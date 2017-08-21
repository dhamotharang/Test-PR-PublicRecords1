IMPORT iesp,BairRx_Common;
EXPORT GetClassification(STRING inORI, integer inMode) := FUNCTION

	k := BairRx_Common.Keys.ClassificationKey();
	dRecs := LIMIT(k(KEYED(ori=inORI AND (inMode=0 OR inMode = mode))), BairRx_Common.Constants.MAX_JOIN_LIMIT);
	
	iesp.bair_classification.t_BAIRClassificationSearchRecord xtResults(dRecs L) := TRANSFORM
		SELF.ORI := L.ORI;
		SELF.Mode := (STRING)L.Mode;
		SELF.Classification := (STRING)L.ucr_group;
		SELF.ClassificationText := IF(L.Mode = 1, L.crime,L.agencytype);
		SELF.LastUpdated := L.Last_Update;
	end;
		
	dRecsOut := PROJECT(dRecs,xtresults(left));
	
	RETURN dRecsOut;
END;