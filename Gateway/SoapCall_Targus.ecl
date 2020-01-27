import $, targus, royalty, doxie, dx_gateway;

// replacement for Targus.Targus_Soapcall_Function

EXPORT SoapCall_Targus(dataset(targus.Layout_Targus_In) d_recs_in,
                        Gateway.Layouts.Config gateway_cfg,
                        integer timeout=1,
                        integer retries=1,
                        boolean makeGatewayCall = false,
                        doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END,
                        boolean apply_opt_out = false) := function

  d_recs_in_clean := dx_gateway.parser_targus.CleanRequest(d_recs_in, mod_access);
  // Commenting it out for now since doxie.phone_noreconn_service is coring due to this
  // d_recs_in_ready := IF(apply_opt_out, d_recs_in_clean, d_recs_in);
  d_recs_in_ready := d_recs_in;

  gateway_URL := gateway_cfg.url;

  targus.layout_targus_out errX(targus.Layout_Targus_In le) := transform
  self.response.Header.ErrorMessage := FAILMESSAGE;
  self.response.Header.ErrorCode := FAILCODE;
  self.response.header.queryid := le.user.queryid;
  self.searchby.phonenumber := le.searchby.phonenumber;
  self.searchby.consumername.frst := le.searchby.consumername.Fname;
  self.searchby.consumername.lst := le.searchby.consumername.Lname;
  self := [];
  end;

  //'http://web_bps_roxie:[PASSWORD_REDACTED]@172.16.18.165:7996/WsGateway'

  targus.layout_targus_in into_in(d_recs_in L) := transform
  self.user.referenceCode := if(L.user.referenceCode <> '', trim(L.user.referenceCode), gateway_cfg.TransactionId);
  self.user.BillingCode := trim(L.user.BillingCode);
  self.user.queryId := trim(L.user.QueryId);
  self.Options.Blind := Gateway.Configuration.GetBlindOption(gateway_cfg);

  // Royalty tracking
  self.GatewayParams.TxnTransactionId := Gateway.Configuration.GetTransactionIdX(gateway_cfg);
  self.GatewayParams.BatchJobId 			:= Gateway.Configuration.GetBatchJobId(gateway_cfg);
  self.GatewayParams.ProcessSpecId 		:= Gateway.Configuration.GetBatchspecId(gateway_cfg);
  self.GatewayParams.QueryName 				:= Gateway.Configuration.GetRoxieQueryName(gateway_cfg);

  _royaltyCode := MAP(
    L.options.IncludeWirelessConnectionSearch 	=> Royalty.Constants.RoyaltyCode.TARGUS_WCS,
    L.options.IncludePhoneDataExpressSearch 		=> Royalty.Constants.RoyaltyCode.TARGUS_PDE,
    L.options.IncludeIntlPhoneDataExpressSearch => Royalty.Constants.RoyaltyCode.TARGUS_PDE,
    L.options.IncludeNameVerificationSearch 		=> Royalty.Constants.RoyaltyCode.TARGUS_NV,
    Royalty.Constants.RoyaltyCode.TARGUS_VE
    );
  self.GatewayParams.RoyaltyCode 			:= _royaltyCode;
  self.GatewayParams.RoyaltyType 			:= Royalty.Functions.GetRoyaltyType(_royaltyCode);

  // Enabling call to external gateway. Additional field CheckVendorGatewayCall to preserve backward
  // compatibility on Gateway ESP side in case of non-roxie calls.
  self.GatewayParams.CheckVendorGatewayCall := true;
  self.GatewayParams.MakeVendorGatewayCall 	:= makeGatewayCall;

  self.options.verifyexpressoptions.screenoptions := trim(L.options.verifyExpressOptions.screenOptions);
  self.searchby.consumername.FullName := trim(L.searchby.consumername.FullName);
  self.searchby.consumername.Fname := trim(L.searchby.consumername.Fname);
  self.searchby.consumername.Middle := trim(L.searchby.consumername.Middle);
  self.searchby.consumername.Lname := trim(L.searchby.consumername.Lname);
  self.searchby.consumername.Suffix := trim(L.searchby.consumername.Suffix);
  self.searchby.consumername.Prefix := trim(L.searchby.consumername.prefix);
  self.searchby.companyname := trim(L.searchby.companyname);
  self.searchby.UnknownName := trim(L.searchby.UnknownName);
  self.searchby.phonenumber := trim(L.searchby.phonenumber);
  self.searchby.address.streetName := trim(L.searchby.address.streetName);
  self.searchby.address.streetNumber := trim(L.searchby.address.streetNumber);
  self.searchby.address.streetPreDirection := trim(L.searchby.address.streetPreDirection);
  self.searchby.address.streetPostDirection := trim(L.searchby.address.streetPostDirection);
  self.searchby.address.StreetSuffix := trim(L.searchby.address.StreetSuffix);
  self.searchby.address.UnitDesignation := trim(L.searchby.address.UnitDesignation);
  self.searchby.address.UnitNumber := trim(L.searchby.address.UnitNumber);
  self.searchby.address.StreetAddress1 := trim(l.searchby.address.StreetAddress1);
  self.searchby.address.StreetAddress2 := trim(L.searchby.address.StreetAddress2);
  self.searchby.address.State := trim(L.searchby.address.State);
  self.searchby.address.City := trim(L.searchby.address.City);
  self.searchby.address.zip5 := trim(L.searchby.address.zip5);
  self.searchby.address.zip4 := trim(L.searchby.address.zip4);
  self.searchby.address.County := trim(L.searchby.address.County);
  self.searchby.address.PostalCode := trim(L.searchby.address.PostalCode);
  self.searchby.address.StateCityZip := trim(L.searchby.address.StateCityZip);
  self := L;
  end;

  d_recs_out := if (makeGatewayCall,
                    soapcall(d_recs_in_ready,gateway_URL,'TargusComprehensive',
                              targus.Layout_Targus_In, into_in(LEFT),
                              dataset(targus.Layout_Targus_Out),
                              XPATH('TargusComprehensiveResponseEx'),
                              ONFAIL(errX(left)), timeout(timeout), retry(retries)));

  d_recs_out_clean := dx_gateway.parser_targus.CleanResponse(d_recs_out, mod_access);
  // Commenting it out for now since doxie.phone_noreconn_service is coring due to this
  // return IF(apply_opt_out, d_recs_out_clean, d_recs_out);
  return d_recs_out;

end;
