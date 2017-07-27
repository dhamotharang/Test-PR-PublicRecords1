//export Convert_MFind_Func := 'todo';


//export Convert_FEIN_Func := 'todo';
// straight pasted   needs changed


// Convert to Dcument record
// Needs to match BWR_Build_Segment_Metadata
import Text_Search;

in_layout := record
MFind.Layout_Clean_MFind;
unsigned6 uid;
unsigned2 src;
end;

export Convert_MFind_Func(DATASET(in_layout)ds) := FUNCTION



//export Convert_MFind_Func(DATASET(MFind.Layout_Clean_MFind)ds) := FUNCTION

	Text_Search.Layout_Document cvt(in_layout l) := TRANSFORM
		SELF.docRef.src := l.src; // need stuff here
		SELF.docRef.doc := l.uid;
		SELF.segs := DATASET([
			
		{1,0,l.CURR_NAME_LAST},
		{2,0,l.CURR_NAME_FIRST},
		{3,0,l.CURR_NAME_MIDDLE},
		{4,0,l.CURR_NAME_SUFFIX},
		{5,0,l.CURR_NAME_GENDER},
		{6,0,l.LEGAL_RES_STATE},
		{7,0,l.MIL_BRANCH},
		{8,0,l.MIL_SEP_DATE},
		{9,0,l.MIL_SERVICE_YRS},
		{10,0,l.CURR_NAME_FIRST + ' ' +l.CURR_NAME_MIDDLE+ ' ' +l.CURR_NAME_LAST}



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