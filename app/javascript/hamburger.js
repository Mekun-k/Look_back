$(document).on('click', '.hamburger', function(){
  $(this).toggleClass('active');

  if ($(this).hasClass('active')) {
      $('.globalMenuSp').addClass('active');
  } else {
      $('.globalMenuSp').removeClass('active');
  }
});
