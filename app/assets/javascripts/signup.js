$(function () {  
  var password = '.password';
  var passcheck = '#reveal_password';
  $(passcheck).change(function () {
      if ($(this).prop('checked')) {
          $(password).attr('type', 'text');
      } else {
          $(password).attr('type', 'password');
      };
  });
});