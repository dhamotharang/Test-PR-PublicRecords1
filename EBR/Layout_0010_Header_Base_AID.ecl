import Address, BIPV2;

export Layout_0010_Header_Base_AID :=	record
  Layout_Base;
  Layout_0010_Header_In_AID;
  address.Layout_Clean182  Clean_Address;
  unsigned8 source_rec_id        :=0;  //Added for BIP project
  unsigned4 dt_effective_first   :=0;
  unsigned4 dt_effective_last    :=0;
  unsigned1 delta_ind            :=0;

end;