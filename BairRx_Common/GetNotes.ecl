IMPORT BairRx_Common;
EXPORT GetNotes(DATASET(BairRx_Common.Layouts.SearchRec) dIDs,INTEGER NoteType = 0) := FUNCTION

		ddIDs 			:= DEDUP(SORT(dIDs, eid), eid);		
		dFetchDeltaRecs 	:= JOIN(ddIDs, BairRx_Common.Keys.NotesKey(TRUE).IDX, KEYED(left.eid = right.eid) and (NoteType= 0 or NoteType = right.note_type), TRANSFORM(RIGHT), KEEP(5), LIMIT(0));	
		dIDSmain 		:= JOIN(dIDS, dFetchDeltaRecs, LEFT.eid = RIGHT.eid, TRANSFORM(BairRx_Common.Layouts.SearchRec,SELF := LEFT),LEFT ONLY);
		dFetchMainRecs 	:= JOIN(dIDSmain, BairRx_Common.Keys.NotesKey(FALSE).IDX, KEYED(left.eid = right.eid) and (NoteType= 0 or NoteType = right.note_type), TRANSFORM(RIGHT), KEEP(5), LIMIT(0));	
		ddFetchDeltaRecs := DEDUP(SORT(dFetchDeltaRecs, eid, note_type), eid, note_type);
		ddFetchMainRecs := DEDUP(SORT(dFetchMainRecs, eid, note_type), eid, note_type);
					
		dDeltaNotes := FETCH(BairRx_Common.Keys.NotesKey(TRUE).FILE, ddFetchDeltaRecs, RIGHT.__filepos, 
			TRANSFORM(BairRx_Common.Layouts.PayloadNotes, SELF.notes := LEFT.notes, SELF := RIGHT));
		dMainNotes := FETCH(BairRx_Common.Keys.NotesKey(FALSE).FILE, ddFetchMainRecs, RIGHT.__filepos, 
			TRANSFORM(BairRx_Common.Layouts.PayloadNotes, SELF.notes := LEFT.notes, SELF := RIGHT));	
		dNotes	:= 	dDeltaNotes + dMainNotes;
		
		return dNotes;						 
END;