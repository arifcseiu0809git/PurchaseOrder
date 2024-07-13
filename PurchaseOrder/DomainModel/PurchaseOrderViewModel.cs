using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PurchaseOrder.DomainModel
{
    public class PurchaseOrderViewModel
    {
        public string RefID { get; set; }
        public string PONumber { get; set; }
        public DateTime PODate { get; set; }
        public int SupplierID { get; set; }
        public DateTime ExpectedDate { get; set; }
        public string Remark { get; set; }
        public List<PurchaseOrderDetailViewModel> Details { get; set; }
    }

    public class PurchaseOrderDetailViewModel
    {
        public int ItemID { get; set; }
        public int Quantity { get; set; }
        public decimal Rate { get; set; }
    }
}