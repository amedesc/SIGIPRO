$(document).ready(function () {

  // aca se leen los json de eventos y se le mandan al calendario en la funcion en la que se inicializa
  var eventosString = $('#data');
  var eventos = eventosString.data('eventos');
  $('#calendar').fullCalendar({
    header: {
      left: 'title',
      center: ' agendaDay, agendaWeek, month',
      right: 'today prev,next'
    },
    events: eventos,
    eventClick: function (calEvent, jsEvent, view) {
      var todo_el_dia="";
      if (calEvent.allDay) {todo_el_dia = "\<tr><td> <strong>Evento de todo el d&iacute;a</strong> <td></td></tr>";}
      $('#ModalEvento').remove();
      $('body').append("<div class='modal fade' id='ModalEvento' tabindex='-1' role='dialog' aria-labelledby='myModalLabel' aria-hidden='true' style='display: none;'>\
          <div class='modal-dialog'>\
            <div class='modal-content'>\
              <div class='modal-header'>\
                <button type='button' class='close' data-dismiss='modal' aria-hidden='true'>&times;</button>\
                <h4 class='modal-title' id='myModalLabel'>Evento</h4>\
              </div>\
              <div class='modal-body'>\
                  <h4 class='title'> Informaci&oacute;n del Evento</h4>\
                  <br>\
                  \<table class='tabla-ver'>\
                    <tr><td> <strong>Nombre del Evento:</strong> <td> "+ calEvent.title +" </td></tr>\
                    <tr><td> <strong>Descripci&oacute;n:</strong> <td> "+ calEvent.description +"</td></tr>\
                   "+todo_el_dia+"\
                  </table>\
                  <div class='form-group'>\
                    <div class='modal-footer'>\
                      <a type='button' class='btn btn-warning' href='/SIGIPRO/Calendario/Calendario?accion=editar&id_evento="+calEvent.id+"'><i class='fa fa-times-circle'></i> Editar</a>\
                      <button type='button' class='btn btn-danger' data-dismiss='modal' onclick='eliminar_evento("+calEvent.id+")'><i class='fa fa-times-circle'></i> Eliminar Evento</button>\
                    </div>\
                  </div>\
              </div>\
            </div>\
          </div>\
        </div>");
      $("#ModalEvento").modal('show');
 //     alert('Event: ' + calEvent.title);
    //  alert('Coordinates: ' + jsEvent.pageX + ',' + jsEvent.pageY);
     // alert('View: ' + view.name);
    }
  })

//timepicker
$('#start_time').timepicker({ 'timeFormat': 'H:i', 'step': 15 });
$('#end_time').timepicker({ 'timeFormat': 'H:i', 
                            'step': 15 });
});
$('td:contains("Todo")').html('<span> Todo <br> el d\u00eda </span>'); // --Intento de arreglar el Todo el DÁa

//funciones de checkbox
$("#allday").change(function () {
  if (this.checked) {
    $("#end_date").prop('disabled', true);
    $("#end_time").prop('disabled', true);
    $("#start_time").prop('disabled', true);
    $("#end_date").prop('placeholder', "--");
    $("#end_time").prop('placeholder', "--");
    $("#start_time").prop('placeholder', "--");
  }
  else {
    $("#end_date").prop('disabled', false);
    $("#end_time").prop('disabled', false);
    $("#start_time").prop('disabled', false);
    $("#end_date").prop('placeholder', "Escoja la fecha");
    $("#end_time").prop('placeholder', "Ej. 14:00");
    $("#start_time").prop('placeholder', "Ej. 14:00");
  }
});

$("#shared").change(function () {
  if (this.checked) {
    $("#divquien").prop('hidden', false);
  }
  else {
    $("#divquien").prop('hidden', true);
    $("#divsecciones").prop('hidden', true);
    $("#divusuarios").prop('hidden', true);
    $("#divroles").prop('hidden', true);
  }
});

//funciones de select una opcion de compartir determinada
$("#whotoshare").change(function () {
  if ($("#whotoshare").select2('val') === "Usuarios") {

    $("#divusuarios").prop('hidden', false);
    $("#divsecciones").prop('hidden', true);
    $("#divroles").prop('hidden', true);
  }
  if ($("#whotoshare").select2('val') === "Secciones") {
    $("#divusuarios").prop('hidden', true);
    $("#divsecciones").prop('hidden', false);
    $("#divroles").prop('hidden', true);
  }
  if ($("#whotoshare").select2('val') === "Roles") {
    $("#divusuarios").prop('hidden', true);
    $("#divsecciones").prop('hidden', true);
    $("#divroles").prop('hidden', false);
  }
  if ($("#whotoshare").select2('val') === "Todos") {
    $("#divusuarios").prop('hidden', true);
    $("#divsecciones").prop('hidden', true);
    $("#divroles").prop('hidden', true);
  }
});

//funcion de validar
function validar() {
  if (!$('#nuevo-evento-form')[0].checkValidity()) {
    $('<input type="submit">').hide().appendTo($('#nuevo-evento-form')).click().remove();
    $('#nuevo-evento-form').find(':submit').click();
  }
  else {
    $('#nuevo-evento-form').submit();
  }
};

//funcion eliminar evento
function eliminar_evento(id) {
$("#id_evento_eliminar").val(id);
$("#ModalEliminarEvento").modal('show');
};