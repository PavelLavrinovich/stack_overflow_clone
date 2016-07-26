$(document).ready(function () {
    $('.edit-link').click(function(e) {
        e.preventDefault();
        var domId = $(this).data('dom-id');
        var parts = domId.split('_');
        $("html, body").animate({scrollTop: $(document).height()}, 'slow');
        var answer = $('#' + domId + '-body').text();
        $('#answer_body').val(answer);
        $('#new_answer').prop('method', 'patch');
        $('#new_answer').prop('action', '/' + parts[0] + 's/' + parts[1]);
  });
});