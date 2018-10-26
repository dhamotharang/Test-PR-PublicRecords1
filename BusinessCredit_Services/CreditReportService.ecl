/*--SOAP--
<message name="CreditReportService">
	<part name="BusinessCreditReportRequest" type="tns:XmlDataSet" cols="80" rows="30"/>
</message>
*/

IMPORT AutoStandardI, BIPV2, BusinessCredit_Services, iesp, Royalty, WSInput, Inquiry_AccLogs, Risk_Reporting, STD;
EXPORT CreditReportService := MACRO

	//The following macro defines the field sequence on WsECL page of query.
	WSInput.MAC_BusinessCredit_Services_CreditReportService();
										
	ds_in			:= DATASET([],iesp.businesscreditreport.t_BusinessCreditReportRequest) : STORED('BusinessCreditReportRequest', FEW);
	first_row := ds_in[1] : INDEPENDENT;
	ReportBy  := GLOBAL (first_row.ReportBy);
	Options 	:= GLOBAL (first_row.Options);
	Users     := GLOBAL (first_row.User);

	iesp.ECL2ESP.SetInputBaseRequest(first_row);
	
	/* **********************************************
   *  Fields needed for improved Scout Logging  *
   **********************************************/
		string32 _LoginID               := ''	: STORED('_LoginID');
		outofbandCompanyID							:= '' : STORED('_CompanyID');
		string20 CompanyID              := if(Users.CompanyId != '', Users.CompanyId, outofbandCompanyID);
		string20 FunctionName           := '' : STORED('_LogFunctionName');
		string50 ESPMethod              := '' : STORED('_ESPMethodName');
		string10 InterfaceVersion       := '' : STORED('_ESPClientInterfaceVersion');
		string5 DeliveryMethod          := '' : STORED('_DeliveryMethod');
		string5 DeathMasterPurpose      := '' : STORED('__deathmasterpurpose');
		string6 SSN_Mask                := '' : STORED('SSNMask');
		string6 DOB_Mask                := '' : STORED('DOBMask');
		unsigned1 DL_Mask               := 0  : STORED('DLMask');
		BOOLEAN ExcludeDMVPII           := False : STORED('ExcludeDMVPII');
		BOOLEAN DisableOutcomeTracking  := False : STORED('OutcomeTrackingOptOut');
		BOOLEAN ArchiveOptIn            := False : STORED('instantidarchivingoptin');

		//Look up the industry by the company ID.
		Industry_Search := Inquiry_AccLogs.Key_Inquiry_industry_use_vertical_login(FALSE)(s_company_id = CompanyID and s_product_id = (String)Risk_Reporting.ProductID.BusinessCredit_Services__CreditReportService);
	/* ************* End Scout Fields **************/
	
	#STORED('DotID',ReportBy.Company.BusinessIds.DotID);
	#STORED('EmpID',ReportBy.Company.BusinessIds.EmpID);
	#STORED('POWID',ReportBy.Company.BusinessIds.POWID);
	#STORED('ProxID',ReportBy.Company.BusinessIds.ProxID);	
	#STORED('SeleID',ReportBy.Company.BusinessIds.SeleID);
	#STORED('OrgID',ReportBy.Company.BusinessIds.OrgID);
	#STORED('UltID',ReportBy.Company.BusinessIds.UltID);
	#STORED('DID',ReportBy.AuthorizedRep.UniqueId);
	#STORED('IncludeBusinessCredit',Options.IncludeBusinessCredit);
	
	UNSIGNED6 s_DotID  := 0 : STORED('DotID');
	UNSIGNED6 s_EmpID  := 0 : STORED('EmpID');
	UNSIGNED6 s_PowID  := 0 : STORED('PowID');
	UNSIGNED6 s_ProxID := 0 : STORED('ProxID');
	UNSIGNED6 s_SeleID := 0 : STORED('SeleID');
	UNSIGNED6 s_OrgID  := 0 : STORED('OrgID');
	UNSIGNED6 s_UltID  := 0 : STORED('UltID');
	
	BIPV2.IDlayouts.l_xlink_ids2 initialize() := TRANSFORM
		SELF.DotID  := s_dotid;
		SELF.EmpID  := s_empid;
		SELF.PowID  := s_powid;
		SELF.ProxID := s_proxid;
		SELF.SeleID := s_seleid;
		SELF.OrgID  := s_orgid;
		SELF.UltID  := s_ultid;     
	END;

	LinkIds := DATASET([initialize()]);
	
	global_mod := AutoStandardI.GlobalModule();
	input_mod := MODULE(PROJECT(global_mod ,BusinessCredit_Services.Iparam.reportrecords,OPT)); 
		//Business 
		EXPORT DATASET (BIPV2.IDlayouts.l_xlink_ids2) BusinessIds := LinkIds;
		EXPORT STRING120	CompanyName 								:= 	TRIM(ReportBy.Company.CompanyName,LEFT,RIGHT);
		EXPORT STRING10		Company_StreetNumber 				:= 	TRIM(ReportBy.Company.Address.StreetNumber,LEFT,RIGHT);
		EXPORT STRING2		Company_StreetPreDirection 	:= 	TRIM(ReportBy.Company.Address.StreetPreDirection,LEFT,RIGHT);
		EXPORT STRING28 	Company_StreetName 					:=	TRIM(ReportBy.Company.Address.StreetName,LEFT,RIGHT);
		EXPORT STRING4 		Company_StreetSuffix 				:= 	TRIM(ReportBy.Company.Address.StreetSuffix,LEFT,RIGHT);
		EXPORT STRING2 		Company_StreetPostDirection := 	TRIM(ReportBy.Company.Address.StreetPostDirection,LEFT,RIGHT);
		EXPORT STRING8 		Company_UnitNumber 					:=	TRIM(ReportBy.Company.Address.UnitNumber,LEFT,RIGHT);
		EXPORT STRING10 	Company_UnitDesignation			:=	TRIM(ReportBy.Company.Address.UnitDesignation,LEFT,RIGHT);
		EXPORT STRING60 	Company_StreetAddress1 			:=	TRIM(ReportBy.Company.Address.StreetAddress1,LEFT,RIGHT);
		EXPORT STRING25 	Company_City 								:= 	TRIM(ReportBy.Company.Address.City,LEFT,RIGHT);
		EXPORT STRING2 		Company_State 							:= 	TRIM(ReportBy.Company.Address.State,LEFT,RIGHT);
		EXPORT STRING5 		Company_Zip 								:= 	TRIM(ReportBy.Company.Address.Zip5,LEFT,RIGHT);
		EXPORT STRING10 	Company_Phone 							:= 	ReportBy.Company.Phone10;
		EXPORT unsigned2 	Company_Radius 							:= 	ReportBy.Company.Radius;
		EXPORT STRING11 	Tin 												:= 	ReportBy.Company.Tin;
		EXPORT STRING100 	Company_URL 								:= 	TRIM(ReportBy.Company.URL,LEFT,RIGHT);
		EXPORT STRING100 	Company_Email 							:= 	TRIM(ReportBy.Company.Email,LEFT,RIGHT);
		// AuthorizedRep
		Export STRING2 		DLState 										:= 	ReportBy.AuthorizedRep.DLState;
		Export STRING50 	DLNumber 										:= 	ReportBy.AuthorizedRep.DLNumber;
		EXPORT STRING30 	LastName 										:= 	ReportBy.AuthorizedRep.Name.Last;     		
		EXPORT STRING30 	FirstName 									:= 	ReportBy.AuthorizedRep.Name.First;      		
		EXPORT STRING30 	MiddleName 									:= 	ReportBy.AuthorizedRep.Name.Middle;      		
		EXPORT STRING10 	AuthRep_StreetNumber 				:= 	TRIM(ReportBy.AuthorizedRep.Address.StreetNumber,LEFT,RIGHT);
		EXPORT STRING2 		AuthRep_StreetPreDirection 	:=	TRIM(ReportBy.AuthorizedRep.Address.StreetPreDirection,LEFT,RIGHT);
		EXPORT STRING28 	AuthRep_StreetName 					:=	TRIM(ReportBy.AuthorizedRep.Address.StreetName,LEFT,RIGHT);
		EXPORT STRING4 		AuthRep_StreetSuffix 				:= 	TRIM(ReportBy.AuthorizedRep.Address.StreetSuffix,LEFT,RIGHT);
		EXPORT STRING2 		AuthRep_StreetPostDirection := 	TRIM(ReportBy.AuthorizedRep.Address.StreetPostDirection,LEFT,RIGHT);
		EXPORT STRING8 		AuthRep_UnitNumber 					:=	TRIM(ReportBy.AuthorizedRep.Address.UnitNumber,LEFT,RIGHT);
		EXPORT STRING10		AuthRep_UnitDesignation			:=	TRIM(ReportBy.AuthorizedRep.Address.UnitDesignation,LEFT,RIGHT);
		EXPORT STRING60 	AuthRep_StreetAddress1 			:=	TRIM(ReportBy.AuthorizedRep.Address.StreetAddress1,LEFT,RIGHT);
		EXPORT STRING25 	AuthRep_City 								:= 	TRIM(ReportBy.AuthorizedRep.Address.City,LEFT,RIGHT);
		EXPORT STRING2 		AuthRep_State 							:= 	TRIM(ReportBy.AuthorizedRep.Address.State,LEFT,RIGHT);
		EXPORT STRING5 		AuthRep_Zip 								:= 	ReportBy.AuthorizedRep.Address.Zip5;
		EXPORT STRING10 	AuthRep_Phone 							:= 	ReportBy.AuthorizedRep.Phone10;
		EXPORT UNSIGNED8 	DOB 												:= 	iesp.ECL2ESP.DateToInteger(ReportBy.AuthorizedRep.DOB);
		EXPORT STRING11 	SSN 												:= 	ReportBy.AuthorizedRep.SSN;
		EXPORT BOOLEAN 		Include_BusinessCredit 			:= 	FALSE :  STORED('IncludeBusinessCredit');
		EXPORT STRING 		DataRestrictionMask 				:= global_mod.DataRestrictionMask;
		EXPORT STRING 		DataPermissionMask 					:= global_mod.DataPermissionMask;
    EXPORT BOOLEAN    TestDataEnabled             := Users.TestDataEnabled;
		EXPORT STRING     TestDataTableName           := TRIM(users.TestDataTableName, LEFT, RIGHT);
	END;
	
	record_results	:= BusinessCredit_Services.CreditReport_Records(input_mod);
	
	results					:= PROJECT(record_results, 
											TRANSFORM(iesp.businesscreditreport.t_BusinessCreditReportResponse,
													SELF._Header	:= IF( ~input_mod.TestDataEnabled, iesp.ECL2ESP.GetHeaderRow()), //Don't populate the header row if testseeds are requested.
													SELF.InputEcho:= ReportBy,
													SELF.Records	:= record_results));														

	bizCreditOnlyCount       	 := IF(record_results[1].BestInformation.BusinessCreditIndicator = BusinessCredit_Services.Constants.BUSINESS_CREDIT_INDICATOR.BUSINESS_CREDIT_ONLY OR 
																		record_results[1].BestInformation.BusinessCreditIndicator = BusinessCredit_Services.Constants.BUSINESS_CREDIT_INDICATOR.BOTH, 1, 0);
	ds_BizCredCountRoyalLayout := DATASET([{bizCreditOnlyCount}], {INTEGER SBFEAccountCount});
	ds_BizCredRecsRoyalties    := Royalty.RoyaltySBFE.GetOnlineRoyalties( ds_BizCredCountRoyalLayout );
	ds_Royalties               := DATASET([], Royalty.Layouts.Royalty) + IF( ~input_mod.TestDataEnabled, ds_BizCredRecsRoyalties);
	
	//Log to Deltabase
	Deltabase_Logging_prep := project(results, transform(Risk_Reporting.Layouts.LOG_Deltabase_Layout_Record,
                                                      self.company_id := (Integer)CompanyID,
                                                      self.login_id := _LoginID,
                                                      self.product_id := Risk_Reporting.ProductID.BusinessCredit_Services__CreditReportService,
                                                      self.function_name := FunctionName,
                                                      self.esp_method := ESPMethod,
                                                      self.interface_version := InterfaceVersion,
                                                      self.delivery_method := DeliveryMethod,
                                                      self.date_added := (STRING8)Std.Date.Today(),
                                                      self.death_master_purpose := DeathMasterPurpose,
                                                      self.ssn_mask := SSN_Mask,
                                                      self.dob_mask := DOB_Mask,
                                                      self.dl_mask := (String)DL_Mask,
                                                      self.exclude_dmv_pii := (String)(Integer)ExcludeDMVPII,
                                                      self.scout_opt_out := (String)(Integer)DisableOutcomeTracking,
                                                      self.archive_opt_in := (String)(Integer)ArchiveOptIn,
                                                      self.glb := (Integer)Users.GLBPurpose,
                                                      self.dppa := (Integer)Users.DLPurpose,
                                                      self.data_restriction_mask := global_mod.DataRestrictionMask,
                                                      self.data_permission_mask := global_mod.DataPermissionMask,
                                                      self.industry := Industry_Search[1].Industry,
                                                      self.i_ssn := ReportBy.AuthorizedRep.SSN,
                                                      self.i_dob := iesp.ECL2ESP.DateToString(ReportBy.AuthorizedRep.DOB);
                                                      self.i_name_full := ReportBy.AuthorizedRep.Name.Full,
                                                      self.i_name_first := ReportBy.AuthorizedRep.Name.First,
                                                      self.i_name_last := ReportBy.AuthorizedRep.Name.Last,
                                                      self.i_lexid := (Integer)ReportBy.AuthorizedRep.UniqueId,
                                                      self.i_address := If(trim(ReportBy.AuthorizedRep.address.streetaddress1)!='',
                                                                          trim(ReportBy.AuthorizedRep.address.streetaddress1 + ' ' + ReportBy.AuthorizedRep.address.streetaddress2),
                                                                         Address.Addr1FromComponents(ReportBy.AuthorizedRep.address.streetnumber,
                                                                         ReportBy.AuthorizedRep.address.streetpredirection, ReportBy.AuthorizedRep.address.streetname,
                                                                         ReportBy.AuthorizedRep.address.streetsuffix, ReportBy.AuthorizedRep.address.streetpostdirection,
                                                                         ReportBy.AuthorizedRep.address.unitdesignation, ReportBy.AuthorizedRep.address.unitnumber)),
                                                      self.i_city := ReportBy.AuthorizedRep.address.City,
                                                      self.i_state := ReportBy.AuthorizedRep.address.State,
                                                      self.i_zip := ReportBy.AuthorizedRep.address.Zip5,
                                                      self.i_dl := ReportBy.AuthorizedRep.DLNumber,
                                                      self.i_dl_state := ReportBy.AuthorizedRep.DLState,
                                                      self.i_home_phone := ReportBy.AuthorizedRep.Phone10,
                                                      self.i_tin := ReportBy.Company.Tin,
                                                      self.i_bus_name := ReportBy.Company.CompanyName,
                                                      self.i_bus_address := If(trim(ReportBy.Company.address.streetaddress1)!='',
                                                                              trim(ReportBy.Company.address.streetaddress1 + ' ' + ReportBy.Company.address.streetaddress2),
                                                                               Address.Addr1FromComponents(ReportBy.Company.address.streetnumber,
                                                                               ReportBy.Company.address.streetpredirection, ReportBy.Company.address.streetname,
                                                                               ReportBy.Company.address.streetsuffix, ReportBy.Company.address.streetpostdirection,
                                                                               ReportBy.Company.address.unitdesignation, ReportBy.Company.address.unitnumber)),
                                                      self.i_bus_city := ReportBy.Company.address.City,
                                                      self.i_bus_state := ReportBy.Company.address.State,
                                                      self.i_bus_zip := ReportBy.Company.address.Zip5,
                                                      self.i_bus_phone := ReportBy.Company.Phone10,
                                                      self.o_score_1    := (String)left.Records.Scorings.Scores[1].Score,
                                                      self.o_reason_1_1 := left.Records.Scorings.Scores[1].ScoreReasons[1].ReasonCode,
                                                      self.o_reason_1_2 := left.Records.Scorings.Scores[1].ScoreReasons[2].ReasonCode,
                                                      self.o_reason_1_3 := left.Records.Scorings.Scores[1].ScoreReasons[3].ReasonCode,
                                                      self.o_reason_1_4 := left.Records.Scorings.Scores[1].ScoreReasons[4].ReasonCode,
                                                      self.o_score_2    := (String)left.Records.Scorings.Scores[2].Score,
                                                      self.o_reason_2_1 := left.Records.Scorings.Scores[2].ScoreReasons[1].ReasonCode,
                                                      self.o_reason_2_2 := left.Records.Scorings.Scores[2].ScoreReasons[2].ReasonCode,
                                                      self.o_reason_2_3 := left.Records.Scorings.Scores[2].ScoreReasons[3].ReasonCode,
                                                      self.o_reason_2_4 := left.Records.Scorings.Scores[2].ScoreReasons[4].ReasonCode,
                                                      self.o_lexid := (integer)left.Records[1].BestInformation.UniqueID,
                                                      self.o_seleid := left.Records[1].BestInformation.BusinessIds.Seleid,
                                                      self := left,
                                                      self := [] ));
	Deltabase_Logging := DATASET([{Deltabase_Logging_prep}], Risk_Reporting.Layouts.LOG_Deltabase_Layout);
	// #stored('Deltabase_Log', Deltabase_Logging);

	//Improved Scout Logging
	IF(~DisableOutcomeTracking and ~input_mod.TestDataEnabled, OUTPUT(Deltabase_Logging, NAMED('LOG_log__mbs_transaction__log__scout')));
	
	OUTPUT(results, NAMED('Results'));
	OUTPUT(ds_Royalties, NAMED('ds_Royalties'));
ENDMACRO;