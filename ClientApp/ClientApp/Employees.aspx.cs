using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ClientApp
{
    public partial class About : Page
    {
        #region Page Lifecycle Methods

        protected void Page_Load(object sender, EventArgs e)
        {
            // Check if it's the first time the page is being loaded
            if (!IsPostBack)
            {
                BindGridView();
            }
        }
        #endregion

        #region GridView Event Handlers 

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int employeeID = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value);
            sqlDataSource1.DeleteParameters["EmployeeID"].DefaultValue = employeeID.ToString();
            sqlDataSource1.Delete();
            BindGridView();
        }
        #endregion

        #region Buttons event Handlers
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            // Trigger an error deliberately
            //throw new Exception("a bad exception for testing!");

            GridView1.DataBind();
        }

        protected void SortButton_Click(object sender, EventArgs e)
        {
            string expression = SortList1.SelectedValue;
            SortDirection direction;

            switch (DirectionList1.SelectedValue)
            {
                case "Ascending":
                    direction = SortDirection.Ascending;
                    break;
                case "Descending":
                    direction = SortDirection.Descending;
                    break;
                default:
                    direction = SortDirection.Ascending;
                    break;
            }

            GridView1.Sort(expression, direction);
        }

        protected void btnAddEmployee_Click(object sender, EventArgs e)
        {
            Response.Redirect("EmployeeForm.aspx");

        }
        #endregion

        #region Helpers
        private void BindGridView()
        {
            GridView1.DataBind();
        }

        #endregion

        #region Backup and for debugging purposes
        /// <summary>
        /// For debugging the select statements...
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void sqlDataSource1_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            
            //string query = e.Command.CommandText;
            //foreach (SqlParameter param in e.Command.Parameters)
            //{
            //    query = query.Replace(param.ParameterName, param.Value.ToString());
            //}
            //System.Diagnostics.Debug.WriteLine("Executing query: " + query);
        }

        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;
            BindGridView();
        }

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            // Ensure the page is valid before proceeding
            if (!Page.IsValid)
            {
                return;
            }

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

        #endregion
    }
}