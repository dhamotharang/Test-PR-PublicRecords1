






 

import Text_Search;


layout_SANCTN_incident_clean_keyed := record
SANCTN.layout_SANCTN_incident_clean;
unsigned6 doc;
end;

export Convert_Incident_Func (DATASET(layout_SANCTN_incident_clean_keyed )ds) := FUNCTION






	Text_Search.Layout_Document cvt(layout_SANCTN_incident_clean_keyed  l) := TRANSFORM
		SELF.docRef.src := 0; 
		SELF.docRef.doc := l.doc;
		SELF.segs := DATASET([
		// need stuff here
	


				

		
		{3,0,l.CASE_NUMBER},
		{4,0,l.INCIDENT_DATE_CLEAN},
		{5,0,l.JURISDICTION},
		{6,0,l.SOURCE_DOCUMENT},
		{7,0,l.AGENCY},
		{8,0,l.ALLEGED_AMOUNT},
		{9,0,l.ESTIMATED_LOSS},
		{10,0,l.INCIDENT_TEXT}
		


		], Text_Search.Layout_Segment);
	END;

	reslt := PROJECT(ds, cvt(LEFT));
	

	
	
Text_Search.layout_DocSeg flatten(Text_Search.Layout_Document l, Text_Search.Layout_Segment r) 
	:= TRANSFORM
		SELF.docRef := l.docRef;
		SELF := r;
END;
	
norm_cont := NORMALIZE(reslt, left.segs, flatten(LEFT,RIGHT));

	
	
	
	
	RETURN norm_cont;
END;