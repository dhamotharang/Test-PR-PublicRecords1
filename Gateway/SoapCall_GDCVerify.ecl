/* Replacement for: GDCVerify.GDCVerify_SoapCall_Function_Unicode */

import GDCVerify,Royalty;

export SoapCall_GDCVerify(dataset(GDCVerify.Layout_GDCVerify_In_Unicode) Inf,  
													Gateway.Layouts.Config gateway_cfg, 
													integer timeout=10, 
													integer retries=0,
													BOOLEAN makeGatewayCall = FALSE) := FUNCTION

GDCVerify.Layout_GDCVerify_Out errX(GDCVerify.Layout_GDCVerify_In_Unicode le) := transform
	self.Response.Header.ErrorMessage := FAILMESSAGE;
	self.Response.Header.ErrorCode := FAILCODE;
	self.Response.header.queryid := le.user.queryid;
	self := [];
end;

// trim all input strings
GDCVerify.Layout_GDCVerify_In_Unicode into_in(inf L) := transform
	self.user.ReferenceCode := trim(if(L.user.ReferenceCode<>'', L.user.ReferenceCode, gateway_cfg.TransactionId));
	self.user.BillingCode := trim(L.user.BillingCode);
	self.user.QueryId := trim(L.user.QueryId);
	self.user.GLBPurpose := trim(L.user.GLBPurpose);
	self.user.DLPurpose := trim(L.user.DLPurpose);
	
	self.searchoptions.SubAccount := trim(L.searchoptions.SubAccount);
	self.searchoptions.CreditFlag := trim(L.searchoptions.CreditFlag);

	self.searchby.Person.FirstName := UnicodeLib.UnicodeCleanSpaces(L.searchby.Person.FirstName);
	self.searchby.Person.MiddleName := UnicodeLib.UnicodeCleanSpaces(L.searchby.Person.MiddleName);
	self.searchby.Person.LastName := UnicodeLib.UnicodeCleanSpaces(L.searchby.Person.LastName);

	self.searchby.Address.FullStreet := UnicodeLib.UnicodeCleanSpaces(L.searchby.Address.FullStreet);
	self.searchby.Address.StreetName := UnicodeLib.UnicodeCleanSpaces(L.searchby.Address.StreetName);
	self.searchby.Address.StreetType := UnicodeLib.UnicodeCleanSpaces(L.searchby.Address.StreetType);
	self.searchby.Address.BuildingNumber := UnicodeLib.UnicodeCleanSpaces(L.searchby.Address.BuildingNumber);
	self.searchby.Address.SubBuildingNumber := UnicodeLib.UnicodeCleanSpaces(L.searchby.Address.SubBuildingNumber);
	self.searchby.Address.CityTown := UnicodeLib.UnicodeCleanSpaces(L.searchby.Address.CityTown);
	self.searchby.Address.StateDistrict := UnicodeLib.UnicodeCleanSpaces(L.searchby.Address.StateDistrict);
	self.searchby.Address.PostalCode := UnicodeLib.UnicodeCleanSpaces(L.searchby.Address.PostalCode);
	self.searchby.Address.Country := trim(L.searchby.Address.Country);
	self.searchby.Address.CountryCode := trim(L.searchby.Address.CountryCode);
	self.searchby.Address.County := UnicodeLib.UnicodeCleanSpaces(L.searchby.Address.County);

	self.searchby.PhoneNumber := trim(L.searchby.PhoneNumber);
	self.searchby.IdNumber := trim(L.searchby.IdNumber);

	// Royalty tracking
	SELF.GatewayParams.TxnTransactionId := Gateway.Configuration.GetTransactionIdX(gateway_cfg);
	SELF.GatewayParams.BatchJobId 			:= Gateway.Configuration.GetBatchJobId(gateway_cfg);
	SELF.GatewayParams.ProcessSpecId 		:= Gateway.Configuration.GetBatchSpecId(gateway_cfg);
	SELF.GatewayParams.QueryName 				:= Gateway.Configuration.GetRoxieQueryName(gateway_cfg);
	SELF.GatewayParams.RoyaltyCode 			:= Royalty.Functions.GetGDCRoyaltyCode(L.searchby.Address.CountryCode);
	SELF.GatewayParams.RoyaltyType 			:= Royalty.Functions.GetGDCRoyaltyType(L.searchby.Address.CountryCode);	
		
	// Enabling call to external gateway. Additional field CheckVendorGatewayCall to preserve backward 
	// compatibility on Gateway ESP side in case of non-roxie calls.
	SELF.GatewayParams.CheckVendorGatewayCall := true; 
	SELF.GatewayParams.MakeVendorGatewayCall 	:= makeGatewayCall;		
	SELF.SearchOptions.Blind := Gateway.Configuration.GetBlindOption(gateway_cfg);
	self := L;
	self := [];
end;

outf := if (makeGatewayCall, soapcall(inf, gateway_cfg.Url, 'GDCVerifyCheck',
																	GDCVerify.Layout_GDCVerify_In_Unicode, into_in(LEFT),  
																	dataset(GDCVerify.Layout_GDCVerify_Out),
																	XPATH('GDCVerifyCheckResponseEx'),
																	ONFAIL(errX(left)), timeout(timeout), retry(retries)));	// what timeout should be used

return outf;
end;