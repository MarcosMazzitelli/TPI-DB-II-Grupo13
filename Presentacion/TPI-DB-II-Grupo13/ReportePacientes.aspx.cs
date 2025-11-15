using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TPI_DB_II_Grupo13
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarGrilla();
            }
        }

        private void CargarGrilla()
        {
            AccesoDatos datos = new AccesoDatos(); // Usamos tu clase
            try
            {
                datos.setearConsulta("SELECT * FROM V_Pacientes_Reporte");
                datos.ejecutarLectura();
                
                DataTable dt = new DataTable();
                dt.Load(datos.Lector);

                GridViewReportePacientes.DataSource = dt;
                GridViewReportePacientes.DataBind();
            }
            catch (Exception)
            {
                throw;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        protected void GridViewReportePacientes_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridViewReportePacientes.PageIndex = e.NewPageIndex;
            CargarGrilla();
        }

        protected void GridViewReportePacientes_SelectedIndexChanged(object sender, EventArgs e)
        {
            string idPaciente = GridViewReportePacientes.SelectedDataKey.Value.ToString();

            Response.Redirect("HistoriaClinica.aspx?idPaciente=" + idPaciente);

        }
    }
}