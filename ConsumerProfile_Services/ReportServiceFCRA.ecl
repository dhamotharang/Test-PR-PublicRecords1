/*--SOAP--
<message name="Consumer Profile FCRA Report" wuTimeout="300000">
	<part name="gateways" type="tns:XmlDataSet" cols="70" rows="4"/>
	<part name="FCRAConsumerProfileReportRequest" type="tns:XmlDataSet" cols="80" rows="30"/>
</message>
*/
/*--INFO-- 
<pre>
&lt;gateways&gt;
 &lt;servicename&gt;&lt;/servicename&gt;
 &lt;url&gt;&lt;/url&gt;
&lt;/gateways&gt;
&lt;FCRAConsumerProfileReportRequest&gt;
 &lt;row&gt;
  &lt;User&gt;
   &lt;SSNMask&gt;&lt;/SSNMask&gt;
   &lt;DOBMask&gt;&lt;/DOBMask&gt;
   &lt;DataRestrictionMask&gt;&lt;/DataRestrictionMask&gt;
   &lt;DataPermissionMask&gt;&lt;/DataPermissionMask&gt;
   &lt;ApplicationType&gt;&lt;/ApplicationType&gt;
   &lt;TestDataEnabled&gt;&lt;/TestDataEnabled&gt;
   &lt;TestDataTableName&gt;&lt;/TestDataTableName&gt;
  &lt;/User&gt;
  &lt;Options&gt;
   &lt;CAInPersonApplication&gt;&lt;/CAInPersonApplication&gt;
   &lt;StateLawException&gt;&lt;/StateLawException&gt;
   &lt;IntendedPurpose&gt;&lt;/IntendedPurpose&gt;
   &lt;FFDOptionsMask&gt;&lt;/FFDOptionsMask&gt;
   &lt;FCRAPurpose&gt;&lt;/FCRAPurpose&gt;
  &lt;/Options&gt;
  &lt;ReportBy&gt;
   &lt;UniqueId&gt;&lt;/UniqueId&gt;
   &lt;Name&gt;
    &lt;Full&gt;&lt;/Full&gt;
    &lt;First&gt;&lt;/First&gt;
    &lt;Middle&gt;&lt;/Middle&gt;
    &lt;Last&gt;&lt;/Last&gt;
    &lt;Suffix&gt;&lt;/Suffix&gt;
    &lt;Prefix&gt;&lt;/Prefix&gt;
   &lt;/Name&gt;
   &lt;Address&gt;
    &lt;StreetAddress1&gt;&lt;/StreetAddress1&gt;
    &lt;StreetAddress2&gt;&lt;/StreetAddress2&gt;
    &lt;City&gt;&lt;/City&gt;
    &lt;State&gt;&lt;/State&gt;
    &lt;Zip5&gt;&lt;/Zip5&gt;
    &lt;Zip4&gt;&lt;/Zip4&gt;
   &lt;/Address&gt;
   &lt;DOB&gt;
    &lt;Year&gt;&lt;/Year&gt;
    &lt;Month&gt;&lt;/Month&gt;
    &lt;Day&gt;&lt;/Day&gt;
   &lt;/DOB&gt;
   &lt;SSN&gt;&lt;/SSN&gt;
   &lt;Phone10&gt;&lt;/Phone10&gt;
  &lt;/ReportBy&gt;
 &lt;/row&gt;  
&lt;/FCRAConsumerProfileReportRequest&gt;
</pre>
*/

IMPORT ConsumerProfile_Services, Gateway, iesp, Inquiry_AccLogs, Risk_Indicators, Risk_Reporting, STD;

EXPORT ReportServiceFCRA := MACRO
		rec_in := iesp.fcraconsumerprofilereport.t_FCRAConsumerProfileReportRequest;
		ds_in := DATASET ([], rec_in) : STORED ('FCRAConsumerProfileReportRequest', FEW);
		first_row := ds_in[1] : INDEPENDENT;
		gateways_in := Gateway.Configuration.Get();
		
		iesp.ECL2ESP.SetInputBaseRequest(first_row);
	
		//Report 
		ReportBy := global(first_row.ReportBy);
		iesp.ECL2ESP.SetInputReportBy (project(reportby,transform(iesp.bpsreport.t_BpsReportBy,self:=left,self:=[])));
	
	  global_mod := AutoStandardI.GlobalModule();
		
		drm_mod := module (project(global_mod,AutoStandardI.DataRestrictionI.params))
			export string datarestrictionmask := risk_indicators.iid_constants.default_DataRestriction : STORED('DataRestrictionMask');
		end;
    
    /* **********************************************
			 *  Fields needed for improved Scout Logging  *
			 **********************************************/
			string32 _LoginID               := ''	: STORED('_LoginID');
			outofbandCompanyID							:= '' : STORED('_CompanyID');
			string20 CompanyID              := if(first_row.User.CompanyId != '', first_row.User.CompanyId, outofbandCompanyID);
			string20 FunctionName           := '' : STORED('_LogFunctionName');
			string50 ESPMethod              := '' : STORED('_ESPMethodName');
			string10 InterfaceVersion       := '' : STORED('_ESPClientInterfaceVersion');
			string5 DeliveryMethod          := '' : STORED('_DeliveryMethod');
			string5 DeathMasterPurpose      := '' : STORED('__deathmasterpurpose');
			outofbandssnmask                := '' : STORED('SSNMask');
			string10 SSN_Mask               := if(first_row.User.SSNMask != '', first_row.User.SSNMask, outofbandssnmask);
			string10 DOB_Mask               := if(first_row.User.DOBMask != '', first_row.User.DOBMask, global_mod.dobmask);
			BOOLEAN DL_Mask                 := first_row.User.DLMask;
			BOOLEAN ExcludeDMVPII           := first_row.User.ExcludeDMVPII;
			BOOLEAN DisableOutcomeTracking  := False : STORED('OutcomeTrackingOptOut');
			BOOLEAN ArchiveOptIn            := False : STORED('instantidarchivingoptin');
			unsigned1 LexIdSourceOptout 		:= 1  : STORED('LexIdSourceOptout');
			string TransactionID 						:= '' : STORED('_TransactionId');
			string BatchUID 								:= '' : STORED('_BatchUID');
			unsigned6 GlobalCompanyId			  := 0  : STORED('_GCID');
      
      BOOLEAN outofband_TestDataEnabled := false : STORED('testdataenabled');
      BOOLEAN _TestData_Enabled := first_row.User.TestDataEnabled or outofband_TestDataEnabled;
      
			//Look up the industry by the company ID.
			Industry_Search := Inquiry_AccLogs.Key_Inquiry_industry_use_vertical_login(TRUE)(s_company_id = CompanyID and s_product_id = (String)Risk_Reporting.ProductID.ConsumerProfile_Services__ReportServiceFCRA);
		/* ************* End Scout Fields **************/
    
		// options 
		ConsumerProfile_mod := module (ConsumerProfile_Services.IParam.options)
			export boolean is_california   := first_row.Options.CAInPersonApplication;
			export string2 state_law_exception := first_row.Options.StateLawException; //no ECL code to support this for now
			export string intended_purpose := first_row.Options.IntendedPurpose;
			export boolean test_data_enabled := false : STORED('TestDataEnabled');
			string TestDataTableName := '' : STORED('TestDataTableName');
			export string test_data_table_name := STD.STR.ToUpperCase(TestDataTableName);
			export integer1 BS_version := 41;
			export string5 industry_class := '' : STORED('IndustryClass');
			string6 DOBMask := '' : STORED('DOBMask');
			export unsigned1 dob_mask := Suppress.date_mask_math.MaskIndicator (DOBMask);
			export string6 SSNMask := '' : STORED('SSNMask');
			export string50 datarestrictionmask := drm_mod.datarestrictionmask;
			export boolean isECHRestricted := AutoStandardI.DataRestrictionI.val(drm_mod).isECHRestricted(datarestrictionmask);
			export boolean isEQCHRestricted := AutoStandardI.DataRestrictionI.val(drm_mod).isEQCHRestricted(datarestrictionmask);
			export integer8 FFDOptionsMask := FFD.FFDMask.Get(first_row.options.FFDOptionsMask);
			export integer FCRAPurpose := FCRA.FCRAPurpose.Get(first_row.options.FCRAPurpose);	
		end;
		
		rec_out := ConsumerProfile_Services.ReportRecords_FCRA(ReportBy, ConsumerProfile_mod, gateways_in);
		
		results := project(rec_out,  transform(iesp.fcraconsumerprofilereport.t_ConsumerProfileReportResponse,
																				self._Header := iesp.ECL2ESP.GetHeaderRow(),
																				self.ConsumerStatements := left.ConsumerStatements;
																				self.Consumer := left.ConsumerInquiry;  // for inquiry logging
																				self.Result  := left.Result));
		
		royalty := rec_out[1].royalty;
		output(results, named('Results'));
		if(not ConsumerProfile_mod.isECHRestricted, output(royalty, named ('RoyaltySet')));
    
    
    //Improved Scout Logging
		Deltabase_Logging_prep := project(results, transform(Risk_Reporting.Layouts.LOG_Deltabase_Layout_Record,
                                                  self.company_id := (Integer)CompanyID,
                                                  self.login_id := _LoginID,
                                                  self.product_id := Risk_Reporting.ProductID.ConsumerProfile_Services__ReportServiceFCRA,
                                                  self.function_name := FunctionName,
                                                  self.esp_method := ESPMethod,
                                                  self.interface_version := InterfaceVersion,
                                                  self.delivery_method := DeliveryMethod,
                                                  self.date_added := (STRING8)Std.Date.Today(),
                                                  self.death_master_purpose := DeathMasterPurpose,
                                                  self.ssn_mask := SSN_Mask,
                                                  self.dob_mask := DOB_Mask,
                                                  self.dl_mask := (String)(Integer)DL_Mask,
                                                  self.exclude_dmv_pii := (String)(Integer)ExcludeDMVPII,
                                                  self.scout_opt_out := (String)(Integer)DisableOutcomeTracking,
                                                  self.archive_opt_in := (String)(Integer)ArchiveOptIn,
                                                  self.glb := (Integer)first_row.User.GLBPurpose,
                                                  self.dppa := (Integer)first_row.User.DLPurpose,
                                                  self.data_restriction_mask := first_row.User.DataRestrictionMask,
                                                  self.data_permission_mask := first_row.User.DataPermissionMask,
                                                  self.industry := Industry_Search[1].Industry,
                                                  //self.i_attributes_name := Attributes_Requested[1].AttributeGroup,
                                                  self.i_ssn := first_row.ReportBy.SSN,
                                                  tmpDOB := iesp.ECL2ESP.DateToString(first_row.ReportBy.DOB);
                                                  self.i_dob := IF(tmpDOB = '00000000', '', tmpDOB);
                                                  self.i_name_full := first_row.ReportBy.Name.Full,
                                                  self.i_name_first := first_row.ReportBy.Name.First,
                                                  self.i_name_last := first_row.ReportBy.Name.Last,
                                                  self.i_lexid := (Integer)first_row.ReportBy.UniqueId,
                                                  self.i_address := If(trim(first_row.ReportBy.address.streetaddress1)!='',
                                                                        trim(first_row.ReportBy.address.streetaddress1 + ' ' + first_row.ReportBy.address.streetaddress2),
                                                                        Address.Addr1FromComponents(first_row.ReportBy.address.streetnumber,
                                                                        first_row.ReportBy.address.streetpredirection, first_row.ReportBy.address.streetname,
                                                                        first_row.ReportBy.address.streetsuffix, first_row.ReportBy.address.streetpostdirection,
                                                                        first_row.ReportBy.address.unitdesignation, first_row.ReportBy.address.unitnumber)),
                                                  self.i_city := first_row.ReportBy.address.City,
                                                  self.i_state := first_row.ReportBy.address.State,
                                                  self.i_zip := first_row.ReportBy.address.Zip5,
                                                  self.i_home_phone := first_row.ReportBy.Phone10,
                                                  self.o_lexid := (Integer)left.Consumer.Lexid,
                                                  self := left,
                                                  self := [] ));
		Deltabase_Logging := DATASET([{Deltabase_Logging_prep}], Risk_Reporting.Layouts.LOG_Deltabase_Layout);

		//Log to Deltabase
		IF(~DisableOutcomeTracking and NOT _TestData_Enabled, OUTPUT(Deltabase_Logging, NAMED('LOG_log__mbs__fcra_transaction__log__scout')));

ENDMACRO;