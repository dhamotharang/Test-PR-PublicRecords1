// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================
/*--INFO-- Lookup DL Records via simple keys and autokeys, then display in narrow_view. */
IMPORT doxie, text_search, WSInput;

EXPORT DLSearchService() := MACRO
  #CONSTANT('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
  //The following macro defines the field sequence on WsECL page of query.
  WSInput.MAC_DLSearchService();

  // compute results
  raw := Driversv2_Services.DLSearchService_records(TRUE);
  Text_Search.MAC_Append_ExternalKey(raw, raw2, INTFORMAT(l.dl_seq,15,1));

  // picking random results is one of the rare occasions when non-determinism is OK
  raw3 := DEDUP(raw2, dl_number, ALL); // disallow multiple recs from the same individual
  ut.MAC_Pick_Random(raw3,rand,DriversV2_Services.input.maxResults);

  seasoned := IF(DriversV2_Services.input.randomize, rand, raw2);

  doxie.MAC_Header_Field_Declare()
  doxie.MAC_Marshall_Results(seasoned,cooked)

  // display results (if permitted)
  MAP(
    ~dppa_ok
    => FAIL(2, doxie.ErrorCodes(2)),

    OUTPUT(cooked, NAMED('Results'))
  )

ENDMACRO;
