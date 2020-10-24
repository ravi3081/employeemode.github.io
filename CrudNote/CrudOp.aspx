<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CrudOp.aspx.cs" Inherits="CrudNote.CrudOp" %>



<!DOCTYPE HTML> 
<html lang="en" xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script src="Scripts/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
    $(document).ready(function () {

        SaveData();
    });
    //In url write your page name like"WebForm1.aspx" and Webmethod name "InsertData".
    //Write jQuery Ajax to call WebMethod(InsertData)
    function SaveData() {
        if ($("#btnsubmit").val() == "Submit") {
            $.ajax({
                url: 'CrudOp.aspx/InsertData',
                type: 'post',
                contentType: 'application/json;charset=utf-8',
                dataType: 'json',
                data: "{name:'" + $("#txtName").val() + "',address:'" + $("#txtAddress").val() + "'}",
                success: function () {
                    alert("Insert data Successfully");
                    GetData();
                },
                error: function () {
                    alert("Insert Error");
                }

            });

        }
        else {
            $.ajax({
                url: 'CrudOp.aspx/Update',
                type: 'post',
                contentType: 'application/json;charset=utf-8',
                dataType: 'json',
                data: "{ID:'" + idd + "',name:'" + $("#txtName").val() + "',age:'" + $("#txtAge").val() + "',address:'" + $("#txtAddress").val() + "'}",
                success: function () {
                    alert("Update data Successfully");
                    GetData();
                },
                error: function () {
                    alert("Update Error");
                }

            });
        }

    }
    //Retreive Record

    function GetData() {
        $.ajax({
            url: 'CrudOp.aspx/GetEmpData',
            type: 'post',
            contentType: 'application/json;charset=utf-8',
            dataType: 'json',
            data: "{}",
            success: function (_data) {
                _data = JSON.parse(_data.d);
                $("#tbl").find("tr:gt(0)").remove();
                for (var i = 0; i < _data.length; i++) {
                    $("#tbl").append('<tr><td>' + _data[i].EmpName + '</td><td>' + _data[i].EmpAddress + '</td><td><input type="button" id="btndelete" value="Delete" onclick="DeleteData(' + _data[i].EmpId + ')" /></td>  <td><input type="button" id="btnedit" value="Edit" onclick="EditData(' + _data[i].EmpId + ')" /></td>  </tr>');
                }

            },
            error: function () {
                alert("Get Error");
            }

        });

    }
    //Edit Record 
    function EditData(empid) {
        $.ajax({
            url: 'CrudOp.aspx/Edit',
            type: 'post',
            contentType: 'application/json;charset=utf-8',
            dataType: 'json',
            data: "{Id : '" + empid + "'}",
            success: function (_dt) {
                _dt = JSON.parse(_dt.d);
                $("#txtName").val(_dt[0].EmpName);
                $("#txtAddress").val(_dt[0].EmpAddress);
               

                $("#btnsubmit").val("Update");
                idd = empid;
            },
            error: function () {
                alert('edit error !!');
            }
        });
    }
    //Delete Record
    function DeleteData(empid) {
        $.ajax({
            url: 'CrudOp.aspx/Delete',
            type: 'post',
            contentType: 'application/json;charset=utf-8',
            dataType: 'json',
            data: "{Id : '" + empid + "'}",
            success: function () {
                alert('delete success !!');
                GetData();
            },
            error: function () {
                alert('delete error !!');
            }
        });
    }
    </script>
 
    <style type="text/css">
#tbl {
    font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
    border-collapse: collapse;
    width: 70%;
}
 
#tbl td, #tbl th {
    border: 1px solid #ddd;
    padding: 8px;
}
 
#tbl tr:nth-child(even){background-color: #f2f2f2;}
 
#tbl tr:hover {background-color: #ddd;}
 
#tbl th {
    padding-top: 12px;
    padding-bottom: 12px;
    text-align: left;
    background-color: #4CAF50;
    color: white;
}
 
 
</style>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <table>
        <tr><td>
            Name:
            </td>
            <td><input type="text" id="txtName" /></td>
        </tr>
     
        <tr>
            <td>Address:</td>
            <td><input type="text" id="txtAddress" /></td>
        </tr>
        <tr>
            <td></td>
            <td><input type="button" id="btnsubmit" value="Submit" onclick="SaveData()" /></td>
        </tr>
    </table>
        <table id="tbl" >
            <tr>
                <th>Enmployee Name</th>
                
                <th>Employee Address</th>
                <th></th>
                <th></th>
            </tr>
 
        </table>
    </div>
    </form>
</body>
</html>
