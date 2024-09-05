<%@ Page Title="About" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Employees.aspx.cs" Inherits="ClientApp.About" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    
    <main aria-labelledby="title">
        <h1>Employees Page
        </h1>
    </main>

    <div style="display: flex; flex-direction: row; justify-content: space-between">

        <%--Search Sort and Add Employee bar--%>
        <div aria-labelledby="title">
            <label for="txtSearch">Search:</label>
            <asp:TextBox ID="txtSearch" runat="server" />
            <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" />
            Sort by:
            <asp:DropDownList ID="SortList1"
                runat="server">
                <asp:ListItem Selected="true">EmployeeId</asp:ListItem>
                <asp:ListItem>Firstname</asp:ListItem>
                <asp:ListItem>Lastname</asp:ListItem>
                <asp:ListItem>Email</asp:ListItem>
                <asp:ListItem>Phone</asp:ListItem>
            </asp:DropDownList>
            Sort order:      
            <asp:DropDownList ID="DirectionList1"
                runat="server">
                <asp:ListItem Selected="true">Ascending</asp:ListItem>
                <asp:ListItem>Descending</asp:ListItem>
            </asp:DropDownList>
            <asp:Button ID="SortButton"
                Text="Sort"
                OnClick="SortButton_Click"
                runat="Server" />
        </div>
        <div>
            <asp:Button ID="btnAddEmployee" runat="server" Text="Add Employee" OnClick="btnAddEmployee_Click" />
        </div>
    </div>

    <%--SQL data source to interact with the DB--%>
    <div>
        <asp:SqlDataSource ID="sqlDataSource1" runat="server"
            ConnectionString="<%$ ConnectionStrings:datWise %>"
            SelectCommand="SELECT EmployeeID, Firstname, Lastname, Email, Phone, HireDate FROM dbo.Employees WHERE FirstName LIKE '%' + @SearchTerm + '%' OR
                LastName LIKE '%' + @SearchTerm + '%' OR Email LIKE '%' + @SearchTerm + '%'"
            DeleteCommand="DELETE FROM dbo.Employees WHERE EmployeeID=@EmployeeID"
            >
            <DeleteParameters>
                <asp:Parameter Name="EmployeeID" Type="Int32" />
            </DeleteParameters>
            <SelectParameters>
                <%--need to solve here the default value thing, I used a trick here--%>
                <asp:ControlParameter Name="SearchTerm" ControlID="txtSearch" PropertyName="Text" Type="String" DefaultValue="%" />
            </SelectParameters>

        </asp:SqlDataSource>


        <%--The Grid view to present the data--%>
        <asp:GridView ID="GridView1" runat="server" DataSourceID="SqlDataSource1"
            AutoGenerateColumns="false"
            OnRowDeleting="GridView1_RowDeleting"
            DataKeyNames="EmployeeID"
            Width="100%"
            AllowSorting="true">
            <Columns>
                <%-- BoundField is used for simple data presentation --%>
                <asp:BoundField DataField="EmployeeID" HeaderText="Employee ID" ReadOnly="true" SortExpression="EmployeeID" />
                <asp:TemplateField HeaderText="First Name" SortExpression="Firstname">
                    <ItemTemplate>
                        <%--Here we can use Eval instead of Bind as it's readonly control. If we wanted to edit in row then we had to use Bind--%>
                        <asp:Label ID="lblFirstname" runat="server"
                            Text='<%# Eval("Firstname") 
                                %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Last Name" SortExpression="Lastname">
                    <ItemTemplate>
                        <asp:Label ID="lblLastname" runat="server"
                            Text='<%# Eval("Lastname") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Email" SortExpression="Email">
                    <ItemTemplate>
                        <asp:Label ID="lblEmail" runat="server"
                            Text='<%# Eval("Email") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Phone" SortExpression="Phone">
                    <ItemTemplate>
                        <asp:Label ID="lblPhone" runat="server"
                            Text='<%# Eval("Phone") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Hire Date" SortExpression="HireDate">
                    <ItemTemplate>
                        <asp:Label ID="lblHireDate" runat="server"
                            Text='<%# Eval("HireDate", "{0:yyyy-MM-dd}") %>'>
                        </asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <%-- Actions (Edit & Delete) Column --%>
                <asp:TemplateField HeaderText="Actions">
                    <ItemTemplate>
                        <asp:HyperLink ID="hlAdvancedEdit" runat="server"
                            NavigateUrl='<%# Eval("EmployeeID", "~/EmployeeForm.aspx?id={0}") %>'
                            Text="Edit">
                        </asp:HyperLink>
                        <asp:LinkButton ID="lnkDelete" runat="server" Text="Delete"
                            CommandName="Delete" CommandArgument='<%# Eval("EmployeeID") %>'>
                        </asp:LinkButton>

                    </ItemTemplate>
                </asp:TemplateField>

            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
