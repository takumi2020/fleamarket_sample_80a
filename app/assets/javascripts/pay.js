$(function () {
  var payjp = Payjp('pk_test_92a7d8f9bdc9e0c5575bdbb0')
  var elements = payjp.elements();
  // 入力フォームを分解して管理・配置できます
  var numberElement = elements.create('cardNumber');
  var expiryElement = elements.create('cardExpiry');
  var cvcElement = elements.create('cardCvc');
  numberElement.mount('#number-form');
  expiryElement.mount('#expiry-form');
  cvcElement.mount('#cvc-form');
  var submit_btn = $("#info_submit");
  submit_btn.click(function (e){
    e.preventDefault();
    payjp.createToken(numberElement).then(function(response) {
      if (response.error) {
        // Payjp側からの返ってくるオブジェクトがerrorオブジェクトを持ってた場合
        // = 通信に失敗したとき
        alert(r.error.message)
        // どの情報に対して不備があるのか教えてくれる。
        // 下記に記載しているが該当箇所のエラーを知らせてくれる
        regist_card.prop('disabled', false);
        // alert("カード情報が正しくありません。");
      } else {
        alert("登録が完了しました"); 
        $("#card_token").append(
          `<input type="hidden" name="payjp_token" value=${response.id}>
          <input type="hidden" name="card_token" value=${response.card.id}>`
        );
         //取得したトークンを送信できる状態にします
        $('#card_form')[0].submit();
        // document.inputForm.submit();
        $("#card_number").removeAttr("name");
        $("#cvc-from").removeAttr("name");
        $("#exp_month").removeAttr("name");
        $("#exp_year").removeAttr("name");
      };
    });   
  });
});

