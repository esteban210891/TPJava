<%@page import="Controlador.Controlador_encar"%>
<%@page import="Modelo.Usuario"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-type" content="text/html; charset=utf-8" />
	<title>CompuCom.com</title>
	<link rel="stylesheet" href="css/jquery.bxslider.css" />
	<link rel="stylesheet" href="css/style.css" type="text/css" media="all" />
	<!--[if lte IE 6]>
		<style type="text/css" media="screen">
			.tabbed { height:420px; }
		</style>
	<![endif]-->
	<link rel="stylesheet" href="css/jquery.bxslider.css" type="text/css" media="all" />
	<script src="js/jquery-1.4.1.min.js" type="text/javascript"></script>
	<!--<script src="js/jquery.jcarousel.pack.js" type="text/javascript"></script>-->
	<!--<script src="js/jquery.slide.js" type="text/javascript"></script> -->
	<!--<script src="js/jquery-func.js" type="text/javascript"></script>-->
	<!--<script src="http://code.jquery.com/jquery-latest.js"></script>-->
	<script src="//code.jquery.com/jquery-1.10.2.js"></script>
    <script src="//code.jquery.com/ui/1.11.0/jquery-ui.js"></script>
    <script src="js/jquery.bxslider.js" type="text/javascript"></script>
    
	
</head>
<body>
<!-- Top -->
<div id="top">
	
	<div class="shell">
		
		<!-- Header -->
		<div id="header">
			<h1 id="logo"><a href="#"></a></h1>
			<div id="navigation">
				<ul id="sddm">
				<%if(session.getAttribute("username")!= null)
					{
					
					
					if(session.getAttribute("EsAdmin").equals(1) && session.getAttribute("bandera").equals(1))
					{response.sendRedirect("MasterMenu.jsp");}
				%>
					<%if(session.getAttribute("EsAdmin").equals(1)) { %><li><a href="MasterMenu.jsp">
					Hola <%=session.getAttribute("username")%></a></li><%}else{ %><li><a href="EdicionUsuario.jsp">
					Hola <%=session.getAttribute("username")%></a></li><%} %>
					<li><a href="CerrarSesion.jsp">Cerrar Sesion</a></li>
				  	<%} %>
				   
				    <%if(session.getAttribute("username")== null)
					{%>
					
					 <li><a href="Login.jsp">Ingresar</a></li>
				   	 <li><a href="Registro.jsp">Registrarme</a></li>
				   <%}%>
				     <li class="last"><a href="Index.jsp">Home</a></li>
				</ul>
						
			
				<div style="clear:both"></div>
			</div>
		</div>
		<!-- End Header -->
	
		<div id="slider">
			<div id="slider-holder">
				<ul>
				    <li><a href="#"><img src="css/images/nvidiaGrande.jpg" alt="" /></a></li>
				    <li><a href="#"><img src="css/images/slide2.jpg" alt="" /></a></li>
				    <li><a href="#"><img src="css/images/tab.gif" alt="" /></a></li>
				</ul>
			</div>
			<div id="slider-nav">
				<a href="#" class="prev">Previous</a>
				<a href="#" class="next">Next</a>
			</div>
		</div>
		<!-- <End Slider -->
		
	</div>
</div>
<!-- Top -->

<!-- Main -->
<div id="main">
	<div class="shell">
		
		<!-- Search, etc -->
		<div class="options">
			<div class="search">
				<form id="form1">
					<span class="field"><input type="text" class="blink" value="SEARCH" title="SEARCH" id="buscar"/></span>
					<input type="text" class="search-submit" value="" id="submit"/>
				</form>
			</div>
			
			
			<div class="right">
			<%if (session.getAttribute("dni")!=null &&session.getAttribute("dni")!=""){ 
				
				if (session.getAttribute("EsAdmin")!=null &&session.getAttribute("EsAdmin").equals(0)){ 
			session.setAttribute("modificarProducto",null);
			%>
				<span class="cart">
					<a href="MiCarrito2.jsp" class="cart-ico">&nbsp;</a>
					
					<strong><label id="ContadorProductosEnCarrito"></label></strong>
					<strong>$<label id="AcumuladorCosto"></label></strong>
				</span>
				<script language="javascript">
				$(document).ready(function() {
				sumarCostoAcumulado();
				contarProductosEnCarro();
				});
			
				</script>
			
				<%}
				}%>
			</div>
		</div>
		<!-- End Search, etc -->
		
		<!-- Content -->
		<div id="content">
			
			<!-- Tabs -->
			<div class="tabs">
				<ul id="tabs">
				    <li><a id="tab1" class="active" ><span>Fuentes</span></a></li>
				    <li><a id="tab2"><span>Gabinete</span></a></li>
				    <li><a id="tab3"><span>HDD</span></a></li>
				    <li><a id="tab4"><span>Memoria</span></a></li>
				    <li><a id="tab5"><span>Micro</span></a></li>
				    <li><a id="tab6"><span>Mother</span></a></li>
				    <li><a id="tab7"><span>Placa Video</span></a></li>
				    <li><a id="tab8"><span>Placa Red</span></a></li>
				    <li><a id="tab9"><span>Placa Sonido</span></a></li>
				    <li><a id="tab10"><span>Cable Red</span></a></li>
				    <li><a id="tab11"><span>Busqueda</span></a></li>
				</ul>
			</div>
			
<script type="text/javascript">
				
		$(document).ready(function() {
			debugger;
			 //$(".bxslider").bxSlider();
					$('#submit').click(function(event) {
						deselecionar();
						var buscarVar = $('#buscar').val();
						var nodo = document.getElementById("tab11");
						nodo.className = "active";
					      $.ajax({
							    type: "POST",
							    url: "Busqueda",
							    data: {'nombre':buscarVar},
							    success: function(a) {
						                $('#results').html(a);
							    },
							    error:function(e)
							    	{
							    	alert("Ha habido un error");
							    	}
						       });
					});
				});			
				
			      $.ajax({
					    type: "POST",
					    url: "Fuentes",
					    success: function(a) {
				                $('#results').html(a);
					    }
				       });
			      
			      function deselecionar()
			      {
			    	  	var nodo1 = document.getElementById("tab1");
			    	  	nodo1.classList.remove("active");
						var nodo2 = document.getElementById("tab2");
						nodo2.classList.remove("active");
						var nodo3 = document.getElementById("tab3");
						nodo3.classList.remove("active");
						var nodo4 = document.getElementById("tab4");
						nodo4.classList.remove("active");
						var nodo5 = document.getElementById("tab5");
						nodo5.classList.remove("active");
						var nodo6 = document.getElementById("tab6");
						nodo6.classList.remove("active");
						var nodo7 = document.getElementById("tab7");
						nodo7.classList.remove("active");
						var nodo8 = document.getElementById("tab8");
						nodo8.classList.remove("active");
						var nodo9 = document.getElementById("tab9");
						nodo9.classList.remove("active");
						var nodo10 = document.getElementById("tab10");
						nodo10.classList.remove("active");
						var nodo11 = document.getElementById("tab11");
						nodo11.classList.remove("active");
			      };
			      
					$(document).ready(function() {
							   $('#tab1').click(function(){
							   deselecionar();
								var nodo = document.getElementById("tab1");
								nodo.className = "active";
						      $.ajax({
							    type: "POST",
							    url: "Fuentes",
							    success: function(a) {
						                $('#results').html(a);
							    },
							    error:function(e)
						    	{
						    	alert("Ha habido un error");
						    	}					       
						       });
						   });
						});	
			      
					$(document).ready(function() {
					   $('#tab2').click(function(){
						   deselecionar();
							var nodo = document.getElementById("tab2");
							nodo.className = "active";
					      $.ajax({
						    type: "POST",
						    url: "Gabinetes",
						    success: function(a) {
					                $('#results').html(a);
						    },
						    error:function(e)
					    	{
						    	debugger;
					    	alert("Ha habido un error: "+e.statusText);
					    	}					       
					      
					       });
					   });
					});		
					
					$(document).ready(function() {
						   $('#tab3').click(function(){
							   deselecionar();
								var nodo = document.getElementById("tab3");
								nodo.className = "active";
						      $.ajax({
							    type: "POST",
							    url: "HD",
							    success: function(a) {
						                $('#results').html(a);
							    }
						       });
						   });
						});	
					
					$(document).ready(function() {
						   $('#tab4').click(function(){
							   deselecionar();
								var nodo = document.getElementById("tab4");
								nodo.className = "active";
						      $.ajax({
							    type: "POST",
							    url: "Memorias",
							    success: function(a) {
						                $('#results').html(a);
							    }
						       });
						   });
						});	

					$(document).ready(function() {
						   $('#tab5').click(function(){
							   deselecionar();
								var nodo = document.getElementById("tab5");
								nodo.className = "active";
						      $.ajax({
							    type: "POST",
							    url: "Micros",
							    success: function(a) {
						                $('#results').html(a);
							    }
						       });
						   });
						});	
					
					$(document).ready(function() {
						   $('#tab6').click(function(){
							   deselecionar();
								var nodo = document.getElementById("tab6");
								nodo.className = "active";
						      $.ajax({
							    type: "POST",
							    url: "PlacasMadres",
							    success: function(a) {
						                $('#results').html(a);
							    }
						       });
						   });
						});	
					
					$(document).ready(function() {
						   $('#tab7').click(function(){
							   deselecionar();
								var nodo = document.getElementById("tab7");
								nodo.className = "active";
						      $.ajax({
							    type: "POST",
							    url: "PlacaVideo",
							    success: function(a) {
						                $('#results').html(a);
							    }
						       });
						   });
						});		
					$(document).ready(function() {
						   $('#tab8').click(function(){
							   deselecionar();
								var nodo = document.getElementById("tab8");
								nodo.className = "active";
						      $.ajax({
							    type: "POST",
							    url: "PlacaRed",
							    success: function(a) {
						                $('#results').html(a);
							    }
						       });
						   });
						});	
					
					$(document).ready(function() {
						   $('#tab9').click(function(){
							   deselecionar();
								var nodo = document.getElementById("tab9");
								nodo.className = "active";
						      $.ajax({
							    type: "POST",
							    url: "PlacaSonido",
							    success: function(a) {
						                $('#results').html(a);
							    }
						       });
						   });
						});	
					
					$(document).ready(function() {
						   $('#tab10').click(function(){
							   deselecionar();
								var nodo = document.getElementById("tab10");
								nodo.className = "active";
						      $.ajax({
							    type: "POST",
							    url: "RedCable",
							    success: function(a) {
						                $('#results').html(a);
							    }
						       });
						   });
						});	
					
					function agregar(cod)
				      {
						debugger;
					
						      $.ajax({
						    	type: "POST",
						        url: "AgregaCarros",
							    data: {'cod':cod},
							    success: function(a) {
							    	 debugger;
						                $('#results').html(a);						                
						                sumarCostoAcumulado();
						                contarProductosEnCarro();						              
							    },
							    error: function (xhr, ajaxOptions, thrownError) {
							       
							        alert("Problema al agregar un producto al carro");
							        }
				      });
				      }
					function quitar(cod)
				      {
						debugger;
					
						      $.ajax({
						    	type: "POST",
						        url: "QuitarDelCarrito",
							    data: {'cod':cod},
							    success: function(a) {
							    	 debugger;
						                $('#results').html(a);
						              
						                sumarCostoAcumulado();
						               contarProductosEnCarro();
						       
							    },
							    error: function (xhr, ajaxOptions, thrownError) {
							       
							        alert(thrownError);
							        }
				      });
				      }
					
					
					function contarProductosEnCarro()
					{
						debugger;
					      $.ajax({
					    	type: "POST",
					        url: "ContarProductosEnCarro",
						    
						    success: function(a) {
						    	debugger;
					                $('#ContadorProductosEnCarrito').html(a);					                
					                
						    },
						    error: function (xhr, ajaxOptions, thrownError) {
							       
						        alert(thrownError);
						        }
					       });
					}
					function sumarCostoAcumulado()
					{
						debugger;
					      $.ajax({
					    	type: "POST",
					        url: "CalculaSumaParcial",
						    
						    success: function(a) {
						    	debugger;
					                $('#AcumuladorCosto').html(a);
					                
					                
						    },
						    error: function (xhr, ajaxOptions, thrownError) {
							       
						        alert(thrownError);
						        }
					       });
					}
				</script> 
			<!-- Tabs -->
			
			<!-- Container -->
			<div id="container">
			<input type="hidden" name="logueado" id="logueado" value="false" ></input>
				
				<div class="tabbed">
					
					<!-- First Tab Content -->
					
					<div class="tab-content" style="display:block;">
						 <div class="items">
							<div class="cl">&nbsp;</div>
													<ul id="results">
							    					</ul>
							<div class="cl">&nbsp;</div>
						</div>
					</div>
					
					
					
					
							  <!--   <li>
							    	<div class="image">
							    		<a href="#"><img src="css/images/image1.jpg" alt="" /></a>
							    	</div>
							    	<p>
							    		Item Number: <span>125515</span><br />
							    		Size List : <span>8/8.5/9.5/10/11</span><br />
							    		Brand Name: <a href="#">Adidas Shoes</a>
							    	</p>
							    	<p class="price">Wholesale Price: <strong>53 USD</strong></p>
							    </li>
							    </ul> -->


				</div>
				<!-- Brands -->
				<div class="brands">
					<h3>Brands</h3>
					<div class="logos">
						<a href="#"><img src="css/images/apple.jpg" alt="" /></a>
						<a href="#"><img src="css/images/intel.jpg" alt="" /></a>
						<a href="#"><img src="css/images/amdnvidia.jpg" alt="" /></a>
					</div>
				</div>
				<!-- End Brands -->
				
				<!-- Footer -->
				<div id="footer">
					<div class="left">
						<a href="#">Home</a>
						<span>|</span>
						<a href="#">Support</a>
						<span>|</span>
						<a href="#">My Account</a>
						<span>|</span>
						<a href="#">The Store</a>
						<span>|</span>
						<a href="#">Contact</a>
					</div>
					<div class="right">
						&copy; Sitename.com. Design by <a href="http://chocotemplates.com" target="_blank" title="CSS Templates">ChocoTemplates.com</a>
					</div>
				</div>
				<!-- End Footer -->
			
			</div>
			<!-- End Container -->
			
		</div>
		<!-- End Content -->
		
	</div>
</div>
<!-- End Main -->
	
</body>
</html>
