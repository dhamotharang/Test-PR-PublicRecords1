EXPORT Mac_Check_Access (ds_in, ds_out, mod_access, fraud_platform) := MACRO
  import suppress, FraudShared_Services;
  #uniquename(_fdn_suppressed)
  %_fdn_suppressed% := suppress.MAC_SuppressSource(ds_in, mod_access);
  ds_out := if(fraud_platform = FraudShared_Services.Constants.Platform.FDN, %_fdn_suppressed%, ds_in);

ENDMACRO;
