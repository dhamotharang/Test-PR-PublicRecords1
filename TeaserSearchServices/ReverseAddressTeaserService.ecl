/*--SOAP--
<message name="ReverseAddressTeaserService">

  <part name="StreetNumber" type="xsd:string"/>
	<part name="StreetPreDirection" type="xsd:string"/>
	<part name="StreetName" type="xsd:string"/>
	<part name="StreetSuffix" type="xsd:string"/>
	<part name="StreetPostDirection" type="xsd:string"/>
	<part name="UnitDesignation" type="xsd:string"/>
	<part name="UnitNumber" type="xsd:string"/>
	<part name="StreetAddress1" type="xsd:string"/>
	<part name="StreetAddress2" type="xsd:string"/>
  <part name="City" type="xsd:string"/>
	<part name="State" type="xsd:string"/>
	<part name="Zip5" type="xsd:string"/>
  <part name="Zip4" type="xsd:string"/>
 
  <separator />
	<part name="ReturnCount"				 type="xsd:unsignedInt"/>
	<part name="StartingRecord"			 type="xsd:unsignedInt"/>	
  <separator />
	<part name="ApplicationType"     	type="xsd:string"/>
  <separator />
  <part name="ReverseAddressTeaserRequest" type="tns:XmlDataSet" cols="80" rows="30" />
</message>
*/
/*--INFO-- services searches for matching address hits (streetname, StreetNum, state) minimum input
           and returns current and prev residents and their age, year built of house at that addr and relatives
*/


IMPORT iesp, TeaserSearchServices;

EXPORT ReverseAddressTeaserService := MACRO
 #CONSTANT('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
  rec_in := iesp.thinreverseAddressteaser.t_ThinReverseAddressTeaserRequest;
  ds_in := DATASET ([], rec_in) : STORED ('ThinReverseAddressTeaserRequest', FEW);
  first_row := ds_in[1] : INDEPENDENT;
  
  // set glb/dppa etc by calling setInputUser
  iesp.ECL2ESP.SetInputBaseRequest (first_row);
  search_by := GLOBAL (first_row.SearchBy);
  search_options := GLOBAL (first_row.Options);
    
  inputAddr := search_by.Address;

  // 'addr' stored value set in this call amoung other things..
  iesp.ecl2esp.setINputAddress(InputAddr);
   
  STRING prim_name := '' : STORED('prim_name');
  STRING prim_range := '' : STORED('prim_range');
  STRING stateInfo := '' : STORED('State');
  
  addrInfo := InputAddr.streetAddress1;

  InputInsufficient := ((prim_name = '' OR prim_range = '') AND AddrInfo = '')
                        OR stateInfo = '';

  UNSIGNED1 stored_dppa_purpose := 0 : STORED('DPPAPurpose');
  UNSIGNED1 stored_glb_purpose := 0 : STORED('GLBPurpose');
  
  STRING stored_datarestrictionmask := '' : STORED('DataRestrictionMask');

  restrictmod := MODULE(AutoStandardI.DataRestrictionI.params)
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
                        
   tempmod := MODULE(PROJECT(Autostandardi.GlobalModule(),TeaserSearchServices.ReverseAddressTeaserRecords.params,OPT))
     EXPORT applicationType := AutoStandardI.InterfaceTranslator.application_type_val.val(
        PROJECT(autostandardi.GlobalModule(),AutoStandardI.InterfaceTranslator.application_type_val.params));
     END;
  //
  recordsFinal := TeaserSearchServices.ReverseAddressTeaserRecords.val(tempMod,RestrictMod);
   
  iesp.ECL2ESP.Marshall.MAC_Marshall_Results(recordsFinal, results,
    iesp.ThinReverseAddressteaser.t_ThinReverseAddressTeaserResponse, Records,
    FALSE, RecordCount,,,iesp.Constants.ThinReverseAddress.MaxRespRecords);
 
  IF (InputInsufficient, FAIL (301, doxie.ErrorCodes (301)),
    OUTPUT (Results, NAMED('Results'))
  );
ENDMACRO;

/*

<reverseaddressteaserrequest>
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
    <Blind>0</Blind>
    <MakeVendorGatewayCall/>
    <StrictMatch>0</StrictMatch>
    <MaxResults/>
    <ReturnCount/>
    <StartingRecord/>
   </Options>
   <SearchBy>
    <Address>
     <StreetNumber/>
     <StreetPreDirection/>
     <StreetName/>
     <StreetSuffix/>
     <StreetPostDirection/>
     <UnitDesignation/>
     <UnitNumber/>
     <StreetAddress1/>
     <StreetAddress2/>
     <City/>
     <State/>
     <Zip5/>
     <Zip4/>
     <County/>
     <PostalCode/>
     <StateCityZip/>
    </Address>
   </SearchBy>
  </Row>
 </reverseaddressteaserrequest>

*/
