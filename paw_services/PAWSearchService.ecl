// For the complete list of SOAP input parameters, please see the newly created (as of 20210126)
//    WSinput.MAC_paw_services_PawsSarchService attribute.
// For the old SOAP inputs info, see the bottom of this attribute.

/*--INFO-- Returns PAW (People at Work) records.*/
IMPORT AutoStandardI, doxie, paw_services, Suppress, WSInput;

export PAWSearchService := macro

  WSInput.MAC_paw_services_PawSearchService();

  #CONSTANT('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
  boolean negate_true_defaults := false : STORED('ECL_NegateTrueDefaults'); // internal ECL use only
  boolean return_waf := true : STORED('ReturnAlsoFound');

// As of 12/04/20, it does not appear that this is needed any more, since tempmodids is not used anywhere
// and even though ContactID is "stored" in it, that field never shows up in the list of inputs when the query is executed on a 
// roxie 8002/WsECL box.  However will leave it in for historical purposes.
  // Bug: 45732:  Pulled tempmodids from the PAW_Services.PAWSearchService_Records.val
  // attribute.  This allows the attribute to find any PAW records given a set
  // of IDs (from any other attribute -- Initially: doxie.HFRS)
  tempmodids := module(project(AutoStandardI.GlobalModule(),PAW_Services.PAWSearchService_IDs.params,opt))
    export ContactID := 0 : stored('ContactID');
  end;

  gmod := AutoStandardI.GlobalModule();
  mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated(gmod);
  tempmod := module(gmod, mod_access)
    export string DataPermissionMask := mod_access.DataPermissionMask; //conflicting definition
    export string DataRestrictionMask := mod_access.DataRestrictionMask; //conflicting definition
    export unsigned2 REQ_PHONES_PER_ADDR := PAW_Services.Constants.MAX_PHONES_PER_ADDR : stored('ReqPhonesPerAddr');
    export unsigned2 REQ_DATES_PER_POSITION := PAW_Services.Constants.MAX_DATES_PER_POSITION : stored('ReqDatesPerPosition');
    export unsigned2 REQ_DATES_PER_EMPLOYER := PAW_Services.Constants.MAX_DATES_PER_EMPLOYER : stored('ReqDatesPerEmployer');
    export unsigned2 REQ_FEINS_PER_EMPLOYER := PAW_Services.Constants.MAX_FEINS_PER_EMPLOYER : stored('ReqFeinsPerEmployer');
    export unsigned2 REQ_COMPANY_NAMES_PER_EMPLOYER := PAW_Services.Constants.MAX_COMPANY_NAMES_PER_EMPLOYER : stored('ReqCompanyNamesPerEmployer');
    export unsigned2 REQ_ADDRS_PER_EMPLOYER := PAW_Services.Constants.MAX_ADDRS_PER_EMPLOYER : stored('ReqAddrsPerEmployer');
    export unsigned2 REQ_POSITIONS_PER_EMPLOYER := PAW_Services.Constants.MAX_POSITIONS_PER_EMPLOYER : stored('ReqPositionsPerEmployer');
    export unsigned2 REQ_SSNS_PER_PERSON := PAW_Services.Constants.MAX_SSNS_PER_PERSON : stored('ReqSsnsPerPerson');
    export unsigned2 REQ_NAMES_PER_PERSON := PAW_Services.Constants.MAX_NAMES_PER_PERSON : stored('ReqNamesPerPerson');
    export unsigned2 REQ_EMPLOYERS_PER_PERSON := PAW_Services.Constants.MAX_EMPLOYERS_PER_PERSON : stored('ReqEmployersPerPerson');
    export unsigned2 PenaltThreshold := 5;
    export includeAlsoFound := return_waf AND ~negate_true_defaults;
    export boolean IncludeCriminalIndicators := false : stored('IncludeCriminalIndicators');
  end;
  mod_paw := PROJECT(tempmod, PAW_Services.PAWSearchService_Records.params, OPT);

  // Bug: 45732 - 
  // removed retrieving IDs from the PAW_Services.PAWSearchService_Records.val
  // attribute to allow the Doxie.HFRS to call the attribute with its IDs 
  // allowing the doxie.hfrs to display a PAW-v2 child dataset in 
  // standard PAW rollup format
  ids := paw_services.PAWSearchService_IDs.val(mod_paw);

  tempresults := PAW_Services.PAWSearchService_Records.val(ids,mod_paw);

  //Suppress by SSN and DID.
  Suppress.MAC_Suppress_Child.keyLinked(tempresults, , ssn_suppressed, tempmod.applicationType, Suppress.Constants.LinkTypes.SSN, ssn, __seq, ssns, true);
  Suppress.MAC_Suppress(ssn_suppressed, did_suppressed, tempmod.applicationType, Suppress.Constants.LinkTypes.DID, did);

  doxie.MAC_Header_Field_Declare();
  doxie.MAC_Marshall_Results(did_suppressed,tempmarshalled);

  output(tempmarshalled,named('Results'));

endmacro;

// SAVED original SOAP inputs ----v
/*--SOAP--
<message name="PAWSearchService">
<!-- COMPLIANCE SETTINGS -->
<part name="GLBPurpose"         type="xsd:byte"/>
<part name="DPPAPurpose"        type="xsd:byte"/>
<part name="DataRestrictionMask" type="xsd:string"/>

<!-- ID NUMBERS -->
<part name="ContactID"          type="xsd:unsignedInt"/>
<part name="DID"                type="xsd:unsignedInt"/>
<part name="BDID"               type="xsd:unsignedInt"/>

<!-- AUTOKEY SEARCH FIELDS -->
<part name="SSN" 								type="xsd:string"/>
<part name="FirstName"   				type="xsd:string"/>
<part name="MiddleName"  				type="xsd:string"/>
<part name="LastName"   	 			type="xsd:string"/>
<part name="FEIN"               type="xsd:string"/>
<part name="CompanyName" 				type="xsd:string"/>
<part name="Addr"	    	   			type="xsd:string"/>
<part name="City"   	     			type="xsd:string"/>
<part name="State"	       			type="xsd:string"/>
<part name="Zip" 	        			type="xsd:string"/>
<part name="Phone"              type="xsd:string"/>

<!-- AUTOKEY OPTIONS -->
<part name="AllowNickNames" 		type="xsd:boolean"/>
<part name="PhoneticMatch"  		type="xsd:boolean"/>
<part name="ZipRadius"  				type="xsd:unsignedInt"/>
<!-- ROLLUP OPTIONS -->
<part name="ReqPhonesPerAddr"           type="xsd:unsignedInt"/>
<part name="ReqDatesPerPosition"        type="xsd:unsignedInt"/>
<part name="ReqDatesPerEmployer"        type="xsd:unsignedInt"/>
<part name="ReqFeinsPerEmployer"        type="xsd:unsignedInt"/>
<part name="ReqCompanyNamesPerEmployer" type="xsd:unsignedInt"/>
<part name="ReqAddrsPerEmployer"        type="xsd:unsignedInt"/>
<part name="ReqPositionsPerEmployer"    type="xsd:unsignedInt"/>
<part name="ReqSsnsPerPerson"           type="xsd:unsignedInt"/>
<part name="ReqNamesPerPerson"          type="xsd:unsignedInt"/>
<part name="ReqEmployersPerPerson"      type="xsd:unsignedInt"/>
<part name="ReturnAlsoFound"            type = "xsd:boolean"/>
<part name="ECL_NegateTrueDefaults"     type = "xsd:boolean"/>

<!-- ADDITIONAL OPTIONS -->
<part name="PenaltThreshold"		type="xsd:unsignedInt"/>
<part name="SSNMask"						type="xsd:string"/>
<part name="NoDeepDive"         type="xsd:boolean"/>
<part name="IncludeCriminalIndicators" type="xsd:boolean"/>

<!-- RESULTS LIST MANAGEMENT -->
<part name="MaxResults"					type="xsd:unsignedInt"/>
<part name="MaxResultsThisTime"	type="xsd:unsignedInt"/>
<part name="SkipRecords"				type="xsd:unsignedInt"/>
</message>
*/
