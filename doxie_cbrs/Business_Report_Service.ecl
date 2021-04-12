// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================
/*--INFO--
    Dayton Smartlynx Business Report Replacement.
*/

IMPORT AutoheaderV2, AutoStandardI, doxie, doxie_cbrs, Royalty, WSInput;

EXPORT Business_Report_Service() := MACRO
  #CONSTANT('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
  #CONSTANT('TwoPartySearch', FALSE);

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
