// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================
/*--INFO-- This service searches the FCRA LiensV2 files and OKC.*/

EXPORT LiensRetrievalServiceFCRA := MACRO

  IMPORT $, Address, AutoStandardI, doxie, iesp, Inquiry_AccLogs, FCRA, FFD,
         risk_indicators, Risk_Reporting, STD, WSInput;

  WSInput.MAC_Liensv2_LiensRetrievalServiceFCRA();
  
  //Get XML Input
  req_in := iesp.riskview_publicrecordretrieval.t_PublicRecordRetrievalRequest;
  in_req := DATASET([], req_in) : STORED('PublicRecordRetrievalRequest', FEW);

  first_row := in_req[1] : INDEPENDENT;
  search := GLOBAL(first_row.SearchBy);
  user := GLOBAL(first_row.User);
  option := GLOBAL(first_row.Options);

  iesp.ECL2ESP.SetInputBaseRequest(first_row);

  /* ************* Begin OUT OF BAND Scout Fields **************/
  STRING32 _LoginID := '' : STORED('_LoginID');
  outofbandCompanyID := '' : STORED('_CompanyID');
  STRING20 CompanyID := IF(user.CompanyId != '', user.CompanyId, outofbandCompanyID);
  STRING20 FunctionName := '' : STORED('_LogFunctionName');
  STRING50 ESPMethod := '' : STORED('_ESPMethodName');
  STRING10 InterfaceVersion := '' : STORED('_ESPClientInterfaceVersion');
  STRING5 DeliveryMethod := '' : STORED('_DeliveryMethod');
  STRING5 DeathMasterPurpose := '' : STORED('__deathmasterpurpose');
  STRING6 SSNMask := 'NONE' : STORED('SSNMask');
  STRING6 DOBMask := 'NONE' : STORED('DOBMask');
  BOOLEAN outOfBandDisableOutcomeTracking := FALSE : STORED('OutcomeTrackingOptOut');
  BOOLEAN DisableOutcomeTracking := outOfBandDisableOutcomeTracking OR user.OutcomeTrackingOptOut;
  BOOLEAN ArchiveOptIn := FALSE : STORED('instantidarchivingoptin');
  STRING outOfBandDataRestriction := risk_indicators.iid_constants.default_DataRestriction : STORED('DataRestrictionMask');
  STRING50 DataRestriction := IF(TRIM(user.DataRestrictionMask) <> '', user.DataRestrictionMask, outOfBandDataRestriction);
  STRING outOfBandDataPermission := '0000000000' : STORED('DataPermissionMask');
  STRING DataPermission := MAP(TRIM(user.DataPermissionMask) <> '' => user.DataPermissionMask,
                               TRIM(outOfBandDataPermission) <> '' => outOfBandDataPermission,
                                                                      Risk_Indicators.iid_constants.default_DataPermission);
  tmpDOB := iesp.ECL2ESP.DateToString(search.DOB);
  STRING8 DateOfBirth := IF(tmpDOB = '00000000', '', tmpDOB);
  STRING28 streetName := search.Address.StreetName;
  STRING10 streetNumber := search.Address.StreetNumber;
  STRING2 streetPreDirection := search.Address.StreetPreDirection;
  STRING2 streetPostDirection := search.Address.StreetPostDirection;
  STRING4 streetSuffix := search.Address.StreetSuffix;
  STRING8 UnitNumber := search.Address.UnitNumber;
  STRING10 UnitDesig := search.Address.UnitDesignation;
  STRING60 tempStreetAddr := Address.Addr1FromComponents(streetNumber, StreetPreDirection, streetName, StreetSuffix, StreetPostDirection, UnitDesig, UnitNumber);
  STRING60 in_streetAddress1 := IF(search.Address.StreetAddress1='', tempStreetAddr, search.Address.StreetAddress1);
  STRING60 in_streetAddress2 := search.Address.StreetAddress2;
  STRING120 streetAddr := TRIM(in_streetAddress1) + ' ' + TRIM(in_streetAddress2);
  outOfBandTestDataEnabled := FALSE : STORED('testDataEnabled');
  BOOLEAN TestDataEnabled := user.TestDataEnabled OR outOfBandTestDataEnabled;
  
  //Look up the industry by the company ID.
  Industry_Search := Inquiry_AccLogs.Key_Inquiry_industry_use_vertical_login(TRUE)(s_company_id = CompanyID AND s_product_id = (STRING)Risk_Reporting.ProductID.RiskView__Search_Service);
  /* ************* End Scout Fields **************/
  
  params := LiensV2_Services.IParam.GetLiensRetrievalParams(first_row);

  search_results := LiensV2_Services.LiensRetrieval_Records(params, in_req);
  
  test_srch := LiensV2_Services.LiensRetrieval_TestSeedFunction(search, params.DeferredTaskRequest,
                                                                params.FFDOptionsMask, params.TestDataTableName);
  
  response := IF(params.TestDataEnabled, test_srch, search_results);

   MAP( params.Invalid_FilingtypeID => FAIL(LiensV2_Services.Constants.LIENS_RETRIEVAL.Invalid_FilingtypeID_failure),
        ~params.InputOk =>FAIL(301, doxie.ErrorCodes(301)),
        params.InputOk => OUTPUT(response,NAMED('Results'))
      ) ;

    //Improved Scout Logging ~ Log to Deltabase
    Deltabase_Logging_prep := PROJECT(response,
      TRANSFORM(Risk_Reporting.Layouts.LOG_Deltabase_Layout_Record,
        SELF.company_id := (INTEGER)CompanyID,
        SELF.login_id := _LoginID,
        SELF.product_id := Risk_Reporting.ProductID.LiensV2_Services__LiensRetrievalServiceFCRA,
        SELF.function_name := FunctionName,
        SELF.esp_method := ESPMethod,
        SELF.interface_version := InterfaceVersion,
        SELF.delivery_method := DeliveryMethod,
        SELF.date_added := (STRING8)STD.Date.Today(),
        SELF.death_master_purpose := DeathMasterPurpose,
        SELF.ssn_mask := SSNMask,
        SELF.dob_mask := DOBMask,
        SELF.dl_mask := (STRING)(INTEGER)user.DLMask,
        SELF.exclude_dmv_pii := (STRING)(INTEGER)user.ExcludeDMVPII,
        SELF.scout_opt_out := (STRING)(INTEGER)DisableOutcomeTracking,
        SELF.archive_opt_in := (STRING)(INTEGER)ArchiveOptIn,
        SELF.glb := (INTEGER)user.GLBPurpose,
        SELF.dppa := (INTEGER)user.DLPurpose,
        SELF.data_restriction_mask := DataRestriction,
        SELF.data_permission_mask := DataPermission,
        SELF.industry := Industry_Search[1].Industry,
        SELF.i_ssn := search.SSN,
        SELF.i_dob := DateOfBirth,
        SELF.i_name_full := search.Name.Full,
        SELF.i_name_first := search.Name.First,
        SELF.i_name_last := search.Name.Last,
        SELF.i_address := streetAddr,
        SELF.i_city := search.Address.City,
        SELF.i_state := search.Address.State,
        SELF.i_zip := search.Address.Zip5,
        SELF.i_home_phone := search.Phone,
        // Response data
        SELF.o_lexid := (INTEGER)LEFT.Consumer.LexId,
        SELF := LEFT,
        SELF := [] ));
    Deltabase_Logging := DATASET([{Deltabase_Logging_prep}], Risk_Reporting.Layouts.LOG_Deltabase_Layout);
    
    //Improved Scout Logging
    IF(~DisableOutcomeTracking AND ~TestDataEnabled AND response[1].Consumer.Inquiry != ROW([], iesp.share_fcra.t_FcraConsumerInquiry), OUTPUT(Deltabase_Logging, NAMED('LOG_log__mbs__fcra_transaction__log__scout')));

 ENDMACRO;
