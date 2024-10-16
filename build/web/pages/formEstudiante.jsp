<%-- 
    Document   : form
    Created on : 02-oct-2024, 20:30:46
    Author     : rendo
--%>

<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String mensaje = (String) request.getAttribute("mensaje");
%>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Registro de Estudiante</title>
        <script>
            // Verifica si hay un mensaje y muestra la alerta
            <% if (mensaje != null) {%>
            alert("<%= mensaje%>");
            <% }%>
        </script>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                margin: 0;
                padding: 20px;
            }
            .form-container {
                padding: 20px;
                display: flex;
                flex-direction: column ;
                width: 400px;
                margin: 0 auto;
                background: #fff;

                border-radius: 8px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            }

            h1 {
                text-align: center;
                color: #333;
            }
            label {
                display: block;
                margin: 10px 0 5px;
                color: #555;
            }
            input[type="text"],
            input[type="number"],
            input[type="datetime-local"],
            select {
                width: 100%;
                padding: 10px;
                margin-bottom: 15px;
                border: 1px solid #ccc;
                border-radius: 4px;
                box-sizing: border-box;
            }
            input[type="submit"] {
                background-color: #28a745;
                color: white;
                padding: 10px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                width: 100%;
            }
            input[type="submit"]:hover {
                background-color: #218838;
            }
        </style>
    </head>
    <body>
        <div class="form-container">
            <h1>Registro de Estudiante</h1>
            <form method="post" action="${pageContext.request.contextPath}/estudianteServlet">
                <label for="id">ID:</label>
                <input type="number" name="id" id="id" required>

                <label for="nombre">Nombre:</label>
                <input type="text" name="nombre" id="nombre" required>

                <label for="semestre">Semestre:</label>
                <input type="number" name="semestre" id="semestre" required>

                <label for="carrera">Carrera:</label>
                <select id="carrera" name="carrera" required>
                    <option value="Civil">Civil</option>
                    <option value="Gastronomia">Gastronomia</option>
                    <option value="Software">Software</option>
                    <option value="Contaduria">Contaduria</option>
                    <option value="Contaduria">Ambiental</option>
                </select>

                <input type="submit" value="Confirmar">
            </form>
        </div>
    </body>
</html>
