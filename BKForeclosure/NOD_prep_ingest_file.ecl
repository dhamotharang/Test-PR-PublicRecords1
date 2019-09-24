IMPORT BKForeclosure, MDR, PRTE2, ut, STD;

EXPORT NOD_prep_ingest_file := FUNCTION

	  //Project to base layout for ingest
fIn_Raw_Nod   := BKForeclosure.File_BK_Foreclosure.Nod_File;

prte2.CleanFields(fIn_Raw_Nod, ClnRawNodIn); //using PRTE2 clean function as it cleans unprintable characters and uppercases output

BKForeclosure.Layout_BK.base_nod_ext CleanTrimNod(ClnRawNodIn L, seqNum) := TRANSFORM
	SELF.DATE_FIRST_SEEN						:= thorlib.wuid()[2..9];
	SELF.DATE_LAST_SEEN							:= thorlib.wuid()[2..9];
	SELF.DATE_VENDOR_FIRST_REPORTED := L.ln_filedate;
	SELF.DATE_VENDOR_LAST_REPORTED	:= L.ln_filedate;
	SELF.PROCESS_DATE						 := thorlib.wuid()[2..9];
	SELF.src  									 := mdr.sourceTools.src_BKFS_Nod;
	ClnAPN											 := REGEXREPLACE('(\\+|`|~|;)',L.APN,'');
	SELF.foreclosure_id					 :=	IF(L.APN <> '',
																		 StringLib.StringFindReplace(TRIM(ClnAPN,LEFT,RIGHT) + TRIM(L.borrower1_lname,LEFT,RIGHT) + TRIM(L.borrower1_fname,LEFT,RIGHT), ' ', ''),
																		 StringLib.StringFindReplace('FC' + INTFORMAT(seqNum, 8, 1) + TRIM(L.borrower1_lname,LEFT,RIGHT) + TRIM(L.borrower1_fname,LEFT,RIGHT), ' ', '')																
																		);
 	SELF.src_county          := ut.CleanSpacesAndUpper(L.src_county);
	SELF.src_state           := ut.CleanSpacesAndUpper(L.src_state);
	SELF.fips_cd             := ut.CleanSpacesAndUpper(L.fips_cd);
	SELF.doc_type            := ut.CleanSpacesAndUpper(L.doc_type);
	SELF.recording_dt        := ut.CleanSpacesAndUpper(L.recording_dt);
	SELF.recording_doc_num   := ut.CleanSpacesAndUpper(L.recording_doc_num);
	SELF.book_number         := ut.CleanSpacesAndUpper(L.book_number);
	SELF.page_number         := ut.CleanSpacesAndUpper(L.page_number);
	SELF.loan_number         := ut.CleanSpacesAndUpper(L.loan_number);
	SELF.trustee_sale_number := ut.CleanSpacesAndUpper(L.trustee_sale_number);
	SELF.case_number         := ut.CleanSpacesAndUpper(L.case_number);
	SELF.orig_contract_date  := ut.CleanSpacesAndUpper(L.orig_contract_date);
	SELF.unpaid_balance      := ut.CleanSpacesAndUpper(L.unpaid_balance);
	SELF.past_due_amt        := ut.CleanSpacesAndUpper(L.past_due_amt);
	SELF.as_of_dt            := ut.CleanSpacesAndUpper(L.as_of_dt);
	SELF.contact_Fname       := ut.CleanSpacesAndUpper(L.contact_Fname);
	SELF.contact_Lname       := ut.CleanSpacesAndUpper(L.contact_Lname);
	SELF.attention_to        := ut.CleanSpacesAndUpper(L.attention_to);
	SELF.contact_mail_full_addr := ut.CleanSpacesAndUpper(L.contact_mail_full_addr);
	SELF.contact_mail_unit   := ut.CleanSpacesAndUpper(L.contact_mail_unit);
	SELF.contact_mail_city   := ut.CleanSpacesAndUpper(L.contact_mail_city);
	SELF.contact_mail_state  := ut.CleanSpacesAndUpper(L.contact_mail_state);
	SELF.contact_mail_zip5   := ut.CleanSpacesAndUpper(L.contact_mail_zip5);
	SELF.contact_mail_zip4   := ut.CleanSpacesAndUpper(L.contact_mail_zip4);
	SELF.contact_telephone   := ut.CleanPhone(L.contact_telephone);
	SELF.due_date            := ut.CleanSpacesAndUpper(L.due_date);
	SELF.trustee_fname       := ut.CleanSpacesAndUpper(L.trustee_fname);
	SELF.trustee_lname       := ut.CleanSpacesAndUpper(L.trustee_lname);
	SELF.trustee_mail_full_addr := ut.CleanSpacesAndUpper(REGEXREPLACE('([`]$|^[`])',L.trustee_mail_full_addr,''));
	SELF.trustee_mail_unit   := ut.CleanSpacesAndUpper(L.trustee_mail_unit);
	SELF.trustee_mail_city   := ut.CleanSpacesAndUpper(L.trustee_mail_city);
	SELF.trustee_mail_state  := ut.CleanSpacesAndUpper(L.trustee_mail_state);
	SELF.trustee_mail_zip5   := ut.CleanSpacesAndUpper(L.trustee_mail_zip5);
	SELF.trustee_mail_zip4   := ut.CleanSpacesAndUpper(L.trustee_mail_zip4);
	SELF.trustee_telephone   := ut.CleanPhone(L.trustee_telephone);
	SELF.borrower1_fname     := ut.CleanSpacesAndUpper(L.borrower1_fname);
	SELF.borrower1_lname     := ut.CleanSpacesAndUpper(REGEXREPLACE('[$]$',L.borrower1_lname,''));
	SELF.borrower1_id_cd     := ut.CleanSpacesAndUpper(L.borrower1_id_cd);
	SELF.borrower2_fname     := ut.CleanSpacesAndUpper(L.borrower2_fname);
	SELF.borrower2_lname     := ut.CleanSpacesAndUpper(REGEXREPLACE('[$]$',L.borrower1_lname,''));
	SELF.borrower2_id_cd     := ut.CleanSpacesAndUpper(L.borrower2_id_cd);
	SELF.orig_lender_name    := ut.CleanSpacesAndUpper(L.orig_lender_name);
	SELF.orig_lender_type    := ut.CleanSpacesAndUpper(L.orig_lender_type);
	SELF.curr_lender_name    := ut.CleanSpacesAndUpper(L.curr_lender_name);
	SELF.curr_lender_type    := ut.CleanSpacesAndUpper(L.curr_lender_type);
	SELF.mers_indicator      := ut.CleanSpacesAndUpper(L.mers_indicator);
	SELF.loan_recording_date := ut.CleanSpacesAndUpper(L.loan_recording_date);
	SELF.loan_doc_num        := ut.CleanSpacesAndUpper(L.loan_doc_num);
	SELF.loan_book           := ut.CleanSpacesAndUpper(L.loan_book);
	SELF.loan_page           := ut.CleanSpacesAndUpper(L.loan_page);
	SELF.orig_loan_amt       := ut.CleanSpacesAndUpper(L.orig_loan_amt);
	SELF.legal_lot_num       := ut.CleanSpacesAndUpper(L.legal_lot_num);
	SELF.legal_block         := ut.CleanSpacesAndUpper(L.legal_block);
	SELF.legal_subdivision_name := ut.CleanSpacesAndUpper(L.legal_subdivision_name);
	SELF.legal_brief_desc    := ut.CleanSpacesAndUpper(L.legal_brief_desc);
	SELF.auction_date        := L.auction_date;
	SELF.auction_time        := L.auction_time;
	SELF.auction_location    := ut.CleanSpacesAndUpper(L.auction_location);
	SELF.auction_min_bid_amt := ut.CleanSpacesAndUpper(L.auction_min_bid_amt);
	SELF.trustee_mail_careof := ut.CleanSpacesAndUpper(L.trustee_mail_careof);
	SELF.property_addr_cd    := ut.CleanSpacesAndUpper(L.property_addr_cd);
	SELF.auction_city        := ut.CleanSpacesAndUpper(L.auction_city);
	SELF.original_nod_recording_date:= ut.CleanSpacesAndUpper(L.original_nod_recording_date);
	SELF.original_nod_doc_num:= ut.CleanSpacesAndUpper(L.original_nod_doc_num);
	SELF.original_nod_book   := ut.CleanSpacesAndUpper(L.original_nod_book);
	SELF.original_nod_page   := ut.CleanSpacesAndUpper(L.original_nod_page);
	SELF.nod_apn             := STD.Str.CleanSpaces(REGEXREPLACE('(\\+|`|~)',L.nod_apn,''));
	SELF.property_full_addr  := ut.CleanSpacesAndUpper(REGEXREPLACE('[`]$',L.property_full_addr,''));
	SELF.prop_addr_unit_type := ut.CleanSpacesAndUpper(L.prop_addr_unit_type);
	SELF.prop_addr_unit_no   := ut.CleanSpacesAndUpper(L.prop_addr_unit_no);
	SELF.prop_addr_city      := ut.CleanSpacesAndUpper(L.prop_addr_city);
	SELF.prop_addr_state     := ut.CleanSpacesAndUpper(L.prop_addr_state);
	SELF.prop_addr_zip5      := L.prop_addr_zip5;
	SELF.prop_addr_zip4      := L.prop_addr_zip4;
	SELF.APN                 := STD.Str.CleanSpaces(ClnAPN);
	SELF.sam_pid             := L.sam_pid;
	SELF.deed_pid            := L.deed_pid;
	SELF.lps_internal_pid    := ut.CleanSpacesAndUpper(L.lps_internal_pid);
	SELF.nod_source          := ut.CleanSpacesAndUpper(L.nod_source);
	SELF := L;
	SELF := [];
END;

Nod_Clean_In := PROJECT(ClnRawNodIn,CleanTrimNod(LEFT,COUNTER));

RETURN Nod_Clean_In;

END;