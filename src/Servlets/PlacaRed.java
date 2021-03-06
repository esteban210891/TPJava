package Servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Controlador.Controlador_encar;
import Modelo.Fuente;
import Modelo.Memoria;
import Modelo.PRed;
import Modelo.Producto;

/**
 * Servlet implementation class PlacaRed
 */
@WebServlet("/PlacaRed")
public class PlacaRed extends Padre {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PlacaRed() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out=response.getWriter();
        Controlador_encar contr = getControlador();
        ArrayList<Producto> prod=contr.buscaProductos("PRED");
        ArrayList<Producto>prodsCarroActual = new ArrayList<Producto>();
        if(contr.getCarroCompleto()!=null){
        if(contr.getCarroCompleto().getProductosCarro()!=null)
        {     	
        prodsCarroActual = contr.getCarroCompleto().getProductosCarro();
        }
        }
        Boolean agregado;
        for(int i=0;i<prod.size();i++)
        {
        	agregado=false;
        	
        	for (int j=0;j< prodsCarroActual.size();j++)
        	{
				
				if(prod.get(i).getCodigo()==prodsCarroActual.get(j).getCodigo())
				{
					agregado=true;
				}
        	}
        PRed pro=(PRed)prod.get(i);
        out.println("<li>");
        out.println("<input name=\"Codigos\" id=\"Codigos\" value=\""+pro.getCodigo()+"\" type=\"hidden\" />");
        out.println(" <div class=\"image\">");

        out.println("<a href=\"#\">");
        out.println("<img src=\""+pro.getFoto()+"\">");     
        out.println("</a>"); 
        out.println("</div>");
        out.println("<p>");
        out.println("Nombre: <span>"+pro.getNombre()+"</span><br />");
        out.println("Descripcion: <span>"+pro.getDescripcion()+"</span><br />");
        out.println("Modelo: <span>"+pro.getModelo()+"</span><br />");       
        out.println("Velocidad: <span>"+pro.getVelocidad()+"</span><br />");    
        out.println(" </p>");   
        out.println("<p class=\"price\">Precio: <strong> $"+pro.getPrecio()+"</strong></p>");
        HttpSession sesion = request.getSession(false);
        if(sesion == null)
        {
        	sesion = request.getSession(true);
        }
        System.out.print(sesion.getAttribute("dni"));
        
       
     
        if(sesion.getAttribute("dni")!=null && sesion.getAttribute("dni")!="")
        	if(sesion.getAttribute("EsAdmin")!=null && sesion.getAttribute("EsAdmin").equals(0))
        	{
        {
        if(!agregado)
        {
        	 // out.println("<input type=\"button\" id=\"btnAgregar\" title=\"Agregar\" value=\"Agregar\" onclick=\"agregar("+pro.getCodigo()+")\" />");
    out.print("<img src=\"css/images/cart_add.png\" id=\"btnAgregar\" alt=\"\" onclick=\"agregar("+pro.getCodigo()+")\" />");
        				    
        }
        else
        {
     //   out.print("<input type=\"button\" id=\"btnQuitar\" title=\"Quitar\" value=\"Quitar\" onclick=\"quitar("+pro.getCodigo()+")\" />");
        out.print("<img src=\"css/images/cart_delete.png\" id=\"btnQuitar\" alt=\"\" onclick=\"quitar("+pro.getCodigo()+")\" />");
        
        }
        out.println("</li>");
        }
        }
        	else
        	{
        		if(sesion.getAttribute("modificarProducto")!=null && sesion.getAttribute("modificarProducto")=="eliminar")
        		{
        			 out.println("<input type=\"button\" id=\"btnEliminar\" title=\"Eliminar\" value=\"Eliminar\" onclick=\"eliminar("+pro.getCodigo()+")\" />");
                }
        		if(sesion.getAttribute("modificarProducto")!=null && sesion.getAttribute("modificarProducto")=="editar")
        		{
        			 out.println("<input type=\"button\" id=\"btnEditar\" title=\"Editar\" value=\"Editar\" onclick=\"editar("+pro.getCodigo()+")\" />");
                }
        	}
        }
	}	

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
