



 

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


Layout_Corporate_Direct_Event_Base_keyed := record
Corp2.Layout_Corporate_Direct_Event_Base;
unsigned6 doc;
end;

export convert_event_func (DATASET(Layout_Corporate_Direct_Event_Base_keyed)ds) := FUNCTION






	Text_Search.Layout_Document cvt(Layout_Corporate_Direct_Event_Base_keyed l) := TRANSFORM
		SELF.docRef.src := 0; // need stuff here
		SELF.docRef.doc := l.doc;
		SELF.segs := DATASET([
		
		{70,0,l.event_filing_reference_nbr},
		{71,0,l.event_amendment_nbr},
		{72,0,l.event_filing_date},
		{11,0,l.event_filing_desc},
		{73,0,l.event_roll + '; ' + l.event_frame + '; ' + l.event_microfilm_nbr},
		{74,0,l.event_desc},
		
		
//		{'NAME',						textType,		[82]},	
//		{'ADDRESS',						textType,		[83]},
//		{'TELEPHONE',					textType,		[84]},
//		{'DATE',						textType,		[85]},
//		{'STATUS',						textType,		[86]},
//		{'NUMBER',						textType,		[87]}	
		{87,0,l.event_filing_reference_nbr},
		{87,0,l.event_amendment_nbr},
		{85,0,l.event_filing_date},
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