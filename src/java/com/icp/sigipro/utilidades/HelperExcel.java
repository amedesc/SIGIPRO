/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.icp.sigipro.utilidades;

import com.icp.sigipro.core.SIGIPROException;
import java.io.FileInputStream;
import java.io.IOException;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DataFormatter;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.util.CellReference;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

/**
 *
 * @author Boga
 */
public class HelperExcel {

    XSSFWorkbook archivo_excel;
    XSSFSheet hoja;
    final HelperVarios helper_varios = HelperVarios.getSingletonHelperVarios();

    public HelperExcel() {
    }

    public HelperExcel(String direccion_archivo) throws SIGIPROException {
        try {
            archivo_excel = new XSSFWorkbook(new FileInputStream(direccion_archivo));
            hoja = archivo_excel.getSheetAt(0);
        } catch (IOException ex) {
            ex.printStackTrace();
            throw new SIGIPROException("Error al obtener el archivo. Notifique al administrador del sistema.");
        }
    }

    public String obtenerCelda(String celda_por_buscar) {
        Cell celda = null;
        CellReference referencia = new CellReference(celda_por_buscar);
        Row fila = hoja.getRow(referencia.getRow());
        String retorno = "No se ingresó ningún valor en la celda " + celda_por_buscar;
        if (fila != null) {
            celda = fila.getCell(referencia.getCol());
        }
        if (celda != null) {
            String valor = "";
            if (!(celda.getCellType() == Cell.CELL_TYPE_FORMULA)) {
                DataFormatter df = new DataFormatter();
                valor = df.formatCellValue(celda);
            } else {
                int tipo = celda.getCachedFormulaResultType();
                if (tipo == Cell.CELL_TYPE_NUMERIC) {
                    Double valor_temporal = celda.getNumericCellValue();
                    valor = helper_varios.redondearDouble(valor_temporal, 4);
                } else if (tipo == Cell.CELL_TYPE_STRING) {
                    valor = celda.getStringCellValue();
                }
            }
            if (!valor.isEmpty()) {
                retorno = valor;
            }
        } else {
            retorno = "Celda no encontrada. Verifique que el análisis esté configurado de acuerdo con su machote.";
        }
        return retorno;
    }
}
