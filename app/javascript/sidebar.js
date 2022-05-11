$(document).on('click', '#sidebarToggler', function(){

  var sidbar = document.querySelector('.sidebar')

  var page = document.getElementsByTagName('main')[0];

  if (page.style.cssText == "margin-left: -250px;" ) {
    page.style.cssText = 'margin-left: 0px';
    return;
  } else {
    page.style.cssText = 'margin-left: -250px';
    return;
  }
});
