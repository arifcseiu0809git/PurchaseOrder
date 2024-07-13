using DAL.DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL.ServiceInterface
{
    public interface IPurchaseOrderService
    {
        (List<PurchaseOrderView>, int) GetPagedPurchaseOrders(int pageNumber, int pageSize);
        int CreatePurchaseOrder(Order order, List<PurchaseOrderDetail> details);
        List<Order> GetAllPurchaseOrders();
        List<PurchaseOrderView> GetPurchaseOrderById(int purchaseOrderId);
        void UpdatePurchaseOrder(Order order, List<PurchaseOrderDetail> details);
        void DeletePurchaseOrder(int purchaseOrderId);
        List<Supplier> GetSuppliers();
        Supplier GetSupplierById(int supplierId);
        List<Item> GetItems();
        Item GetItemById(int itemId);
        List<Item> GetItemByName(string itemName);
        string GetGenerateNextSerial();
    }

}
