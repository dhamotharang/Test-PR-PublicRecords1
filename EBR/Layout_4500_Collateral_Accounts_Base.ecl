export Layout_4500_Collateral_Accounts_Base := 
record
  Layout_Base;
  Layout_4500_Collateral_Accounts_In - [lf];
  unsigned4 dt_effective_first  := 0;
  unsigned4 dt_effective_last   := 0;
  unsigned1 delta_ind           := 0;
end;