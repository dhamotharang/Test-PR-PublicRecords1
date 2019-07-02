/*--SOAP--
<message name="PrelitReportServiceFCRA" wuTimeout="300000">
  <part name="DID" type="xsd:string" required="1" />
  <separator />
  <part name="SSNMask" type="xsd:string"/>  <!-- [NONE, ALL, LAST4, FIRST5] -->
  <part name="DOB" type="xsd:unsignedInt"/>
  <part name="DPPAPurpose" type="xsd:byte" default="1"/>
  <part name="FCRAPurpose" type="xsd:string"/>
  <part name="GLBPurpose" type="xsd:byte" default="1"/> 
  <part name="ApplicationType"       type="xsd:string"/>
  <part name="LnBranded" type="xsd:boolean"/>
  <part name="DataRestrictionMask" type="xsd:string" default="0000000000000000"/>
  <part name="FFDOptionsMask"         type="xsd:string"/>
  <part name="SuppressWithdrawnBankruptcy" type="xsd:boolean"/>
  <separator />
<!--  <part name="SelectIndividually" type="xsd:boolean" default="false"/> -->
  <part name="FcraPrelitigationReportRequest" type="tns:XmlDataSet" cols="80" rows="30" />
</message>
*/
/*--INFO-- Prelit(igation) report. Almost same as asset report*/

IMPORT iesp, doxie, AutoHeaderI, AutoStandardI, FFD, ut;

EXPORT PrelitReportServiceFCRA () := MACRO

#onwarning(4207, ignore);
#constant('NoDeepDive', true); // needed in bankruptcy V3 to exclude non-fcra business header search

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

  // stores XML options, which are not BpsReport "compatible", for subsequent reading
  SetInputLocalOptions (PersonReports.IParam._prelitreport options_esdl) := FUNCTION
    #stored ('ReturnAlsoFound', options_esdl.include_alsofound);
    return output (dataset ([],{integer x}), named('__internal__'), extend);
  end;


  rec_in := iesp.prelitigationreport_fcra.t_FcraPreLitigationReportRequest;
  ds_in := DATASET ([], rec_in) : STORED ('FcraPrelitigationReportRequest', FEW);
  first_row := ds_in[1] : INDEPENDENT;
  
   // this will #store some standard input parameters (generally, for search purpose)
  iesp.ECL2ESP.SetInputBaseRequest (first_row);

  string12 UniqueId := global(first_row.ReportBy).UniqueId;
  #stored('did', UniqueId);

  // set up default options -- those, which must be always chosen in ESDL mode
  options_esdl := module (PersonReports.IParam._prelitreport)
    export boolean bk_suppress_withdrawn := first_row.Options.SuppressWithdrawnBankruptcy;

    // this coming not from the t_FcraPrelitReportOption but from the t_User structure
    export integer1 non_subject_suppression := ut.getNonSubjectSuppression (first_row.User.NonSubjectSuppression);
  end;

  // store XML options for subsequent legacy-style reading
  PersonReports.functions.SetInputSearchOptions (module (project (options_esdl, PersonReports.IParam._compoptions, opt)) end);
  SetInputLocalOptions (options_esdl);

  // Read from stored and set parameters from SOAP (rather debug purpose). 
  SR := PersonReports.StoredReader;
  options_stored := module (SR.relatives_options, SR.global_options)
    // other debug options can be specified here
  end;

  // TODO: cannot choose module conditionally: if (exists (first_row), options_esdl, options_stored);
  // to bypass global storage use "options_esdl"
  options := options_stored; 
  // options := options_esdl;  

  // define search parameters; in "pure" ESDL mode this must be replaced with a module created from XML input
  gm := AutoStandardI.GlobalModule();
  search_mod := module (project (gm, PersonReports.IParam._didsearch, opt))
  end;

  // Now define all report parameters
  mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated (gm);
  report_mod := module (options, mod_access)
    export unsigned1 liensjudgments_version := 2; // latest available
    export unsigned1 bankruptcy_version := 3;
    // those are not yet in the report (so far report is for project July only)
    // export boolean include_alsofound := false;
    export boolean include_motorvehicles := false;
    export boolean include_uccfilings := false;
    export boolean include_imposters := false;
    export boolean include_akas := true;
    export boolean include_bpsaddress := false;
    export boolean include_peopleatwork := false;
    // export boolean include_bankruptcy      := true;
    export boolean include_proflicenses    := false;
    export boolean include_corpaffiliations := false;
    // export boolean include_liensjudgments  := true;

    // Do all required translations here
    export unsigned1 score_threshold := AutoStandardI.InterfaceTranslator.score_threshold_value.val (search_mod);
    export integer1 non_subject_suppression := options_esdl.non_subject_suppression;
    export boolean bk_include_dockets := options_esdl.bk_include_dockets;
    export boolean bk_suppress_withdrawn := options_esdl.bk_suppress_withdrawn;
    export integer8 FFDOptionsMask := FFD.FFDMask.Get(first_row.Options.FFDOptionsMask);
    export integer FCRAPurpose := FCRA.FCRAPurpose.Get(first_row.Options.FCRAPurpose);
  end;

  // The DID must be provided in the input
  dids := dataset ([(unsigned6) search_mod.did], doxie.layout_references);

  // main records
  prelit_mod := module (project (report_mod, PersonReports.IParam._prelitreport, opt)) end;
  recs_combined := PersonReports.PrelitReport (dids, prelit_mod, TRUE);
  recs := project(recs_combined.Records, transform(iesp.prelitigationreport_fcra.t_FcraPreLitigationReportIndividual,
       Self := Left));  // it is single record coming as dataset
  
 input_consumer := FFD.MAC.PrepareConsumerRecord(search_mod.did, true, , UniqueId);  // we only have UniqueId coming from input

  // wrap it into output structure
   iesp.prelitigationreport_fcra.t_FcraPreLitigationReportResponse SetResponse () := transform
       Self._Header := iesp.ECL2ESP.GetHeaderRow ();
       
       Self.Individual := recs[1];
       Self.ConsumerStatements := recs_combined.Statements;
       Self.ConsumerAlerts := recs_combined.ConsumerAlerts;
       Self.Consumer := input_consumer;
     end;
     results := dataset ([SetResponse ()]);
   
     IF (count (dids) > 1,
         fail (203, doxie.ErrorCodes (203)), // or ('ambiguous criteria')
         output (results, named ('Results')));

ENDMACRO;
//PrelitReportService ();
