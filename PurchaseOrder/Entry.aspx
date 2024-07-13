<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Entry.aspx.cs" Inherits="PurchaseOrder.Entry" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <title>Dynamic Table with JavaScript</title>
    <link rel="stylesheet" type="text/css" href="Styles.css" />
<style>
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
    </style>
    <script src="Scripts.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script>
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
            /*var itemName = document.getElementById('itemName').value;*/
            var qty = document.getElementById('qty').value;
            var rate = document.getElementById('rate').value;
            var total = qty * rate;

            if (itemName === '' || qty === '' || rate === '') {
                alert('Please fill all fields.');
                return;
            }

            var table = document.getElementById('itemsTable').getElementsByTagName('tbody')[0];
            var newRow = table.insertRow();

            var cell1 = newRow.insertCell(0);
            var cell2 = newRow.insertCell(1);
            var cell3 = newRow.insertCell(2);
            var cell4 = newRow.insertCell(3);
            var cell5 = newRow.insertCell(4);

            cell1.innerHTML = itemName;
            cell2.innerHTML = qty;
            cell3.innerHTML = rate;
            cell4.innerHTML = total;
            cell5.innerHTML = '<button type="button" onclick="editItem(this)">Edit</button> <button type="button" onclick="deleteItem(this)">Delete</button>';

            /*document.getElementById('itemName').value = '';*/
            document.getElementById('searchInput').value = '';
            document.getElementById('qty').value = '';
            document.getElementById('rate').value = '';
        }

        function editItem(button) {
            var row = button.parentNode.parentNode;
            /*document.getElementById('itemName').value = row.cells[0].innerHTML;*/
            document.getElementById('searchInput').value = row.cells[0].innerHTML;
            document.getElementById('qty').value = row.cells[1].innerHTML;
            document.getElementById('rate').value = row.cells[2].innerHTML;

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

            var table = document.getElementById('itemsTable').getElementsByTagName('tbody')[0];
            for (var i = 0, row; row = table.rows[i]; i++) {
                itemNames.push(row.cells[0].innerHTML);
                quantities.push(row.cells[1].innerHTML);
                rates.push(row.cells[2].innerHTML);
            }

            document.getElementById('itemNames').value = itemNames.join(',');
            document.getElementById('quantities').value = quantities.join(',');
            document.getElementById('rates').value = rates.join(',');
        }

    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Button ID="btnBack" runat="server" Text="Back to List" PostBackUrl="~/Default.aspx" />

            
            <h2>Add Item</h2>

            <div style="position: relative;">
                <label for="searchInput">Search item:</label>
                <input type="text" id="searchInput" autocomplete="off" />
                <div id="dropdownContent" class="dropdown-content">
                    <!-- Search results will be displayed here -->
                </div>
            </div>

            <%--<label for="itemName">Item Name:</label>
            <input type="text" id="itemName" />
            <br />--%>
            <label for="qty">Quantity:</label>
            <input type="number" id="qty" />
            <br />
            <label for="rate">Rate:</label>
            <input type="number" id="rate" />
            <br />
            <button type="button" onclick="addItem()">Add Item</button>
        </div>

        <div>
            <h2>Items List</h2>
            <table runat="server" id="itemsTable">
                <thead>
                    <tr>
                        <th>Item Name</th>
                        <th>Quantity</th>
                        <th>Rate</th>
                        <th>Total</th>
                        <th>Actions</th>
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
            <asp:Button ID="btnSaveAll" runat="server" Text="Save All" OnClientClick="prepareDataForSubmit()" OnClick="btnSaveAll_Click" />
        </div>
    </form>
</body>
</html>


