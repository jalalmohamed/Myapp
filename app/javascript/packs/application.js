// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

// import Rails from "@rails/ujs"
// import Turbolinks from "turbolinks"
// import * as ActiveStorage from "@rails/activestorage"
import * as Popper from "@popperjs/core"
import "channels"
//= require jquery3
//= require jquery_ujs
//= require_tree
// Rails.start()
// Turbolinks.start()
ActiveStorage.start()

// $(document).ready(function(){
//     $(".btn1").click(function(){
//         //$(".read_text").hide();
//         $(this).parent().find(".read_text").css( "display", "none" );
//     })
// });
$(document).ready(function() {
    var $label = $("#read_text label");
    var text = $label.text();
    $label.text(text.replace("Unread", "read"));
});
