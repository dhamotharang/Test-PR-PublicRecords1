// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================
IMPORT doxie, Text_Search;

EXPORT BankruptcySearchService() := MACRO
  #CONSTANT ('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
  //The following macro defines the field sequence on WsECL page of query.
  WSInput.MAC_BankruptcyV2_Services_SearchService();

  doxie.MAC_Selection_Declare()
  doxie.MAC_Header_Field_Declare()

  UNSIGNED ChapterChoice := 0 : STORED('ChapterChoice');
  BOOLEAN BusinessOnly := FALSE : STORED('BusinessOnly');

  #CONSTANT('SearchIgnoresAddressOnly',TRUE);
  #STORED('ScoreThreshold',10);
  #STORED('PenaltThreshold',10);
  #CONSTANT('DisplayMatchedParty',TRUE);
  #CONSTANT('isFCRA', FALSE);

  recs := bankruptcyv2_Services.bankruptcy_raw().search_view(
    in_ssn_mask := ssn_mask_value,
    in_party_type := Party_Type,
    in_filing_jurisdiction := FilingJurisdiction_value,
    in_includeCriminalIndicators := IncludeCriminalIndicators
  );


    // If needed filter out chapters
  bankrecs_chp := MAP(
    ChapterChoice = 1 => recs(Chapter = '11'),
    ChapterChoice = 2 => recs(Chapter = '7'),
    ChapterChoice = 3 => recs(Chapter IN ['11','7']),
    ChapterChoice NOT IN [1,2,3] AND BusinessOnly => recs(Chapter IN ['11','7']),
    recs);

  // Classify the Bankruptcy record
  bankrecs_classified := BLJ_V2_Services.fnSupressPeople(bankrecs_chp);
  bankrecs_unclassified := PROJECT(bankrecs_chp,
    TRANSFORM(RECORDOF(bankrecs_classified),
      SELF.BKRecordType := 3, // no classification
      SELF := LEFT));

  bankrecs_final := IF(BusinessOnly,bankrecs_classified(BKRecordType <> 0),bankrecs_unclassified);

  orec := RECORD
    RECORDOF(recs);
    Text_Search.Layout_ExternalKey;
    // added
    BOOLEAN DebtorsSuppressed;
  END;

  orec addExt(bankrecs_final l) := TRANSFORM
    SELF.ExternalKey := l.TMSID;
    SELF.DebtorsSuppressed := l.BKRecordType = 2; // added
    SELF := l;
  END;

  recs2 := PROJECT(bankrecs_final, addext(LEFT));

  doxie.MAC_Marshall_Results(recs2, recs_marshalled);
        //output(recs, named('recs'));
  OUTPUT(recs_marshalled, NAMED('Results'));
ENDMACRO;
