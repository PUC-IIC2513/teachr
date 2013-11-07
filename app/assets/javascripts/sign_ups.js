// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

var Teachr =  (function(m, undefined) {
  m.validateRequired = function(field) {
    //TODO valida
  };
}(Teachr || {}));



/**
Validación "required" a cualquier campo con data-validate=required.
*/
$(function() {
  $("#new_user").on("submit", function(e) {
    var error = false;
    var $this = $(this);
    var $required_fields = $this.find("[data-validate=required]");
    
    for(var i = 0, len = $required_fields.length; i < len; i++) {
      var $field = $($required_fields[i]);
      var value = $field.val();
      if (!value || value.trim().length === 0) {
        error = true;
        $field.parent().addClass("field_with_errors");
        $errorMessage = $field.next('span.error-message');
        if($errorMessage.length === 0) {
          $errorMessage = $('<span class="error-message"></span>').insertAfter($field);
        }
        $errorMessage.html('es requerido');
      } else {
        // clear error
        $field.parent().removeClass('field_with_errors');
        $field.next('span.error-message').hide();
      }
    }

    // TODO: crear una clase que encapsule este comportamiento, o al menos extraerlo a una función    
    
    if (error) {
      e.preventDefault();
    }
  });
});

