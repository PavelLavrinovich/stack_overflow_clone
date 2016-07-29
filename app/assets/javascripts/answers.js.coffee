ready = ->
    $('.edit-link').click (e) ->
        e.preventDefault()
        domId = $(this).data('dom-id')
        $('#' + domId + '-edit-form').toggle()

$(document).ready(ready);
$(document).on('page:load', ready)
$(document).on('page:update', ready)