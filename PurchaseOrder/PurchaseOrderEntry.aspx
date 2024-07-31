<%@ Page Title="Purchase Order Entry" Language="C#" MasterPageFile="~/MasterPages/Modal.master" AutoEventWireup="true" CodeBehind="PurchaseOrderEntry.aspx.cs" Inherits="PurchaseOrder.PurchaseOrderEntry" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="Content/assets/css/jquery-ui-1.9.2.css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="Styles.css" />
    <style type="text/css">

        .dropdown-content {
            display: none;
            position: absolute;
            background-color: #f9f9f9;
            min-width: 200px;
            border: 1px solid #ccc;
            z-index: 1;
            max-height: 200px;
            overflow-y: auto;
        }

        .dropdown-content div {
            padding: 8px 16px;
            cursor: pointer;
        }

        .dropdown-content div:hover {
            background-color: #f1f1f1;
        }

        table {
            font-family: arial, sans-serif;
            border-collapse: collapse;
            width: 100%;
        }

        td, th {
            border: 1px solid #dddddd;
            text-align: left;
            padding: 8px;
        }

        tr:nth-child(even) {
            background-color: #dddddd;
        }

        .col-form-label{
            font-weight:bolder;
        }

    </style>
    <script type="text/javascript" src="Scripts.js"></script>
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script type="text/javascript">

        $(document).ready(function () {
            $('#searchInput').on('input', function () {
                var searchText = $(this).val().trim();
                if (searchText.length >= 1) {
                    $.ajax({
                        type: "POST",
                        url: "Entry.aspx/SearchItems",
                        data: JSON.stringify({ searchText: searchText }),
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (response) {
                            $('#dropdownContent').empty().show();
                            $.each(response.d, function (key, value) {
                                $('#dropdownContent').append('<div>' + value.ItemName + '</div>');
                            });
                        },
                        error: function (xhr, status, error) {
                            console.log("Error:", error);
                        }
                    });
                } else {
                    $('#dropdownContent').hide();
                }
            });

            $(document).on('click', '#dropdownContent div', function () {
                var selectedItem = $(this).text();
                $('#searchInput').val(selectedItem);
                $('#dropdownContent').hide();
            });

            $(document).click(function (e) {
                if (!$(e.target).closest('#searchInput').length) {
                    $('#dropdownContent').hide();
                }
            });
        });

        function addItem() {
            var itemName = document.getElementById('searchInput').value;
            var qty = document.getElementById('qty').value;
            var rate = document.getElementById('rate').value;
            var total = qty * rate;

            var rate = document.getElementById('rate').value;

            if (itemName === '' || qty === '' || rate === '') {
                alert('Please fill all fields.');
                return;
            }

            var table = document.getElementById('<%= itemsTable.ClientID %>').getElementsByTagName('tbody')[0];
            var newRow = table.insertRow();

            var cell1 = newRow.insertCell(0);
            var cell2 = newRow.insertCell(1);
            var cell3 = newRow.insertCell(2);
            var cell4 = newRow.insertCell(3);
            var cell5 = newRow.insertCell(4);

            cell1.innerHTML = itemName;
            cell2.innerHTML = qty;
            cell3.innerHTML = rate;
            cell4.innerHTML = '<button type="button" onclick="editItem(this)">Edit</button>';
            cell5.innerHTML = '<button type="button" onclick="deleteItem(this)">Delete</button>';

            document.getElementById('searchInput').value = '';
            document.getElementById('qty').value = '';
            document.getElementById('rate').value = '';
        }

        function editItem(button) {
            var row = button.parentNode.parentNode;
            console.log(row);

            document.getElementById('searchInput').value = row.cells[0].innerHTML.trim();
            document.getElementById('qty').value = row.cells[1].innerHTML.trim();
            document.getElementById('rate').value = row.cells[2].innerHTML.trim();

            row.parentNode.removeChild(row);
        }

        function deleteItem(button) {
            var row = button.parentNode.parentNode;
            row.parentNode.removeChild(row);
        }

        function prepareDataForSubmit() {
            var itemNames = [];
            var quantities = [];
            var rates = [];

            var textRef = document.getElementById('<%= txtRefIDs.ClientID %>');
            var textPONO = document.getElementById('<%= txtPONO.ClientID %>');
            var textPODate = document.getElementById('<%= txtPODate.ClientID %>');
            var textSupplier = document.getElementById('<%= ddlSupplier.ClientID %>');
            var textExpectedDate = document.getElementById('<%= txtExpectedDate.ClientID %>');
            var textRemarks = document.getElementById('<%= txtRemarks.ClientID %>');


            if (textRef.value.trim() === '') {
                alert('REF. ID is required.');
                return false;
            }
            else if (textPONO.value.trim() === '') {
                alert('PO NO is required.');
                return false;
            }
            else if (textPODate.value.trim() === '') {
                alert('PO Date is required.');
                return false;
            }
            else if (textPODate.value.trim() === '') {
                alert('PO Date is required.');
                return false;
            }
            else if (textExpectedDate.value.trim() === '') {
                alert('Expected Date is required.');
                return false;
            }
            else if (textRemarks.value.trim() === '') {
                alert('Remarks is required.');
                return false;
            }

            var table = document.getElementById('<%= itemsTable.ClientID %>').getElementsByTagName('tbody')[0];
            if (table.rows.length <= 1) {
                alert('Please add atleast one item.');
                return false;
            }

            for (var i = 0, row; row = table.rows[i]; i++) {
                itemNames.push(row.cells[0].innerHTML);
                quantities.push(row.cells[1].innerHTML);
                rates.push(row.cells[2].innerHTML);
            }

            document.getElementById('itemNames').value = itemNames.join(',');
            document.getElementById('quantities').value = quantities.join(',');
            document.getElementById('rates').value = rates.join(',');

            return true;
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="modal-body thickbox-modal" style="text-align: left">
        <div class="col-12 col-md-12 col-lg-12">
            <div class="col-12">
                <asp:UpdatePanel ID="lstpanel" runat="server">
                    <ContentTemplate>
                        <div style="text-align: center; background-color: #33C7FF; color: black; font-size: 16px; margin-bottom: 35px;">
                            PURCHASE ORDER ENTRY FORM
                        </div>
                        <div class="form-group row">
                            <div class="form-group row col-sm-6">
                                <asp:Label runat="server" Text="REF. ID:" class="col-sm-5 col-form-label" Style="text-align: left"> </asp:Label>
                                <div class="col-sm-7">
                                    <asp:TextBox ID="txtRefIDs" CssClass="form-control required" runat="server" MaxLength="100"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group row row col-sm-6"">
                                <asp:Label runat="server" Text="PO NO:" class="col-sm-5 col-form-label" Style="text-align: left"> </asp:Label>
                                <div class="col-sm-7">
                                    <asp:TextBox ID="txtPONO" CssClass="form-control" runat="server"></asp:TextBox>
                                </div>
                            </div>                           
                        </div>
                        <div class="form-group row">
                            <div class="form-group row col-sm-6">
                                <asp:Label runat="server" mandatory="true" Text="PO Date:" class="col-sm-5 col-form-label" Style="text-align: left"> </asp:Label>
                                <div class="col-sm-7">
                                    <asp:TextBox ID="txtPODate" type="date" CssClass="cndate form-control" runat="server"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group row row col-sm-6"">
                            <asp:Label runat="server" mandatory="true" Text="SUPPLIER:" class="col-sm-5 col-form-label" Style="text-align: left"> </asp:Label>
                            <div class="col-sm-7">
                                <asp:DropDownList ID="ddlSupplier" runat="server" CssClass="form-control required"></asp:DropDownList>
                            </div>
                        </div>
                        </div>
                        <div class="form-group row">
                        <div class="form-group row row col-sm-6"">
                                <asp:Label runat="server" mandatory="true" Text="EXPECTED DATE:" class="col-sm-5 col-form-label" Style="text-align: left"> </asp:Label>
                                <div class="col-sm-7">
                                    <asp:TextBox ID="txtExpectedDate" type="date" CssClass="cndate form-control" runat="server"></asp:TextBox>
                                </div>
                            </div>
                        <div class="form-group row row col-sm-6"">
                            <asp:Label runat="server" Text="REMARK:" class="col-sm-5 col-form-label" Style="text-align: left"> </asp:Label>
                            <div class="col-sm-7">
                                <asp:TextBox ID="txtRemarks" runat="server" CssClass="form-control" Rows="2" TextMode="MultiLine"> </asp:TextBox>
                            </div>
                        </div>
                            </div>
                        <table class="contenttext" style="table-layout: fixed; width: 100%;">
                            <tr>
                                <td colspan="2" style="border: #FCDCC5 1px solid;">
                                    <div style="height: 450px; width: 100%; overflow: auto">
                                        <div>
                                            <table>
                                                <tr>
                                                    <td>
                                                        <label for="searchInput">ITEM:</label>
                                                    </td>
                                                    <td>
                                                        <input type="text" id="searchInput" placeholder="Auto Complete" autocomplete="off" />
                                                        <div id="dropdownContent" class="dropdown-content">
                                                            <!-- Search results will be displayed here -->
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <label for="qty">QTY:</label>
                                                    </td>
                                                    <td>
                                                        <input type="number" id="qty" />
                                                    </td>
                                                    <td>
                                                        <label for="rate">RATE:</label>
                                                    </td>
                                                    <td>
                                                        <input type="number" id="rate" />
                                                    </td>
                                                    <td>
                                                        <button type="button" onclick="addItem()">Add</button>
                                                    </td>
                                                </tr>
                                            </table>
                                            <br />
                                            <table runat="server" id="itemsTable">
                                                <thead>
                                                    <tr>
                                                        <th>ITEM NAME</th>
                                                        <th>QTY.</th>
                                                        <th>RATE</th>
                                                        <th>Edit</th>
                                                        <th>Delete</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                </tbody>
                                            </table>
                                        </div>
                                        <div>
                                            <input type="hidden" id="itemNames" name="itemNames" />
                                            <input type="hidden" id="quantities" name="quantities" />
                                            <input type="hidden" id="rates" name="rates" />
                                        </div>
                                        <br />
                                        <div style="text-align: right">
                                            <asp:Button ID="btnSave" runat="server" Text="Save" OnClientClick="return prepareDataForSubmit();" OnClick="btnSave_Click" />
                                            <asp:Button ID="btnDelete" Visible="false" runat="server" Text="Delete" OnClick="btnSave_Click" />
                                            <asp:Button ID="btnClose" runat="server" Text="Close" OnClick="btnClose_Click" />
                                        </div>
                                    </div>
                                </td>
                            </tr>
                        </table>
                        <div class="msg">
                            <asp:Label ID="lblMsg" runat="server">
    
                            </asp:Label>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
    </div>

    <div class="modal-footer bg-whitesmoke br">
        <div class="footer">
            <div class="col-xs-10" id="lblstatus"></div>
        </div>
    </div>
    <script type="text/javascript">
</script>
    <script src="Scripts/jquery-1.10.0.min.js" type="text/javascript"></script>
    <script src="Scripts/jquery-ui.min.js"  type="text/javascript"></script> 
    <script src="Content/assets/js/app.min.js" type="text/javascript"></script> 
    <script src="Scripts/jquery-ui-1.13.1.js" type="text/javascript"></script>
</asp:Content>


