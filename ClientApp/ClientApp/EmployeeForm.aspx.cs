using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ClientApp
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && Request.QueryString["id"] != null)
            {
                // If we are on edit mode we want to load the data of the employee
                int employeeId;
                if (int.TryParse(Request.QueryString["id"], out employeeId))
                {
                    LoadEmployee(employeeId);
                }
            }
        }

        /// <summary>
        /// Checking if we are in add or edit mode according to the hidden field employee id, and update the DB
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnSave_Click(object sender, EventArgs e)
        {
            // Ensure the page is valid before proceeding, to make sure user didn't tried to pass validation.
            if (!Page.IsValid)
            {
                return;
            }

            // Insert mode:
            if (string.IsNullOrEmpty(hfEmployeeId.Value))
            {
                SqlDataSource1.InsertParameters["Firstname"].DefaultValue = txtFirstName.Text;
                SqlDataSource1.InsertParameters["LastName"].DefaultValue = txtLastName.Text;
                SqlDataSource1.InsertParameters["Email"].DefaultValue = txtEmail.Text;
                SqlDataSource1.InsertParameters["Phone"].DefaultValue = txtPhone.Text;
                SqlDataSource1.InsertParameters["HireDate"].DefaultValue = txtHireDate.Text;
                SqlDataSource1.Insert();
            }
            // Edit mode
            else
            {
                SqlDataSource1.UpdateParameters["Firstname"].DefaultValue = txtFirstName.Text;
                SqlDataSource1.UpdateParameters["LastName"].DefaultValue = txtLastName.Text;
                SqlDataSource1.UpdateParameters["Email"].DefaultValue = txtEmail.Text;
                SqlDataSource1.UpdateParameters["Phone"].DefaultValue = txtPhone.Text;
                SqlDataSource1.UpdateParameters["HireDate"].DefaultValue = txtHireDate.Text;
                // here we also need the employee id so we can update the right employee entity
                SqlDataSource1.UpdateParameters["EmployeeId"].DefaultValue = hfEmployeeId.Value;
                SqlDataSource1.Update();
            }

            // Redirect back to the employees page
            Response.Redirect("Employees.aspx");
        }

        /// <summary>
        /// Initialize the form with the data of the employee we want to edit
        /// </summary>
        /// <param name="employeeId"></param>
        private void LoadEmployee(int employeeId)
        {
            // trigger the select command of the Sql data source to retrieve the employee data.
            var dataView = (System.Data.DataView)SqlDataSource1.Select(DataSourceSelectArguments.Empty);

            // if we retrieved the data successfully then we fill the form with the data.
            if (dataView.Count > 0)
            {
                var row = dataView[0];
                hfEmployeeId.Value = row["EmployeeId"].ToString();
                txtFirstName.Text = row["Firstname"].ToString();
                txtLastName.Text = row["Lastname"].ToString();
                txtEmail.Text = row["Email"].ToString();
                txtPhone.Text = row["Phone"].ToString();
                // here again we need to format the date to the right format
                txtHireDate.Text = DateTime.Parse(row["HireDate"].ToString()).ToString("yyyy-MM-dd");
            }
        }
    }
}