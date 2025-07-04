# MT5 Risk Manager EA

## Overview
**MT% Risk Manager** is a simple yet powerful Risk Management Expert Advisor (EA) designed for the MetaTrader 5 (MT5) platform.  
It helps traders automatically calculate the lot size based on account balance and predefined risk percentage per trade.

By default, this EA risks **0.5%** of the total account balance per trade and uses horizontal lines drawn on the chart to determine the **Entry**, **Stop Loss (SL)**, and **Take Profit (TP)** levels.

---

## Key Features
- ✅ Automatically calculates **lot size** based on account balance and stop-loss distance.
- ✅ Default risk per trade: **0.5% of account balance**.
- ✅ Uses horizontal lines to define:
  - **Entry Line**: Named `Entry`
  - **Stop Loss Line**: Named `SL`
  - **Take Profit Line**: Named `TP`
- ✅ Simple and intuitive: just draw the lines and let the EA handle the rest.
- ✅ Works on any symbol and timeframe.
- ✅ Ensures **one trade per setup** to prevent overtrading.

---

## How to Use
1. Attach the EA to your preferred chart.
2. Draw **three horizontal lines** and name them exactly as:
   - `Entry` for entry price.
   - `SL` for stop-loss level.
   - `TP` for take-profit level.
3. The EA will automatically:
   - Calculate the correct lot size based on your stop-loss distance and account size.
   - Place a trade when the market price reaches your entry point.
4. The EA will not place a new trade until the current trade is complete.

---

## Input Parameters
| Parameter       | Description                             | Default |
|-----------------|-----------------------------------------|---------|
| RiskPercent     | Percentage of account balance to risk    | 0.5     |
| EntryLineName   | Name of the horizontal entry line        | Entry   |
| StopLossLineName| Name of the stop-loss horizontal line    | SL      |
| TakeProfitLineName| Name of the take-profit horizontal line| TP      |

---

## Important Notes
- The EA does not manage trailing stop or break-even — it strictly handles **entry and lot sizing** based on risk.
- Make sure the line names are correctly typed (case-sensitive).
- Always test the EA in a demo account before using it in live trading.

---

## Recommended Enhancements (Future Versions)
- Add a user interface (UI) for more interactive lot size adjustments.
- Include dynamic risk % selection.
- Add trailing stop and break-even features.
- Notification on trade execution.

---

## Disclaimer
This EA is provided for educational and personal use only. Trading in the financial markets involves risk. Please test thoroughly and use appropriate risk management. The author is not responsible for any losses incurred.

---

## Contact
For updates or support:  
**Amal Jeev**  
[Visit my MQL5 profile]([https://www.mql5.com](https://www.mql5.com/en/users/amaljeev))
