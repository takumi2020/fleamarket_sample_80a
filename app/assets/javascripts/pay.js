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
          
          // $('<input type="hidden" name="payjp-token">').val(response.id)
        );
          // $('<input type="hidden" name="payjp-token">').val(response.cars.id)
         //取得したトークンを送信できる状態にします
        $('#card_form')[0].submit();
        // document.inputForm.submit();
        $("#card_number").removeAttr("name");
        $("#cvc-from").removeAttr("name");
        $("#exp_month").removeAttr("name");
        $("#exp_year").removeAttr("name");
      //   // cardElement.clear()
      //   // alert("登録が完了しました"); //確認用
      //   // const token = response.id;
      //   // response.id is token ID
      };
    });   
  });
});


{/* <input type="hidden" name="card_token" value=${response.card.id}></input> */}
// $(function(){
//   if(document.location.pathname !== "/cards/new") return false;
//   // カード登録ページじゃい時は処理を実行しない
//   const payjp = Payjp('pk_test_7370ce03239ee60f10ca694c') //公開鍵を読み込む。
//   // Payjp.setPublicKey('pk_...................')としなくて良いらしい
//   const elements = payjp.elements();
//   // payjpのインスタンス生成
//   const cardElement = elements.create('card', {style: {base: {color: 'black'}}})
//   // ここでformを生成してる。createの第一引数には、「card」「cardNumber」「cardExpiry」「cardCvc」とかのタイプを選んで作れる。
//   // cardだとカード番号、有効期限、cvcの３つをまとめて横並びにしたフォームを生成する
//   // フォームを分けたい人は「cardNumber」「cardExpiry」「cardCvc」を引数にして作ると良いです。
//   cardElement.mount('#card-element');
//   // 任意のセレクタ(#card-element)に対してiframe(入力フォームを付与する)
//   const submit_btn = $("#info_submit")
//   // いつものリファクタ


//   submit_btn.click(function(e) {
//     e.preventDefault();
//     // submitしないように止める
//     payjp.createToken(cardElement).then(function(response) { 
//       if (response.error) {
//         // Payjp側からの返ってくるオブジェクトがerrorオブジェクトを持ってた場合
// 　　　　 // = 通信に失敗したとき
//         alert(response.error.message)
//         // どの情報に対して不備があるのか教えてくれる。
// 　　　　 // 下記に記載しているが該当箇所のエラーを知らせてくれる
//         regist_card.prop('disabled', false);
//         // いつものやつ
//         return ;
//       }
//       else {
//         alert("カード登録が完了しました")
//         $("#card_token").append(
//             `<input type="hidden" name="payjp_token" value=${response.id}>
//              <input type="hidden" name="card_token" value=${response.card.id}>`
//             //  これもいつものやつ
//          );
//       cardElement.clear()
// 　　　 // 入力情報を消す
//       $('#card_form')[0].submit()
//       }

//     })
//   });

  // });