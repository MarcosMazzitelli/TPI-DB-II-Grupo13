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
    public partial class TurnosPacientes : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarGrilla();
                CargarDDLS();
            }
        }

        private void CargarGrilla()
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("SELECT * FROM V_Pacientes_Turnos ORDER BY FechaYHora DESC");
                datos.ejecutarLectura();

                DataTable dt = new DataTable();
                dt.Load(datos.Lector);

                GridViewTurnos.DataSource = dt;
                GridViewTurnos.DataBind();
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
        private void CargarDDLS()
        {


            // --- TURNOS ---
            ddlMedicos_Turno.DataSource = ObtenerDeBD("SELECT IdMedico, 'DNI: ' + Documento + ' - ' + Nombre + ' ' + Apellido AS Medico FROM Medicos ORDER BY Documento ASC");
            ddlMedicos_Turno.DataTextField = "Medico";
            ddlMedicos_Turno.DataValueField = "IdMedico";
            ddlMedicos_Turno.DataBind();

            ddlEspecialidad_Turno.DataSource = ObtenerDeBD("SELECT * FROM Especialidades ORDER BY Descripcion ASC");
            ddlEspecialidad_Turno.DataTextField = "Descripcion";
            ddlEspecialidad_Turno.DataValueField = "IdEspecialidad";
            ddlEspecialidad_Turno.DataBind();

            ddlPacientes_Turno.DataSource = ObtenerDeBD("SELECT IdPaciente, 'DNI: ' + Documento + ' - ' + Nombre + ' ' + Apellido AS Paciente FROM Pacientes ORDER BY Documento ASC");
            ddlPacientes_Turno.DataTextField = "Paciente";
            ddlPacientes_Turno.DataValueField = "IdPaciente";
            ddlPacientes_Turno.DataBind();

            ddlTipoTurno_Turno.DataSource = ObtenerDeBD("SELECT * FROM TiposTurno ORDER BY IdTipoTurno ASC");
            ddlTipoTurno_Turno.DataTextField = "Tipo";
            ddlTipoTurno_Turno.DataValueField = "IdTipoTurno";
            ddlTipoTurno_Turno.DataBind();
            //falta fecha y hora y sobreturnos
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

        protected void btnAgregar_Turno_Click(object sender, EventArgs e)
        {
            try
            {
                lblRegistroCorrecto.Visible = false;
                lblErrorSQL_Turnos.Visible = false;

                int idPaciente = int.Parse(ddlPacientes_Turno.SelectedValue);
                int idMedico = int.Parse(ddlMedicos_Turno.SelectedValue);
                int idEspecialidad = int.Parse(ddlEspecialidad_Turno.SelectedValue);
                int idEspecialidadXMedico = buscarIdEspecialidadXMedico(idEspecialidad, idMedico);
                int idTipoTurno = int.Parse(ddlTipoTurno_Turno.SelectedValue);
                DateTime fecha = DateTime.ParseExact(
                    txtFecha_Turno.Text,
                    "yyyy-MM-ddTHH:mm",
                    System.Globalization.CultureInfo.InvariantCulture
                );
                string observaciones = txtObservaciones_Turno.Text;
                bool esSobreTurno = chkEsSobreTurno_Turno.Checked;
                agregarTurno(idPaciente, idEspecialidadXMedico, idTipoTurno, fecha, observaciones, esSobreTurno);

                lblRegistroCorrecto.Text = "Turno registrado correctamente.";
                lblRegistroCorrecto.Visible = true;

                CargarGrilla();

            }
            catch (SqlException ex)
            {
                lblErrorSQL_Turnos.Text = ex.Message;
                lblErrorSQL_Turnos.Visible = true;

            }
        }

        private int buscarIdEspecialidadXMedico(int idEspecialidad, int idMedico)
        {
            int idBuscado = -1;
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("SELECT IdEspecialidadXMedico FROM EspecialidadesXMedicos WHERE IdEspecialidad = @idEspecialidad AND IdMedico = @idMedico");
                datos.setearParametro("@idEspecialidad", idEspecialidad);
                datos.setearParametro("@idMedico", idMedico);
                datos.ejecutarLectura();

                if (datos.Lector.Read())
                {
                    idBuscado = (int)datos.Lector["IdEspecialidadXMedico"];
                }
                return idBuscado;


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
        private void agregarTurno(int idPaciente, int idEspecialidadXMedico, int idTipoTurno, DateTime fecha, string observaciones, bool esSobreTurno)
        {
            AccesoDatos datos = new AccesoDatos();
            datos.setearSP("SP_Registrar_Turno");
            datos.setearParametro("@IdPaciente", idPaciente);
            datos.setearParametro("@IdEspecialidadXMedico", idEspecialidadXMedico);
            datos.setearParametro("@IdTipoTurno", idTipoTurno);
            datos.setearParametro("@Fecha", fecha);
            datos.setearParametro("@Observaciones", observaciones);
            datos.setearParametro("@EsSobreTurno", esSobreTurno);
            datos.ejecutarAccion();

        }

        protected void GridViewTurnos_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridViewTurnos.PageIndex = e.NewPageIndex;
            CargarGrilla();
        }

        protected void GridViewTurnos_SelectedIndexChanged(object sender, EventArgs e)
        {
            AccesoDatos datos = new AccesoDatos();
            int idTurno = int.Parse(GridViewTurnos.SelectedDataKey.Value.ToString());
            try
            {
                datos.setearConsulta("UPDATE Turnos SET IdEstado = (Select IdEstado FROM Estados WHERE Descripcion = 'Cancelado') WHERE IdTurno = @idTurno;");
                datos.setearParametro("@idTurno", idTurno);
                datos.ejecutarAccion();
                CargarGrilla();
                lblRegistroCorrecto.Text = "Estado de turno cancelado correctamente.";
                lblRegistroCorrecto.Visible = true;
                lblErrorSQL_Turnos.Visible = false;
            }
            catch (SqlException ex)
            {
                lblErrorSQL_Turnos.Text = ex.Message;
                lblErrorSQL_Turnos.Visible = true;
                lblRegistroCorrecto.Visible = false;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
    }
}