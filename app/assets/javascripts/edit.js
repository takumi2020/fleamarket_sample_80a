$(document).on('turbolinks:load', function() {
  function buildHTML(count) {
    var html = `<div class="preview-box" id="preview-box__${count}">
                  <div class="upper-box">
                    <img src="" alt="preview">
                  </div>
                  <div class="lower-box">
                    <div class="delete-box" id="delete_btn_${count}">
                      <span>削除</span>
                    </div>
                  </div>
                </div>`
    return html;
  }
    if (window.location.href.match(/\/items\/\d+\/edit/)){
      var prevContent = $('.label-content').prev();
      labelWidth = (620 - $(prevContent).css('width').replace(/[^0-9]/g, ''));
      $('.label-content').css('width', labelWidth);
      $('.preview-box').each(function(index, box){
        $(box).attr('id', `preview-box__${index}`);
      })
      $('.delete-box').each(function(index, box){
        $(box).attr('id', `delete-btn_${index}`);
      })
      var count = $('.preview-box').length;
      if (count == 5) {
        $('.label-content').hide();
      }
    }
  function setLabel() {
    var prevContent = $('.label-content').prev();
    labelWidth = (620 - $(prevContent).css('width').replace(/[^0-9]/g, ''));
    $('.label-content').css('width', labelWidth);
  }
  $(document).on('change', '.hidden-field', function() {
    setLabel();
    var id = $(this).attr('id').replace(/[^0-9]/g, '');
    $('.label-box').attr({id: `label-box--${id}`,for: `item_item_images_attributes_${id}_url`});
    var file = this.files[0];
    var reader = new FileReader();
    reader.readAsDataURL(file);
    reader.onload = function() {
      var image = this.result;
      if ($(`#preview-box__${id}`).length == 0) {
        var count = $('.preview-box').length;
        var html = buildHTML(id);
        var prevContent = $('.label-content').prev();
        $(prevContent).append(html);
      }
      $(`#preview-box__${id} img`).attr('src', `${image}`);
      var count = $('.preview-box').length;
      if (count == 5) { 
        $('.label-content').hide();
      }

      if ($(`#item_item_images_attributes_${id}__destroy`)){
        $(`#item_item_images_attributes_${id}__destroy`).prop('checked',false);
      } 

      setLabel();
      if(count < 5){
        $('.label-box').attr({id: `label-box--${count}`,for: `item_item_images_attributes_${count}_url`});
      }
    }
  });
  $(document).on('click', '.delete-box', function() {
    var count = $('.preview-box').length;
    setLabel(count);
    var id = $(this).prop('id').replace(/[^0-9]/g, '');
    $(`#preview-box__${id}`).remove();
    $(`#item_item_images_attributes_${id}__destroy`).prop("checked",true);
    if (count == 4) {
      $('.label-content').show();
    }
    setLabel(count);
    if(id < 5){
      $('.label-box').attr({id: `label-box--${id}`,for: `item_item_images_attributes_${id}_url`});
    }else {
      $(`#item_images_attributes_${id}__destroy`).prop('checked',true);
      if (count == 4) {
        $('.label-content').show();
      }
      setLabel();
      if(id < 5){
        $('.label-box').attr({id: `label-box--${id}`,for: `item_images_attributes_${id}_image`});
      }
    }
  });
});

$(document).on('turbolinks:load', function() { 
  $('[name=change]').click(function () {
    $('.change').remove();
    function appendOption(category){
            var html = `<option value="${category.id}" data-category="${category.id}">${category.name}</option>`;
            return html;
          }
          function appendChildrenBox(insertHTML){
            var childSelectHtml = '';
            childSelectHtml = `<div class='listing-select-wrapper__added' id= 'children_wrapper'>
                                <div class='listing-select-wrapper__box'>
                                  <select class="inputfield" id="child_category" name="item[category_id]">
                                    <option value="---" data-category="---">選択してください</option>
                                    ${insertHTML}
                                  <select>
                                </div>
                              </div>`;
            $('.listing-product-detail__category').append(childSelectHtml);
          }
          function appendGrandchildrenBox(insertHTML){
            var grandchildSelectHtml = '';
            grandchildSelectHtml = `<div class='listing-select-wrapper__added' id= 'grandchildren_wrapper'>
                                      <div class='listing-select-wrapper__box'>
                                        <select class="inputfield inputfield-last" id="grandchild_category" name="item[category_id]">
                                          <option value="---" data-category="---">選択してください</option>
                                          ${insertHTML}
                                        </select>
                                      </div>
                                    </div>`;
            $('.listing-product-detail__category').append(grandchildSelectHtml);
          }
          $("#parent_category").on('change', function(){
            var parentCategory = document.getElementById('parent_category').value;
            if (parentCategory != "選択してください"){
              $.ajax({
                url: '/items/get_category_children',
                type: 'GET',
                data: { parent_name: parentCategory },
                dataType: 'json'
              })
              .done(function(children){
                $('#children_wrapper').remove();
                $('#grandchildren_wrapper').remove();
                var insertHTML = '';
                children.forEach(function(child){
                  insertHTML += appendOption(child);
                });
                appendChildrenBox(insertHTML);
              })
              .fail(function(){
                alert('カテゴリー取得に失敗しました');
              })
            }else{
              $('#children_wrapper').remove();
              $('#grandchildren_wrapper').remove();
            }
          });
          $('.listing-product-detail__category').on('change', '#child_category', function(){
            var childId = $('#child_category option:selected').data('category');
            if (childId != "選択してください"){
              $.ajax({
                url: '/items/get_category_grandchildren',
                type: 'GET',
                data: { child_id: childId },
                dataType: 'json'
              })
              .done(function(grandchildren){
                if(grandchildren.length != 0) {
                  $('#grandchildren_wrapper').remove();
                  $('#size_wrapper').remove();
                  $('#brand_wrapper').remove();
                  var insertHTML = '';
                  grandchildren.forEach(function(grandchild){
                    insertHTML += appendOption(grandchild);
                  });
                  appendGrandchildrenBox(insertHTML);
                }
              })
              .fail(function(){
                alert('カテゴリー取得に失敗しました');
              })
            }else{
              $('#grandchildren_wrapper').remove();
            }
          });
  });
});