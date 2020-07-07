﻿/*--SOAP--
	<message name="SearchService">
			<part name="FraudGovSearchRequest" type="tns:XmlDataSet" cols="80" rows="30"/>
	</message>
*/

IMPORT Doxie, FraudShared_Services, FraudGovPlatform_Services, iesp, WSInput;

EXPORT SearchService() := MACRO
	#CONSTANT('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
	#CONSTANT('useonlybestdid',true);
	#CONSTANT('FraudPlatform', 'FraudGov');
	WSInput.MAC_FraudGovPlatform_Services_SearchService();

	ds_in					:= DATASET([],iesp.fraudgovsearch.t_FraudGovSearchRequest) : STORED('FraudGovSearchRequest', FEW);
	first_row 		:= ds_in[1] : INDEPENDENT;
	SearchBy  		:= GLOBAL (first_row.SearchBy); 
	Options 			:= GLOBAL (first_row.Options);
	FraudGovUser	:= GLOBAL (first_row.FraudGovUser);
	iesp.ECL2ESP.SetInputBaseRequest(first_row);
	
	#STORED('GlobalCompanyId', FraudGovUser.GlobalCompanyId);
	#STORED('IndustryTypeName', FraudGovUser.IndustryTypeName);
	#STORED('ProductCode',FraudGovUser.ProductCode); 
	#STORED('IsOnline', Options.IsOnline);

	// *********************************Validation*******************************************
	
	BOOLEAN ValidAmount := MAP(searchBy.AmountMin <> '' AND searchBy.AmountMax = '' => TRUE,
														 searchBy.AmountMin = '' AND searchBy.AmountMax <> '' => TRUE,
														 searchBy.AmountMin <> '' AND searchBy.AmountMax <> '' AND searchBy.AmountMin <= searchBy.AmountMax => TRUE, FALSE);
	
	BOOLEAN isMinimumInput := searchBy.Name.Last <> '' OR searchBy.SSN <> '' OR searchBy.Phone10 <> '' OR searchBy.UniqueId <> '' OR 
														searchBy.EmailAddress <> '' OR searchBy.DriversLicense.DriversLicenseNumber <> '' OR
														searchBy.HouseholdID <> '' OR searchBy.CustomerPersonId <> ''  OR searchBy.DeviceSerialNumber <> '' OR 
														ValidAmount OR searchBy.BankName <> '' OR searchBy.BankInformation.BankRoutingNumber <> '' OR
														searchBy.BankInformation.BankAccountNumber <> '' OR searchBy.ISPName <> '' OR searchBy.MACAddress <> '' OR searchBy.DeviceId <> '' OR searchBy.IPAddress <> '' OR
														(iesp.ECL2ESP.t_DateToString8(searchBy.TransactionStartDate)  <> '' AND iesp.ECL2ESP.t_DateToString8(searchBy.TransactionEndDate) <> '') OR
														searchBy.Address.StreetAddress1 <> '' OR (searchBy.Address.StreetName <> '' AND ((searchBy.Address.City <> '' AND searchBy.Address.State <> '') OR searchBy.Address.Zip5 <> ''));
														
	BOOLEAN isMinimumForRINID := searchBy.Name.Last <> '' AND searchBy.Name.First <> '' AND searchBy.SSN <> '' AND
															 searchBy.DOB.Year <> 0 AND searchBy.DOB.Month <> 0 AND searchBy.DOB.Day <> 0;

	BOOLEAN isValidDate := FraudGovPlatform_Services.Functions.IsValidInputDate(searchby.DOB) AND
												 FraudGovPlatform_Services.Functions.IsValidInputDate(searchby.TransactionStartDate) AND
												 FraudGovPlatform_Services.Functions.IsValidInputDate(searchby.TransactionEndDate);

	//Checking that gc_id, industry type, and product code have some values - they are required.
	IF(FraudGovUser.GlobalCompanyId = 0, FraudShared_Services.Utilities.FailMeWithCode(ut.constants_MessageCodes.FRAUDGOV_GC_ID));
	IF(FraudGovUser.IndustryTypeName = '', FraudShared_Services.Utilities.FailMeWithCode(ut.constants_MessageCodes.FRAUDGOV_INDUSTRY_TYPE));
	IF(FraudGovUser.ProductCode = 0, FraudShared_Services.Utilities.FailMeWithCode(ut.constants_MessageCodes.FRAUDGOV_PRODUCT_CODE));
	// **************************************************************************************

	GetSearchModule(iesp.fraudgovsearch.t_FraudGovSearchBy searchBy) := FUNCTION
		FraudShared_Services.Layouts.BatchInExtended_rec xform_batch_in() := TRANSFORM
			SELF.acctno := '1';	//Input will always be batch of 1 record. 
			SELF.name_first := searchBy.Name.First;
			SELF.name_middle := searchBy.Name.Middle;
			SELF.name_last := searchBy.Name.Last;
			SELF.name_suffix := searchBy.Name.Suffix; 
			SELF.addr := searchBy.Address.StreetAddress1;
			SELF.predir := searchBy.Address.StreetPredirection;
			SELF.prim_range := searchBy.Address.StreetNumber;
			SELF.prim_name := searchBy.Address.StreetName;
			SELF.addr_suffix := searchBy.Address.StreetSuffix;
			SELF.postdir := searchBy.Address.StreetPostDirection;
			SELF.unit_desig := searchBy.Address.UnitDesignation;
			SELF.sec_range := searchBy.Address.UnitNumber;
			SELF.p_city_name := searchBy.Address.City; 
			SELF.st := searchBy.Address.State; 
			SELF.z5 := searchBy.Address.Zip5; 
			SELF.mailing_addr := searchBy.MailingAddress.StreetAddress1;
			SELF.mailing_prim_range := searchBy.MailingAddress.StreetPredirection;
			SELF.mailing_predir := searchBy.MailingAddress.StreetNumber;
			SELF.mailing_prim_name := searchBy.MailingAddress.StreetName;
			SELF.mailing_addr_suffix := searchBy.MailingAddress.StreetSuffix;
			SELF.mailing_postdir := searchBy.MailingAddress.StreetPostDirection;
			SELF.mailing_unit_desig := searchBy.MailingAddress.UnitDesignation;
			SELF.mailing_sec_range := searchBy.MailingAddress.UnitNumber;
			SELF.mailing_p_city_name := searchBy.MailingAddress.City; 
			SELF.mailing_st := searchBy.MailingAddress.State; 
			SELF.mailing_z5 := searchBy.MailingAddress.Zip5; 			
			SELF.dob := iesp.ECL2ESP.t_DateToString8(searchBy.DOB);
			SELF.ssn := searchBy.SSN;
			SELF.phoneno := searchBy.Phone10;
			SELF.did := (INTEGER)searchBy.UniqueId; 
			SELF.email_address := searchBy.EmailAddress;
			SELF.dl_number := searchBy.DriversLicense.DriversLicenseNumber; 
			SELF.dl_state := searchBy.DriversLicense.DriversLicenseState; 
			SELF.ProgramCode := searchBy.ProgramCode;
			SELF.HouseholdID := searchBy.HouseholdID;
			SELF.CustomerPersonId := searchBy.CustomerPersonId;
			SELF.TransactionStartDate := iesp.ECL2ESP.t_DateToString8(searchBy.TransactionStartDate);
			SELF.TransactionEndDate := iesp.ECL2ESP.t_DateToString8(searchBy.TransactionEndDate);
			SELF.AmountMin := searchBy.AmountMin;
			SELF.AmountMax := searchBy.AmountMax;
			SELF.BankName := searchBy.BankName;
			SELF.bank_routing_number := searchBy.BankInformation.BankRoutingNumber;
			SELF.bank_account_number := searchBy.BankInformation.BankAccountNumber;
			SELF.ISPname := searchBy.ISPName;
			SELF.ip_address := searchBy.IPAddress; 
			SELF.MACAddress := searchBy.MACAddress; 
			SELF.device_id := searchBy.DeviceId;
			SELF.DeviceSerialNumber := searchBy.DeviceSerialNumber;
			SELF.appendedproviderid := searchBy.AppendedProviderId;
			SELF.lnpid := searchBy.lnpid; 
			SELF.tin := searchBy.tin; 
			SELF.npi := searchBy.NPI;
			SELF.professionalid := searchBy.ProfessionalId;
			SELF.geo_lat := searchBy.GeoLocation.Latitude; 
			SELF.geo_long := searchBy.GeoLocation.Longitude;
			SELF.ultid := searchBy.BusinessLinkIds[1].ultid; 
			SELF.orgid := searchBy.BusinessLinkIds[1].orgid; 
			SELF.seleid := searchBy.BusinessLinkIds[1].seleid;
			SELF := [];
		END;

		ds_xml_in := dataset([xform_batch_in()]);
		//Upper Case, add acctno, and clean input address 
		BatchShare.MAC_SequenceInput(ds_xml_in, ds_xml_in_seq);		
		BatchShare.MAC_CapitalizeInput(ds_xml_in_seq, ds_capital);
		BatchShare.MAC_CleanAddresses(ds_capital, ds_batch_in);

		RETURN ds_batch_in;
	END;
 
	batch_params := FraudGovPlatform_Services.IParam.getBatchParams();
	search_mod := GetSearchModule(first_row.SearchBy);

	//Adding Options.IsTestRequest. When Options.IsTestRequest = TRUE, the service returns mockedup data in the
	//... roxie response, to help ESP and Web to continue with the development until we find a real way to return the data.
	ds_searchrecords := FraudGovPlatform_Services.SearchRecords(search_mod, batch_params, Options.IsTestRequest);
	
	search_records := ds_searchrecords.ds_results;
	adlDIDFound := ds_searchrecords.DidFoundInPR;
	ds_adl := ds_searchrecords.ds_adl;
	adl_did_input_PII := ds_searchrecords.ds_in_w_adl_did_appended;

	iesp.fraudgovsearch.t_FraudGovSearchResponse final_transform_t_FraudGovSearchResponse() := TRANSFORM
		SELF._Header	:= iesp.ECL2ESP.GetHeaderRow(),
		SELF.RecordCount := COUNT(search_records),
		SELF.InputEcho:= SearchBy,
		SELF.Records	:= search_records
	END;

	results := DATASET([final_transform_t_FraudGovSearchResponse()]);
	
	/*-------- Following code is to generate Deltabase Log Input ---------------------*/
	
	//Per GRP-2060, we save RINID (stored in the lexid field), when the user entered full DOB, SSN and full name
	// as search criteria and we couldn't resolve to a lexid from publicrecords
	// but we found a SINGLE identity record in the contributory data
	useRINID := COUNT(search_records(RecordType=FraudGovPlatform_Services.Constants.RecordType.IDENTITY)) = 1 AND isMinimumForRINID AND ~adlDIDFound AND adl_did_input_PII[1].did = 0;
	
	// GRP-3288
	// Following booleans are created for the rules listed in GRP-3288. These will be used to conditionally fill Did and PII.
	BOOLEAN isPII_Input := searchBy.Name.Last <> '' OR searchBy.SSN <> '' OR searchBy.Phone10 <> '' OR
												 searchBy.Address.StreetAddress1 <> '' OR (searchBy.Address.StreetName <> '' AND 
													 ((searchBy.Address.City <> '' AND searchBy.Address.State <> '') OR searchBy.Address.Zip5 <> ''));
	//Condition 2(a)
	BOOLEAN PIIDid_W_ValidDid_PIINoSameDid := SearchBy.UniqueId <> '' AND isPII_Input AND adlDIDFound AND (adl_did_input_PII[1].did = 0 OR (SearchBy.UniqueId  <> (string)adl_did_input_PII[1].did));
	
	delta_log_input := PROJECT(first_row,
														TRANSFORM(iesp.fraudgovsearch.t_FraudGovSearchRequest,
																SELF.SearchBy.UniqueId := 
																	IF(~useRINID ,
																			(string) ds_adl[1].did, 
																			search_records(RecordType=FraudGovPlatform_Services.Constants.RecordType.IDENTITY)[1].ElementValue);
																SELF.SearchBy.Name := 
																	IF(PIIDid_W_ValidDid_PIINoSameDid, ROW([], iesp.share.t_Name),  LEFT.SearchBy.Name);
																SELF.SearchBy.Address := 
																	IF(PIIDid_W_ValidDid_PIINoSameDid, ROW([], iesp.share.t_Address),  LEFT.SearchBy.Address);
																SELF.SearchBy.DOB := 
																	IF(PIIDid_W_ValidDid_PIINoSameDid, ROW([], iesp.share.t_Date),  LEFT.SearchBy.DOB);
																SELF.SearchBy.SSN := 
																	IF(PIIDid_W_ValidDid_PIINoSameDid, '',  LEFT.SearchBy.SSN);
																SELF.SearchBy.Phone10 := 
																	IF(PIIDid_W_ValidDid_PIINoSameDid, '',  LEFT.SearchBy.Phone10);
																SELF := LEFT
														));

	deltabase_inquiry_log := FraudGovPlatform_Services.Functions.GetDeltabaseLogDataSet(
														delta_log_input,
														FraudGovPlatform_Services.Constants.ServiceType.SEARCH);
														
	IF(~isValidDate, FAIL(303,doxie.ErrorCodes(303)));

	IF (isMinimumInput, 
				OUTPUT(results, named('Results')), 
				FAIL(301,doxie.ErrorCodes(301))
			);
			
	IF(~Options.Blind, OUTPUT(deltabase_inquiry_log, NAMED('log_delta__fraudgov_delta__identity')));
		
ENDMACRO;