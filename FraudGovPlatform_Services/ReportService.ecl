/*--SOAP--
<message name="SearchServiceFCRA">
    <part name="FraudGovReportRequest" type="tns:XmlDataSet" cols="80" rows="30"/>
</message>
*/

IMPORT BatchShare;

EXPORT ReportService() := MACRO

		//The following macro defines the field sequence on WsECL page of query. 
	  WSInput.MAC_FraudGovPlatform_Services_ReportService();
		
		rec_in := iesp.fraudgovplatform.t_FraudGovReportRequest;
		ds_in  := DATASET ([], rec_in) : STORED ('FraudGovReportRequest', FEW);
		first_row := ds_in[1] : independent;
		iesp.ECL2ESP.SetInputBaseRequest (first_row);
		
		MaxVelocities := MAP(first_row.options.IsOnline and first_row.options.MaxVelocities > 0 => MIN(first_row.options.MaxVelocities, iesp.Constants.FraudGov.MAX_COUNT_VELOCITY),
												 first_row.options.IsOnline and first_row.options.MaxVelocities = 0 => iesp.Constants.FraudGov.MAX_COUNT_VELOCITY,
												 ~first_row.options.IsOnline => FraudGovPlatform_Services.Constants.MAX_VELOCITIES,
												 0);
												 
		MaxKnownFrauds := MAP(first_row.options.IsOnline and first_row.options.MaxKnownFrauds > 0 => MIN(first_row.options.MaxKnownFrauds, iesp.Constants.FraudGov.MAX_COUNT_KNOWN_RISK),
												  first_row.options.IsOnline and first_row.options.MaxKnownFrauds = 0 => iesp.Constants.FraudGov.MAX_COUNT_KNOWN_RISK,
												 ~first_row.options.IsOnline => FraudGovPlatform_Services.Constants.MAX_KNOWN_FRAUDS,
												 0);
	
		#STORED('AppendBest', first_row.options.AppendBest);
		#STORED('DIDScoreThreshold', first_row.options.DIDScoreThreshold);
		#STORED('ProductCode',first_row.FDNUser.ProductCode);
		#STORED('GlobalCompanyId',	first_row.FDNUser.GlobalCompanyId);
		#STORED('IndustryType',	first_row.FDNUser.IndustryType);
		#STORED('AgencyVerticalType', first_row.options.AgencyVerticalType);
		#STORED('AgencyCounty',  first_row.options.AgencyCounty);
		#STORED('AgencyState',  first_row.options.AgencyState);
		#STORED('FraudPlatform',	first_row.options.Platform);
		#STORED('MaxVelocities', MaxVelocities);
		#STORED('MaxKnownFrauds', MaxKnownFrauds);

		GetReportModule(iesp.fraudgovplatform.t_FraudGovReportBy reportBy) := FUNCTION
	
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
	report_mod := GetReportModule(first_row.reportBy);

	// **************************************************************************************
 // Append DID for Input PII
 // **************************************************************************************	  
	ds_batch_in_with_did := BatchShare.MAC_Get_Scored_DIDs(report_mod, batch_params_mod, usePhone:=TRUE);

	tmp := FraudGovPlatform_Services.ReportRecords(ds_batch_in_with_did, batch_params_mod, MaxVelocities, MaxKnownFrauds);
	
	//Final iESP Form Conversion
	iesp.ECL2ESP.Marshall.MAC_Marshall_Results(tmp, 
																																											 results, 
																																											 iesp.fraudgovplatform.t_FraudGovReportResponse);
																																											 
	Royalties := Royalty.RoyaltyFDNCoRR.GetOnlineRoyalties(tmp,true);			
	
	output(Royalties, NAMED('RoyaltySet'));	
	output(results, NAMED('Results'));	
	
ENDMACRO;
