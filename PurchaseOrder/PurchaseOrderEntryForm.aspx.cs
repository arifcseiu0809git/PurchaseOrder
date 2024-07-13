using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLL.Service;
using BLL.ServiceInterface;
using DAL.DTO;
using DAL.Repository;

namespace PurchaseOrder
{
    public partial class PurchaseOrderEntryForm : System.Web.UI.Page
    {
        private readonly PurchaseOrderService _purchaseOrderService;
        //private readonly PurchaseOrderBLL _purchaseOrderBLL;
        public PurchaseOrderEntryForm()
        {
            _purchaseOrderService = new PurchaseOrderService(new PurchaseOrderRepository(ConfigurationManager.ConnectionStrings["DBConnection"].ConnectionString));
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Code to initialize the form, e.g., load data
                var orders = _purchaseOrderService.GetAllPurchaseOrders();
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            // Code to save the form data to the database
        }
    }
}