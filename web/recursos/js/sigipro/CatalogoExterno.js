
/* 
 * Funciones de JS para la funcionalidad de Catalogo Externo
 */


// Funcion que agrega el producto interno
function agregarProductoInterno() {
  if (!$('#form-Interno-Externo')[0].checkValidity()) {
    $('<input type="submit">').hide().appendTo($('#form-Interno-Externo')).click().remove();
    $('#form-Interno-Externo').find(':submit').click();
  }else{
    permisoSeleccionado = $('#seleccioninterno :selected');
    idPermiso = permisoSeleccionado.val();
    if (idPermiso==null) {
       $('<input type="submit">').hide().appendTo($('#form-Interno-Externo')).click().remove();
       $('#form-Interno-Externo').find(':submit').click();
    }
    else {
      $('#modalAgregarCatalogoInterno').modal('hide');

      textoPermiso = permisoSeleccionado.text();

      permisoSeleccionado.remove();

      fila = '<tr ' + 'id=' + idPermiso + '>';
      fila += '<td>' + textoPermiso + '</td>';
      fila += '<td>';
      fila += '<button type="button" class="btn btn-danger btn-sm" onclick="eliminarProductoInterno(' + idPermiso + ')" style="margin-left:7px;margin-right:5px;">Eliminar</button>';
      fila += '</td>';
      fila += '</tr>';

      $('#datatable-column-filter-permisos > tbody:last').append(fila);

      $('#inputGroupSeleccionInterno').find('.select2-chosen').each(function(){$(this).prop('id',''); $(this).text('');});
    }
  }
}

// Funcion que elimina el producto interno l
function eliminarProductoInterno(idPermiso) {
  fila = $('#' + idPermiso);
  $('#seleccioninterno')
    .append($("<option></option>")
    .attr("value", fila.attr('id'))
    .text(fila.children('td').eq(0).text()));
  fila.remove();
}
// Funcion que agrega los productos internos
function confirmacionAgregarProductoExterno() {
    permisosCodificados = "";
    $('#datatable-column-filter-permisos > tbody > tr').each(function ()
    
    {
      fila = $(this);
      permisosCodificados += fila.attr('id');
      permisosCodificados += "#r#";
    });
    $('#productosinternos').val(permisosCodificados.slice(0, -3));
    //alert("El valor del campo escondido de permisos es: "+ $('#permisosRol').val());
    
    if (!$('#formCatalogoExterno')[0].checkValidity()) {
    $('<input type="submit">').hide().appendTo($('#formCatalogoExterno')).click().remove();
    $('#formCatalogoExterno').find(':submit').click();
    }
    else{$('#formCatalogoExterno').submit();}
}
