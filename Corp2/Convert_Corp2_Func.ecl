

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
import Text_Search, corp2;


Layout_Corporate_Direct_Corp_Base_keyed := record
Corp2.Layout_Corporate_Direct_Corp_Base;
unsigned6 doc;
end;


export Convert_Corp2_Func(DATASET(Layout_Corporate_Direct_Corp_Base_keyed)ds) := FUNCTION






	Text_Search.Layout_Document cvt(Layout_Corporate_Direct_Corp_Base_keyed l) := TRANSFORM
		SELF.docRef.src := 0; // need stuff here
		SELF.docRef.doc := l.doc;
		SELF.segs := DATASET([
		
		{1,0,l.corp_sos_charter_nbr + '; ' + l.corp_forgn_sos_charter_nbr},
		{2,0,l.corp_legal_name},

		{3,0,l.corp_ln_name_type_desc},
		{4,0,l.corp_name_comment},
		{5,0,l.corp_address1_line1 + ' ' + l.corp_address1_line2 + ' ' + l.corp_address1_line3 +
				' ' + l.corp_address1_line4 + ' ' + l.corp_address1_line5 + ' ' + l.corp_address1_line6},
				
		{5,0,l.corp_address2_line1 + ' ' + l.corp_address2_line2 + ' ' + l.corp_address2_line3 +
				' ' + l.corp_address2_line4 + ' ' + l.corp_address2_line5 + ' ' + l.corp_address2_line6},
		
	
		{6,0,l.corp_phone_number},
	
		{7,0,l.corp_fax_nbr},
		{8,0,l.corp_email_address},
		{9,0,l.corp_web_address},
		{10,0,l.corp_filing_date},
		{11,0,l.corp_filing_desc},
		
//		{12,0,l.},  <--------------------
		{13,0,l.corp_status_date},
		
		{14,0,l.corp_standing},
		{15,0,l.corp_status_comment},
		
		{16,0,l.corp_ticker_symbol},
		{17,0,l.corp_stock_exchange},
		{18,0,l.corp_inc_state + '; ' + l.corp_forgn_state_desc},		
		{19,0,l.corp_inc_county},
		{20,0,l.corp_inc_date},
		
		{21,0,l.corp_fed_tax_id},
		{22,0,l.corp_state_tax_id},
		
		

		{23,0,l.corp_term_exist_exp},

		
		{24,0,l.corp_term_exist_desc},		
		{25,0,l.corp_forgn_date},
		
		{26,0,l.corp_orig_org_structure_desc},
		{27,0,l.corp_sic_code},		
		{28,0,l.corp_naic_code},
		{29,0,l.corp_orig_bus_type_desc},
		{30,0,l.corp_certificate_nbr},
		{31,0,l.corp_internal_nbr},
		{32,0,l.corp_previous_nbr},
		
		
		
		{33,0,l.corp_microfilm_nbr},
		{34,0,l.corp_amendments_filed},
		{35,0,l.corp_acts},
		{36,0,l.corp_addl_info},
		{37,0,l.corp_taxes},
		{38,0,l.corp_franchise_taxes},
		{39,0,l.corp_tax_program_cd},
		{40,0,l.corp_ra_name},
		
		
		
		{41,0,l.corp_ra_fein},
		{42,0,l.corp_ra_ssn},
		
		
		{43,0,l.corp_ra_dob},
		{44,0,l.corp_ra_effective_date},
		{45,0,l.corp_ra_resign_date},
		{46,0,l.corp_ra_address_line1 + ' ' + l.corp_ra_address_line2 + ' ' +
				l.corp_ra_address_line3 + ' ' + l.corp_ra_address_line4 + ' ' +
				l.corp_ra_address_line5 + ' ' + l.corp_ra_address_line6},
				
				
				
		{47,0,l.corp_ra_phone_number},
		{48,0,l.corp_ra_fax_nbr},
		{49,0,l.corp_ra_email_address},
		{50,0,l.corp_ra_web_address},
		{50,0,l.corp_ra_web_address},
/* need to add these		
		{'NAME',						textType,		[82]},	
		{'ADDRESS',						textType,		[83]},
		{'TELEPHONE',					textType,		[84]},
		{'DATE',						textType,		[85]},
		{'STATUS',						textType,		[86]},
		{'NUMBER',						textType,		[87]}		
*/	
		{82,0,l.corp_legal_name},
		{82,0,l.corp_ra_name},
		
		{83,0,l.corp_address1_line1 + ' ' + 
				l.corp_address1_line2 + ' ' + 
				l.corp_address1_line3 +	' ' + 
				l.corp_address1_line4 + ' ' + 
				l.corp_address1_line5 + ' ' + 
				l.corp_address1_line6 + '; ' +
				l.corp_address2_line1 + ' ' + 
				l.corp_address2_line2 + ' ' + 
				l.corp_address2_line3 +	' ' + 
				l.corp_address2_line4 + ' ' + 
				l.corp_address2_line5 + ' ' + 
				l.corp_address2_line6},
		{83,0,l.corp_ra_address_line1 + ' ' +
				l.corp_ra_address_line2 + ' ' +
				l.corp_ra_address_line3 + ' ' + 
				l.corp_ra_address_line4 + ' ' +
				l.corp_ra_address_line5 + ' ' + 
				l.corp_ra_address_line6},				
				
			
		{84,0,l.corp_phone_number},					
		{84,0,l.corp_ra_phone_number},
		
		{85,0,l.corp_filing_date},
		{85,0,l.corp_filing_desc},	
		{85,0,l.corp_inc_date},	
		{85,0,l.corp_term_exist_exp},
		{85,0,l.corp_forgn_date},
		{85,0,l.corp_ra_dob},
		{85,0,l.corp_ra_effective_date},
		{85,0,l.corp_ra_resign_date},		


		{86,0,l.corp_status_desc},		
		{86,0,l.corp_status_comment},
		
		{87,0,l.corp_fed_tax_id},
		{87,0,l.corp_state_tax_id},
		{87,0,l.corp_forgn_sos_charter_nbr},
		{87,0,l.corp_forgn_fed_tax_id},
		{87,0,l.corp_forgn_state_tax_id},
		{87,0,l.corp_certificate_nbr},
		{87,0,l.corp_internal_nbr},
		{87,0,l.corp_previous_nbr},
		{87,0,l.corp_ra_fein},
		{87,0,l.corp_ra_ssn}
		

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
	
norm_corp2 := NORMALIZE(reslt, left.segs, flatten(LEFT,RIGHT));

	
	
	
	
	RETURN norm_corp2;
END;