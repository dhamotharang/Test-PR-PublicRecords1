// This is a super-sloppy match which is then scored and graded.
// Designed to let you know where the underlinks are lurking
IMPORT InsuranceHeader_Property_Transactions_DeedsMortgages; // Import modules for  attribute definitions
IMPORT SALT34,ut,std;
EXPORT Underlinks(DATASET(layout_PROPERTY_TRANSACTION) ih,UNSIGNED MatchThreshold = Config.MatchThreshold) := MODULE
SHARED LowerMatchThreshold := MatchThreshold-6; // Consider up to Threshold - 6
SHARED h := match_candidates(ih).candidates;
SHARED s := Specificities(ih).Specificities[1];
  dt := debug(ih,s,MatchThreshold).sample_match_join;
  RawResults := matches(ih,MatchThreshold).MAC_DoJoins(h,dt);
EXPORT RRF := RawResults(Conf>=LowerMatchThreshold);
  R := RECORD
    TotalCnt := COUNT(GROUP);
    recording_date_skipped := COUNT(GROUP,RRF.recording_date_skipped);
    recording_date_skipped_pcnt := AVE(GROUP,IF(RRF.recording_date_skipped,100,0));
    SourceType_skipped := COUNT(GROUP,RRF.SourceType_skipped);
    SourceType_skipped_pcnt := AVE(GROUP,IF(RRF.SourceType_skipped,100,0));
    zip_skipped := COUNT(GROUP,RRF.zip_skipped);
    zip_skipped_pcnt := AVE(GROUP,IF(RRF.zip_skipped,100,0));
    sales_price_skipped := COUNT(GROUP,RRF.sales_price_skipped);
    sales_price_skipped_pcnt := AVE(GROUP,IF(RRF.sales_price_skipped,100,0));
    first_td_loan_amount_skipped := COUNT(GROUP,RRF.first_td_loan_amount_skipped);
    first_td_loan_amount_skipped_pcnt := AVE(GROUP,IF(RRF.first_td_loan_amount_skipped,100,0));
    contract_date_skipped := COUNT(GROUP,RRF.contract_date_skipped);
    contract_date_skipped_pcnt := AVE(GROUP,IF(RRF.contract_date_skipped,100,0));
    recorder_page_number_skipped := COUNT(GROUP,RRF.recorder_page_number_skipped);
    recorder_page_number_skipped_pcnt := AVE(GROUP,IF(RRF.recorder_page_number_skipped,100,0));
    sec_range_alpha_skipped := COUNT(GROUP,RRF.sec_range_alpha_skipped);
    sec_range_alpha_skipped_pcnt := AVE(GROUP,IF(RRF.sec_range_alpha_skipped,100,0));
    prim_name_num_skipped := COUNT(GROUP,RRF.prim_name_num_skipped);
    prim_name_num_skipped_pcnt := AVE(GROUP,IF(RRF.prim_name_num_skipped,100,0));
    prim_name_alpha_skipped := COUNT(GROUP,RRF.prim_name_alpha_skipped);
    prim_name_alpha_skipped_pcnt := AVE(GROUP,IF(RRF.prim_name_alpha_skipped,100,0));
    sec_range_num_skipped := COUNT(GROUP,RRF.sec_range_num_skipped);
    sec_range_num_skipped_pcnt := AVE(GROUP,IF(RRF.sec_range_num_skipped,100,0));
    prim_range_num_skipped := COUNT(GROUP,RRF.prim_range_num_skipped);
    prim_range_num_skipped_pcnt := AVE(GROUP,IF(RRF.prim_range_num_skipped,100,0));
    address_skipped := COUNT(GROUP,RRF.address_skipped);
    address_skipped_pcnt := AVE(GROUP,IF(RRF.address_skipped,100,0));
  END;
EXPORT ForceFails := TABLE(RRF,R);
  ds := RRF;
  R := RECORD
    ds;
    SALT34.StrType Summary;
  END;
  R tosummary(ds le) := TRANSFORM
    SELF := le;
    SELF.Summary := IF(le.recording_date_Score = 0,'','|'+IF(le.recording_date_Score < 0,'-','')+'recording_date')+IF(le.SourceType_Score = 0,'','|'+IF(le.SourceType_Score < 0,'-','')+'SourceType')+IF(le.did_Score = 0,'','|'+IF(le.did_Score < 0,'-','')+'did')+IF(le.apnt_or_pin_number_Score = 0,'','|'+IF(le.apnt_or_pin_number_Score < 0,'-','')+'apnt_or_pin_number')+IF(le.recorder_book_number_Score = 0,'','|'+IF(le.recorder_book_number_Score < 0,'-','')+'recorder_book_number')+IF(le.primname_Score = 0,'','|'+IF(le.primname_Score < 0,'-','')+'primname')+IF(le.zip_Score = 0,'','|'+IF(le.zip_Score < 0,'-','')+'zip')+IF(le.sales_price_Score = 0,'','|'+IF(le.sales_price_Score < 0,'-','')+'sales_price')+IF(le.first_td_loan_amount_Score = 0,'','|'+IF(le.first_td_loan_amount_Score < 0,'-','')+'first_td_loan_amount')+IF(le.primrange_Score = 0,'','|'+IF(le.primrange_Score < 0,'-','')+'primrange')+IF(le.secrange_Score = 0,'','|'+IF(le.secrange_Score < 0,'-','')+'secrange')+IF(le.contract_date_Score = 0,'','|'+IF(le.contract_date_Score < 0,'-','')+'contract_date')+IF(le.document_number_Score = 0,'','|'+IF(le.document_number_Score < 0,'-','')+'document_number')+IF(le.recorder_page_number_Score = 0,'','|'+IF(le.recorder_page_number_Score < 0,'-','')+'recorder_page_number')+IF(le.prim_range_alpha_Score = 0,'','|'+IF(le.prim_range_alpha_Score < 0,'-','')+'prim_range_alpha')+IF(le.sec_range_alpha_Score = 0,'','|'+IF(le.sec_range_alpha_Score < 0,'-','')+'sec_range_alpha')+IF(le.name_Score = 0,'','|'+IF(le.name_Score < 0,'-','')+'name')+IF(le.prim_name_num_Score = 0,'','|'+IF(le.prim_name_num_Score < 0,'-','')+'prim_name_num')+IF(le.prim_name_alpha_Score = 0,'','|'+IF(le.prim_name_alpha_Score < 0,'-','')+'prim_name_alpha')+IF(le.sec_range_num_Score = 0,'','|'+IF(le.sec_range_num_Score < 0,'-','')+'sec_range_num')+IF(le.fips_code_Score = 0,'','|'+IF(le.fips_code_Score < 0,'-','')+'fips_code')+IF(le.county_name_Score = 0,'','|'+IF(le.county_name_Score < 0,'-','')+'county_name')+IF(le.lender_name_Score = 0,'','|'+IF(le.lender_name_Score < 0,'-','')+'lender_name')+IF(le.prim_range_num_Score = 0,'','|'+IF(le.prim_range_num_Score < 0,'-','')+'prim_range_num')+IF(le.city_Score = 0,'','|'+IF(le.city_Score < 0,'-','')+'city')+IF(le.st_Score = 0,'','|'+IF(le.st_Score < 0,'-','')+'st')+IF(le.locale_Score = 0,'','|'+IF(le.locale_Score < 0,'-','')+'locale')+IF(le.address_Score = 0,'','|'+IF(le.address_Score < 0,'-','')+'address');
  END;
  P := PROJECT(ds,tosummary(LEFT));
EXPORT Annotated := P;
EXPORT FieldMatches := SORT(TABLE(Annotated,{Summary,Cnt := COUNT(GROUP)},Summary,FEW),-Cnt);
END;
