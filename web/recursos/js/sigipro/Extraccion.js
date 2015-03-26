function setSerpiente(){
    if (!$('#agregarSerpiente')[0].checkValidity()) {
        $('<input type="submit">').hide().appendTo($('#agregarSerpiente')).click().remove();
        $('#agregarSerpiente').find(':submit').click();
  }else{
        serpienteSeleccionada = $('#seleccionSerpiente :selected');
        id_serpiente = serpienteSeleccionada.val();
        if (id_serpiente==null) {
            $('<input type="submit">').hide().appendTo($('#agregarSerpiente')).click().remove();
            $('#agregarSerpiente').find(':submit').click();
        }
        else {
            textoSerpiente = serpienteSeleccionada.text();

            serpienteSeleccionada.remove();

            fila = '<tr ' + 'id=' + id_serpiente + '>';
            fila += '<div class="col-md-3 ">'
            fila += '<td>' + textoSerpiente + '</td>';
            fila += '</div>';
            fila += '<div class="col-md-3 ">'
            fila += '<td>';
            fila += '<input type="number" step="any" placeholder="" class="form-control" name="talla_cabeza_'+id_serpiente+'" value="" oninput="setCustomValidity(\'\')" oninvalid="setCustomValidity(\'Ingrese solo números\')">';
            fila += '</td>';
            fila += '</div>';
            fila += '<div class="col-md-3 ">'
            fila += '<td>';
            fila += '<input type="number" step="any" placeholder="" class="form-control" name="talla_cola_'+id_serpiente+'" value="" oninput="setCustomValidity(\'\')" oninvalid="setCustomValidity(\'Ingrese solo números\')">';
            fila += '</td>';
            fila += '</div>';
            fila += '<div class="col-md-3 ">'
            fila += '<td>';
            fila += '<input type="number" step="any" placeholder="" class="form-control" name="peso_'+id_serpiente+'" value="" oninput="setCustomValidity(\'\')" oninvalid="setCustomValidity(\'Ingrese solo números\')">';
            fila += '</td>';
            fila += '</div>';
            fila += '<td>';
            fila += '<button type="button" class="btn btn-danger btn-sm" onclick="eliminarSerpiente(' + id_serpiente + ')" style="margin-left:7px;margin-right:5px;">Eliminar</button>';
            fila += '</td>';
            fila += '</tr>';

            $('#datatable-column-filter-permisos > tbody:last').append(fila);

            $('#inputGroupSeleccionSerpiente').find('.select2-chosen').each(function(){$(this).prop('id',''); $(this).text('');});
        }
  }
}

// Funcion que elimina el producto interno l
function eliminarSerpiente(id_serpiente) {
  fila = $('#' + id_serpiente);
  $('#seleccionSerpiente')
    .append($("<option></option>")
    .attr("value", fila.attr('id'))
    .text(fila.children('td').eq(0).text()));
  fila.remove();
}
// Funcion que agrega los productos internos
function confirmacionAgregarSerpientes() {
    serpientesCodificados = "";
    $('#datatable-column-filter-permisos > tbody > tr').each(function ()
    
    {
      fila = $(this);
      serpientesCodificados += fila.attr('id');
      serpientesCodificados += "#r#";
    });
    $('#serpientes').val(serpientesCodificados.slice(0, -3));
    //alert("El valor del campo escondido de permisos es: "+ $('#permisosRol').val());
    console.log($('#talla_cabeza_21'));
    if (!$('#modificarSerpiente')[0].checkValidity()) {

  }else{
    $('#modificarSerpiente').submit();
  }
}


$(document).on("click", ".registrar-Modal", function () {                            
                            var numero_extraccion = $(this).data('id');
                            console.log(numero_extraccion);
                            var arr = numero_extraccion.split("/-/");
                            $('#class-registrar #numero_extraccion').text("Extraccion - "+arr[1]);
                            $("#class-registrar #id_extraccion").val(arr[0]); 
                            });
                            
                            

$(document).on("click", ".centrifugado-Modal", function () {                            
                            var numero_extraccion = $(this).data('id');
                            console.log(numero_extraccion);
                            var arr = numero_extraccion.split("/-/");
                            $('#class-centrifugado #numero_extraccion').text("Extraccion - "+arr[1]);
                            $("#class-centrifugado #id_extraccion").val(arr[0]); 
                            });
                            
$(document).on("click", ".liofilizacion-inicio-Modal", function () {                            
                            var numero_extraccion = $(this).data('id');
                            var arr = numero_extraccion.split("/-/");
                            $('#class-liofilizacion-inicio #numero_extraccion').text("Extraccion - "+arr[1]);
                            $("#class-liofilizacion-inicio #id_extraccion").val(arr[0]); 
                            });
                            
$(document).on("click", ".liofilizacion-fin-Modal", function () {                            
                            var numero_extraccion = $(this).data('id');
                            var arr = numero_extraccion.split("/-/");
                            $('#class-liofilizacion-fin #numero_extraccion').text("Extraccion - "+arr[1]);
                            $("#class-liofilizacion-fin #id_extraccion").val(arr[0]); 
                            });
                            
