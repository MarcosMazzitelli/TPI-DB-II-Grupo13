using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TPI_DB_II_Grupo13
{
    public partial class WebForm2 : System.Web.UI.Page
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
                // Usamos la VISTA para leer los datos
                datos.setearConsulta("SELECT * FROM V_Medicos_ConEstado");
                datos.ejecutarLectura();

                DataTable dt = new DataTable();
                dt.Load(datos.Lector);

                GridViewMedicosConEstado.DataSource = dt;
                GridViewMedicosConEstado.DataBind();
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
        protected void GridViewMedicosConEstado_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridViewMedicosConEstado.PageIndex = e.NewPageIndex;
            CargarGrilla();
        }

        protected void GridViewMedicosConEstado_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                int idMedico = int.Parse(GridViewMedicosConEstado.SelectedDataKey.Value.ToString());
                inactivarMedico(idMedico);
            }
            catch
            {
                throw;
            }
        }

        protected void inactivarMedico(int IdMedico)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta(@"UPDATE Usuarios SET Activo = 0 WHERE IdUsuario = (SELECT IdUsuario FROM Medicos WHERE IdMedico = @IdMedico)");
                datos.setearParametro("@IdMedico", IdMedico);
                datos.ejecutarAccion();
            }
            catch (SqlException ex)
            {
                lblErrorSQL.Text = ex.Message;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
    }
}