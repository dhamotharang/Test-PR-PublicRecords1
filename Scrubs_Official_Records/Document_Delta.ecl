IMPORT SALT311,STD;
EXPORT Document_Delta(DATASET(Document_Layout_Official_Records)old_s, DATASET(Document_Layout_Official_Records) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['process_date','vendor','state_origin','county_name','official_record_key','fips_st','fips_county','batch_id','doc_serial_num','doc_instrument_or_clerk_filing_num','doc_num_dummy_flag','doc_filed_dt','doc_record_dt','doc_type_cd','doc_type_desc','doc_other_desc','doc_page_count','doc_names_count','doc_status_cd','doc_status_desc','doc_amend_cd','doc_amend_desc','execution_dt','consideration_amt','assumption_amt','certified_mail_fee','service_charge','trust_amt','transfer_','mortgage','intangible_tax_amt','intangible_tax_penalty','excise_tax_amt','recording_fee','documentary_stamps_fee','doc_stamps_mtg_fee','book_num','page_num','book_type_cd','book_type_desc','parcel_or_case_num','formatted_parcel_num','legal_desc_1','legal_desc_2','legal_desc_3','legal_desc_4','legal_desc_5','verified_flag','address_1','address_2','address_3','address_4','prior_doc_file_num','prior_doc_type_cd','prior_doc_type_desc','prior_book_num','prior_page_num','prior_book_type_cd','prior_book_type_desc','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','rec_type','ace_fips_st','ace_fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := Document_hygiene(old_s).Summary('Old') + Document_hygiene(new_s).Summary('New') + Document_hygiene(PROJECT(Differences(deleted), TRANSFORM(Document_Layout_Official_Records, SELF := LEFT.old_rec))).Summary('Deletions') + Document_hygiene(PROJECT(Differences(added), TRANSFORM(Document_Layout_Official_Records, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Official_Records, Document_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
