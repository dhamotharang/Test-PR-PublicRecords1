export Layout_7010_SNP_Data_Base := 
record
  Layout_Base;
  Layout_7010_SNP_Data_In - [lf];
  unsigned4 dt_effective_first  := 0;
  unsigned4 dt_effective_last   := 0;
  unsigned1 delta_ind           := 0;
end;