/*--SOAP--
<message name="Practitioner_Search_Service">

	<!-- SEARCH FIELDS -->
   <part name="deaNumber"           type="xsd:STRING20"/>
   <part name="federalTaxId"        type="xsd:STRING22"/>
   <part name="FirstName"           type="xsd:STRING20"/>
   <part name="LastName"            type="xsd:STRING20"/>
   <part name="state"               type="xsd:STRING15"/>
   <part name="npiNumber"           type="xsd:STRING15"/>
   <part name="Phone"               type="xsd:STRING14"/>
   <part name="practitionerId"      type="xsd:STRING20"/>  
   <part name="SSN"                 type="xsd:STRING11"/>
   <part name="stateLicenseNumber"  type="xsd:STRING25"/>
   <part name="uniquePhysicianID"   type="xsd:STRING"/>
   <part name="zip"                 type="xsd:STRING10"/>
   <part name="PageNum"             type="xsd:INTEGER"/>
   <part name="isPharmacistSearch"  type="xsd:BOOLEAN"/>

   <!-- COMPLIANCE SETTINGS -->
   <part name="DPPAPurpose"         type="xsd:BYTE"/>
   <part name="GLBPurpose"          type="xsd:BYTE"/>
	 <part name="DataRestrictionMask" type="xsd:STRING"/>
	 <part name="SSNMask" 				    type="xsd:STRING"/>

	 <!-- ESP REQUEST -->
	 <part name="queryPractitionerRequest" type="tns:XmlDataSet" cols="80" rows="30" />

</message>
*/
/*--INFO-- Practitioner Search Service (ESP-compliant output)*/


IMPORT iesp, AutoStandardI, doxie;

EXPORT Practitioner_Search_Service := 
   MACRO
  #constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.LEGACY);     
     // Get XML input 
     rec_in    := iesp.searchpoint.t_queryPractitionerRequest;
     ds_in     := DATASET ([], rec_in) : STORED ('queryPractitionerRequest', FEW);
	   first_row := ds_in[1] : INDEPENDENT;

     // Set global options
	   iesp.ECL2ESP.SetInputBaseRequest(first_row);  // dppa, glba, data restriction mask & ssn mask
      
     // Store main search criteria:
	   search_by := GLOBAL (first_row.SearchBy);
	   options   := GLOBAL (first_row.Options);
      
      
     // Service specific (& those not handled commonly by iesp.ECL2ESP functions)
     // input variables
	   #STORED ('in_FirstName', search_by.FirstName);
     #STORED ('in_LastName', search_by.LastName);
     #STORED ('deaNumber', search_by.deaNumber);
     #STORED ('federalTaxId', search_by.federalTaxId);
     #STORED ('npiNumber', search_by.npiNumber);
     #STORED ('practitionerId', search_by.practitionerId);
     #STORED ('stateLicenseNumber', search_by.stateLicenseNumber);
     #STORED ('uniquePhysicianID', search_by.uniquePhysicianID);
     #STORED ('State', search_by.state);
		 #STORED ('in_Zip', search_by.Zip);
     #STORED ('isPharmacistSearch', search_by.isPharmacistSearch);
     #STORED ('PageNum', search_by.PageNum);
     
     STRING20 in_fname  := '' : STORED('in_FirstName');
     STRING20 fname_val := stringlib.StringFindReplace( in_fname, '*', '' );
     
     STRING20 in_lname  := '' : STORED('in_LastName');
     STRING20 lname_val := stringlib.StringFindReplace( in_lname, '*', '' ); 
     
     STRING20 in_zip    := '' : STORED('in_Zip');
     STRING20 zip_val   := stringlib.StringFindReplace( in_zip, '*', '' ); 
     
     
     #STORED ('FirstName', fname_val);  // Store the first name (without the asterisk (*) in the global space
     #STORED ('LastName', lname_val);
     #STORED ('Zip',      zip_val);
     
     // *** Start of processing
     input_params := AutoStandardI.GlobalModule();
	   tempmod := MODULE(PROJECT(input_params,SearchPoint_Services.Practitioner_Search_Service_Records.Iparams,OPT));
       // Store product specific search option
       EXPORT STRING20 deaNum              := ''    : STORED( 'deaNumber' );
       EXPORT STRING22 federalTaxId        := ''    : STORED( 'federalTaxId' );
		   EXPORT STRING20 practitionerId      := ''    : STORED( 'practitionerId' );
       EXPORT STRING25 stateLicenseNumber  := ''    : STORED( 'stateLicenseNumber' );
       EXPORT STRING15 npiNumber           := ''    : STORED( 'npiNumber' );
       EXPORT STRING   uniquePhysicianID   := ''    : STORED( 'uniquePhysicianID' );  
       EXPORT INTEGER  PageNum             := 1     : STORED( 'PageNum' );
		   EXPORT BOOLEAN  isPharmacistSearch := FALSE : STORED( 'isPharmacistSearch' );
       EXPORT STRING32 applicationType	   := AutoStandardI.InterfaceTranslator.application_type_val.val(PROJECT(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.application_type_val.params));
     END;
      
     isPharmacistSearchBool := FALSE : STORED( 'isPharmacistSearch');
     in_pageNumStored       := 1     : STORED( 'PageNum' );
     /* Since PageNum is an integer, the default value is never empty, it'll default to 0 the following code 
        insures that the user's record count never goes below 0. 20120521: at this time the in_pageNum is 
        not being used by the esp. Code is in so that when the user and ESP implement the functionality, no 
        ECL work will be required.  */
     in_pageNum             := IF( in_pageNumStored < 2,
                                   1,
                                   in_pageNumStored
                                 );
            
		 practitioner_results := SearchPoint_Services.Practitioner_Search_Service_Records.resultRecs( tempmod );

     dateTime       := ut.GetTimeDate();
     queryDate      := dateTime[1..10] + 'T' + dateTime[11..12] + ':' + dateTime[13..14] + ':' + dateTime[15..16] + '.000Z';
     resultsAllCnt  := COUNT( practitioner_results );

     /* Calculates the starting position in the results dataset to begin the CHOOSEN based on 
        the page number. if the calculated page is past the end of the file give user last 3000 records */
     calcedStartRec := 1 + ( ( in_pageNum - 1 ) * 3000 );     
                                                               
     startRecord    := IF( calcedStartRec > resultsAllCnt,
                           resultsAllCnt - 2999,  
                           calcedStartRec 
                         );                               
      
     endRecord    := startRecord + 2999;               
     ResultsTemp  := CHOOSEN( practitioner_results, 3000, startRecord );
     resultsCount := COUNT( ResultsTemp );
     errorMessage := 'There are ' + (STRING)resultsAllCnt + ' available records. Records ' + (STRING)startRecord + ' through ' + (STRING)endRecord + ' have been returned.';
     maxRecsRet   := 1; // Per Jason Ding, the customer only gets the best (1) record returned.
      
		 /* Not able to call MAC_Marshall_Results because there are four additional 
        fields that need to be set and MAC_Marshall_Results only 
        accomodates one additonal field  */ 
     iesp.searchpoint.t_queryPractitionerResponse xform() := 
       TRANSFORM
         SELF._Header			                   := iesp.ECL2ESP.GetHeaderRow();
         SELF.RecordCount                    := resultsCount;
         SELF.return.PractitionerSummaryList := CHOOSEN(ResultsTemp, maxRecsRet);
         SELF.return.ErrorCode		           := IF( resultsAllCnt > 3000,
                                                    'MaxReached',
                                                     ''
                                                  );
         SELF.return.ErrorMessage	           := IF( resultsAllCnt > 3000,
                                                    errorMessage,
                                                    ''
                                                  );
         SELF.return.queryDate		           := queryDate;
         SELF.return.isPharmacistSearch      := isPharmacistSearchBool;
			 END;
		 
     results := CHOOSEN( DATASET( [xform()] ), maxRecsRet, iesp.ECL2ESP.Marshall.starting_record );  // The legacy system only outputs one result.
		 
     OUTPUT( results, NAMED( 'Results' ) ); 

   ENDMACRO;
	
/*
<queryPractitionerRequest>
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
	<SearchBy>
		<DeaNumber></DeaNumber>
		<FederalTaxId></FederalTaxId>
		<FirstName></FirstName>
		<LastName></LastName>
		<State></State>
		<NpiNumber></NpiNumber>
		<Phone></Phone>
		<PractitionerId></PractitionerId>
		<SSN></SSN>
		<StateLicenseNumber></StateLicenseNumber>
		<UniquePhysicianId></UniquePhysicianId>
		<Zip></Zip>
		<isPharmacistSearch></isPharmacistSearch>
	</SearchBy>
</row>
</queryPractitionerRequest>


See Roxie Release bug: https://bugzilla.seisint.com/show_bug.cgi?id=103720 
for an attachment with search data

*/