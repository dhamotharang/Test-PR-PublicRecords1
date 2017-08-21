IMPORT iesp,BairRx_Common;

EXPORT GetLayerText(DATASET(iesp.bair_agencylayer.t_BAIRAgencyLayerSearchRecord) EIDs) := FUNCTION
		
	dIDs := CHOOSEN(DEDUP(SORT(EIDs, RECORD)), 5000);		
	
	dFetchRecs := JOIN(dIDs, BairRx_Common.Keys.LayerPayloadKey().IDX, KEYED(LEFT.LayerID = RIGHT.LayerID AND LEFT.GeoType = RIGHT.GeoType), TRANSFORM(RIGHT));	
	
	dFPRecs := BairRx_Common.FetchLimit(dFetchRecs, 5000);

	dRecs := FETCH(BairRx_Common.Keys.LayerPayloadKey().FILE, dFPRecs, RIGHT.__filepos, 
		TRANSFORM(iesp.bair_agencylayer.t_BAIRAgencyLayerRecord,
			SELF.LayerId := RIGHT.LayerId,
			SELF.Segment := left.seg,
			SELF.GeoText := LEFT.GeoText));

	dRecsOut := SORT(dRecs,LayerId,Segment);
	
	RETURN dRecsOut;
END;
