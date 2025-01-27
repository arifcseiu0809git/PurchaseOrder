﻿using DAL.DTO;
using DAL.RepositoryInterface;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Configuration;

namespace DAL.Repository
{
    public class PurchaseOrderRepository : IPurchaseOrderRepository
    {
        private readonly string _connectionString;
        public PurchaseOrderRepository(string connectionString)
        {
            _connectionString = connectionString;
        }
        public (List<PurchaseOrderView>, int) GetPagedPurchaseOrders(int pageNumber, int pageSize)
        {
            List<PurchaseOrderView> orders = new List<PurchaseOrderView>();
            int totalRecords = 0;

            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                SqlCommand command = new SqlCommand("GetPurchaseOrdersPaginated", connection)
                {
                    CommandType = CommandType.StoredProcedure
                };
                command.Parameters.AddWithValue("@PageNumber", pageNumber);
                command.Parameters.AddWithValue("@PageSize", pageSize);

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    PurchaseOrderView order = new PurchaseOrderView
                    {
                        PurchaseOrderID = reader.GetInt32(0),
                        RefID = reader.GetString(1),
                        PONumber = reader.GetString(2),
                        PODate = reader.GetDateTime(3),
                        SupplierID = reader.GetInt32(4),
                        SupplierName = reader.GetString(5),
                        ExpectedDate = reader.GetDateTime(6)
                    };
                    orders.Add(order);
                }

                if (reader.NextResult() && reader.Read())
                {
                    totalRecords = reader.GetInt32(0);
                }
            }

            return (orders, totalRecords);
        }
        public int InsertPurchaseOrder(SqlConnection connection, SqlTransaction transaction, Order order)
        {
            using (SqlCommand cmd = new SqlCommand("InsertPurchaseOrder", connection, transaction))
            {
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@RefID", order.RefID);
                cmd.Parameters.AddWithValue("@PONumber", order.PONumber);
                cmd.Parameters.AddWithValue("@PODate", order.PODate);
                cmd.Parameters.AddWithValue("@SupplierID", order.SupplierID);
                cmd.Parameters.AddWithValue("@ExpectedDate", order.ExpectedDate);
                cmd.Parameters.AddWithValue("@Remark", order.Remark);

                return Convert.ToInt32(cmd.ExecuteScalar());
            }
        }
        public void InsertPurchaseOrderDetail(SqlConnection connection, SqlTransaction transaction, PurchaseOrderDetail detail)
        {
            using (SqlCommand cmd = new SqlCommand("InsertPurchaseOrderDetail", connection, transaction))
            {
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@PurchaseOrderID", detail.PurchaseOrderID);
                cmd.Parameters.AddWithValue("@ItemID", detail.ItemID);
                cmd.Parameters.AddWithValue("@Quantity", detail.Quantity);
                cmd.Parameters.AddWithValue("@Rate", detail.Rate);

                cmd.ExecuteNonQuery();
            }
        }
        public List<Order> GetPurchaseOrders()
        {
            List<Order> orders = new List<Order>();
            using (SqlConnection conn = new SqlConnection(_connectionString))
            {
                SqlCommand cmd = new SqlCommand("GetPurchaseOrders", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    orders.Add(new Order
                    {
                        PurchaseOrderID = Convert.ToInt32(reader["PurchaseOrderID"]),
                        RefID = reader["RefID"].ToString(),
                        PONumber = reader["PONumber"].ToString(),
                        PODate = Convert.ToDateTime(reader["PODate"]),
                        SupplierID = Convert.ToInt32(reader["SupplierID"]),
                        ExpectedDate = Convert.ToDateTime(reader["ExpectedDate"]),
                        Remark = reader["Remark"].ToString()
                    });
                }
            }
            return orders;
        }
        public List<PurchaseOrderView> GetPurchaseOrderById(int purchaseOrderId)
        {
            List<PurchaseOrderView> orders = new List<PurchaseOrderView>();
            using (SqlConnection conn = new SqlConnection(_connectionString))
            {
                SqlCommand cmd = new SqlCommand("GetPurchaseOrderById", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@PurchaseOrderID", purchaseOrderId);
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    orders.Add(new PurchaseOrderView
                    {
                        PurchaseOrderID = Convert.ToInt32(reader["PurchaseOrderID"]),
                        RefID = reader["RefID"].ToString(),
                        PONumber = reader["PONumber"].ToString(),
                        PODate = Convert.ToDateTime(reader["PODate"]),
                        SupplierID = Convert.ToInt32(reader["SupplierID"]),
                        SupplierName = reader["SupplierName"].ToString(),
                        ExpectedDate = Convert.ToDateTime(reader["ExpectedDate"]),
                        Remark = reader["Remark"].ToString(),
                        ItemID = Convert.ToInt32(reader["ItemID"]),
                        ItemName = reader["ItemName"].ToString(),
                        Quantity = Convert.ToInt32(reader["Quantity"]),
                        Rate = Convert.ToDecimal(reader["Rate"])
                    });
                }
            }
            return orders;
        }
        public void UpdatePurchaseOrder(SqlConnection connection, SqlTransaction transaction, Order order)
        {
            using (SqlCommand cmd = new SqlCommand("UpdatePurchaseOrder", connection, transaction))
            {
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@PurchaseOrderID", order.PurchaseOrderID);
                cmd.Parameters.AddWithValue("@RefID", order.RefID);
                cmd.Parameters.AddWithValue("@PONumber", order.PONumber);
                cmd.Parameters.AddWithValue("@PODate", order.PODate);
                cmd.Parameters.AddWithValue("@SupplierID", order.SupplierID);
                cmd.Parameters.AddWithValue("@ExpectedDate", order.ExpectedDate);
                cmd.Parameters.AddWithValue("@Remark", order.Remark);

                cmd.ExecuteNonQuery();
            }
        }
        public void DeletePurchaseOrder(int purchaseOrderId)
        {
            using (SqlConnection conn = new SqlConnection(_connectionString))
            {
                SqlCommand cmd = new SqlCommand("DeletePurchaseOrder", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@PurchaseOrderID", purchaseOrderId);
                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }
        public List<Supplier> GetSuppliers()
        {
            List<Supplier> suppliers = new List<Supplier>();
            using (SqlConnection conn = new SqlConnection(_connectionString))
            {
                SqlCommand cmd = new SqlCommand("GetSuppliers", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    suppliers.Add(new Supplier
                    {
                        SupplierID = Convert.ToInt32(reader["SupplierID"]),
                        SupplierName = reader["SupplierName"].ToString(),
                        ContactInfo = reader["ContactInfo"].ToString()
                    });
                }
            }
            return suppliers;
        }
        public Supplier GetSupplierById(int supplierId)
        {
            Supplier supplier = null;
            using (SqlConnection conn = new SqlConnection(_connectionString))
            {
                SqlCommand cmd = new SqlCommand("GetSupplierById", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@SupplierID", supplierId);
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    supplier = new Supplier
                    {
                        SupplierID = Convert.ToInt32(reader["SupplierID"]),
                        SupplierName = reader["SupplierName"].ToString(),
                        ContactInfo = reader["ContactInfo"].ToString(),
                    };
                }
            }
            return supplier;
        }
        public List<Item> GetItems()
        {
            List<Item> items = new List<Item>();
            using (SqlConnection conn = new SqlConnection(_connectionString))
            {
                SqlCommand cmd = new SqlCommand("GetItems", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    items.Add(new Item
                    {
                        ItemID = Convert.ToInt32(reader["ItemID"]),
                        ItemName = reader["ItemName"].ToString(),
                        Description = reader["Description"].ToString(),
                    });
                }
            }
            return items;
        }
        public Item GetItemById(int itemId)
        {
            Item item = null;
            using (SqlConnection conn = new SqlConnection(_connectionString))
            {
                SqlCommand cmd = new SqlCommand("GetItemById", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@ItemID", itemId);
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    item = new Item
                    {
                        ItemID = Convert.ToInt32(reader["ItemID"]),
                        ItemName = reader["ItemName"].ToString(),
                        Description = reader["Description"].ToString(),
                    };
                }
            }
            return item;
        }
        public List<Item> SearchItemByName(string itemName)
        {
            List<Item> items = new List<Item>();
            using (SqlConnection conn = new SqlConnection(_connectionString))
            {
                SqlCommand cmd = new SqlCommand("SearchItems", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@SearchTerm", itemName);
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    items.Add(new Item
                    {
                        ItemName = reader["ItemName"].ToString(),
                    });
                }
            }
            return items;
        }
        public string GetGenerateNextSerial()
        {
             string nextSerialNumber = "";
            using (SqlConnection conn = new SqlConnection(_connectionString))
            {
                SqlCommand cmd = new SqlCommand("GenerateNextSerialNumber", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    nextSerialNumber = reader["NextSerialNumber"].ToString();
                }
            }
            return nextSerialNumber;
        }
    }
}
