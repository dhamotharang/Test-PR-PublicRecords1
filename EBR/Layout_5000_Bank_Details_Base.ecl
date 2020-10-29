import dx_common;

export Layout_5000_Bank_Details_Base := 
record
  Layout_Base;
  Layout_5000_Bank_Details_In;
  dx_common.layout_metadata - [global_sid, record_sid];
end;