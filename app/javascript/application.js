// Entry point for the build script in your package.json
//= require jquery
//= require_tree .
//= require jquery_ujs
//= require bootstrap
//= require bootstrap-multiselect
import "./controllers";
import "./controllers"
import Rails from 'rails-ujs'
Rails.start()
$(document).ready(function() {
    var $label = $("#read_text label");
    var text = $label.text();
    $("td").click(function(){
    });
    $label.text(text.replace("Unread", "read"));
});