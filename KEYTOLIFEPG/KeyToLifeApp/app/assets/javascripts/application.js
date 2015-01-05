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

$('img.catphoto').on('click', function(){
  console.log('working');
});

function showLogoImage(){
  $('.logo_image').css('visibility', 'visible');
  $('.logo').css('display', 'block');
};

function switchTabs(el){
    $(el).css('border-bottom', '0px solid black');
    $(el).css('border-left', '0px solid black');
    $(el).addClass('green_to_white');
};

function switchNew(){
  $('.proceed_modal_title_new').on('click', function(){
    var other = $('.proceed_modal_title_returning');
    switchTabs($(this));
    $(other).removeClass('green_to_white')
    $(other).css('border-bottom', '2px solid black');
    $(other).css('border-right', '2px solid black');
    // $('.new_customer').css('display', 'block');
    $('.new_customer').show()
    $('.returning_customer').hide();
  });
};

function switchReturningTab(el){
    var other = $('.proceed_modal_title_new');
    switchTabs($(el));
    $(other).removeClass('green_to_white')
    $(other).css('border-bottom', '2px solid black');
    $(other).css('border-right', '2px solid black');
    $('.returning_customer').show();
    $('.new_customer').hide();
};

function switchReturning(){
  $('.proceed_modal_title_returning').on('click', function(){
    switchReturningTab($(this));
  });
};

function switchActive(el){
  var that = $(el);
  var tabs = $('.show_tab');
  for(var i = 0; i < tabs.length; i++){
    $(tabs[i]).removeClass('green_to_white')
  };
  $(that).addClass('green_to_white');
};