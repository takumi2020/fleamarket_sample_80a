$(document).on('turbolinks:load', function() {
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
      // 投稿編集時
    //items/:i/editページへリンクした際のアクション=======================================
    if (window.location.href.match(/\/items\/\d+\/edit/)){
      //登録済み画像のプレビュー表示欄の要素を取得する
      var prevContent = $('.label-content').prev();
      labelWidth = (620 - $(prevContent).css('width').replace(/[^0-9]/g, ''));
      $('.label-content').css('width', labelWidth);
      //プレビューにidを追加
      $('.preview-box').each(function(index, box){
        $(box).attr('id', `preview-box__${index}`);
      })
      //削除ボタンにidを追加
      $('.delete-box').each(function(index, box){
        $(box).attr('id', `delete-btn_${index}`);
      })
      var count = $('.preview-box').length;
      //プレビューが5あるときは、投稿ボックスを消しておく
      if (count == 5) {
        $('.label-content').hide();
      }
    }
    //=============================================================================
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
    var id = $(this).prop('id').replace(/[^0-9]/g, '');
    console.log(id)
    //取得したidに該当するプレビューを削除
    $(`#preview-box__${id}`).remove();
    // $(".hidden-checkbox").prop("checked",true);
    $(`#item_item_images_attributes_${id}__destroy`).prop("checked",true);
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
    }else {
      //投稿編集時
      $(`#item_images_attributes_${id}__destroy`).prop('checked',true);
      //5個めが消されたらラベルを表示
      if (count == 4) {
        $('.label-content').show();
      }
      //ラベルのwidth操作
      setLabel();
      //ラベルのidとforの値を変更
      //削除したプレビューのidによって、ラベルのidを変更する
      if(id < 5){
        $('.label-box').attr({id: `label-box--${id}`,for: `item_images_attributes_${id}_image`});
      }
    }
  });
});

$(document).on('turbolinks:load', function() { 
  $('[name=change]').click(function () {
    $('.change').remove();
    // location.reload();
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