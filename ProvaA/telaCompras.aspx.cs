using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class telaCompras : System.Web.UI.Page
{
    Criptografia cripto = new Criptografia("ETEP");
    double total, preco, qtd, totalFinal;
    DataTable listaDescriptografada = new DataTable();
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnPesq_Click(object sender, EventArgs e)
    {
        DataView PesqProd;

        SqlPesq.SelectParameters["PROD"].DefaultValue = cripto.Encrypt(txtPesq.Text);

        PesqProd = (DataView)SqlPesq.Select(DataSourceSelectArguments.Empty);

        if (PesqProd.Table.Rows.Count > 0)
        {
            Session["idProd"] = PesqProd.Table.Rows[0]["id_prod"].ToString();
            lblNome.Text = cripto.Decrypt(PesqProd.Table.Rows[0]["nome_prod"].ToString());
            lblFabricante   .Text = cripto.Decrypt(PesqProd.Table.Rows[0]["fabricante_prod"].ToString());
            double preco;
            preco = Convert.ToDouble(cripto.Decrypt(PesqProd.Table.Rows[0]["preco_prod"].ToString()).Replace('.',','));
            lblPreco.Text = preco.ToString();

        }
        else
        {

        }
    }

    protected void btnCalTotal_Click(object sender, EventArgs e)
    {
        preco = Convert.ToDouble(lblPreco.Text.Replace('.', ','));
        qtd = Convert.ToInt32(txtQtd.Text);

        total = preco * qtd;

        lblTotal.Text = Convert.ToString(total);    
    }

    protected void btnComprar_Click(object sender, EventArgs e)
    {
        totalFinal = Convert.ToDouble(lblTotal.Text);

        SqlComprar.InsertParameters["TOTAL"].DefaultValue = cripto.Encrypt(totalFinal.ToString().Replace(',', '.'));
        SqlComprar.InsertParameters["QTD"].DefaultValue = cripto.Encrypt(txtQtd.Text);
        SqlComprar.Insert();
        lblComprar.Text = "Dados Cadastrados com sucesso";

        lblNome.Text = "";
        lblFabricante.Text = "";
        lblPreco.Text = "";
        txtQtd.Text = "";
        lblTotal.Text = "";
        txtPesq.Text = "";
        carregarGrid();

    }
    private void carregarGrid()
    {

        listaDescriptografada.Columns.Add("id_vendas", typeof(int));
        listaDescriptografada.Columns.Add("nome_prod", typeof(String));
        listaDescriptografada.Columns.Add("qtd", typeof(int));
        listaDescriptografada.Columns.Add("total", typeof(double));

        DataView listaVendas;
        listaVendas = (DataView)SqlTabelaVendas.Select(DataSourceSelectArguments.Empty);

        for (int i = 0; i < listaVendas.Table.Rows.Count; i++)
        {
            DataRow linha = listaDescriptografada.NewRow();

            linha["id_vendas"] = listaVendas.Table.Rows[i]["id_vendas"].ToString();
            linha["nome_prod"] = cripto.Decrypt(listaVendas.Table.Rows[i]["nome_prod"].ToString());
            linha["qtd"] = cripto.Decrypt(listaVendas.Table.Rows[i]["qtd"].ToString());
            linha["total"] = cripto.Decrypt(listaVendas.Table.Rows[i]["total"].ToString());

            listaDescriptografada.Rows.Add(linha);
        }
        gvExibir.DataSource = listaDescriptografada;
        gvExibir.DataBind();

        Session["listaDescriptografada"] = listaDescriptografada;


    }

}
