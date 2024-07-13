<%--<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="OrderList.aspx.cs" Inherits="PurchaseOrder.OrderList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="card mt-3">
        <div class="card-header">ORDER LIST
        </div>
        <div class="card-body">
            <button type="button" class="btn btn-primary mb-3">Create</button>
<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" OnPageIndexChanging="GridView1_PageIndexChanging" AllowPaging="True" PageSize="10">
            <Columns>
                <asp:BoundField DataField="RefID" HeaderText="REF. ID" />
                <asp:BoundField DataField="PONumber" HeaderText="PO NO" />
                <asp:BoundField DataField="PODate" HeaderText="PO DATE" DataFormatString="{0:yyyy-MM-dd}" />
                <asp:BoundField DataField="SupplierName" HeaderText="SUPPLIER" />
                <asp:BoundField DataField="ExpectedDate" HeaderText="EX. DATE" DataFormatString="{0:yyyy-MM-dd}" />
            </Columns>
                 <PagerStyle CssClass="gridviewPager" />
        </asp:GridView>
        <asp:Label ID="lblTotalRecords" runat="server" />
        </div>
    </div>
</asp:Content>--%>

<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OrderList.aspx.cs" Inherits="PurchaseOrder.OrderList" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Purchase Order List</title>
    <style>
        .gridviewPager {
            text-align: center;
            margin-top: 10px;
        }
        .gridviewPager a {
            margin: 0 5px;
            text-decoration: none;
            color: #007bff;
        }
        .gridviewPager a:hover {
            text-decoration: underline;
        }
        .gridviewPager span {
            margin: 0 5px;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <input type="button" value="Add New RF" alt="PurchaseOrderEntry.aspx?keepThis=false&TB_iframe=true&height=600"
                                class="thickbox btn btn-info" title="Create" />
    <form id="form1" runat="server">
        <asp:GridView ID="gvPurchaseOrders" runat="server" AutoGenerateColumns="False" OnPageIndexChanging="gvPurchaseOrders_PageIndexChanging" AllowPaging="True" PageSize="2">
            <Columns>
                <asp:BoundField DataField="RefID" HeaderText="REF. ID" />
                <asp:BoundField DataField="PONumber" HeaderText="PO NO" />
                <asp:BoundField DataField="PODate" HeaderText="PO DATE" DataFormatString="{0:yyyy-MM-dd}" />
                <asp:BoundField DataField="SupplierName" HeaderText="SUPPLIER" />
                <asp:BoundField DataField="ExpectedDate" HeaderText="EX. DATE" DataFormatString="{0:yyyy-MM-dd}" />
                <asp:TemplateField>
                <ItemTemplate>
                        <asp:ImageButton ID="btnEdit" runat="server" ImageUrl="~/images/edit.png" />
                        <asp:ImageButton ID="btnDelete" runat="server" ImageUrl="~/images/delete.png" />
                        <asp:ImageButton ID="btnExport" runat="server" ImageUrl="~/images/export.png" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <div class="pagination">
            <asp:Button ID="btnPrevious" runat="server" Text="Previous" CssClass="page-button" OnClick="btnPrevious_Click" />
            <asp:Label ID="lblPageInfo" runat="server" Text="Page X of Y"></asp:Label>
            <asp:Button ID="btnNext" runat="server" Text="Next" CssClass="page-button" OnClick="btnNext_Click" />
        </div>
        <asp:Label ID="lblTotalRecords" runat="server" />
    </form>
</body>
</html>
