using BLL.Service;
using DAL.Repository;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PurchaseOrder
{
    public partial class PurchaseOrderList : System.Web.UI.Page
    {
        private readonly PurchaseOrderService _purchaseOrderService;
        public PurchaseOrderList()
        {
            _purchaseOrderService = new PurchaseOrderService(new PurchaseOrderRepository(ConfigurationManager.ConnectionStrings["DBConnection"].ConnectionString));
        }
        //protected void Page_Load(object sender, EventArgs e)
        //{
        //    if (!IsPostBack)
        //    {
        //        BindPurchaseOrders();
        //    }
        //}
        //protected void gvPurchaseOrders_PageIndexChanging(object sender, GridViewPageEventArgs e)
        //{
        //    gvPurchaseOrders.PageIndex = e.NewPageIndex;
        //    BindPurchaseOrders();
        //}
        //protected void btnPrevious_Click(object sender, EventArgs e)
        //{
        //    //if (gvPurchaseOrders.PageIndex > 0)
        //    //{
        //    //    gvPurchaseOrders.PageIndex--;
        //    //}
        //    //BindPurchaseOrders();
        //}
        //protected void btnNext_Click(object sender, EventArgs e)
        //{
        //    //gvPurchaseOrders.PageIndex++;
        //    //BindPurchaseOrders();
        //}
        //private void BindPurchaseOrders()
        //{
        //    int pageIndex = gvPurchaseOrders.PageIndex + 1;
        //    int pageSize = gvPurchaseOrders.PageSize;

        //    var result = _purchaseOrderService.GetPagedPurchaseOrders(pageIndex, pageSize);
        //    gvPurchaseOrders.DataSource = result.Item1;
        //    //gvPurchaseOrders.DataSource = _purchaseOrderService.GetPagedPurchaseOrders(pageIndex, pageSize); //GetPurchaseOrders(pageIndex, pageSize);
        //    gvPurchaseOrders.DataBind();

        //    // Update page info
        //    //lblPageInfo.Text = $"Page {pageIndex} of {GetTotalPages(pageSize)}";
        //    lblPageInfo.Text = $"Page {pageIndex} of {GetTotalPages(pageSize, result.Item2)}";

        //    // Disable previous button if on the first page
        //    btnPrevious.Enabled = pageIndex > 1;
        //    // Disable next button if on the last page
        //    //btnNext.Enabled = pageIndex < GetTotalPages(pageSize);
        //    btnNext.Enabled = pageIndex < GetTotalPages(pageSize, result.Item2);
        //}
        private int GetTotalPages(int pageSize)
        {
            string connString = ConfigurationManager.ConnectionStrings["DBConnection"].ConnectionString;
            int totalRecords = 0;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM PurchaseOrder", conn))
                {
                    conn.Open();
                    totalRecords = (int)cmd.ExecuteScalar();
                }
            }
            rowCount = totalRecords;
            return (int)Math.Ceiling((double)totalRecords / pageSize);
        }
        protected int rowCount
        {
            get
            {
                return (int)ViewState["rowCount"];
            }
            set
            {
                ViewState["rowCount"] = value;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                rowCount = 0;
                btnRefresh_Click(null, null);
            }
        }
        protected void btnRefresh_Click(object sender, EventArgs e)
        {
            BindData();
        }

        private void BindData()
        {
            GetTotalPages(pager.MaximumRows);
            var result = _purchaseOrderService.GetPagedPurchaseOrders((pager.StartRowIndex/pager.MaximumRows) + 1, pager.MaximumRows);

            lblResults.Text = String.Format("Total results: {0}", rowCount);

            if (rowCount <= pager.MaximumRows)
            {
                pager.Visible = false;
            }
            else
            {
                pager.Visible = true;
            }
            pager.SetPageProperties(0, pager.MaximumRows, true);
        }

        protected void LinqDataSource1_Selecting(object sender, LinqDataSourceSelectEventArgs e)
        {
            e.Arguments.RetrieveTotalRowCount = false;

            var result = _purchaseOrderService.GetPagedPurchaseOrders((pager.StartRowIndex / pager.MaximumRows) + 1, pager.MaximumRows);
            e.Arguments.TotalRowCount = rowCount;
            e.Result = result.Item1;
        }
    }
}