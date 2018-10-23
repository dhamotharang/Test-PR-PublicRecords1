/*--SOAP--
<message name="FinderReportService">
  <part name="FirstName" type="xsd:string"/>
  <part name="MiddleName" type="xsd:string"/>
  <part name="LastName" type="xsd:string"/>
  <part name="allowNicknames" type="xsd:boolean"/>
  <part name="UnparsedFullName" type="xsd:string"/>  
  <part name="PhoneticMatch" type="xsd:boolean"/>
  <separator />
  <part name="Addr" type="xsd:string"/>
  <part name="City" type="xsd:string"/>
  <part name="State" type="xsd:string"/>
  <part name="Zip" type="xsd:string"/>
  <part name="Phone" type="xsd:string"/>
  <separator />
  <part name="DID" type="xsd:string" required="1" />
  <part name="SSN" type="xsd:string"/>
  <part name="SSNMask" type="xsd:string"/>	<!-- [NONE, ALL, LAST4, FIRST5] -->
  <part name="DOB" type="xsd:unsignedInt"/>
  <part name="DPPAPurpose" type="xsd:byte" default="1"/>
  <part name="GLBPurpose" type="xsd:byte" default="1"/> 
  <part name="LnBranded" type="xsd:boolean"/>
  <part name="DataRestrictionMask" type="xsd:string" default="00000000000"/>
  <part name="DataPermissionMask" type="xsd:string" default="00000000000"/>
	<part name="ExcludeDMVPII" type="xsd:boolean"/>
  <separator />
	<part name="ReturnAlsoFound" type="xsd:boolean" />
  <part name="IncludeProfessionalLicenses" type="xsd:boolean"/>
  <part name="IncludeMotorVehicles" type="xsd:boolean"/>
  <part name="IncludePeopleAtWork" type="xsd:boolean"/>
  <part name="IncludeDriversLicenses" type="xsd:boolean"/>
  <part name="IncludePhonesPlus" type="xsd:boolean"/>
  <part name="IncludePhonesFeedback" type="xsd:boolean"/>
  <part name="IncludeCriminalIndicators" type="xsd:boolean"/>
  <separator />
  <part name="UnverifiedAddresses" type="xsd:boolean" default="false" description=" return unverified addresses as well"/>
  <part name="AddressesWithoutPhones" type="xsd:boolean" default="false" description=" includes addresses without phones as well"/>
  <part name="_n_phones" type="xsd:byte" default="20" description=" phones numbers to keep per address W/O secondary range"/>
  <part name="IndicateUnpub" type="xsd:boolean" default="false" description=" show 'UNPUB' for restricted phones"/>
  <part name="AddressRecencyDays" type="xsd:unsignedInt" default="30" description=" days address is 'current'"/>
  <part name="ReturnAllImposters" type="xsd:boolean" description=" returns all imposter records, even having different SSN (demo only)"/>
  <separator />
  <part name="PeopleReportRequest" type="tns:XmlDataSet" cols="80" rows="10" />
</message>
*/
/*--INFO-- Provides indicators and more (Address, AKAs, Imposters).<p/><p/>
  Only persons with "verified" address(es) are returned. Address is verified when it has a current phone 
  (either by exact secondary range or by person's last name as a listed name). Associates' addresses can be
  verified by subject's one, if the same and recent enough.
*/
/*--USES-- ut.input_xslt */

IMPORT iesp, doxie, AutoHeaderI, AutoStandardI, Relationship;

EXPORT FinderReportService () := MACRO
#constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.LEGACY);
#onwarning(4207, ignore);

//The following macro defines the field sequence on WsECL page of query. 
WSInput.MAC_PersonReports_FinderReportService();

#CONSTANT('TwoPartySearch', FALSE);
#constant('IsCRS',true);
#constant('useOnlyBestDID',true);
#constant('LegacyVerified',true);
#constant('SelectIndividually', true); // we will setup all components explicitly
#constant('IncludeCensusData', false); // this can be true only for most complete BpsAddress structures

#constant('RelativeDepth', 2);
#stored ('MaxRelatives', 20);
#stored ('MaxRelativeAddresses', 10);

#stored ('MaxNeighborhoods', 10);
#stored ('NeighborsPerAddress', 20);
#stored ('AddressesPerNeighbor', 1);
#constant('NeighborsProximityRadius', 15);

unsigned1 n_phones := 40 : stored('_n_phones');
#stored('PhonesPerAddress', n_phones);

#constant ('IncludeNonDMVSources', true);
#constant ('IncludeNonRegulatedVehicleSources', true);

  // reads "volatile" options from XML
  GetInputOptions (iesp.peoplereport.t_PeopleReportOption tag) := function
    options := module
      export boolean include_alsofound            := tag.ReturnAlsoFound;
      export boolean include_peopleatwork         := tag.IncludePeopleAtWork;
      export boolean include_motorvehicles        := tag.IncludeMotorVehicle;
      export boolean include_phonesplus           := tag.IncludePhonesPlus;
      export boolean include_proflicenses         := tag.IncludeProfessionalLicenses;
      export boolean include_driverslicenses      := tag.IncludeDriversLicenses;
      export boolean include_phonesfeedback       := tag.IncludePhonesFeedback;
      export boolean include_criminalindicators   := tag.IncludeCriminalIndicators;
    end;
    return options;
  end;

  // stores XML options, which are not BpsReport "compatible", for subsequent reading
  SetInputLocalOptions (PersonReports.input._finderreport options_esdl) := FUNCTION
    #stored ('ReturnAlsoFound', options_esdl.include_alsofound);
    return output (dataset ([],{integer x}), named('__internal__'), extend);
  end;

  rec_in := iesp.peoplereport.t_PeopleReportRequest;
  ds_in := DATASET ([], rec_in) : STORED ('PeopleReportRequest', FEW);
  first_row := ds_in[1] : INDEPENDENT;

  // this will #store some standard input parameters (generally, for search purpose)
  iesp.ECL2ESP.SetInputBaseRequest (first_row);
  iesp.ECL2ESP.SetInputReportBy (first_row.ReportBy);

  // create module incorporating ESDL input options 
  options_in := GetInputOptions (global (first_row.Options));

  // set up default options -- those, which must be always chosen in ESDL mode
  options_esdl := module (project (options_in, PersonReports.input.default_options_finder, opt))
  end;

  // store ESDL options for subsequent legacy-style reading
  PersonReports.functions.SetInputSearchOptions (module (project (options_esdl, PersonReports.input._compoptions, opt)) end);
  SetInputLocalOptions (options_esdl);

  // Read from stored and set parameters from SOAP (rather debug purpose). 
  SR := PersonReports.StoredReader;
  options_stored := module (SR.relatives_options, SR.neighbors_options, SR.imposters_options, 
                            SR.global_options, SR.phones_options)
    // debug options, can be removed (not exposed in ESP)
    shared boolean use_unverified_addr := false : stored ('UnverifiedAddresses');
    export boolean use_verified_address_ra := ~use_unverified_addr;
    export boolean use_verified_address_nb := ~use_unverified_addr;
    export boolean use_no_phone_addresses := false : stored ('AddressesWithoutPhones');
    export boolean nbrs_with_phones := ~use_no_phone_addresses;
    export boolean rels_with_phones := ~use_no_phone_addresses;
    export boolean exact_sec_range_match := false : stored ('ExactSecondRangeMatch');
    // defines whether address is current depending on number of days since date_last_seen
    unsigned1 days := 60 : stored('AddressRecencyDays');
    export unsigned1 address_recency_days := if (days < 255, days, 60);
  end;

  // TODO: cannot choose module conditionally: if (exists (first_raw), options_esdl, options_stored);
  // to bypass global storage use "options_esdl"
  options := options_stored; 
  //options := options_esdl;  

	gm := AutoStandardI.GlobalModule();

  // define search parameters; in "pure" ESDL mode this must be replaced with a module created from XML input
  search_mod := module (project (gm, PersonReports.input._didsearch, opt))
  end;

  // Now define all report parameters
  report_mod := module (options)
    // Do all required translations here
    export unsigned1 GLBPurpose := AutoStandardI.InterfaceTranslator.glb_purpose.val (search_mod);
    export unsigned1 DPPAPurpose := AutoStandardI.InterfaceTranslator.dppa_purpose.val (search_mod);
		export string5 IndustryClass := AutoStandardI.InterfaceTranslator.industry_class_value.val (search_mod);
		export string DataPermissionMask := gm.dataPermissionMask;
    export string DataRestrictionMask := gm.dataRestrictionMask;
    export boolean ln_branded := AutoStandardI.InterfaceTranslator.ln_branded_value.val (search_mod);
    export string6 ssn_mask := 'NONE' : stored('SSNMask'); // ideally, must be "translated" ssnmask
    //export string6 ssn_mask := AutoStandardI.InterfaceTranslator.ssn_mask_val.val (search_mod);
    export unsigned1 score_threshold := AutoStandardI.InterfaceTranslator.score_threshold_value.val (search_mod);
		EXPORT UNSIGNED1 neighborhoods := 10;
  end;

  // execute search
  dids := AutoHeaderI.LIBCALL_FetchI_Hdr_Indv.do (search_mod);

  // main records
	Relationship.IParams.storeParams(first_row.Options.RelationshipOption);
	finder_mod := Relationship.IParams.getParams(report_mod,PersonReports.input._finderreport);
  recs := PersonReports.FinderReport (dids, finder_mod, FALSE);
//  output (recs);

  // wrap it into output structure
  iesp.peoplereport.t_PeopleReportResponse SetResponse (iesp.peoplereport.t_PeopleReportIndividual L) := transform
    Self._Header := iesp.ECL2ESP.GetHeaderRow ();
    Self.Individual := L;
  end;
  results := PROJECT (recs, SetResponse (Left));

  IF (count (dids) > 1,
      fail (203, doxie.ErrorCodes (203)), // or ('ambiguous criteria')
      output (results, named ('Results')));
/*
  // debug
  print_mod := module (project (finder_mod, PersonReports.input._compoptions, opt))
  end;
  res := PersonReports.functions.GetCRSOptionsDataset (print_mod);
  output (res, named ('Options'));
*/
ENDMACRO;
//FinderReportService ();

/*
<PeopleReportRequest>
<row>
<User>
  <ReferenceCode>ref_code_str</ReferenceCode>
  <BillingCode>billing_code</BillingCode>
  <QueryId>query_id</QueryId>
  <GLBPurpose>1</GLBPurpose>
  <DLPurpose>1</DLPurpose>
  <EndUser/>
</User>
<Options>
  <IncludePeopleAtWork>true</IncludePeopleAtWork>
  <IncludeMotorVehicle>true</IncludeMotorVehicle>
  <IncludePhonesPlus>true</IncludePhonesPlus>
  <IncludeProfessionalLicenses>true</IncludeProfessionalLicenses>
  <IncludePhonesFeedback>true</IncludePhonesFeedback>
  <IncludeDriversLicenses>true</IncludeDriversLicenses>
</Options>
<ReportBy>
  <Name>
    <Full></Full><First></First><Middle></Middle><Last></Last>
  </Name>
  <Address>
    <StreetName></StreetName><StreetNumber></StreetNumber><StreetSuffix></StreetSuffix><UnitNumber></UnitNumber>
    <State></State><City></City><Zip5></Zip5></Address>
  <SSN></SSN>
  <UniqueId></UniqueId>
  <DOB><Year></Year><Month></Month><Day></Day></DOB>
  <Phone10></Phone10>
</ReportBy>
</row>
</PeopleReportRequest>
*/
