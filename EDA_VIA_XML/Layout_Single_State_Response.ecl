export Layout_Single_State_Response := RECORD, MAXLENGTH(500 * eda_via_xml.max_rowsRequested)
  UNSIGNED4 stateListCount;
	UNSIGNED4 totalListingsFound;
	UNSIGNED4 totalListingsReturned;
	DATASET(EDA_VIA_XML.Layout_Listing) listings {maxcount(eda_via_xml.max_rowsRequested)};
END;