using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Client
{
    public partial class About : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Check if it's the first time the page is being loaded
            if (!IsPostBack)
            {
                BindGridView();
            }
        }

        private void BindGridView()
        {
            GridView1.DataBind();
            //var connectionString = ConfigurationManager.ConnectionStrings["datWise"].ConnectionString;
        }

        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;
            BindGridView();
        }

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            // Retrieve the values from the GridView
            int employeeID = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value);
            var x = GridView1.Rows[e.RowIndex];
            string firstname = ((TextBox)GridView1.Rows[e.RowIndex].FindControl("txtFirstname")).Text;
            string lastname = ((TextBox)GridView1.Rows[e.RowIndex].FindControl("txtLastname")).Text;
            string email = ((TextBox)GridView1.Rows[e.RowIndex].FindControl("txtEmail")).Text;
            string phone = ((TextBox)GridView1.Rows[e.RowIndex].FindControl("txtPhone")).Text;
            DateTime hireDate = Convert.ToDateTime(((TextBox)GridView1.Rows[e.RowIndex].FindControl("txtHireDate")).Text);


            // Update the employee to the database
            sqlDataSource1.UpdateParameters["EmployeeID"].DefaultValue = employeeID.ToString();
            sqlDataSource1.UpdateParameters["Firstname"].DefaultValue = firstname;
            sqlDataSource1.UpdateParameters["Lastname"].DefaultValue = lastname;
            sqlDataSource1.UpdateParameters["Email"].DefaultValue = email;
            sqlDataSource1.UpdateParameters["Phone"].DefaultValue = phone;
            sqlDataSource1.UpdateParameters["HireDate"].DefaultValue = hireDate.ToString("yyyy-MM-dd");

            sqlDataSource1.Update();

            GridView1.EditIndex = -1;
            BindGridView();
        }

        protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView1.EditIndex = -1;
            BindGridView();
        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int employeeID = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value);
            sqlDataSource1.DeleteParameters["EmployeeID"].DefaultValue = employeeID.ToString();
            sqlDataSource1.Delete();
            BindGridView();
        }
            
    }
}