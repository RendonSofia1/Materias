/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Config.ConnectionBD;
import Model.Curso;
import Model.Estudiante;
import Model.Inscripcion;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author rendo
 */
@WebServlet(name = "registroServlet", urlPatterns = {"/registroServlet"})
public class registroServlet extends HttpServlet {

    Connection conn;
    PreparedStatement ps;
    Statement statement;
    ResultSet rs;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet registroServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet registroServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("Se ejecuta el doGet");
        String action = request.getParameter("action");

        if (action == null) {
            cargarRegistros(request, response);
        } else if (action.equals("loadIds")) {
            loadStudents(request, response);
            loadCursos(request, response);
            request.getRequestDispatcher("/pages/formRegistro.jsp").forward(request, response);
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        ConnectionBD conexion = new ConnectionBD();

        // Obtener los parámetros del formulario 
        String idEstStr = request.getParameter("id_est");
        String idCurStr = request.getParameter("id_cur");

        int id_est = Integer.parseInt(idEstStr);
        int id_cur = Integer.parseInt(idCurStr);

        try {
            // Crear la consulta SQL para insertar el usuario 
            String sql = "INSERT INTO inscripcion (id_estudiante, id_curso) VALUES (?, ?)";
            conn = conexion.getConnectionBD();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id_est);
            ps.setInt(2, id_cur);

            // Ejecutar la consulta 
            int filasInsertadas = ps.executeUpdate();
            if (filasInsertadas > 0) {
                // Si se insertó correctamente, mostrar los registros
                response.sendRedirect(request.getContextPath() + "/registroServlet");
            } else {
                // Si falló, redirigir a una página de error 
                request.setAttribute("mensaje", "Error al registrar.");
                request.getRequestDispatcher("/pages/formRegistro.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("mensaje", "Ocurrió un error: " + e.getMessage());
            request.getRequestDispatcher("/pages/formRegistro.jsp").forward(request, response);
        } finally {
            // Cerrar los recursos 
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

    }

    private void cargarRegistros(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ConnectionBD conexion = new ConnectionBD();
        List<Inscripcion> listaCursos = new ArrayList<>();
        String sql = "SELECT id_estudiante, id_curso, fecha_inscripcion FROM inscripcion";

        try {
            conn = conexion.getConnectionBD();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Inscripcion curso = new Inscripcion();
                curso.setId_estudiante(rs.getInt("id_estudiante"));
                curso.setId_curso(rs.getInt("id_curso"));
                curso.setFecha(rs.getTimestamp("fecha_inscripcion"));
                listaCursos.add(curso);
            }

            // Pasa la lista de usuarios al JSP
            request.setAttribute("cursos", listaCursos);
            request.getRequestDispatcher("/pages/tabla_registros.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al obtener los cursos" + e);
        } finally {
            // Close resources
            // Close resources
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    private void loadStudents(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ConnectionBD conexion = new ConnectionBD();
        List<Estudiante> listaIdsEstudiantes = new ArrayList<>();
        String sql = "SELECT id_estudiante, nombre FROM estudiante";

        try {
            conn = conexion.getConnectionBD();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Estudiante estudiante = new Estudiante();
                estudiante.setId(rs.getInt("id_estudiante"));
                estudiante.setNombre(rs.getString("nombre"));
                listaIdsEstudiantes.add(estudiante);
            }

            request.setAttribute("estudiantes", listaIdsEstudiantes);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al obtener los estudiantes" + e);
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    private void loadCursos(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ConnectionBD conexion = new ConnectionBD();
        List<Curso> listaIdsCursos = new ArrayList<>();
        String sql = "SELECT id_curso, nombre FROM curso";

        try {
            conn = conexion.getConnectionBD();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Curso curso = new Curso();
                curso.setId(rs.getInt("id_curso"));
                curso.setNombre(rs.getString("nombre"));
                System.out.println(curso.toString());
                listaIdsCursos.add(curso);
            }

            request.setAttribute("cursos", listaIdsCursos);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al obtener los cursos" + e);
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ConnectionBD conexion = new ConnectionBD();
        System.out.println("se ejecuta doDelete");

        String idEstudiante = request.getParameter("idEstudiante");
        String idCurso = request.getParameter("idCurso");

        String sql = "DELETE FROM inscripcion WHERE id_estudiante = ? AND id_curso = ?";

        try {
            conn = conexion.getConnectionBD();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, Integer.parseInt(idEstudiante));
            ps.setInt(2, Integer.parseInt(idCurso));

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                response.setStatus(HttpServletResponse.SC_OK); // Eliminar exitoso 
                System.out.println("se eliminó");
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND); // No se encontró el usuario 
                System.out.println("se ejecuta doDelete");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // Error del servidor 
        } finally {
            try {
                if (ps != null) {
                    ps.close();
                }
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
