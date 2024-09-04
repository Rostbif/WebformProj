<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AddEditEmployee.aspx.cs" Inherits="ClientApp.WebForm1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Add or Edit Employee </h2>
    <asp:HiddenField ID="hfEmployeeId" runat="server" />
    <div>
        <label for="txtFirstName">First Name:</label>
        <asp:TextBox ID="txtFirstName" runat="server" />
    </div>
    <div>
        <label for="txtLastName">Last Name:</label>
        <asp:TextBox ID="txtLastName" runat="server" />
    </div>
    <div>
        <label for="txtEmail">Email:</label>
        <asp:TextBox ID="txtEmail" runat="server" />
    </div>
    <div>
        <label for="txtPhone">Phone:</label>
        <asp:TextBox ID="txtPhone" runat="server" />
    </div>
    <div>
        <label for="txtHireDate">Hire Date:</label>
        <%--Here we might want a date picker - TBD--%>
        <asp:TextBox ID="txtHireDate" runat="server" />
    </div>
    <div>
        <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" />
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
