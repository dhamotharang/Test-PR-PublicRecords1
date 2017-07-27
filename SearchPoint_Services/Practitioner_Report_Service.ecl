/*--SOAP--
<message name="Practitioner_Report_Service">

  <!-- SEARCH FIELDS -->
  <part name="gennum"                       type="xsd:string" />
  <part name="isPharmacistSearch"           type="xsd:boolean"/>

  <!-- COMPLIANCE SETTINGS -->
  <part name="DPPAPurpose"                  type="xsd:byte"/>
  <part name="GLBPurpose"                   type="xsd:byte"/>
	<part name="DataRestrictionMask"          type="xsd:string"/>
  <part name="SSNMask" 				              type="xsd:string"/>

	<!-- ESP REQUEST -->
	<part name="getPractitionerReportRequest" type="tns:XmlDataSet" cols="80" rows="30" />
	
</message>
*/
/*--INFO-- Practitioner Report Service (ESP-compliant output)*/

IMPORT AutoStandardI, doxie, iesp;

EXPORT Practitioner_Report_Service := 
  MACRO

    // Get XML input 
    rec_in    := iesp.searchpoint.t_getPractitionerReportRequest;
    ds_in     := DATASET ([], rec_in) : STORED ('getPractitionerReportRequest', FEW);
	  first_row := ds_in[1] : INDEPENDENT;

    // Set global options
	  iesp.ECL2ESP.SetInputBaseRequest(first_row);  // dppa, glba, data restriction mask & ssn mask
      
    // Store main search option criteria:
	  options   := GLOBAL(first_row.Options);

    #STORED('gennum',             GLOBAL( first_row.Gennum ) );
    #STORED('isPharmacistSearch', GLOBAL( first_row.isPharmacistSearch ) );
      
    // *** Start of processing
    input_params := AutoStandardI.GlobalModule();
	  tempmod := 
      MODULE(SearchPoint_Services.Practitioner_Report_Service_Records.Iparams);
        // Store product specific search option
        EXPORT STRING   gennum             := ''    : STORED( 'gennum' );
        EXPORT BOOLEAN  isPharmacistSearch := FALSE : STORED( 'isPharmacistSearch');
		    EXPORT STRING32 applicationType	   := AutoStandardI.InterfaceTranslator.application_type_val.val(PROJECT(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.application_type_val.params));
	    END;
 
    practitioner_report_results := SearchPoint_services.Practitioner_Report_Service_Records.resultRecs( tempmod );
	  
    dateTime               := ut.GetTimeDate();
    queryDate              := dateTime[1..10] + 'T' + dateTime[11..12] + ':' + dateTime[13..14] + ':' + dateTime[15..16] + '.000Z';
    resultsCount           := COUNT( practitioner_report_results );
    isPharmacistSearchBool := FALSE : STORED( 'isPharmacistSearch' );
    STRING gennum          := ''    : STORED( 'gennum' );
      
		// Not able to call MAC_Marshall_Results because there are four additional fields that need to 
    // be set and MAC_Marshall_Results only accomodates one additonal field
    iesp.searchpoint.t_getPractitionerReportResponse xform() := 
      TRANSFORM
        SELF._Header			             := iesp.ECL2ESP.GetHeaderRow();
        SELF.RecordCount               := resultsCount;
        SELF.return.PractitionerList   := IF( resultsCount>0, practitioner_report_results[1] );
        SELF.return.ErrorCode		       := '';
        SELF.return.ErrorMessage	     := '';
        SELF.return.queryDate		       := queryDate;
			  SELF.return.isPharmacistSearch := isPharmacistSearchBool;
      END;
		results := CHOOSEN( DATASET( [xform()] ), iesp.ECL2ESP.Marshall.max_return, iesp.ECL2ESP.Marshall.starting_record);
		
    OUTPUT( results, NAMED( 'Results' ) ); 

  ENDMACRO;
   
/*
<getPractitionerDetailRequest>
<row>
	<User>
		<ReferenceCode></ReferenceCode>
		<BillingCode></BillingCode>
		<QueryId></QueryId>
		<GLBPurpose></GLBPurpose>
		<DLPurpose></DLPurpose>
		<EndUser>
			<CompanyName></CompanyName>
			<StreetAddress1></StreetAddress1>
			<City></City>
			<State></State>
			<Zip5></Zip5>
		</EndUser>
		<MaxWaitSeconds></MaxWaitSeconds>
	</User>
	<Options> </Options>
	<Gennum>000881793289</Gennum>
	<isPharmacistSearch>TRUE</isPharmacistSearch>
</row>
</getPractitionerDetailRequest>

*/