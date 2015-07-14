contador = 1;
columnas = 1;
filas = 1;
function agregarCampo() {
    fila = "<div class=\"widget widget-table campo_" + contador + "\" id=\"" + contador + "\">";
    fila += "<input hidden=\"true\" id=\"elemento_" + contador + "\" value=\"campo\">";
    fila += "   <div class=\"widget-header\">";
    fila += "       <h3><i class=\"fa fa-edit\"></i> Campo #" + contador + "</h3>";
    fila += "       <div class=\"btn-group widget-header-toolbar\">";
    fila += '           <button type="button" id="boton_eliminar" class="btn btn-danger btn-sm eliminar" onclick="eliminarCampo(\'campo_' + contador + '\')" style="margin-left:7px;margin-right:5px;">Eliminar</button>';
    fila += "       </div>";
    fila += "   </div>";
    fila += "   <div class=\"widget-content\">";
    fila += "       <div class=\"col-md-6\">";
    fila += "           <label for=\"tipo\" class=\"control-label\"> *Tipo de Campo</label>";
    fila += "           <div class=\"form-group\">";
    fila += "               <div class=\"col-sm-12\">";
    fila += "                   <div class=\"input-group\">";
    fila += "                       <select id=\"tipocampo_" + contador + "\" class=\"select2\" name=\"c_tipocampo_" + contador + "\"";
    fila += "                           style=\'background-color: #fff;\' required";
    fila += "                           oninvalid=\"setCustomValidity(\'Este campo es requerido\')\"";
    fila += "                           onchange=\"setCustomValidity(\'\')\">";
    fila += "                           <option value=\'\'></option>";
    fila += "                           <option value=\"number\">Número</option>";
    fila += "                           <option value=\"text\">Campo de Texto</option>";
    fila += "                       </select>";
    fila += "                   </div>";
    fila += "               </div>";
    fila += "           </div>";
    fila += "           <label for=\"nombre\" class=\"control-label\">*Nombre del Campo</label>";
    fila += "           <div class=\"form-group\">";
    fila += "               <div class=\"col-sm-12\">";
    fila += "                   <div class=\"input-group\">";
    fila += "                       <input type=\"text\" maxlength=\"45\" placeholder=\"Nombre\" class=\"form-control\" name=\"c_nombre_" + contador + "\"";
    fila += "                           required";
    fila += "                           oninvalid=\"setCustomValidity(\'Este campo es requerido\')\"";
    fila += "                           oninput=\"setCustomValidity(\'\')\" > ";
    fila += "                   </div>";
    fila += "               </div>";
    fila += "           </div>";
    fila += "       </div>";
    fila += "       <div class=\"col-md-6\">";
    fila += "           <div class=\"col-sm-6\">";
    fila += "               <br>";
    fila += "               <div class=\"form-group\">";
    fila += "                   <div class=\"col-sm-12\">";
    fila += "                       <div class=\"input-group\">";
    fila += "                           <input id=\"manual_" + contador + "\" onchange=\"checkManual(this," + contador + ")\" type=\"checkbox\" name=\"c_manual_" + contador + "\" style=\"width:20px; height:20px;\"><span>  Automático</span>";
    fila += "                       </div>";
    fila += "                   </div>";
    fila += "               </div>";
    fila += "               <br>";
    fila += "               <div class=\"form-group\">";
    fila += "                   <div class=\"col-sm-12\">";
    fila += "                       <div class=\"input-group\">";
    fila += "                           <input id=\"visible_" + contador + "\" type=\"checkbox\" name=\"c_campovisible_" + contador + "\" style=\"width:20px; height:20px;\"><span>  Visible para Usuarios</span>";
    fila += "                       </div>";
    fila += "                   </div>";
    fila += "               </div>";
    fila += "           </div>";
    fila += "           <div class=\"col-sm-6\">";
    fila += "               <br>";
    fila += "               <div class=\"form-group\">";
    fila += "                   <div class=\"col-sm-12\">";
    fila += "                       <div class=\"input-group\">";
    fila += "                           <input type=\"text\" maxlength=\"45\" placeholder=\"Celda eg. A34\" class=\"form-control\" id=\"celda_" + contador + "\" name=\"c_celda_" + contador + "\" disabled ";
    fila += "                               oninvalid=\"setCustomValidity(\'Este campo es requerido o no coincide con el formato requerido. \')\"";
    fila += "                               oninput=\"setCustomValidity(\'\')\" > ";
    fila += "                       </div>";
    fila += "                    </div>";
    fila += "               </div>";
    fila += "           </div>";
    fila += "       </div>";
    fila += "   </div>";
    fila += "</div>";
    var orden = $("#orden").val();
    if (orden === '') {
        $("#orden").val(contador);
    } else {
        $("#orden").val(orden + ',' + contador);
    }
    var orden = $("#orden").val();
    $(".campos").append(fila);

    $("#tipocampo_" + contador).select2();

    contador++;

}

function checkManual(check, id) {
    if (check.checked) {
        $("#celda_" + id).prop("disabled", false);
    } else {
        $("#celda_" + id).val("");
        $("#celda_" + id).prop("disabled", true);
    }
}

function checkNombres(check, id) {
    if (check.checked) {
        $("#nombresfilas_" + id).prop("disabled", false);
    } else {
        $("#nombresfilas_" + id).prop("disabled", true);
    }
}

$(function () {
    $("#sortable").sortable({
        placeholder: "ui-state-highlight",
        update: function () {
            var ordenElementos = $(this).sortable("toArray").toString();
            $("#orden").val(ordenElementos);
        }
    });
    $("#sortable").disableSelection();
});
function agregarColumna(id) {
    fila = "<div class='columna col-md-12 columna_" + id + "_" + columnas + "' id=\"columna_" + id + "_" + columnas + "\" >";
    fila += "   <div class='col-md-5'>";
    fila += "       <label for=\"nombre\" class=\"control-label\">*Nombre de Columna</label>";
    fila += "       <div class=\"form-group\">";
    fila += "           <div class=\"col-sm-12\">";
    fila += "               <div class=\"input-group\">";
    fila += "                   <input type=\"text\" maxlength=\"45\" placeholder=\"Nombre\" class=\"form-control\" name=\"t_nombrecolumna_" + id + "_" + columnas + "\"";
    fila += "                       required";
    fila += "                       oninvalid=\"setCustomValidity('Este campo es requerido')\"";
    fila += "                       oninput=\"setCustomValidity('')\" > ";
    fila += "                   </div>";
    fila += "               </div>";
    fila += "            </div>";
    fila += "       </div>";
    fila += "                                            <div class=\"col-md-5\">";
    fila += "                                                <label for=\"especie\" class=\"control-label\"> *Tipo del Campo</label>";
    fila += "                                                <div class=\"form-group\">";
    fila += "                                                    <div class=\"col-sm-12\">";
    fila += "                                                        <div class=\"input-group\">";
    fila += "                                                            <select id=\"tipocampocolumna_" + id + "_" + columnas + "\" class=\"select2\" name=\"t_tipocampocolumna_" + id + "_" + columnas + "\"";
    fila += "                                                                    style='background-color: #fff;' required";
    fila += "                                                                    oninvalid=\"setCustomValidity('Este campo es requerido')\"";
    fila += "                                                                    onchange=\"setCustomValidity('')\">";
    fila += "                                                                <option value=''></option>";
    fila += "                                                                <option value=\"number_tabla\">Número</option>";
    fila += "                                                                <option value=\"text_tabla\">Campo de Texto</option>";
    fila += "                                                            </select>";
    fila += "                                                        </div>";
    fila += "                                                    </div>";
    fila += "                                                </div>";
    fila += "                                            </div>";
    fila += "       <div class=\"col-md-2\">";
    fila += "<br>";
    fila += '           <button type="button" id="boton_eliminar" class="btn btn-danger btn-sm eliminar" onclick="eliminarCampo(\'columna_' + id + "_" + columnas + '\')" style="margin-left:7px;margin-right:5px;">Eliminar</button>';
    fila += "       </div>";
    fila += "                                        </div>";

    $(".columnas_" + id).append(fila);

    $("#tipocampocolumna_" + id + "_" + columnas).select2();

    columnas++;

}
;

function agregarFilaEspecial(id) {
    fila = "<div class=\'filaespecial col-md-12 filaespecial_" + id + "_" + filas + " \' id=\"filaespecial_" + id + "_" + filas + "\">";
    fila += "<div class=\'col-md-5\'>";
    fila += "    <label for=\"nombre\" class=\"control-label\">*Nombre de Fila Especial</label>";
    fila += "    <div class=\"form-group\">";
    fila += "        <div class=\"col-sm-12\">";
    fila += "            <div class=\"input-group\">";
    fila += "                <input type=\"text\" maxlength=\"45\" placeholder=\"Nombre\" class=\"form-control\" name=\"t_nombrefilaespecial_" + id + "_" + filas + "\"";
    fila += "                       required";
    fila += "                       oninvalid=\"setCustomValidity(\'Este campo es requerido\')\"";
    fila += "                       oninput=\"setCustomValidity(\'\')\" > ";
    fila += "            </div>";
    fila += "        </div>";
    fila += "    </div>";
    fila += "</div>";
    fila += "<div class=\"col-md-5\">";
    fila += "    <label for=\"especie\" class=\"control-label\"> *Tipo del Campo</label>";
    fila += "    <div class=\"form-group\">";
    fila += "        <div class=\"col-sm-12\">";
    fila += "            <div class=\"input-group\">";
    fila += "                <select id=\"tipocampofilaespecial_" + id + "_" + filas + "\" class=\"select2\" name=\"t_tipocampofilaespecial_" + id + "_" + filas + "\"";
    fila += "                        style=\'background-color: #fff;\' required";
    fila += "                        oninvalid=\"setCustomValidity(\'Este campo es requerido\')\"";
    fila += "                        onchange=\"setCustomValidity(\'\')\">";
    fila += "                    <option value=\'\'></option>";
    fila += "                    <option value=\"promedio\">Promedio</option>";
    fila += "                    <option value=\"sumatoria\">Sumatoria</option>";
    fila += "                </select>";
    fila += "            </div>";
    fila += "        </div>";
    fila += "    </div>";
    fila += "</div>";
    fila += "       <div class=\"col-md-2\">";
    fila += "<br>";
    fila += '           <button type="button" id="boton_eliminar" class="btn btn-danger btn-sm eliminar" onclick="eliminarCampo(\'filaespecial_' + id + "_" + filas + '\')" style="margin-left:7px;margin-right:5px;">Eliminar</button>';
    fila += "       </div>";
    fila += "</div>";

    $(".filasespeciales_" + id).append(fila);

    $("#tipocampofilaespecial_" + id + "_" + filas).select2();
    filas++;
}
;

function agregarTabla() {
    fila = "<div class=\"widget widget-table tabla_" + contador + "\" id=\"" + contador + "\">";
    fila += "<input hidden=\"true\" id=\"elemento_" + contador + "\" value=\"tabla\">";
    fila += "<div class=\"widget-header\">";
    fila += "    <h3><i class=\"fa fa-table\"></i> Tabla #" + contador + "</h3>";
    fila += "    <div class=\"btn-group widget-header-toolbar\">";
    fila += '           <button type="button" id="boton_eliminar" class="btn btn-danger btn-sm eliminar" onclick="eliminarCampo(\'tabla_' + contador + '\')" style="margin-left:7px;margin-right:5px;">Eliminar</button>';
    fila += "        <input id=\"visible_" + contador + "\" type=\"checkbox\" name=\"t_tablavisible_" + contador + "\" style=\"width:20px; height:20px; alignment-baseline: central\"><span>  Visible para Usuarios</span>";
    fila += "    </div>";
    fila += "</div>";
    fila += "<div class=\"widget-content\">";
    fila += "    <label for=\"nombre\" class=\"control-label\">*Nombre de Tabla</label>";
    fila += "    <div class=\"form-group\">";
    fila += "        <div class=\"col-sm-12\">";
    fila += "            <div class=\"input-group\">";
    fila += "                <input type=\"text\" maxlength=\"45\" placeholder=\"Nombre de la Tabla\" class=\"form-control\" name=\"t_nombretabla_" + contador + "\"";
    fila += "                       required";
    fila += "                       oninvalid=\"setCustomValidity(\'Este campo es requerido\')\"";
    fila += "                       oninput=\"setCustomValidity(\'\')\" > ";
    fila += "            </div>";
    fila += "        </div>";
    fila += "    </div>";
    fila += "    <div class=\"widget widget-table\" id=\"" + contador + "\">";
    fila += "        <div class=\"widget-header\">";
    fila += "            <h3><i class=\"fa fa-columns\"></i> Columnas</h3>";
    fila += "            <div class=\"btn-group widget-header-toolbar\">";
    fila += "            </div>";
    fila += "        </div>";
    fila += "        <div class='widget-content'>";
    fila += "            <div class='columnas_" + contador + "'>";
    fila += "            </div>";
    fila += "            <div class='col-md-12 form-group'>";
    fila += "                <button type=\"button\" onclick=\"agregarColumna(" + contador + "); \" class=\"btn btn-primary\"><i class=\"fa fa-plus-circle\"></i> Agregar Columna</button>";
    fila += "                <br>";
    fila += "            </div>";
    fila += "        </div>";
    fila += "    </div>";
    fila += "    <div class=\"widget widget-table\" id=\"" + contador + "\">";
    fila += "        <div class=\"widget-header\">";
    fila += "            <h3><i class=\"fa fa-bars\"></i> Filas</h3>";
    fila += "            <div class=\"btn-group widget-header-toolbar\">";
    fila += "            </div>";
    fila += "        </div>";
    fila += "        <div class='widget-content'>";
    fila += "            <div class='filas col-md-12'>";
    fila += "                <div class='col-md-6'>";
    fila += "                    <label for=\"nombre\" class=\"control-label\">*Cantidad</label>";
    fila += "                    <div class=\"form-group\">";
    fila += "                        <div class=\"col-sm-12\">";
    fila += "                            <div class=\"input-group\">";
    fila += "                                <input type=\"number\" min='0' id=\"cantidadfilas_" + contador + "\" maxlength=\"45\" placeholder=\"Cantidad de Filas\" class=\"form-control\" name=\"t_cantidadfilas_" + contador + "\"";
    fila += "                                       required";
    fila += "                                       oninvalid=\"setCustomValidity('Este campo es requerido')\"";
    fila += "                                       oninput=\"setCustomValidity('')\" > ";
    fila += "                            </div>";
    fila += "                        </div>";
    fila += "                    </div>";
    fila += "                    <label for=\"nombre\" class=\"control-label\">*Nombre de la Columna</label>";
    fila += "                    <div class=\"form-group\">";
    fila += "                        <div class=\"col-sm-12\">";
    fila += "                            <div class=\"input-group\">";
    fila += "                                <input type=\"text\" maxlength=\"45\" placeholder=\"Nombre de la columna de las filas\" class=\"form-control\" name=\"t_nombrefilacolumna_" + contador + "\"";
    fila += "                                       required";
    fila += "                                       oninvalid=\"setCustomValidity('Este campo es requerido')\"";
    fila += "                                       oninput=\"setCustomValidity('')\" > ";
    fila += "                            </div>";
    fila += "                        </div>";
    fila += "                    </div>";
    fila += "                </div>";
    fila += "                <div class=\"col-md-6\">";
    fila += "                    <br>";
    fila += "                    <div class=\"form-group\">";
    fila += "                        <div class=\"col-sm-12\">";
    fila += "                            <div class=\"input-group\">";
    fila += "                                <input id=\"connombre_" + contador + "\" onchange=\"checkNombres(this," + contador + ")\" type=\"checkbox\" name=\"t_connombre_" + contador + "\" style=\"width:20px; height:20px; \"><span>  Con Nombre</span>";
    fila += "                            </div>";
    fila += "                        </div>";
    fila += "                    </div>";
    fila += "                    <br>";
    fila += "                    <div class=\"form-group\">";
    fila += "                        <div class=\"col-sm-12\">";
    fila += "                            <div class=\"input-group\">";
    fila += "                                <input type=\"text\" placeholder=\"Nombre, filas, separadas, por, comas\" name=\"t_nombresfilas_" + contador + "\" id=\"nombresfilas_" + contador + "\" disabled";
    fila += "                                       oninvalid=\"setCustomValidity('Este campo es requerido o no concuerda con la cantidad de filas a ingresar.')\"";
    fila += "                                       oninput=\"setCustomValidity('')\" > ";
    fila += "                            </div>";
    fila += "                        </div>";
    fila += "                    </div>";
    fila += "                </div>";
    fila += "            </div>";
    fila += "            <br>";
    fila += "            <div class=\"filasespeciales_" + contador + "\">";
    fila += "            </div>";
    fila += "        <div class='col-md-12 form-group'>";
    fila += "            <button type=\"button\" onclick=\"agregarFilaEspecial(" + contador + "); \" class=\"btn btn-primary\"><i class=\"fa fa-plus-circle\"></i> Agregar Fila Especial</button>";
    fila += "        </div>";
    fila += "        </div>";
    fila += "    </div>";
    fila += "</div>";
    fila += "</div>";

    var orden = $("#orden").val();
    if (orden === '') {
        $("#orden").val(contador);
    } else {
        $("#orden").val(orden + ',' + contador);
    }
    var orden = $("#orden").val();
    $(".campos").append(fila);


    $("#nombresfilas_" + contador).select2({
        minimumResultsForSearch: -1,
        tags: true,
        tokenSeparators: [',', ' ']
    })

    contador++;
}

function agregarAnalisis() {
    //
    var orden = $("#orden").val();
    var lista = orden.split(",");
    alert(lista);
    $.each(lista, function (i, e) {
        alert(e);
        alert(e !== "");
        if (e !== "") {
            var tipo = $("#elemento_" + e).val();
            if (tipo === "tabla") {
                var filas = $("#nombresfilas_" + e).val().split(",");
                alert(filas);
                if (filas !== "") {
                    var tamano = filas.length;
                    var cantidad = parseInt($("#cantidadfilas_" + e).val());
                    alert(tamano);
                    alert(cantidad);
                    if (cantidad !== tamano) {
                        $("#nombresfilas_" + e)[0].setCustomValidity("La cantidad de filas no coincide con la cantidad entregada.");
                    } else {
                        $("#nombresfilas_" + e)[0].setCustomValidity('');
                    }
                }
            } else {
                var celda = $("#celda_" + e).val();
                if (celda !== "") {
                    var regex = /(\$?[a-zA-Z]{1,2}\$?[1-9][0-9]*)(?![0-9a-zA-Z_:])/;
                    if (celda.match(regex)) {
                        $("#celda_" + e)[0].setCustomValidity("");
                    } else {
                        $("#celda_" + e)[0].setCustomValidity("El formato no coincide con una celda de Excel.");
                    }
                }
            }
        }
    });
    if (!$('#agregarAnalisis')[0].checkValidity()) {
        $('<input type="submit">').hide().appendTo($('#agregarAnalisis')).click().remove();
        $('#agregarAnalisis').find(':submit').click();
    } else {
        $("#agregarAnalisis").submit();
    }


}

Array.prototype.remove = function(x) { 
    var i;
    for(i in this){
        if(this[i].toString() === x.toString()){
            this.splice(i,1)
        }
    }
};

function eliminarCampo(campo) {
    var o = $("#orden").val().split(",");
    $("div > ." + campo).remove();
    var nombres = campo.split("_");
    if (nombres[0] === "campo" || nombres[0] === "tabla") {
        alert (o);
        o.remove(nombres[1].toString());
        o = o.join();
        alert (o);
        $("#orden").val(o);
    }
}



/*
 * 
 * Definición de código para la función de realizar análisis
 * 
 * 
 */

$(document).ready(function () {

    $(".fila-especial").each(function () {
        new FilaEspecial($(this));
    });
    
    $("#seleccion-reactivos").change(function() {
        var espacio_reactivos = $("#espacio-preparacion-reactivos");
        
        espacio_reactivos.children().each(function(){
            $(this).remove();
            $("label[for=preparacion-reactivos]").hide();
        });
        
        $(this).find("option:selected").each(function() {
            var enlace = "/SIGIPRO/ControlCalidad/Reactivo?accion=preparacion&id_reactivo=" + $(this).val();
            var objeto_enlace = $("<a href=\"" + enlace + "\">");
            var quiebre = $("<br>");
            objeto_enlace.text("Descargar preparación de reactivo " + $(this).text());
            
            espacio_reactivos.append(objeto_enlace);
            espacio_reactivos.append(quiebre);
            espacio_reactivos.show();
            $("label[for=preparacion-reactivos]").show();
        });
    });
});


/*
 * 
 *      Definición de la clase de fila especial
 * 
 */

// Constructor y Atributos
var FilaEspecial = function (elemento_fila) {

    this.elemento = elemento_fila;
    this.celdas = new Array();
    this.obtener_celdas();
    this.funcion = elemento_fila.data("funcion");
    this.asignar_funciones();

};

// Métodos
FilaEspecial.prototype.obtener_celdas = function () {

    var fila_especial = this;

    this.elemento.find("td").each(function (i) {
        fila_especial.celdas.push(new CeldaEspecial($(this)));
    });

};

FilaEspecial.prototype.asignar_funciones = function () {

    var fila_especial = this;

    $.each(this.celdas, function () {
        this.asignar_evento_objeto(fila_especial.funcion);
    });

};

/*
 * 
 *      Definición de la clase de celda especial
 * 
 */

// Constructor y Atributos
var CeldaEspecial = function (elemento_celda) {

    this.fila = elemento_celda.parents("tr");
    this.elemento = elemento_celda;
    this.campos_superiores = new Array();
    this.indice = this.fila.find("td").index(elemento_celda);
    this.input = elemento_celda.find("input");
    this.input.attr("readonly", true);
    this.obtener_celdas_superiores();
    this.asignar_evento_campos();

};

CeldaEspecial.prototype.obtener_celdas_superiores = function () {

    var celda_especial = this;
    this.fila.prevAll(":not(.fila-especial)").find("td:eq(" + this.indice + ")").each(function () {
        celda_especial.campos_superiores.push($(this));
    });

};

CeldaEspecial.prototype.asignar_evento_campos = function () {

    var celda_especial = this;
    $.each(this.campos_superiores, function () {
        this.find("input").change(function () {
            celda_especial.actualizar();
        });
    });

};

CeldaEspecial.prototype.asignar_evento_objeto = function (funcion) {
    if (funcion === "sumatoria") {
        this.funcion = CeldaEspecial.prototype.sumatoria;
    } else if (funcion === "promedio") {
        this.funcion = CeldaEspecial.prototype.promedio;
    }
};

CeldaEspecial.prototype.actualizar = function () {
    this.funcion();
};

CeldaEspecial.prototype.sumatoria = function () {
    var sumatoria = this.sumatoria_elementos();
    this.elemento.find("input").val(sumatoria);
};

CeldaEspecial.prototype.promedio = function () {
    var sumatoria = this.sumatoria_elementos();
    this.elemento.find("input").val(sumatoria / this.campos_superiores.length);
};

CeldaEspecial.prototype.sumatoria_elementos = function () {
    var sumatoria = 0;
    $.each(this.campos_superiores, function () {
        var valor_campo = this.find("input").val();
        var esNaN = isNaN(valor_campo);
        if (!esNaN && valor_campo !== "") {
            sumatoria += parseFloat(valor_campo);
        } else {
            sumatoria += 0;
        }
    });
    return sumatoria;
};
