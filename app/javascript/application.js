// Entry point for the build script in your package.json
import "./controllers";
import * as Popper from "@popperjs/core"
$(document).ready(function() {
    var $label = $("#read_text label");
    var text = $label.text();
    $label.text(text.replace("Unread", "read"));
});