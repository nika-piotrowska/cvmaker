import Rails from "@rails/ujs";
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "trix"
import "@rails/actiontext"
import $ from "jquery"

import "./channels"
import "./src/sections"

// klucz: nie startuj drugi raz
if (!window._rails_loaded) {
  Rails.start();
}

Turbolinks.start();
ActiveStorage.start();

window.Rails = $;
window.jQuery = $;
window.$ = $;
