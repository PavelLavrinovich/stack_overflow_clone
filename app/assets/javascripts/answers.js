$(document).ready(function () {
    $('.edit-link').click(function(e) {
        e.preventDefault();
        var domId = $(this).data('dom-id');
        $('#' + domId + '-edit-form').toggle();
  });
});