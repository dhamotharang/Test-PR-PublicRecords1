import dx_common;

export Layout_0010_Header_Base := 
record
  Layout_Base;
  Layout_0010_Header_In;
  dx_common.layout_metadata - [global_sid, record_sid];
end;
