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
		
		// options 
		ConsumerProfile_mod := module (ConsumerProfile_Services.IParam.options)
			export boolean is_california   := first_row.Options.CAInPersonApplication;
			export string2 state_law_exception := first_row.Options.StateLawException; //no ECL code to support this for now
			export string intended_purpose := first_row.Options.IntendedPurpose;
			export boolean test_data_enabled := false : STORED('TestDataEnabled');
			string TestDataTableName := '' : STORED('TestDataTableName');
			export string test_data_table_name := stringlib.stringtouppercase(TestDataTableName);
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
ENDMACRO;