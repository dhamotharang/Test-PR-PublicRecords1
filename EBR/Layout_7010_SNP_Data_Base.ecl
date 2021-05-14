import dx_common;

export Layout_7010_SNP_Data_Base := 
record
  Layout_Base;
  Layout_7010_SNP_Data_In - [lf];
  dx_common.layout_metadata - [global_sid, record_sid];
end;