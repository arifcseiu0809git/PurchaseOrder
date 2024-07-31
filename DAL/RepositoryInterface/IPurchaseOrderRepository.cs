using DAL.DTO;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.RepositoryInterface
{
    public interface IPurchaseOrderRepository
    {
        (List<PurchaseOrderView>, int) GetPagedPurchaseOrders(int pageNumber, int pageSize);
        int InsertPurchaseOrder(SqlConnection connection, SqlTransaction transaction, Order order);
        void InsertPurchaseOrderDetail(SqlConnection connection, SqlTransaction transaction, PurchaseOrderDetail detail);
        List<Order> GetPurchaseOrders();
        List<PurchaseOrderView> GetPurchaseOrderById(int purchaseOrderId);
        void UpdatePurchaseOrder(SqlConnection connection, SqlTransaction transaction, Order order);
        void DeletePurchaseOrder(int purchaseOrderId);
        List<Supplier> GetSuppliers();
        Supplier GetSupplierById(int supplierId);
        List<Item> GetItems();
        Item GetItemById(int itemId);
        List<Item> SearchItemByName(string itemName);
        string GetGenerateNextSerial();
    }

}
