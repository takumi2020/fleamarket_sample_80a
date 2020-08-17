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
                    <div class="update-box">
                      <label class="edit_btn">編集</label>
                    </div>
                    <div class="delete-box" id="delete_btn_${count}">
                      <span>削除</span>
                    </div>
                  </div>
                </div>`
    return html;
  }

  // ラベルのwidth操作
  function setLabel() {
    //プレビューボックスのwidthを取得し、maxから引くことでラベルのwidthを決定
    var prevContent = $('.label-content').prev();
    labelWidth = (620 - $(prevContent).css('width').replace(/[^0-9]/g, ''));
    $('.label-content').css('width', labelWidth);
  }

  // プレビューの追加
  $(document).on('change', '.hidden-field', function() {
    setLabel();
    //hidden-fieldのidの数値のみ取得
    var id = $(this).attr('id').replace(/[^0-9]/g, '');
    //labelボックスのidとforを更新
    $('.label-box').attr({id: `label-box--${id}`,for: `item_item_images_attributes_${id}_url`});
    //選択したfileのオブジェクトを取得
    var file = this.files[0];
    var reader = new FileReader();
    //readAsDataURLで指定したFileオブジェクトを読み込む
    reader.readAsDataURL(file);
    //読み込み時に発火するイベント
    reader.onload = function() {
      var image = this.result;
      //プレビューが元々なかった場合はhtmlを追加
      if ($(`#preview-box__${id}`).length == 0) {
        var count = $('.preview-box').length;
        var html = buildHTML(id);
        //ラベルの直前のプレビュー群にプレビューを追加
        var prevContent = $('.label-content').prev();
        $(prevContent).append(html);
      }
      //イメージを追加
      $(`#preview-box__${id} img`).attr('src', `${image}`);
      var count = $('.preview-box').length;
      //プレビューが5個あったらラベルを隠す 
      if (count == 5) { 
        $('.label-content').hide();
      }

      //ラベルのwidth操作
      setLabel();
      //ラベルのidとforの値を変更
      if(count < 5){
        //プレビューの数でラベルのオプションを更新する
        $('.label-box').attr({id: `label-box--${count}`,for: `item_item_images_attributes_${count}_url`});
      }
    }
  });

  // 画像の削除
  $(document).on('click', '.delete-box', function() {
    var count = $('.preview-box').length;
    setLabel(count);
    //item_images_attributes_${id}_image から${id}に入った数字のみを抽出
    var id = $(this).attr('id').replace(/[^0-9]/g, '');
    //取得したidに該当するプレビューを削除
    $(`#preview-box__${id}`).remove();
    console.log("new")
    //フォームの中身を削除 
    $(`#item_item_images_attributes_${id}_url`).val("");

    //削除時のラベル操作
    var count = $('.preview-box').length;
    //5個めが消されたらラベルを表示
    if (count == 4) {
      $('.label-content').show();
    }
    setLabel(count);

    if(id < 5){
      //削除された際に、空っぽになったfile_fieldをもう一度入力可能にする
      $('.label-box').attr({id: `label-box--${id}`,for: `item_item_images_attributes_${id}_url`});
    }
  });
});

$(function() {
  // カテゴリーセレクトボックスのオプションを作成
  function appendOption(category) {
    var html = `<option value="${category.name}" data-category="${category.id}">${category.name}</option>`;
    return html;
  }

  // 子カテゴリーの表示作成
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

  // 孫カテゴリーの表示作成
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

  // 子要素のアクション
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

  // 孫要素のアクション
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