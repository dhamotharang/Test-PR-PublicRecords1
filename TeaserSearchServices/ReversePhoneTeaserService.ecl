/*--SOAP--
<message name="ReversePhoneTeaserService">	
  <part name="Phone" type="xsd:string"/>
  	<!-- COMPLIANCE SETTINGS -->
	<part name="GLBPurpose"          type="xsd:byte"/>
	<part name="DPPAPurpose"         type="xsd:byte"/>
	<part name="DataRestrictionMask" type="xsd:string"/>	
	<part name="Phone"               type="xsd:string"/>

  <separator />
	<part name="ReturnCount"				 type="xsd:unsignedInt"/>
	<part name="StartingRecord"			 type="xsd:unsignedInt"/>	
  <separator />
	<part name="ApplicationType"     	type="xsd:string"/>
  <separator />
	<part name="ThinReversePhoneTeaserRequest" type="tns:XmlDataSet" cols="80" rows="30" />
</message>
*/
/*--INFO-- Reverse Phone Teaser Service.
*/

IMPORT iesp, AutoStandardI, TeaserSearchServices, std;

EXPORT ReversePhoneTeaserService := MACRO
	#constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.LEGACY);
	rec_in := iesp.thinreversephoneteaser.t_ThinReversePhoneTeaserRequest;
	ds_in := DATASET ([], rec_in) : STORED ('ThinReversePhoneTeaserRequest', FEW);
  first_row := ds_in[1] : INDEPENDENT;

  //set options
	// Set DPPA, GLBA, DRM, App_type etc. as it calls setInputUser
  iesp.ECL2ESP.SetInputBaseRequest (first_row);

  //set main search criteria:
	search_by := GLOBAL (first_row.SearchBy);
	search_options := GLOBAL (first_row.Options);
	
	STRING15 phone_value15 := trim(search_By.Phone, left,right);
	#stored('phone', Phone_value15);
	
	string32 stored_Application_type := '' : stored('ApplicationType');

	//// Get back the DPPA, GLBA, DRM, etc
	unsigned1 stored_dppa_purpose := 0 : stored('DPPAPurpose');
	unsigned1 stored_glb_purpose := 0 : stored('GLBPurpose');
	
	string stored_datarestrictionmask := '' : stored('DataRestrictionMask');

	tempmod := module(AutoStandardI.DataRestrictionI.params)
		  export boolean AllowAll := false;
		  export boolean AllowDPPA := false;
		  export boolean AllowGLB := false;		  
			export string DataRestrictionMask := stored_datarestrictionmask;
		  export unsigned1 DPPAPurpose := stored_dppa_purpose;
		  export unsigned1 GLBPurpose := stored_glb_purpose;
		  export boolean ignoreFares := false;
		  export boolean ignoreFidelity := false;
		  export boolean includeMinors := false;
	  end;		
	  
	 OutRec := TeaserSearchServices.ReversePhoneTeaserRecords.records(tempmod,
	  stored_Application_type);
 
	 iesp.ECL2ESP.Marshall.MAC_Marshall_Results(outRec, results,                        
												 iesp.thinreversephoneteaser.t_ThinReversePhoneTeaserResponse, Records,
												 false, RecordCount,,,iesp.Constants.ThinRpsExt.MaxRespRecords);
		Map( 
					phone_value15 = '' OR   			   	                         
					length(std.str.filter(phone_value15,'0123456789')) <> 10 =>
                   FAIL(100, 'Phone Value input field is required'),												 
	     output(results, named('Results'))
		 );
ENDMACRO;	 

/*
 <thinreversephoneteaserrequest>
  <Row>
   <User>
    <ReferenceCode/>
    <BillingCode/>
    <QueryId/>
    <CompanyId/>
    <GLBPurpose/>
    <DLPurpose/>
    <LoginHistoryId/>
    <DebitUnits/>
    <IP/>
    <IndustryClass/>
    <ResultFormat/>
    <LogAsFunction/>
    <SSNMask/>
    <DOBMask/>
    <ExcludeDMVPII>0</ExcludeDMVPII>
    <DLMask>0</DLMask>
    <DataRestrictionMask/>
    <DataPermissionMask/>
    <SourceCode/>
    <ApplicationType/>
    <SSNMaskingOn>0</SSNMaskingOn>
    <DLMaskingOn>0</DLMaskingOn>
    <LnBranded>0</LnBranded>
    <EndUser>
     <CompanyName/>
     <StreetAddress1/>
     <City/>
     <State/>
     <Zip5/>
     <Phone/>
    </EndUser>
    <MaxWaitSeconds/>
    <RelatedTransactionId/>
    <AccountNumber/>
    <TestDataEnabled>0</TestDataEnabled>
    <TestDataTableName/>
    <OutcomeTrackingOptOut>0</OutcomeTrackingOptOut>
    <NonSubjectSuppression/>
   </User>
   <RemoteLocations>
    <Item/>
   </RemoteLocations>
   <ServiceLocations>
    <ServiceLocation>
     <LocationId/>
     <ServiceName/>
     <Parameters>
      <Parameter>
       <Name/>
       <Value/>
      </Parameter>
     </Parameters>
    </ServiceLocation>
   </ServiceLocations>
   <Options>
    <MaxResults/>
    <ReturnCount/>
    <StartingRecord/>
   </Options>
   <SearchBy>
    <Phone/>
   </SearchBy>
  </Row>
 </thinreversephoneteaserrequest>
 */
	