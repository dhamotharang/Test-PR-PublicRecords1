






// Convert to Dcument record
// Needs to match BWR_Build_Segment_Metadata
import Text_Search,codes;
import Property;


 


export Convert_MD_Func(DATASET(marriage_divorce_v2.layout_mar_div_base)ds_in) := FUNCTION

// marriage = 3 divorce = 7

	// Filing type conversion 
	

	ftype_conv_record := record
		ds_in;
		typeof(codes.File_Codes_V3_In.long_desc)    ft_desc;
	end;

	ftype_conv_record conv_function(ds_in l,codes.File_Codes_V3_In r):= transform
		self := l;
		self.ft_desc := r.long_desc;
	end;
	
	ds := join(ds_in,codes.File_Codes_V3_In,
							right.file_name = 'MARRIAGE_DIVORCE' and
							right.field_name = 'FILING_TYPE' and
							left.filing_type = right.code,
							conv_function(left,right),
							left outer,lookup
							);
	
	
	Text_Search.Layout_Document cvt(ds l) := TRANSFORM
		SELF.docRef.src := 0; // need stuff here
		SELF.docRef.doc := l.record_id;
		SELF.segs := DATASET([
		
		{1,0,l.ft_desc},
		{2,0,if(l.party1_type = 'G' , l.party1_name,'')},
		{3,0,if(l.party1_type = 'H' , l.party1_name,'')},
		{2,0,if(l.party2_type = 'G' , l.party2_name,'')},
		{3,0,if(l.party2_type = 'H' , l.party2_name,'')},		
		

		{4,0,if(l.party1_type = 'G' , l.party1_dob,'')},
		{5,0,if(l.party1_type = 'H' , l.party1_dob,'')},
		{4,0,if(l.party2_type = 'G' , l.party2_dob,'')},
		{5,0,if(l.party2_type = 'H' , l.party2_dob,'')},		
		
		{6,0,if(l.party1_type = 'G' , l.party1_birth_state,'')},
		{7,0,if(l.party1_type = 'H' , l.party1_birth_state,'')},
		{6,0,if(l.party2_type = 'G' , l.party2_birth_state,'')},
		{7,0,if(l.party2_type = 'H' , l.party2_birth_state,'')},		
		
		{8,0,if(l.party1_type = 'G' , l.party1_age,'')},
		{9,0,if(l.party1_type = 'H' , l.party1_age,'')},
		{8,0,if(l.party2_type = 'G' , l.party2_age,'')},
		{9,0,if(l.party2_type = 'H' , l.party2_age,'')},		
		
		
		{10,0,if(l.party1_type = 'G' , l.party1_addr1 + ' ' +
										l.party1_csz + ' ' +
										l.party1_county,'')},
		{11,0,if(l.party1_type = 'H' , l.party1_addr1 + ' ' +
										l.party1_csz + ' ' +
										l.party1_county,'')},
		{10,0,if(l.party2_type = 'G' , l.party2_addr1 + ' ' +
										l.party2_csz + ' ' +
										l.party2_county,'')},
		{11,0,if(l.party2_type = 'H' , l.party2_addr1 + ' ' +
										l.party2_csz + ' ' +
										l.party2_county,'')},										
										
		{12,0,if(l.party1_type = 'H' , l.party1_previous_marital_status,'')},
		{12,0,if(l.party1_type = 'G' , l.party1_previous_marital_status,'')},
		{12,0,if(l.party2_type = 'H' , l.party2_previous_marital_status,'')},
		{12,0,if(l.party2_type = 'G' , l.party2_previous_marital_status,'')},		

		{13,0,if(l.party1_type = 'H' , l.party1_times_married,'')},
		{13,0,if(l.party1_type = 'G' , l.party1_times_married,'')},
		{13,0,if(l.party2_type = 'H' , l.party2_times_married,'')},
		{13,0,if(l.party2_type = 'G' , l.party2_times_married,'')},
		

										
	
		
		{14,0,if(l.party1_type = 'B' , l.party1_name,'')},
		{15,0,if(l.party1_type = 'W' , l.party1_name,'')},
		{14,0,if(l.party2_type = 'B' , l.party2_name,'')},
		{15,0,if(l.party2_type = 'W' , l.party2_name,'')},		
	
		{16,0,if(l.party1_type = 'B' , l.party1_alias,'')},
		{17,0,if(l.party1_type = 'W' , l.party1_alias,'')},
		{16,0,if(l.party2_type = 'B' , l.party2_alias,'')},
		{17,0,if(l.party2_type = 'W' , l.party2_alias,'')},		
		
		
		{18,0,if(l.party1_type = 'B' , l.party1_dob,'')},		
		{19,0,if(l.party1_type = 'W' , l.party1_dob,'')},
		{18,0,if(l.party2_type = 'B' , l.party2_dob,'')},		
		{19,0,if(l.party2_type = 'W' , l.party2_dob,'')},		
		
		
		{20,0,if(l.party1_type = 'B' , l.party1_birth_state,'')},
		{21,0,if(l.party1_type = 'W' , l.party1_birth_state,'')},
		{20,0,if(l.party2_type = 'B' , l.party2_birth_state,'')},
		{21,0,if(l.party2_type = 'W' , l.party2_birth_state,'')},		
		
		
		{22,0,if(l.party1_type = 'B' , l.party1_age,'')},
		{23,0,if(l.party1_type = 'W' , l.party1_age,'')},
		{22,0,if(l.party2_type = 'B' , l.party2_age,'')},
		{23,0,if(l.party2_type = 'W' , l.party2_age,'')},		
		
		
		{24,0,if(l.party1_type = 'B' , l.party1_addr1 + ' ' +
										l.party1_csz + ' ' +
										l.party1_county,'')},		
		{25,0,if(l.party1_type = 'W' , l.party1_addr1 + ' ' +
										l.party1_csz + ' ' +
										l.party1_county,'')},
		{24,0,if(l.party2_type = 'B' , l.party2_addr1 + ' ' +
										l.party2_csz + ' ' +
										l.party2_county,'')},		
		{25,0,if(l.party2_type = 'W' , l.party2_addr1 + ' ' +
										l.party2_csz + ' ' +
										l.party2_county,'')},										
										
										
		{26,0,if(l.party1_type = 'B' , l.party1_previous_marital_status,'')},
		{27,0,if(l.party1_type = 'W' , l.party1_previous_marital_status,'')},
		{26,0,if(l.party2_type = 'B' , l.party2_previous_marital_status,'')},
		{27,0,if(l.party2_type = 'W' , l.party2_previous_marital_status,'')},		
		
		{28,0,if(l.party1_type = 'B' , l.party1_times_married,'')},
		{29,0,if(l.party1_type = 'W' , l.party1_times_married,'')},
		{28,0,if(l.party2_type = 'B' , l.party2_times_married,'')},
		{29,0,if(l.party2_type = 'W' , l.party2_times_married,'')},		
		
		{30,0,if(l.filing_type = '7' , l.party2_how_marriage_ended,'')},
		{31,0,if(l.filing_type = '3' , l.marriage_filing_dt + ';' + l.marriage_dt,'')},

		
		
		{32,0,l.marriage_county+ ' ' + l.divorce_county},
		{33,0,l.marriage_city},
		{34,0,l.place_of_marriage},
		{35,0,l.type_of_ceremony},
		{36,0,l.marriage_filing_number + ' ' +l.divorce_filing_number},
		{37,0,if(l.filing_type = '7' , l.divorce_filing_dt + ';' + l.divorce_dt,'')},

		{38,0,l.number_of_children},
		///// New Segments
		{39,0,if(l.party1_type = 'P',l.party1_name,'')},
		{40,0,if(l.party1_type = 'D',l.party1_name,'')},
		{41,0,if(l.party1_type = 'M',l.party1_name,'')},
		{42,0,if(l.party1_type = 'N',l.party1_name,'')},
		{39,0,if(l.party2_type = 'P',l.party2_name,'')},
		{40,0,if(l.party2_type = 'D',l.party2_name,'')},
		{41,0,if(l.party2_type = 'M',l.party2_name,'')},
		{42,0,if(l.party2_type = 'N',l.party2_name,'')},
		/////
		{43,0,l.party1_name + '; ' + l.party1_alias + '; ' + l.party2_name+ '; ' + l.party2_alias},
		{45,0,l.party1_addr1 + ' ' +l.party1_csz + ' ' +l.party1_county + '; ' +
				l.party2_addr1 + ' ' +l.party2_csz + ' ' +l.party2_county + ' ' + l.state_origin},
		{46,0,l.marriage_county + ' ' + l.divorce_county},
		{47,0,l.marriage_filing_number + ' ' + l.divorce_filing_number},
		{48,0,l.state_origin}
		

				
		

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
	
norm_md := NORMALIZE(reslt, left.segs, flatten(LEFT,RIGHT));

	
	
	
	
	RETURN norm_md;
END;