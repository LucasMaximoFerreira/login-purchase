<%@ Page Language="C#" AutoEventWireup="true"  CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <span class="auto-style1"><strong><em>MERCADINHO TUDO LEGAL</em></strong></span><br />
        <br />
        Faça seu Login para comprar<br />
        <br />
        Login:
        <asp:TextBox ID="txtLogin" runat="server"></asp:TextBox>
        <br />
        <br />
        Senha:
        <asp:TextBox ID="txtSenha" runat="server"></asp:TextBox>
&nbsp;<asp:Button ID="btnOK" runat="server" Text="OK" OnClick="btnOK_Click" />
        <br />
        <br />
        <asp:Label ID="lblErro" runat="server" Text=""></asp:Label>
        <br />
    
    </div>
        <asp:SqlDataSource ID="SqlLogin" runat="server" ConnectionString="<%$ ConnectionStrings:prova_1ConnectionString %>" ProviderName="<%$ ConnectionStrings:prova_1ConnectionString.ProviderName %>" SelectCommand="SELECT id_usu, login_usu, senha_usu FROM usuario WHERE (login_usu = @LOGIN) AND (senha_usu = @SENHA)">
            <SelectParameters>
                <asp:Parameter Name="LOGIN" />
                <asp:Parameter Name="SENHA" />
            </SelectParameters>
        </asp:SqlDataSource>
    </form>
</body>
</html>
