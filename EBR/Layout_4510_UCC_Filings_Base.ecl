import dx_common;

export Layout_4510_UCC_Filings_Base := 
record
  Layout_Base;
  Layout_4510_UCC_Filings_In - [lf];
  dx_common.layout_metadata - [global_sid, record_sid];
end;