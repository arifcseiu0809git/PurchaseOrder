using BLL.Service;
using BLL.ServiceInterface;
using DAL.Repository;
using DAL.RepositoryInterface;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Extensions.DependencyInjection;
using System.IO;
using iTextSharp.text;
using iTextSharp.text.pdf;
using DAL.DTO;

namespace PurchaseOrder
{
    public partial class PurchaseOrderList : System.Web.UI.Page
    {
        private readonly IPurchaseOrderService _purchaseOrderService;
        public PurchaseOrderList()
        {
            _purchaseOrderService = DependencyInjectionConfig.ServiceProvider.GetService<IPurchaseOrderService>();
        }
        private int GetTotalPages(int pageSize)
        {
            var lstOrder = _purchaseOrderService.GetAllPurchaseOrders();
            int totalRecords = lstOrder.Count;
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

        protected void OnItemCommand(object sender, ListViewCommandEventArgs e)
        {
            string commandName = e.CommandName;
            int OrderID = Convert.ToInt32(e.CommandArgument);
            if (commandName == "Export")
            {
                GeneratePdfReport(OrderID);
            }
        }
        private void GeneratePdfReport(int OrderID)
        {
            using (MemoryStream stream = new MemoryStream())
            {
                Document document = new Document();
                PdfWriter writer = PdfWriter.GetInstance(document, stream);
                document.Open();

                // Add Title
                Paragraph title = new Paragraph("Dependable Solutions Inc.", new Font(Font.FontFamily.HELVETICA, 18, Font.BOLD));
                title.Alignment = Element.ALIGN_CENTER;
                document.Add(title);

                Paragraph subtitle = new Paragraph("Purchase Order Report", new Font(Font.FontFamily.HELVETICA, 15, Font.BOLD));
                subtitle.Alignment = Element.ALIGN_CENTER;
                document.Add(subtitle);

                List<PurchaseOrderView> lstOrders = new List<PurchaseOrderView>();
                lstOrders = _purchaseOrderService.GetPurchaseOrderById(OrderID);

                if (lstOrders == null || lstOrders.Count == 0)
                    return;

                document.Add(new Paragraph($"Ref ID: {lstOrders[0].RefID}"));
                document.Add(new Paragraph($"PO NO: {lstOrders[0].PONumber}"));
                document.Add(new Paragraph($"Current Date: {lstOrders[0].CurrentDate:MMM dd, yyyy}"));
                document.Add(new Paragraph($"Expected Date: {lstOrders[0].ExpectedDate:MMM dd, yyyy}"));
                document.Add(new Paragraph($"Supplier: {lstOrders[0].SupplierName}"));
                document.Add(new Paragraph($"Remarks: {lstOrders[0].Remark}"));
                document.Add(new Paragraph($"."));

                // Add Table
                PdfPTable table = new PdfPTable(4);
                table.WidthPercentage = 100;

                table.AddCell("Item");
                table.AddCell("Quantity");
                table.AddCell("Rate ($)");
                table.AddCell("Cost ($)");

                decimal totalSum = 0;
                foreach (var item in lstOrders)
                {
                    table.AddCell(item.ItemName);
                    table.AddCell(item.Quantity.ToString());
                    table.AddCell(item.Rate.ToString("F2"));
                    table.AddCell((item.Quantity * item.Rate).ToString("F2"));
                    totalSum = Convert.ToDecimal(item.Quantity * item.Rate);
                }

                document.Add(table);
                document.Add(new Paragraph($"Total Cost: {totalSum:F2}"));

                document.Close();
                writer.Close();

                Response.ContentType = "application/pdf";
                Response.AddHeader("content-disposition", "attachment;filename=PurchaseOrderReport.pdf");
                Response.Cache.SetCacheability(HttpCacheability.NoCache);
                Response.BinaryWrite(stream.ToArray());
                Response.End();
            }
        }
    }
}