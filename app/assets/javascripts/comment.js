$(function(){
  function buildHTML(comment){
    let html = `<p class="showComments">
                  <strong>
                    <a class="showComments__userName" href=/users/${comment.user_id}>${comment.user_name}</a>：
                  </strong>
                  ${comment.text}
                </p>`
    return html;
  }
  $('.commentForm').on('submit', function(e){
    e.preventDefault();
    let formData = new FormData(this);
    let url = $(this).attr('action')
    $.ajax({
      url: url,
      type: "POST",
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(data){
      let html = buildHTML(data);
      $('.commentList').append(html);
      $('.textForm').val('');
      $('.commentSubmit').prop('disabled', false);
    })
    .fail(function(){
      alert('error');
    })
  })
})