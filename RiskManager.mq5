//+------------------------------------------------------------------+
//|                                               PositionSizer.mq5 |
//|                      Custom EA with Position Sizing UI         |
//+------------------------------------------------------------------+
#property strict
#property version   "1.00"
#property script_show_inputs

#include <Trade/Trade.mqh>
CTrade trade;

input double RiskPercent = 1.0; // Risk Percentage per trade

string entryLineName = "EntryLine";
string stopLossLineName = "StopLossLine";
bool tradePlaced = false;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
   ObjectCreate(0, entryLineName, OBJ_HLINE, 0, 0, 0);
   ObjectSetInteger(0, entryLineName, OBJPROP_COLOR, clrBlue);

   ObjectCreate(0, stopLossLineName, OBJ_HLINE, 0, 0, 0);
   ObjectSetInteger(0, stopLossLineName, OBJPROP_COLOR, clrRed);

   Print("Draw the Entry and Stop Loss lines on the chart.");

   return (INIT_SUCCEEDED);
  }

//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
   if (tradePlaced)
      return;

   double entryPrice = ObjectGetDouble(0, entryLineName, OBJPROP_PRICE);
   double stopLossPrice = ObjectGetDouble(0, stopLossLineName, OBJPROP_PRICE);

   if (entryPrice == 0 || stopLossPrice == 0)
      return;

   if (SymbolInfoDouble(_Symbol, SYMBOL_BID) >= entryPrice && !tradePlaced)
     {
      double lotSize = CalculateLotSize(entryPrice, stopLossPrice);
      if (lotSize > 0)
        {
         bool result = trade.Buy(lotSize, NULL, entryPrice, stopLossPrice, 0);
         if (result)
           {
            Print("Trade Placed: Lot Size: ", lotSize);
            tradePlaced = true;
           }
         else
           {
            Print("Trade Failed. Error: ", GetLastError());
           }
        }
     }
  }

//+------------------------------------------------------------------+
//| Calculate Lot Size                                               |
//+------------------------------------------------------------------+
double CalculateLotSize(double entryPrice, double stopLossPrice)
  {
   double slDistance = MathAbs(entryPrice - stopLossPrice);
   if (slDistance <= 0)
      return (0);

   double tickValue = SymbolInfoDouble(_Symbol, SYMBOL_TRADE_TICK_VALUE);
   double tickSize = SymbolInfoDouble(_Symbol, SYMBOL_TRADE_TICK_SIZE);

   double pipValuePerLot = tickValue / tickSize;

   double accountRisk = AccountInfoDouble(ACCOUNT_BALANCE) * (RiskPercent / 100);
   double lotSize = accountRisk / (slDistance / _Point * pipValuePerLot);

   double minLot = SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_MIN);
   double maxLot = SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_MAX);
   double lotStep = SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_STEP);

   lotSize = MathFloor(lotSize / lotStep) * lotStep;
   lotSize = MathMax(lotSize, minLot);
   lotSize = MathMin(lotSize, maxLot);

   return (NormalizeDouble(lotSize, 2));
  }

//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
   ObjectDelete(0, entryLineName);
   ObjectDelete(0, stopLossLineName);
  }
//+------------------------------------------------------------------+
