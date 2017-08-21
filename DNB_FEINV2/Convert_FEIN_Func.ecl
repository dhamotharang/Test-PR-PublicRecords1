//export Convert_FEIN_Func := 'todo';
// change this


// Convert to Dcument record
// Needs to match BWR_Build_Segment_Metadata
import Text_Search;

fpos_fein := record
DNB_FEINv2.layout_DNB_fein_base_main;
unsigned6 uid;
unsigned2 src;
end;

export Convert_fein_Func(DATASET(fpos_fein)ds) := FUNCTION

	Text_Search.Layout_Document cvt(fpos_fein l) := TRANSFORM
//		SELF.docRef.src := TRANSFER(l.SOURCE_DUNS_NUMBER, INTEGER2);
		SELF.docRef.src := 0;
		SELF.docRef.doc := l.uid;
		SELF.segs := DATASET([
			
		{1,0,l.orig_company_name},
		{2,0,l.FEIN},
		{3,0,l.SOURCE_DUNS_NUMBER},
		//{4,0,l.CASE_DUNS_NUMBER},
		//{5,0,l.orig_address1},
		//{6,0,l.orig_address2},
		//{7,0,l.orig_CITY},
		//{8,0,l.orig_STATE},
		//{9,0,l.orig_ZIP5},
		//{10,0,l.orig_zip4},
		{11,0,l.orig_address1 + ' ' +l.orig_address2+ ' ' +l.orig_CITY+ ' ' +
				l.orig_STATE + ' ' +l.orig_ZIP5 + ' ' + l.orig_zip4}



		], Text_Search.Layout_Segment);
	END;

	reslt := PROJECT(ds, cvt(LEFT));
	
	// transform to normalize this data into layout.DocSeg  see liens
	
	//call to do the normalize
	
	// returned normalized data
	
	
Text_Search.layout_DocSeg flatten(Text_Search.Layout_Document l, Text_Search.Layout_Segment r) 
	:= TRANSFORM
		SELF.docRef := l.docRef;
		SELF := r;
END;
	
norm_fein := NORMALIZE(reslt, left.segs, flatten(LEFT,RIGHT));

	
	
	
	
	RETURN norm_fein;
END;