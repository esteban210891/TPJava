<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

	<link rel="stylesheet" href="css/style.css" type="text/css" media="all" />
	<link rel="stylesheet" href="css/Register.css" type="text/css" media="all" />
	<script src="js/jquery-1.4.1.min.js" type="text/javascript"></script>
	<script src="js/jquery.slide.js" type="text/javascript"></script>
	<script src="js/jquery-func.js" type="text/javascript"></script>
	<script src="http://code.jquery.com/jquery-latest.js"></script>
	<script src="//code.jquery.com/jquery-1.10.2.js"></script>
    <script src="//code.jquery.com/ui/1.11.0/jquery-ui.js"></script>
    
<title>Menu del Admin</title>
<script type="text/javascript">

//Funcion para validar DNI

</script>
</head>
<body>
    <!-- Top -->
		<div id="topAdmin">
	
	<div class="shell">
				<!-- Header -->
				<div id="header" style="color: #ff0000">
					<h1 id="logo"><a href="#"></a></h1>
					<div id="navigation">
				<ul id="sddm">
				<%if(session.getAttribute("username")!= null)
					{
					if(session.getAttribute("EsAdmin").equals(1) && session.getAttribute("bandera").equals(1))
					{response.sendRedirect("MasterMenu.jsp");}
				%>
					<li><a href="EdicionUsuario.jsp"> Hola <%=session.getAttribute("username")%></a></li>
					<li><a href="CerrarSesion.jsp">Cerrar Sesion</a></li>
				  	<%} %>
				   
				    <%if(session.getAttribute("username")== null)
					{%>
					
					 <li><a href="Login.jsp">Ingresar</a></li>
				   	 <li><a href="Registro.jsp">Registrarme</a></li>
				   <%}%>
				     <li class="last"><a href="#">Home</a></li>
				</ul>
						
			
				<div style="clear:both"></div>
			</div>
			    </div>
			    	</div>
</div>
       <div id="main" >
       <div class="shell">
       <div class="options" align="center"></div>
       	<div id="content">
		        	<% session.setAttribute("bandera",0);%>
		        			<form class="dark-matter texto-form" >
								<h1>Panel del Administrador</h1>
								<ul class="cssmenu">
									<li><a href="Index.jsp">Indice</a></li>
									<li><a href="Registro.jsp">Alta Usuario</a></li>
									<li><a href="EdicionUsuarioAdmin.jsp">Edicion Usuario</a></li>
									<li><a href="Altaproductos.jsp">Alta de productos</a></li>
									<li><a href="Modificaproductos.jsp">Edici�n de productos</a></li>
									<li><a href="Bajaproductos.jsp">Eliminar productos</a></li>
									<li><a href="CambiarEstadoCompra.jsp">Cambio Estado Compras</a></li>
									
								</ul> 
							</form>									        	
	        </div>
	    </div>
 	 </div>
</body>
</html>