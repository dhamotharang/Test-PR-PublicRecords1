import Address, dx_common;

export Layout_6510_Government_Debarred_Contractor_Base_AID :=  record
  Layout_Base;
  Layout_6510_Government_Debarred_Contractor_In_AID;
  address.Layout_Clean182  Clean_Business_Address;
  dx_common.layout_metadata - [global_sid, record_sid];
end;