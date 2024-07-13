using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PurchaseOrder
{
    public partial class Entry : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnSaveAll_Click(object sender, EventArgs e)
        {
            string itemNames = Request.Form["itemNames"];
            string quantities = Request.Form["quantities"];
            string rates = Request.Form["rates"];

            string[] items = itemNames.Split(',');
            string[] qtys = quantities.Split(',');
            string[] ratesArray = rates.Split(',');

            //string connectionString = ConfigurationManager.ConnectionStrings["YourConnectionString"].ConnectionString;
            //using (SqlConnection con = new SqlConnection(connectionString))
            //{
            //    con.Open();
            //    for (int i = 0; i < items.Length; i++)
            //    {
            //        using (SqlCommand cmd = new SqlCommand("INSERT INTO Items (ItemName, Qty, Rate, Total) VALUES (@ItemName, @Qty, @Rate, @Total)", con))
            //        {
            //            cmd.Parameters.AddWithValue("@ItemName", items[i]);
            //            cmd.Parameters.AddWithValue("@Qty", qtys[i]);
            //            cmd.Parameters.AddWithValue("@Rate", ratesArray[i]);
            //            cmd.Parameters.AddWithValue("@Total", Convert.ToDecimal(qtys[i]) * Convert.ToDecimal(ratesArray[i]));
            //            cmd.ExecuteNonQuery();
            //        }
            //    }
            //}

            //Response.Redirect("Default.aspx");
        }


        [WebMethod(EnableSession = false)]
        public static List<Item> SearchItems(string searchText)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DBConnection"].ConnectionString;
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