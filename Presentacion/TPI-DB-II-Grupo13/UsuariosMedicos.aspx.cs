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

     /*   protected void GridViewMedicosConEstado_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                int idMedico = int.Parse(GridViewMedicosConEstado.SelectedDataKey.Value.ToString());
                inactivarMedico(idMedico);
                CargarGrilla();
            }
            catch
            {
                throw;
            }
        }*/

        protected void inactivarMedico(int IdMedico)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("DELETE FROM Medicos WHERE IdMedico = @IdMedico");
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
        protected void activarMedico(int IdMedico)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("UPDATE U SET Activo = 1 FROM Usuarios U INNER JOIN Medicos M ON U.IdUsuario = M.IdUsuario WHERE M.IdMedico = @IdMedico");
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

        protected void GridViewMedicosConEstado_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int idMedico = Convert.ToInt32(e.CommandArgument);
            if (e.CommandName == "Activar")
            {
                activarMedico(idMedico);
            }
            else if (e.CommandName == "Inactivar")
            {
                inactivarMedico(idMedico);
            }
            CargarGrilla();
        }

        protected void GridViewMedicosConEstado_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {

                bool activo = Convert.ToBoolean(DataBinder.Eval(e.Row.DataItem, "EstadoUsuario"));

                LinkButton btnActivar = (LinkButton)e.Row.FindControl("btnActivar");
                LinkButton btnInactivar = (LinkButton)e.Row.FindControl("btnInactivar");

                if (activo)
                {
                    btnActivar.Visible = false;
                    btnInactivar.Visible = true;
                }
                else
                {
                    btnActivar.Visible = true;
                    btnInactivar.Visible = false;
                }
            }

        }
    }
}