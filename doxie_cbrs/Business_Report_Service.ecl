/*--SOAP--
<message name="BusinessReportService" wuTimeout="300000">
  <part name="INDUSTRYCLASS" type="xsd:string"/>
  <part name="BDID" type="xsd:string"/>
  <part name="BDL" type="xsd:string"/>
  <part name="CompanyName" type="xsd:string"/>
  <part name="AlternateCompanyName" type="xsd:string"/>
  <part name="Addr" type="xsd:string"/>
  <part name="City" type="xsd:string"/>
  <part name="State" type="xsd:string"/>
  <part name="Zip" type="xsd:string"/>
  <part name="BusinessPhone" type="xsd:string"/>
  <part name="TaxIdNumber" type="xsd:string"/>
  <part name="DPPAPurpose" type="xsd:byte"/>
  <part name="GLBPurpose" type="xsd:byte"/>
  <part name="Include_Bus_DPPA" type="xsd:boolean"/>
  <part name="DataRestrictionMask" type="xsd:string"/>
  <part name="DataPermissionMask" type="xsd:string"/>
  <part name="SSNMask" type="xsd:string"/>
  <part name="SelectIndividually" type="xsd:boolean"/>
  <part name="IncludeNameVariations" type="xsd:boolean"/>
  <part name="IncludeAddressVariations" type="xsd:boolean"/>
  <part name="IncludePhoneVariations" type="xsd:boolean"/>
  <part name="IncludeDunBradstreetRecords" type="xsd:boolean"/>
  <part name="IncludeExperianBusinessReports" type="xsd:boolean"/>
  <part name="IncludeIRS5500" type="xsd:boolean"/>
  <part name="IncludeDCA" type="xsd:boolean"/>
  <part name="IncludeSales" type="xsd:boolean"/>
  <part name="IncludeIndustryInformation" type="xsd:boolean"/>
  <part name="IncludeLiensJudgments" type="xsd:boolean"/>
  <part name="IncludeLiensJudgmentsV2" type="xsd:boolean"/>
  <part name="IncludeUCCFilings" type="xsd:boolean"/>
  <part name="IncludeUCCFilingsV2" type="xsd:boolean"/>
  <part name="IncludeAssociatedPeople" type="xsd:boolean"/>
  <part name="IncludeInternetDomains" type="xsd:boolean"/>
  <part name="IncludeBankruptcies" type="xsd:boolean"/>
  <part name="IncludeBankruptciesV2" type="xsd:boolean"/>
  <part name="IncludeBusinessRegistrations" type="xsd:boolean"/>
  <part name="IncludeProperties" type="xsd:boolean"/>
  <part name="IncludePropertiesV2" type="xsd:boolean"/>
  <part name="IncludeMotorVehicles" type="xsd:boolean"/>
  <part name="IncludeMotorVehiclesV2" type="xsd:boolean"/>
  <part name="IncludeWatercrafts" type="xsd:boolean"/>
  <part name="IncludeAircrafts" type="xsd:boolean"/>
  <part name="IncludeProfessionalLicenses" type="xsd:boolean"/>
  <part name="IncludeCompanyIDnumbers" type="xsd:boolean"/>
  <part name="IncludeCompanyIDnumbersV2" type="xsd:boolean"/>
  <part name="IncludeCompanyProfile" type="xsd:boolean"/>
  <part name="IncludeCompanyProfileV2" type="xsd:boolean"/>
  <part name="IncludeRegisteredAgents" type="xsd:boolean"/>
  <part name="IncludeExecutives" type="xsd:boolean"/>
  <part name="IncludeBusinessAssociates" type="xsd:boolean"/>
  <part name="IncludeNoticeOfDefaults" type="xsd:boolean"/>
  <part name="IncludeForeclosures" type="xsd:boolean"/>
  <part name="IncludeSourceCounts" type="xsd:boolean"/>
  <part name="IncludeSourceFlags" type="xsd:boolean"/>
  <part name="IncludeCompanyVerification" type="xsd:boolean"/>
  <part name="IncludePhoneSummary" type="xsd:boolean"/>
  <part name="IncludeSanctions" type="xsd:boolean"/>
  <part name="UccVersion" type="xsd:byte"/>
  <part name="JudgmentLienVersion" type="xsd:byte"/>
  <part name="BankruptcyVersion" type="xsd:byte"/>
  <part name="VehicleVersion" type="xsd:byte"/>
  <part name="PropertyVersion" type="xsd:byte"/>

  <part name="hashvals" type="tns:XmlDataSet" cols="70" rows="3"/>
  <part name="ReturnHashes" type="xsd:boolean"/>
  <part name="TrackNameChanges" type="xsd:boolean"/>
  <part name="TrackAddressChanges" type="xsd:boolean"/>
  <part name="TrackAssetChanges" type="xsd:boolean"/>
  <part name="TrackPropertyChanges" type="xsd:boolean"/>
  <part name="TrackBankruptcyChanges" type="xsd:boolean"/>
  <part name="TrackUCCChanges" type="xsd:boolean"/>
  <part name="TrackLiensChanges" type="xsd:boolean"/>
  <part name="TrackLicenseChanges" type="xsd:boolean"/>
  <part name="TrackCorpChanges" type="xsd:boolean"/>
</message>
*/
/*--INFO-- Dayton Smartlynx Business Report Replacement.*/

IMPORT AutoheaderV2, AutoStandardI, doxie, doxie_cbrs, Royalty, WSInput;

EXPORT Business_Report_Service() := MACRO
  #CONSTANT('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
    #ONWARNING(4207, ignore);
    //The following macro defines the field sequence on WsECL page of query.
    WSInput.MAC_Business_Report_Service();
    
    #OPTION ('globalAutoHoist', FALSE);
    #OPTION ('spotCSE', FALSE);
    STRING BDL := '' : STORED('BDL');
    #STORED('useSupergroup',(UNSIGNED)bdl = 0);
    #STORED('useLevels',TRUE);
    #STORED('isDayBR',TRUE);
    #STORED('IncludeMultipleSecured',TRUE);
    #STORED('ReturnRolledDebtors',TRUE);
    #CONSTANT('GONG_SEARCHTYPE','BUSINESS');
    #STORED('bdidsDerived', TRUE);
    #CONSTANT('usePropMarshall',TRUE);
    #CONSTANT('isCRS',TRUE);

    mod_access := Doxie.compliance.GetGlobalDataAccessModuleTranslated(AutoStandardI.GlobalModule());

    // Have to add these here instead of just calling doxie_cbrs.mac_Selection_Declare()
    // because of a nasty dependency:
    // doxie_cbrs.mac_Selection_Declare->business_header.doxie_MAC_Field_Declare->doxie.MAC_Header_Field_Declare()
    BOOLEAN _Select_Indiv := FALSE : STORED('SelectIndividually');
    BOOLEAN _Always_Compute := FALSE : STORED('AlwaysCompute');
    BOOLEAN _Include_DunBradstreetRecords := FALSE : STORED('IncludeDunBradstreetRecords');
    BOOLEAN _Include_Properties := FALSE : STORED('IncludeProperties');
    _Include_Them_All := NOT _Select_Indiv;
    _Include_DunBradstreetRecords_val := _Include_Them_All OR _Include_DunBradstreetRecords OR _Always_Compute;
    _Include_Properties_val := _Include_Them_All OR _Include_Properties OR _Always_Compute;

    base_records_prs :=doxie_cbrs.all_base_records_prs(doxie_cbrs.getBizReportBDIDs(mod_access).bdids, mod_access);

    doxie_crs.layout_property_ln property_child(doxie_cbrs.layout_property_records l):= TRANSFORM
      SELF := l;
    END;

    property_table := NORMALIZE(base_records_prs, LEFT.property,property_child(RIGHT));
    Royalty.RoyaltyFares.MAC_SetB(property_table, property_royalties);

    dnb_table := NORMALIZE(base_records_prs, LEFT.dnb,TRANSFORM(RIGHT));
    dnb_royalties := Royalty.RoyaltyDNB.GetOnlineRoyalties(dnb_table);

    royalties := IF(_Include_Properties_val, property_royalties) +
      IF(_Include_DunBradstreetRecords_val, dnb_royalties);

    alerters := doxie_cbrs.alert_hashes(PROJECT(base_records_prs,doxie_cbrs.layout_report));
    changedSections := alerters.changed_sections;
    outputHashes := alerters.output_hashes;
    hashmap := alerters.hashmap;
    sendResults := alerters.sendResults;
    sendHashes := alerters.sendHashes;

    use_records := IF(sendHashes, changedSections, base_records_prs);

    DO_ALL := PARALLEL(
      IF(sendResults,OUTPUT(use_records, NAMED('DayBR'))),
      IF(sendResults,OUTPUT(royalties,NAMED('RoyaltySet'))),
      IF(sendHashes,OUTPUT(outputHashes,NAMED('Hashes'))),
      IF(sendHashes,OUTPUT(hashmap,NAMED('Hashmap'))));

    IF(EXISTS(doxie_cbrs.getBizReportBDIDs(mod_access).bdids), DO_ALL, OUTPUT(doxie.ErrorCodes (10),NAMED('Results')));
ENDMACRO;
