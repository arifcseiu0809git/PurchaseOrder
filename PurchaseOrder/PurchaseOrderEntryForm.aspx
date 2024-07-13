<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PurchaseOrderEntryForm.aspx.cs" Inherits="PurchaseOrder.PurchaseOrderEntryForm" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="card mt-3">
        <div class="card-header">PURCHASE ORDER ENTRY FORM</div>
        <div class="card-body">
            <form>
                <div class="form-row">
                    <div class="form-group col-md-2">
                        <label for="refId">REF. ID</label>
                        <input type="text" class="form-control" id="refId" placeholder="001">
                    </div>
                    <div class="form-group col-md-2">
                        <label for="poDate">PO DATE</label>
                        <input type="date" class="form-control" id="poDate">
                    </div>
                    <div class="form-group col-md-2">
                        <label for="supplier">SUPPLIER</label>
                        <input type="text" class="form-control" id="supplier">
                    </div>
                    <div class="form-group col-md-4">
                        <label for="remark">REMARK</label>
                        <input type="text" class="form-control" id="remark">
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-3">
                        <label for="item">ITEM NAME</label>
                        <input type="text" class="form-control" id="item">
                    </div>
                    <div class="form-group col-md2">
                        <label for="qty">QTY</label>
                        <input type="number" class="form-control" id="qty">
                    </div>
                    <div class="form-group col-md-2">
                        <label for="rate">RATE ($)</label>
                        <input type="number" class="form-control" id="rate">
                    </div>
                    <div class="form-group col-md-2 align-self-end">
                        <button type="button" class="btn btn-primary">Add</button>
                    </div>
                </div>
            </form>
            <table class="table table-striped mt-3">
                <thead>
                    <tr>
                        <th>ITEM NAME</th>
                        <th>QTY</th>
                        <th>RATE ($)</th>
                        <th>EDIT</th>
                        <th>DELETE</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>A</td>
                        <td>5</td>
                        <td>5</td>
                        <td><button class="btn btn-warning btn-sm">Edit</button></td>
                        <td><button class="btn btn-danger btn-sm">Delete</button></td>
                    </tr>
                    <!-- Add more rows as needed -->
                </tbody>
            </table>
            <button type="button" class="btn btn-success">Save</button>
            <button type="button" class="btn btn-secondary">Close</button>
        </div>
    </div>
</asp:Content>
