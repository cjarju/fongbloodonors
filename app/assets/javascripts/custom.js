$(document).on('turbolinks:load', function() {
    $('.input-group.date').datepicker({
        format: "yyyy-mm-dd",
        todayBtn: "linked",
        todayHighlight: true,
        orientation: "top auto",
        autoclose: true
    });
});
