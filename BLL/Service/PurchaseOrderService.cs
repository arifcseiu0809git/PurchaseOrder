using BLL.ServiceInterface;
using DAL.DTO;
using DAL.Repository;
using DAL.RepositoryInterface;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL.Service
{
    public class PurchaseOrderService : IPurchaseOrderService
    {
        private readonly IPurchaseOrderRepository _orderRepository;
        private readonly string _connectionString;
        public PurchaseOrderService(IPurchaseOrderRepository repository, string connectionString)
        {
            _orderRepository = repository;
            _connectionString = connectionString;
        }
        public (List<PurchaseOrderView>, int) GetPagedPurchaseOrders(int pageNumber, int pageSize)
        {
            return _orderRepository.GetPagedPurchaseOrders(pageNumber, pageSize);
        }
        public int CreatePurchaseOrder(Order order, List<PurchaseOrderDetail> details)
        {
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                int purchaseOrderId = 0;
                connection.Open();
                SqlTransaction transaction = connection.BeginTransaction();

                try
                {
                    purchaseOrderId = _orderRepository.InsertPurchaseOrder(connection, transaction, order);
                    foreach (var detail in details)
                    {
                        detail.PurchaseOrderID = purchaseOrderId;
                        _orderRepository.InsertPurchaseOrderDetail(connection, transaction, detail);
                    }                    
                    transaction.Commit();
                }
                catch (Exception ex)
                {
                    // Roll back the transaction if any operation fails
                    transaction.Rollback();

                    // Handle the exception (e.g., log it)
                    Console.WriteLine("Exception: " + ex.Message);
                }
                return purchaseOrderId;
            }
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
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                connection.Open();
                SqlTransaction transaction = connection.BeginTransaction();

                try
                {
                    _orderRepository.UpdatePurchaseOrder(connection, transaction, order);
                    foreach (var detail in details)
                    {
                        _orderRepository.InsertPurchaseOrderDetail(connection, transaction, detail);
                    }
                    transaction.Commit();
                }
                catch (Exception ex)
                {
                    // Roll back the transaction if any operation fails
                    transaction.Rollback();

                    // Handle the exception (e.g., log it)
                    Console.WriteLine("Exception: " + ex.Message);
                }
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
