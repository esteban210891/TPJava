package DB;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import Modelo.CarritoCompra;
import Modelo.Producto;

public class DBCarros extends DBAdapter
{
	public void GuardaCarro(CarritoCompra cc)
	{
		try
		{
		
		Statement st=conex.createStatement();
		for (int i=0;i<cc.getProductosCarro().size();i++)
		{
		st.execute("INSERT INTO carritos(dni,codigo) VALUES('"+cc.getDni()+","+cc.getProductosCarro().get(i).getCodigo()+"')");
		}
	} catch (SQLException t) 
		{
		
		t.printStackTrace();
	
		}	
	}
	
	public ArrayList<Integer> BuscaProductos(String dni)
	{
		ArrayList<Integer> codigos=new ArrayList<Integer>();
		int dnis=Integer.parseInt(dni);	
	try
	{
		
		Statement st=conex.createStatement();
		ResultSet rs=st.executeQuery("SELECT * FROM Carritos where dni=" + dnis);
		
		while(rs.next())
		{
			codigos.add(rs.getInt("codigo"));
		}
	}
		catch (SQLException t) 
	{
		
	t.printStackTrace();
	}
		return codigos;
}
	
	public void EliminaCarro(int codigo, String dni)
	{
		try
		{
		
		Statement st=conex.createStatement();
		st.execute("DELETE FROM carritos where dni='"+dni+"' and codigo='"+codigo+"'");
	} catch (SQLException t) 
		{
		
		t.printStackTrace();
	
		}	
	}
	
	public CarritoCompra BuscaCarro(int codigo, String dni)
	{
		CarritoCompra carro = new CarritoCompra();
		try
		{
		
		Statement st=conex.createStatement();
		ResultSet rs=st.executeQuery("SELECT * FROM carritos where dni=" + Integer.parseInt(dni)+"' OR codigo='"+codigo+"'");
		while(rs.next())
		{
			int dni2 = rs.getInt("dni");
			carro.setDni(String.valueOf(dni2));
			carro.setCodigo_carrito(rs.getInt("codigo"));
		
		}	
	} catch (SQLException t) 
		{
		
		t.printStackTrace();
	
		}
		return carro;
	}

	public CarritoCompra CreaCarro(String dni)
	{
		CarritoCompra carrito =  new CarritoCompra();
		try{
			
		if(!ExisteCarro(dni))
		{
			
		
PreparedStatement preparedStatement = conex.prepareStatement("insert into carritos(dni) values (?)",PreparedStatement.RETURN_GENERATED_KEYS);
preparedStatement.setInt(1,Integer.parseInt(dni));
preparedStatement.executeUpdate();

ResultSet tableKeys = preparedStatement.getGeneratedKeys();
tableKeys.next();


int autoGeneratedID = tableKeys.getInt(1);

carrito.setCodigo_carrito(autoGeneratedID);
carrito.setDni(dni.toString());


}
		
		}
		catch (SQLException sqle) 
{
sqle.printStackTrace();
}
return carrito;
}
		
	

public CarritoCompra BuscaCarro(String dni)
{
	
	CarritoCompra carro = new CarritoCompra();
	
	try
	{
		if(ExisteCarro(dni))
		{
	Statement st=conex.createStatement();														
	ResultSet rs=st.executeQuery("SELECT * FROM carritos c left join lineacarro lc on lc.codigo_carro = c.codigo where dni=" + Integer.parseInt(dni));
	
	carro = new CarritoCompra();
	
	if(rs.next())
	{
		int dni2= rs.getInt("dni");
		carro.setDni(String.valueOf(dni2));
		carro.setCodigo_carrito(rs.getInt("codigo"));
		
	}	
	rs.beforeFirst();
	DBProductos ProdDB = new DBProductos();
	ArrayList<Producto> arreglo = new ArrayList<Producto>();
	while(rs.next())
	{
		int codigpr=rs.getInt("codigo_producto");
		if(codigpr!=0)
		{
			
		int cod = rs.getInt("codigo_producto");
	    Producto pro=	ProdDB.buscaProducto(cod);
	    arreglo.add(pro);
		}
	}
	carro.setProductosCarro(arreglo);
		}
	} catch (SQLException t) 
	{
	
	t.printStackTrace();
	
	}
	return carro;
	
}

public boolean ExisteCarro(String dni)
{
	CarritoCompra carro = new CarritoCompra();
	Boolean res = true;
	try
	{
	
	Statement st=conex.createStatement();
	ResultSet rs=st.executeQuery("SELECT * FROM Carritos where dni=" + dni+"");

	int cont = 0;
		while(rs.next())
	{
		cont = cont + 1;
	
	}
	
if(cont ==0)
{
	res = false;
}
}

 catch (SQLException t) 
	{
	
	t.printStackTrace();
	
	}
	return res;
	
}
/*
public ArrayList<CarritoCompra> getAllCarritos(String modelo)
{
	Producto prod=null;
	try
	{
	Statement st=conex.createStatement();
	ResultSet rs=st.executeQuery("SELECT * FROM Productos");
	while(rs.next())
	{
	if(rs.getString("modelo").equals(modelo))
		{
		prod=new Producto();
		prod.setFoto(rs.getString("foto"));
		prod.setModelo(rs.getString("modelo"));
		prod.setNombre(rs.getString("nombre"));
		prod.setPrecio(rs.getFloat("precio"));
		prod.setTipo(rs.getString("tipo"));
		prod.setDescripcion(rs.getString("Descripcion"));

		}
	}
	
	return prod;
} catch (SQLException t) 
{
	
t.printStackTrace();
return prod;
}
}*/
}






