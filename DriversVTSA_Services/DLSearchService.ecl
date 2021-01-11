// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================
/*--INFO-- Lookup DL Records via simple keys and autokeys, then display in narrow_view. */
IMPORT doxie, text_search, WSInput;

EXPORT DLSearchService() := MACRO

	//The following macro defines the field sequence on WsECL page of query.
	WSInput.MAC_DriversVTSA_Services_DLSearchService();
	#constant('NoDeepDive',true);

	// compute results
  raw := DriversvTSA_Services.DLSearchService_records;
	Text_Search.MAC_Append_ExternalKey(raw, raw2, INTFORMAT(l.dl_seq,15,1));

  doxie.MAC_Header_Field_Declare()
	doxie.MAC_Marshall_Results(raw2,cooked)

	// display results (if permitted)
	map(
		~dppa_ok
		=> fail(2, doxie.ErrorCodes(2)),

		output(cooked, NAMED('Results'))
	)

ENDMACRO;
