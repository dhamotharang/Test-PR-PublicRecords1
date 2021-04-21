// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================
IMPORT BatchServices, Royalty, ut, AutoheaderV2, Suppress;

EXPORT Accurint_Property_BatchService(useCannedRecs = 'false') :=
  MACRO
    #CONSTANT('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
    #CONSTANT('TwoPartySearch', FALSE);

      //non-subject suppression
    nss := ut.getNonSubjectSuppression (Suppress.Constants.NonSubjectSuppression.doNothing);

    result := BatchServices.Accurint_Property_BatchCommon(false, nss, useCannedRecs).Records;
    returnDetailedRoyalties := false : stored('ReturnDetailedRoyalties');
    royalties := Royalty.RoyaltyFares.GetBatchRoyaltySet(result, fares_source_id, returnDetailedRoyalties);

    OUTPUT(result, NAMED('Results'));
    OUTPUT(royalties, NAMED('RoyaltySet'));

  ENDMACRO;
