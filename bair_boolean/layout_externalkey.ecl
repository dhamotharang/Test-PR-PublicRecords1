// The detail posting record for the inversion.
//
import text_search;
export Layout_externalkey := RECORD
	text_search.Types.DocRef docRef;
	text_search.Layout_Segment;
	string eid;
END;