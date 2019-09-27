IMPORT BKForeclosure, MDR, PRTE2, ut, STD;

EXPORT REO_prep_ingest_file := FUNCTION

  //Project to base layout for ingest
	fIn_Raw_Reo   := BKForeclosure.File_BK_Foreclosure.Reo_File;
	
	prte2.CleanFields(fIn_Raw_Reo, ClnRawReoIn); //using PRTE2 clean function as it cleans unprintable characters and uppercases output

BKForeclosure.Layout_BK.base_reo_ext CleanTrimReo(ClnRawReoIn L, seqNum) := TRANSFORM
	SELF.DATE_FIRST_SEEN						:= thorlib.wuid()[2..9];
	SELF.DATE_LAST_SEEN							:= thorlib.wuid()[2..9];
	SELF.DATE_VENDOR_FIRST_REPORTED := L.ln_filedate;
	SELF.DATE_VENDOR_LAST_REPORTED	:= L.ln_filedate;
	SELF.PROCESS_DATE						 := thorlib.wuid()[2..9];
	SELF.src  									 := mdr.sourceTools.src_BKFS_Reo;
	ClnAPN											 := IF(LENGTH(TRIM(L.APN)) = 1 and STD.Str.Find(L.APN,'+',1) = 1, STD.Str.FindReplace(L.APN,'+',''),
																			REGEXREPLACE('(\\+|`|~)',L.APN,''));
	SELF.foreclosure_id					 :=	IF(L.APN <> '',
																		 STD.Str.FindReplace(TRIM(ClnAPN,LEFT,RIGHT) + TRIM(L.buyer1_lname,LEFT,RIGHT) + TRIM(L.buyer1_fname,LEFT,RIGHT), ' ', ''),
																		 STD.Str.FindReplace('FC' + INTFORMAT(seqNum, 8, 1) + TRIM(L.buyer1_lname,LEFT,RIGHT) + TRIM(L.buyer1_fname,LEFT,RIGHT), ' ', '')																
																		);
	SELF.fips_cd                 := L.fips_cd;
	SELF.prop_full_addr          := ut.CleanSpacesAndUpper(L.prop_full_addr);
	SELF.prop_addr_city          := ut.CleanSpacesAndUpper(L.prop_addr_city);
	SELF.prop_addr_state         := ut.CleanSpacesAndUpper(L.prop_addr_state);
	SELF.prop_addr_zip5          := L.prop_addr_zip5;
	SELF.prop_addr_zip4          := IF(TRIM(L.prop_addr_zip4) = '0','',
																		IF(TRIM(L.prop_addr_zip4) = 'NULL','',L.prop_addr_zip4));
	SELF.prop_addr_unit_type     := L.prop_addr_unit_type;	
	SELF.prop_addr_unit_no       := L.prop_addr_unit_no;
	SELF.prop_addr_house_no      := L.prop_addr_house_no;
	SELF.prop_addr_predir        := L.prop_addr_predir;
	SELF.prop_addr_street        := ut.CleanSpacesAndUpper(L.prop_addr_street);
	SELF.prop_addr_suffix        := L.prop_addr_suffix;
	SELF.prop_addr_postdir       := L.prop_addr_postdir;
	SELF.prop_addr_carrier_rt    := L.prop_addr_carrier_rt;
	SELF.recording_date          := L.recording_date;
	SELF.recording_book_num      := L.recording_book_num;
	SELF.recording_page_num      := L.recording_page_num;
	SELF.recording_doc_num       := L.recording_doc_num;
	SELF.doc_type_cd             := L.doc_type_cd;
	SELF.APN                     := STD.Str.CleanSpaces(ClnAPN);
	SELF.multi_APN               := L.multi_APN;
	SELF.partial_interest_trans  := L.partial_interest_trans;
	SELF.seller1_fname           := ut.CleanSpacesAndUpper(L.seller1_fname);
	SELF.seller1_lname           := ut.CleanSpacesAndUpper(L.seller1_lname);
	SELF.seller1_id              := ut.CleanSpacesAndUpper(L.seller1_id);
	SELF.seller2_fname           := ut.CleanSpacesAndUpper(L.seller2_fname);
	SELF.seller2_lname           := ut.CleanSpacesAndUpper(L.seller2_lname);
	SELF.buyer1_fname            := ut.CleanSpacesAndUpper(L.buyer1_fname);
	SELF.buyer1_lname            := ut.CleanSpacesAndUpper(L.buyer1_lname);
	SELF.buyer1_id_cd            := ut.CleanSpacesAndUpper(L.buyer1_id_cd);
	SELF.buyer2_fname            := ut.CleanSpacesAndUpper(L.buyer2_fname);
	SELF.buyer2_lname            := ut.CleanSpacesAndUpper(L.buyer2_lname);
	SELF.buyer_vesting_cd        := L.buyer_vesting_cd;
	SELF.concurrent_doc_num      := L.concurrent_doc_num;
	SELF.buyer_mail_city         := STD.Str.FindReplace(L.buyer_mail_city,'N/A','');
	SELF.buyer_mail_state        := L.buyer_mail_state;
	SELF.buyer_mail_zip5         := L.buyer_mail_zip5;
	SELF.buyer_mail_zip4         := IF(TRIM(L.buyer_mail_zip4) = '0','',
																		IF(TRIM(L.buyer_mail_zip4) = 'NULL','',L.buyer_mail_zip4));
	SELF.legal_lot_cd            := L.legal_lot_cd;
	SELF.legal_lot_num           := L.legal_lot_num;
	SELF.legal_block             := L.legal_block;
	SELF.legal_section           := L.legal_section;
	SELF.legal_district          := L.legal_district;
	SELF.legal_land_lot          := L.legal_land_lot;
	SELF.legal_unit              := L.legal_unit;
	SELF.legacl_city             := L.legacl_city;
	SELF.legal_subdivision       := L.legal_subdivision;
	SELF.legal_phase_num         := L.legal_phase_num;
	SELF.legal_tract_num         := L.legal_tract_num;
	SELF.legal_brief_desc        := ut.CleanSpacesAndUpper(L.legal_brief_desc);
	SELF.Legal_Township          := L.Legal_Township;
	SELF.recorder_map_ref        := L.recorder_map_ref;
	SELF.prop_buyer_mail_addr_cd := L.prop_buyer_mail_addr_cd;
	SELF.property_use_cd         := L.property_use_cd;
	SELF.orig_contract_date      := L.orig_contract_date;
	SELF.sales_price             := L.sales_price;
	SELF.sales_price_cd          := L.sales_price_cd;
	SELF.city_xfer_tax           := L.city_xfer_tax;
	SELF.county_xfer_tax         := L.county_xfer_tax;
	SELF.total_xfer_tax          := L.total_xfer_tax;
	SELF.concurrent_lender_name  := ut.CleanSpacesAndUpper(L.concurrent_lender_name);
	SELF.concurrent_lender_type  := L.concurrent_lender_type;
	SELF.concurrent_loan_amt     := L.concurrent_loan_amt;
	SELF.concurrent_loan_type    := L.concurrent_loan_type;
	SELF.concurrent_type_fin     := L.concurrent_type_fin;
	SELF.concurrent_interest_rate:= L.concurrent_interest_rate;
	SELF.concurrent_due_dt       := L.concurrent_due_dt;
	SELF.concurrent_2nd_loan_amt := L.concurrent_2nd_loan_amt;
	SELF.buyer_mail_full_addr    := ut.CleanSpacesAndUpper(L.buyer_mail_full_addr);
	SELF.buyer_mail_unit_type    := L.buyer_mail_unit_type;
	SELF.buyer_mail_unit_no      := L.buyer_mail_unit_no;
	SELF.lps_internal_pid        := L.lps_internal_pid;
	SELF.buyer_mail_careof       := L.buyer_mail_careof;
	SELF.title_co_name           := ut.CleanSpacesAndUpper(L.title_co_name);
	SELF.legal_desc_cd           := L.legal_desc_cd;
	SELF.adj_rate_rider          := L.adj_rate_rider;
	SELF.adj_rate_index          := L.adj_rate_index;
	SELF.change_index            := L.change_index;
	SELF.rate_change_freq        := L.rate_change_freq;
	SELF.int_rate_ngt            := L.int_rate_ngt;
	SELF.int_rate_nlt            := L.int_rate_nlt;
	SELF.max_int_rate            := L.max_int_rate;
	SELF.int_only_period         := L.int_only_period;
	SELF.fixed_rate_rider        := L.fixed_rate_rider;
	SELF.first_chg_dt_yy         := L.first_chg_dt_yy;
	SELF.first_chg_dt_mmdd       := L.first_chg_dt_mmdd;
	SELF.prepayment_rider        := L.prepayment_rider;
	SELF.prepayment_term         := L.prepayment_term;
	SELF.asses_land_use          := L.asses_land_use;
	SELF.res_indicator           := L.res_indicator;
	SELF.construction_loan       := L.construction_loan;
	SELF.inter_family            := L.inter_family;
	SELF.cash_purchase           := L.cash_purchase;
	SELF.stand_alone_refi        := L.stand_alone_refi;
	SELF.equity_credit_line      := L.equity_credit_line;
	SELF.reo_flag                := L.reo_flag;
	SELF.DistressedSaleFlag      := L.DistressedSaleFlag;
	SELF := L;
	SELF := [];
END;

 Reo_Clean_In := project(ClnRawReoIn,CleanTrimReo(left,counter));
 
RETURN Reo_Clean_in;

END;
	

	

	
