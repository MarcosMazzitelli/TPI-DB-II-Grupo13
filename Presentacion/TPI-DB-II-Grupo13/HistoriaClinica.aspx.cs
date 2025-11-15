using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TPI_DB_II_Grupo13
{
    public partial class HistoriaClinica : System.Web.UI.Page
    {
        private int idPaciente;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["idPaciente"] != null)
            {
                idPaciente = int.Parse(Request.QueryString["idPaciente"]);
            }
            else
            {
                Response.Redirect("Error.aspx");
                return;
            }

            if (!IsPostBack)
            {
                CargarDatosPaciente(idPaciente);
            }        
        }

        private void CargarDatosPaciente(int idPaciente)
        {
            AccesoDatos datos = new AccesoDatos();
            DataTable dt = new DataTable();

            try
            {
                datos.setearSP("SP_Reporte_Historia_Paciente");
                datos.setearParametro("@IdPaciente", idPaciente);
                datos.ejecutarLectura();

                if (datos.Lector.Read())
                {
                    lblNombrePaciente.Text = (string)datos.Lector["NombrePaciente"] + " " + (string)datos.Lector["ApellidoPaciente"];
                    lblDni.Text = (string)datos.Lector["Documento"];
                    lblFechaNacimiento.Text = ((DateTime)datos.Lector["FechaNacimiento"]).ToString("dd/MM/yyyy");

                    dt.Load(datos.Lector);
                    repeaterHC.DataSource = dt;
                    repeaterHC.DataBind();
                }
                else
                {
                    lblNombrePaciente.Text = "Paciente sin historial clínico";
                }
            }
            catch (Exception ex)
            {
                // Manejar error de carga
                lblNombrePaciente.Text = "Error al cargar historial: " + ex.Message;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
    }
}