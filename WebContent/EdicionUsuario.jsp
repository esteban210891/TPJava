<%@page import="java.io.Writer"%>
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

<title>Registro</title>
<script type="text/javascript">

//Funcion para validar DNI
function RecuperarUsuario(dni)
{  
	      $.ajax({
			    type: "POST",
			    dataType: "json",
			    url: "BusquedaUsuario",
			    data: {'dni':dni},
			    success: function (result){
			    $('#dni').val(result.dni);
			    $('#password').val(result.contrase�a);
			    $('#passwordconfirm').val(result.contrase�a);
			    $('#nombre').val(result.nombre);
			    $('#apellido').val(result.apellido);
			    $('#direccion').val(result.direccion);
			    $('#direnvios').val(result.direnvio);
			    $('#localidad').val(result.localidad);
			    $('#edad').val(result.edad);
			    $('#email').val(result.email);
			    },
	      });
}

//Funcion para validar EMAIL
function validarEmail( email ) 
{
expr = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;

if (expr.test(email))

	{
	return true;
	}
else
	{
    return false;
	}
}

//Funcion para controlar el largo del mensaje de error acumulado
function controlarLongitudError(error){
	var cont = 0;
	var errorTruncado = "";
	for(var i=0;i<error.length;i++)
	{
		if(error[i]=='<' && error[i+1]=='l' && error[i+2]=='i' && error[i+3]=='>')
		{
			cont++;
		}
	}
	if(cont>6){
		for(var i=0,cont=6;cont>0;i++){
				if(error[i]=='<' && error[i+1]=='l' && error[i+2]=='i' && error[i+3]=='>')
				{
					cont--;
				}
				errorTruncado=errorTruncado+error[i];
			}
		errorTruncado=errorTruncado+"/ul>";
		return errorTruncado;
	}
	else{
			return error;
		}

}

function isInteger(n) {
    return /^[0-9]+$/.test(n);
}

//Funcion para validar EDA
function validarEntero(valor)
{ 
     //intento convertir a entero. 
     //si era un entero no le afecta, si no lo era lo intenta convertir 
     return isInteger(valor);

     /*	//Compruebo si es un valor num�rico 
     	if (isNaN(valor)) 
		{ 
           	 //entonces (no es numero) devuelvo false 
           	 return false; 
     	}
		else{ 
           	 //En caso contrario (Si era un n�mero) devuelvo el valor 
           	 return true; 
     		}*/ 
}

function validarPass(pass)
{
	 $.ajax({
			type: "POST",
		    url: "Validador",
		    async: false,
		    data: {'pass':pass},
		    success: function (result){ $('#validacionPass').val(result);},
 });}

function validarEnvio(){ 
	$('#divMensaje').empty();
	var bandera=true;
	var error="<ul>";

	//valido longitud PASSWORD 
   	if ($('#password').val().trim().length<1)
   	{ 
      	error=error+"<li>Tiene que escribir su password</li>"; 
      	bandera=false; 
   	} else {
	  	var pass = $("#password").val().trim();
		validarPass(pass);
	   	var contra = $('#passValidacion').val();
		//Valido password
	  	if(contra == 'false')
	  		{
		  	 error=error+"<li>Debe ingresar una contrase�a sin caracteres especiales y de m�s de 6 caracteres</li>";
		  	 bandera=false;
	  		}
	  	else{
		  	if($("#password").val()!=$("#passwordconfirm").val())
			{
		  		error=error+"<li>La contrase�a y su confirmaci�n deben ser iguales</li>";
		  		bandera=false;
		  	}
	   	}
   	}
  	
  	//valido longitud PASSWORD CONFIRMATION
	if ($('#passwordconfirm').val().trim().length<1)
   	{ 
      	error=error+"<li>Tiene que escribir su confirmacion de password</li>"; 
      	bandera=false;
   	}
	//valido longitud NOMBRE
	if ($('#nombre').val().trim().length<1)
   	{ 
      	 error=error+"<li>Tiene que escribir su nombre</li>"; 
      	 bandera=false;; 
   	} 
	
	//valido longitud APELLIDO
	if ($('#apellido').val().trim().length<1)
   	{ 
      	error=error+"<li>Tiene que escribir su Apellido</li>"; 
      	bandera=false;
   	} 
	
	//valido longitus DIRECCION
	if ($('#direccion').val().trim().length<1)
   	{ 
      	 error=error+"<li>Tiene que escribir su Direccion</li>"; 
      	 bandera=false;
   	} 
	
	//valido longitud DIRECCION ENVIOS
	if ($('#direnvios').val().trim().length<1)
   	{ 
      	 error=error+"<li>Tiene que escribir su Direccion de envios</li>"; 
      	 bandera=false;
   	} 
	
	//valido longitud LOCALIDAD
	if ($('#localidad').val().trim().length<1)
   	{ 
      	 error=error+"<li>Tiene que escribir su Localidad</li>"; 
      	 bandera=false; 
   	} 
	
	//valido longitud EDAD
	var edad = $('#edad').val();
	if (edad<1)
   	{ 
      	 error=error+"<li>Tiene que escribir su Edad</li>"; 
      	 bandera=false; 
   	} 
	else{
	    //valido EDAD entero mayor de 18
	   	if($.isNumeric(edad))
	   		{
	    res = validarEntero(edad);
	   	if (!res)
	   	{ 
	       error=error+"<li>Tiene que introducir un n�mero entero en su edad</li>"; 
	       bandera=false; 
	   	}else
	   	{ 
	      	 if (edad<18){ 
	         	 error=error+"<li>Debe ser mayor de 18 a�os</li>"; 
	         	 bandera=false; 
	      	 } 
	  	}
	   		}
	   	else
	   		{
	   		error=error+"<li>Su edad es incorrecta</li>"; 
		       bandera=false; 
	   		}
   	}
	
	//valido longitud EMAIL
	var email=$('#email').val().trim();
	if (email.length<1)
   	{ 
      	 error=error+"<li>Tiene que escribir su email</li>"; 
      	 bandera=false; 
   	} else{
		//Valido el EMAIL
		if(!validarEmail(email))
			{
		     	 error=error+"<li>Tiene que escribir un email valido</li>"; 
		      	 bandera=false;
			}
   	}
   	
   	if(bandera == true)
   	{
   		return true;
   	}
   	else
	{
   		error=error+"</ul>";
   		var mensaje = controlarLongitudError(error);
   		$('#divMensaje').show();
   		$('#divMensaje').append(mensaje);
   		return false;
	}
}

<%if(!session.getAttribute("dni").equals(null))
{%>
	RecuperarUsuario(<%=session.getAttribute("dni")%>);
<%} %> 

</script>


</head>
    <body>
    <!-- Top -->
		
				<!-- Header -->
				<div id="topFormularios">
<div id="topAdmin">
		<div class="shell">
	
				<!-- Header -->
				<div id="header" style="color: #ff0000">
					<h1 id="logo"><a href="#"></a></h1>
					<div id="navigation">
				<ul id="sddm">
				<%if(session.getAttribute("username")!= null)
					{
				
					
				%>
					<li><a href="EdicionUsuario.jsp"> Hola <%=session.getAttribute("username")%></a></li>
					<li><a href="CerrarSesion.jsp">Cerrar Sesion</a></li>
					
					
				  	<%} 
				
				if(session.getAttribute("username")== null)
					{response.sendRedirect("Login.jsp");
					
					}
				if(session.getAttribute("EsAdmin").equals(1)){
					%>
					<li class="last"><a href="MasterMenu.jsp">Home</a></li>
				</ul>
				<%}
				else
				{%>
				<li class="last"><a href="Index.jsp">Home</a></li>
				</ul>
				<%} %>
			
				<div style="clear:both"></div>
			</div>
			    </div>
			    	</div>
</div>
</div>
       <div id="main" >
       <div class="shell">
       <div class="options"></div>
       	<div id="content">

		

			<form id="Registro" class="dark-matter texto-form" action="Usuarios" method="post" > 
		        	<h1>Modificacion Perfil<input id="validacionPass" style="display: none" /></h1>
		        	<p>
		        	<div class="error" style="display: none; background-image: none;" id="divMensaje"></div>
						<label style="display: none">
				        	<span>Dni: </span> <input type="text" id="dni" name="dni" >
						</label>
						<label>
				        	<span>Nueva Contrase�a: </span> <input type="password" id="password" name="password" value="">
						</label>
						<label>
				            <span>Confirmar Contrase�a: </span> <input type="password" name="passwordconfirm" id="passwordconfirm">
						</label>
						<label>
				            <span>Nombre: </span> <input type="text" name="nombre" id="nombre">
						</label>
						<label>
				            <span>Apellido: </span> <input type="text" name="apellido" id="apellido">
						</label>
						<label>
				            <span>Direcci�n: </span> <input type="text" name="direccion" id="direccion">
						</label>
						<label>
				            <span>Direcci�n de Envios: </span> <input name="direnvios" type="text" id="direnvios">
						</label>
						<label>
				            <span>Localidad: </span> <input type="text" name="localidad" id="localidad">
						</label>
						<label>
				            <span>Edad: </span> <input type="text" name="edad" id="edad">
						</label>
						<label>
				            <span>Mail: </span> <input type="text" id="email"  name="email">
				        </label>
				        <label>
				        <% String direccion;
				        if(session.getAttribute("EsAdmin").equals(1)){
				        	direccion= "EdicionUsuarioAdmin.jsp";
				        } else{
				        	direccion = "Index.jsp";
				        }
				        %>
				        	<span>&nbsp</span>
				        	<input type="button" value="Volver" onclick="location.href ='<%= direccion %>' "> 
				        	<input type="submit" onclick="return validarEnvio()" value="Guardar" >
				        	
				        </label>
				       </p> 
			     </form>
	        </div>
	    </div>
 	 </div>
</body>


</html>
