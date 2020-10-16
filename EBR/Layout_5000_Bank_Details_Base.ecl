export Layout_5000_Bank_Details_Base := 
record
  Layout_Base;
  Layout_5000_Bank_Details_In;
  unsigned4 dt_effective_first  := 0;
  unsigned4 dt_effective_last   := 0;
  unsigned1 delta_ind           := 0;
end;