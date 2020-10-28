import dx_common;

export Layout_4500_Collateral_Accounts_Base := 
record
  Layout_Base;
  Layout_4500_Collateral_Accounts_In - [lf];
  dx_common.layout_metadata - [global_sid, record_sid];
end;