







 

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


Layout_Corporate_Direct_Stock_Base_keyed := record
Corp2.Layout_Corporate_Direct_Stock_Base;
unsigned6 doc;
end;

export Convert_Stock_Func (DATASET(Layout_Corporate_Direct_Stock_Base_keyed)ds) := FUNCTION






	Text_Search.Layout_Document cvt(Layout_Corporate_Direct_Stock_Base_keyed l) := TRANSFORM
		SELF.docRef.src := 0; // need stuff here
		SELF.docRef.doc := l.doc;
		SELF.segs := DATASET([
		
		{16,0,l.stock_ticker_symbol},
		{17,0,l.stock_exchange},
		{62,0,l.stock_type},
		{63,0,l.stock_class},
		{64,0,l.stock_shares_issued},
		{65,0,l.stock_authorized_nbr},
		{66,0,l.stock_par_value},
		{67,0,l.stock_nbr_par_shares},
		{68,0,l.stock_change_date},
		{69,0,l.stock_tax_capital},
		{88,0,l.stock_total_capital},
		{88,0,l.corp_state_origin},
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