/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.icp.sigipro.bodegas.modelos;

import com.icp.sigipro.configuracion.modelos.Seccion;
import com.icp.sigipro.core.IModelo;
import java.lang.reflect.Field;
import org.json.JSONObject;



/**
 *
 * @author Amed
 */
public class Inventario extends IModelo{
  private int id_inventario;
  private int id_producto;
  private int id_seccion;
  private int stock_actual;
  
  private ProductoInterno producto;
  private Seccion seccion;
  
  public Inventario(){};
  
      //Parsea a JSON la clase de forma automatica y estandarizada para todas las clases
    public String parseJSON(){
        Class _class = this.getClass();
        JSONObject JSON = new JSONObject();
        try{
            Field properties[] = _class.getDeclaredFields();
            for (int i = 0; i < properties.length; i++) {
                Field field = properties[i];
                if (i != 0){
                    JSON.put(field.getName(), field.get(this));
                }else{
                    JSON.put("id_objeto", field.get(this));
                }
            }          
        }catch (Exception e){
            
        }
        return JSON.toString();
    }

  public void setId_inventario(int p){this.id_inventario = p;}
  public void setId_producto(int p){this.id_producto = p;}
  public void setId_seccion(int p){this.id_seccion = p;}
  public void setStock_actual(int p){this.stock_actual = p;}
  public int getId_inventario(){return id_inventario;}
  public int getId_producto(){return id_producto;}
  public int getId_seccion(){return id_seccion;}
  public int getStock_actual(){return stock_actual;}
  
  public void setProducto(ProductoInterno p){this.producto = p;}
  public void setSeccion(Seccion p){this.seccion = p;}
  
  public ProductoInterno getProducto(){return producto;}
  public Seccion getSeccion(){return seccion;}
  
}
