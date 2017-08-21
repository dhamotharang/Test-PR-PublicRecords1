//export Convert_MFind_Func := 'todo';


//export Convert_FEIN_Func := 'todo';
// straight pasted   needs changed


// Convert to Dcument record
// Needs to match BWR_Build_Segment_Metadata
import Text_Search, codes;

in_layout := record
MFind.Layout_Clean_MFind;
unsigned6 uid;
unsigned2 src;
end;

export Convert_MFind_Func(DATASET(in_layout)ds) := FUNCTION

	stcode_layout := record
		ds;
		string2 leg_res_state_code := '';
	end;

	stds := Codes.File_Codes_V3_In(file_name = 'GENERAL' and field_name = 'STATE_LONG');
	
	stcode_layout convt_function(ds l, stds r) := transform
				self.leg_res_state_code := if (l.legal_res_state <> '', r.code, '');
				self := l;
	end;

	join_out := join(ds,stds,
									stringlib.stringtouppercase(trim(left.legal_res_state,left,right)) = stringlib.stringtouppercase(trim(right.long_desc,left,right)),
									convt_function(left,right),
									left outer,lookup
									);

//export Convert_MFind_Func(DATASET(MFind.Layout_Clean_MFind)ds) := FUNCTION

	Text_Search.Layout_Document cvt(join_out l) := TRANSFORM
		SELF.docRef.src := l.src; // need stuff here
		SELF.docRef.doc := l.uid;
		SELF.segs := DATASET([
			
		{1,0,l.CURR_NAME_LAST},
		{2,0,l.CURR_NAME_FIRST},
		{3,0,l.CURR_NAME_MIDDLE},
		{4,0,l.CURR_NAME_SUFFIX},
		{5,0,l.CURR_NAME_GENDER},
		{6,0,l.leg_res_state_code},
		{7,0,l.MIL_BRANCH},
		{8,0,l.MIL_SEP_DATE},
		{9,0,l.MIL_SERVICE_YRS},
		{10,0,l.CURR_NAME_FIRST + ' ' +l.CURR_NAME_MIDDLE+ ' ' +l.CURR_NAME_LAST},
		{11,0,l.MIL_PAY_GRADE}



		], Text_Search.Layout_Segment);
	END;

	reslt := PROJECT(join_out, cvt(LEFT));
	
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