import dx_common;

export Layout_4020_Tax_Liens_Base := 
record
  Layout_Base;
  Layout_4020_Tax_Liens_In - [lf];
  dx_common.layout_metadata - [global_sid, record_sid];
end;