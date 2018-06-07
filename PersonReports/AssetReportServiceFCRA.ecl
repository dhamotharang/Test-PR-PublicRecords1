/*--SOAP--
<message name="AssetReportService" wuTimeout="300000">
  <part name="DID" type="xsd:string" required="1" />
  <separator />
  <part name="SSNMask" type="xsd:string"/>  <!-- [NONE, ALL, LAST4, FIRST5] -->
  <part name="DOB" type="xsd:unsignedInt"/>
  <part name="FCRAPurpose" type="xsd:string"/>
  <part name="DPPAPurpose" type="xsd:byte" default="1"/>
  <part name="GLBPurpose" type="xsd:byte" default="1"/> 
  <part name="ApplicationType"       type="xsd:string"/>
  <part name="LnBranded" type="xsd:boolean"/>
  <part name="DataRestrictionMask" type="xsd:string" default="00000000000"/>
  <part name="FFDOptionsMask"         type="xsd:string"/>
  <part name="SuppressWithdrawnBankruptcy" type="xsd:boolean"/>
  <separator />
  <part name="FcraAssetReportRequest" type="tns:XmlDataSet" cols="80" rows="30" />
</message>
*/
/*--INFO-- Searches for personal assets (FCRA-data only)<p/><p/>*/

IMPORT iesp, doxie, AutoHeaderI, AutoStandardI, ut;

EXPORT AssetReportServiceFCRA () := MACRO

#CONSTANT('TwoPartySearch', FALSE);

#constant('IncludeHRI', false);
#constant('IsCRS',true);
#constant('LegacyVerified',true);
#constant('SelectIndividually', true); // we will setup all components explicitly

// property section
#constant ('IncludePriorProperties', false); // NOT NECESSARILY SUBJECT PROPERTY!
#constant ('CurrentOnly', false);
#constant ('UseCurrentlyOwnedProperty', false);



  // reads "volatile" options from XML
  // so far there are no any specific options for FCRA report, I keep it here for the future needs
  GetInputOptions (iesp.assetreport_fcra.t_FcraAssetReportOption tag) := function
    options := module
      export boolean bk_suppress_withdrawn := tag.SuppressWithdrawnBankruptcy;
     // export boolean include_alsofound            := tag.ReturnAlsoFound;
      // export boolean include_proflicenses         := tag.IncludeProfessionalLicenses;
      // export boolean include_peopleatwork         := tag.IncludePeopleAtWork;
    end;
    return options;
  end;

  rec_in := iesp.assetreport_fcra.t_FcraAssetReportRequest;
  ds_in := DATASET ([], rec_in) : STORED ('FcraAssetReportRequest', FEW);
  first_row := ds_in[1] : INDEPENDENT;
  
  // this will #store some standard input parameters (generally, for search purpose)
  iesp.ECL2ESP.SetInputBaseRequest (first_row);

  string12 UniqueId := global(first_row.ReportBy).UniqueId;
  #stored('did', UniqueId);
  

  // create module incorporating XML input options 
  options_in := GetInputOptions (global (first_row.Options));

  // set up default options -- those, which must be always chosen in ESDL mode
  options_esdl := module (project (options_in, PersonReports.input._assetreport, opt))
    // this coming not from the t_FcraAssetReportOption but from the t_User structure
    export integer1 non_subject_suppression := ut.getNonSubjectSuppression (first_row.User.NonSubjectSuppression);
  end;

  // store XML options for subsequent legacy-style reading
  PersonReports.functions.SetInputSearchOptions (module (project (options_esdl, PersonReports.input._compoptions, opt)) end);

  // Read from stored and set parameters from SOAP (rather debug purpose). 
  SR := PersonReports.StoredReader;
  options_stored := module (SR.global_options)
    // other debug options can be specified here
  end;

  // TODO: cannot choose module conditionally: if (exists (first_raw), options_esdl, options_stored);
  // to bypass global storage use "options_esdl"
  options := options_stored; 
  // options := options_esdl;  

  // define search parameters; in "pure" ESDL mode this must be replaced with a module created from XML input
   globals := AutoStandardI.GlobalModule();
  search_mod := module (project (globals, PersonReports.input._didsearch, opt))
  end;

  // Now define all report parameters
  report_mod := module (options)
    // those are not yet in the report (so far report is for project July only)
    export boolean include_alsofound := false;
    export boolean include_motorvehicles := false;
    export boolean include_uccfilings := false;
    export boolean include_imposters := false;
    export boolean include_akas := true;
    export boolean include_bpsaddress := false;
    export boolean include_peopleatwork := false;

    // Do all required translations here
    export unsigned1 GLBPurpose := AutoStandardI.InterfaceTranslator.glb_purpose.val (search_mod);
    export unsigned1 DPPAPurpose := AutoStandardI.InterfaceTranslator.dppa_purpose.val (search_mod);
    export string5 IndustryClass := AutoStandardI.InterfaceTranslator.industry_class_value.val (search_mod);
    export string DataPermissionMask := search_mod.dataPermissionMask;
    export string DataRestrictionMask := globals.dataRestrictionMask;
    export boolean ln_branded := AutoStandardI.InterfaceTranslator.ln_branded_value.val (search_mod);
    export string6 ssn_mask := 'NONE' : stored('SSNMask'); // ideally, must be "translated" ssnmask
    //export string6 ssn_mask := AutoStandardI.InterfaceTranslator.ssn_mask_val.val (search_mod);
    export unsigned1 score_threshold := AutoStandardI.InterfaceTranslator.score_threshold_value.val (search_mod);
    export string32 applicationType := AutoStandardI.InterfaceTranslator.application_type_val.val(project(search_mod,AutoStandardI.InterfaceTranslator.application_type_val.params));
    export integer1 non_subject_suppression := options_esdl.non_subject_suppression;
    export boolean bk_suppress_withdrawn := options_esdl.bk_suppress_withdrawn;
    export integer8 FFDOptionsMask := FFD.FFDMask.Get(first_row.Options.FFDOptionsMask);
    export integer8 FCRAPurpose := FCRA.FCRAPurpose.Get(first_row.Options.FCRAPurpose);
  end;

  // The DID must be provided in the input
  dids := dataset ([(unsigned6) search_mod.did], doxie.layout_references);

  // main records
  asset_mod := module (project (report_mod, PersonReports.input._assetreport, opt)) end;
  recs_combined := PersonReports.AssetReport(dids, asset_mod, TRUE);
  recs := recs_combined.Records[1];  // single row coming as dataset here
//  output (recs);

  input_consumer := FFD.MAC.PrepareConsumerRecord(search_mod.did, true,, UniqueId);  // we only have UniqueId coming from input

  // wrap it into output structure
   iesp.assetreport_fcra.t_FcraAssetReportResponse SetResponse () := transform
       Self._Header := iesp.ECL2ESP.GetHeaderRow ();
       Self.Individual := recs;
       Self.ConsumerStatements := recs_combined.Statements;
       Self.ConsumerAlerts := recs_combined.ConsumerAlerts;
       Self.Consumer := input_consumer;
     end;
   results := dataset ([SetResponse ()]);


    IF (count (dids) > 1,
                     fail (203, doxie.ErrorCodes (203)), // or ('ambiguous criteria'),
                    output (results, named ('Results')));


  

  // debug
 /* print_mod := module (project (asset_mod, PersonReports.input._compoptions, opt))
  end;
  res := PersonReports.functions.GetCRSOptionsDataset (print_mod);
  output (res, named ('Options'));
*/
ENDMACRO;
// AssetReportServiceFCRA ();

/*
<AssetReportRequest>
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
  <IncludeProfessionalLicenses></IncludeProfessionalLicenses>
</Options>
<ReportBy>
  <UniqueId></UniqueId>
</ReportBy>
</row>
</AssetReportRequest>
*/
