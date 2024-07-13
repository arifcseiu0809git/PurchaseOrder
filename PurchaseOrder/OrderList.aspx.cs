using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLL.ServiceInterface;
using BLL.Service;
using DAL.Repository;
using System.Configuration;

namespace PurchaseOrder
{
    public partial class OrderList : System.Web.UI.Page
    {
        private readonly PurchaseOrderService _purchaseOrderService;
        public OrderList()
        {
            _purchaseOrderService = new PurchaseOrderService(new PurchaseOrderRepository(ConfigurationManager.ConnectionStrings["DBConnection"].ConnectionString));
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindPurchaseOrders();
            }
        }

        protected void gvPurchaseOrders_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvPurchaseOrders.PageIndex = e.NewPageIndex;
            BindPurchaseOrders();
        }

        protected void btnPrevious_Click(object sender, EventArgs e)
        {
            if (gvPurchaseOrders.PageIndex > 0)
            {
                gvPurchaseOrders.PageIndex--;                
            }
            BindPurchaseOrders();
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            gvPurchaseOrders.PageIndex++;
            BindPurchaseOrders();
        }

        private void BindPurchaseOrders()
        {
            int pageIndex = gvPurchaseOrders.PageIndex + 1;
            int pageSize = gvPurchaseOrders.PageSize;

            var result = _purchaseOrderService.GetPagedPurchaseOrders(pageIndex, pageSize);
            gvPurchaseOrders.DataSource = result.Item1;
            //gvPurchaseOrders.DataSource = _purchaseOrderService.GetPagedPurchaseOrders(pageIndex, pageSize); //GetPurchaseOrders(pageIndex, pageSize);
            gvPurchaseOrders.DataBind();

            // Update page info
            //lblPageInfo.Text = $"Page {pageIndex} of {GetTotalPages(pageSize)}";
            lblPageInfo.Text = $"Page {pageIndex} of {GetTotalPages(pageSize, result.Item2 )}";

            // Disable previous button if on the first page
            btnPrevious.Enabled = pageIndex > 1;
            // Disable next button if on the last page
            //btnNext.Enabled = pageIndex < GetTotalPages(pageSize);
            btnNext.Enabled = pageIndex < GetTotalPages(pageSize, result.Item2);
        }

        private int GetTotalPages(int pageSize, int totalRecords)
        {
            //string connString = ConfigurationManager.ConnectionStrings["DBConnection"].ConnectionString;
            //int totalRecords = 0;

            //using (SqlConnection conn = new SqlConnection(connString))
            //{
            //    using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM PurchaseOrder", conn))
            //    {
            //        conn.Open();
            //        totalRecords = (int)cmd.ExecuteScalar();
            //    }
            //}
            return (int)Math.Ceiling((double)totalRecords / pageSize);
        }
    }
}