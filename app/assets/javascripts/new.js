$(function(){
  $('#inputin').keyup(function(){
      $('.count1000').text($(this).val().length);
  });
});

$(function(){

  //プレビューのhtmlを定義
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

      setLabel();
      if(count < 5){
        $('.label-box').attr({id: `label-box--${count}`,for: `item_item_images_attributes_${count}_url`});
      }
    }
  });

  $(document).on('click', '.delete-box', function() {
    var count = $('.preview-box').length;
    setLabel(count);
    var id = $(this).attr('id').replace(/[^0-9]/g, '');
    $(`#preview-box__${id}`).remove();
    console.log("new")
    $(`#item_item_images_attributes_${id}_url`).val("");

    var count = $('.preview-box').length;
    if (count == 4) {
      $('.label-content').show();
    }
    setLabel(count);

    if(id < 5){
      $('.label-box').attr({id: `label-box--${id}`,for: `item_item_images_attributes_${id}_url`});
    }
  });
});

$(function() {
  function appendOption(category) {
    var html = `<option value="${category.name}" data-category="${category.id}">${category.name}</option>`;
    return html;
  }

  function appendChildrenBox(insertHTML) {
    var childSelectHtml = '';
    childSelectHtml = `
                       <div class='select--wrap' id= 'category__box--children'>
                         <select class="inputfield" id="child_form" name="category_id">
                           <option value="---" data-category="---">選択してください</option>
                           ${insertHTML}
                         </select>
                       </div>
                      `;
    $('.product-details__form__category').append(childSelectHtml);
  }

  function appendGrandchildrenBox(insertHTML) {
    var grandchildSelectHtml = '';
    grandchildSelectHtml = `
                            <div class='select--wrap' id= 'category__box--grandchildren'>
                              <select class="inputfield inputfield-last" id="grandchild_form" name="category_id">
                                <option value="---" data-category="---">選択してください</option>
                                ${insertHTML}
                              </select>
                            </div>
                           `;
    $('.product-details__form__category').append(grandchildSelectHtml);
  }

  $("#parent_form").on("change", function() {
    var parentValue = document.getElementById("parent_form").value;
    if (parentValue != "選択してください") {
      $('#category__box--children').remove();
      $('#category__box--grandchildren').remove();
      $.ajax({
        url     : '/items/search_child',
        type    : 'GET',
        data    : {
          parent_id: parentValue
        },
        dataType: 'json'
      })

      .done(function(children) {
        $('#category__box--children').remove();
        $('#category__box--grandchildren').remove();
        var insertHTML = '';
        children.forEach(function(child){
          insertHTML += appendOption(child);
        });
        appendChildrenBox(insertHTML);
      })
      .fail(function() {
        alert('カテゴリーを入力して下さい');
      })
    } else {
      $('#category__box--children').remove();
      $('#category__box--grandchildren').remove();
    }
  });

  $(".product-details__form__category").on("change", "#child_form", function() {
    var childValue = $('#child_form option:selected').data('category');
    if (childValue != "選択してください") {
      $.ajax({
        url     : '/items/search_grandchild',
        type    : 'GET',
        data    : {
          child_id: childValue
        },
        dataType: 'json'
      })

      .done(function(grandchildren) {
        var insertHTML = '';
        grandchildren.forEach(function(grandchild){
          insertHTML += appendOption(grandchild);
        });
        appendGrandchildrenBox(insertHTML);
      })
      .fail(function() {
        alert('カテゴリーを入力して下さい');
      })
    } else {
      $('#category__box--children').remove();
      $('#category__box--grandchildren').remove();
    }
  });
});