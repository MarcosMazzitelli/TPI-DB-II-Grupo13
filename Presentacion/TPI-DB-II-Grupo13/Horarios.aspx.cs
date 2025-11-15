using Bogus.DataSets;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TPI_DB_II_Grupo13
{
    public partial class Horarios : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarGrilla();

                ddlMedico.DataSource = ObtenerDeBD("SELECT IdMedico, 'DNI: ' + Documento + ' - ' + Nombre + ' ' + Apellido AS Medico FROM Medicos ORDER BY Documento ASC");
                ddlMedico.DataTextField = "Medico";
                ddlMedico.DataValueField = "IdMedico";
                ddlMedico.DataBind();

                ddlEspecialidad.DataSource = ObtenerDeBD("SELECT * FROM Especialidades ORDER BY Descripcion ASC");
                ddlEspecialidad.DataTextField = "Descripcion";
                ddlEspecialidad.DataValueField = "IdEspecialidad";
                ddlEspecialidad.DataBind();

                ddlTipoTurno.DataSource = ObtenerDeBD("SELECT * FROM TiposTurno ORDER BY IdTipoTurno ASC");
                ddlTipoTurno.DataTextField = "Tipo";
                ddlTipoTurno.DataValueField = "IdTipoTurno";
                ddlTipoTurno.DataBind();

                ddlDia.DataSource = ObtenerDeBD("SELECT * FROM DiasSemana ORDER BY IdDiaSemana ASC");
                ddlDia.DataTextField = "Dia";
                ddlDia.DataValueField = "IdDiaSemana";
                ddlDia.DataBind();
            }
        }

        private void CargarGrilla()
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("SELECT * FROM V_Horarios_Detallados ORDER BY IdDiaSemana ASC, HoraEntrada ASC");
                datos.ejecutarLectura();

                DataTable dt = new DataTable();
                dt.Load(datos.Lector);

                GridViewHorarios.DataSource = dt;
                GridViewHorarios.DataBind();
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

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            int idMedico = int.Parse(ddlMedico.SelectedItem.Value);
            int idEspecialidad = int.Parse(ddlEspecialidad.SelectedItem.Value);
            int idTipoTurno = int.Parse(ddlTipoTurno.SelectedItem.Value);
            int idDiaSemana = int.Parse(ddlDia.SelectedItem.Value);
            string horaEntrada = txtHoraEntrada.Text.Trim();
            string horaSalida = txtHoraSalida.Text.Trim();

            AgregarHorario(idMedico, idEspecialidad, idTipoTurno, idDiaSemana, horaEntrada, horaSalida);
        }

        protected void GridViewHorarios_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridViewHorarios.PageIndex = e.NewPageIndex;
            CargarGrilla();
        }
        private DataTable ObtenerDeBD(string query)
        {
            AccesoDatos datos = new AccesoDatos();
            DataTable dt = new DataTable();
            try
            {
                datos.setearConsulta(query);
                datos.ejecutarLectura();
                dt.Load(datos.Lector);
                return dt;
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

        private void AgregarHorario(int idMedico, int idEspecialidad, int idTipoTurno, int idDiaSemana, string horaEntrada, string horaSalida)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("EXEC SP_Agregar_Horarios_De_Medicos @idMedico, @idEspecialidad, @idTipoTurno, @idDiaSemana, @horaEntrada, @horaSalida");
                datos.setearParametro("@idMedico", idMedico);
                datos.setearParametro("@idEspecialidad", idEspecialidad);
                datos.setearParametro("@idTipoTurno", idTipoTurno);
                datos.setearParametro("@idDiaSemana", idDiaSemana);
                datos.setearParametro("@horaEntrada", horaEntrada);
                datos.setearParametro("@horaSalida", horaSalida);
                datos.ejecutarLectura();
                SqlDataReader response = datos.Lector;
                Response.Redirect("Horarios.aspx", false);
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