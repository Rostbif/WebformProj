<%@ Page Title="Contact Details" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="ClientApp.Contact" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <main aria-labelledby="title">
        <h1 id="title"><%: Title %>.</h1>
        <h3>Ofir Adany </h3>
        <address>
            Kefar Sava
        </address>

        <address>
            <strong>Email:</strong>   <a href="mailto:ofiradany@gmail.com">ofiradany@gmail.com</a><br />
            <strong>Phone:</strong> 054-9760104
        </address>
    </main>
</asp:Content>
