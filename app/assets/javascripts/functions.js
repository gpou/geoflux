$(function() {
  $("select").each(function() {
    if ($(this).parents('.modal').length==0) {
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
