<%-- 
    Document   : tablaCursos
    Created on : 15-oct-2024, 15:36:34
    Author     : rendo
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="Model.Curso"%>
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
            function eliminarCurso(id) {
                console.log(`eliminarCurso?id=` + id);
                if (confirm("¿Estás seguro de que quieres eliminar este curso?")) {
                    fetch(`${pageContext.request.contextPath}/cursoServlet?id=` + id, {
                        method: 'delete'
                    }).then(response => {
                        if (response.ok) {
                            alert('Curso eliminado exitosamente');
                            location.reload();
                        } else {
                            alert('Error al eliminar curso');
                        }
                    }).catch(error => console.error('Error:', error));
                }
            }
        </script>
    </head>
    <body>
        <div class="container" style="margin-top: 20px">
            <a class="btn btn-outline-secondary"  href="${pageContext.request.contextPath}/pages/formCurso.jsp"
               role="button" style="margin-bottom: 15px">Agregar Curso</a>
            <div class="table-responsive">
                <table class="table table-bordered table-striped table-hover" >
                    <thead>
                        <tr>
                            <th scope="col">ID</th>
                            <th scope="col">Nombre</th>
                            <th scope="col">Descripción</th>
                            <th scope="col">Créditos</th>
                            <th scope="col" >Nivel</th>
                             <th scope="col" >Acciones</th>
                        </tr>
                    </thead>
                    <tbody >
                        <%
                            ArrayList<Curso> listaCursos = (ArrayList<Curso>) request.getAttribute("cursos");

                            if (listaCursos != null && !listaCursos.isEmpty()) {
                                for (Curso est : listaCursos) {
                        %>
                        <tr>
                            <th scope="row"><%= est.getId()%></th>
                            <td><%= est.getNombre()%></td>
                            <td><%= est.getDescripcion()%></td>
                            <td><%= est.getCreditos()%></td>
                            <td><%= est.getNivel()%></td>
                            <td >
                                <button type="button " class="btn btn-outline-danger"  onclick="eliminarCurso(<%= est.getId()  %>)">
                                    <i class="bi bi-trash3-fill"></i>
                                </button>
                            </td>
                        </tr>
                        <%
                            }
                        } else {    
                        %>
                        <tr>
                            <td colspan="6">No hay cursos registrados.</td>
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