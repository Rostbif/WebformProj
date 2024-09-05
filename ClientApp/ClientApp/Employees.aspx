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
            UpdateCommand="UPDATE Employees SET Firstname = @Firstname, Lastname = @Lastname, Email = @Email, Phone = @Phone, HireDate = @HireDate WHERE EmployeeID = @EmployeeID">
            <DeleteParameters>
                <asp:Parameter Name="EmployeeID" Type="Int32" />
            </DeleteParameters>
            <SelectParameters>
                <%--need to solve here the default value thing, I used a trick here--%>
                <asp:ControlParameter Name="SearchTerm" ControlID="txtSearch" PropertyName="Text" Type="String" DefaultValue="%" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="Firstname" Type="String" />
                <asp:Parameter Name="Lastname" Type="String" />
                <asp:Parameter Name="Email" Type="String" />
                <asp:Parameter Name="Phone" Type="String" />
                <asp:Parameter Name="HireDate" Type="DateTime" />
                <asp:Parameter Name="EmployeeID" Type="Int32" />
            </UpdateParameters>

        </asp:SqlDataSource>


        <%--The Grid view to present the data--%>
        <asp:GridView ID="GridView1" runat="server" DataSourceID="SqlDataSource1"
            AutoGenerateColumns="false"
            OnRowDeleting="GridView1_RowDeleting"
            DataKeyNames="EmployeeID"
            OnRowEditing="GridView1_RowEditing"
            OnRowUpdating="GridView1_RowUpdating"
            OnRowCancelingEdit="GridView1_RowCancelingEdit"
            Width="100%"
            AllowSorting="true">
            <Columns>
                <%-- BoundField is used for simple data presentation --%>
                <asp:BoundField DataField="EmployeeID" HeaderText="Employee ID" ReadOnly="true" SortExpression="EmployeeID" />
                <asp:TemplateField HeaderText="First Name" SortExpression="Firstname">
                    <ItemTemplate>
                        <%--Here we can use Eval instead of Bind as it's readonly control. If we wanted to edit in row then we have to use Bind--%>
                        <asp:Label ID="lblFirstname" runat="server"
                            Text='<%# Eval("Firstname") 
                                %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtFirstname" runat="server" Text='<%# Bind("Firstname") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvFirstname" runat="server" ControlToValidate="txtFirstname"
                            ErrorMessage="* Required" ValidationGroup="vgEdit" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Last Name" SortExpression="Lastname">
                    <ItemTemplate>
                        <asp:Label ID="lblLastname" runat="server"
                            Text='<%# Eval("Lastname") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <div style="display: flex; flex-direction: column">
                            <asp:TextBox ID="txtLastname" runat="server" Text='<%# Bind("Lastname") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvLastname" runat="server" ControlToValidate="txtLastname"
                                ErrorMessage="* Required" ValidationGroup="vgEdit" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                        </div>
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Email" SortExpression="Email">
                    <ItemTemplate>
                        <asp:Label ID="lblEmail" runat="server"
                            Text='<%# Eval("Email") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <div style="display: flex; flex-direction: column">
                            <asp:TextBox ID="txtEmail" runat="server" Text='<%# Bind("Email") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail"
                                ErrorMessage="* Required" ValidationGroup="vgEdit" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail"
                                ErrorMessage="Invalid email format." ValidationExpression="^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$"
                                ValidationGroup="vgEdit" Display="Dynamic" ForeColor="Red"></asp:RegularExpressionValidator>
                        </div>
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Phone" SortExpression="Phone">
                    <ItemTemplate>
                        <asp:Label ID="lblPhone" runat="server"
                            Text='<%# Eval("Phone") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>

                        <div style="display: flex; flex-direction: column">
                            <asp:TextBox ID="txtPhone" runat="server" Text='<%# Bind("Phone") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvPhone" runat="server" ControlToValidate="txtPhone"
                                ErrorMessage="* Required" ValidationGroup="vgEdit" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="revPhone" runat="server" ControlToValidate="txtPhone"
                                ErrorMessage="Invalid phone number format." ValidationExpression="^\d{10}$"
                                ValidationGroup="vgEdit" Display="Dynamic" ForeColor="Red"></asp:RegularExpressionValidator>
                        </div>

                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Hire Date" SortExpression="HireDate">
                    <ItemTemplate>
                        <asp:Label ID="lblHireDate" runat="server"
                            Text='<%# Eval("HireDate", "{0:yyyy-MM-dd}") %>'>
                        </asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <div style="display: flex; flex-direction: column">

                            <asp:TextBox ID="txtHireDate" runat="server" Text='<%# Bind("HireDate", "{0:yyyy-MM-dd}") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvHireDate" runat="server" ControlToValidate="txtHireDate"
                                ErrorMessage="* Required" ValidationGroup="vgEdit" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                            <asp:CompareValidator ID="cvHireDate" runat="server" ControlToValidate="txtHireDate"
                                ErrorMessage="Invalid date format." Operator="DataTypeCheck" Type="Date"
                                ValidationGroup="vgEdit" Display="Dynamic" ForeColor="Red"></asp:CompareValidator>
                        </div>
                    </EditItemTemplate>

                </asp:TemplateField>

                <%-- Actions (Edit & Delete) Column --%>
                <asp:TemplateField HeaderText="Actions">
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkDelete" runat="server" Text="Delete"
                            CommandName="Delete" CommandArgument='<%# Eval("EmployeeID") %>'>
                        </asp:LinkButton>
                        |
                         <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" CommandName="Edit"></asp:LinkButton>
                        |
                       <asp:HyperLink ID="hlAdvancedEdit" runat="server"
                           NavigateUrl='<%# Eval("EmployeeID", "~/EmployeeForm.aspx?id={0}") %>'
                           Text="Advanced Edit">
                       </asp:HyperLink>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:LinkButton ID="lnkUpdate" runat="server" Text="Update" CommandName="Update"
                            ValidationGroup="vgEdit">
                        </asp:LinkButton>
                        <asp:LinkButton ID="lnkCancel" runat="server" Text="Cancel" CommandName="Cancel"></asp:LinkButton>
                    </EditItemTemplate>
                </asp:TemplateField>

            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
