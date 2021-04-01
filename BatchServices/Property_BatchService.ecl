// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================

IMPORT AutoheaderV2, BatchServices, BIPV2, Royalty, LN_PropertyV2_Services, ut, STD;

EXPORT Property_BatchService(useCannedRecs = 'false') :=
  MACRO
    #CONSTANT('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
    #CONSTANT('TwoPartySearch', FALSE);

    STRING1 BIPFetchLevel := BIPV2.IDconstants.Fetch_Level_SELEID   : STORED('BIPFetchLevel');
    boolean includeAssignmentsAndReleases := false : STORED ('IncludeAssignmentsAndReleases');

      //non-subject suppression
    nss := ut.getNonSubjectSuppression (Suppress.Constants.NonSubjectSuppression.doNothing);
    ds_in  := DATASET([], LN_PropertyV2_Services.layouts.batch_in_plus_date_filter) : STORED('batch_in', FEW);
    result := BatchServices.Property_BatchCommon(false, nss, useCannedRecs,ds_in,STD.Str.touppercase(BIPFetchLevel), includeAssignmentsAndReleases);
    returnDetailedRoyalties := false : stored('ReturnDetailedRoyalties');
    royalties := Royalty.RoyaltyFares.GetBatchRoyaltySet(result.Records,,returnDetailedRoyalties);

    OUTPUT(result.Records, NAMED('Results'));
    OUTPUT(royalties, NAMED('RoyaltySet'));

  ENDMACRO;
