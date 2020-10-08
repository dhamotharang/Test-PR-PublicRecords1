/*--SOAP--
<message name="ReversePhoneTeaserService">
  <part name="Phone" type="xsd:string"/>
    <!-- COMPLIANCE SETTINGS -->
  <part name="GLBPurpose" type="xsd:byte"/>
  <part name="DPPAPurpose" type="xsd:byte"/>
  <part name="DataRestrictionMask" type="xsd:string"/>
  <part name="Phone" type="xsd:string"/>

  <separator />
  <part name="ReturnCount" type="xsd:unsignedInt"/>
  <part name="StartingRecord" type="xsd:unsignedInt"/>
  <separator />
  <part name="ApplicationType" type="xsd:string"/>
  <separator />
  <part name="ThinReversePhoneTeaserRequest" type="tns:XmlDataSet" cols="80" rows="30" />
</message>
*/
/*--INFO-- Reverse Phone Teaser Service.
*/

IMPORT iesp, AutoStandardI, TeaserSearchServices, std, doxie;

EXPORT ReversePhoneTeaserService := MACRO
  #CONSTANT('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
  rec_in := iesp.thinreversephoneteaser.t_ThinReversePhoneTeaserRequest;
  ds_in := DATASET ([], rec_in) : STORED ('ThinReversePhoneTeaserRequest', FEW);
  first_row := ds_in[1] : INDEPENDENT;

  //set options
  // Set DPPA, GLBA, DRM, App_type etc. as it calls setInputUser
  iesp.ECL2ESP.SetInputBaseRequest (first_row);

  //set main search criteria:
  search_by := GLOBAL (first_row.SearchBy);
  search_options := GLOBAL (first_row.Options);

  STRING15 phone_value15 := TRIM(search_By.Phone, LEFT,RIGHT);
  #STORED('phone', Phone_value15);

  STRING32 stored_Application_type := '' : STORED('ApplicationType');

  //// Get back the DPPA, GLBA, DRM, etc
  UNSIGNED1 stored_dppa_purpose := 0 : STORED('DPPAPurpose');
  UNSIGNED1 stored_glb_purpose := 0 : STORED('GLBPurpose');

  STRING stored_datarestrictionmask := '' : STORED('DataRestrictionMask');

  tempmod := MODULE(AutoStandardI.DataRestrictionI.params)
    EXPORT BOOLEAN AllowAll := FALSE;
    EXPORT BOOLEAN AllowDPPA := FALSE;
    EXPORT BOOLEAN AllowGLB := FALSE;
    EXPORT STRING DataRestrictionMask := stored_datarestrictionmask;
    EXPORT UNSIGNED1 DPPAPurpose := stored_dppa_purpose;
    EXPORT UNSIGNED1 GLBPurpose := stored_glb_purpose;
    EXPORT BOOLEAN ignoreFares := FALSE;
    EXPORT BOOLEAN ignoreFidelity := FALSE;
    EXPORT BOOLEAN includeMinors := FALSE;
  END;

  OutRec := TeaserSearchServices.ReversePhoneTeaserRecords.records(tempmod,
  stored_Application_type);

  iesp.ECL2ESP.Marshall.MAC_Marshall_Results(outRec, results,
    iesp.thinreversephoneteaser.t_ThinReversePhoneTeaserResponse, Records,
    FALSE, RecordCount,,,iesp.Constants.ThinRpsExt.MaxRespRecords);
    
  MAP(
    phone_value15 = '' OR
    LENGTH(std.str.filter(phone_value15,'0123456789')) <> 10 =>
      FAIL(100, 'Phone Value input field is required'),
    OUTPUT(results, NAMED('Results'))
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
