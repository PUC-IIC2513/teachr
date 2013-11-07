// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

/*
  Esto nos permite escuchar cuando llegue la respuesta Ajax (que en estos momentos
  es sólo un trozo de HTML) y usar esa trozo para insertarlo dentro de una burbuja.
*/

function loadAjaxTags() {
  if ($(document.body).data('controller') !== 'tags') {
    return;
  }
  console.log("escuchando requests ajax para tags");
  
  $("#tags").on('ajax:success', 'a.tag', function(e, data) {
    $this = $(this);
    var $bubble = $('#tag-bubble');
    if($bubble.length === 0) {
      $bubble = $('<div id="tag-bubble"></div>').addClass("bubble");
      $("#tags").append($bubble);
    }
    $bubble.html(data).insertAfter($this);
    var pos = $this.offset();
    pos.top += 50;
    pos.left -= 50;
    $bubble.offset(pos);
  });
}

$(loadAjaxTags);
$(document).on('page:load', loadAjaxTags);


var Teachr = (function(m) {
  
  function privada() {
    
  }
  
  
  var datoCompartido = 42;
  
  m.createTagBubble = function(tag_id, content) {
    var $tag = $("#tag_" + tag_id);

    var $bubble = $('#tag-bubble');
    if($bubble.length === 0) {
      $bubble = $('<div id="tag-bubble"></div>').addClass("bubble");
      $("#tags").append($bubble);
    }

    $bubble.html(content);

    var pos = $tag.offset();
    pos.top += 50;
    pos.left -= 50;

    $bubble.offset(pos);  
  
  }
  
  return m;
}(Teachr || {}));

