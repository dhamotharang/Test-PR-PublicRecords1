IMPORT iesp,BairRx_Common;
EXPORT GetImages(DATASET(iesp.share.t_StringArrayItem) EIDs) := FUNCTION
		
	dIDs := CHOOSEN(DEDUP(SORT(EIDs, RECORD)), 5000);		
	dFPDeltaFetch := JOIN(dIDs, BairRx_Common.Keys.ImageKey(TRUE).IDX, KEYED(left.value = right.eid), TRANSFORM(RIGHT));	
	dIDSmain 		:= JOIN(dIDS, dFPDeltaFetch, LEFT.value = RIGHT.eid, TRANSFORM(iesp.share.t_StringArrayItem,SELF := LEFT),LEFT ONLY);
	dFPmainFetch := JOIN(dIDSmain, BairRx_Common.Keys.ImageKey(FALSE).IDX, KEYED(left.value = right.eid), TRANSFORM(RIGHT));	
	
	dFPDeltaRecs := BairRx_Common.FetchLimit(dFPDeltaFetch, 5000);
	dFPmainRecs := BairRx_Common.FetchLimit(dFPmainFetch, 5000);
	
	
	dRecsDelta := FETCH(BairRx_Common.Keys.ImageKey(TRUE).FILE, dFPDeltaRecs, RIGHT.__filepos, 
		TRANSFORM(iesp.bair_image.t_BAIRImageRecord,
			SELF.EntityID := RIGHT.EID,
			SELF.ImageType := RIGHT.image_type, // 1 - LPRPLATE, 2 - LPROVERVIEW, 3 - OFFENDER, 4 - PERSON
			SELF.Image := LEFT.photo));
			
	dRecsMain := FETCH(BairRx_Common.Keys.ImageKey(FALSE).FILE, dFPmainRecs, RIGHT.__filepos, 
		TRANSFORM(iesp.bair_image.t_BAIRImageRecord,
			SELF.EntityID := RIGHT.EID,
			SELF.ImageType := RIGHT.image_type, // 1 - LPRPLATE, 2 - LPROVERVIEW, 3 - OFFENDER, 4 - PERSON
			SELF.Image := LEFT.photo));
			
	dRecsOut := dRecsDelta + dRecsMain;
	
	RETURN dRecsOut;
END;
