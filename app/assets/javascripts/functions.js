DATATABLE_PROPS = {
  language: {
    "sProcessing":   "Processant...",
    "sLengthMenu":   "Mostra _MENU_ registres",
    "sZeroRecords":  "No s'han trobat registres.",
    "sInfo":         "Mostrant de _START_ a _END_ de _TOTAL_ registres",
    "sInfoEmpty":    "Mostrant de 0 a 0 de 0 registres",
    "sInfoFiltered": "(filtrat de _MAX_ total registres)",
    "sInfoPostFix":  "",
    "sSearch":       "Filtrar:",
    "sUrl":          "",
    "oPaginate": {
        "sFirst":    "Primer",
        "sPrevious": "&lt;",
        "sNext":     "&gt;",
        "sLast":     "Últim"
    }
  }
};

$(function() {
  $(".datatable").dataTable(DATATABLE_PROPS);

  $("select").each(function() {
    if (($(this).parents('.modal').length==0) && ($(this).parents('.dataTables_wrapper').length==0)) {
      $(this).chosen({disable_search_threshold: 10});
    }
  });

  $(".dialogify").on("click", function(e) {
    var url = $(this).attr('href');
    var title = $(this).attr('title');
    if (!title) title = $(this).attr('original-title');
    var width = $("#dialog_wrapper").width()
    var height = $(window).height()-100
    if (url.substring(0,1)=="#") {
      $(url).children().appendTo("#ajax_dialog");
      $("#ajax_dialog").dialog({
        modal: true, 
        width: width, 
        height: height,
        title: title,
        create: function(event, ui) {
          $("body").css({ overflow: 'hidden' })
        },
        beforeClose: function(event, ui) {
          $("body").css({ overflow: 'inherit' })
          $("#ajax_dialog").children().appendTo(url);
          if (window.closeDialogifyHandler) {
            window.closeDialogifyHandler();
          }
        }
      })
    } else {
      $("#ajax_dialog").html("<iframe style='display:none;width:"+(width)+"px;height:"+(height-40)+"px' src='"+url+"'></iframe>")
      $("#ajax_dialog iframe").load(function() {
        $(this).show();
      })
      $("#ajax_dialog").dialog({
        modal: true, 
        width: width, 
        height: height,
        title: title,
        create: function(event, ui) {
          $("body").css({ overflow: 'hidden' })
        },
        beforeClose: function(event, ui) {
          $("body").css({ overflow: 'inherit' })
          if (window.closeDialogifyHandler) {
            window.closeDialogifyHandler();
          }
        }
      })
    }
    return false;
  });

  $('.modal').on('shown.bs.modal', function () {
    $('select', this).chosen({disable_search_threshold: 10});
  });
})
