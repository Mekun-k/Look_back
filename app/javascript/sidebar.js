$(document).on('click', '#sidbar-toggler', function(){

  var sidbar = document.querySelector('.sidebar')

  if (sidbar.style.left == '-100%' ) {
    sidbar.style.left = '0%';
    return;
  } else {
    sidbar.style.left = '-100%';
    return;
  }
});
