/*--SOAP--
<message name="LicenseReportService">

	<!-- COMPLIANCE/USER SETTINGS -->
	<part name="GLBPurpose"          type="xsd:byte"/>
	<part name="DPPAPurpose"         type="xsd:byte"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="SSNMask" 					   type="xsd:string"/>
	<part name="ApplicationType"   	 type="xsd:string"/>
  <part name="MaxWaitSeconds"      type="xsd:integer"/>
	
	<!-- SEARCH FIELDS/OPTIONS, order matches WEB/GUI search form -->
  <part name="MidexReportNumber"   type="xsd:string"/>
	<part name="MariRid"   					 type="xsd:string"/>
	<part name="SearchType"   	 		 type="xsd:string"/>

	<!-- INTERNAL TESTING FIELDS/OPTIONS -->
	<part name="ReturnCount"			   type="xsd:unsignedInt"/>
	
  <part name="MIDEXLicenseReportRequest" type="tns:XmlDataSet" cols="80" rows="30" />

</message>
*/
/*--INFO-- Search and return Midex License report.*/
// import AutoStandardI, iesp;

export LicenseReportService := macro

	import AutoStandardI, iesp;
  // Get XML input 
  rec_in := iesp.midexlicensereport.t_MIDEXLicenseReportRequest;
  ds_in := DATASET ([], rec_in) : STORED ('MIDEXLicenseReportRequest', FEW);
	first_row := ds_in[1] : independent;

  // Set input options
	iesp.ECL2ESP.SetInputBaseRequest (first_row);
	
	report_options := global (first_row.Options); 
  // iesp.ECL2ESP.Marshall.Mac_Set (first_row.options);

  // Store main search criteria:
	report_by := global (first_row.ReportBy);
	alert_Input := global(first_row.AlertInput);
	
  // Store mari rid and midex report number
	#stored ('MidexReportNumber', report_by.MIDEXReportNumber);
	#stored ('MariRid', report_by.MariRid);
	#stored ('SearchType', report_by.SearchType);
	
	string26 Midex_number := ''  		: stored('MidexReportNumber');
	string26 Mari_rid := ''  				: stored('MariRid');
	
	MIDEX_Services.Layouts.rec_midex_payloadKeyField xfm_make_midx_record() := transform
		  self.midex_rpt_nbr    := Midex_number;
      self                  := [];
  end;
	ds_Midex_number := dataset([xfm_make_midx_record()]);
	
	MIDEX_Services.Layouts.rec_profLicMari_payloadKeyField xfm_make_mari_record() := transform
		  self.mari_rid       	:= (Integer) Mari_rid;
      self                  := [];
    end;

	ds_Mari_number := dataset([xfm_make_mari_record()]);
	
  unsigned1 vAlertVersion := IF(alert_input.AlertVersion = Midex_Services.Constants.AlertVersion.None,
                                Midex_Services.Constants.AlertVersion.Current,
                                alert_input.AlertVersion);
  
  // *** Start of processing
  input_params := AutoStandardI.GlobalModule();
	tempmod := module(project(input_params,Midex_Services.Iparam.reportrecords,opt));
    // SearchBy fields not handled by AutoStandardI.GlobalModule
		export dataset   MidexReportNumbers := 						ds_Midex_number;
		export dataset   MariRidNumbers := 								ds_Mari_number;
		export string1   searchType := ''									: stored('SearchType');
		export string25  nameHash := alert_input.hashes.name.hashvalue;
		export string25  addressHash := alert_input.hashes.address.hashvalue;
		export string25  licenseStatHash := alert_input.hashes.LicenseStatus.hashvalue;
		export string25  phoneHash := alert_input.hashes.Phone.hashvalue;
		export string25  NMLSIdHash := alert_input.hashes.NMLSId.hashvalue;
		export string25  RepresentHash := alert_input.hashes.NMLSRepresents.hashvalue;
		export string25  RegistrationHash := alert_input.hashes.NMLSRegistration.hashvalue;
		export string25  DisciplinaryHash := alert_input.hashes.NMLSDisciplinary.hashvalue;
		export string25  AKAAndNameVariationHash 	:= alert_input.hashes.AKAAndNameVariation.hashvalue;
		export boolean   TrackName := alert_input.options.TrackName;
		export boolean   TrackAddress := alert_input.options.TrackAddress;
		export boolean   TrackLicenseStatus := alert_input.options.TrackLicenseStatus;
		export boolean   TrackPhone := alert_input.options.TrackPhone;
		export boolean   TrackRegistration := alert_input.options.TrackNMLSRegistration;
		export boolean   TrackNMLSId := alert_input.options.TrackNMLSId;
		export boolean   TrackRepresent := alert_input.options.TrackNMLSRepresents;
		export boolean   TrackDisciplinary := alert_input.options.TrackNMLSDisciplinary;
		export boolean   TrackAKAAndNameVariation := alert_input.options.TrackAKAAndNameVariation;
		export boolean   EnableAlert := alert_input.EnableAlert;
		export unsigned1 AlertVersion := IF(alert_input.EnableAlert,
                                        vAlertVersion,
                                        Midex_Services.Constants.AlertVersion.None);
		export boolean   isLicenseOnlyReport := IF(Midex_number = '',TRUE,FALSE);
	end;

  // No MAC_marshal is used, since the alert values are set at the repsone record level, the .val
	// returns the results already "Marshalled".
	ds_results := Midex_Services.LicenseReport_Records(tempmod);
	finalresults := MIDEX_Services.Functions.Format_licenseReport_iespResponse(ds_results);
  
  // Output the search results
  // JIRA 10581 - because the format call above replicates rows, only output the first row
	output(finalresults[1],named('Results'));

endmacro;

/*
For testing/debugging: 
1. In the "LicenseReportRequest" xml text area, use the sample xml input below 
   filling in:
   a. the appropriate input/search data fields,
   b. the appropriate common input/search options, (DPA, GLB, DRM, etc.) 
   c. the product search specific ??? option (if needed/desired)

<LicenseReportRequest>
<row>
 <User>
  <GLBPurpose></GLBPurpose>
  <DLPurpose></DLPurpose>
  <DataRestrictionMask>000000000000000</DataRestrictionMask>
  <SSNMask></SSNMask>
  <ApplicationType></ApplicationType>
 </User>
 <ReportBy>
  <MidexReportNumber></MidexReportNumber>
  <MariRid>4</MariRid>
 </ReportBy>
 <Options>
  <IncludeNonPublic>false</IncludeNonPublic>
  <IncludeFreddieMac>false</IncludeFreddieMac>
 </Options>
 <AlertInput>
  <Hashes>
			<Name>
					<HashValue>14882468829392440489</HashValue>
			</Name>
			<Address>
					<HashValue>13161771840837423140</HashValue>
			</Address>
			<Incidents>
					<HashValue></HashValue>
			</Incidents>
			<LicenseStatus>
					<HashValue>15366554617299757982</HashValue>
			</LicenseStatus>
	</Hashes>
  <Options>
			<TrackNameChanges>true</TrackNameChanges>
			<TrackAddressChanges>true</TrackAddressChanges>
			<TrackInccidentChanges>false</TrackInccidentChanges>
			<TrackLicenseStatus>true</TrackLicenseStatus>
	</Options>
	<EnableAlert>true</EnableAlert>
 </AlertInput>
</row>
</LicenseReportRequest>
*/