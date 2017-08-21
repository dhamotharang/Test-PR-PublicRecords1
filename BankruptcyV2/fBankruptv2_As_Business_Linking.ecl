IMPORT BIPV2, Business_Header, ut, mdr, _validate;

EXPORT fBankruptv2_As_Business_Linking(
	 DATASET(layout_bankruptcy_search_v3_supp_bip									) pFile_BK_Search_V3
	,DATASET(layout_bankruptcy_main.layout_bankruptcy_main_filing	) pFile_BK_Main) := FUNCTION
	
	bs_Bus     := pFile_BK_Search_V3((cname <> '' AND ((lname = '' AND cname <> '' AND court_code <> '' AND case_number <> '') OR case_number[1..3] <> '449')),(TRIM(name_type) = 'D'));
  bs_Con     := pFile_BK_Search_V3(((court_code <> '' and case_number <> '') or case_number[1..3] <> '449'),(trim(name_type) = 'D'));	
	bm         := pFile_BK_Main((court_code <> '' AND case_number <> '') OR case_number[1..3] <> '449');
	
 	layout_bk_temp_loc := RECORD
	   layout_bankruptcy_search_v3_supp_bip;
	   STRING8 orig_filing_date;
		 STRING8 disposed_date;
	   STRING8 reopen_date;
		 STRING8  status_date := '';
		 STRING30 status_type := '';
	END;

	layout_bk_main_slim := RECORD
	   bm.court_code;
	   bm.case_number;
	   bm.seq_number;
	   bm.orig_filing_date;
	   bm.date_filed;
	   bm.disposed_date;
	   bm.reopen_date;
	   bm.converted_date;
		 STRING8  status_date := '';
		 STRING30 status_type := '';
	END;
  
	layout_court_case_list := RECORD
	  bs_Con.court_code;
	  bs_Con.case_number;
	END;

  court_case_list       := TABLE(bs_Con(lname = '', cname <> ''), layout_court_case_list);
	court_case_list_dedup := DEDUP(court_case_list, court_code, case_number, ALL);
	 	
	// Join business bankruptcy list to search file to get contacts
	BankruptcyV2.layout_bankruptcy_search_v3_supp_bip SelectContacts(BankruptcyV2.layout_bankruptcy_search_v3_supp_bip L, layout_court_case_list R) := TRANSFORM
	  SELF := L;
	END;

	bc_init := JOIN(bs_Con(lname <> '', cname = ''),
					   court_case_list_dedup,
				  	 LEFT.court_code = RIGHT.court_code AND
					   LEFT.case_number = RIGHT.case_number,
					   SelectContacts(LEFT, RIGHT),
				  	 HASH);

	bc_dist := DISTRIBUTE(bc_init, HASH(court_code, case_number));
		
	// *************************************************************************
	// Translate Bankruptcy Contacts to Contacts Linking Format
	// *************************************************************************
	
	Business_Header.Layout_Business_Linking.Contact Transfer_Contacts_to_BLF(bc_dist L) := TRANSFORM
    SELF.tmp_join_id_contact         := TRIM(l.Tmsid) + TRIM(l.court_code) + TRIM(l.case_number);
		SELF.contact_address_type        := 'C';		
		SELF.contact_did                 := (UNSIGNED6)L.did;
    SELF.contact_name.title          := L.title; 	
		SELF.contact_name.fname          := L.fname; 		
		SELF.contact_name.mname          := L.mname; 		
		SELF.contact_name.lname          := L.lname; 		
		SELF.contact_name.name_suffix    := L.name_suffix; 		
		SELF.contact_name.name_score     := Business_Header.CleanName(L.fname, L.mname, L.lname, L.name_suffix)[142]; 
		SELF.contact_ssn                 := L.app_ssn;
    SELF:= [];
  END;

  dsBkContacts  := PROJECT(bc_dist, Transfer_Contacts_to_BLF(LEFT));
	dsBkCon_Dist  := DISTRIBUTE(dsBkContacts,HASH(tmp_join_id_contact));
	dsBKCon_Dedup := DEDUP(SORT(dsBkCon_Dist,RECORD,LOCAL),RECORD,LOCAL);
	
  //BUSINESS

	bm_init       := project(bm, transform(layout_bk_main_slim,
																				 self.status_date := max(left.status,status_date),
																				 self.status_type := left.status(status_date = self.status_date)[1].status_type,
																				 self := left));
	bm_init_dist  := DISTRIBUTE(bm_init, HASH(court_code, case_number));
	bm_init_sort  := SORT(bm_init_dist, court_code, case_number, -seq_number, LOCAL);
	bm_init_dedup := DEDUP(bm_init_sort, court_code, case_number, LOCAL);

	bsBus_dist    := DISTRIBUTE(bs_Bus, HASH(court_code, case_number));

	layout_bk_temp_loc AppendFromMain(layout_bankruptcy_search_v3_supp_bip L, layout_bk_main_slim R) := TRANSFORM
	   SELF.orig_filing_date := R.orig_filing_date;
	   SELF.date_filed       := If (L.date_filed<>'',L.date_filed,R.date_filed);
	   SELF.disposed_date    := R.disposed_date;
	   SELF.reopen_date      := R.reopen_date;
	   SELF.converted_date   := If (L.converted_date<>'',L.converted_date,R.converted_date);
		 SELF.status_date 		 := R.status_date;
		 SELF.status_type 		 := ut.CleanSpacesAndUpper(R.status_type);
	   SELF                  := L;
	END;
	
	// Add dates from the MAIN file to the SEARCH file
	bsBus_append := JOIN(bsBus_dist, bm_init_dedup,
					     LEFT.court_code  = RIGHT.court_code AND
						   LEFT.case_number = RIGHT.case_number, 
					     AppendFromMain(LEFT, RIGHT),
					     LOCAL);

			
	// *************************************************************************
	// Translate Bankruptcy Companies to Company Linking Format
	// *************************************************************************	
	Business_Header.Layout_Business_Linking.Company_	Transfer_Comp_To_BLF(layout_bk_temp_loc L) := TRANSFORM
			string tmpRecord_Status_type 		 := ut.CleanSpacesAndUpper(L.record_type) + if(ut.CleanSpacesAndUpper(L.status_type) <> '',';'+ut.CleanSpacesAndUpper(L.status_type),''); 
			
      SELF.tmp_join_id_company         := TRIM(L.Tmsid) + TRIM(L.court_code) + TRIM(L.case_number);	 		
			SELF.source											 := MDR.sourceTools.src_Bankruptcy;
			SELF.dt_first_seen  				     := ut.EarliestDate(IF(_validate.date.fIsValid(L.orig_filing_date),(UNSIGNED4)L.orig_filing_date,0),
																													IF(_validate.date.fIsValid(L.date_filed),(UNSIGNED4)L.date_filed,0));
			SELF.dt_last_seen  					     := MAX(MAX(IF(_validate.date.fIsValid(L.disposed_date),(UNSIGNED4)L.disposed_date,0),
																																			IF(_validate.date.fIsValid(L.reopen_date),(UNSIGNED4)L.reopen_date,0)),
																												MAX(IF(_validate.date.fIsValid(L.converted_date),(UNSIGNED4)L.converted_date,0),
																																			IF(_validate.date.fIsValid(L.date_filed),(UNSIGNED4)L.date_filed,0))
																											 );
		  SELF.dt_vendor_first_reported    := SELF.dt_first_seen;
		  SELF.dt_vendor_last_reported     := SELF.dt_last_seen;
			SELF.company_bdid                := (UNSIGNED6)L.bdid;	
			SELF.company_name							   := Stringlib.StringToUpperCase(L.cname);
			SELF.company_address.prim_range  := L.prim_range;
		  SELF.company_address.predir      := L.predir;
		  SELF.company_address.prim_name   := L.prim_name;
		  SELF.company_address.addr_suffix := L.addr_suffix;
		  SELF.company_address.postdir     := L.postdir;
		  SELF.company_address.unit_desig  := L.unit_desig;
		  SELF.company_address.sec_range   := L.sec_range;
		  SELF.company_address.p_city_name := L.p_city_name; 
		  SELF.company_address.v_city_name := L.v_city_name;
		  SELF.company_address.st          := L.st;
		  SELF.company_address.zip         := L.zip;
		  SELF.company_address.zip4        := L.zip4;
		  SELF.company_address.cart        := L.cart; 
		  SELF.company_address.cr_sort_sz  := L.cr_sort_sz;
		  SELF.company_address.lot         := L.lot; 
		  SELF.company_address.lot_order   := L.lot_order; 		
		  SELF.company_address.dbpc        := L.dbpc; 
		  SELF.company_address.chk_digit   := L.chk_digit;
		  SELF.company_address.rec_type    := L.rec_type; 			
		  SELF.company_address.fips_county := L.county[3..5];
			SELF.company_address.fips_state  := L.county[1..2];
			SELF.company_address.geo_lat     := L.geo_lat;
		  SELF.company_address.geo_long    := L.geo_long;
			SELF.company_address.msa         := L.msa; 
		  SELF.company_address.geo_blk     := L.geo_blk;
		  SELF.company_address.geo_match   := L.geo_match;
		  SELF.company_address.err_stat    := L.err_stat;
			SELF.company_status_raw					 := if (BIPV2.BL_Tables.CompanyStatusDesc(tmpRecord_Status_type) = BIPV2.BL_Tables.CompanyStatusConstants.strDefunct, tmpRecord_Status_type,'');
			SELF.company_fein                := IF((UNSIGNED4)L.app_ssn > 9999, L.app_ssn, '');
			SELF.company_phone               := Business_Header.CleanPhone(L.phone); 
			SELF.phone_type     						 := IF((INTEGER)SELF.company_phone = 0, '', 'T');
		  SELF.vl_id   										 := TRIM(L.tmsid) + TRIM(L.debtor_type,LEFT,RIGHT);
			SELF.source_docid                := TRIM(L.tmsid);
			SELF.current										 := TRUE;
			SELF.glb     										 := FALSE;
      SELF.dppa												 := FALSE;
			SELF.source_record_id						 := L.source_rec_id;
		  SELF 														 := L;
		  SELF 														 := [];
	END;
	
	dsBkComp       := PROJECT(bsBus_append, Transfer_Comp_to_BLF(LEFT));
	dsBKComp_Dist  := DISTRIBUTE(dsBkComp,HASH(tmp_join_id_company));
	dsBkComp_Dedup := DEDUP(SORT(dsBKComp_Dist,RECORD,LOCAL),RECORD,LOCAL);
	
	Business_Header.Layout_Business_Linking.Combined Comb_BK( Business_Header.Layout_Business_Linking.Company_ L, Business_Header.Layout_Business_Linking.Contact R) := transform
	  SELF.company_address_type_raw := R.contact_address_type;  	
		SELF      := L;
	  SELF      := R;
  END;

  jCombined := JOIN(dsBkComp_Dedup
						       ,dsBKCon_Dedup
						       ,LEFT.tmp_join_id_company = RIGHT.tmp_join_id_contact
						       ,Comb_BK(LEFT,RIGHT)
						       ,LEFT OUTER
						       ,LOCAL);		
									 
									 
	Bk_dedup := 	PROJECT(jCombined,Business_Header.Layout_Business_Linking.Linking_Interface);							 

	RETURN Bk_dedup(~ut.isNumeric(TRIM(company_name,ALL)));
END;