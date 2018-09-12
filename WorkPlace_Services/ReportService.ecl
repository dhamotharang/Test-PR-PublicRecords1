/*--SOAP--
<message name="WorkPlace_ReportService">
	<!-- COMPLIANCE SETTINGS -->
	<part name="GLBPurpose"          type="xsd:byte"/>
	<part name="DPPAPurpose"         type="xsd:byte"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="ApplicationType"     type="xsd:string"/>

	<!-- SEARCH FIELDS -->
  <part name="UniqueID"			   type="xsd:string"/>

	<!-- ADDITIONAL USER OPTIONS -->
	<part name="IncludeSecretaryOfStateInfo"  type="xsd:boolean"/>
	<part name="IsSpouse"	                    type="xsd:boolean"/>

	<!-- XML INPUT DATASET BOXES -->
  <part name="WorkPlaceReportRequest" type="tns:XmlDataSet" cols="80" rows="30" />
	
	<!-- RESULTS DATA EXCLUSION OPTIONS FOR INTERNAL USE-->
	<part name="ExcludedSources"        type="xsd:string"/>

</message>
*/
/*--INFO-- Return WorkPlace information in a report format for a certain DID. */

import iesp,AutoStandardI, Royalty;

export ReportService := macro

  // Get XML input
  rec_in := iesp.workplace.t_WorkPlaceReportRequest;
  ds_in := DATASET ([], rec_in) : STORED ('WorkPlaceReportRequest', FEW);
	first_row := ds_in[1] : independent;

//*****************************
  //set options
	iesp.ECL2ESP.SetInputBaseRequest (first_row);

	// Store product specific report options (see iesp.workplace.t_WPReportOption)
	report_options := global (first_row.Options); 
  #stored ('IncludeSecretaryOfStateInfo', report_options.IncludeSecretaryOfStateInfo);
  #stored ('IsSpouse', report_options.IsSpouse);

  // Store source exclusion option
  #stored ('ExcludedSources', report_options.ExcludedSources); 

  //set main search criteria:
	report_by := global (first_row.ReportBy);
  #stored ('UniqueID', report_by.UniqueID);

  // *** Start of processing
	tempmod := module(project(AutoStandardI.GlobalModule(),WorkPlace_Services.ReportService_Records.params,opt));
	  // NOTE: UniqueID is the xml input name, but it is really a did 
		// so it is stored into the standard global "did" name. 
	  export string12 unique_id  := ''    : stored('UniqueID');
    export boolean include_sos := false : stored('IncludeSecretaryOfStateInfo');
		export boolean is_spouse   := false : stored('IsSpouse');	// defaults to OFF
	  export string  excluded_sources := '' : stored('ExcludedSources'); 
		export string32 applicationType := AutoStandardI.InterfaceTranslator.application_type_val.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.application_type_val.params));
	end;

	ds_temp_results  := WorkPlace_Services.ReportService_Records.val(tempmod);

   // Even when no results, we still need to output the report reponse structure because 
   // certain xml tags (i.e. <TransactionId> are needed by ESP.
	 // So an empty WPReportRecord is output below when the temp_results have no records.
  iesp.workplace.t_WorkPlaceReportResponse format() := transform
			temp_cnt := count(ds_temp_results);
			self._Header         := iesp.ECL2ESP.GetHeaderRow(),
			self.RecordCount     := temp_cnt, //count(ds_temp_results),
			self.WPReportRecord  := if(temp_cnt>0,ds_temp_results[1])
   end;
  ds_results := dataset([format()]);
									
	// ds_results_slimmed := project(ds_results,
																// transform(WorkPlace_Services.Layouts.result_sources,
																	// self.source := left.WPReportRecord.SourceCode));
									
	// Royalty.MAC_RoyaltyWorkplace(ds_results_slimmed, temp_royalties);							
	
	Royalty.MAC_RoyaltyEmail(ds_results[1].WPReportRecord.EmailAddresses, email_royalties, EmailSource);
	
	// royalties:= temp_royalties + email_royalties;
	
  //Uncomment line below as needed to assist in debugging
  //output(ds_temp_results,  named('ds_temp_results'));
  output(ds_results,named('Results'));
	OUTPUT(email_royalties, NAMED('RoyaltySet'));	// Returning only email_royalties as royalties for WPL is yet to approved by billing team.
																								// Royalties for WPL are calculated in Workplace_Services.SearchService.
 endmacro;

/*
For testing/debugging: 
1. In the "WorkPlaceSearchRequest" xml text area, use the sample xml input below 
   filling in:
   a. the appropriate input UniqueID(did) field value, 
   b. the IncludeSecretaryofStateInfo option (if needed/desired) and 
   c. the IsSpouse indicator if needed and
   d. If needed, set the "ExcludedSources" list of comma de-limited sources to be excluded.
<WorkPlaceReportRequest>
<row>
 <User>
  <GLBPurpose>1</GLBPurpose>
  <DLPurpose>1</DLPurpose>
  <DataRestrictionMask>00000000000</DataRestrictionMask>
  <ApplicationType></ApplicationType>
 </User>
 <Options>
  <IncludeSecretaryofStateInfo>false</IncludeSpouseData>
  <IsSpouse>false</IsSpouse>
  <ExcludedSources></ExcludedSources>
 </Options>
 <ReportBy>
  <UniqueID></UniqueID>
 </ReportBy>
</row>
</WorkPlaceReportRequest>

*/
