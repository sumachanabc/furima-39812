//アロー関数
const pay = () => {
  const publicKey = gon.public_key;
  const payjp = Payjp(publicKey); // PAY.JPテスト公開鍵
  // ↓elements()メソッド…Payjpインスタンスが持つメソッドで、elementsインスタンスを作ることができる。
  const elements = payjp.elements(); // elementsインスタンスを作成
  // ↓elements.create()…elementsインスタンスのメソッド。このメソッドを使用することで、入力フォームを作成可能。
  //  この時、生成されたフォームはelementという種類のインスタンスになる。
  const numberElement = elements.create("cardNumber"); // ()内は指定可能なタイプの記述が予め決まっている。
  const expiryElement = elements.create("cardExpiry");
  const cvcElement = elements.create("cardCvc");
  // ↓引数で要素のid属性を指定し、指定した要素とelementインスタンスが情報を持つフォームとを置き換える…mountメソッド
  numberElement.mount("#number-form"); // #number-formというid属性の要素とフォームを置き換える
  expiryElement.mount("#expiry-form");
  cvcElement.mount("#cvc-form");
  const form = document.getElementById("charge-form"); // DOMツリーから特定のHTMLの要素を取得するためのメソッド。引数に渡したidを持つHTML要素を取得.

  form.addEventListener("submit", (e) => {
    // createTokenメソッド…戻り値としてカード情報のトークンを取得。第一引数のcardはPAY.JP側に送るカードの情報。
    // then以降に、レスポンスを受け取ったあとの処理を記述。変数responseには、PAY.JP側からのレスポンスとステータスコードが含まれている。
    payjp.createToken(numberElement).then(function (response) {
      // 処理にエラーがない場合response.errorの値がnilとなることを利用して条件分岐をしています。
      // すなわち、うまく処理が完了したときだけ、トークンの値を取得し送信アクションが行われる
      if (response.error) {
      } else {
        const token = response.id; // response.idとすることでトークンの値を取得
        const renderDom = document.getElementById("charge-form");
        // valueは実際に送られる値、nameはその値を示すプロパティ名（params[:name]のように取得できるようになる）を示す。
        const tokenObj = `<input value=${token} name='token' type="hidden">`; // type指定でトークンの値を非表示
        // insertAdjacentHTMLメソッド(JavaScriptのDOM操作用メソッド)で、フォームの中に作成したinput要素を追加
        renderDom.insertAdjacentHTML("beforeend", tokenObj);
      }
      numberElement.clear(); // clear()…クレジットカードの各情報を削除
      expiryElement.clear();
      cvcElement.clear();
      document.getElementById("charge-form").submit(); // フォームの情報をサーバーサイドに送信
    });
    e.preventDefault(); // 通常のRuby on Railsにおけるフォーム送信処理はキャンセル
  });
};

window.addEventListener("turbo:load", pay);
