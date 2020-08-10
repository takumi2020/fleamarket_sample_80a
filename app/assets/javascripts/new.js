$(function(){
  $('#inputin').keyup(function(){
      $('.count1000').text($(this).val().length);
  });
});