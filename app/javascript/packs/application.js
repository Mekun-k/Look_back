// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import '@fortawesome/fontawesome-free/js/all';

Rails.start()
Turbolinks.start()
ActiveStorage.start()
require("jquery")
require('qiita.js')
require('sidebar.js')
require('hamburger.js')
require('check_box.js')

var jQuery = require('jquery')
global.$ = global.jQuery = jQuery;
window.$ = window.jQuery = jQuery;

$(document).on ("turbolinks:load", function(){
	$('img')
	  // マウスポインターが画像に乗った時の動作
	  .mouseover(function(e) {
		console.log('マウスオーバーしました');
		$(this).attr('src', "/assets/line_on.png");
	  })
	  // マウスポインターが画像から外れた時の動作
	  .mouseout(function(e) {
		$(this).attr('src', '/assets/line.png');
	  })
      .click(function(e) {
		$(this).attr('src', '/assets/line_cl.png');
	  });
});

require("bootstrap/dist/js/bootstrap")