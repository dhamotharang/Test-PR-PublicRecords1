IMPORT SALT311,STD;
EXPORT Delta(DATASET(Layout_BKForeclosure_Nod)old_s, DATASET(Layout_BKForeclosure_Nod) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['foreclosure_id','ln_filedate','bk_infile_type','src_county','src_state','fips_cd','doc_type','recording_dt','recording_doc_num','book_number','page_number','loan_number','trustee_sale_number','case_number','orig_contract_date','unpaid_balance','past_due_amt','as_of_dt','contact_fname','contact_lname','attention_to','contact_mail_full_addr','contact_mail_unit','contact_mail_city','contact_mail_state','contact_mail_zip5','contact_mail_zip4','contact_telephone','due_date','trustee_fname','trustee_lname','trustee_mail_full_addr','trustee_mail_unit','trustee_mail_city','trustee_mail_state','trustee_mail_zip5','trustee_mail_zip4','trustee_telephone','borrower1_fname','borrower1_lname','borrower1_id_cd','borrower2_fname','borrower2_lname','borrower2_id_cd','orig_lender_name','orig_lender_type','curr_lender_name','curr_lender_type','mers_indicator','loan_recording_date','loan_doc_num','loan_book','loan_page','orig_loan_amt','legal_lot_num','legal_block','legal_subdivision_name','legal_brief_desc','auction_date','auction_time','auction_location','auction_min_bid_amt','trustee_mail_careof','property_addr_cd','auction_city','original_nod_recording_date','original_nod_doc_num','original_nod_book','original_nod_page','nod_apn','property_full_addr','prop_addr_unit_type','prop_addr_unit_no','prop_addr_city','prop_addr_state','prop_addr_zip5','prop_addr_zip4','apn','sam_pid','deed_pid','lps_internal_pid','nod_source'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := hygiene(old_s).Summary('Old') + hygiene(new_s).Summary('New') + hygiene(PROJECT(Differences(deleted), TRANSFORM(Layout_BKForeclosure_Nod, SELF := LEFT.old_rec))).Summary('Deletions') + hygiene(PROJECT(Differences(added), TRANSFORM(Layout_BKForeclosure_Nod, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_BKForeclosure_Nod, Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
