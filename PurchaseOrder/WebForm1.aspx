<%@ Page Title="" Language="C#" MasterPageFile="~/PopupMaster.master" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="PurchaseOrder.WebForm1" %>
<%@ Page Title="Purchase Order Entry" Language="C#" MasterPageFile="~/PopupMaster.master" AutoEventWireup="true" CodeBehind="PurchaseOrderEntry.aspx.cs" Inherits="YourNamespace.PurchaseOrderEntry" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-4">
        <h2 class="mb-4">Purchase Order Entry Form</h2>
        <div class="form-group row">
            <label for="txtRefId" class="col-sm-2 col-form-label">REF. ID:</label>
            <div class="col-sm-4">
                <asp:TextBox ID="txtRefId" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
            <label for="txtPoNo" class="col-sm-2 col-form-label">PO NO.:</label>
            <div class="col-sm-4">
                <asp:TextBox ID="txtPoNo" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
        </div>
        <div class="form-group row">
            <label for="txtPoDate" class="col-sm-2 col-form-label">PO DATE:</label>
            <div class="col-sm-4">
                <asp:TextBox ID="txtPoDate" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
            <label for="txtSupplier" class="col-sm-2 col-form-label">SUPPLIER:</label>
            <div class="col-sm-4">
                <asp:TextBox ID="txtSupplier" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
        </div>
        <div class="form-group row">
            <label for="txtExDate" class="col-sm-2 col-form-label">EXPECTED DATE:</label>
            <div class="col-sm-4">
                <asp:TextBox ID="txtExDate" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
            <label for="txtRemark" class="col-sm-2 col-form-label">REMARK:</label>
            <div class="col-sm-4">
                <asp:TextBox ID="txtRemark" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
        </div>
        <div class="form-group row">
            <label for="txtItem" class="col-sm-2 col-form-label">ITEM:</label>
            <div class="col-sm-4">
                <asp:TextBox ID="txtItem" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
            <label for="txtQty" class="col-sm-2 col-form-label">QTY.:</label>
            <div class="col-sm-2">
                <asp:TextBox ID="txtQty" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
            <label for="txtRate" class="col-sm-1 col-form-label">RATE ($):</label>
            <div class="col-sm-2">
                <asp:TextBox ID="txtRate" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
            <div class="col-sm-1">
                <asp:ImageButton ID="btnAddItem" runat="server" ImageUrl="~/images/add.png" OnClick="btnAddItem_Click" CssClass="img-button" />
            </div>
        </div>
        </div>
</asp:Content>
<%--        <asp:GridView ID="gvItems" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered">
            <Columns>
                <asp:BoundField DataField="ItemName" HeaderText="ITEM NAME" />
                <asp:BoundField DataField="Qty" HeaderText="QTY." />
                <asp:BoundField DataField="Rate" HeaderText="RATE ($)" />
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:ImageButton ID="btnEditItem" runat="server" ImageUrl="~/images/edit.png" CommandName="EditItem" CommandArgument='<%# Container.DataItemIndex %>' CssClass="img-button" />
                        <asp:ImageButton ID="btnDeleteItem" runat="server"--%>

