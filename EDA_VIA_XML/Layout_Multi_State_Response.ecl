export Layout_Multi_State_Response := RECORD
  UNSIGNED4 stateListCount;
	UNSIGNED4 totalListingsFound;
	UNSIGNED4 totalListingsReturned;
	DATASET(EDA_VIA_XML.Layout_State) stateList;
END;