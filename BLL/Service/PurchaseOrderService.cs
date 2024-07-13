using BLL.ServiceInterface;
using DAL.DTO;
using DAL.Repository;
using DAL.RepositoryInterface;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL.Service
{
    public class PurchaseOrderService : IPurchaseOrderService
    {
        private readonly IPurchaseOrderRepository _orderRepository;
        public PurchaseOrderService(IPurchaseOrderRepository repository)
        {
            _orderRepository = repository;
        }

        public (List<PurchaseOrderView>, int) GetPagedPurchaseOrders(int pageNumber, int pageSize)
        {
            return _orderRepository.GetPagedPurchaseOrders(pageNumber, pageSize);
        }
        public int CreatePurchaseOrder(Order order, List<PurchaseOrderDetail> details)
        {
            int purchaseOrderId = _orderRepository.InsertPurchaseOrder(order);
            foreach (var detail in details)
            {
                detail.PurchaseOrderID = purchaseOrderId;
                _orderRepository.InsertPurchaseOrderDetail(detail);
            }
            return purchaseOrderId;
        }

        public List<Order> GetAllPurchaseOrders()
        {
            return _orderRepository.GetPurchaseOrders();
        }

        public List<PurchaseOrderView> GetPurchaseOrderById(int purchaseOrderId)
        {
            return _orderRepository.GetPurchaseOrderById(purchaseOrderId);
        }

        public void UpdatePurchaseOrder(Order order, List<PurchaseOrderDetail> details)
        {
            _orderRepository.UpdatePurchaseOrder(order);
            foreach (var detail in details)
            {
                _orderRepository.InsertPurchaseOrderDetail(detail); // Assumes all details are new and should be inserted
            }
        }

        public void DeletePurchaseOrder(int purchaseOrderId)
        {
            _orderRepository.DeletePurchaseOrder(purchaseOrderId);
        }

        public List<Supplier> GetSuppliers()
        {
            return _orderRepository.GetSuppliers();
        }

        public Supplier GetSupplierById(int supplierId)
        {
            return _orderRepository.GetSupplierById(supplierId);
        }

        public List<Item> GetItems()
        {
            return _orderRepository.GetItems();
        }

        public Item GetItemById(int itemId)
        {
            return _orderRepository.GetItemById(itemId);
        }

        public List<Item> GetItemByName(string itemName)
        {
            return _orderRepository.SearchItemByName(itemName);
        }

        public string GetGenerateNextSerial()
        {
            return _orderRepository.GetGenerateNextSerial();
        }
    }

}
