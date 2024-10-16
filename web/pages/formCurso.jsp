<%-- 
    Document   : formCurso
    Created on : 14-oct-2024, 21:31:42
    Author     : rendo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String mensaje = (String) request.getAttribute("mensaje");
%>
<!DOCTYPE html>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Registro Curso</title>
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
            <h1>Registro de Curso</h1>
            <form method="post" action="${pageContext.request.contextPath}/cursoServlet">
                <label for="id">ID:</label>
                <input type="number" name="id" id="id" required>
                
                <label for="nombre">Nombre:</label>
                <input type="text" name="nombre" id="nombre" required>

                <label for="descripcion">Descripción</label>
                <input type="text" name="descripcion" id="descripcion" required>
                
                <label for="creditos">Créditos</label>
                <input type="number" step="0.1" name="creditos" id="creditos" required>

                <label for="nivel">Nivel:</label>
                <select id="nivel" name="nivel" required>
                    <option value="Básico">Básico</option>
                    <option value="Intermedio">Intermedio</option>
                    <option value="Avanzado">Avanzado</option>
                </select>

                <input type="submit" value="Confirmar">
            </form>
        </div>
    </body>
</html>