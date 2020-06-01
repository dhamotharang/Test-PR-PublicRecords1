IMPORT AutoheaderV2, BatchShare, FraudShared_Services, iesp, RiskIntelligenceNetwork_Services, WSInput;

EXPORT SearchService() := MACRO

 WSInput.MAC_RiskIntelligenceNetwork_Services_SearchService();

 #CONSTANT('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
 #CONSTANT('useonlybestdid',true);
 #CONSTANT('FraudPlatform', 'FraudGov');

 ds_in     := DATASET([], iesp.identitysearch.t_IdentitySearchRequest) : STORED('IdentitySearchRequest', FEW);
 first_row := ds_in[1] : INDEPENDENT;
 SearchBy  := GLOBAL (first_row.SearchBy);
 Options   := GLOBAL (first_row.Options);
 RINUser   := GLOBAL (first_row.RINUser);
 iesp.ECL2ESP.SetInputBaseRequest(first_row);

 #STORED('GlobalCompanyId', RINUser.GlobalCompanyId);
 #STORED('IndustryTypeName', RINUser.IndustryTypeName);
 #STORED('ProductCode',RINUser.ProductCode); 
 #STORED('IsOnline', Options.IsOnline);

 ValidAmount := (searchBy.AmountMin <>'' AND searchBy.AmountMax = '') OR 
                ((REAL)searchBy.AmountMax >= (REAL)searchBy.AmountMin);
                      
 isValidDate := RiskIntelligenceNetwork_Services.Functions.IsValidInputDate(searchby.TransactionStartDate) AND
                RiskIntelligenceNetwork_Services.Functions.IsValidInputDate(searchby.TransactionEndDate);

 isMinimumInput := searchBy.Name.Last <> '' OR 
                   searchBy.SSN <> '' OR 
                   searchBy.Phone10 <> '' OR 
                   searchBy.UniqueId <> '' OR 
                   searchBy.EmailAddress <> '' OR 
                   searchBy.DriverLicense.DriverLicenseNumber <> '' OR
                   searchBy.HouseholdID <> '' OR 
                   searchBy.CustomerPersonId <> '' OR 
                   searchBy.DeviceSerialNumber <> '' OR 
                   searchBy.BankInformation.BankName <> '' OR 
                   searchBy.BankInformation.BankRoutingNumber <> '' OR
                   searchBy.BankInformation.BankAccountNumber <> '' OR 
                   searchBy.ISPName <> '' OR 
                   searchBy.MACAddress <> '' OR 
                   searchBy.DeviceId <> '' OR 
                   searchBy.IPAddress <> '' OR
                   (iesp.ECL2ESP.t_DateToString8(searchBy.TransactionStartDate)  <> '' AND iesp.ECL2ESP.t_DateToString8(searchBy.TransactionEndDate) <> '' AND isValidDate) OR
                   ((searchBy.Address.StreetAddress1 <> '' OR searchBy.Address.StreetName <> '') AND 
                   ((searchBy.Address.City <> '' AND searchBy.Address.State <> '') OR searchBy.Address.Zip5 <> '')) OR  
                   ValidAmount;

 //Checking that gc_id, industry type, and product code have some values - they are required.
 IF(RINUser.GlobalCompanyId = 0, FraudShared_Services.Utilities.FailMeWithCode(ut.constants_MessageCodes.FRAUDGOV_GC_ID));
 IF(RINUser.IndustryTypeName = '', FraudShared_Services.Utilities.FailMeWithCode(ut.constants_MessageCodes.FRAUDGOV_INDUSTRY_TYPE));
 IF(RINUser.ProductCode = 0, FraudShared_Services.Utilities.FailMeWithCode(ut.constants_MessageCodes.FRAUDGOV_PRODUCT_CODE));
 // **************************************************************************************

 FraudShared_Services.Layouts.BatchInExtended_rec xform_ds_xml_in(iesp.identitysearch.t_RINIdentitySearchBy searchBy) := TRANSFORM
  SELF.acctno := '1';
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
  SELF.dob := iesp.ECL2ESP.t_DateToString8(searchBy.DOB);
  SELF.ssn := searchBy.SSN;
  SELF.phoneno := searchBy.Phone10;
  SELF.did := (INTEGER)searchBy.UniqueId; 
  SELF.email_address := searchBy.EmailAddress;
  SELF.dl_number := searchBy.DriverLicense.DriverLicenseNumber; 
  SELF.dl_state := searchBy.DriverLicense.DriverLicenseState; 
  SELF.ProgramCode := searchBy.ProgramCode;
  SELF.HouseholdID := searchBy.HouseholdID;
  SELF.CustomerPersonId := searchBy.CustomerPersonId;
  SELF.AmountMin := searchBy.AmountMin;
  SELF.AmountMax := searchBy.AmountMax;
  SELF.BankName := searchBy.BankInformation.BankName;
  SELF.bank_routing_number := searchBy.BankInformation.BankRoutingNumber;
  SELF.bank_account_number := searchBy.BankInformation.BankAccountNumber;
  SELF.ISPname := searchBy.ISPName;
  SELF.ip_address := searchBy.IPAddress; 
  SELF.MACAddress := searchBy.MACAddress; 
  SELF.device_id := searchBy.DeviceId;
  SELF.DeviceSerialNumber := searchBy.DeviceSerialNumber;
  SELF := [];
 END;

 ds_xml_in := dataset([xform_ds_xml_in(SearchBy)]);
 //Upper Case, add acctno, and clean input address 
 BatchShare.MAC_SequenceInput(ds_xml_in, ds_xml_in_seq);  
 BatchShare.MAC_CapitalizeInput(ds_xml_in_seq, ds_capital);
 BatchShare.MAC_CleanAddresses(ds_capital, search_input); 

 search_params := RiskIntelligenceNetwork_Services.IParam.getParams();

 ds_searchrecords := RiskIntelligenceNetwork_Services.SearchRecords(search_input, search_params);

 iesp.identitysearch.t_IdentitySearchResponse final_transform_t_IdentitySearchResponse() := TRANSFORM
  SELF._Header := iesp.ECL2ESP.GetHeaderRow(),
  SELF.RecordCount:= COUNT(ds_searchrecords),
  SELF.InputEcho := SearchBy,
  SELF.Records := ds_searchrecords
 END;

 results := DATASET([final_transform_t_IdentitySearchResponse()]);

 IF(~isValidDate, FAIL(RiskIntelligenceNetwork_Services.Constants.INVALID_INPUT_CODE, 
                       RiskIntelligenceNetwork_Services.Constants.INVALID_INPUT_MSG));

 IF (isMinimumInput, OUTPUT(results, named('Results')), 
                        FAIL(RiskIntelligenceNetwork_Services.Constants.INSUFFICIENT_INPUT_CODE, 
                             RiskIntelligenceNetwork_Services.Constants.INSUFFICIENT_INPUT_MSG));
ENDMACRO;