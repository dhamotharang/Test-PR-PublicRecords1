/*--SOAP--
<message name="ReportService">
    <part name="FraudGovReportRequest" type="tns:XmlDataSet" cols="80" rows="30"/>
</message>
*/

IMPORT BatchShare,FraudShared_Services,iesp,WSInput;

EXPORT ReportService() := MACRO

	//The following macro defines the field sequence on WsECL page of query.
	WSInput.MAC_FraudGovPlatform_Services_ReportService();
	
	rec_in 				:= iesp.fraudgovreport.t_FraudGovReportRequest;
	ds_in 			 	:= DATASET ([], rec_in) : STORED ('FraudGovReportRequest', FEW);
	first_row 		:= ds_in[1] : independent;
	ReportBy 			:= GLOBAL (first_row.reportBy);
	Options 			:= GLOBAL (first_row.Options);
	FraudGovUser	:= GLOBAL (first_row.FraudGovUser);
	iesp.ECL2ESP.SetInputBaseRequest (first_row);
	
	// **************************************************************************************
	//Checking that gc_id, industry type, and product code have some values - they are required.
	IF(FraudGovUser.GlobalCompanyId = 0, FraudShared_Services.Utilities.FailMeWithCode(ut.constants_MessageCodes.FRAUDGOV_GC_ID));
	IF(FraudGovUser.IndustryType = 0, FraudShared_Services.Utilities.FailMeWithCode(ut.constants_MessageCodes.FRAUDGOV_INDUSTRY_TYPE));
	IF(FraudGovUser.ProductCode = 0, FraudShared_Services.Utilities.FailMeWithCode(ut.constants_MessageCodes.FRAUDGOV_PRODUCT_CODE));
	// **************************************************************************************
	
	MaxVelocities := MAP(	Options.IsOnline and Options.MaxVelocities > 0 => MIN(Options.MaxVelocities, iesp.Constants.FraudGov.MAX_COUNT_VELOCITY),
												Options.IsOnline and Options.MaxVelocities = 0 => iesp.Constants.FraudGov.MAX_COUNT_VELOCITY,
												~Options.IsOnline => FraudGovPlatform_Services.Constants.MAX_VELOCITIES,
												0);
											 
	MaxKnownFrauds := MAP(Options.IsOnline and Options.MaxKnownFrauds > 0 => MIN(Options.MaxKnownFrauds, iesp.Constants.FraudGov.MAX_COUNT_KNOWN_RISK),
												Options.IsOnline and Options.MaxKnownFrauds = 0 => iesp.Constants.FraudGov.MAX_COUNT_KNOWN_RISK,
												~Options.IsOnline => FraudGovPlatform_Services.Constants.MAX_KNOWN_FRAUDS,
												0);

	#STORED('AppendBest', Options.AppendBest);
	#STORED('DIDScoreThreshold', Options.DIDScoreThreshold);
	#STORED('GlobalCompanyId',	FraudGovUser.GlobalCompanyId);
	#STORED('IndustryType',	FraudGovUser.IndustryType);
	#STORED('ProductCode',FraudGovUser.ProductCode);
	#STORED('AgencyVerticalType', Options.AgencyVerticalType);
	#STORED('AgencyCounty',  Options.AgencyCounty);
	#STORED('AgencyState',  Options.AgencyState);
	#STORED('FraudPlatform',	Options.Platform);
	#STORED('MaxVelocities', MaxVelocities);
	#STORED('MaxKnownFrauds', MaxKnownFrauds);

	GetReportModule(iesp.fraudgovreport.t_FraudGovReportBy reportBy) := FUNCTION
		FraudShared_Services.Layouts.BatchIn_rec xform_batch_in() := TRANSFORM
			SELF.ssn := reportBy.SSN;
			SELF.dob := iesp.ECL2ESP.t_DateToString8(reportBy.DOB);
			SELF.did := (INTEGER)reportBy.UniqueId; 
			SELF.name_first := reportBy.Name.First; 
			SELF.name_middle := reportBy.Name.Middle;
			SELF.name_last := reportby.Name.Last;
			SELF.name_suffix := reportby.Name.Suffix; 
			SELF.addr := reportBy.Address.StreetAddress1;
			SELF.predir := reportBy.Address.StreetPredirection;
			SELF.prim_range := reportBy.Address.StreetNumber;
			SELF.prim_name := reportBy.Address.StreetName;
			SELF.addr_suffix := reportBy.Address.StreetSuffix;
			SELF.postdir := reportBy.Address.StreetPostdirection;
			SELF.p_city_name := reportBy.Address.City; 
			SELF.st := reportBy.Address.State; 
			SELF.z5 := reportBy.Address.Zip5; 
			SELF.mailing_addr := reportBy.MailingAddress.StreetAddress1; 
			SELF.mailing_predir := reportBy.MailingAddress.StreetPredirection;
			SELF.mailing_prim_range := reportBy.MailingAddress.StreetNumber;
			SELF.mailing_prim_name := reportBy.MailingAddress.StreetName;
			SELF.mailing_addr_suffix := reportBy.MailingAddress.StreetSuffix;
			SELF.mailing_postdir := reportBy.MailingAddress.StreetPostdirection;
			SELF.mailing_p_city_name := reportBy.MailingAddress.City; 
			SELF.mailing_st := reportBy.MailingAddress.State; 
			SELF.mailing_z5 := reportBy.MailingAddress.Zip5;
			SELF.phoneno := reportBy.Phone10;
			SELF.ultid := reportBy.BusinessLinkIds[1].ultid; 
			SELF.orgid := reportBy.BusinessLinkIds[1].orgid; 
			SELF.seleid := reportBy.BusinessLinkIds[1].seleid;
			SELF.tin := reportBy.tin; 
			SELF.email_address := reportBy.EmailAddress;
			SELF.appendedproviderid := reportBy.AppendedProviderId;
			SELF.lnpid := reportBy.lnpid; 
			SELF.npi := reportBy.NPI;
			SELF.ip_address := reportBy.IPAddress; 
			SELF.device_id := reportBy.DeviceId;
			SELF.professionalid := reportBy.ProfessionalId;
			SELF.bank_routing_number := reportBy.BankRoutingNumber; 
			SELF.bank_account_number := reportBy.BankAccountNumber; 
			SELF.dl_state := reportBy.DriversLicenseState; 
			SELF.dl_number := reportBy.DriversLicenseNumber; 
			SELF.geo_lat := reportBy.GeoLocation.Latitude; 
			SELF.geo_long := reportBy.GeoLocation.Longitude;
			SELF := [];
		END;

		ds_xml_in := dataset([xform_batch_in()]);
		//Upper Case, add acctno, and clean input address 
		BatchShare.MAC_SequenceInput(ds_xml_in, ds_xml_in_seq);		
		BatchShare.MAC_CapitalizeInput(ds_xml_in_seq, ds_capital);
		BatchShare.MAC_CleanAddresses(ds_capital, ds_batch_in);

		RETURN ds_batch_in;
	END;
	
	batch_params_mod := FraudGovPlatform_Services.IParam.getBatchParams();
	report_mod := GetReportModule(ReportBy);

	// **************************************************************************************
	// Append DID for Input PII
	// **************************************************************************************	  
	ds_batch_in_with_did := BatchShare.MAC_Get_Scored_DIDs(report_mod, batch_params_mod, usePhone:=TRUE);

	tmp := FraudGovPlatform_Services.ReportRecords(ds_batch_in_with_did, batch_params_mod, MaxVelocities, MaxKnownFrauds);
	
	//Final iESP Form Conversion
	iesp.ECL2ESP.Marshall.MAC_Marshall_Results(tmp.esdl_out, results, iesp.fraudgovreport.t_FraudGovReportResponse);
																																											 
	// Royalties := Royalty.RoyaltyFDNCoRR.GetOnlineRoyalties(tmp);
	
	output(tmp.ds_royalties, NAMED('RoyaltySet'));
	output(results, NAMED('Results'));
	
ENDMACRO;
