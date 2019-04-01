/*--SOAP--
<message name="ReportService">
    <part name="FraudGovReportRequest" type="tns:XmlDataSet" cols="80" rows="30"/>
</message>
*/

IMPORT BatchShare,doxie, FraudShared_Services, iesp, WSInput;

EXPORT ReportService() := MACRO
  #CONSTANT ('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
	#CONSTANT ('FraudPlatform', 'FraudGov');

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
	IF(FraudGovUser.IndustryTypeName = '', FraudShared_Services.Utilities.FailMeWithCode(ut.constants_MessageCodes.FRAUDGOV_INDUSTRY_TYPE));
	IF(FraudGovUser.ProductCode = 0, FraudShared_Services.Utilities.FailMeWithCode(ut.constants_MessageCodes.FRAUDGOV_PRODUCT_CODE));
	// **************************************************************************************
	
	MaxVelocities := MAP( ~Options.IsOnline and Options.MaxVelocities > 0 => MIN(Options.MaxVelocities, iesp.Constants.FraudGov.MAX_COUNT_VELOCITY),
												~Options.IsOnline and Options.MaxVelocities = 0 => iesp.Constants.FraudGov.MAX_COUNT_VELOCITY,
												0);
											 
	MaxKnownFrauds := MAP(~Options.IsOnline and Options.MaxKnownRisks > 0 => MIN(Options.MaxKnownRisks, iesp.Constants.FraudGov.MAX_COUNT_KNOWN_RISK),
												~Options.IsOnline and Options.MaxKnownRisks = 0 => iesp.Constants.FraudGov.MAX_COUNT_KNOWN_RISK,
												0);
												
	MaxCriminals := MAP(~Options.IsOnline and Options.MaxCriminals > 0 => MIN(Options.MaxCriminals, iesp.Constants.FraudGov.MAX_COUNT_CRIMINAL),
												~Options.IsOnline and Options.MaxCriminals = 0 => iesp.Constants.FraudGov.MAX_COUNT_CRIMINAL,
												0);
												
	MaxRedFlags := MAP(~Options.IsOnline and Options.MaxRedFlags > 0 => MIN(Options.MaxRedFlags, iesp.Constants.FraudGov.MAX_COUNT_RED_FLAG),
												~Options.IsOnline and Options.MaxRedFlags = 0 => iesp.Constants.FraudGov.MAX_COUNT_RED_FLAG,
												0);
	
	MaxGlobalWatchLists := MAP(~Options.IsOnline and Options.MaxGlobalWatchLists > 0 => MIN(Options.MaxGlobalWatchLists, iesp.Constants.FraudGov.MAX_COUNT_GLOBAL_WATCHLIST),
												~Options.IsOnline and Options.MaxGlobalWatchLists = 0 => iesp.Constants.FraudGov.MAX_COUNT_GLOBAL_WATCHLIST,
												0);
												
	MaxIndicatorAttributes := MAP(Options.IsOnline and Options.MaxIndicatorAttributes > 0 => MIN(Options.MaxIndicatorAttributes, iesp.Constants.FraudGov.MAX_COUNT_INDICATOR_ATTRIBUTE),
												Options.IsOnline and Options.MaxIndicatorAttributes = 0 => iesp.Constants.FraudGov.MAX_COUNT_INDICATOR_ATTRIBUTE,
												0);
												
	MaxScoreBreakdown := MAP(Options.IsOnline and Options.MaxScoreBreakdown > 0 => MIN(Options.MaxScoreBreakdown, iesp.Constants.FraudGov.MAX_COUNT_SCORE_BREAKDOWN),
												Options.IsOnline and Options.MaxScoreBreakdown = 0 => iesp.Constants.FraudGov.MAX_COUNT_SCORE_BREAKDOWN,
												0);
												
	MaxAssociatedIdentities := MAP(Options.IsOnline and Options.MaxAssociatedIdentities > 0 => MIN(Options.MaxAssociatedIdentities, iesp.Constants.FraudGov.MAX_COUNT_ASSOCIATED_IDENTITY),
												Options.IsOnline and Options.MaxAssociatedIdentities = 0 => iesp.Constants.FraudGov.MAX_COUNT_ASSOCIATED_IDENTITY,
												0);
												
  MaxAssociatedAddresses := MAP(Options.IsOnline and Options.MaxAssociatedAddresses > 0 => MIN(Options.MaxAssociatedAddresses, iesp.Constants.FraudGov.MAX_COUNT_ASSOCIATED_ADDRESS),
												Options.IsOnline and Options.MaxAssociatedAddresses = 0 => iesp.Constants.FraudGov.MAX_COUNT_ASSOCIATED_ADDRESS,
												0);
												
	MaxRelatedClusters := MAP(Options.IsOnline and Options.MaxRelatedClusters > 0 => MIN(Options.MaxRelatedClusters, iesp.Constants.FraudGov.MAX_COUNT_CLUSTER),
												Options.IsOnline and Options.MaxRelatedClusters = 0 => iesp.Constants.FraudGov.MAX_COUNT_CLUSTER,
												0);
	
	MaxTimelineDetails := MAP(Options.IsOnline and Options.MaxTimelineDetails > 0 => MIN(Options.MaxTimelineDetails, iesp.Constants.FraudGov.MAX_COUNT_TIMELINE_DETAILS),
												Options.IsOnline and Options.MaxTimelineDetails = 0 => iesp.Constants.FraudGov.MAX_COUNT_TIMELINE_DETAILS,
												0);

	#STORED('AppendBest', Options.AppendBest);
	#STORED('DIDScoreThreshold', Options.DIDScoreThreshold);
	#STORED('GlobalCompanyId',	FraudGovUser.GlobalCompanyId);
	#STORED('IndustryTypeName', FraudGovUser.IndustryTypeName);
	#STORED('ProductCode',FraudGovUser.ProductCode);
	#STORED('AgencyVerticalType', Options.AgencyVerticalType);
	#STORED('AgencyCounty',  Options.AgencyCounty);
	#STORED('AgencyState',  Options.AgencyState);
	#STORED('IsOnline',	Options.IsOnline);
	#STORED('useAllSearchFields',	Options.useAllSearchFields);
	#STORED('MaxVelocities', MaxVelocities);
	#STORED('MaxKnownFrauds', MaxKnownFrauds);
	#STORED('MaxCriminals', MaxCriminals);
	#STORED('MaxRedFlags', MaxRedFlags);
	#STORED('MaxGlobalWatchLists', MaxGlobalWatchLists);
	#STORED('MaxIndicatorAttributes', MaxIndicatorAttributes);
	#STORED('MaxScoreBreakdown', MaxScoreBreakdown);
	#STORED('MaxAssociatedIdentities', MaxAssociatedIdentities);
	#STORED('MaxAssociatedAddresses', MaxAssociatedAddresses);
	#STORED('MaxRelatedClusters', MaxRelatedClusters);
	#STORED('MaxTimelineDetails', MaxTimelineDetails);

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
			//removing assigment of parsed fields, because we want to clean the address in the same way as search service based on streetaddress1. 
			//the address cleaning is happening few line below by calling "MAC_CleanAddresses" where streetaddress1 is broken into cleaned parsed fields.
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
			SELF.bank_routing_number := reportBy.BankInformation.BankRoutingNumber; 
			SELF.bank_account_number := reportBy.BankInformation.BankAccountNumber; 
			SELF.dl_state := reportBy.DriversLicense.DriversLicenseState; 
			SELF.dl_number := reportBy.DriversLicense.DriversLicenseNumber; 
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
	
	report_mod := FraudGovPlatform_Services.IParam.getBatchParams();
	report_in := GetReportModule(ReportBy);

	hasName := IF(report_in[1].name_last != '' OR ReportBy.Name.Full != '', 1,0);
	hasAddress := IF(report_in[1].prim_name != '' AND report_in[1].prim_range != '' AND
				  ((report_in[1].p_city_name != '' AND report_in[1].st != '') OR report_in[1].z5 != ''),
				  1,0);
	hasMailingAddress := IF((report_in[1].mailing_addr != '' OR 
								(report_in[1].mailing_prim_name != '' AND report_in[1].mailing_prim_range != '')) AND
				  			((report_in[1].mailing_p_city_name != '' AND report_in[1].mailing_st != '') OR report_in[1].mailing_z5 != ''),
				  			1,0);
	hasLexId := IF(report_in[1].did > 0,1,0);
	hasSsn := IF(report_in[1].ssn != '',1,0);
	hasBankAccount := IF(report_in[1].bank_account_number != '', 1,0);
	hasDeviceId := IF(report_in[1].device_id != '', 1,0);
	hasDriversLicense := IF(report_in[1].dl_number != '', 1,0);
	hasGeoLocation := IF(report_in[1].geo_lat != '' AND report_in[1].geo_long != '', 1,0);
	hasIpAddress := IF(report_in[1].ip_address != '', 1,0);
	hasPhone := IF(report_in[1].phoneno != '', 1,0);
	hasEmail := IF(report_in[1].email_address != '', 1,0);

	inputCount := hasName + hasAddress + hasMailingAddress + hasLexId + hasSsn + hasBankAccount + hasDeviceId + hasDriversLicense + hasGeoLocation + hasIpAddress + hasPhone + hasEmail;
	
	BOOLEAN isValidDate := FraudGovPlatform_Services.Functions.IsValidInputDate(reportBy.DOB);
	
	//When Options.IsOnline is FALSE, we don't use the validation logic, because the API clients use the ReportService
	//for searches, not just card details.
	isValidInput := (inputCount = 1 OR ~Options.IsOnline OR Options.UseAllSearchFields) AND isValidDate;

	// **************************************************************************************
	// Append DID for Input PII
	// **************************************************************************************	  
	ds_in_with_did := BatchShare.MAC_Get_Scored_DIDs(report_in, report_mod, usePhone:=TRUE);
	
	ds_in_final := IF(Options.IsOnline, report_in, ds_in_with_did);

	ds_reportrecords := FraudGovPlatform_Services.ReportRecords(ds_in_final, 
																															report_mod,
																															Options.IsIdentityTestRequest, //This is not used as of now, left for future use.
																															Options.IsElementTestRequest //This is not used as of now, left for future use.
																															);
																															
	// Fail the Report service for API customer when record count is > 1. JIRA : GRP-2061
	IF(count(ds_reportrecords.esdl_out) > 1 AND ~Options.IsOnline ,FAIL(203,doxie.ErrorCodes(203)));
	
	//Final iESP Form Conversion
	iesp.ECL2ESP.Marshall.MAC_Marshall_Results(ds_reportrecords.esdl_out, results, iesp.fraudgovreport.t_FraudGovReportResponse);

	deltabase_inquiry_log := FraudGovPlatform_Services.Functions.GetDeltabaseLogDataSet(
														first_row,
														FraudGovPlatform_Services.Constants.ServiceType.REPORT);

	IF(isValidInput,
		PARALLEL( 
			output(results, NAMED('Results')),
			output(ds_reportrecords.ds_royalties, NAMED('RoyaltySet'))
		),
		FAIL(303,doxie.ErrorCodes(303)));
	
	IF(~Options.IsOnline,output(deltabase_inquiry_log, NAMED('log_delta__fraudgov_delta__identity')));
ENDMACRO;
