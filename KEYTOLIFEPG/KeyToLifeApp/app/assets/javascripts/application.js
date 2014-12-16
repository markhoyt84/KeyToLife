// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require ../../../vendor/assets/javascripts/jssor.slider.mini.js

var checkSpot = function(){
$(window).scroll(function(){
  var pos = scroller();
  if(pos > 128){
    $('.logo_image').css('visibility', 'visible')
    $('.logo').css('display', 'block');
  }else{
    $('.logo_image').css('visibility', 'hidden')
    if($( document ).width() < 650){
    $('.logo').css('display', 'none');
  };
  };
});

function scroller(){
  var pos = $(window).scrollTop();
  return pos;
};
};

checkSpot();