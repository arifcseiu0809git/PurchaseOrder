using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Services;
using System.Web.Services.Description;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using BLL.Service;
using BLL.ServiceInterface;
using DAL.DTO;
using DAL.Repository;
using DAL.RepositoryInterface;
using iTextSharp.text;
using iTextSharp.text.pdf;
using Microsoft.Extensions.DependencyInjection;

namespace PurchaseOrder
{
    public partial class PurchaseOrderEntry : System.Web.UI.Page
    {
        private readonly IPurchaseOrderService _purchaseOrderService;
        public PurchaseOrderEntry()
        {
            _purchaseOrderService = DependencyInjectionConfig.ServiceProvider.GetService<IPurchaseOrderService>();
        }
        protected string EditMode
        {
            get
            {
                return ViewState["EditMode"].ToString();
            }
            set
            {
                ViewState["EditMode"] = value;
            }
        }
        protected int OrderID
        {
            get
            {
                return (int)ViewState["OrderID"];
            }
            set
            {
                ViewState["OrderID"] = value;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                EditMode = "add";

                if (!string.IsNullOrEmpty(Request["mode"]))
                {
                    EditMode = Request["mode"];
                }
                if (!string.IsNullOrEmpty(Request["id"]))
                {
                    OrderID = int.Parse(Request["id"].Trim());
                }

                if (EditMode == "delete")
                {
                    btnDelete.Visible = true;
                    btnSave.Visible = false;
                }
                else if (EditMode == "edit" || EditMode == "add")
                {
                    btnDelete.Visible = false;
                    btnSave.Text = "Save";
                }
                PopulateData();
            }
        }
        private void PopulateData()
        {
            PopulateSupplier();

            if (EditMode == "add")
            {
                string nextSerialNumber = _purchaseOrderService.GetGenerateNextSerial();
                txtRefIDs.Text = nextSerialNumber;

                txtPODate.Text = System.DateTime.Now.ToString("yyyy-MM-dd");
            }
            else if ((EditMode == "edit" || EditMode == "delete") && OrderID > 0)
            {
                List<PurchaseOrderView> lstOrders = new List<PurchaseOrderView>();
                lstOrders = _purchaseOrderService.GetPurchaseOrderById(OrderID);

                if (lstOrders == null || lstOrders.Count == 0)
                    return;

                txtRefIDs.Text = lstOrders[0].RefID;
                txtPONO.Text = lstOrders[0].PONumber.ToString();
                txtPODate.Text = lstOrders[0].PODate.ToString("yyyy-MM-dd");
                txtExpectedDate.Text = lstOrders[0].ExpectedDate.ToString("yyyy-MM-dd");
                txtRemarks.Text = lstOrders[0].Remark.ToString();
                ddlSupplier.SelectedValue = lstOrders[0].SupplierID.ToString();

                foreach (var item in lstOrders)
                {
                    HtmlTableRow row = new HtmlTableRow();

                    HtmlTableCell cell1 = new HtmlTableCell { InnerText = item.ItemName.ToString() };
                    HtmlTableCell cell2 = new HtmlTableCell { InnerText = item.Quantity.ToString() };
                    HtmlTableCell cell3 = new HtmlTableCell { InnerText = item.Rate.ToString() };

                    // Edit button
                    HtmlTableCell cellEdit = new HtmlTableCell();
                    HtmlButton editButton = new HtmlButton
                    {
                        InnerText = "Edit"
                    };
                    editButton.Attributes.Add("onclick", "editItem(this)");
                    cellEdit.Controls.Add(editButton);


                    // Delete button
                    HtmlTableCell cellDelete = new HtmlTableCell();
                    HtmlButton deleteButton = new HtmlButton
                    {
                        InnerText = "Delete",
                    };
                    deleteButton.Attributes.Add("onclick", $"deleteItem(this)");
                    cellDelete.Controls.Add(deleteButton);

                    row.Cells.Add(cell1);
                    row.Cells.Add(cell2);
                    row.Cells.Add(cell3);
                    row.Cells.Add(cellEdit);
                    row.Cells.Add(cellDelete);

                    itemsTable.Rows.Add(row);
                }
            }
        }
        private void PopulateSupplier()
        {
            try
            {
                ddlSupplier.DataSource = _purchaseOrderService.GetSuppliers();
                ddlSupplier.DataTextField = "SupplierName";
                ddlSupplier.DataValueField = "SupplierID";
                ddlSupplier.DataBind();
            }
            catch (Exception ex)
            {
            }
        }
        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                string itemNames = Request.Form["itemNames"];
                string quantities = Request.Form["quantities"];
                string rates = Request.Form["rates"];

                string[] items = itemNames.Split(',');
                List<string> itemList = new List<string>(items);
                itemList.RemoveAt(0);
                items = itemList.ToArray();

                string[] qtys = quantities.Split(',');
                List<string> itemList2 = new List<string>(qtys);
                itemList2.RemoveAt(0);
                qtys = itemList2.ToArray();

                string[] ratesArray = rates.Split(',');
                List<string> itemList3 = new List<string>(ratesArray);
                itemList3.RemoveAt(0);
                ratesArray = itemList3.ToArray();

                List<PurchaseOrderDetail> lstDetail = new List<PurchaseOrderDetail>();
                PurchaseOrderDetail detail;

                List<Item> lstItems = new List<Item>();
                lstItems = _purchaseOrderService.GetItems();

                Order order = new Order
                {
                    RefID = txtRefIDs.Text.Trim(),
                    PONumber = txtPONO.Text.Trim(),
                    PODate = Convert.ToDateTime(txtPODate.Text.Trim()),
                    SupplierID = Convert.ToInt32(ddlSupplier.SelectedValue),
                    ExpectedDate = Convert.ToDateTime(txtExpectedDate.Text.Trim()),
                    Remark = txtRemarks.Text.Trim()
                };

                for (int i = 0; i < items.Length; i++)
                {
                    detail = new PurchaseOrderDetail();
                    string itemName = items[i];
                    var firstOrDefaultItem = lstItems.FirstOrDefault(item => item.ItemName == itemName);
                    if (EditMode == "edit")
                    {
                        detail.PurchaseOrderID = OrderID;
                    }
                    detail.ItemID = firstOrDefaultItem.ItemID;
                    detail.Quantity = Convert.ToInt32(qtys[i]);
                    detail.Rate = Convert.ToDecimal(ratesArray[i]);

                    lstDetail.Add(detail);
                }


                if (EditMode == "edit" && OrderID > 0)
                {
                    order.PurchaseOrderID = OrderID;
                    _purchaseOrderService.UpdatePurchaseOrder(order, lstDetail);
                }
                else if (EditMode == "delete" && OrderID > 0)
                {
                    _purchaseOrderService.DeletePurchaseOrder(OrderID);
                }
                else
                {
                    _purchaseOrderService.CreatePurchaseOrder(order, lstDetail);
                }
            }
            catch (Exception ex)
            {

            }

            ScriptManager.RegisterStartupScript(this, this.GetType(), "close", string.Format("parent.location.href='purchaseOrderList.aspx';", 0), true);
        }
        protected void btnClose_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "close", string.Format("parent.location.href='purchaseOrderList.aspx';", 0), true);
        }

        [WebMethod(EnableSession = false)]
        public static List<Item> SearchItems(string searchText)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DBConnection"].ConnectionString;

            List<Item> items = new List<Item>();
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("SearchItems", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@SearchTerm", searchText);
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    items.Add(new Item
                    {
                        ItemName = reader["ItemName"].ToString(),
                    });
                }
            }
            return items;
        }
    }
}