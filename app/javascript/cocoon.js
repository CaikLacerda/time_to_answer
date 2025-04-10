import $ from "jquery";

$(document).on("click", ".add_fields", function (e) {
    e.preventDefault();
    let time = new Date().getTime();
    let regexp = new RegExp($(this).data("id"), "g");
    $(this)
        .before($(this).data("fields").replace(regexp, time));
});

$(document).on("click", ".remove_fields", function (e) {
    e.preventDefault();
    $(this).prev("input[type=hidden]").val("1");
    $(this).closest(".nested-fields").hide();
});
