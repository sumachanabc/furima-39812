// app/javascript/item.js

document.addEventListener('DOMContentLoaded', () => {
  const priceInput = document.getElementById('item_price');
  const feeDisplay = document.getElementById('fee_display');
  const profitDisplay = document.getElementById('profit_display');

  if (priceInput) {
    priceInput.addEventListener('input', () => {
      const price = parseFloat(priceInput.value);
      if (!isNaN(price)) {
        const fee = Math.floor(price * 0.1); // 10%手数料（適宜変更）
        const profit = Math.floor(price - fee);
        feeDisplay.innerText = `¥${fee.toLocaleString()}`;
        profitDisplay.innerText = `¥${profit.toLocaleString()}`;
      } else {
        feeDisplay.innerText = '';
        profitDisplay.innerText = '';
      }
    });
  }
});