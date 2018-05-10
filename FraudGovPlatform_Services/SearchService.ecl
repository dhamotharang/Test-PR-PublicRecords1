/*--SOAP--
	<message name="SearchService">
			<part name="FraudGovSearchRequest" type="tns:XmlDataSet" cols="80" rows="30"/>
	</message>
*/

IMPORT Doxie, FraudShared_Services, FraudGovPlatform_Services, iesp, WSInput;

EXPORT SearchService() := MACRO
		
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
	#STORED('FraudPlatform', Options.Platform);

	// *********************************Validation*******************************************
	
	BOOLEAN isMinimumInput := searchBy.Name.Last <> '' OR searchBy.SSN <> '' OR searchBy.Phone10 <> '' OR searchBy.UniqueId <> '' OR 
														searchBy.EmailAddress <> '' OR (searchBy.DriversLicenseNumber <> '' AND searchBy.DriversLicenseState <> '') OR
														searchBy.HouseholdID <> '' OR searchBy.CustomerPersonId <> ''  OR searchBy.DeviceSerialNumber <> '' OR 
														searchBy.AmountMin <> '' OR searchBy.AmountMax <> '' OR searchBy.BankName <> '' OR searchBy.BankRoutingNumber <> '' OR
														searchBy.BankAccountNumber <> '' OR searchBy.ISPName <> '' OR searchBy.MACAddress <> '' OR searchBy.DeviceId <> '' OR searchBy.IPAddress <> '' OR
														(iesp.ECL2ESP.t_DateToString8(searchBy.TransactionStartDate)  <> '' AND iesp.ECL2ESP.t_DateToString8(searchBy.TransactionEndDate) <> '') OR
														searchBy.Address.StreetAddress1 <> '' OR (searchBy.Address.StreetName <> '' AND ((searchBy.Address.City <> '' AND searchBy.Address.State <> '') OR searchBy.Address.Zip5 <> ''));
	
	//Checking that gc_id, industry type, and product code have some values - they are required.
	IF(FraudGovUser.GlobalCompanyId = 0, FraudShared_Services.Utilities.FailMeWithCode(ut.constants_MessageCodes.FRAUDGOV_GC_ID));
	IF(FraudGovUser.IndustryTypeName = '', FraudShared_Services.Utilities.FailMeWithCode(ut.constants_MessageCodes.FRAUDGOV_INDUSTRY_TYPE));
	IF(FraudGovUser.ProductCode = 0, FraudShared_Services.Utilities.FailMeWithCode(ut.constants_MessageCodes.FRAUDGOV_PRODUCT_CODE));
	// **************************************************************************************

	GetSearchModule(iesp.fraudgovsearch.t_FraudGovSearchBy searchBy) := FUNCTION
		FraudShared_Services.Layouts.BatchInExtended_rec xform_batch_in() := TRANSFORM
			SELF.acctno := '1';
			// SELF.name_Full := searchBy.Name.Full; 
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
			// SELF.sec_range := searchBy.Address.UnitNumber;
			SELF.p_city_name := searchBy.Address.City; 
			SELF.st := searchBy.Address.State; 
			SELF.z5 := searchBy.Address.Zip5; 
			SELF.dob := iesp.ECL2ESP.t_DateToString8(searchBy.DOB);
			SELF.ssn := searchBy.SSN;
			SELF.phoneno := searchBy.Phone10;
			SELF.did := (INTEGER)searchBy.UniqueId; 
			SELF.email_address := searchBy.EmailAddress;
			SELF.dl_number := searchBy.DriversLicenseNumber; 
			SELF.dl_state := searchBy.DriversLicenseState; 
			SELF.ProgramCode := searchBy.ProgramCode;
			SELF.HouseholdID := searchBy.HouseholdID;
			SELF.CustomerPersonId := searchBy.CustomerPersonId;
			SELF.TransactionStartDate := iesp.ECL2ESP.t_DateToString8(searchBy.TransactionStartDate);
			SELF.TransactionEndDate := iesp.ECL2ESP.t_DateToString8(searchBy.TransactionEndDate);
			SELF.AmountMin := searchBy.AmountMin;
			SELF.AmountMax := searchBy.AmountMax;
			SELF.BankName := searchBy.BankName;
			SELF.bank_routing_number := searchBy.BankRoutingNumber;
			SELF.bank_account_number := searchBy.BankAccountNumber;
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

	search_records := FraudGovPlatform_Services.SearchRecords(search_mod, batch_params, Options.IsOnline);

	iesp.fraudgovsearch.t_FraudGovSearchResponse final_transform_t_FraudGovSearchResponse() := TRANSFORM
			SELF._Header	:= iesp.ECL2ESP.GetHeaderRow(),
			SELF.RecordCount := COUNT(search_records);
			SELF.InputEcho:= SearchBy,
			SELF.Records	:= search_records
	END;

	results := DATASET([final_transform_t_FraudGovSearchResponse()]) ;

	IF (isMinimumInput, 
				OUTPUT(results, named('Results')),
				FAIL(301,doxie.ErrorCodes(301))
			);
		
ENDMACRO;