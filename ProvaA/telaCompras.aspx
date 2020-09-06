<%@ Page Language="C#" AutoEventWireup="true" CodeFile="telaCompras.aspx.cs" Inherits="telaCompras" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            font-size: x-large;
        }
        .auto-style2 {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <span class="auto-style2"><strong><em>TELA COMPRAS</em></strong></span><br />
            <br />
            Escolha seu produto:
            <asp:TextBox ID="txtPesq" runat="server"></asp:TextBox>
&nbsp;<asp:Button ID="btnPesq" runat="server" Text="Pesquisar" OnClick="btnPesq_Click" />
            <br />
            <asp:SqlDataSource ID="SqlPesq" runat="server" ConnectionString="<%$ ConnectionStrings:prova_1ConnectionString %>" ProviderName="<%$ ConnectionStrings:prova_1ConnectionString.ProviderName %>" SelectCommand="SELECT id_prod, nome_prod, fabricante_prod, preco_prod FROM produto WHERE (nome_prod = @PROD)">
                <SelectParameters>
                    <asp:Parameter Name="PROD" />
                </SelectParameters>
            </asp:SqlDataSource>
            <br />
            Confirme o produto:<asp:Panel ID="Panel1" runat="server" BorderStyle="Solid">
                Nome:
                <asp:Label ID="lblNome" runat="server" Text=""></asp:Label>
                <br />
                Fabricante:
                <asp:Label ID="lblFabricante" runat="server" Text=""></asp:Label>
                <br />
                Preço:
                <asp:Label ID="lblPreco" runat="server" Text=""></asp:Label>
            </asp:Panel>
        </div>
        <p>
            Quantidade Desejada:
            <asp:TextBox ID="txtQtd" runat="server"></asp:TextBox>
&nbsp;<asp:Button ID="btnCalTotal" runat="server" Text="Calcular Total Pagar" OnClick="btnCalTotal_Click" />
        </p>
        <p>
            <span class="auto-style1"><strong>Total R$:
            </strong></span><strong>
            <asp:Label ID="lblTotal" runat="server" Text="" CssClass="auto-style1"></asp:Label>
            </strong>&nbsp;</p>
        <p>
            <asp:Button ID="btnComprar" runat="server" Text="Comprar" OnClick="btnComprar_Click" />
        &nbsp;<asp:Label ID="lblComprar" runat="server" Text=""></asp:Label>
            <asp:SqlDataSource ID="SqlComprar" runat="server" ConnectionString="<%$ ConnectionStrings:prova_1ConnectionString %>" InsertCommand="INSERT INTO vendas(id_prod, qtd, total) VALUES (@IDPROD, @QTD, @TOTAL)" ProviderName="<%$ ConnectionStrings:prova_1ConnectionString.ProviderName %>" SelectCommand="SELECT * FROM vendas">
                <InsertParameters>
                    <asp:SessionParameter Name="IDPROD" SessionField="idProd" />
                    <asp:Parameter Name="QTD" />
                    <asp:Parameter Name="TOTAL" />
                </InsertParameters>
            </asp:SqlDataSource>
        </p>
        <p>
            <asp:GridView ID="gvExibir" runat="server" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical" AutoGenerateColumns="False" DataKeyNames="id_vendas">
                <AlternatingRowStyle BackColor="#CCCCCC" />
                <Columns>
                    <asp:BoundField DataField="id_vendas" HeaderText="Código" InsertVisible="False" ReadOnly="True" SortExpression="id_vendas" />
                    <asp:BoundField DataField="qtd" HeaderText="Quantidade" SortExpression="qtd" />
                    <asp:BoundField DataField="total" DataFormatString="{0:c}" HeaderText="Total" SortExpression="total" />
                    <asp:BoundField DataField="nome_prod" HeaderText="Nome do Produto" SortExpression="nome_prod" />
                </Columns>
                <FooterStyle BackColor="#CCCCCC" />
                <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
            </asp:GridView>
            <asp:SqlDataSource ID="SqlTabelaVendas" runat="server" ConnectionString="<%$ ConnectionStrings:prova_1ConnectionString %>" ProviderName="<%$ ConnectionStrings:prova_1ConnectionString.ProviderName %>" SelectCommand="SELECT vendas.id_vendas, vendas.qtd, vendas.total, produto.nome_prod FROM vendas INNER JOIN produto ON vendas.id_prod = produto.id_prod"></asp:SqlDataSource>
        </p>
    </form>
</body>
</html>
