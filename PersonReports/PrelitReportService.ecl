/*--SOAP--
<message name="PrelitReportService" wuTimeout="300000">
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
	<part name="ApplicationType"     	type="xsd:string"/>
  <part name="LnBranded" type="xsd:boolean"/>
  <part name="DataRestrictionMask" type="xsd:string" default="00000000000"/>
  <part name="DataPermissionMask" type="xsd:string" default="00000000000"/>
	<part name="ExcludeDMVPII" type="xsd:boolean"/>
  <separator />
<!--  <part name="SelectIndividually" type="xsd:boolean" default="false"/> -->
	<part name="ReturnAlsoFound" type="xsd:boolean" />
	<part name="IncludeRelatives"  type="xsd:boolean"/>
	<part name="IncludeAssociates" type="xsd:boolean"/>
  <part name="IncludeDriversLicenses" type="xsd:boolean"/>
  <part name="IncludePhonesPlus" type="xsd:boolean"/>
  <part name="IncludeCriminalIndicators" type="xsd:boolean"/>
  <separator />
  <part name="PreLitigationReportRequest" type="tns:XmlDataSet" cols="80" rows="30" />
</message>
*/
/*--INFO-- Prelit(igation) report. Almost same as asset report*/
/*--USES-- ut.input_xslt */

IMPORT iesp, doxie, AutoHeaderI, AutoStandardI;

EXPORT PrelitReportService () := MACRO
#constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.LEGACY);
#onwarning(4207, ignore);

//The following macro defines the field sequence on WsECL page of query. 
WSInput.MAC_PersonReports_PrelitReportService();

#CONSTANT('TwoPartySearch', FALSE);
#constant('IsCRS',true);
#constant('useOnlyBestDID',true);
#constant('LegacyVerified',true);
#constant('SelectIndividually', true);
#constant('IncludeCensusData', false); // this can be true only for most complete BpsAddress structures
#constant('IncludePhonesFeedback', false);

#constant('RelativeDepth', 1);
#constant('MaxRelatives', 20);
#constant('MaxRelativeAddresses', 10);

// these are set for UCC report
#constant('IncludeMultipleSecured', true);
#constant('ReturnRolledDebtors', true);

// property section
#constant ('IncludePriorProperties', false); // NOT NECESSARILY SUBJECT PROPERTY!
#constant ('CurrentOnly', false);
#constant ('UseCurrentlyOwnedProperty', false);

#constant ('IncludeNonDMVSources', true);

  // reads "volatile" options from XML
  GetInputOptions (iesp.prelitigationreport.t_PreLitigationReportOption tag) := function
    options := module
      export boolean include_alsofound            := tag.ReturnAlsoFound;
      export boolean include_relatives            := tag.IncludeRelatives;
      export boolean include_associates           := tag.IncludeAssociates;
      export boolean include_phonesplus           := tag.IncludePhonesPlus;
      export boolean include_driverslicenses      := tag.IncludeDriversLicenses;
      export boolean include_criminalindicators   := tag.IncludeCriminalIndicators;
    end;
    return options;
  end;

  // stores XML options, which are not BpsReport "compatible", for subsequent reading
  SetInputLocalOptions (PersonReports.input._prelitreport options_esdl) := FUNCTION
    #stored ('ReturnAlsoFound', options_esdl.include_alsofound);
    return output (dataset ([],{integer x}), named('__internal__'), extend);
  end;


  rec_in := iesp.prelitigationreport.t_PreLitigationReportRequest;
  ds_in := DATASET ([], rec_in) : STORED ('PreLitigationReportRequest', FEW);
  first_raw := ds_in[1] : INDEPENDENT;

  // this will #store some standard input parameters (generally, for search purpose)
  iesp.ECL2ESP.SetInputBaseRequest (first_raw);
  iesp.ECL2ESP.SetInputReportBy (first_raw.ReportBy);

  // create module incorporating XML input options 
  options_in := GetInputOptions (global (first_raw.Options));

  // set up default options -- those, which must be always chosen in ESDL mode
  options_esdl := module (project (options_in, PersonReports.input._prelitreport, opt))
  end;

  // store XML options for subsequent legacy-style reading
  PersonReports.functions.SetInputSearchOptions (module (project (options_esdl, PersonReports.input._compoptions, opt)) end);
  SetInputLocalOptions (options_esdl);

  // Read from stored and set parameters from SOAP (rather debug purpose). 
  SR := PersonReports.StoredReader;
  options_stored := module (SR.relatives_options, SR.global_options)
    // other debug options can be specified here
  end;

  // TODO: cannot choose module conditionally: if (exists (first_raw), options_esdl, options_stored);
  // to bypass global storage use "options_esdl"
  options := options_stored; 
  // options := options_esdl;  

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
		export string32 applicationType := AutoStandardI.InterfaceTranslator.application_type_val.val(project(search_mod,AutoStandardI.InterfaceTranslator.application_type_val.params));
  end;

  // execute search
  dids := AutoHeaderI.LIBCALL_FetchI_Hdr_Indv.do (search_mod);

  // main records
  prelit_mod := module (project (report_mod, PersonReports.input._prelitreport, opt)) end;
  recs := PersonReports.PrelitReport (dids, prelit_mod, FALSE).Records;
  // output (recs);

  // wrap it into output structure
  iesp.prelitigationreport.t_PrelitigationReportResponse SetResponse (recordof (recs) L) := transform
    Self._Header := iesp.ECL2ESP.GetHeaderRow ();
    Self.Individual := L;
  end;
  results := PROJECT (recs, SetResponse (Left));

  IF (count (dids) > 1,
      fail (203, doxie.ErrorCodes (203)), // or ('ambiguous criteria')
      output (results, named ('Results')));
/*
  // debug
  print_mod := module (project (prelit_mod, PersonReports.input._compoptions, opt))
  end;
  res := PersonReports.functions.GetCRSOptionsDataset (print_mod);
  output (res, named ('Options'));
*/
ENDMACRO;
//PrelitReportService ();

/*
<PrelitigationReportRequest>
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
	<ReturnAlsoFound></ReturnAlsoFound>
	<IncludeRelatives></IncludeRelatives>
	<IncludeAssociates></IncludeAssociates>
	<IncludePhonesPlus></IncludePhonesPlus>
	<IncludeProfessionalLicenses></IncludeProfessionalLicenses>
	<IncludeDriversLicenses></IncludeDriversLicenses>
</Options>
<ReportBy>
  <Name>
    <Full></Full>
    <First></First>
    <Middle></Middle>
    <Last></Last>
  </Name>
  <Address>
    <StreetName></StreetName>
    <StreetNumber></StreetNumber>
    <StreetSuffix></StreetSuffix>
    <UnitNumber></UnitNumber>
    <State></State>
    <City></City>
    <Zip5></Zip5>
  </Address>
  <SSN></SSN>
  <UniqueId></UniqueId>
  <DOB>
    <Year></Year>
    <Month></Month>
    <Day></Day>
   </DOB>
  <Phone10></Phone10>
</ReportBy>
</row>
</PrelitigationReportRequest>
*/

