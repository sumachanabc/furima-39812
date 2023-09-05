const price = () => {
  const priceInput = document.getElementById("item-price");

  priceInput.addEventListener("input", () => {
    // 価格入力値を取得
    const inputValue = priceInput.value;

    // 価格のバリデーションなどを行う（価格が適切な形式であることを確認）

    // 販売手数料と販売利益の計算ロジック
    const price = parseFloat(inputValue); // 入力値を数値に変換
    if (!isNaN(price) && price >= 300 && price <= 9999999) {
      const fee = Math.floor(price * 0.1); // 販売手数料（価格の10%）
      const profit = Math.floor(price - fee); // 販売利益
      document.getElementById("add-tax-price").innerHTML = fee.toLocaleString(); // 販売手数料を表示
      document.getElementById("profit").innerHTML = profit.toLocaleString(); // 販売利益を表示
    } else {
      // 価格が適切でない場合、エラー処理を行うか、表示をクリアするなどの対応が必要
      document.getElementById("add-tax-price").innerHTML = "";
      document.getElementById("profit").innerHTML = "";
    }
  });
};
window.addEventListener("turbo:load", price);
