// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

/*
  Esto nos permite escuchar cuando llegue la respuesta Ajax (que en estos momentos
  es sólo un trozo de HTML) y usar esa trozo para insertarlo dentro de una burbuja.
*/
$(
  function() {
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
);