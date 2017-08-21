IMPORT BairRx_Common,iesp;

EXPORT Functions := MODULE
	EXPORT AppendNotes(DATASET(iesp.bair_offender.t_BAIROffenderSearchRecord) dOffRecs) := FUNCTION
		dEIDs := PROJECT(dOffRecs, TRANSFORM(BairRx_Common.Layouts.SearchRec, SELF.eid := LEFT.EntityID,SELF :=[]));
		dNotes := BairRx_Common.GetNotes(dEIDs);		
		dOffRecsWithNotes := JOIN(dOffRecs, dNotes, LEFT.EntityID = RIGHT.eid, 
			TRANSFORM(iesp.bair_offender.t_BAIROffenderSearchRecord,
				SELF.OffenderNotes := RIGHT.notes,
				SELF := LEFT),
			KEEP(1), LIMIT(0), LEFT OUTER);
		RETURN dOffRecsWithNotes;
	END;
END;

