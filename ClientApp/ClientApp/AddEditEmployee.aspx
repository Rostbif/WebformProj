<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AddEditEmployee.aspx.cs" Inherits="ClientApp.WebForm1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Add or Edit Employee </h2>

    <div style="display:flex; flex-direction:column;gap:4px;">
        <asp:HiddenField ID="hfEmployeeId" runat="server" />
        <div style="display: flex; flex-direction: column">
            <label for="txtFirstName">First Name:</label>
            <div>
                <asp:TextBox ID="txtFirstName" runat="server" />
                <asp:RequiredFieldValidator ID="rfvFirstname" runat="server" ControlToValidate="txtFirstName" ErrorMessage="* Required" ForeColor="Red" />
            </div>
        </div>
        <div style="display: flex; flex-direction: column">
            <label for="txtLastName">Last Name:</label>
            <div>
                <asp:TextBox ID="txtLastName" runat="server" />
                <asp:RequiredFieldValidator ID="rfvLastName" runat="server" ControlToValidate="txtLastName" ErrorMessage="* Required" ForeColor="Red" />
            </div>
        </div>
        <div style="display: flex; flex-direction: column">
            <label for="txtEmail">Email:</label>
            <div>
                <asp:TextBox ID="txtEmail" runat="server" />
                <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="* Required" ForeColor="Red" />
                <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="Invalid Email Address" ForeColor="Red" ValidationExpression="\w+([-+.'']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" />
            </div>
        </div>
        <div style="display: flex; flex-direction: column">
            <label for="txtPhone">Phone:</label>
            <div>
                <asp:TextBox ID="txtPhone" runat="server" />
                <asp:RequiredFieldValidator ID="rfvPhone" runat="server" ControlToValidate="txtPhone" ErrorMessage="* Required" ForeColor="Red" />
                <asp:RegularExpressionValidator ID="revPhone" runat="server" ControlToValidate="txtPhone" ErrorMessage="Invalid Phone Number" ForeColor="Red" ValidationExpression="^\d{10}$" />
            </div>
        </div>
        <div style="display: flex; flex-direction: column">
            <label for="txtHireDate">Hire Date:</label>
            <%--Here we might want a date picker - TBD--%>
            <div>
                <asp:TextBox ID="txtHireDate" runat="server" placeholder="DD-MM-YYYY"/>
                <asp:RequiredFieldValidator ID="rfvHireDate" runat="server" ControlToValidate="txtHireDate" ErrorMessage="* Required" ForeColor="Red" />
                <asp:CompareValidator ID="cvHireDate" runat="server" ControlToValidate="txtHireDate" ErrorMessage="Invalid Date" ForeColor="Red" Operator="DataTypeCheck" Type="Date" />
            </div>
        </div>
        <div>
            <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" />
        </div>
    </div>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server"
        ConnectionString="<%$ ConnectionStrings:datWise %>"
        SelectCommand="SELECT * FROM Employees WHERE EmployeeId = @EmployeeId"
        UpdateCommand="UPDATE Employees SET FirstName = @Firstname, Lastname = @Lastname, Email = @Email, Phone = @Phone, HireDate = @HireDate WHERE EmployeeId = @EmployeeId"
        InsertCommand="INSERT INTO Employees (Firstname, Lastname, Email, Phone, HireDate) VALUES (@FirstName, @LastName, @Email, @Phone, @HireDate)">
        <SelectParameters>
            <asp:QueryStringParameter Name="EmployeeId" QueryStringField="id" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="Firstname" Type="String" />
            <asp:Parameter Name="LastName" Type="String" />
            <asp:Parameter Name="Email" Type="String" />
            <asp:Parameter Name="Phone" Type="String" />
            <asp:Parameter Name="HireDate" Type="DateTime" />
            <asp:Parameter Name="EmployeeId" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="Firstname" Type="String" />
            <asp:Parameter Name="LastName" Type="String" />
            <asp:Parameter Name="Email" Type="String" />
            <asp:Parameter Name="Phone" Type="String" />
            <asp:Parameter Name="HireDate" Type="DateTime" />
        </InsertParameters>
    </asp:SqlDataSource>

</asp:Content>
