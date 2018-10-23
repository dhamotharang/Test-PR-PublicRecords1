/*--SOAP--
<message name="SearchService">
	
	<!-- COMPLIANCE SETTINGS -->
	<part name="GLBPurpose"          type="xsd:byte" 	default="1"/>
	<part name="DPPAPurpose"         type="xsd:byte" 	default="1"/>
	<part name="ApplicationType"     type="xsd:string"/>
	
	<separator />
	<!-- Internal testing search field -->
	<part name="did"								 type="string"  />	
	<part name="DatasourceExclusion"	type="unsignedint" default="0" description="[debug only, not exposed in ESP] 0-No Exclusion, 1-No Alloy, 2-No ASL"/>		

	<separator />
  <part name="StudentSearchRequest" type="tns:XmlDataSet" cols="80" rows="30" />

</message>
*/

/*--HELP--
<pre>
&lt;StudentSearchRequest&gt;
	&lt;row&gt;
		&lt;User&gt;
			&lt;GLBPurpose&gt;&lt;/GLBPurpose&gt;
			&lt;DLPurpose&gt;&lt;/DLPurpose&gt;
			&lt;DOBMask&gt;&lt;/DOBMask&gt;
			&lt;SSNMask&gt;&lt;/SSNMask&gt;
			&lt;EndUser/&gt;
		&lt;/User&gt;
		&lt;SearchBy&gt;
			&lt;Name&gt;
				&lt;Last&gt;&lt;/Last&gt;
				&lt;First&gt;&lt;/First&gt;
				&lt;Middle&gt;&lt;/Middle&gt;
				&lt;suffix&gt;&lt;/suffix&gt;
				&lt;full&gt;&lt;/full&gt;
			&lt;/Name&gt;    
			&lt;Address&gt;
				&lt;StreetName&gt;&lt;/StreetName&gt;
				&lt;StreetNumber&gt;&lt;/StreetNumber&gt;
				&lt;StreetPreDirection&gt;&lt;/StreetPreDirection&gt;
				&lt;StreetPostDirection&gt;&lt;/StreetPostDirection&gt;
				&lt;StreetSuffix&gt;&lt;/StreetSuffix&gt;
				&lt;UnitNumber&gt;&lt;/UnitNumber&gt;
				&lt;StateCityZip&gt;&lt;/StateCityZip&gt;
	  		&lt;StreetAddress1&gt;&lt;/StreetAddress1&gt;
				&lt;City&gt;&lt;/City&gt;
				&lt;State&gt;&lt;/State&gt;
				&lt;Zip5&gt;&lt;/Zip5&gt;
				&lt;County&gt;&lt;/County&gt;
			&lt;/Address&gt;
			&lt;DOB&gt;
			&lt;Year&gt;&lt;/Year&gt;
      &lt;Month&gt;&lt;/Month&gt;
      &lt;Day&gt;&lt;/Day&gt;
			&lt;/DOB&gt;
			&lt;SSN&gt;&lt;/SSN&gt; 
			&lt;UniqueId&gt;&lt;/UniqueId&gt; 
		&lt;/SearchBy&gt;
		&lt;Options&gt;
			&lt;StrictMatch&gt;false&lt;/StrictMatch&gt; 
			&lt;MaxResults&gt;0&lt;/MaxResults&gt; 
			&lt;UseNicknames&gt;false&lt;/UseNicknames&gt; 
			&lt;IncludeAlsoFound&gt;false&lt;/IncludeAlsoFound&gt; 
			&lt;UsePhonetics&gt;false&lt;/UsePhonetics&gt; 
			&lt;PenaltyThreshold&gt;0&lt;/PenaltyThreshold&gt; 
			&lt;ReturnCount&gt;0&lt;/ReturnCount&gt; 
			&lt;StartingRecord&gt;0&lt;/StartingRecord&gt; 
		&lt;/Options&gt;
	&lt;/row&gt;
&lt;/StudentSearchRequest&gt;
</pre>
*/
/*--USES-- ut.input_xslt */
import iesp, AutoStandardI, American_Student_Services;

export SearchService := MACRO

 #CONSTANT ('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);

  WSInput.MAC_American_Student_SearchService();
	
	ds_in := DATASET ([], iesp.student.t_StudentSearchRequest) : STORED('StudentSearchRequest', FEW);
	first_row := ds_in[1] : INDEPENDENT;
  // set legacy #stored input parameters
	iesp.ECL2ESP.SetInputBaseRequest(first_row);
	iesp.ECL2ESP.SetInputReportBy (ROW (first_row.searchBy, transform (iesp.bpsreport.t_BpsReportBy, Self := Left, Self := [])));
	iesp.ECL2ESP.SetInputSearchOptions(first_row.options);	  
	iesp.ECL2ESP.Marshall.Mac_Set(first_row.options);
	// this option is for testing only.
	ds_exlusion := 0 : STORED('DatasourceExclusion');		

	input_params := AutoStandardI.GlobalModule();
	tmpMod:= MODULE(PROJECT(input_params, American_Student_Services.IParam.searchParams,opt))		
		EXPORT unsigned2 	penalty_threshold := AutoStandardI.InterfaceTranslator.penalt_threshold_value.val(project(input_params,AutoStandardI.InterfaceTranslator.penalt_threshold_value.params)); ;
		EXPORT STRING14 	didValue := AutoStandardI.InterfaceTranslator.did_value.val(project(input_params,AutoStandardI.InterfaceTranslator.did_value.params));
		EXPORT BOOLEAN 		isDeepDive := not AutoStandardI.InterfaceTranslator.nodeepdive.val(project(input_params, AutoStandardI.InterfaceTranslator.nodeepdive.params));
		EXPORT string11 	ssn  := AutoStandardI.InterfaceTranslator.ssn_value.val(project(input_params, AutoStandardI.InterfaceTranslator.ssn_value.params));  
		EXPORT UNSIGNED8 	dob  := AutoStandardI.InterfaceTranslator.dob_val.val(project(input_params, AutoStandardI.InterfaceTranslator.dob_val.params));      			
		EXPORT unsigned1  dob_mask_value := AutoStandardI.InterfaceTranslator.dob_mask_value.val(project(input_params, AutoStandardI.InterfaceTranslator.dob_mask_value.params));      				
		EXPORT STRING32 ApplicationType := AutoStandardI.InterfaceTranslator.application_type_val.val(project(input_params,AutoStandardI.InterfaceTranslator.application_type_val.params));
	END;
	
	recs := American_Student_Services.SearchRecords(tmpMod, ds_exlusion);
	
	iesp_output := American_Student_Services.Functions.xform_iesp_output(recs);
	
	iesp.ECL2ESP.Marshall.MAC_Marshall_Results(iesp_output, results, iesp.student.t_StudentSearchResponse, Records, false,,,,iesp.Constants.MaxCountASLSearch);

	output(results, named('Results'));
	
ENDMACRO;
// American_Student_Services.SearchService()
