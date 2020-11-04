import Address, dx_common;

export Layout_5000_Bank_Details_Base_AID :=  record
  Layout_Base;
  Layout_5000_Bank_Details_In_AID;
  address.Layout_Clean182  Clean_Address;
  dx_common.layout_metadata - [global_sid, record_sid];
end;