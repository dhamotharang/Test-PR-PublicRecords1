








 

import Text_Search;


Layout_cont_keyed := record
Layout_Common.contact;
unsigned6 doc;
end;

export Convert_FBN_Cont_Func (DATASET(Layout_cont_keyed )ds) := FUNCTION






	Text_Search.Layout_Document cvt(Layout_cont_keyed  l) := TRANSFORM
		SELF.docRef.src := 0; 
		SELF.docRef.doc := l.doc;
		SELF.segs := DATASET([
		// need stuff here
	
				

		
		{19,0,l.Contact_COUNTRY},
		{21,0,l.Contact_NAME},
		{22,0,l.Contact_STATUS},
		{23,0,l.Contact_PHONE},
		{24,0,l.Contact_ADDR + ' ' + l.Contact_CITY + ' ' + l.Contact_STATE + ' ' +
				l.Contact_ZIP},
		{10,0,l.Contact_FEI_NUM},
		{25,0,l.CONTACT_CHARTER_NUM},
		{26,0,l.WITHDRAWAL_DATE},

		{33,0,l.Contact_ADDR + ' ' + l.Contact_CITY + ' ' + l.Contact_STATE + ' ' +
				l.Contact_ZIP},
		{30,0,l.Contact_NAME},
		{31,0,l.Contact_STATUS},
		{32,0,l.Contact_PHONE},
		{27,0,l.Contact_FEI_NUM + ' ' + l.CONTACT_CHARTER_NUM },
		{28,0,l.WITHDRAWAL_DATE}
		


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