import Address;

export Layout_5000_Bank_Details_Base_AID :=  record
  Layout_Base;
  Layout_5000_Bank_Details_In_AID;
  address.Layout_Clean182  Clean_Address;
  unsigned4 dt_effective_first  := 0;
  unsigned4 dt_effective_last   := 0;
  unsigned1 delta_ind           := 0;
end;