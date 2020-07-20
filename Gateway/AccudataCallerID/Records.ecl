IMPORT Doxie, dx_gateway, iesp, Phones, Gateway;

// This function sits in front of the AccuData CallerID gateway to apply opt out suppression.
// The non-PII fields are saved for royalty calculations.

EXPORT Records(
  DATASET(Phones.Layouts.PhoneAcctno) in_phones,
  Doxie.IDataAccess mod_access,
  DATASET(Gateway.Layouts.Config) gws,
  BOOLEAN in_make_gw_call = FALSE,
  UNSIGNED pWaitTime = Phones.Constants.GatewayValues.requestTimeout,
  UNSIGNED pRetries = Phones.Constants.GatewayValues.requestRetries)
:= FUNCTION

  gateway_cfg := gws(Gateway.Configuration.IsAccuDataCNAM(servicename))[1];
  gateway_URL := gateway_cfg.url;
  make_gateway_call := gateway_URL != '' AND in_make_gw_call AND NOT mod_access.isAccuDataRestricted();
  gw_resp := Gateway.SoapCall_AccuData_CallerID(in_phones, gateway_cfg, make_gateway_call);
  gw_resp_cleaned := Gateway.AccudataCallerID.Parser.CleanResponse(gw_resp, mod_access);

  RETURN gw_resp_cleaned;
END;
