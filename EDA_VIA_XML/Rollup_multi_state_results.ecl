export Rollup_multi_state_results(DATASET(EDA_VIA_XML.Layout_State) multi_state_v) := FUNCTION

EDA_VIA_XML.Layout_Multi_State_Response toFinalLayout(EDA_VIA_XML.Layout_State l) := TRANSFORM
  SELF.stateListCount := COUNT(multi_state_v);
	SELF.totalListingsFound := l.listingsFound;
	SELF.totalListingsReturned := 0;
	SELF.stateList := dataset([l], EDA_VIA_XML.Layout_State);
END;

EDA_VIA_XML.Layout_Multi_State_Response rollResults(EDA_VIA_XML.Layout_Multi_State_Response l, EDA_VIA_XML.Layout_Multi_State_Response r) := TRANSFORM
	SELF.stateListCount := l.stateListCount;
	SELF.totalListingsFound := l.totalListingsFound + r.totalListingsFound;
	SELF.totalListingsReturned := 0;
	SELF.stateList := l.stateList + r.stateList;
END;

return ROLLUP(PROJECT(multi_state_v, toFinalLayout(LEFT)), true, rollResults(LEFT, RIGHT));

END;