// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================
IMPORT doxie, text_search, WSInput;

EXPORT BankruptcySearchService(
  ) :=
    MACRO
  #CONSTANT ('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
    //The following macro defines the field sequence on WsECL page of query.
    WSInput.MAC_BankruptcyV3_Services_BankruptcySearchService();

    doxie.MAC_Header_Field_Declare();
    #CONSTANT('SearchIgnoresAddressOnly',TRUE);
    #STORED('ScoreThreshold',10);
    #STORED('PenaltThreshold',10);
    #CONSTANT('DisplayMatchedParty',TRUE);

    recs := bankruptcyv3_Services.bankruptcy_raw().search_view(in_ssn_mask := ssn_mask_value,
                                                             in_party_type := Party_Type,
                                                             in_filing_jurisdiction := FilingJurisdiction_value);

    orec := RECORD
      RECORDOF(recs);
      Text_Search.Layout_ExternalKey;
    END;
    orec addExt ( recs l) := TRANSFORM
      SELF := l;
      SELF.ExternalKey := l.TMSID;
    END;
    recs2 := PROJECT(recs, addext(LEFT));

    doxie.MAC_Marshall_Results(recs2, recs_marshalled);

    OUTPUT(recs_marshalled, NAMED('Results'));
    ENDMACRO;
