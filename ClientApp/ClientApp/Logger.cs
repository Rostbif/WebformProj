using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace ClientApp
{
    public static class Logger
    {
        public static void LogExceptionToDatabase(Exception exception)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["Datwise"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "INSERT INTO ErrorLog (ErrorDate, Message, StackTrace, Source, TargetSite) VALUES (@ErrorDate, @Message, @StackTrace, @Source, @TargetSite)";
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@ErrorDate", DateTime.Now);
                    command.Parameters.AddWithValue("@Message", exception.Message);
                    command.Parameters.AddWithValue("@StackTrace", exception.StackTrace);
                    command.Parameters.AddWithValue("@Source", exception.Source ?? (object)DBNull.Value);
                    command.Parameters.AddWithValue("@TargetSite", exception.TargetSite?.ToString() ?? (object)DBNull.Value);

                    connection.Open();
                    command.ExecuteNonQuery();
                }
            }
        }
    }
}