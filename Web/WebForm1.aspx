<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="Web.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1">
            <Columns>
                <asp:BoundField DataField="i" HeaderText="i" InsertVisible="False" ReadOnly="True" SortExpression="i" />
                <asp:BoundField DataField="p" HeaderText="p" SortExpression="p" />
                <asp:BoundField DataField="r" HeaderText="r" SortExpression="r" />
                <asp:BoundField DataField="c" HeaderText="c" SortExpression="c" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:RAMConnectionString1 %>" SelectCommand="SELECT * FROM [c]"></asp:SqlDataSource>
    </div>
    </form>
</body>
</html>
