<%-- 
    Document   : tabla_registros
    Created on : 15-oct-2024, 18:04:55
    Author     : rendo
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="Model.Inscripcion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
        <title>JSP Page</title>
        <script>
            function eliminarIns(idEstudiante, idCurso) {
                console.log(`eliminarIns?idEstudiante=` + idEstudiante + `&idCurso=` + idCurso);
                if (confirm("¿Estás seguro de que quieres eliminar esta inscripción?")) {
                    fetch(`${pageContext.request.contextPath}/registroServlet?idEstudiante=` + idEstudiante + `&idCurso=` + idCurso, {
                        method: 'delete'
                    }).then(response => {
                        if (response.ok) {
                            alert('Inscripción eliminada exitosamente');
                            location.reload();
                        } else {
                            alert('Error al eliminar inscripción');
                        }
                    }).catch(error => console.error('Error:', error));
                }
            }

        </script>
    </head>
    <body>
        <div class="container" style="margin-top: 20px">
            <a class="btn btn-outline-secondary"  href="${pageContext.request.contextPath}/registroServlet?action=loadIds"
               role="button" style="margin-bottom: 15px">Agregar Inscripción</a>
            <div class="table-responsive">
                <table class="table table-bordered table-striped table-hover" >
                    <thead>
                        <tr>
                            <th scope="col">Id Estudiante</th>
                            <th scope="col">Id Curso</th>
                            <th scope="col">Fecha de Inscripción</th>
                            <th scope="col" >Acciones</th>
                        </tr>
                    </thead>
                    <tbody >
                        <%
                            ArrayList<Inscripcion> listaCursos = (ArrayList<Inscripcion>) request.getAttribute("cursos");

                            if (listaCursos != null && !listaCursos.isEmpty()) {
                                for (Inscripcion est : listaCursos) {
                        %>
                        <tr>
                            <th scope="row"><%= est.getId_estudiante()%></th>
                            <th ><%= est.getId_curso()%></th>
                            <td><%= est.getFecha()%></td>
                            <td >
                                <button type="button " class="btn btn-outline-danger"  onclick="eliminarIns(<%= est.getId_estudiante()%>, <%= est.getId_curso()%>)">
                                    <i class="bi bi-trash3-fill"></i>
                                </button>
                            </td>
                        </tr>
                        <%
                            }
                        } else {
                        %>
                        <tr>
                            <td colspan="4">No hay inscripciones registradas.</td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>  
            <a class="btn btn-outline-primary"  href="${pageContext.request.contextPath}">
                <i class="bi bi-house-door"></i>
            </a>
        </div>
    </body>
</html>