function switchActive(){
  console.log('dick')
  var that = $(this);
  var tabs = $('.show_tab');
  for(var i = 0; i < tabs.length; i++){
    $(tabs[i]).removeClass('green_to_white')
  };
  $(that).addClass('green_to_white');
}