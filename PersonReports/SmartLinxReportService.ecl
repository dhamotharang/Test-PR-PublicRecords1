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

/*--HELP-- 
<pre>
&lt;SmartlinxReportRequest&gt;
  &lt;Row&gt;
    &lt;User&gt;
      &lt;ReferenceCode&gt;&lt;/ReferenceCode&gt;
      &lt;BillingCode&gt;&lt;/BillingCode&gt;
      &lt;QueryId&gt;&lt;/QueryId&gt;
      &lt;CompanyId&gt;&lt;/CompanyId&gt;
      &lt;GLBPurpose&gt;&lt;/GLBPurpose&gt;
      &lt;DLPurpose&gt;&lt;/DLPurpose&gt;
      &lt;LoginHistoryId&gt;&lt;/LoginHistoryId&gt;
      &lt;DebitUnits&gt;&lt;/DebitUnits&gt;
      &lt;IP&gt;&lt;/IP&gt;
      &lt;IndustryClass&gt;&lt;/IndustryClass&gt;
      &lt;ResultFormat&gt;&lt;/ResultFormat&gt;
      &lt;LogAsFunction&gt;&lt;/LogAsFunction&gt;
      &lt;SSNMask&gt;&lt;/SSNMask&gt;
      &lt;DOBMask&gt;&lt;/DOBMask&gt;
      &lt;DLMask&gt;&lt;/DLMask&gt;
      &lt;DataRestrictionMask&gt;&lt;/DataRestrictionMask&gt;
      &lt;DataPermissionMask&gt;&lt;/DataPermissionMask&gt;
      &lt;ApplicationType&gt;&lt;/ApplicationType&gt;
      &lt;SSNMaskingOn&gt;&lt;/SSNMaskingOn&gt;
      &lt;DLMaskingOn&gt;&lt;/DLMaskingOn&gt;
      &lt;EndUser&gt;
        &lt;CompanyName&gt;&lt;/CompanyName&gt;
        &lt;StreetAddress1&gt;&lt;/StreetAddress1&gt;
        &lt;City&gt;&lt;/City&gt;
        &lt;State&gt;&lt;/State&gt;
        &lt;Zip5&gt;&lt;/Zip5&gt;
      &lt;/EndUser&gt;
      &lt;MaxWaitSeconds&gt;&lt;/MaxWaitSeconds&gt;
      &lt;RelatedTransactionId&gt;&lt;/RelatedTransactionId&gt;
      &lt;AccountNumber&gt;&lt;/AccountNumber&gt;
      &lt;TestDataEnabled&gt;&lt;/TestDataEnabled&gt;
      &lt;TestDataTableName&gt;&lt;/TestDataTableName&gt;
    &lt;/User&gt;
    &lt;RemoteLocations&gt;
      &lt;Item/&gt;
    &lt;/RemoteLocations&gt;
    &lt;ServiceLocations&gt;
      &lt;ServiceLocation&gt;
        &lt;LocationId&gt;&lt;/LocationId&gt;
        &lt;ServiceName&gt;&lt;/ServiceName&gt;
        &lt;Parameters&gt;
          &lt;Parameter&gt;
            &lt;Name&gt;&lt;/Name&gt;
            &lt;Value&gt;&lt;/Value&gt;
          &lt;/Parameter&gt;
        &lt;/Parameters&gt;
      &lt;/ServiceLocation&gt;
    &lt;/ServiceLocations&gt;
    &lt;Options&gt;
      &lt;Blind&gt;&lt;/Blind&gt;
      &lt;Encrypt&gt;&lt;/Encrypt&gt;
      &lt;ReturnTokens&gt;&lt;/ReturnTokens&gt;
      &lt;IncludeAKAs&gt;&lt;/IncludeAKAs&gt;
      &lt;IncludeImposters&gt;&lt;/IncludeImposters&gt;
      &lt;IncludeOldPhones&gt;&lt;/IncludeOldPhones&gt;
      &lt;IncludeAssociates&gt;&lt;/IncludeAssociates&gt;
      &lt;IncludeProperties&gt;&lt;/IncludeProperties&gt;
      &lt;IncludePriorProperties&gt;&lt;/IncludePriorProperties&gt;
      &lt;IncludeCurrentProperties&gt;&lt;/IncludeCurrentProperties&gt;
      &lt;IncludeDriversLicenses&gt;&lt;/IncludeDriversLicenses&gt;
      &lt;IncludeMotorVehicles&gt;&lt;/IncludeMotorVehicles&gt;
      &lt;IncludeBankruptcies&gt;&lt;/IncludeBankruptcies&gt;
      &lt;IncludeLiensJudgments&gt;&lt;/IncludeLiensJudgments&gt;
      &lt;IncludeCorporateAffiliations&gt;&lt;/IncludeCorporateAffiliations&gt;
      &lt;IncludeMerchantVessels&gt;&lt;/IncludeMerchantVessels&gt;
      &lt;IncludeUCCFilings&gt;&lt;/IncludeUCCFilings&gt;
      &lt;IncludeInternetDomains&gt;&lt;/IncludeInternetDomains&gt;
      &lt;IncludeFAACertificates&gt;&lt;/IncludeFAACertificates&gt;
      &lt;IncludeCriminalRecords&gt;&lt;/IncludeCriminalRecords&gt;
      &lt;IncludeCensusData&gt;&lt;/IncludeCensusData&gt;
      &lt;IncludeAccidents&gt;&lt;/IncludeAccidents&gt;
      &lt;IncludeWaterCrafts&gt;&lt;/IncludeWaterCrafts&gt;
      &lt;IncludeProfessionalLicenses&gt;&lt;/IncludeProfessionalLicenses&gt;
      &lt;IncludeHealthCareSanctions&gt;&lt;/IncludeHealthCareSanctions&gt;
      &lt;IncludeDEAControlledSubstance&gt;&lt;/IncludeDEAControlledSubstance&gt;
      &lt;IncludeVoterRegistrations&gt;&lt;/IncludeVoterRegistrations&gt;
      &lt;IncludeHuntingFishingLicenses&gt;&lt;/IncludeHuntingFishingLicenses&gt;
      &lt;IncludeFirearmExplosives&gt;&lt;/IncludeFirearmExplosives&gt;
      &lt;IncludeWeaponPermits&gt;&lt;/IncludeWeaponPermits&gt;
      &lt;IncludeCriminalIndicators&gt;&lt;/IncludeCriminalIndicators&gt;
      &lt;IncludeSexualOffenses&gt;&lt;/IncludeSexualOffenses&gt;
      &lt;IncludeCivilCourts&gt;&lt;/IncludeCivilCourts&gt;
      &lt;IncludeFAAAircrafts&gt;&lt;/IncludeFAAAircrafts&gt;
      &lt;IncludePeopleAtWork&gt;&lt;/IncludePeopleAtWork&gt;
      &lt;IncludeHighRiskIndicators&gt;&lt;/IncludeHighRiskIndicators&gt;
      &lt;IncludeForeclosures&gt;&lt;/IncludeForeclosures&gt;
      &lt;IncludePhonesPlus&gt;&lt;/IncludePhonesPlus&gt;
      &lt;DoPhoneReport&gt;&lt;/DoPhoneReport&gt;
      &lt;IncludeMatrixCriminalHistory&gt;&lt;/IncludeMatrixCriminalHistory&gt;
      &lt;Relatives&gt;
        &lt;IncludeRelatives&gt;&lt;/IncludeRelatives&gt;
        &lt;MaxRelatives&gt;&lt;/MaxRelatives&gt;
        &lt;RelativeDepth&gt;&lt;/RelativeDepth&gt;
        &lt;IncludeRelativeAddresses&gt;&lt;/IncludeRelativeAddresses&gt;
        &lt;MaxRelativeAddresses&gt;&lt;/MaxRelativeAddresses&gt;
      &lt;/Relatives&gt;
      &lt;Neighbors&gt;
        &lt;IncludeNeighbors&gt;&lt;/IncludeNeighbors&gt;
        &lt;IncludeHistoricalNeighbors&gt;&lt;/IncludeHistoricalNeighbors&gt;
        &lt;NeighborhoodCount&gt;&lt;/NeighborhoodCount&gt;
        &lt;NeighborCount&gt;&lt;/NeighborCount&gt;
        &lt;HistoricalNeighborhoodCount&gt;&lt;/HistoricalNeighborhoodCount&gt;
        &lt;HistoricalNeighborCount&gt;&lt;/HistoricalNeighborCount&gt;
      &lt;/Neighbors&gt;
      &lt;LawEnforcement&gt;&lt;/LawEnforcement&gt;
      &lt;PruneAgedSSNs&gt;&lt;/PruneAgedSSNs&gt;
      &lt;MaxAddresses&gt;&lt;/MaxAddresses&gt;
      &lt;MaxSubjectAddresses&gt;&lt;/MaxSubjectAddresses&gt;
      &lt;LegacyVerified&gt;&lt;/LegacyVerified&gt;
      &lt;IncludeSourceDocs&gt;&lt;/IncludeSourceDocs&gt;
      &lt;IncludeBestInfo&gt;&lt;/IncludeBestInfo&gt;
      &lt;IncludePhonesFeedback&gt;&lt;/IncludePhonesFeedback&gt;
      &lt;IncludeDriversAtAddress&gt;&lt;/IncludeDriversAtAddress&gt;
      &lt;IncludeGlobalWatchLists&gt;&lt;/IncludeGlobalWatchLists&gt;
      &lt;IncludeRealTimeVehicles&gt;&lt;/IncludeRealTimeVehicles&gt;
      &lt;RealTimePermissibleUse&gt;&lt;/RealTimePermissibleUse&gt;
      &lt;IncludeFictitiousBusinesses&gt;&lt;/IncludeFictitiousBusinesses&gt;
      &lt;IncludeNoticeOfDefaults&gt;&lt;/IncludeNoticeOfDefaults&gt;
      &lt;IncludeGSAVerification&gt;&lt;/IncludeGSAVerification&gt;
      &lt;DateRange&gt;&lt;/DateRange&gt;
      &lt;EnableNationalAccidents&gt;&lt;/EnableNationalAccidents&gt;
      &lt;AcceptedNonSolicitationTerms&gt;&lt;/AcceptedNonSolicitationTerms&gt;
      &lt;IncludeEmailAddresses&gt;&lt;/IncludeEmailAddresses&gt;
      &lt;IncludeHealthCareProviders&gt;&lt;/IncludeHealthCareProviders&gt;
      &lt;HealthCareProviders&gt;
        &lt;IncludeHealthCareProviders&gt;&lt;/IncludeHealthCareProviders&gt;
        &lt;IncludeGroupAffiliations&gt;&lt;/IncludeGroupAffiliations&gt;
        &lt;IncludeHospitalAffiliations&gt;&lt;/IncludeHospitalAffiliations&gt;
        &lt;IncludeEducation&gt;&lt;/IncludeEducation&gt;
        &lt;IncludeBusinessAddress&gt;&lt;/IncludeBusinessAddress&gt;
      &lt;/HealthCareProviders&gt;
      &lt;IncludeVerification&gt;&lt;/IncludeVerification&gt;
      &lt;IncludePhoneSummary&gt;&lt;/IncludePhoneSummary&gt;
      &lt;IncludeStudentInformation&gt;&lt;/IncludeStudentInformation&gt;
    &lt;/Options&gt;
    &lt;ReportBy&gt;
      &lt;Name&gt;
        &lt;Full&gt;&lt;/Full&gt;
        &lt;First&gt;&lt;/First&gt;
        &lt;Middle&gt;&lt;/Middle&gt;
        &lt;Last&gt;&lt;/Last&gt;
        &lt;Suffix&gt;&lt;/Suffix&gt;
        &lt;Prefix&gt;&lt;/Prefix&gt;
      &lt;/Name&gt;
      &lt;Address&gt;
        &lt;StreetNumber&gt;&lt;/StreetNumber&gt;
        &lt;StreetPreDirection&gt;&lt;/StreetPreDirection&gt;
        &lt;StreetName&gt;&lt;/StreetName&gt;
        &lt;StreetSuffix&gt;&lt;/StreetSuffix&gt;
        &lt;StreetPostDirection&gt;&lt;/StreetPostDirection&gt;
        &lt;UnitDesignation&gt;&lt;/UnitDesignation&gt;
        &lt;UnitNumber&gt;&lt;/UnitNumber&gt;
        &lt;StreetAddress1&gt;&lt;/StreetAddress1&gt;
        &lt;StreetAddress2&gt;&lt;/StreetAddress2&gt;
        &lt;City&gt;&lt;/City&gt;
        &lt;State&gt;&lt;/State&gt;
        &lt;Zip5&gt;&lt;/Zip5&gt;
        &lt;Zip4&gt;&lt;/Zip4&gt;
        &lt;County&gt;&lt;/County&gt;
        &lt;PostalCode&gt;&lt;/PostalCode&gt;
        &lt;StateCityZip&gt;&lt;/StateCityZip&gt;
      &lt;/Address&gt;
      &lt;SSN&gt;&lt;/SSN&gt;
      &lt;SSNLast4&gt;&lt;/SSNLast4&gt;
      &lt;SSNFirst5&gt;&lt;/SSNFirst5&gt;
      &lt;UniqueId&gt;&lt;/UniqueId&gt;
      &lt;DOB&gt;
        &lt;Year&gt;&lt;/Year&gt;
        &lt;Month&gt;&lt;/Month&gt;
        &lt;Day&gt;&lt;/Day&gt;
      &lt;/DOB&gt;
      &lt;Phone10&gt;&lt;/Phone10&gt;
      &lt;CompanyName&gt;&lt;/CompanyName&gt;
      &lt;BusinessPhone&gt;&lt;/BusinessPhone&gt;
    &lt;/ReportBy&gt;
  &lt;/Row&gt;
&lt;/SmartlinxReportRequest&gt;
</pre>
*/
/*--USES-- ut.input_xslt */

IMPORT iesp, doxie, AutoStandardI, Royalty;

EXPORT SmartLinxReportService () := MACRO
  #constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.LEGACY);
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
	
	s_gateway := dataset([],risk_indicators.Layout_Gateways_In) 	: stored('gateways');
	
  // this will #store some standard input parameters (generally, for search purpose)
  iesp.ECL2ESP.SetInputBaseRequest (first_row);
  iesp.ECL2ESP.SetInputReportBy (first_row.ReportBy);

  // create module incorporating XML input options 
  options_in := PersonReports.functions.GetInputOptions (global (first_row.Options));
	
	// todo move prunedAgedSSNs to appropriate location
  #stored ('UsingKeepSSNs', first_row.options.PruneAgedSSNs);
  #stored ('KeepOldSsns', ~first_row.options.PruneAgedSSNs);
	  // set up defaults: comp report options are the most detailed, so they can be used here
  options_esdl := module (project (options_in, PersonReports.input._compreport, opt))
  end;

  // store XML options for subsequent legacy-style reading
  PersonReports.functions.SetInputSearchOptions (options_esdl);

  // Read from stored. 
  SR := PersonReports.StoredReader;
  options_stored := module (SR.relatives_options, SR.neighbors_options, SR.imposters_options,
                            SR.global_options, SR.phones_options, SR.providers_options, SR.versions)
  end;

  // TODO: cannot choose module conditionally: if (exists (first_raw), options_esdl, options_stored);
  // to bypass global storage use "options_esdl"
  options := options_stored; 
  // options := options_esdl;  


  // get search parameters from global #stored variables;
  globals := AutoStandardI.GlobalModule(); //PersonReports.input.include
  // parameters needed for search only (perhaps, there should be a separate function for reading them)
  search_mod := module (project (globals, PersonReports.input._didsearch, opt))
  end;

  // Now define all report parameters
  report_mod := module (options)
    // Do all required translations here
    export unsigned1 GLBPurpose := AutoStandardI.InterfaceTranslator.glb_purpose.val (search_mod);
    export unsigned1 DPPAPurpose := AutoStandardI.InterfaceTranslator.dppa_purpose.val (search_mod);
		export string5 IndustryClass := AutoStandardI.InterfaceTranslator.industry_class_value.val (search_mod);
		export string DataPermissionMask := globals.dataPermissionMask;
    export string DataRestrictionMask := globals.dataRestrictionMask;
    export boolean ln_branded := AutoStandardI.InterfaceTranslator.ln_branded_value.val (search_mod);
    export string6 ssn_mask := 'NONE' : stored('SSNMask'); // ideally, must be "translated" ssnmask
    //export string6 ssn_mask := AutoStandardI.InterfaceTranslator.ssn_mask_val.val (search_mod);
    export unsigned1 score_threshold := AutoStandardI.InterfaceTranslator.score_threshold_value.val (search_mod);
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
  end;


  // fetch DID (just one is expected)
  //  dids := AutoHeaderI.LIBCALL_FetchI_Hdr_Indv.do (search_mod);
  did_value := AutoStandardI.InterfaceTranslator.did_value.val(project(search_mod,AutoStandardI.InterfaceTranslator.did_value.params));
  dids := dataset ([(unsigned6) did_value], doxie.layout_references);

	// main records

	Relationship.IParams.storeParams(first_row.Options.RelationshipOption);
	smartMod := Relationship.IParams.getParams(report_mod,PersonReports.input._smartlinxreport);
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
 	royalties := if (not ut.IndustryClass.is_knowx, royalties_fares) + royalties_email;

	output (results, named ('Results'));
  output (royalties, named ('RoyaltySet'));

/*
  // debug
  print_mod := module (project (report_mod, PersonReports.input._compoptions, opt))
  end;
  res := PersonReports.functions.GetCRSOptionsDataset (print_mod);
  output (res, named ('Options'));
*/
  // res := PersonReports.SourceCounts_records (dids, project (report_mod, PersonReports.input._sources, opt), IsFCRA);
  // output (res);
// return 0;
// end;
ENDMACRO;
//SmartLinxReportService ();
/*
<SmartLinxReportRequest>
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
  <IncludeAKAs>true</IncludeAKAs>
  <IncludeBpsAddress>true</IncludeBpsAddress>
  <IncludeEmailAddresses>true</IncludeEmailAddresses>
  <IncludeSourceDocs>true</IncludeSourceDocs>
  <IncludeBestInfo>true</IncludeBestInfo>
</Options>
<ReportBy>
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
</SmartLinxReportRequest>
*/

// BpsDenormalizer::doIndividual