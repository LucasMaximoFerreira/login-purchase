using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
public partial class _Default : System.Web.UI.Page 
{
    Criptografia cripto = new Criptografia("ETEP");
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnOK_Click(object sender, EventArgs e)
    {
        DataView lg;

        SqlLogin.SelectParameters["LOGIN"].DefaultValue = cripto.Encrypt(txtLogin.Text);
        SqlLogin.SelectParameters["SENHA"].DefaultValue = cripto.Encrypt(txtSenha.Text);

        lg = (DataView)SqlLogin.Select(DataSourceSelectArguments.Empty);

        if(lg.Table.Rows.Count == 0)
        {
            Response.Redirect("Default.aspx");
            lblErro.Text = "Usuário nao cadastrado";

        }else{
            Session["logado"] = "OK";
            Response.Redirect("telaCompras.aspx");
        }

    }
}