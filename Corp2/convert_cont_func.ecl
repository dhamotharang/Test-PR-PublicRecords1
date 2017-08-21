 

// unfortunately, there are 5 files that need to be processed
// so we will do this 5 times and cat the results tigether
// we only take one file in, as a param
// so we need to change things
// or hardcode the filenames
// probably the thing to do
// seems as tho I have to get the index number on all records
// that is painful  well  maybe not



// Convert to Dcument record
// Needs to match BWR_Build_Segment_Metadata
import Text_Search;


Layout_Corporate_Direct_Cont_Base_keyed := record
Corp2.Layout_Corporate_Direct_Cont_Base;
unsigned6 doc;
end;


export convert_cont_func(DATASET(Layout_Corporate_Direct_Cont_Base_keyed)ds) := FUNCTION






	Text_Search.Layout_Document cvt(Layout_Corporate_Direct_Cont_Base_keyed l) := TRANSFORM
		SELF.docRef.src := 0; // need stuff here
		SELF.docRef.doc := l.doc;
		SELF.segs := DATASET([
		
		{51,0,l.cont_name},
		{52,0,l.cont_fein},
		{53,0,l.cont_ssn},
		{54,0,l.cont_dob},
		{55,0,l.cont_status_desc},
		{56,0,l.cont_effective_date},
		{57,0,l.cont_address_line1 + ' ' + l.cont_address_line2 + ' ' + l.cont_address_line3 + ' ' +
				l.cont_address_line4 + ' ' + l.cont_address_line5 + ' ' + l.cont_address_line6},
		{58,0,l.cont_phone_number},
		{59,0,l.cont_fax_nbr},
		{60,0,l.cont_email_address},
		{61,0,l.cont_web_address},
		

		{82,0,l.cont_name},
		{83,0,l.cont_address_line1 + ' ' + l.cont_address_line2 + ' ' + l.cont_address_line3 + ' ' +
				l.cont_address_line4 + ' ' + l.cont_address_line5 + ' ' + l.cont_address_line6},
		{84,0,l.cont_phone_number},
		{85,0,l.cont_effective_date},
		//{86,0,l.cont_status_desc},
		{87,0,l.cont_fein + '; ' + l.cont_ssn},
		{89,0,l.corp_state_origin},
		{249,0,l.corp_process_date}
		
		
		

//vesa: doxie_build.key_prep_Vehicles

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
	
norm_cont := NORMALIZE(reslt, left.segs, flatten(LEFT,RIGHT));

	
	
	
	
	RETURN norm_cont;
END;