IMPORT AutoheaderV2, BatchShare, FraudShared_Services, iesp, RiskIntelligenceNetwork_Services, WSInput;

EXPORT RealtimeAssessmentReportService() := MACRO
  
 WSInput.MAC_RiskIntelligenceNetwork_Services_RealtimeAssessmentReportService();

 #CONSTANT('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
 #CONSTANT('FraudPlatform', 'FraudGov');
  
 ds_in     := DATASET([], iesp.identityreport.t_IdentityReportRequest) : STORED('IdentityReportRequest', FEW);
 first_row := ds_in[1] : INDEPENDENT;
 ReportBy  := GLOBAL (first_row.ReportBy);
 Options   := GLOBAL (first_row.Options);
 RINUser   := GLOBAL (first_row.RINUser);
 iesp.ECL2ESP.SetInputBaseRequest(first_row);

 #STORED('GlobalCompanyId', RINUser.GlobalCompanyId);
 #STORED('IndustryTypeName', RINUser.IndustryTypeName);
 #STORED('ProductCode',RINUser.ProductCode); 
 #STORED('IsOnline', Options.IsOnline);
             
 //Checking that gc_id, industry type, and product code have some values - they are required.
 IF(RINUser.GlobalCompanyId = 0, FraudShared_Services.Utilities.FailMeWithCode(ut.constants_MessageCodes.FRAUDGOV_GC_ID));
 IF(RINUser.IndustryTypeName = '', FraudShared_Services.Utilities.FailMeWithCode(ut.constants_MessageCodes.FRAUDGOV_INDUSTRY_TYPE));
 IF(RINUser.ProductCode = 0, FraudShared_Services.Utilities.FailMeWithCode(ut.constants_MessageCodes.FRAUDGOV_PRODUCT_CODE));
 // **************************************************************************************

 isMinimumInput := Options.IsOnline AND reportBy.UniqueId <> '';

 FraudShared_Services.Layouts.BatchInExtended_rec xform_ds_xml_in(iesp.identityreport.t_RINIdentityReportBy reportBy) := TRANSFORM
  SELF.acctno := '1';
  SELF.name_first := reportBy.Name.First;
  SELF.name_middle := reportBy.Name.Middle;
  SELF.name_last := reportBy.Name.Last;
  SELF.name_suffix := reportBy.Name.Suffix; 
  SELF.addr := reportBy.Address.StreetAddress1;
  SELF.predir := reportBy.Address.StreetPredirection;
  SELF.prim_range := reportBy.Address.StreetNumber;
  SELF.prim_name := reportBy.Address.StreetName;
  SELF.addr_suffix := reportBy.Address.StreetSuffix;
  SELF.postdir := reportBy.Address.StreetPostDirection;
  SELF.unit_desig := reportBy.Address.UnitDesignation;
  SELF.sec_range := reportBy.Address.UnitNumber;
  SELF.p_city_name := reportBy.Address.City; 
  SELF.st := reportBy.Address.State; 
  SELF.z5 := reportBy.Address.Zip5;
  SELF.dob := iesp.ECL2ESP.t_DateToString8(reportBy.DOB);
  SELF.ssn := reportBy.SSN;
  SELF.phoneno := reportBy.Phone10;
  SELF.did := (INTEGER)reportBy.UniqueId; 
  SELF.email_address := reportBy.EmailAddress;
  SELF.dl_number := reportBy.DriverLicense.DriverLicenseNumber; 
  SELF.dl_state := reportBy.DriverLicense.DriverLicenseState; 
  SELF.ProgramCode := reportBy.ProgramCode;
  SELF.HouseholdID := reportBy.HouseholdID;
  SELF.CustomerPersonId := reportBy.CustomerPersonId;
  SELF.AmountMin := reportBy.AmountMin;
  SELF.AmountMax := reportBy.AmountMax;
  SELF.BankName := reportBy.BankInformation.BankName;
  SELF.bank_routing_number := reportBy.BankInformation.BankRoutingNumber;
  SELF.bank_account_number := reportBy.BankInformation.BankAccountNumber;
  SELF.ISPname := reportBy.ISPName;
  SELF.ip_address := reportBy.IPAddress; 
  SELF.MACAddress := reportBy.MACAddress; 
  SELF.device_id := reportBy.DeviceId;
  SELF.DeviceSerialNumber := reportBy.DeviceSerialNumber;
  SELF := [];
 END;

 ds_xml_in := dataset([xform_ds_xml_in(ReportBy)]);
 //Upper Case, add acctno, and clean input address 
 BatchShare.MAC_SequenceInput(ds_xml_in, ds_xml_in_seq);  
 BatchShare.MAC_CapitalizeInput(ds_xml_in_seq, ds_capital);
 BatchShare.MAC_CleanAddresses(ds_capital, report_input); 

 report_params := RiskIntelligenceNetwork_Services.IParam.getParams();

 ds_reportrecords := RiskIntelligenceNetwork_Services.RealtimeAssessmentReportRecords(report_input, report_params);

 iesp.identityreport.t_IdentityReportResponse final_transform_ReportResponse() := TRANSFORM
  SELF._Header := iesp.ECL2ESP.GetHeaderRow(),
  SELF.RecordCount:= COUNT(ds_reportrecords),
  SELF.InputEcho := reportBy,
  SELF.Records := ds_reportrecords
 END;

 results := DATASET([final_transform_ReportResponse()]);
 
 IF(isMinimumInput, OUTPUT(results, NAMED('Results')), FAIL(RiskIntelligenceNetwork_Services.Constants.INSUFFICIENT_INPUT_CODE, 
                                                            RiskIntelligenceNetwork_Services.Constants.INSUFFICIENT_INPUT_MSG));

ENDMACRO;