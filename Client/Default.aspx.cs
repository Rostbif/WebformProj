using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Client
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //var connectionString = ConfigurationManager.ConnectionStrings["datWise"].ConnectionString;
            //DataTable employees = new DataTable();

            //using (SqlConnection connection = new SqlConnection(connectionString))
            //{
            //    connection.Open();
            //    string query = "SELECT * FROM Employees"; // Adjust the query as needed
            //    using (SqlCommand command = new SqlCommand(query, connection))
            //    {
            //        using (SqlDataAdapter adapter = new SqlDataAdapter(command))
            //        {
            //            adapter.Fill(employees);
            //        }
            //    }
            //}

            //var x = employees;

        }
    }
}