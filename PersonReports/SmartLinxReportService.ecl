 /*--SOAP--
 <message name="SmartLinxReportService" wuTimeout="300000">
  <part name="DID" type="xsd:string" required="1" />
  <part name="SSN" type="xsd:string"/>
  <part name="DPPAPurpose" type="xsd:byte" default="1"/>
  <part name="GLBPurpose" type="xsd:byte" default="1"/> 
  <part name="LnBranded" type="xsd:boolean"/>
  <part name="DataRestrictionMask" type="xsd:string" default="00000000000"/>
  <part name="DataPermissionMask" type="xsd:string" default="00000000000"/>
  <part name="LegacyVerified" type="xsd:boolean" disabled="true" description=" not implemented"/>
  <part name="IncludeBlankDOD" type="xsd:boolean" default="false" description=" allowes to return death records with no DOD"/>
  <part name="ExcludeDMVPII" type="xsd:boolean"/>
  <separator />
  <part name="IncludeBestInfo" type="xsd:boolean" default="true" description=" ...new selector"/>
  <part name="IncludeBpsAddress" type="xsd:boolean" default="true" description=" ...new selector"/>
        <part name="IncludeCensusData" type="xsd:boolean" indent="true" />
        <part name="IncludePhonesFeedback" type="xsd:boolean" indent="true" />
        <part name="ExactSecondRangeMatch" type="xsd:boolean" indent="true" 
                    description=" not in doxie CRS: address-phone linking"/>
  <part name="IncludeAKAs" type="xsd:boolean" default="true"/>
  <part name="IncludeImposters" type="xsd:boolean" default="true"/>
        <part name="ReturnAllImposters" type="xsd:boolean" description=" returns all imposter records, even having different SSN (demo only)"/>
  <part name="IncludeAssociates" type="xsd:boolean" />
  <part name="IncludeRelatives"  type="xsd:boolean" />
        <part name="MaxRelatives" type="xsd:unsignedInt" indent="true" default="100"/>
        <part name="RelativeDepth" type="xsd:byte" indent="true" default="3"/> 
        <part name="IncludeRelativeAddresses" type="xsd:boolean" indent="true" />
        <part name="MaxRelativeAddresses" type="xsd:unsignedInt" indent="true" />
  <separator />
  <part name="IncludeNeighbors" type="xsd:boolean"/>
        <part name="NeighborhoodCount" type="xsd:unsignedInt" indent="true" default="0" size="4"/>
        <part name="NeighborsPerAddress" type="xsd:byte" indent="true" default="1" size="4"/>
        <part name="AddressesPerNeighbor" type="xsd:byte" indent="true" default="20" size="4"/>
        <part name="NeighborsPerNA" type="xsd:byte" indent="true" default="2" size="4" />
  <part name="IncludeHistoricalNeighbors" type="xsd:boolean" />
  <!-- those are seem not to be used anywhere -->
      <!--<part name="MaxHistoricalNeighborhoods" type="xsd:unsignedInt" indent="true" />-->
      <!--<part name="HistoricalNeighborsPerAddress" type="xsd:byte" indent="true" />-->
      <!--<part name="AddressesPerHistoricalNeighbor" type="xsd:byte" indent="true" />-->
      <part name="NeighborsPerNA" type="xsd:byte" indent="true" default="6" size="4" />
      <part name="NeighborRecency" type="xsd:byte" indent="true" default="3" size="4" />
  <separator />
  <part name="IncludeAccidents" type="xsd:boolean"/>
  <part name="IncludeBankruptcies" type="xsd:boolean" version="Bankruptcy" />
  <part name="IncludeCivilCourts" type="xsd:boolean" description=" not exposed in doxie"/>
  <part name="IncludeCorporateAffiliations" type="xsd:boolean"/>
  <part name="IncludeCriminalRecords" type="xsd:boolean" version="CriminalRecord" />
  <part name="IncludeDEARecords" type="xsd:boolean" version="Dea" />
  <part name="IncludeDriversAtAddress" type="xsd:boolean"/>
  <part name="IncludeDriversLicenses" type="xsd:boolean" version="Dl" />
  <part name="IncludeEmailAddresses" type="xsd:boolean"/>
  <part name="IncludeFAAAircrafts" type="xsd:boolean" default="true"/>
  <part name="IncludeFAACertificates"  type="xsd:boolean" default="true"/>phili
  <part name="IncludeFBN" type="xsd:boolean"/>
  <part name="IncludeFirearmsAndExplosives" type="xsd:boolean"/>
  <part name="IncludeForeclosures" type="xsd:boolean"/>
  <part name="IncludeHuntingFishingLicenses" type="xsd:boolean"/>
  <part name="IncludeInternetDomains" type="xsd:boolean"/>
  <part name="IncludeLiensJudgments" type="xsd:boolean" version="JudgmentLien"/>
  <part name="IncludeMotorVehicles" type="xsd:boolean" default="true"/>
  <part name="IncludeNoticeOfDefaults" type="xsd:boolean"/>
  <part name="IncludePatriot" type="xsd:boolean" description=" (aka &lt;Global Watch&gt;)"/>
  <part name="IncludePhonesPlus" type="xsd:boolean" />
  <part name="IncludeOldPhones" type="xsd:boolean"/>
  <part name="IncludePeopleAtWork" type="xsd:boolean" />
  <part name="IncludeProfessionalLicenses" type="xsd:boolean" />
  <part name="IncludeProperties" type="xsd:boolean" description=" (assessments &amp; deeds)" default="true"/>
  <part name="IncludeSexualOffenses" type="xsd:boolean"/>
  <part name="IncludeUCCFilings" type="xsd:boolean" default="true" version="UCC" />
  <part name="IncludeVoterRegistrations" type="xsd:boolean" version="Voter" />
  <part name="IncludeWatercrafts" type="xsd:boolean" default="true"/>
  <part name="IncludeWeaponPermits" type="xsd:boolean"/>
  <part name="IncludeCriminalIndicators" type="xsd:boolean"/>
  <separator />
  <part name="ExcludeSources" type="xsd:boolean" />
  <part name="IncludeHRI" type="xsd:boolean"/>
  <part name="MaxHriPer" type="xsd:unsignedInt"/>
  <part name="MaxAddresses" type="xsd:unsignedInt" default="1000" 
        description=" limits number of Comp_addresses; should it be exposed?"/>
  <part name="MaxAssociates" type="xsd:unsignedInt" default="10" description=" number of associates to return"/>
<!--
  <part name="IncludeVerification" type="xsd:boolean"/>
  <part name="IncludePhoneSummary" type="xsd:boolean"/>
-->
  <separator />
  <part name="SmartLinxReportRequest" type="tns:XmlDataSet" cols="80" rows="30" />
<!--
  <part name="PhonesPerAddress" type="xsd:byte"/>
  <part name="LawEnforcement" type="xsd:boolean"/>
  <part name="IncludeTimeline" type="xsd:boolean"/>
  <part name="ExcludeResidentsForAssociatesAddresses" type="xsd:boolean"/>         
  <part name="ProbationOverride" type="xsd:boolean"/>
  <part name="NoSmartRollup" type="xsd:boolean"/>
  <part name="IncludeKeyRiskIndicators" type="xsd:boolean"/>
  <part name="IncludeAMLProperty" type="xsd:boolean"/>
<part name="includeAddressSourceInfo" type="xsd:boolean"/>
  <part name="gateways" type="tns:XmlDataSet" cols="110" rows="10"/>
-->

<!--
  <part name="ENTRP_Month_Value" type="xsd:string"/>
  <part name="IndustryCLASS" type="xsd:string"/>
  <part name="UnParsedFullName" type="xsd:string"/>
  <part name="FirstName" type="xsd:string"/>
  <part name="AllowNickNames" type="xsd:boolean"/>
  <part name="LastName" type="xsd:string"/>
  <part name="PhoneticMatch" type="xsd:boolean"/>
  <part name="MiddleName" type="xsd:string"/>
  <part name="Addr" type="xsd:string"/>
  <part name="City" type="xsd:string"/>
  <part name="State" type="xsd:string"/>
  <part name="Zip" type="xsd:string"/>
  <part name="StateCityZip" type="xsd:string"/>
  <part name="Phone" type="xsd:string"/>
  <part name="DOB" type="xsd:unsignedInt"/>
  <part name="CompanyName" type="xsd:string"/>
  <part name="BusinessPhone" type="xsd:string"/>
  <part name="SSNMask" type="xsd:string"/>
  <part name="DLMask" type="xsd:string"/>
 -->

</message>
*/
/*--INFO-- 
<b>Note on options:</b> "SOAP" options will always override ESDL options
(this is an unfortuante consequence of not being able to choose modules conditionally, but it seems
to be relatively harmless anyway). <br /> 
*/

IMPORT iesp, doxie, AutoStandardI, Royalty;

EXPORT SmartLinxReportService () := MACRO
  #constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
  #onwarning(4207, ignore);

  //The following macro defines the field sequence on WsECL page of query.
  WSInput.MAC_PersonReports_SmartLinxReportService();


  #CONSTANT('TwoPartySearch', FALSE);
  #constant('SelectIndividually', true); // we will setup all components explicitly

  // those are defined in current CRS:
  #option ('maxCompileThreads', 4); //
  #stored('IncludeAllDIDRecords','1'); //
  #stored('ReportReq',true); //
  #stored('CriminalRecordVersion',2);
  #stored('deaversion',2);
  #stored('propertyversion',2);
  #stored('dlversion',2);
  #stored('voterversion',2);
  #stored('vehicleversion',2);
  #stored('judgmentlienversion',2);
  #stored('uccversion',2);
  #stored('bankruptcyversion',2);
  #stored('IncludeSanctions',true);  //temporary fix until FUNCTIONS #stores..
  #stored('IncludeProviders',true);
  #constant('useOnlyBestDID',true); //
  #stored('DataRestrictionMask','0000000000'); // //intentionally has diff default behavior than doxie_ln version
  #CONSTANT('GONG_SEARCHTYPE','PERSON'); //
  #constant('IncludeNonDMVSources', true); //
  #CONSTANT('IncludeNonRegulatedVehicleSources', true);
  #CONSTANT('IncludeNonRegulatedWatercraftSources', true);

  #CONSTANT('AML_XG5_GATEWAY','TRUE');

  #constant('IsCRS',true);
  #constant ('CurrentOnly', false); //TODO: check (property?)
  noSmartRollup := false : stored('NoSmartRollup');

// set to ensure address hierarchy always on.
 #CONSTANT('UseAddressHierarchy', true); 

  //
  // these are set for UCC report; not exposed in doxie CRS; in UCC report they are set to true
  //#constant('IncludeMultipleSecured', false);
  //#constant('ReturnRolledDebtors', false);

  // *** Input parameters handling ***
  // General idea is that we may want to support reading from "stored" for a quite long time.
  // Thus, even when reading from ESDL-input, parameters are #stored anyway, and then 
  // being read again -- this time from 'stored', creating a module containing required parameters.
  // I will create the same module directly from ESDL input anyway, so later 
  // we could bypass generally redundant in ESDL mode "save - read" processing.

  // parse ESDL input
  ds_in := DATASET ([], iesp.smartlinxreport.t_SmartlinxReportRequest) : STORED ('SmartLinxReportRequest', FEW);
  first_row := ds_in[1] : INDEPENDENT;

  s_gateway := dataset([],risk_indicators.Layout_Gateways_In)   : stored('gateways');

  // this will #store some standard input parameters (generally, for search purpose)
  iesp.ECL2ESP.SetInputBaseRequest (first_row);
  iesp.ECL2ESP.SetInputReportBy (first_row.ReportBy);

  // create module incorporating XML input options 
  options_in := PersonReports.functions.GetInputOptions (global (first_row.Options));

  // todo move prunedAgedSSNs to appropriate location

  #stored ('UsingKeepSSNs', first_row.options.PruneAgedSSNs);
  #stored ('KeepOldSsns', ~first_row.options.PruneAgedSSNs);
    // set up defaults: comp report options are the most detailed, so they can be used here
  options_esdl := module (project (options_in, PersonReports.IParam._compoptions, OPT))
    export boolean include_bpsaddress := TRUE;
    export unsigned1 max_relatives := 20; // changing this constant for max # of relatives to be returned
  end;

  // store XML options for subsequent legacy-style reading
  PersonReports.functions.SetInputSearchOptions (options_esdl);

  // Read from stored. 
  SR := PersonReports.StoredReader;
  options_stored := module (SR.relatives_options, SR.neighbors_options, SR.imposters_options, SR.email_options,
                            SR.global_options, SR.phones_options, SR.providers_options, SR.versions)
  end;

  // TODO: cannot choose module conditionally: if (exists (first_raw), options_esdl, options_stored);
  // to bypass global storage use "options_esdl"
  options := options_stored; 
  // options := options_esdl;  


  // get search parameters from global #stored variables;
  globals := AutoStandardI.GlobalModule();
  // parameters needed for search only (perhaps, there should be a separate function for reading them)
  search_mod := module (project (globals, PersonReports.IParam._didsearch, opt))
  end;

  // Now define all report parameters
  mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated(globals);
  report_mod := module (options, mod_access)
    // Do all required translations here
    export unsigned1 score_threshold := AutoStandardI.InterfaceTranslator.score_threshold_value.val (search_mod);
    export boolean include_hri := globals.IncludeHRI;
    export boolean legacy_verified := false : stored('LegacyVerified');
    export boolean include_BlankDOD := false : stored ('IncludeBlankDOD');
    export boolean include_deceased := true ; //need to fix PersonReports.SourceCounts_records doesn't work without it.
    export string9 _ssn := AutoStandardI.InterfaceTranslator.ssn_value.val(project(search_mod,AutoStandardI.InterfaceTranslator.ssn_value.params));
    export boolean smart_rollup := if (noSmartRollup, false, true);
    export boolean include_sources := true;
    export unsigned1 max_relatives := 100;
    export boolean use_bestaka_ra := false;
    export boolean use_bestaka_nb := false;
    export unsigned1 bankruptcy_version := 2;
    export STRING1 bk_party_type := iesp.Constants.SMART.DEBTOR;
    export unsigned1 crimrecords_version := 2;
    export unsigned1 dea_version := 2;
    export unsigned1 dl_version := 2;
    export unsigned1 liensjudgments_version := 2;
    export STRING1 liens_party_type := iesp.Constants.SMART.DEBTOR;
    export unsigned1 phonesplus_version := 2;
    export unsigned1 proflicense_version := 2;
    export unsigned1 property_version := 2;
    export unsigned1 ucc_version := 2;
    export unsigned1 vehicles_version := 2;
    export unsigned1 voters_version := 2;
    export boolean include_nonresidents_phones := false;
    export unsigned1 neighbors_per_na := 2;
    export boolean sort_deeds_by_ownership := true; //sets property ownership flag that is needed for determining Current/Prior
    //criminal defaults
    export boolean AllowGraphicDescription := false;
    export boolean Include_BestAddress := false;
    export boolean IncludeAllCriminalRecords := false;
    export boolean IncludeSexualOffenses := false;
    export boolean return_AllImposterRecords := true;
    export unsigned1 max_imposter_akas := 50;
    export boolean include_proflicenses := true;  //force proflic, providers and sanctions for now
    export boolean include_providers := true;
    export boolean include_sanctions := true;
    export boolean include_criminalindicators := false : stored ('IncludeCriminalIndicators');
    export boolean Include_NonRegulated_WatercraftSources := false : stored ('IncludeNonRegulatedWatercraftSources');
    export boolean include_AddressSourceInfo := false : stored('IncludeAddressSourceInfo');
    export boolean includeVendorSourceB := first_row.options.IncludeVendorSourceB;
    export boolean IncludeAssignmentsAndReleases := first_row.options.IncludeAssignmentsAndReleases;
    // new additions nov 2020
    export boolean IncludeProgressivePhone := first_row.options.ProgressivePhones.IncludeProgressivePhone;
    EXPORT unsigned1 MaxNumSubject  := first_row.options.ProgressivePhones.MaxNumSubject;
    EXPORT STRING ScoreModel := first_row.options.ProgressivePhones.ScoreModel;
     EXPORT BOOLEAN UsePremiumSourceA := first_row.options.ProgressivePhones.UsePremiumSourceA;
     EXPORT UNSIGNED1 PremiumSourceAlimit := first_row.options.ProgressivePhones.PremiumSourceAlimit;
     EXPORT BOOLEAN IncludePersonRiskIndicatorSection := first_row.options.IncludePersonRiskIndicatorSection;     
     EXPORT BOOLEAN DoAddrHierarchy := true : STORED('UseAddressHierarchy');
  end;


  // fetch DID (just one is expected)
  //  dids := AutoHeaderI.LIBCALL_FetchI_Hdr_Indv.do (search_mod);
  did_value := AutoStandardI.InterfaceTranslator.did_value.val(project(search_mod,AutoStandardI.InterfaceTranslator.did_value.params));
  dids := dataset ([(unsigned6) did_value], doxie.layout_references);



  Relationship.IParams.storeParams(first_row.Options.RelationshipOption);
  smartMod := Relationship.IParams.getParams(report_mod,PersonReports.IParam._smartlinxreport);
  recs := PersonReports.SmartLinxReport (dids, smartMod, FALSE);

  // wrap it into output structure
  iesp.smartlinxreport.t_SmartLinxReportResponse SetResponse (recs L) := transform
    Self._Header := iesp.ECL2ESP.GetHeaderRow ();
    Self.Messages := L.messages; 
    Self.Individual := L;
  end;
  results := PROJECT (recs, SetResponse (Left));
  // ROYALTIES
  Royalty.RoyaltyFares.MAC_SetD(recs.Foreclosures, royalties_fares);
  Royalty.MAC_RoyaltyEmail(recs.Emailaddresses, royalties_email, source);
  royaltiesEquifaxPhones := recs.EquifaxRoyalties;
  royalties := if (not mod_access.isConsumer(), royalties_fares) +
               if(report_mod.email_version=2,recs.EmailV2Royalties, royalties_email) +                             
               if (report_mod.IncludeProgressivePhone and report_mod.UsePremiumSourceA 
                      and ~doxie.compliance.isPhoneMartRestricted(report_mod.DataRestrictionMask)
                      and mod_access.isValidGLB(), royaltiesEquifaxPhones);                
  output (results, named ('Results'));
  output (royalties, named ('RoyaltySet'));


ENDMACRO;
