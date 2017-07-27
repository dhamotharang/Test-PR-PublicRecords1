




import Text_Search;


Layout_TaxPro_keyed := record
Layout.Taxpro_Standard_Base;
unsigned6 doc;
end;

export Convert_TaxPro_Func (DATASET(Layout_TaxPro_keyed )ds) := FUNCTION






	Text_Search.Layout_Document cvt(Layout_TaxPro_keyed  l) := TRANSFORM
		SELF.docRef.src := 0; 
		SELF.docRef.doc := l.doc;
		SELF.segs := DATASET([
		// need stuff here
		{1,0,l.firstnm + ' ' + l.midinit + ' ' + l.lastnm},
		{2,0,l.enroll_year},
		{3,0,l.addr1 + ' ' + l.addr2 + ' ' + l.addr3 + ' ' + l.city + ' ' + l.state +
				' ' /*+ l.province + ' '*/ + l.country + ' ' + l.zip},
		{4,0,l.city},
		{5,0,l.state},
		{6,0,l.zip},
		
		//{7,0,l.province},
		{8,0,l.country}
		

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