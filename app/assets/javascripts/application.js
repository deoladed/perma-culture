// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require jquery_ujs
//= require assets/js/core/popper.min
//= require bootstrap
//= require assets/js/plugins/moment.min
//= require assets/js/plugins/bootstrap-switch
//= require assets/js/plugins/bootstrap-tagsinput
//= require assets/js/plugins/bootstrap-selectpicker
//= require assets/js/plugins/jasny-bootstrap.min
//= require assets/js/plugins/nouislider.min
//= require assets/js/plugins/bootstrap-datetimepicker.min
//= require assets/js/now-ui-kit
//= require assets/js/animatenumber/jquery.animateNumber.min
//= require mapbox-gl
//= require activestorage
//= require_tree .


// ------------------------ REPARATION RESPONSIVE  NAVBAR & SELECTPICKER ---------------------
$(document).ready(function() {
    $('#navbar-btn').click(function () {
        $('.collapse').show(500);
    });
    $('select').selectpicker();
});


// ---------------------------------- CHAT -------------------------------------
(function() {
  $(document).on('click', '.toggle-window', function(e) {
    e.preventDefault();
    var card = $(this).parent().parent();
    var messages_list = card.find('.messages-list');

    card.find('.card-body').toggle();
    card.attr('class', 'card bg-light mb-0');

    if (card.find('.card-body').is(':visible')) {
      var height = messages_list[0].scrollHeight;
      messages_list.scrollTop(height);
    }
  });
})();

$(document).ready(function() { 
  $('#toggle-user-list').click(function (e) {
    e.preventDefault();
    $('#the-user-list').fadeToggle(800);
    $('#conversations-list').toggleClass('conversation-list-to-right');
    $('.collapse').fadeOut(300);
  });

   $('#close-messenger').click(function (e) {
    $('#the-user-list').fadeOut(500);
    $('#conversations-list').removeClass('conversation-list-to-right');
  });
});


