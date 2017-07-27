



		







 

import Text_Search;


layout_SANCTN_party_clean_keyed := record
SANCTN.layout_SANCTN_party_clean;
unsigned6 doc;
end;

export Convert_Party_Func  (DATASET(layout_SANCTN_party_clean_keyed )ds) := FUNCTION






	Text_Search.Layout_Document cvt(layout_SANCTN_party_clean_keyed l) := TRANSFORM
		SELF.docRef.src := 0; 
		SELF.docRef.doc := l.doc;
		SELF.segs := DATASET([
		// need stuff here
	


				

		
		{1,0,l.PARTY_NAME + '; ' + l.PARTY_FIRM},
		{2,0,l.RESTITUTION}


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