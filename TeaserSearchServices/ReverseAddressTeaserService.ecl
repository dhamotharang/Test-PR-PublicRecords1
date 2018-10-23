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
 #constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.LEGACY);
	rec_in := iesp.thinreverseAddressteaser.t_ThinReverseAddressTeaserRequest;
	ds_in := DATASET ([], rec_in) : STORED ('ThinReverseAddressTeaserRequest', FEW);
  first_row := ds_in[1] : INDEPENDENT;
	
  // set glb/dppa etc by calling setInputUser
  iesp.ECL2ESP.SetInputBaseRequest (first_row);
	search_by := global (first_row.SearchBy);
	search_options := GLOBAL (first_row.Options);
		
  inputAddr := search_by.Address;

	// 'addr' stored value set in this call amoung other things..                	 
	iesp.ecl2esp.setINputAddress(InputAddr);						 
   
	string prim_name  := '' : stored('prim_name');
	string prim_range := '' : stored('prim_range');	
	string stateInfo  := '' : stored('State');
	
	addrInfo := InputAddr.streetAddress1;

  InputInsufficient := ((prim_name = '' OR prim_range = '')   AND AddrInfo = '')
	                      OR stateInfo = '';

  unsigned1 stored_dppa_purpose := 0 : stored('DPPAPurpose');
	unsigned1 stored_glb_purpose := 0 : stored('GLBPurpose');
	
	string stored_datarestrictionmask := '' : stored('DataRestrictionMask');

	restrictmod := module(AutoStandardI.DataRestrictionI.params)
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
												
   tempmod := MODULE(PROJECT(Autostandardi.GlobalModule(),TeaserSearchServices.ReverseAddressTeaserRecords.params,OPT))													 	   
		 EXPORT applicationType := AutoStandardI.InterfaceTranslator.application_type_val.val(
		                       project(autostandardi.GlobalModule(),AutoStandardI.InterfaceTranslator.application_type_val.params));
		 end;
	//	
	recordsFinal := TeaserSearchServices.ReverseAddressTeaserRecords.val(tempMod,RestrictMod);
 
	// output(recordsFinal, named('recordsFinal'));
		
	iesp.ECL2ESP.Marshall.MAC_Marshall_Results(recordsFinal, results, 
	                                iesp.ThinReverseAddressteaser.t_ThinReverseAddressTeaserResponse, Records, 
                                             false, RecordCount,,,iesp.Constants.ThinReverseAddress.MaxRespRecords);
 // output(results, named('Results'));		
 //output(inputAddr, named('inputAddr'));
 //output(AddrInfo, named('AddrInfo'));
 // output(prim_name, named('prim_name'));
 // output(prim_range, named('prim_range'));
  // output(stateInfo, named('stateInfo'));
 // output(stateInfo, named('stateInfo2'));
 //output(addrInfo, named('addrInfo'));
 // output(recordsFinal, named('recordsFinal'));
 
  if (InputInsufficient, FAIL (301, doxie.ErrorCodes (301)), 
                       output (Results, named('Results'))
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