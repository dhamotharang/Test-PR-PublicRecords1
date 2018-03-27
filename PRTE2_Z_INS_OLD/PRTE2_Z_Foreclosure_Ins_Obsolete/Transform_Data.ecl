IMPORT NID,Doxie,address;

EXPORT Transform_Data := MODULE

		EXPORT Layouts.foreclose_XFORM_Rec Reformat_Alpha_Data (Layouts.batch_in L, Integer CNT) := TRANSFORM
							string clean_address := address.CleanAddress182(L.address, L.city + ' ' + L.st + ' ' + L.zip);
							unsigned1	zero := 0;
							unsigned6	property_rid := CNT;
							self.inp.fname := 	L.fname; 
							self.inp.mname := 	L.mname; 
							self.inp.lname := 	L.lname; 
							self.inp.ssn := 	if((integer)L.ssn=0,'',(string9)L.ssn); 
							self.inp.dob := 	(integer)L.dob; 
							self.inp.phone      := 	(string10) ''; 
							self.inp.prim_name  := clean_address[13..40]; 
							self.inp.prim_range := clean_address[1..10]; 
							self.inp.st         := clean_address[115..116]; 
							self.inp.city_name  := clean_address[65..89]; 
							self.inp.zip        := clean_address[117..121]; 
							self.inp.sec_range  := L.apt;
							self.inp.states := 	zero; 
							self.inp.lname1 := 	zero; 
							self.inp.lname2 := 	zero; 
							self.inp.lname3 := 	zero; 
							self.inp.city1 := 	zero; 
							self.inp.city2 := 	zero; 
							self.inp.city3 := 	zero; 
							self.inp.rel_fname1 := zero; 
							self.inp.rel_fname2 := zero; 
							self.inp.rel_fname3 := zero; 
							self.inp.lookups    := zero;
							self.inp.DID        := zero;
							self.inp.BDID     := zero;
							SELF.prim_name :=   clean_address [13..40];
							SELF.prim_range :=  clean_address [1..10];
							SELF.st :=    			clean_address[115..116];
							SELF.zip := 				clean_address[117..121];
							self.sec_range := L.Apt;
							SELF.seq :=  160000 + CNT;
							SELF.bdid := 0;
							SELF.did := 0;
							SELF.did_score := 0;
							SELF.bdid_score := 0;
							SELF.city_code := doxie.Make_CityCode(L.city);
							SELF.dph_lname := metaphonelib.DMetaPhone1(L.lname);
							SELF.pfname := NID.PreferredFirstVersionedStr(L.fname,2);
							SELF.lname := L.lname;
							SELF.fname := L.fname;
							SELF.minit := L.mname[1..1];	
							SELF.name_first := L.fname;
							SELF.name_middle := L.mname;
							SELF.name_last := L.lname;
							SELF.site_prim_range := clean_address [1..10];
							SELF.site_predir := clean_address[11..12];
							SELF.site_prim_name := clean_address [13..40];
							SELF.site_addr_suffix := clean_address [41..44];
							Self.site_postdir := clean_address [45..46];
							SELF.site_unit_desig := clean_address [47..56];
							SELF.site_sec_range := L.sec_range_1;
							SELF.site_p_city_name := L.p_city_name_1;
							SELF.site_v_city_name := L.p_city_name_1;
							SELF.site_st := clean_address [115..116];
							SELF.site_zip := clean_address [117..121];
							SELF.site_zip4 := clean_address [122..125];
							//* new fields:	
							SELF.DOB := IF ((integer)L.DOB =0, 0, (integer)L.DOB);
							SELF.ssn :=	if((integer)L.ssn=0,'',(string9)L.ssn); 
							self.ssn4 := if((integer)L.ssn=0, 0, (unsigned) L.ssn[6..9]);
							SELF.yob := IF ((integer)L.DOB = 0, zero, (integer) L.DOB [1..4]);
							SELF.s1 := L.ssn[1..1];
							SELF.s2 := L.ssn[2..2];
							SELF.s3 := L.ssn[3..3];
							self.s4 := (string)L.ssn[4..4];
							SELF.s5 := L.ssn[5..5];
							SELF.s6 := L.ssn[6..6];
							SELF.s7 := L.ssn[7..7];
							SELF.s8 := L.ssn[8..8];
							SELF.s9 := L.ssn[9..9];
							//*  FID fields:
							SELF.state := clean_address [115..116];
							SELF.county := clean_address [143..145];
							SELF.deed_category := L.deed_event_type_cd;
							SELF.deed_desc := L.deed_event_type_desc;
							SELF.document_type := L.doc_type_cd;
							SELF.document_desc := L.doc_type_desc;
							SELF.recording_date := L.deed_recording_date;

							SELF.first_defendant_borrower_owner_first_name := L.fname;
							SELF.first_defendant_borrower_owner_last_name := L.lname;
							SELF.first_defendant_borrower_company_name := L.ownr_1_cmpny_name;
							SELF.second_defendant_borrower_owner_first_name := '';
							SELF.second_defendant_borrower_owner_last_name := '';	
							SELF.third_defendant_borrower_owner_first_name := '';
							SELF.third_defendant_borrower_owner_last_name := '';
							SELF.fourth_defendant_borrower_owner_first_name := '';
							SELF.fourth_defendant_borrower_owner_last_name := '';
							SELF.date_of_default := IF(L.cp_dflt_dt > '' and L.deed_event_type_desc > '', L.cp_dflt_dt,'20090101');
							SELF.amount_of_default := IF (L.cp_dflt_amt > '' and L.deed_event_type_desc > '', L.cp_dflt_amt,'12000');
							SELF.filing_date := L.cp_filing_dt;
							SELF.court_case_nbr := L.court_case_nbr;
							SELF.plaintiff_1 := L.plntff1_name;
							SELF.plaintiff_2 := IF(L.plntff2_name	> '', L.fname + ' ' + L.lname, '');
							SELF.auction_date := L.cp_auction_dt;
							SELF.sales_price := L.cp_sale_amt;
							SELF.trustee_name := L.trustee_name;
							SELF.trustee_mailing_address := L.trustee_addr;
							SELF.trustee_city := L.trustee_city;
							SELF.trustee_state := L.trustee_state;
							SELF.trustee_zip := L.trustee_zipcd;
							SELF.trustee_phone := L.trustee_phone_nbr;
							self.full_site_address_unparsed_1 := trim(self.site_prim_range,left,right) + ' ' + trim(self.site_prim_name,left,right);

							self.situs_house_number_1 := self. site_prim_range;
							self.situs_street_name_1  := self.site_prim_name;
							self.situs_house_number_prefix_1 := self.site_predir;
							self.situs_house_number_suffix_1 := self.site_addr_suffix;
							self.property_city_1    := self.site_p_city_name;
							self.property_state_1   := self.site_st;
							self.property_address_zip_code_1 := self.site_zip;
							self.situs1_p_city_name := self.site_p_city_name;
							self.situs1_v_city_name := self.site_p_city_name;
							self.situs1_prim_range  := self.site_prim_range;
							self.situs1_prim_name   := self.site_prim_name;
							self.situs1_postdir     := self.site_postdir;
							self.situs1_predir      := self.site_predir;
							self.situs1_addr_suffix := self.site_addr_suffix;
							self.situs1_unit_desig  := self.site_unit_desig;
							self.situs1_sec_range   := self.site_sec_range;
							self.situs1_st          := self.site_st;
							self.situs1_zip         := self.site_zip;
							self.situs1_zip4        := self.site_zip4;
							self.name1_first        := self.fname;
							self.name1_middle       := self.minit;
							self.name1_last         := self.lname;

							SELF.original_loan_date := L.orig_loan_dt;
							SELF.original_loan_recording_date := L.orig_loan_recording_dt;
							SELF.parcel_number_parcel_id := L.parcel_number_parcel_id;
							self.parcel_number_unmatched_id := IF (L.parcel_number_parcel_id > ''
										,stringlib.stringfilter(L.parcel_number_parcel_id,'0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ')
										, '');
							SELF.property_indicator := L.property_type_cd;
							SELF.property_desc := L.property_type_desc;
							SELF.tract_subdivision_name := L.subdv_name;
							SELF.expanded_legal := L.expand_legal_desc;
							SELF.legal_2 := L.legal_desc_2;
							SELF.legal_3 := L.legal_desc_3;
							SELF.legal_4 := L.legal_desc_4;
							self.foreclosure_id	:= IF(L.parcel_number_unmatched_id <> ''
																					,IF(	TRIM(L.lname,LEFT,RIGHT) + TRIM(L.fname,LEFT,RIGHT) <> ''
																							,StringLib.StringFindReplace(TRIM(L.parcel_number_unmatched_id,LEFT,RIGHT) 
																																						+ TRIM(L.lname,LEFT,RIGHT) 
																																						+ TRIM(L.fname,LEFT,RIGHT), ' ', '')
																							,StringLib.StringFindReplace(TRIM(L.parcel_number_unmatched_id,LEFT,RIGHT) 
																																						+ TRIM(L.ownr_1_cmpny_name,LEFT,RIGHT), ' ', ''
																																					)
																						)
																					,'');		
							self.cname_indic := IF(L.lndr_cmpny_name <> '', L.lndr_cmpny_name, L.ownr_1_cmpny_name);																			
							SELF.word := TRIM(self.cname_indic,LEFT,RIGHT);
							SELF := L;
							SELF := [];
							self.p := []; 
							self.b := []
		END;
		
END;