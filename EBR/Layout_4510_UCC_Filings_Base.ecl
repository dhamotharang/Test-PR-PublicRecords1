export Layout_4510_UCC_Filings_Base := 
record
  Layout_Base;
  Layout_4510_UCC_Filings_In - [lf];
  unsigned4 dt_effective_first  := 0;
  unsigned4 dt_effective_last   := 0;
  unsigned1 delta_ind           := 0;
end;