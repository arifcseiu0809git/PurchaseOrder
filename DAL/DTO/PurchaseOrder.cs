using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.DTO
{
    public class Order
    {
        public int PurchaseOrderID { get; set; }
        public string RefID { get; set; }
        public string PONumber { get; set; }
        public DateTime PODate { get; set; }
        public int SupplierID { get; set; }
        public DateTime ExpectedDate { get; set; }
        public string Remark { get; set; }
        public List<PurchaseOrderDetail> Details { get; set; }
    }

    public class PurchaseOrderDetail
    {
        public int PurchaseOrderDetailID { get; set; }
        public int PurchaseOrderID { get; set; }
        public int ItemID { get; set; }
        public int ItemName { get; set; }
        public int Quantity { get; set; }
        public decimal Rate { get; set; }
    }

    public class Supplier
    {
        public int SupplierID { get; set; }
        public string SupplierName { get; set; }
        public string ContactInfo { get; set; }
    }

    public class PurchaseOrderView
    {
        public int PurchaseOrderID { get; set; }
        public string RefID { get; set; }
        public string PONumber { get; set; }
        public DateTime PODate { get; set; }
        public int SupplierID { get; set; }
        public string SupplierName { get; set; }
        public DateTime ExpectedDate { get; set; }
        public DateTime CurrentDate { get; set; }        
        public string Remark { get; set; }
        public int ItemID { get; set; }
        public string ItemName { get; set; }
        public int Quantity { get; set; }
        public decimal Rate { get; set; }
    }

    public class Item
    {
        public int ItemID { get; set; }
        public string ItemName { get; set; }
        public string Description { get; set; }
    }
}
