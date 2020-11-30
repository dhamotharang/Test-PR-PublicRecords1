import dx_common;

export Layout_2000_Trade_Base := 
record
  Layout_Base;
  Layout_2000_Trade_In - [lf];
  dx_common.layout_metadata - [global_sid, record_sid];
end;