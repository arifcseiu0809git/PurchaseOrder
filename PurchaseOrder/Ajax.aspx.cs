using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PurchaseOrder
{
    public partial class Ajax : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod(EnableSession = false)]
        public static List<Item> SearchItems(string searchText)
        {
            string connectionString = "DBConnection";
            List<Item> items = new List<Item>();

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "select ItemName from Item where ItemName LIKE @searchText";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@searchText", "%" + searchText + "%");
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        Item item = new Item();
                        item.ItemName = reader["ItemName"].ToString();
                        items.Add(item);
                    }
                }
            }

            return items;
        }

        public class Item
        {
            public string ItemName { get; set; }
        }
    }   
}