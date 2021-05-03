IMPORT SALT311,STD;
EXPORT Scrubs := MODULE

// The module to handle the case where no scrubs exist
  EXPORT NumRules := 288;
  EXPORT NumRulesFromFieldType := 288;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 72;
  EXPORT NumFieldsWithPossibleEdits := 72;
  EXPORT NumRulesWithPossibleEdits := 288;
  EXPORT Expanded_Layout := RECORD(Layout_File)
    UNSIGNED1 seq_rec_id_Invalid;
    BOOLEAN seq_rec_id_wouldClean;
    UNSIGNED1 did_Invalid;
    BOOLEAN did_wouldClean;
    UNSIGNED1 did_score_field_Invalid;
    BOOLEAN did_score_field_wouldClean;
    UNSIGNED1 current_rec_flag_Invalid;
    BOOLEAN current_rec_flag_wouldClean;
    UNSIGNED1 current_experian_pin_Invalid;
    BOOLEAN current_experian_pin_wouldClean;
    UNSIGNED1 date_first_seen_Invalid;
    BOOLEAN date_first_seen_wouldClean;
    UNSIGNED1 date_last_seen_Invalid;
    BOOLEAN date_last_seen_wouldClean;
    UNSIGNED1 date_vendor_first_reported_Invalid;
    BOOLEAN date_vendor_first_reported_wouldClean;
    UNSIGNED1 date_vendor_last_reported_Invalid;
    BOOLEAN date_vendor_last_reported_wouldClean;
    UNSIGNED1 encrypted_experian_pin_Invalid;
    BOOLEAN encrypted_experian_pin_wouldClean;
    UNSIGNED1 social_security_number_Invalid;
    BOOLEAN social_security_number_wouldClean;
    UNSIGNED1 date_of_birth_Invalid;
    BOOLEAN date_of_birth_wouldClean;
    UNSIGNED1 telephone_Invalid;
    BOOLEAN telephone_wouldClean;
    UNSIGNED1 gender_Invalid;
    BOOLEAN gender_wouldClean;
    UNSIGNED1 additional_name_count_Invalid;
    BOOLEAN additional_name_count_wouldClean;
    UNSIGNED1 previous_address_count_Invalid;
    BOOLEAN previous_address_count_wouldClean;
    UNSIGNED1 nametype_Invalid;
    BOOLEAN nametype_wouldClean;
    UNSIGNED1 orig_consumer_create_date_Invalid;
    BOOLEAN orig_consumer_create_date_wouldClean;
    UNSIGNED1 orig_fname_Invalid;
    BOOLEAN orig_fname_wouldClean;
    UNSIGNED1 orig_mname_Invalid;
    BOOLEAN orig_mname_wouldClean;
    UNSIGNED1 orig_lname_Invalid;
    BOOLEAN orig_lname_wouldClean;
    UNSIGNED1 orig_suffix_Invalid;
    BOOLEAN orig_suffix_wouldClean;
    UNSIGNED1 title_Invalid;
    BOOLEAN title_wouldClean;
    UNSIGNED1 fname_Invalid;
    BOOLEAN fname_wouldClean;
    UNSIGNED1 mname_Invalid;
    BOOLEAN mname_wouldClean;
    UNSIGNED1 lname_Invalid;
    BOOLEAN lname_wouldClean;
    UNSIGNED1 name_suffix_Invalid;
    BOOLEAN name_suffix_wouldClean;
    UNSIGNED1 name_score_Invalid;
    BOOLEAN name_score_wouldClean;
    UNSIGNED1 addressseq_Invalid;
    BOOLEAN addressseq_wouldClean;
    UNSIGNED1 orig_address_create_date_Invalid;
    BOOLEAN orig_address_create_date_wouldClean;
    UNSIGNED1 orig_address_update_date_Invalid;
    BOOLEAN orig_address_update_date_wouldClean;
    UNSIGNED1 orig_prim_range_Invalid;
    BOOLEAN orig_prim_range_wouldClean;
    UNSIGNED1 orig_predir_Invalid;
    BOOLEAN orig_predir_wouldClean;
    UNSIGNED1 orig_prim_name_Invalid;
    BOOLEAN orig_prim_name_wouldClean;
    UNSIGNED1 orig_addr_suffix_Invalid;
    BOOLEAN orig_addr_suffix_wouldClean;
    UNSIGNED1 orig_postdir_Invalid;
    BOOLEAN orig_postdir_wouldClean;
    UNSIGNED1 orig_unit_desig_Invalid;
    BOOLEAN orig_unit_desig_wouldClean;
    UNSIGNED1 orig_sec_range_Invalid;
    BOOLEAN orig_sec_range_wouldClean;
    UNSIGNED1 orig_city_Invalid;
    BOOLEAN orig_city_wouldClean;
    UNSIGNED1 orig_state_Invalid;
    BOOLEAN orig_state_wouldClean;
    UNSIGNED1 orig_zipcode_Invalid;
    BOOLEAN orig_zipcode_wouldClean;
    UNSIGNED1 orig_zipcode4_Invalid;
    BOOLEAN orig_zipcode4_wouldClean;
    UNSIGNED1 prim_range_Invalid;
    BOOLEAN prim_range_wouldClean;
    UNSIGNED1 predir_Invalid;
    BOOLEAN predir_wouldClean;
    UNSIGNED1 prim_name_Invalid;
    BOOLEAN prim_name_wouldClean;
    UNSIGNED1 addr_suffix_Invalid;
    BOOLEAN addr_suffix_wouldClean;
    UNSIGNED1 postdir_Invalid;
    BOOLEAN postdir_wouldClean;
    UNSIGNED1 unit_desig_Invalid;
    BOOLEAN unit_desig_wouldClean;
    UNSIGNED1 sec_range_Invalid;
    BOOLEAN sec_range_wouldClean;
    UNSIGNED1 p_city_name_Invalid;
    BOOLEAN p_city_name_wouldClean;
    UNSIGNED1 v_city_name_Invalid;
    BOOLEAN v_city_name_wouldClean;
    UNSIGNED1 st_Invalid;
    BOOLEAN st_wouldClean;
    UNSIGNED1 zip_Invalid;
    BOOLEAN zip_wouldClean;
    UNSIGNED1 zip4_Invalid;
    BOOLEAN zip4_wouldClean;
    UNSIGNED1 cart_Invalid;
    BOOLEAN cart_wouldClean;
    UNSIGNED1 cr_sort_sz_Invalid;
    BOOLEAN cr_sort_sz_wouldClean;
    UNSIGNED1 lot_Invalid;
    BOOLEAN lot_wouldClean;
    UNSIGNED1 lot_order_Invalid;
    BOOLEAN lot_order_wouldClean;
    UNSIGNED1 dbpc_Invalid;
    BOOLEAN dbpc_wouldClean;
    UNSIGNED1 chk_digit_Invalid;
    BOOLEAN chk_digit_wouldClean;
    UNSIGNED1 rec_type_Invalid;
    BOOLEAN rec_type_wouldClean;
    UNSIGNED1 county_Invalid;
    BOOLEAN county_wouldClean;
    UNSIGNED1 geo_lat_Invalid;
    BOOLEAN geo_lat_wouldClean;
    UNSIGNED1 geo_long_Invalid;
    BOOLEAN geo_long_wouldClean;
    UNSIGNED1 msa_Invalid;
    BOOLEAN msa_wouldClean;
    UNSIGNED1 geo_blk_Invalid;
    BOOLEAN geo_blk_wouldClean;
    UNSIGNED1 geo_match_Invalid;
    BOOLEAN geo_match_wouldClean;
    UNSIGNED1 err_stat_Invalid;
    BOOLEAN err_stat_wouldClean;
    UNSIGNED1 delete_flag_Invalid;
    BOOLEAN delete_flag_wouldClean;
    UNSIGNED1 delete_file_date_Invalid;
    BOOLEAN delete_file_date_wouldClean;
    UNSIGNED1 suppression_code_Invalid;
    BOOLEAN suppression_code_wouldClean;
    UNSIGNED1 deceased_ind_Invalid;
    BOOLEAN deceased_ind_wouldClean;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_File)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsBits2;
    UNSIGNED8 ScrubsBits3;
    UNSIGNED8 ScrubsBits4;
    UNSIGNED8 ScrubsCleanBits1;
    UNSIGNED8 ScrubsCleanBits2;
  END;
  EXPORT Rule_Layout := RECORD(Layout_File)
    STRING Rules {MAXLENGTH(1000)};
  END;
  SHARED toRuleDesc(UNSIGNED c) := CHOOSE(c
          ,'seq_rec_id:seq_rec_id:LEFTTRIM','seq_rec_id:seq_rec_id:ALLOW','seq_rec_id:seq_rec_id:LENGTHS','seq_rec_id:seq_rec_id:WORDS'
          ,'did:did:LEFTTRIM','did:did:ALLOW','did:did:LENGTHS','did:did:WORDS'
          ,'did_score_field:did_score_field:LEFTTRIM','did_score_field:did_score_field:ALLOW','did_score_field:did_score_field:LENGTHS','did_score_field:did_score_field:WORDS'
          ,'current_rec_flag:current_rec_flag:LEFTTRIM','current_rec_flag:current_rec_flag:ALLOW','current_rec_flag:current_rec_flag:LENGTHS','current_rec_flag:current_rec_flag:WORDS'
          ,'current_experian_pin:current_experian_pin:LEFTTRIM','current_experian_pin:current_experian_pin:ALLOW','current_experian_pin:current_experian_pin:LENGTHS','current_experian_pin:current_experian_pin:WORDS'
          ,'date_first_seen:date_first_seen:LEFTTRIM','date_first_seen:date_first_seen:ALLOW','date_first_seen:date_first_seen:LENGTHS','date_first_seen:date_first_seen:WORDS'
          ,'date_last_seen:date_last_seen:LEFTTRIM','date_last_seen:date_last_seen:ALLOW','date_last_seen:date_last_seen:LENGTHS','date_last_seen:date_last_seen:WORDS'
          ,'date_vendor_first_reported:date_vendor_first_reported:LEFTTRIM','date_vendor_first_reported:date_vendor_first_reported:ALLOW','date_vendor_first_reported:date_vendor_first_reported:LENGTHS','date_vendor_first_reported:date_vendor_first_reported:WORDS'
          ,'date_vendor_last_reported:date_vendor_last_reported:LEFTTRIM','date_vendor_last_reported:date_vendor_last_reported:ALLOW','date_vendor_last_reported:date_vendor_last_reported:LENGTHS','date_vendor_last_reported:date_vendor_last_reported:WORDS'
          ,'encrypted_experian_pin:encrypted_experian_pin:LEFTTRIM','encrypted_experian_pin:encrypted_experian_pin:ALLOW','encrypted_experian_pin:encrypted_experian_pin:LENGTHS','encrypted_experian_pin:encrypted_experian_pin:WORDS'
          ,'social_security_number:social_security_number:LEFTTRIM','social_security_number:social_security_number:ALLOW','social_security_number:social_security_number:LENGTHS','social_security_number:social_security_number:WORDS'
          ,'date_of_birth:date_of_birth:LEFTTRIM','date_of_birth:date_of_birth:ALLOW','date_of_birth:date_of_birth:LENGTHS','date_of_birth:date_of_birth:WORDS'
          ,'telephone:telephone:LEFTTRIM','telephone:telephone:ALLOW','telephone:telephone:LENGTHS','telephone:telephone:WORDS'
          ,'gender:gender:LEFTTRIM','gender:gender:ALLOW','gender:gender:LENGTHS','gender:gender:WORDS'
          ,'additional_name_count:additional_name_count:LEFTTRIM','additional_name_count:additional_name_count:ALLOW','additional_name_count:additional_name_count:LENGTHS','additional_name_count:additional_name_count:WORDS'
          ,'previous_address_count:previous_address_count:LEFTTRIM','previous_address_count:previous_address_count:ALLOW','previous_address_count:previous_address_count:LENGTHS','previous_address_count:previous_address_count:WORDS'
          ,'nametype:nametype:LEFTTRIM','nametype:nametype:ALLOW','nametype:nametype:LENGTHS','nametype:nametype:WORDS'
          ,'orig_consumer_create_date:orig_consumer_create_date:LEFTTRIM','orig_consumer_create_date:orig_consumer_create_date:ALLOW','orig_consumer_create_date:orig_consumer_create_date:LENGTHS','orig_consumer_create_date:orig_consumer_create_date:WORDS'
          ,'orig_fname:orig_fname:LEFTTRIM','orig_fname:orig_fname:ALLOW','orig_fname:orig_fname:LENGTHS','orig_fname:orig_fname:WORDS'
          ,'orig_mname:orig_mname:LEFTTRIM','orig_mname:orig_mname:ALLOW','orig_mname:orig_mname:LENGTHS','orig_mname:orig_mname:WORDS'
          ,'orig_lname:orig_lname:LEFTTRIM','orig_lname:orig_lname:ALLOW','orig_lname:orig_lname:LENGTHS','orig_lname:orig_lname:WORDS'
          ,'orig_suffix:orig_suffix:LEFTTRIM','orig_suffix:orig_suffix:ALLOW','orig_suffix:orig_suffix:LENGTHS','orig_suffix:orig_suffix:WORDS'
          ,'title:title:LEFTTRIM','title:title:ALLOW','title:title:LENGTHS','title:title:WORDS'
          ,'fname:fname:LEFTTRIM','fname:fname:ALLOW','fname:fname:LENGTHS','fname:fname:WORDS'
          ,'mname:mname:LEFTTRIM','mname:mname:ALLOW','mname:mname:LENGTHS','mname:mname:WORDS'
          ,'lname:lname:LEFTTRIM','lname:lname:ALLOW','lname:lname:LENGTHS','lname:lname:WORDS'
          ,'name_suffix:name_suffix:LEFTTRIM','name_suffix:name_suffix:ALLOW','name_suffix:name_suffix:LENGTHS','name_suffix:name_suffix:WORDS'
          ,'name_score:name_score:LEFTTRIM','name_score:name_score:ALLOW','name_score:name_score:LENGTHS','name_score:name_score:WORDS'
          ,'addressseq:addressseq:LEFTTRIM','addressseq:addressseq:ALLOW','addressseq:addressseq:LENGTHS','addressseq:addressseq:WORDS'
          ,'orig_address_create_date:orig_address_create_date:LEFTTRIM','orig_address_create_date:orig_address_create_date:ALLOW','orig_address_create_date:orig_address_create_date:LENGTHS','orig_address_create_date:orig_address_create_date:WORDS'
          ,'orig_address_update_date:orig_address_update_date:LEFTTRIM','orig_address_update_date:orig_address_update_date:ALLOW','orig_address_update_date:orig_address_update_date:LENGTHS','orig_address_update_date:orig_address_update_date:WORDS'
          ,'orig_prim_range:orig_prim_range:LEFTTRIM','orig_prim_range:orig_prim_range:ALLOW','orig_prim_range:orig_prim_range:LENGTHS','orig_prim_range:orig_prim_range:WORDS'
          ,'orig_predir:orig_predir:LEFTTRIM','orig_predir:orig_predir:ALLOW','orig_predir:orig_predir:LENGTHS','orig_predir:orig_predir:WORDS'
          ,'orig_prim_name:orig_prim_name:LEFTTRIM','orig_prim_name:orig_prim_name:ALLOW','orig_prim_name:orig_prim_name:LENGTHS','orig_prim_name:orig_prim_name:WORDS'
          ,'orig_addr_suffix:orig_addr_suffix:LEFTTRIM','orig_addr_suffix:orig_addr_suffix:ALLOW','orig_addr_suffix:orig_addr_suffix:LENGTHS','orig_addr_suffix:orig_addr_suffix:WORDS'
          ,'orig_postdir:orig_postdir:LEFTTRIM','orig_postdir:orig_postdir:ALLOW','orig_postdir:orig_postdir:LENGTHS','orig_postdir:orig_postdir:WORDS'
          ,'orig_unit_desig:orig_unit_desig:LEFTTRIM','orig_unit_desig:orig_unit_desig:ALLOW','orig_unit_desig:orig_unit_desig:LENGTHS','orig_unit_desig:orig_unit_desig:WORDS'
          ,'orig_sec_range:orig_sec_range:LEFTTRIM','orig_sec_range:orig_sec_range:ALLOW','orig_sec_range:orig_sec_range:LENGTHS','orig_sec_range:orig_sec_range:WORDS'
          ,'orig_city:orig_city:LEFTTRIM','orig_city:orig_city:ALLOW','orig_city:orig_city:LENGTHS','orig_city:orig_city:WORDS'
          ,'orig_state:orig_state:LEFTTRIM','orig_state:orig_state:ALLOW','orig_state:orig_state:LENGTHS','orig_state:orig_state:WORDS'
          ,'orig_zipcode:orig_zipcode:LEFTTRIM','orig_zipcode:orig_zipcode:ALLOW','orig_zipcode:orig_zipcode:LENGTHS','orig_zipcode:orig_zipcode:WORDS'
          ,'orig_zipcode4:orig_zipcode4:LEFTTRIM','orig_zipcode4:orig_zipcode4:ALLOW','orig_zipcode4:orig_zipcode4:LENGTHS','orig_zipcode4:orig_zipcode4:WORDS'
          ,'prim_range:prim_range:LEFTTRIM','prim_range:prim_range:ALLOW','prim_range:prim_range:LENGTHS','prim_range:prim_range:WORDS'
          ,'predir:predir:LEFTTRIM','predir:predir:ALLOW','predir:predir:LENGTHS','predir:predir:WORDS'
          ,'prim_name:prim_name:LEFTTRIM','prim_name:prim_name:ALLOW','prim_name:prim_name:LENGTHS','prim_name:prim_name:WORDS'
          ,'addr_suffix:addr_suffix:LEFTTRIM','addr_suffix:addr_suffix:ALLOW','addr_suffix:addr_suffix:LENGTHS','addr_suffix:addr_suffix:WORDS'
          ,'postdir:postdir:LEFTTRIM','postdir:postdir:ALLOW','postdir:postdir:LENGTHS','postdir:postdir:WORDS'
          ,'unit_desig:unit_desig:LEFTTRIM','unit_desig:unit_desig:ALLOW','unit_desig:unit_desig:LENGTHS','unit_desig:unit_desig:WORDS'
          ,'sec_range:sec_range:LEFTTRIM','sec_range:sec_range:ALLOW','sec_range:sec_range:LENGTHS','sec_range:sec_range:WORDS'
          ,'p_city_name:p_city_name:LEFTTRIM','p_city_name:p_city_name:ALLOW','p_city_name:p_city_name:LENGTHS','p_city_name:p_city_name:WORDS'
          ,'v_city_name:v_city_name:LEFTTRIM','v_city_name:v_city_name:ALLOW','v_city_name:v_city_name:LENGTHS','v_city_name:v_city_name:WORDS'
          ,'st:st:LEFTTRIM','st:st:ALLOW','st:st:LENGTHS','st:st:WORDS'
          ,'zip:zip:LEFTTRIM','zip:zip:ALLOW','zip:zip:LENGTHS','zip:zip:WORDS'
          ,'zip4:zip4:LEFTTRIM','zip4:zip4:ALLOW','zip4:zip4:LENGTHS','zip4:zip4:WORDS'
          ,'cart:cart:LEFTTRIM','cart:cart:ALLOW','cart:cart:LENGTHS','cart:cart:WORDS'
          ,'cr_sort_sz:cr_sort_sz:LEFTTRIM','cr_sort_sz:cr_sort_sz:ALLOW','cr_sort_sz:cr_sort_sz:LENGTHS','cr_sort_sz:cr_sort_sz:WORDS'
          ,'lot:lot:LEFTTRIM','lot:lot:ALLOW','lot:lot:LENGTHS','lot:lot:WORDS'
          ,'lot_order:lot_order:LEFTTRIM','lot_order:lot_order:ALLOW','lot_order:lot_order:LENGTHS','lot_order:lot_order:WORDS'
          ,'dbpc:dbpc:LEFTTRIM','dbpc:dbpc:ALLOW','dbpc:dbpc:LENGTHS','dbpc:dbpc:WORDS'
          ,'chk_digit:chk_digit:LEFTTRIM','chk_digit:chk_digit:ALLOW','chk_digit:chk_digit:LENGTHS','chk_digit:chk_digit:WORDS'
          ,'rec_type:rec_type:LEFTTRIM','rec_type:rec_type:ALLOW','rec_type:rec_type:LENGTHS','rec_type:rec_type:WORDS'
          ,'county:county:LEFTTRIM','county:county:ALLOW','county:county:LENGTHS','county:county:WORDS'
          ,'geo_lat:geo_lat:LEFTTRIM','geo_lat:geo_lat:ALLOW','geo_lat:geo_lat:LENGTHS','geo_lat:geo_lat:WORDS'
          ,'geo_long:geo_long:LEFTTRIM','geo_long:geo_long:ALLOW','geo_long:geo_long:LENGTHS','geo_long:geo_long:WORDS'
          ,'msa:msa:LEFTTRIM','msa:msa:ALLOW','msa:msa:LENGTHS','msa:msa:WORDS'
          ,'geo_blk:geo_blk:LEFTTRIM','geo_blk:geo_blk:ALLOW','geo_blk:geo_blk:LENGTHS','geo_blk:geo_blk:WORDS'
          ,'geo_match:geo_match:LEFTTRIM','geo_match:geo_match:ALLOW','geo_match:geo_match:LENGTHS','geo_match:geo_match:WORDS'
          ,'err_stat:err_stat:LEFTTRIM','err_stat:err_stat:ALLOW','err_stat:err_stat:LENGTHS','err_stat:err_stat:WORDS'
          ,'delete_flag:delete_flag:LEFTTRIM','delete_flag:delete_flag:ALLOW','delete_flag:delete_flag:LENGTHS','delete_flag:delete_flag:WORDS'
          ,'delete_file_date:delete_file_date:LEFTTRIM','delete_file_date:delete_file_date:ALLOW','delete_file_date:delete_file_date:LENGTHS','delete_file_date:delete_file_date:WORDS'
          ,'suppression_code:suppression_code:LEFTTRIM','suppression_code:suppression_code:ALLOW','suppression_code:suppression_code:LENGTHS','suppression_code:suppression_code:WORDS'
          ,'deceased_ind:deceased_ind:LEFTTRIM','deceased_ind:deceased_ind:ALLOW','deceased_ind:deceased_ind:LENGTHS','deceased_ind:deceased_ind:WORDS'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY'
          ,'record:Number_Edited_Records:SUMMARY'
          ,'rule:Number_Edited_Rules:SUMMARY','UNKNOWN');
  SHARED toErrorMessage(UNSIGNED c) := CHOOSE(c
          ,Fields.InvalidMessage_seq_rec_id(1),Fields.InvalidMessage_seq_rec_id(2),Fields.InvalidMessage_seq_rec_id(3),Fields.InvalidMessage_seq_rec_id(4)
          ,Fields.InvalidMessage_did(1),Fields.InvalidMessage_did(2),Fields.InvalidMessage_did(3),Fields.InvalidMessage_did(4)
          ,Fields.InvalidMessage_did_score_field(1),Fields.InvalidMessage_did_score_field(2),Fields.InvalidMessage_did_score_field(3),Fields.InvalidMessage_did_score_field(4)
          ,Fields.InvalidMessage_current_rec_flag(1),Fields.InvalidMessage_current_rec_flag(2),Fields.InvalidMessage_current_rec_flag(3),Fields.InvalidMessage_current_rec_flag(4)
          ,Fields.InvalidMessage_current_experian_pin(1),Fields.InvalidMessage_current_experian_pin(2),Fields.InvalidMessage_current_experian_pin(3),Fields.InvalidMessage_current_experian_pin(4)
          ,Fields.InvalidMessage_date_first_seen(1),Fields.InvalidMessage_date_first_seen(2),Fields.InvalidMessage_date_first_seen(3),Fields.InvalidMessage_date_first_seen(4)
          ,Fields.InvalidMessage_date_last_seen(1),Fields.InvalidMessage_date_last_seen(2),Fields.InvalidMessage_date_last_seen(3),Fields.InvalidMessage_date_last_seen(4)
          ,Fields.InvalidMessage_date_vendor_first_reported(1),Fields.InvalidMessage_date_vendor_first_reported(2),Fields.InvalidMessage_date_vendor_first_reported(3),Fields.InvalidMessage_date_vendor_first_reported(4)
          ,Fields.InvalidMessage_date_vendor_last_reported(1),Fields.InvalidMessage_date_vendor_last_reported(2),Fields.InvalidMessage_date_vendor_last_reported(3),Fields.InvalidMessage_date_vendor_last_reported(4)
          ,Fields.InvalidMessage_encrypted_experian_pin(1),Fields.InvalidMessage_encrypted_experian_pin(2),Fields.InvalidMessage_encrypted_experian_pin(3),Fields.InvalidMessage_encrypted_experian_pin(4)
          ,Fields.InvalidMessage_social_security_number(1),Fields.InvalidMessage_social_security_number(2),Fields.InvalidMessage_social_security_number(3),Fields.InvalidMessage_social_security_number(4)
          ,Fields.InvalidMessage_date_of_birth(1),Fields.InvalidMessage_date_of_birth(2),Fields.InvalidMessage_date_of_birth(3),Fields.InvalidMessage_date_of_birth(4)
          ,Fields.InvalidMessage_telephone(1),Fields.InvalidMessage_telephone(2),Fields.InvalidMessage_telephone(3),Fields.InvalidMessage_telephone(4)
          ,Fields.InvalidMessage_gender(1),Fields.InvalidMessage_gender(2),Fields.InvalidMessage_gender(3),Fields.InvalidMessage_gender(4)
          ,Fields.InvalidMessage_additional_name_count(1),Fields.InvalidMessage_additional_name_count(2),Fields.InvalidMessage_additional_name_count(3),Fields.InvalidMessage_additional_name_count(4)
          ,Fields.InvalidMessage_previous_address_count(1),Fields.InvalidMessage_previous_address_count(2),Fields.InvalidMessage_previous_address_count(3),Fields.InvalidMessage_previous_address_count(4)
          ,Fields.InvalidMessage_nametype(1),Fields.InvalidMessage_nametype(2),Fields.InvalidMessage_nametype(3),Fields.InvalidMessage_nametype(4)
          ,Fields.InvalidMessage_orig_consumer_create_date(1),Fields.InvalidMessage_orig_consumer_create_date(2),Fields.InvalidMessage_orig_consumer_create_date(3),Fields.InvalidMessage_orig_consumer_create_date(4)
          ,Fields.InvalidMessage_orig_fname(1),Fields.InvalidMessage_orig_fname(2),Fields.InvalidMessage_orig_fname(3),Fields.InvalidMessage_orig_fname(4)
          ,Fields.InvalidMessage_orig_mname(1),Fields.InvalidMessage_orig_mname(2),Fields.InvalidMessage_orig_mname(3),Fields.InvalidMessage_orig_mname(4)
          ,Fields.InvalidMessage_orig_lname(1),Fields.InvalidMessage_orig_lname(2),Fields.InvalidMessage_orig_lname(3),Fields.InvalidMessage_orig_lname(4)
          ,Fields.InvalidMessage_orig_suffix(1),Fields.InvalidMessage_orig_suffix(2),Fields.InvalidMessage_orig_suffix(3),Fields.InvalidMessage_orig_suffix(4)
          ,Fields.InvalidMessage_title(1),Fields.InvalidMessage_title(2),Fields.InvalidMessage_title(3),Fields.InvalidMessage_title(4)
          ,Fields.InvalidMessage_fname(1),Fields.InvalidMessage_fname(2),Fields.InvalidMessage_fname(3),Fields.InvalidMessage_fname(4)
          ,Fields.InvalidMessage_mname(1),Fields.InvalidMessage_mname(2),Fields.InvalidMessage_mname(3),Fields.InvalidMessage_mname(4)
          ,Fields.InvalidMessage_lname(1),Fields.InvalidMessage_lname(2),Fields.InvalidMessage_lname(3),Fields.InvalidMessage_lname(4)
          ,Fields.InvalidMessage_name_suffix(1),Fields.InvalidMessage_name_suffix(2),Fields.InvalidMessage_name_suffix(3),Fields.InvalidMessage_name_suffix(4)
          ,Fields.InvalidMessage_name_score(1),Fields.InvalidMessage_name_score(2),Fields.InvalidMessage_name_score(3),Fields.InvalidMessage_name_score(4)
          ,Fields.InvalidMessage_addressseq(1),Fields.InvalidMessage_addressseq(2),Fields.InvalidMessage_addressseq(3),Fields.InvalidMessage_addressseq(4)
          ,Fields.InvalidMessage_orig_address_create_date(1),Fields.InvalidMessage_orig_address_create_date(2),Fields.InvalidMessage_orig_address_create_date(3),Fields.InvalidMessage_orig_address_create_date(4)
          ,Fields.InvalidMessage_orig_address_update_date(1),Fields.InvalidMessage_orig_address_update_date(2),Fields.InvalidMessage_orig_address_update_date(3),Fields.InvalidMessage_orig_address_update_date(4)
          ,Fields.InvalidMessage_orig_prim_range(1),Fields.InvalidMessage_orig_prim_range(2),Fields.InvalidMessage_orig_prim_range(3),Fields.InvalidMessage_orig_prim_range(4)
          ,Fields.InvalidMessage_orig_predir(1),Fields.InvalidMessage_orig_predir(2),Fields.InvalidMessage_orig_predir(3),Fields.InvalidMessage_orig_predir(4)
          ,Fields.InvalidMessage_orig_prim_name(1),Fields.InvalidMessage_orig_prim_name(2),Fields.InvalidMessage_orig_prim_name(3),Fields.InvalidMessage_orig_prim_name(4)
          ,Fields.InvalidMessage_orig_addr_suffix(1),Fields.InvalidMessage_orig_addr_suffix(2),Fields.InvalidMessage_orig_addr_suffix(3),Fields.InvalidMessage_orig_addr_suffix(4)
          ,Fields.InvalidMessage_orig_postdir(1),Fields.InvalidMessage_orig_postdir(2),Fields.InvalidMessage_orig_postdir(3),Fields.InvalidMessage_orig_postdir(4)
          ,Fields.InvalidMessage_orig_unit_desig(1),Fields.InvalidMessage_orig_unit_desig(2),Fields.InvalidMessage_orig_unit_desig(3),Fields.InvalidMessage_orig_unit_desig(4)
          ,Fields.InvalidMessage_orig_sec_range(1),Fields.InvalidMessage_orig_sec_range(2),Fields.InvalidMessage_orig_sec_range(3),Fields.InvalidMessage_orig_sec_range(4)
          ,Fields.InvalidMessage_orig_city(1),Fields.InvalidMessage_orig_city(2),Fields.InvalidMessage_orig_city(3),Fields.InvalidMessage_orig_city(4)
          ,Fields.InvalidMessage_orig_state(1),Fields.InvalidMessage_orig_state(2),Fields.InvalidMessage_orig_state(3),Fields.InvalidMessage_orig_state(4)
          ,Fields.InvalidMessage_orig_zipcode(1),Fields.InvalidMessage_orig_zipcode(2),Fields.InvalidMessage_orig_zipcode(3),Fields.InvalidMessage_orig_zipcode(4)
          ,Fields.InvalidMessage_orig_zipcode4(1),Fields.InvalidMessage_orig_zipcode4(2),Fields.InvalidMessage_orig_zipcode4(3),Fields.InvalidMessage_orig_zipcode4(4)
          ,Fields.InvalidMessage_prim_range(1),Fields.InvalidMessage_prim_range(2),Fields.InvalidMessage_prim_range(3),Fields.InvalidMessage_prim_range(4)
          ,Fields.InvalidMessage_predir(1),Fields.InvalidMessage_predir(2),Fields.InvalidMessage_predir(3),Fields.InvalidMessage_predir(4)
          ,Fields.InvalidMessage_prim_name(1),Fields.InvalidMessage_prim_name(2),Fields.InvalidMessage_prim_name(3),Fields.InvalidMessage_prim_name(4)
          ,Fields.InvalidMessage_addr_suffix(1),Fields.InvalidMessage_addr_suffix(2),Fields.InvalidMessage_addr_suffix(3),Fields.InvalidMessage_addr_suffix(4)
          ,Fields.InvalidMessage_postdir(1),Fields.InvalidMessage_postdir(2),Fields.InvalidMessage_postdir(3),Fields.InvalidMessage_postdir(4)
          ,Fields.InvalidMessage_unit_desig(1),Fields.InvalidMessage_unit_desig(2),Fields.InvalidMessage_unit_desig(3),Fields.InvalidMessage_unit_desig(4)
          ,Fields.InvalidMessage_sec_range(1),Fields.InvalidMessage_sec_range(2),Fields.InvalidMessage_sec_range(3),Fields.InvalidMessage_sec_range(4)
          ,Fields.InvalidMessage_p_city_name(1),Fields.InvalidMessage_p_city_name(2),Fields.InvalidMessage_p_city_name(3),Fields.InvalidMessage_p_city_name(4)
          ,Fields.InvalidMessage_v_city_name(1),Fields.InvalidMessage_v_city_name(2),Fields.InvalidMessage_v_city_name(3),Fields.InvalidMessage_v_city_name(4)
          ,Fields.InvalidMessage_st(1),Fields.InvalidMessage_st(2),Fields.InvalidMessage_st(3),Fields.InvalidMessage_st(4)
          ,Fields.InvalidMessage_zip(1),Fields.InvalidMessage_zip(2),Fields.InvalidMessage_zip(3),Fields.InvalidMessage_zip(4)
          ,Fields.InvalidMessage_zip4(1),Fields.InvalidMessage_zip4(2),Fields.InvalidMessage_zip4(3),Fields.InvalidMessage_zip4(4)
          ,Fields.InvalidMessage_cart(1),Fields.InvalidMessage_cart(2),Fields.InvalidMessage_cart(3),Fields.InvalidMessage_cart(4)
          ,Fields.InvalidMessage_cr_sort_sz(1),Fields.InvalidMessage_cr_sort_sz(2),Fields.InvalidMessage_cr_sort_sz(3),Fields.InvalidMessage_cr_sort_sz(4)
          ,Fields.InvalidMessage_lot(1),Fields.InvalidMessage_lot(2),Fields.InvalidMessage_lot(3),Fields.InvalidMessage_lot(4)
          ,Fields.InvalidMessage_lot_order(1),Fields.InvalidMessage_lot_order(2),Fields.InvalidMessage_lot_order(3),Fields.InvalidMessage_lot_order(4)
          ,Fields.InvalidMessage_dbpc(1),Fields.InvalidMessage_dbpc(2),Fields.InvalidMessage_dbpc(3),Fields.InvalidMessage_dbpc(4)
          ,Fields.InvalidMessage_chk_digit(1),Fields.InvalidMessage_chk_digit(2),Fields.InvalidMessage_chk_digit(3),Fields.InvalidMessage_chk_digit(4)
          ,Fields.InvalidMessage_rec_type(1),Fields.InvalidMessage_rec_type(2),Fields.InvalidMessage_rec_type(3),Fields.InvalidMessage_rec_type(4)
          ,Fields.InvalidMessage_county(1),Fields.InvalidMessage_county(2),Fields.InvalidMessage_county(3),Fields.InvalidMessage_county(4)
          ,Fields.InvalidMessage_geo_lat(1),Fields.InvalidMessage_geo_lat(2),Fields.InvalidMessage_geo_lat(3),Fields.InvalidMessage_geo_lat(4)
          ,Fields.InvalidMessage_geo_long(1),Fields.InvalidMessage_geo_long(2),Fields.InvalidMessage_geo_long(3),Fields.InvalidMessage_geo_long(4)
          ,Fields.InvalidMessage_msa(1),Fields.InvalidMessage_msa(2),Fields.InvalidMessage_msa(3),Fields.InvalidMessage_msa(4)
          ,Fields.InvalidMessage_geo_blk(1),Fields.InvalidMessage_geo_blk(2),Fields.InvalidMessage_geo_blk(3),Fields.InvalidMessage_geo_blk(4)
          ,Fields.InvalidMessage_geo_match(1),Fields.InvalidMessage_geo_match(2),Fields.InvalidMessage_geo_match(3),Fields.InvalidMessage_geo_match(4)
          ,Fields.InvalidMessage_err_stat(1),Fields.InvalidMessage_err_stat(2),Fields.InvalidMessage_err_stat(3),Fields.InvalidMessage_err_stat(4)
          ,Fields.InvalidMessage_delete_flag(1),Fields.InvalidMessage_delete_flag(2),Fields.InvalidMessage_delete_flag(3),Fields.InvalidMessage_delete_flag(4)
          ,Fields.InvalidMessage_delete_file_date(1),Fields.InvalidMessage_delete_file_date(2),Fields.InvalidMessage_delete_file_date(3),Fields.InvalidMessage_delete_file_date(4)
          ,Fields.InvalidMessage_suppression_code(1),Fields.InvalidMessage_suppression_code(2),Fields.InvalidMessage_suppression_code(3),Fields.InvalidMessage_suppression_code(4)
          ,Fields.InvalidMessage_deceased_ind(1),Fields.InvalidMessage_deceased_ind(2),Fields.InvalidMessage_deceased_ind(3),Fields.InvalidMessage_deceased_ind(4)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors'
          ,'Edited records'
          ,'Rules leading to edits','UNKNOWN');
EXPORT FromNone(DATASET(Layout_File) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.seq_rec_id_Invalid := Fields.InValid_seq_rec_id((SALT311.StrType)le.seq_rec_id);
    clean_seq_rec_id := (TYPEOF(le.seq_rec_id))Fields.Make_seq_rec_id((SALT311.StrType)le.seq_rec_id);
    clean_seq_rec_id_Invalid := Fields.InValid_seq_rec_id((SALT311.StrType)clean_seq_rec_id);
    SELF.seq_rec_id := IF(withOnfail, clean_seq_rec_id, le.seq_rec_id); // ONFAIL(CLEAN)
    SELF.seq_rec_id_wouldClean := TRIM((SALT311.StrType)le.seq_rec_id) <> TRIM((SALT311.StrType)clean_seq_rec_id);
    SELF.did_Invalid := Fields.InValid_did((SALT311.StrType)le.did);
    clean_did := (TYPEOF(le.did))Fields.Make_did((SALT311.StrType)le.did);
    clean_did_Invalid := Fields.InValid_did((SALT311.StrType)clean_did);
    SELF.did := IF(withOnfail, clean_did, le.did); // ONFAIL(CLEAN)
    SELF.did_wouldClean := TRIM((SALT311.StrType)le.did) <> TRIM((SALT311.StrType)clean_did);
    SELF.did_score_field_Invalid := Fields.InValid_did_score_field((SALT311.StrType)le.did_score_field);
    clean_did_score_field := (TYPEOF(le.did_score_field))Fields.Make_did_score_field((SALT311.StrType)le.did_score_field);
    clean_did_score_field_Invalid := Fields.InValid_did_score_field((SALT311.StrType)clean_did_score_field);
    SELF.did_score_field := IF(withOnfail, clean_did_score_field, le.did_score_field); // ONFAIL(CLEAN)
    SELF.did_score_field_wouldClean := TRIM((SALT311.StrType)le.did_score_field) <> TRIM((SALT311.StrType)clean_did_score_field);
    SELF.current_rec_flag_Invalid := Fields.InValid_current_rec_flag((SALT311.StrType)le.current_rec_flag);
    clean_current_rec_flag := (TYPEOF(le.current_rec_flag))Fields.Make_current_rec_flag((SALT311.StrType)le.current_rec_flag);
    clean_current_rec_flag_Invalid := Fields.InValid_current_rec_flag((SALT311.StrType)clean_current_rec_flag);
    SELF.current_rec_flag := IF(withOnfail, clean_current_rec_flag, le.current_rec_flag); // ONFAIL(CLEAN)
    SELF.current_rec_flag_wouldClean := TRIM((SALT311.StrType)le.current_rec_flag) <> TRIM((SALT311.StrType)clean_current_rec_flag);
    SELF.current_experian_pin_Invalid := Fields.InValid_current_experian_pin((SALT311.StrType)le.current_experian_pin);
    clean_current_experian_pin := (TYPEOF(le.current_experian_pin))Fields.Make_current_experian_pin((SALT311.StrType)le.current_experian_pin);
    clean_current_experian_pin_Invalid := Fields.InValid_current_experian_pin((SALT311.StrType)clean_current_experian_pin);
    SELF.current_experian_pin := IF(withOnfail, clean_current_experian_pin, le.current_experian_pin); // ONFAIL(CLEAN)
    SELF.current_experian_pin_wouldClean := TRIM((SALT311.StrType)le.current_experian_pin) <> TRIM((SALT311.StrType)clean_current_experian_pin);
    SELF.date_first_seen_Invalid := Fields.InValid_date_first_seen((SALT311.StrType)le.date_first_seen);
    clean_date_first_seen := (TYPEOF(le.date_first_seen))Fields.Make_date_first_seen((SALT311.StrType)le.date_first_seen);
    clean_date_first_seen_Invalid := Fields.InValid_date_first_seen((SALT311.StrType)clean_date_first_seen);
    SELF.date_first_seen := IF(withOnfail, clean_date_first_seen, le.date_first_seen); // ONFAIL(CLEAN)
    SELF.date_first_seen_wouldClean := TRIM((SALT311.StrType)le.date_first_seen) <> TRIM((SALT311.StrType)clean_date_first_seen);
    SELF.date_last_seen_Invalid := Fields.InValid_date_last_seen((SALT311.StrType)le.date_last_seen);
    clean_date_last_seen := (TYPEOF(le.date_last_seen))Fields.Make_date_last_seen((SALT311.StrType)le.date_last_seen);
    clean_date_last_seen_Invalid := Fields.InValid_date_last_seen((SALT311.StrType)clean_date_last_seen);
    SELF.date_last_seen := IF(withOnfail, clean_date_last_seen, le.date_last_seen); // ONFAIL(CLEAN)
    SELF.date_last_seen_wouldClean := TRIM((SALT311.StrType)le.date_last_seen) <> TRIM((SALT311.StrType)clean_date_last_seen);
    SELF.date_vendor_first_reported_Invalid := Fields.InValid_date_vendor_first_reported((SALT311.StrType)le.date_vendor_first_reported);
    clean_date_vendor_first_reported := (TYPEOF(le.date_vendor_first_reported))Fields.Make_date_vendor_first_reported((SALT311.StrType)le.date_vendor_first_reported);
    clean_date_vendor_first_reported_Invalid := Fields.InValid_date_vendor_first_reported((SALT311.StrType)clean_date_vendor_first_reported);
    SELF.date_vendor_first_reported := IF(withOnfail, clean_date_vendor_first_reported, le.date_vendor_first_reported); // ONFAIL(CLEAN)
    SELF.date_vendor_first_reported_wouldClean := TRIM((SALT311.StrType)le.date_vendor_first_reported) <> TRIM((SALT311.StrType)clean_date_vendor_first_reported);
    SELF.date_vendor_last_reported_Invalid := Fields.InValid_date_vendor_last_reported((SALT311.StrType)le.date_vendor_last_reported);
    clean_date_vendor_last_reported := (TYPEOF(le.date_vendor_last_reported))Fields.Make_date_vendor_last_reported((SALT311.StrType)le.date_vendor_last_reported);
    clean_date_vendor_last_reported_Invalid := Fields.InValid_date_vendor_last_reported((SALT311.StrType)clean_date_vendor_last_reported);
    SELF.date_vendor_last_reported := IF(withOnfail, clean_date_vendor_last_reported, le.date_vendor_last_reported); // ONFAIL(CLEAN)
    SELF.date_vendor_last_reported_wouldClean := TRIM((SALT311.StrType)le.date_vendor_last_reported) <> TRIM((SALT311.StrType)clean_date_vendor_last_reported);
    SELF.encrypted_experian_pin_Invalid := Fields.InValid_encrypted_experian_pin((SALT311.StrType)le.encrypted_experian_pin);
    clean_encrypted_experian_pin := (TYPEOF(le.encrypted_experian_pin))Fields.Make_encrypted_experian_pin((SALT311.StrType)le.encrypted_experian_pin);
    clean_encrypted_experian_pin_Invalid := Fields.InValid_encrypted_experian_pin((SALT311.StrType)clean_encrypted_experian_pin);
    SELF.encrypted_experian_pin := IF(withOnfail, clean_encrypted_experian_pin, le.encrypted_experian_pin); // ONFAIL(CLEAN)
    SELF.encrypted_experian_pin_wouldClean := TRIM((SALT311.StrType)le.encrypted_experian_pin) <> TRIM((SALT311.StrType)clean_encrypted_experian_pin);
    SELF.social_security_number_Invalid := Fields.InValid_social_security_number((SALT311.StrType)le.social_security_number);
    clean_social_security_number := (TYPEOF(le.social_security_number))Fields.Make_social_security_number((SALT311.StrType)le.social_security_number);
    clean_social_security_number_Invalid := Fields.InValid_social_security_number((SALT311.StrType)clean_social_security_number);
    SELF.social_security_number := IF(withOnfail, clean_social_security_number, le.social_security_number); // ONFAIL(CLEAN)
    SELF.social_security_number_wouldClean := TRIM((SALT311.StrType)le.social_security_number) <> TRIM((SALT311.StrType)clean_social_security_number);
    SELF.date_of_birth_Invalid := Fields.InValid_date_of_birth((SALT311.StrType)le.date_of_birth);
    clean_date_of_birth := (TYPEOF(le.date_of_birth))Fields.Make_date_of_birth((SALT311.StrType)le.date_of_birth);
    clean_date_of_birth_Invalid := Fields.InValid_date_of_birth((SALT311.StrType)clean_date_of_birth);
    SELF.date_of_birth := IF(withOnfail, clean_date_of_birth, le.date_of_birth); // ONFAIL(CLEAN)
    SELF.date_of_birth_wouldClean := TRIM((SALT311.StrType)le.date_of_birth) <> TRIM((SALT311.StrType)clean_date_of_birth);
    SELF.telephone_Invalid := Fields.InValid_telephone((SALT311.StrType)le.telephone);
    clean_telephone := (TYPEOF(le.telephone))Fields.Make_telephone((SALT311.StrType)le.telephone);
    clean_telephone_Invalid := Fields.InValid_telephone((SALT311.StrType)clean_telephone);
    SELF.telephone := IF(withOnfail, clean_telephone, le.telephone); // ONFAIL(CLEAN)
    SELF.telephone_wouldClean := TRIM((SALT311.StrType)le.telephone) <> TRIM((SALT311.StrType)clean_telephone);
    SELF.gender_Invalid := Fields.InValid_gender((SALT311.StrType)le.gender);
    clean_gender := (TYPEOF(le.gender))Fields.Make_gender((SALT311.StrType)le.gender);
    clean_gender_Invalid := Fields.InValid_gender((SALT311.StrType)clean_gender);
    SELF.gender := IF(withOnfail, clean_gender, le.gender); // ONFAIL(CLEAN)
    SELF.gender_wouldClean := TRIM((SALT311.StrType)le.gender) <> TRIM((SALT311.StrType)clean_gender);
    SELF.additional_name_count_Invalid := Fields.InValid_additional_name_count((SALT311.StrType)le.additional_name_count);
    clean_additional_name_count := (TYPEOF(le.additional_name_count))Fields.Make_additional_name_count((SALT311.StrType)le.additional_name_count);
    clean_additional_name_count_Invalid := Fields.InValid_additional_name_count((SALT311.StrType)clean_additional_name_count);
    SELF.additional_name_count := IF(withOnfail, clean_additional_name_count, le.additional_name_count); // ONFAIL(CLEAN)
    SELF.additional_name_count_wouldClean := TRIM((SALT311.StrType)le.additional_name_count) <> TRIM((SALT311.StrType)clean_additional_name_count);
    SELF.previous_address_count_Invalid := Fields.InValid_previous_address_count((SALT311.StrType)le.previous_address_count);
    clean_previous_address_count := (TYPEOF(le.previous_address_count))Fields.Make_previous_address_count((SALT311.StrType)le.previous_address_count);
    clean_previous_address_count_Invalid := Fields.InValid_previous_address_count((SALT311.StrType)clean_previous_address_count);
    SELF.previous_address_count := IF(withOnfail, clean_previous_address_count, le.previous_address_count); // ONFAIL(CLEAN)
    SELF.previous_address_count_wouldClean := TRIM((SALT311.StrType)le.previous_address_count) <> TRIM((SALT311.StrType)clean_previous_address_count);
    SELF.nametype_Invalid := Fields.InValid_nametype((SALT311.StrType)le.nametype);
    clean_nametype := (TYPEOF(le.nametype))Fields.Make_nametype((SALT311.StrType)le.nametype);
    clean_nametype_Invalid := Fields.InValid_nametype((SALT311.StrType)clean_nametype);
    SELF.nametype := IF(withOnfail, clean_nametype, le.nametype); // ONFAIL(CLEAN)
    SELF.nametype_wouldClean := TRIM((SALT311.StrType)le.nametype) <> TRIM((SALT311.StrType)clean_nametype);
    SELF.orig_consumer_create_date_Invalid := Fields.InValid_orig_consumer_create_date((SALT311.StrType)le.orig_consumer_create_date);
    clean_orig_consumer_create_date := (TYPEOF(le.orig_consumer_create_date))Fields.Make_orig_consumer_create_date((SALT311.StrType)le.orig_consumer_create_date);
    clean_orig_consumer_create_date_Invalid := Fields.InValid_orig_consumer_create_date((SALT311.StrType)clean_orig_consumer_create_date);
    SELF.orig_consumer_create_date := IF(withOnfail, clean_orig_consumer_create_date, le.orig_consumer_create_date); // ONFAIL(CLEAN)
    SELF.orig_consumer_create_date_wouldClean := TRIM((SALT311.StrType)le.orig_consumer_create_date) <> TRIM((SALT311.StrType)clean_orig_consumer_create_date);
    SELF.orig_fname_Invalid := Fields.InValid_orig_fname((SALT311.StrType)le.orig_fname);
    clean_orig_fname := (TYPEOF(le.orig_fname))Fields.Make_orig_fname((SALT311.StrType)le.orig_fname);
    clean_orig_fname_Invalid := Fields.InValid_orig_fname((SALT311.StrType)clean_orig_fname);
    SELF.orig_fname := IF(withOnfail, clean_orig_fname, le.orig_fname); // ONFAIL(CLEAN)
    SELF.orig_fname_wouldClean := TRIM((SALT311.StrType)le.orig_fname) <> TRIM((SALT311.StrType)clean_orig_fname);
    SELF.orig_mname_Invalid := Fields.InValid_orig_mname((SALT311.StrType)le.orig_mname);
    clean_orig_mname := (TYPEOF(le.orig_mname))Fields.Make_orig_mname((SALT311.StrType)le.orig_mname);
    clean_orig_mname_Invalid := Fields.InValid_orig_mname((SALT311.StrType)clean_orig_mname);
    SELF.orig_mname := IF(withOnfail, clean_orig_mname, le.orig_mname); // ONFAIL(CLEAN)
    SELF.orig_mname_wouldClean := TRIM((SALT311.StrType)le.orig_mname) <> TRIM((SALT311.StrType)clean_orig_mname);
    SELF.orig_lname_Invalid := Fields.InValid_orig_lname((SALT311.StrType)le.orig_lname);
    clean_orig_lname := (TYPEOF(le.orig_lname))Fields.Make_orig_lname((SALT311.StrType)le.orig_lname);
    clean_orig_lname_Invalid := Fields.InValid_orig_lname((SALT311.StrType)clean_orig_lname);
    SELF.orig_lname := IF(withOnfail, clean_orig_lname, le.orig_lname); // ONFAIL(CLEAN)
    SELF.orig_lname_wouldClean := TRIM((SALT311.StrType)le.orig_lname) <> TRIM((SALT311.StrType)clean_orig_lname);
    SELF.orig_suffix_Invalid := Fields.InValid_orig_suffix((SALT311.StrType)le.orig_suffix);
    clean_orig_suffix := (TYPEOF(le.orig_suffix))Fields.Make_orig_suffix((SALT311.StrType)le.orig_suffix);
    clean_orig_suffix_Invalid := Fields.InValid_orig_suffix((SALT311.StrType)clean_orig_suffix);
    SELF.orig_suffix := IF(withOnfail, clean_orig_suffix, le.orig_suffix); // ONFAIL(CLEAN)
    SELF.orig_suffix_wouldClean := TRIM((SALT311.StrType)le.orig_suffix) <> TRIM((SALT311.StrType)clean_orig_suffix);
    SELF.title_Invalid := Fields.InValid_title((SALT311.StrType)le.title);
    clean_title := (TYPEOF(le.title))Fields.Make_title((SALT311.StrType)le.title);
    clean_title_Invalid := Fields.InValid_title((SALT311.StrType)clean_title);
    SELF.title := IF(withOnfail, clean_title, le.title); // ONFAIL(CLEAN)
    SELF.title_wouldClean := TRIM((SALT311.StrType)le.title) <> TRIM((SALT311.StrType)clean_title);
    SELF.fname_Invalid := Fields.InValid_fname((SALT311.StrType)le.fname);
    clean_fname := (TYPEOF(le.fname))Fields.Make_fname((SALT311.StrType)le.fname);
    clean_fname_Invalid := Fields.InValid_fname((SALT311.StrType)clean_fname);
    SELF.fname := IF(withOnfail, clean_fname, le.fname); // ONFAIL(CLEAN)
    SELF.fname_wouldClean := TRIM((SALT311.StrType)le.fname) <> TRIM((SALT311.StrType)clean_fname);
    SELF.mname_Invalid := Fields.InValid_mname((SALT311.StrType)le.mname);
    clean_mname := (TYPEOF(le.mname))Fields.Make_mname((SALT311.StrType)le.mname);
    clean_mname_Invalid := Fields.InValid_mname((SALT311.StrType)clean_mname);
    SELF.mname := IF(withOnfail, clean_mname, le.mname); // ONFAIL(CLEAN)
    SELF.mname_wouldClean := TRIM((SALT311.StrType)le.mname) <> TRIM((SALT311.StrType)clean_mname);
    SELF.lname_Invalid := Fields.InValid_lname((SALT311.StrType)le.lname);
    clean_lname := (TYPEOF(le.lname))Fields.Make_lname((SALT311.StrType)le.lname);
    clean_lname_Invalid := Fields.InValid_lname((SALT311.StrType)clean_lname);
    SELF.lname := IF(withOnfail, clean_lname, le.lname); // ONFAIL(CLEAN)
    SELF.lname_wouldClean := TRIM((SALT311.StrType)le.lname) <> TRIM((SALT311.StrType)clean_lname);
    SELF.name_suffix_Invalid := Fields.InValid_name_suffix((SALT311.StrType)le.name_suffix);
    clean_name_suffix := (TYPEOF(le.name_suffix))Fields.Make_name_suffix((SALT311.StrType)le.name_suffix);
    clean_name_suffix_Invalid := Fields.InValid_name_suffix((SALT311.StrType)clean_name_suffix);
    SELF.name_suffix := IF(withOnfail, clean_name_suffix, le.name_suffix); // ONFAIL(CLEAN)
    SELF.name_suffix_wouldClean := TRIM((SALT311.StrType)le.name_suffix) <> TRIM((SALT311.StrType)clean_name_suffix);
    SELF.name_score_Invalid := Fields.InValid_name_score((SALT311.StrType)le.name_score);
    clean_name_score := (TYPEOF(le.name_score))Fields.Make_name_score((SALT311.StrType)le.name_score);
    clean_name_score_Invalid := Fields.InValid_name_score((SALT311.StrType)clean_name_score);
    SELF.name_score := IF(withOnfail, clean_name_score, le.name_score); // ONFAIL(CLEAN)
    SELF.name_score_wouldClean := TRIM((SALT311.StrType)le.name_score) <> TRIM((SALT311.StrType)clean_name_score);
    SELF.addressseq_Invalid := Fields.InValid_addressseq((SALT311.StrType)le.addressseq);
    clean_addressseq := (TYPEOF(le.addressseq))Fields.Make_addressseq((SALT311.StrType)le.addressseq);
    clean_addressseq_Invalid := Fields.InValid_addressseq((SALT311.StrType)clean_addressseq);
    SELF.addressseq := IF(withOnfail, clean_addressseq, le.addressseq); // ONFAIL(CLEAN)
    SELF.addressseq_wouldClean := TRIM((SALT311.StrType)le.addressseq) <> TRIM((SALT311.StrType)clean_addressseq);
    SELF.orig_address_create_date_Invalid := Fields.InValid_orig_address_create_date((SALT311.StrType)le.orig_address_create_date);
    clean_orig_address_create_date := (TYPEOF(le.orig_address_create_date))Fields.Make_orig_address_create_date((SALT311.StrType)le.orig_address_create_date);
    clean_orig_address_create_date_Invalid := Fields.InValid_orig_address_create_date((SALT311.StrType)clean_orig_address_create_date);
    SELF.orig_address_create_date := IF(withOnfail, clean_orig_address_create_date, le.orig_address_create_date); // ONFAIL(CLEAN)
    SELF.orig_address_create_date_wouldClean := TRIM((SALT311.StrType)le.orig_address_create_date) <> TRIM((SALT311.StrType)clean_orig_address_create_date);
    SELF.orig_address_update_date_Invalid := Fields.InValid_orig_address_update_date((SALT311.StrType)le.orig_address_update_date);
    clean_orig_address_update_date := (TYPEOF(le.orig_address_update_date))Fields.Make_orig_address_update_date((SALT311.StrType)le.orig_address_update_date);
    clean_orig_address_update_date_Invalid := Fields.InValid_orig_address_update_date((SALT311.StrType)clean_orig_address_update_date);
    SELF.orig_address_update_date := IF(withOnfail, clean_orig_address_update_date, le.orig_address_update_date); // ONFAIL(CLEAN)
    SELF.orig_address_update_date_wouldClean := TRIM((SALT311.StrType)le.orig_address_update_date) <> TRIM((SALT311.StrType)clean_orig_address_update_date);
    SELF.orig_prim_range_Invalid := Fields.InValid_orig_prim_range((SALT311.StrType)le.orig_prim_range);
    clean_orig_prim_range := (TYPEOF(le.orig_prim_range))Fields.Make_orig_prim_range((SALT311.StrType)le.orig_prim_range);
    clean_orig_prim_range_Invalid := Fields.InValid_orig_prim_range((SALT311.StrType)clean_orig_prim_range);
    SELF.orig_prim_range := IF(withOnfail, clean_orig_prim_range, le.orig_prim_range); // ONFAIL(CLEAN)
    SELF.orig_prim_range_wouldClean := TRIM((SALT311.StrType)le.orig_prim_range) <> TRIM((SALT311.StrType)clean_orig_prim_range);
    SELF.orig_predir_Invalid := Fields.InValid_orig_predir((SALT311.StrType)le.orig_predir);
    clean_orig_predir := (TYPEOF(le.orig_predir))Fields.Make_orig_predir((SALT311.StrType)le.orig_predir);
    clean_orig_predir_Invalid := Fields.InValid_orig_predir((SALT311.StrType)clean_orig_predir);
    SELF.orig_predir := IF(withOnfail, clean_orig_predir, le.orig_predir); // ONFAIL(CLEAN)
    SELF.orig_predir_wouldClean := TRIM((SALT311.StrType)le.orig_predir) <> TRIM((SALT311.StrType)clean_orig_predir);
    SELF.orig_prim_name_Invalid := Fields.InValid_orig_prim_name((SALT311.StrType)le.orig_prim_name);
    clean_orig_prim_name := (TYPEOF(le.orig_prim_name))Fields.Make_orig_prim_name((SALT311.StrType)le.orig_prim_name);
    clean_orig_prim_name_Invalid := Fields.InValid_orig_prim_name((SALT311.StrType)clean_orig_prim_name);
    SELF.orig_prim_name := IF(withOnfail, clean_orig_prim_name, le.orig_prim_name); // ONFAIL(CLEAN)
    SELF.orig_prim_name_wouldClean := TRIM((SALT311.StrType)le.orig_prim_name) <> TRIM((SALT311.StrType)clean_orig_prim_name);
    SELF.orig_addr_suffix_Invalid := Fields.InValid_orig_addr_suffix((SALT311.StrType)le.orig_addr_suffix);
    clean_orig_addr_suffix := (TYPEOF(le.orig_addr_suffix))Fields.Make_orig_addr_suffix((SALT311.StrType)le.orig_addr_suffix);
    clean_orig_addr_suffix_Invalid := Fields.InValid_orig_addr_suffix((SALT311.StrType)clean_orig_addr_suffix);
    SELF.orig_addr_suffix := IF(withOnfail, clean_orig_addr_suffix, le.orig_addr_suffix); // ONFAIL(CLEAN)
    SELF.orig_addr_suffix_wouldClean := TRIM((SALT311.StrType)le.orig_addr_suffix) <> TRIM((SALT311.StrType)clean_orig_addr_suffix);
    SELF.orig_postdir_Invalid := Fields.InValid_orig_postdir((SALT311.StrType)le.orig_postdir);
    clean_orig_postdir := (TYPEOF(le.orig_postdir))Fields.Make_orig_postdir((SALT311.StrType)le.orig_postdir);
    clean_orig_postdir_Invalid := Fields.InValid_orig_postdir((SALT311.StrType)clean_orig_postdir);
    SELF.orig_postdir := IF(withOnfail, clean_orig_postdir, le.orig_postdir); // ONFAIL(CLEAN)
    SELF.orig_postdir_wouldClean := TRIM((SALT311.StrType)le.orig_postdir) <> TRIM((SALT311.StrType)clean_orig_postdir);
    SELF.orig_unit_desig_Invalid := Fields.InValid_orig_unit_desig((SALT311.StrType)le.orig_unit_desig);
    clean_orig_unit_desig := (TYPEOF(le.orig_unit_desig))Fields.Make_orig_unit_desig((SALT311.StrType)le.orig_unit_desig);
    clean_orig_unit_desig_Invalid := Fields.InValid_orig_unit_desig((SALT311.StrType)clean_orig_unit_desig);
    SELF.orig_unit_desig := IF(withOnfail, clean_orig_unit_desig, le.orig_unit_desig); // ONFAIL(CLEAN)
    SELF.orig_unit_desig_wouldClean := TRIM((SALT311.StrType)le.orig_unit_desig) <> TRIM((SALT311.StrType)clean_orig_unit_desig);
    SELF.orig_sec_range_Invalid := Fields.InValid_orig_sec_range((SALT311.StrType)le.orig_sec_range);
    clean_orig_sec_range := (TYPEOF(le.orig_sec_range))Fields.Make_orig_sec_range((SALT311.StrType)le.orig_sec_range);
    clean_orig_sec_range_Invalid := Fields.InValid_orig_sec_range((SALT311.StrType)clean_orig_sec_range);
    SELF.orig_sec_range := IF(withOnfail, clean_orig_sec_range, le.orig_sec_range); // ONFAIL(CLEAN)
    SELF.orig_sec_range_wouldClean := TRIM((SALT311.StrType)le.orig_sec_range) <> TRIM((SALT311.StrType)clean_orig_sec_range);
    SELF.orig_city_Invalid := Fields.InValid_orig_city((SALT311.StrType)le.orig_city);
    clean_orig_city := (TYPEOF(le.orig_city))Fields.Make_orig_city((SALT311.StrType)le.orig_city);
    clean_orig_city_Invalid := Fields.InValid_orig_city((SALT311.StrType)clean_orig_city);
    SELF.orig_city := IF(withOnfail, clean_orig_city, le.orig_city); // ONFAIL(CLEAN)
    SELF.orig_city_wouldClean := TRIM((SALT311.StrType)le.orig_city) <> TRIM((SALT311.StrType)clean_orig_city);
    SELF.orig_state_Invalid := Fields.InValid_orig_state((SALT311.StrType)le.orig_state);
    clean_orig_state := (TYPEOF(le.orig_state))Fields.Make_orig_state((SALT311.StrType)le.orig_state);
    clean_orig_state_Invalid := Fields.InValid_orig_state((SALT311.StrType)clean_orig_state);
    SELF.orig_state := IF(withOnfail, clean_orig_state, le.orig_state); // ONFAIL(CLEAN)
    SELF.orig_state_wouldClean := TRIM((SALT311.StrType)le.orig_state) <> TRIM((SALT311.StrType)clean_orig_state);
    SELF.orig_zipcode_Invalid := Fields.InValid_orig_zipcode((SALT311.StrType)le.orig_zipcode);
    clean_orig_zipcode := (TYPEOF(le.orig_zipcode))Fields.Make_orig_zipcode((SALT311.StrType)le.orig_zipcode);
    clean_orig_zipcode_Invalid := Fields.InValid_orig_zipcode((SALT311.StrType)clean_orig_zipcode);
    SELF.orig_zipcode := IF(withOnfail, clean_orig_zipcode, le.orig_zipcode); // ONFAIL(CLEAN)
    SELF.orig_zipcode_wouldClean := TRIM((SALT311.StrType)le.orig_zipcode) <> TRIM((SALT311.StrType)clean_orig_zipcode);
    SELF.orig_zipcode4_Invalid := Fields.InValid_orig_zipcode4((SALT311.StrType)le.orig_zipcode4);
    clean_orig_zipcode4 := (TYPEOF(le.orig_zipcode4))Fields.Make_orig_zipcode4((SALT311.StrType)le.orig_zipcode4);
    clean_orig_zipcode4_Invalid := Fields.InValid_orig_zipcode4((SALT311.StrType)clean_orig_zipcode4);
    SELF.orig_zipcode4 := IF(withOnfail, clean_orig_zipcode4, le.orig_zipcode4); // ONFAIL(CLEAN)
    SELF.orig_zipcode4_wouldClean := TRIM((SALT311.StrType)le.orig_zipcode4) <> TRIM((SALT311.StrType)clean_orig_zipcode4);
    SELF.prim_range_Invalid := Fields.InValid_prim_range((SALT311.StrType)le.prim_range);
    clean_prim_range := (TYPEOF(le.prim_range))Fields.Make_prim_range((SALT311.StrType)le.prim_range);
    clean_prim_range_Invalid := Fields.InValid_prim_range((SALT311.StrType)clean_prim_range);
    SELF.prim_range := IF(withOnfail, clean_prim_range, le.prim_range); // ONFAIL(CLEAN)
    SELF.prim_range_wouldClean := TRIM((SALT311.StrType)le.prim_range) <> TRIM((SALT311.StrType)clean_prim_range);
    SELF.predir_Invalid := Fields.InValid_predir((SALT311.StrType)le.predir);
    clean_predir := (TYPEOF(le.predir))Fields.Make_predir((SALT311.StrType)le.predir);
    clean_predir_Invalid := Fields.InValid_predir((SALT311.StrType)clean_predir);
    SELF.predir := IF(withOnfail, clean_predir, le.predir); // ONFAIL(CLEAN)
    SELF.predir_wouldClean := TRIM((SALT311.StrType)le.predir) <> TRIM((SALT311.StrType)clean_predir);
    SELF.prim_name_Invalid := Fields.InValid_prim_name((SALT311.StrType)le.prim_name);
    clean_prim_name := (TYPEOF(le.prim_name))Fields.Make_prim_name((SALT311.StrType)le.prim_name);
    clean_prim_name_Invalid := Fields.InValid_prim_name((SALT311.StrType)clean_prim_name);
    SELF.prim_name := IF(withOnfail, clean_prim_name, le.prim_name); // ONFAIL(CLEAN)
    SELF.prim_name_wouldClean := TRIM((SALT311.StrType)le.prim_name) <> TRIM((SALT311.StrType)clean_prim_name);
    SELF.addr_suffix_Invalid := Fields.InValid_addr_suffix((SALT311.StrType)le.addr_suffix);
    clean_addr_suffix := (TYPEOF(le.addr_suffix))Fields.Make_addr_suffix((SALT311.StrType)le.addr_suffix);
    clean_addr_suffix_Invalid := Fields.InValid_addr_suffix((SALT311.StrType)clean_addr_suffix);
    SELF.addr_suffix := IF(withOnfail, clean_addr_suffix, le.addr_suffix); // ONFAIL(CLEAN)
    SELF.addr_suffix_wouldClean := TRIM((SALT311.StrType)le.addr_suffix) <> TRIM((SALT311.StrType)clean_addr_suffix);
    SELF.postdir_Invalid := Fields.InValid_postdir((SALT311.StrType)le.postdir);
    clean_postdir := (TYPEOF(le.postdir))Fields.Make_postdir((SALT311.StrType)le.postdir);
    clean_postdir_Invalid := Fields.InValid_postdir((SALT311.StrType)clean_postdir);
    SELF.postdir := IF(withOnfail, clean_postdir, le.postdir); // ONFAIL(CLEAN)
    SELF.postdir_wouldClean := TRIM((SALT311.StrType)le.postdir) <> TRIM((SALT311.StrType)clean_postdir);
    SELF.unit_desig_Invalid := Fields.InValid_unit_desig((SALT311.StrType)le.unit_desig);
    clean_unit_desig := (TYPEOF(le.unit_desig))Fields.Make_unit_desig((SALT311.StrType)le.unit_desig);
    clean_unit_desig_Invalid := Fields.InValid_unit_desig((SALT311.StrType)clean_unit_desig);
    SELF.unit_desig := IF(withOnfail, clean_unit_desig, le.unit_desig); // ONFAIL(CLEAN)
    SELF.unit_desig_wouldClean := TRIM((SALT311.StrType)le.unit_desig) <> TRIM((SALT311.StrType)clean_unit_desig);
    SELF.sec_range_Invalid := Fields.InValid_sec_range((SALT311.StrType)le.sec_range);
    clean_sec_range := (TYPEOF(le.sec_range))Fields.Make_sec_range((SALT311.StrType)le.sec_range);
    clean_sec_range_Invalid := Fields.InValid_sec_range((SALT311.StrType)clean_sec_range);
    SELF.sec_range := IF(withOnfail, clean_sec_range, le.sec_range); // ONFAIL(CLEAN)
    SELF.sec_range_wouldClean := TRIM((SALT311.StrType)le.sec_range) <> TRIM((SALT311.StrType)clean_sec_range);
    SELF.p_city_name_Invalid := Fields.InValid_p_city_name((SALT311.StrType)le.p_city_name);
    clean_p_city_name := (TYPEOF(le.p_city_name))Fields.Make_p_city_name((SALT311.StrType)le.p_city_name);
    clean_p_city_name_Invalid := Fields.InValid_p_city_name((SALT311.StrType)clean_p_city_name);
    SELF.p_city_name := IF(withOnfail, clean_p_city_name, le.p_city_name); // ONFAIL(CLEAN)
    SELF.p_city_name_wouldClean := TRIM((SALT311.StrType)le.p_city_name) <> TRIM((SALT311.StrType)clean_p_city_name);
    SELF.v_city_name_Invalid := Fields.InValid_v_city_name((SALT311.StrType)le.v_city_name);
    clean_v_city_name := (TYPEOF(le.v_city_name))Fields.Make_v_city_name((SALT311.StrType)le.v_city_name);
    clean_v_city_name_Invalid := Fields.InValid_v_city_name((SALT311.StrType)clean_v_city_name);
    SELF.v_city_name := IF(withOnfail, clean_v_city_name, le.v_city_name); // ONFAIL(CLEAN)
    SELF.v_city_name_wouldClean := TRIM((SALT311.StrType)le.v_city_name) <> TRIM((SALT311.StrType)clean_v_city_name);
    SELF.st_Invalid := Fields.InValid_st((SALT311.StrType)le.st);
    clean_st := (TYPEOF(le.st))Fields.Make_st((SALT311.StrType)le.st);
    clean_st_Invalid := Fields.InValid_st((SALT311.StrType)clean_st);
    SELF.st := IF(withOnfail, clean_st, le.st); // ONFAIL(CLEAN)
    SELF.st_wouldClean := TRIM((SALT311.StrType)le.st) <> TRIM((SALT311.StrType)clean_st);
    SELF.zip_Invalid := Fields.InValid_zip((SALT311.StrType)le.zip);
    clean_zip := (TYPEOF(le.zip))Fields.Make_zip((SALT311.StrType)le.zip);
    clean_zip_Invalid := Fields.InValid_zip((SALT311.StrType)clean_zip);
    SELF.zip := IF(withOnfail, clean_zip, le.zip); // ONFAIL(CLEAN)
    SELF.zip_wouldClean := TRIM((SALT311.StrType)le.zip) <> TRIM((SALT311.StrType)clean_zip);
    SELF.zip4_Invalid := Fields.InValid_zip4((SALT311.StrType)le.zip4);
    clean_zip4 := (TYPEOF(le.zip4))Fields.Make_zip4((SALT311.StrType)le.zip4);
    clean_zip4_Invalid := Fields.InValid_zip4((SALT311.StrType)clean_zip4);
    SELF.zip4 := IF(withOnfail, clean_zip4, le.zip4); // ONFAIL(CLEAN)
    SELF.zip4_wouldClean := TRIM((SALT311.StrType)le.zip4) <> TRIM((SALT311.StrType)clean_zip4);
    SELF.cart_Invalid := Fields.InValid_cart((SALT311.StrType)le.cart);
    clean_cart := (TYPEOF(le.cart))Fields.Make_cart((SALT311.StrType)le.cart);
    clean_cart_Invalid := Fields.InValid_cart((SALT311.StrType)clean_cart);
    SELF.cart := IF(withOnfail, clean_cart, le.cart); // ONFAIL(CLEAN)
    SELF.cart_wouldClean := TRIM((SALT311.StrType)le.cart) <> TRIM((SALT311.StrType)clean_cart);
    SELF.cr_sort_sz_Invalid := Fields.InValid_cr_sort_sz((SALT311.StrType)le.cr_sort_sz);
    clean_cr_sort_sz := (TYPEOF(le.cr_sort_sz))Fields.Make_cr_sort_sz((SALT311.StrType)le.cr_sort_sz);
    clean_cr_sort_sz_Invalid := Fields.InValid_cr_sort_sz((SALT311.StrType)clean_cr_sort_sz);
    SELF.cr_sort_sz := IF(withOnfail, clean_cr_sort_sz, le.cr_sort_sz); // ONFAIL(CLEAN)
    SELF.cr_sort_sz_wouldClean := TRIM((SALT311.StrType)le.cr_sort_sz) <> TRIM((SALT311.StrType)clean_cr_sort_sz);
    SELF.lot_Invalid := Fields.InValid_lot((SALT311.StrType)le.lot);
    clean_lot := (TYPEOF(le.lot))Fields.Make_lot((SALT311.StrType)le.lot);
    clean_lot_Invalid := Fields.InValid_lot((SALT311.StrType)clean_lot);
    SELF.lot := IF(withOnfail, clean_lot, le.lot); // ONFAIL(CLEAN)
    SELF.lot_wouldClean := TRIM((SALT311.StrType)le.lot) <> TRIM((SALT311.StrType)clean_lot);
    SELF.lot_order_Invalid := Fields.InValid_lot_order((SALT311.StrType)le.lot_order);
    clean_lot_order := (TYPEOF(le.lot_order))Fields.Make_lot_order((SALT311.StrType)le.lot_order);
    clean_lot_order_Invalid := Fields.InValid_lot_order((SALT311.StrType)clean_lot_order);
    SELF.lot_order := IF(withOnfail, clean_lot_order, le.lot_order); // ONFAIL(CLEAN)
    SELF.lot_order_wouldClean := TRIM((SALT311.StrType)le.lot_order) <> TRIM((SALT311.StrType)clean_lot_order);
    SELF.dbpc_Invalid := Fields.InValid_dbpc((SALT311.StrType)le.dbpc);
    clean_dbpc := (TYPEOF(le.dbpc))Fields.Make_dbpc((SALT311.StrType)le.dbpc);
    clean_dbpc_Invalid := Fields.InValid_dbpc((SALT311.StrType)clean_dbpc);
    SELF.dbpc := IF(withOnfail, clean_dbpc, le.dbpc); // ONFAIL(CLEAN)
    SELF.dbpc_wouldClean := TRIM((SALT311.StrType)le.dbpc) <> TRIM((SALT311.StrType)clean_dbpc);
    SELF.chk_digit_Invalid := Fields.InValid_chk_digit((SALT311.StrType)le.chk_digit);
    clean_chk_digit := (TYPEOF(le.chk_digit))Fields.Make_chk_digit((SALT311.StrType)le.chk_digit);
    clean_chk_digit_Invalid := Fields.InValid_chk_digit((SALT311.StrType)clean_chk_digit);
    SELF.chk_digit := IF(withOnfail, clean_chk_digit, le.chk_digit); // ONFAIL(CLEAN)
    SELF.chk_digit_wouldClean := TRIM((SALT311.StrType)le.chk_digit) <> TRIM((SALT311.StrType)clean_chk_digit);
    SELF.rec_type_Invalid := Fields.InValid_rec_type((SALT311.StrType)le.rec_type);
    clean_rec_type := (TYPEOF(le.rec_type))Fields.Make_rec_type((SALT311.StrType)le.rec_type);
    clean_rec_type_Invalid := Fields.InValid_rec_type((SALT311.StrType)clean_rec_type);
    SELF.rec_type := IF(withOnfail, clean_rec_type, le.rec_type); // ONFAIL(CLEAN)
    SELF.rec_type_wouldClean := TRIM((SALT311.StrType)le.rec_type) <> TRIM((SALT311.StrType)clean_rec_type);
    SELF.county_Invalid := Fields.InValid_county((SALT311.StrType)le.county);
    clean_county := (TYPEOF(le.county))Fields.Make_county((SALT311.StrType)le.county);
    clean_county_Invalid := Fields.InValid_county((SALT311.StrType)clean_county);
    SELF.county := IF(withOnfail, clean_county, le.county); // ONFAIL(CLEAN)
    SELF.county_wouldClean := TRIM((SALT311.StrType)le.county) <> TRIM((SALT311.StrType)clean_county);
    SELF.geo_lat_Invalid := Fields.InValid_geo_lat((SALT311.StrType)le.geo_lat);
    clean_geo_lat := (TYPEOF(le.geo_lat))Fields.Make_geo_lat((SALT311.StrType)le.geo_lat);
    clean_geo_lat_Invalid := Fields.InValid_geo_lat((SALT311.StrType)clean_geo_lat);
    SELF.geo_lat := IF(withOnfail, clean_geo_lat, le.geo_lat); // ONFAIL(CLEAN)
    SELF.geo_lat_wouldClean := TRIM((SALT311.StrType)le.geo_lat) <> TRIM((SALT311.StrType)clean_geo_lat);
    SELF.geo_long_Invalid := Fields.InValid_geo_long((SALT311.StrType)le.geo_long);
    clean_geo_long := (TYPEOF(le.geo_long))Fields.Make_geo_long((SALT311.StrType)le.geo_long);
    clean_geo_long_Invalid := Fields.InValid_geo_long((SALT311.StrType)clean_geo_long);
    SELF.geo_long := IF(withOnfail, clean_geo_long, le.geo_long); // ONFAIL(CLEAN)
    SELF.geo_long_wouldClean := TRIM((SALT311.StrType)le.geo_long) <> TRIM((SALT311.StrType)clean_geo_long);
    SELF.msa_Invalid := Fields.InValid_msa((SALT311.StrType)le.msa);
    clean_msa := (TYPEOF(le.msa))Fields.Make_msa((SALT311.StrType)le.msa);
    clean_msa_Invalid := Fields.InValid_msa((SALT311.StrType)clean_msa);
    SELF.msa := IF(withOnfail, clean_msa, le.msa); // ONFAIL(CLEAN)
    SELF.msa_wouldClean := TRIM((SALT311.StrType)le.msa) <> TRIM((SALT311.StrType)clean_msa);
    SELF.geo_blk_Invalid := Fields.InValid_geo_blk((SALT311.StrType)le.geo_blk);
    clean_geo_blk := (TYPEOF(le.geo_blk))Fields.Make_geo_blk((SALT311.StrType)le.geo_blk);
    clean_geo_blk_Invalid := Fields.InValid_geo_blk((SALT311.StrType)clean_geo_blk);
    SELF.geo_blk := IF(withOnfail, clean_geo_blk, le.geo_blk); // ONFAIL(CLEAN)
    SELF.geo_blk_wouldClean := TRIM((SALT311.StrType)le.geo_blk) <> TRIM((SALT311.StrType)clean_geo_blk);
    SELF.geo_match_Invalid := Fields.InValid_geo_match((SALT311.StrType)le.geo_match);
    clean_geo_match := (TYPEOF(le.geo_match))Fields.Make_geo_match((SALT311.StrType)le.geo_match);
    clean_geo_match_Invalid := Fields.InValid_geo_match((SALT311.StrType)clean_geo_match);
    SELF.geo_match := IF(withOnfail, clean_geo_match, le.geo_match); // ONFAIL(CLEAN)
    SELF.geo_match_wouldClean := TRIM((SALT311.StrType)le.geo_match) <> TRIM((SALT311.StrType)clean_geo_match);
    SELF.err_stat_Invalid := Fields.InValid_err_stat((SALT311.StrType)le.err_stat);
    clean_err_stat := (TYPEOF(le.err_stat))Fields.Make_err_stat((SALT311.StrType)le.err_stat);
    clean_err_stat_Invalid := Fields.InValid_err_stat((SALT311.StrType)clean_err_stat);
    SELF.err_stat := IF(withOnfail, clean_err_stat, le.err_stat); // ONFAIL(CLEAN)
    SELF.err_stat_wouldClean := TRIM((SALT311.StrType)le.err_stat) <> TRIM((SALT311.StrType)clean_err_stat);
    SELF.delete_flag_Invalid := Fields.InValid_delete_flag((SALT311.StrType)le.delete_flag);
    clean_delete_flag := (TYPEOF(le.delete_flag))Fields.Make_delete_flag((SALT311.StrType)le.delete_flag);
    clean_delete_flag_Invalid := Fields.InValid_delete_flag((SALT311.StrType)clean_delete_flag);
    SELF.delete_flag := IF(withOnfail, clean_delete_flag, le.delete_flag); // ONFAIL(CLEAN)
    SELF.delete_flag_wouldClean := TRIM((SALT311.StrType)le.delete_flag) <> TRIM((SALT311.StrType)clean_delete_flag);
    SELF.delete_file_date_Invalid := Fields.InValid_delete_file_date((SALT311.StrType)le.delete_file_date);
    clean_delete_file_date := (TYPEOF(le.delete_file_date))Fields.Make_delete_file_date((SALT311.StrType)le.delete_file_date);
    clean_delete_file_date_Invalid := Fields.InValid_delete_file_date((SALT311.StrType)clean_delete_file_date);
    SELF.delete_file_date := IF(withOnfail, clean_delete_file_date, le.delete_file_date); // ONFAIL(CLEAN)
    SELF.delete_file_date_wouldClean := TRIM((SALT311.StrType)le.delete_file_date) <> TRIM((SALT311.StrType)clean_delete_file_date);
    SELF.suppression_code_Invalid := Fields.InValid_suppression_code((SALT311.StrType)le.suppression_code);
    clean_suppression_code := (TYPEOF(le.suppression_code))Fields.Make_suppression_code((SALT311.StrType)le.suppression_code);
    clean_suppression_code_Invalid := Fields.InValid_suppression_code((SALT311.StrType)clean_suppression_code);
    SELF.suppression_code := IF(withOnfail, clean_suppression_code, le.suppression_code); // ONFAIL(CLEAN)
    SELF.suppression_code_wouldClean := TRIM((SALT311.StrType)le.suppression_code) <> TRIM((SALT311.StrType)clean_suppression_code);
    SELF.deceased_ind_Invalid := Fields.InValid_deceased_ind((SALT311.StrType)le.deceased_ind);
    clean_deceased_ind := (TYPEOF(le.deceased_ind))Fields.Make_deceased_ind((SALT311.StrType)le.deceased_ind);
    clean_deceased_ind_Invalid := Fields.InValid_deceased_ind((SALT311.StrType)clean_deceased_ind);
    SELF.deceased_ind := IF(withOnfail, clean_deceased_ind, le.deceased_ind); // ONFAIL(CLEAN)
    SELF.deceased_ind_wouldClean := TRIM((SALT311.StrType)le.deceased_ind) <> TRIM((SALT311.StrType)clean_deceased_ind);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_File);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.seq_rec_id_Invalid << 0 ) + ( le.did_Invalid << 3 ) + ( le.did_score_field_Invalid << 6 ) + ( le.current_rec_flag_Invalid << 9 ) + ( le.current_experian_pin_Invalid << 12 ) + ( le.date_first_seen_Invalid << 15 ) + ( le.date_last_seen_Invalid << 18 ) + ( le.date_vendor_first_reported_Invalid << 21 ) + ( le.date_vendor_last_reported_Invalid << 24 ) + ( le.encrypted_experian_pin_Invalid << 27 ) + ( le.social_security_number_Invalid << 30 ) + ( le.date_of_birth_Invalid << 33 ) + ( le.telephone_Invalid << 36 ) + ( le.gender_Invalid << 39 ) + ( le.additional_name_count_Invalid << 42 ) + ( le.previous_address_count_Invalid << 45 ) + ( le.nametype_Invalid << 48 ) + ( le.orig_consumer_create_date_Invalid << 51 ) + ( le.orig_fname_Invalid << 54 ) + ( le.orig_mname_Invalid << 57 ) + ( le.orig_lname_Invalid << 60 );
    SELF.ScrubsBits2 := ( le.orig_suffix_Invalid << 0 ) + ( le.title_Invalid << 3 ) + ( le.fname_Invalid << 6 ) + ( le.mname_Invalid << 9 ) + ( le.lname_Invalid << 12 ) + ( le.name_suffix_Invalid << 15 ) + ( le.name_score_Invalid << 18 ) + ( le.addressseq_Invalid << 21 ) + ( le.orig_address_create_date_Invalid << 24 ) + ( le.orig_address_update_date_Invalid << 27 ) + ( le.orig_prim_range_Invalid << 30 ) + ( le.orig_predir_Invalid << 33 ) + ( le.orig_prim_name_Invalid << 36 ) + ( le.orig_addr_suffix_Invalid << 39 ) + ( le.orig_postdir_Invalid << 42 ) + ( le.orig_unit_desig_Invalid << 45 ) + ( le.orig_sec_range_Invalid << 48 ) + ( le.orig_city_Invalid << 51 ) + ( le.orig_state_Invalid << 54 ) + ( le.orig_zipcode_Invalid << 57 ) + ( le.orig_zipcode4_Invalid << 60 );
    SELF.ScrubsBits3 := ( le.prim_range_Invalid << 0 ) + ( le.predir_Invalid << 3 ) + ( le.prim_name_Invalid << 6 ) + ( le.addr_suffix_Invalid << 9 ) + ( le.postdir_Invalid << 12 ) + ( le.unit_desig_Invalid << 15 ) + ( le.sec_range_Invalid << 18 ) + ( le.p_city_name_Invalid << 21 ) + ( le.v_city_name_Invalid << 24 ) + ( le.st_Invalid << 27 ) + ( le.zip_Invalid << 30 ) + ( le.zip4_Invalid << 33 ) + ( le.cart_Invalid << 36 ) + ( le.cr_sort_sz_Invalid << 39 ) + ( le.lot_Invalid << 42 ) + ( le.lot_order_Invalid << 45 ) + ( le.dbpc_Invalid << 48 ) + ( le.chk_digit_Invalid << 51 ) + ( le.rec_type_Invalid << 54 ) + ( le.county_Invalid << 57 ) + ( le.geo_lat_Invalid << 60 );
    SELF.ScrubsBits4 := ( le.geo_long_Invalid << 0 ) + ( le.msa_Invalid << 3 ) + ( le.geo_blk_Invalid << 6 ) + ( le.geo_match_Invalid << 9 ) + ( le.err_stat_Invalid << 12 ) + ( le.delete_flag_Invalid << 15 ) + ( le.delete_file_date_Invalid << 18 ) + ( le.suppression_code_Invalid << 21 ) + ( le.deceased_ind_Invalid << 24 );
    SELF.ScrubsCleanBits1 := ( IF(le.seq_rec_id_wouldClean, 1, 0) << 0 ) + ( IF(le.did_wouldClean, 1, 0) << 1 ) + ( IF(le.did_score_field_wouldClean, 1, 0) << 2 ) + ( IF(le.current_rec_flag_wouldClean, 1, 0) << 3 ) + ( IF(le.current_experian_pin_wouldClean, 1, 0) << 4 ) + ( IF(le.date_first_seen_wouldClean, 1, 0) << 5 ) + ( IF(le.date_last_seen_wouldClean, 1, 0) << 6 ) + ( IF(le.date_vendor_first_reported_wouldClean, 1, 0) << 7 ) + ( IF(le.date_vendor_last_reported_wouldClean, 1, 0) << 8 ) + ( IF(le.encrypted_experian_pin_wouldClean, 1, 0) << 9 ) + ( IF(le.social_security_number_wouldClean, 1, 0) << 10 ) + ( IF(le.date_of_birth_wouldClean, 1, 0) << 11 ) + ( IF(le.telephone_wouldClean, 1, 0) << 12 ) + ( IF(le.gender_wouldClean, 1, 0) << 13 ) + ( IF(le.additional_name_count_wouldClean, 1, 0) << 14 ) + ( IF(le.previous_address_count_wouldClean, 1, 0) << 15 ) + ( IF(le.nametype_wouldClean, 1, 0) << 16 ) + ( IF(le.orig_consumer_create_date_wouldClean, 1, 0) << 17 ) + ( IF(le.orig_fname_wouldClean, 1, 0) << 18 ) + ( IF(le.orig_mname_wouldClean, 1, 0) << 19 ) + ( IF(le.orig_lname_wouldClean, 1, 0) << 20 ) + ( IF(le.orig_suffix_wouldClean, 1, 0) << 21 ) + ( IF(le.title_wouldClean, 1, 0) << 22 ) + ( IF(le.fname_wouldClean, 1, 0) << 23 ) + ( IF(le.mname_wouldClean, 1, 0) << 24 ) + ( IF(le.lname_wouldClean, 1, 0) << 25 ) + ( IF(le.name_suffix_wouldClean, 1, 0) << 26 ) + ( IF(le.name_score_wouldClean, 1, 0) << 27 ) + ( IF(le.addressseq_wouldClean, 1, 0) << 28 ) + ( IF(le.orig_address_create_date_wouldClean, 1, 0) << 29 ) + ( IF(le.orig_address_update_date_wouldClean, 1, 0) << 30 ) + ( IF(le.orig_prim_range_wouldClean, 1, 0) << 31 ) + ( IF(le.orig_predir_wouldClean, 1, 0) << 32 ) + ( IF(le.orig_prim_name_wouldClean, 1, 0) << 33 ) + ( IF(le.orig_addr_suffix_wouldClean, 1, 0) << 34 ) + ( IF(le.orig_postdir_wouldClean, 1, 0) << 35 ) + ( IF(le.orig_unit_desig_wouldClean, 1, 0) << 36 ) + ( IF(le.orig_sec_range_wouldClean, 1, 0) << 37 ) + ( IF(le.orig_city_wouldClean, 1, 0) << 38 ) + ( IF(le.orig_state_wouldClean, 1, 0) << 39 ) + ( IF(le.orig_zipcode_wouldClean, 1, 0) << 40 ) + ( IF(le.orig_zipcode4_wouldClean, 1, 0) << 41 ) + ( IF(le.prim_range_wouldClean, 1, 0) << 42 ) + ( IF(le.predir_wouldClean, 1, 0) << 43 ) + ( IF(le.prim_name_wouldClean, 1, 0) << 44 ) + ( IF(le.addr_suffix_wouldClean, 1, 0) << 45 ) + ( IF(le.postdir_wouldClean, 1, 0) << 46 ) + ( IF(le.unit_desig_wouldClean, 1, 0) << 47 ) + ( IF(le.sec_range_wouldClean, 1, 0) << 48 ) + ( IF(le.p_city_name_wouldClean, 1, 0) << 49 ) + ( IF(le.v_city_name_wouldClean, 1, 0) << 50 ) + ( IF(le.st_wouldClean, 1, 0) << 51 ) + ( IF(le.zip_wouldClean, 1, 0) << 52 ) + ( IF(le.zip4_wouldClean, 1, 0) << 53 ) + ( IF(le.cart_wouldClean, 1, 0) << 54 ) + ( IF(le.cr_sort_sz_wouldClean, 1, 0) << 55 ) + ( IF(le.lot_wouldClean, 1, 0) << 56 ) + ( IF(le.lot_order_wouldClean, 1, 0) << 57 ) + ( IF(le.dbpc_wouldClean, 1, 0) << 58 ) + ( IF(le.chk_digit_wouldClean, 1, 0) << 59 ) + ( IF(le.rec_type_wouldClean, 1, 0) << 60 ) + ( IF(le.county_wouldClean, 1, 0) << 61 ) + ( IF(le.geo_lat_wouldClean, 1, 0) << 62 ) + ( IF(le.geo_long_wouldClean, 1, 0) << 63 );
    SELF.ScrubsCleanBits2 := ( IF(le.msa_wouldClean, 1, 0) << 0 ) + ( IF(le.geo_blk_wouldClean, 1, 0) << 1 ) + ( IF(le.geo_match_wouldClean, 1, 0) << 2 ) + ( IF(le.err_stat_wouldClean, 1, 0) << 3 ) + ( IF(le.delete_flag_wouldClean, 1, 0) << 4 ) + ( IF(le.delete_file_date_wouldClean, 1, 0) << 5 ) + ( IF(le.suppression_code_wouldClean, 1, 0) << 6 ) + ( IF(le.deceased_ind_wouldClean, 1, 0) << 7 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
  STRING escQuotes(STRING s) := STD.Str.FindReplace(s,'\'','\\\'');
  Rule_Layout IntoRule(BitmapInfile le, UNSIGNED c) := TRANSFORM
    mask := 1<<(c-1);
    hasError := (mask&le.ScrubsBits1)>0 OR (mask&le.ScrubsBits2)>0 OR (mask&le.ScrubsBits3)>0 OR (mask&le.ScrubsBits4)>0;
    SELF.Rules := IF(hasError,TRIM(toRuleDesc(c))+':\''+escQuotes(TRIM(toErrorMessage(c)))+'\'',IF(le.ScrubsBits1=0 AND le.ScrubsBits2=0 AND le.ScrubsBits3=0 AND le.ScrubsBits4=0 AND c=1,'',SKIP));
    SELF := le;
  END;
  unrolled := NORMALIZE(BitmapInfile,NumRules,IntoRule(LEFT,COUNTER));
  Rule_Layout toRoll(Rule_Layout le,Rule_Layout ri) := TRANSFORM
    SELF.Rules := TRIM(le.Rules) + IF(LENGTH(TRIM(le.Rules))>0 AND LENGTH(TRIM(ri.Rules))>0,',','') + TRIM(ri.Rules);
    SELF := le;
  END;
  EXPORT RulesInfile := ROLLUP(unrolled,toRoll(LEFT,RIGHT),EXCEPT Rules);
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_File);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.seq_rec_id_Invalid := (le.ScrubsBits1 >> 0) & 7;
    SELF.did_Invalid := (le.ScrubsBits1 >> 3) & 7;
    SELF.did_score_field_Invalid := (le.ScrubsBits1 >> 6) & 7;
    SELF.current_rec_flag_Invalid := (le.ScrubsBits1 >> 9) & 7;
    SELF.current_experian_pin_Invalid := (le.ScrubsBits1 >> 12) & 7;
    SELF.date_first_seen_Invalid := (le.ScrubsBits1 >> 15) & 7;
    SELF.date_last_seen_Invalid := (le.ScrubsBits1 >> 18) & 7;
    SELF.date_vendor_first_reported_Invalid := (le.ScrubsBits1 >> 21) & 7;
    SELF.date_vendor_last_reported_Invalid := (le.ScrubsBits1 >> 24) & 7;
    SELF.encrypted_experian_pin_Invalid := (le.ScrubsBits1 >> 27) & 7;
    SELF.social_security_number_Invalid := (le.ScrubsBits1 >> 30) & 7;
    SELF.date_of_birth_Invalid := (le.ScrubsBits1 >> 33) & 7;
    SELF.telephone_Invalid := (le.ScrubsBits1 >> 36) & 7;
    SELF.gender_Invalid := (le.ScrubsBits1 >> 39) & 7;
    SELF.additional_name_count_Invalid := (le.ScrubsBits1 >> 42) & 7;
    SELF.previous_address_count_Invalid := (le.ScrubsBits1 >> 45) & 7;
    SELF.nametype_Invalid := (le.ScrubsBits1 >> 48) & 7;
    SELF.orig_consumer_create_date_Invalid := (le.ScrubsBits1 >> 51) & 7;
    SELF.orig_fname_Invalid := (le.ScrubsBits1 >> 54) & 7;
    SELF.orig_mname_Invalid := (le.ScrubsBits1 >> 57) & 7;
    SELF.orig_lname_Invalid := (le.ScrubsBits1 >> 60) & 7;
    SELF.orig_suffix_Invalid := (le.ScrubsBits2 >> 0) & 7;
    SELF.title_Invalid := (le.ScrubsBits2 >> 3) & 7;
    SELF.fname_Invalid := (le.ScrubsBits2 >> 6) & 7;
    SELF.mname_Invalid := (le.ScrubsBits2 >> 9) & 7;
    SELF.lname_Invalid := (le.ScrubsBits2 >> 12) & 7;
    SELF.name_suffix_Invalid := (le.ScrubsBits2 >> 15) & 7;
    SELF.name_score_Invalid := (le.ScrubsBits2 >> 18) & 7;
    SELF.addressseq_Invalid := (le.ScrubsBits2 >> 21) & 7;
    SELF.orig_address_create_date_Invalid := (le.ScrubsBits2 >> 24) & 7;
    SELF.orig_address_update_date_Invalid := (le.ScrubsBits2 >> 27) & 7;
    SELF.orig_prim_range_Invalid := (le.ScrubsBits2 >> 30) & 7;
    SELF.orig_predir_Invalid := (le.ScrubsBits2 >> 33) & 7;
    SELF.orig_prim_name_Invalid := (le.ScrubsBits2 >> 36) & 7;
    SELF.orig_addr_suffix_Invalid := (le.ScrubsBits2 >> 39) & 7;
    SELF.orig_postdir_Invalid := (le.ScrubsBits2 >> 42) & 7;
    SELF.orig_unit_desig_Invalid := (le.ScrubsBits2 >> 45) & 7;
    SELF.orig_sec_range_Invalid := (le.ScrubsBits2 >> 48) & 7;
    SELF.orig_city_Invalid := (le.ScrubsBits2 >> 51) & 7;
    SELF.orig_state_Invalid := (le.ScrubsBits2 >> 54) & 7;
    SELF.orig_zipcode_Invalid := (le.ScrubsBits2 >> 57) & 7;
    SELF.orig_zipcode4_Invalid := (le.ScrubsBits2 >> 60) & 7;
    SELF.prim_range_Invalid := (le.ScrubsBits3 >> 0) & 7;
    SELF.predir_Invalid := (le.ScrubsBits3 >> 3) & 7;
    SELF.prim_name_Invalid := (le.ScrubsBits3 >> 6) & 7;
    SELF.addr_suffix_Invalid := (le.ScrubsBits3 >> 9) & 7;
    SELF.postdir_Invalid := (le.ScrubsBits3 >> 12) & 7;
    SELF.unit_desig_Invalid := (le.ScrubsBits3 >> 15) & 7;
    SELF.sec_range_Invalid := (le.ScrubsBits3 >> 18) & 7;
    SELF.p_city_name_Invalid := (le.ScrubsBits3 >> 21) & 7;
    SELF.v_city_name_Invalid := (le.ScrubsBits3 >> 24) & 7;
    SELF.st_Invalid := (le.ScrubsBits3 >> 27) & 7;
    SELF.zip_Invalid := (le.ScrubsBits3 >> 30) & 7;
    SELF.zip4_Invalid := (le.ScrubsBits3 >> 33) & 7;
    SELF.cart_Invalid := (le.ScrubsBits3 >> 36) & 7;
    SELF.cr_sort_sz_Invalid := (le.ScrubsBits3 >> 39) & 7;
    SELF.lot_Invalid := (le.ScrubsBits3 >> 42) & 7;
    SELF.lot_order_Invalid := (le.ScrubsBits3 >> 45) & 7;
    SELF.dbpc_Invalid := (le.ScrubsBits3 >> 48) & 7;
    SELF.chk_digit_Invalid := (le.ScrubsBits3 >> 51) & 7;
    SELF.rec_type_Invalid := (le.ScrubsBits3 >> 54) & 7;
    SELF.county_Invalid := (le.ScrubsBits3 >> 57) & 7;
    SELF.geo_lat_Invalid := (le.ScrubsBits3 >> 60) & 7;
    SELF.geo_long_Invalid := (le.ScrubsBits4 >> 0) & 7;
    SELF.msa_Invalid := (le.ScrubsBits4 >> 3) & 7;
    SELF.geo_blk_Invalid := (le.ScrubsBits4 >> 6) & 7;
    SELF.geo_match_Invalid := (le.ScrubsBits4 >> 9) & 7;
    SELF.err_stat_Invalid := (le.ScrubsBits4 >> 12) & 7;
    SELF.delete_flag_Invalid := (le.ScrubsBits4 >> 15) & 7;
    SELF.delete_file_date_Invalid := (le.ScrubsBits4 >> 18) & 7;
    SELF.suppression_code_Invalid := (le.ScrubsBits4 >> 21) & 7;
    SELF.deceased_ind_Invalid := (le.ScrubsBits4 >> 24) & 7;
    SELF.seq_rec_id_wouldClean := le.ScrubsCleanBits1 >> 0;
    SELF.did_wouldClean := le.ScrubsCleanBits1 >> 1;
    SELF.did_score_field_wouldClean := le.ScrubsCleanBits1 >> 2;
    SELF.current_rec_flag_wouldClean := le.ScrubsCleanBits1 >> 3;
    SELF.current_experian_pin_wouldClean := le.ScrubsCleanBits1 >> 4;
    SELF.date_first_seen_wouldClean := le.ScrubsCleanBits1 >> 5;
    SELF.date_last_seen_wouldClean := le.ScrubsCleanBits1 >> 6;
    SELF.date_vendor_first_reported_wouldClean := le.ScrubsCleanBits1 >> 7;
    SELF.date_vendor_last_reported_wouldClean := le.ScrubsCleanBits1 >> 8;
    SELF.encrypted_experian_pin_wouldClean := le.ScrubsCleanBits1 >> 9;
    SELF.social_security_number_wouldClean := le.ScrubsCleanBits1 >> 10;
    SELF.date_of_birth_wouldClean := le.ScrubsCleanBits1 >> 11;
    SELF.telephone_wouldClean := le.ScrubsCleanBits1 >> 12;
    SELF.gender_wouldClean := le.ScrubsCleanBits1 >> 13;
    SELF.additional_name_count_wouldClean := le.ScrubsCleanBits1 >> 14;
    SELF.previous_address_count_wouldClean := le.ScrubsCleanBits1 >> 15;
    SELF.nametype_wouldClean := le.ScrubsCleanBits1 >> 16;
    SELF.orig_consumer_create_date_wouldClean := le.ScrubsCleanBits1 >> 17;
    SELF.orig_fname_wouldClean := le.ScrubsCleanBits1 >> 18;
    SELF.orig_mname_wouldClean := le.ScrubsCleanBits1 >> 19;
    SELF.orig_lname_wouldClean := le.ScrubsCleanBits1 >> 20;
    SELF.orig_suffix_wouldClean := le.ScrubsCleanBits1 >> 21;
    SELF.title_wouldClean := le.ScrubsCleanBits1 >> 22;
    SELF.fname_wouldClean := le.ScrubsCleanBits1 >> 23;
    SELF.mname_wouldClean := le.ScrubsCleanBits1 >> 24;
    SELF.lname_wouldClean := le.ScrubsCleanBits1 >> 25;
    SELF.name_suffix_wouldClean := le.ScrubsCleanBits1 >> 26;
    SELF.name_score_wouldClean := le.ScrubsCleanBits1 >> 27;
    SELF.addressseq_wouldClean := le.ScrubsCleanBits1 >> 28;
    SELF.orig_address_create_date_wouldClean := le.ScrubsCleanBits1 >> 29;
    SELF.orig_address_update_date_wouldClean := le.ScrubsCleanBits1 >> 30;
    SELF.orig_prim_range_wouldClean := le.ScrubsCleanBits1 >> 31;
    SELF.orig_predir_wouldClean := le.ScrubsCleanBits1 >> 32;
    SELF.orig_prim_name_wouldClean := le.ScrubsCleanBits1 >> 33;
    SELF.orig_addr_suffix_wouldClean := le.ScrubsCleanBits1 >> 34;
    SELF.orig_postdir_wouldClean := le.ScrubsCleanBits1 >> 35;
    SELF.orig_unit_desig_wouldClean := le.ScrubsCleanBits1 >> 36;
    SELF.orig_sec_range_wouldClean := le.ScrubsCleanBits1 >> 37;
    SELF.orig_city_wouldClean := le.ScrubsCleanBits1 >> 38;
    SELF.orig_state_wouldClean := le.ScrubsCleanBits1 >> 39;
    SELF.orig_zipcode_wouldClean := le.ScrubsCleanBits1 >> 40;
    SELF.orig_zipcode4_wouldClean := le.ScrubsCleanBits1 >> 41;
    SELF.prim_range_wouldClean := le.ScrubsCleanBits1 >> 42;
    SELF.predir_wouldClean := le.ScrubsCleanBits1 >> 43;
    SELF.prim_name_wouldClean := le.ScrubsCleanBits1 >> 44;
    SELF.addr_suffix_wouldClean := le.ScrubsCleanBits1 >> 45;
    SELF.postdir_wouldClean := le.ScrubsCleanBits1 >> 46;
    SELF.unit_desig_wouldClean := le.ScrubsCleanBits1 >> 47;
    SELF.sec_range_wouldClean := le.ScrubsCleanBits1 >> 48;
    SELF.p_city_name_wouldClean := le.ScrubsCleanBits1 >> 49;
    SELF.v_city_name_wouldClean := le.ScrubsCleanBits1 >> 50;
    SELF.st_wouldClean := le.ScrubsCleanBits1 >> 51;
    SELF.zip_wouldClean := le.ScrubsCleanBits1 >> 52;
    SELF.zip4_wouldClean := le.ScrubsCleanBits1 >> 53;
    SELF.cart_wouldClean := le.ScrubsCleanBits1 >> 54;
    SELF.cr_sort_sz_wouldClean := le.ScrubsCleanBits1 >> 55;
    SELF.lot_wouldClean := le.ScrubsCleanBits1 >> 56;
    SELF.lot_order_wouldClean := le.ScrubsCleanBits1 >> 57;
    SELF.dbpc_wouldClean := le.ScrubsCleanBits1 >> 58;
    SELF.chk_digit_wouldClean := le.ScrubsCleanBits1 >> 59;
    SELF.rec_type_wouldClean := le.ScrubsCleanBits1 >> 60;
    SELF.county_wouldClean := le.ScrubsCleanBits1 >> 61;
    SELF.geo_lat_wouldClean := le.ScrubsCleanBits1 >> 62;
    SELF.geo_long_wouldClean := le.ScrubsCleanBits1 >> 63;
    SELF.msa_wouldClean := le.ScrubsCleanBits2 >> 0;
    SELF.geo_blk_wouldClean := le.ScrubsCleanBits2 >> 1;
    SELF.geo_match_wouldClean := le.ScrubsCleanBits2 >> 2;
    SELF.err_stat_wouldClean := le.ScrubsCleanBits2 >> 3;
    SELF.delete_flag_wouldClean := le.ScrubsCleanBits2 >> 4;
    SELF.delete_file_date_wouldClean := le.ScrubsCleanBits2 >> 5;
    SELF.suppression_code_wouldClean := le.ScrubsCleanBits2 >> 6;
    SELF.deceased_ind_wouldClean := le.ScrubsCleanBits2 >> 7;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    seq_rec_id_LEFTTRIM_ErrorCount := COUNT(GROUP,h.seq_rec_id_Invalid=1);
    seq_rec_id_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.seq_rec_id_Invalid=1 AND h.seq_rec_id_wouldClean);
    seq_rec_id_ALLOW_ErrorCount := COUNT(GROUP,h.seq_rec_id_Invalid=2);
    seq_rec_id_ALLOW_WouldModifyCount := COUNT(GROUP,h.seq_rec_id_Invalid=2 AND h.seq_rec_id_wouldClean);
    seq_rec_id_LENGTHS_ErrorCount := COUNT(GROUP,h.seq_rec_id_Invalid=3);
    seq_rec_id_LENGTHS_WouldModifyCount := COUNT(GROUP,h.seq_rec_id_Invalid=3 AND h.seq_rec_id_wouldClean);
    seq_rec_id_WORDS_ErrorCount := COUNT(GROUP,h.seq_rec_id_Invalid=4);
    seq_rec_id_WORDS_WouldModifyCount := COUNT(GROUP,h.seq_rec_id_Invalid=4 AND h.seq_rec_id_wouldClean);
    seq_rec_id_Total_ErrorCount := COUNT(GROUP,h.seq_rec_id_Invalid>0);
    did_LEFTTRIM_ErrorCount := COUNT(GROUP,h.did_Invalid=1);
    did_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.did_Invalid=1 AND h.did_wouldClean);
    did_ALLOW_ErrorCount := COUNT(GROUP,h.did_Invalid=2);
    did_ALLOW_WouldModifyCount := COUNT(GROUP,h.did_Invalid=2 AND h.did_wouldClean);
    did_LENGTHS_ErrorCount := COUNT(GROUP,h.did_Invalid=3);
    did_LENGTHS_WouldModifyCount := COUNT(GROUP,h.did_Invalid=3 AND h.did_wouldClean);
    did_WORDS_ErrorCount := COUNT(GROUP,h.did_Invalid=4);
    did_WORDS_WouldModifyCount := COUNT(GROUP,h.did_Invalid=4 AND h.did_wouldClean);
    did_Total_ErrorCount := COUNT(GROUP,h.did_Invalid>0);
    did_score_field_LEFTTRIM_ErrorCount := COUNT(GROUP,h.did_score_field_Invalid=1);
    did_score_field_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.did_score_field_Invalid=1 AND h.did_score_field_wouldClean);
    did_score_field_ALLOW_ErrorCount := COUNT(GROUP,h.did_score_field_Invalid=2);
    did_score_field_ALLOW_WouldModifyCount := COUNT(GROUP,h.did_score_field_Invalid=2 AND h.did_score_field_wouldClean);
    did_score_field_LENGTHS_ErrorCount := COUNT(GROUP,h.did_score_field_Invalid=3);
    did_score_field_LENGTHS_WouldModifyCount := COUNT(GROUP,h.did_score_field_Invalid=3 AND h.did_score_field_wouldClean);
    did_score_field_WORDS_ErrorCount := COUNT(GROUP,h.did_score_field_Invalid=4);
    did_score_field_WORDS_WouldModifyCount := COUNT(GROUP,h.did_score_field_Invalid=4 AND h.did_score_field_wouldClean);
    did_score_field_Total_ErrorCount := COUNT(GROUP,h.did_score_field_Invalid>0);
    current_rec_flag_LEFTTRIM_ErrorCount := COUNT(GROUP,h.current_rec_flag_Invalid=1);
    current_rec_flag_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.current_rec_flag_Invalid=1 AND h.current_rec_flag_wouldClean);
    current_rec_flag_ALLOW_ErrorCount := COUNT(GROUP,h.current_rec_flag_Invalid=2);
    current_rec_flag_ALLOW_WouldModifyCount := COUNT(GROUP,h.current_rec_flag_Invalid=2 AND h.current_rec_flag_wouldClean);
    current_rec_flag_LENGTHS_ErrorCount := COUNT(GROUP,h.current_rec_flag_Invalid=3);
    current_rec_flag_LENGTHS_WouldModifyCount := COUNT(GROUP,h.current_rec_flag_Invalid=3 AND h.current_rec_flag_wouldClean);
    current_rec_flag_WORDS_ErrorCount := COUNT(GROUP,h.current_rec_flag_Invalid=4);
    current_rec_flag_WORDS_WouldModifyCount := COUNT(GROUP,h.current_rec_flag_Invalid=4 AND h.current_rec_flag_wouldClean);
    current_rec_flag_Total_ErrorCount := COUNT(GROUP,h.current_rec_flag_Invalid>0);
    current_experian_pin_LEFTTRIM_ErrorCount := COUNT(GROUP,h.current_experian_pin_Invalid=1);
    current_experian_pin_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.current_experian_pin_Invalid=1 AND h.current_experian_pin_wouldClean);
    current_experian_pin_ALLOW_ErrorCount := COUNT(GROUP,h.current_experian_pin_Invalid=2);
    current_experian_pin_ALLOW_WouldModifyCount := COUNT(GROUP,h.current_experian_pin_Invalid=2 AND h.current_experian_pin_wouldClean);
    current_experian_pin_LENGTHS_ErrorCount := COUNT(GROUP,h.current_experian_pin_Invalid=3);
    current_experian_pin_LENGTHS_WouldModifyCount := COUNT(GROUP,h.current_experian_pin_Invalid=3 AND h.current_experian_pin_wouldClean);
    current_experian_pin_WORDS_ErrorCount := COUNT(GROUP,h.current_experian_pin_Invalid=4);
    current_experian_pin_WORDS_WouldModifyCount := COUNT(GROUP,h.current_experian_pin_Invalid=4 AND h.current_experian_pin_wouldClean);
    current_experian_pin_Total_ErrorCount := COUNT(GROUP,h.current_experian_pin_Invalid>0);
    date_first_seen_LEFTTRIM_ErrorCount := COUNT(GROUP,h.date_first_seen_Invalid=1);
    date_first_seen_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.date_first_seen_Invalid=1 AND h.date_first_seen_wouldClean);
    date_first_seen_ALLOW_ErrorCount := COUNT(GROUP,h.date_first_seen_Invalid=2);
    date_first_seen_ALLOW_WouldModifyCount := COUNT(GROUP,h.date_first_seen_Invalid=2 AND h.date_first_seen_wouldClean);
    date_first_seen_LENGTHS_ErrorCount := COUNT(GROUP,h.date_first_seen_Invalid=3);
    date_first_seen_LENGTHS_WouldModifyCount := COUNT(GROUP,h.date_first_seen_Invalid=3 AND h.date_first_seen_wouldClean);
    date_first_seen_WORDS_ErrorCount := COUNT(GROUP,h.date_first_seen_Invalid=4);
    date_first_seen_WORDS_WouldModifyCount := COUNT(GROUP,h.date_first_seen_Invalid=4 AND h.date_first_seen_wouldClean);
    date_first_seen_Total_ErrorCount := COUNT(GROUP,h.date_first_seen_Invalid>0);
    date_last_seen_LEFTTRIM_ErrorCount := COUNT(GROUP,h.date_last_seen_Invalid=1);
    date_last_seen_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.date_last_seen_Invalid=1 AND h.date_last_seen_wouldClean);
    date_last_seen_ALLOW_ErrorCount := COUNT(GROUP,h.date_last_seen_Invalid=2);
    date_last_seen_ALLOW_WouldModifyCount := COUNT(GROUP,h.date_last_seen_Invalid=2 AND h.date_last_seen_wouldClean);
    date_last_seen_LENGTHS_ErrorCount := COUNT(GROUP,h.date_last_seen_Invalid=3);
    date_last_seen_LENGTHS_WouldModifyCount := COUNT(GROUP,h.date_last_seen_Invalid=3 AND h.date_last_seen_wouldClean);
    date_last_seen_WORDS_ErrorCount := COUNT(GROUP,h.date_last_seen_Invalid=4);
    date_last_seen_WORDS_WouldModifyCount := COUNT(GROUP,h.date_last_seen_Invalid=4 AND h.date_last_seen_wouldClean);
    date_last_seen_Total_ErrorCount := COUNT(GROUP,h.date_last_seen_Invalid>0);
    date_vendor_first_reported_LEFTTRIM_ErrorCount := COUNT(GROUP,h.date_vendor_first_reported_Invalid=1);
    date_vendor_first_reported_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.date_vendor_first_reported_Invalid=1 AND h.date_vendor_first_reported_wouldClean);
    date_vendor_first_reported_ALLOW_ErrorCount := COUNT(GROUP,h.date_vendor_first_reported_Invalid=2);
    date_vendor_first_reported_ALLOW_WouldModifyCount := COUNT(GROUP,h.date_vendor_first_reported_Invalid=2 AND h.date_vendor_first_reported_wouldClean);
    date_vendor_first_reported_LENGTHS_ErrorCount := COUNT(GROUP,h.date_vendor_first_reported_Invalid=3);
    date_vendor_first_reported_LENGTHS_WouldModifyCount := COUNT(GROUP,h.date_vendor_first_reported_Invalid=3 AND h.date_vendor_first_reported_wouldClean);
    date_vendor_first_reported_WORDS_ErrorCount := COUNT(GROUP,h.date_vendor_first_reported_Invalid=4);
    date_vendor_first_reported_WORDS_WouldModifyCount := COUNT(GROUP,h.date_vendor_first_reported_Invalid=4 AND h.date_vendor_first_reported_wouldClean);
    date_vendor_first_reported_Total_ErrorCount := COUNT(GROUP,h.date_vendor_first_reported_Invalid>0);
    date_vendor_last_reported_LEFTTRIM_ErrorCount := COUNT(GROUP,h.date_vendor_last_reported_Invalid=1);
    date_vendor_last_reported_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.date_vendor_last_reported_Invalid=1 AND h.date_vendor_last_reported_wouldClean);
    date_vendor_last_reported_ALLOW_ErrorCount := COUNT(GROUP,h.date_vendor_last_reported_Invalid=2);
    date_vendor_last_reported_ALLOW_WouldModifyCount := COUNT(GROUP,h.date_vendor_last_reported_Invalid=2 AND h.date_vendor_last_reported_wouldClean);
    date_vendor_last_reported_LENGTHS_ErrorCount := COUNT(GROUP,h.date_vendor_last_reported_Invalid=3);
    date_vendor_last_reported_LENGTHS_WouldModifyCount := COUNT(GROUP,h.date_vendor_last_reported_Invalid=3 AND h.date_vendor_last_reported_wouldClean);
    date_vendor_last_reported_WORDS_ErrorCount := COUNT(GROUP,h.date_vendor_last_reported_Invalid=4);
    date_vendor_last_reported_WORDS_WouldModifyCount := COUNT(GROUP,h.date_vendor_last_reported_Invalid=4 AND h.date_vendor_last_reported_wouldClean);
    date_vendor_last_reported_Total_ErrorCount := COUNT(GROUP,h.date_vendor_last_reported_Invalid>0);
    encrypted_experian_pin_LEFTTRIM_ErrorCount := COUNT(GROUP,h.encrypted_experian_pin_Invalid=1);
    encrypted_experian_pin_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.encrypted_experian_pin_Invalid=1 AND h.encrypted_experian_pin_wouldClean);
    encrypted_experian_pin_ALLOW_ErrorCount := COUNT(GROUP,h.encrypted_experian_pin_Invalid=2);
    encrypted_experian_pin_ALLOW_WouldModifyCount := COUNT(GROUP,h.encrypted_experian_pin_Invalid=2 AND h.encrypted_experian_pin_wouldClean);
    encrypted_experian_pin_LENGTHS_ErrorCount := COUNT(GROUP,h.encrypted_experian_pin_Invalid=3);
    encrypted_experian_pin_LENGTHS_WouldModifyCount := COUNT(GROUP,h.encrypted_experian_pin_Invalid=3 AND h.encrypted_experian_pin_wouldClean);
    encrypted_experian_pin_WORDS_ErrorCount := COUNT(GROUP,h.encrypted_experian_pin_Invalid=4);
    encrypted_experian_pin_WORDS_WouldModifyCount := COUNT(GROUP,h.encrypted_experian_pin_Invalid=4 AND h.encrypted_experian_pin_wouldClean);
    encrypted_experian_pin_Total_ErrorCount := COUNT(GROUP,h.encrypted_experian_pin_Invalid>0);
    social_security_number_LEFTTRIM_ErrorCount := COUNT(GROUP,h.social_security_number_Invalid=1);
    social_security_number_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.social_security_number_Invalid=1 AND h.social_security_number_wouldClean);
    social_security_number_ALLOW_ErrorCount := COUNT(GROUP,h.social_security_number_Invalid=2);
    social_security_number_ALLOW_WouldModifyCount := COUNT(GROUP,h.social_security_number_Invalid=2 AND h.social_security_number_wouldClean);
    social_security_number_LENGTHS_ErrorCount := COUNT(GROUP,h.social_security_number_Invalid=3);
    social_security_number_LENGTHS_WouldModifyCount := COUNT(GROUP,h.social_security_number_Invalid=3 AND h.social_security_number_wouldClean);
    social_security_number_WORDS_ErrorCount := COUNT(GROUP,h.social_security_number_Invalid=4);
    social_security_number_WORDS_WouldModifyCount := COUNT(GROUP,h.social_security_number_Invalid=4 AND h.social_security_number_wouldClean);
    social_security_number_Total_ErrorCount := COUNT(GROUP,h.social_security_number_Invalid>0);
    date_of_birth_LEFTTRIM_ErrorCount := COUNT(GROUP,h.date_of_birth_Invalid=1);
    date_of_birth_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.date_of_birth_Invalid=1 AND h.date_of_birth_wouldClean);
    date_of_birth_ALLOW_ErrorCount := COUNT(GROUP,h.date_of_birth_Invalid=2);
    date_of_birth_ALLOW_WouldModifyCount := COUNT(GROUP,h.date_of_birth_Invalid=2 AND h.date_of_birth_wouldClean);
    date_of_birth_LENGTHS_ErrorCount := COUNT(GROUP,h.date_of_birth_Invalid=3);
    date_of_birth_LENGTHS_WouldModifyCount := COUNT(GROUP,h.date_of_birth_Invalid=3 AND h.date_of_birth_wouldClean);
    date_of_birth_WORDS_ErrorCount := COUNT(GROUP,h.date_of_birth_Invalid=4);
    date_of_birth_WORDS_WouldModifyCount := COUNT(GROUP,h.date_of_birth_Invalid=4 AND h.date_of_birth_wouldClean);
    date_of_birth_Total_ErrorCount := COUNT(GROUP,h.date_of_birth_Invalid>0);
    telephone_LEFTTRIM_ErrorCount := COUNT(GROUP,h.telephone_Invalid=1);
    telephone_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.telephone_Invalid=1 AND h.telephone_wouldClean);
    telephone_ALLOW_ErrorCount := COUNT(GROUP,h.telephone_Invalid=2);
    telephone_ALLOW_WouldModifyCount := COUNT(GROUP,h.telephone_Invalid=2 AND h.telephone_wouldClean);
    telephone_LENGTHS_ErrorCount := COUNT(GROUP,h.telephone_Invalid=3);
    telephone_LENGTHS_WouldModifyCount := COUNT(GROUP,h.telephone_Invalid=3 AND h.telephone_wouldClean);
    telephone_WORDS_ErrorCount := COUNT(GROUP,h.telephone_Invalid=4);
    telephone_WORDS_WouldModifyCount := COUNT(GROUP,h.telephone_Invalid=4 AND h.telephone_wouldClean);
    telephone_Total_ErrorCount := COUNT(GROUP,h.telephone_Invalid>0);
    gender_LEFTTRIM_ErrorCount := COUNT(GROUP,h.gender_Invalid=1);
    gender_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.gender_Invalid=1 AND h.gender_wouldClean);
    gender_ALLOW_ErrorCount := COUNT(GROUP,h.gender_Invalid=2);
    gender_ALLOW_WouldModifyCount := COUNT(GROUP,h.gender_Invalid=2 AND h.gender_wouldClean);
    gender_LENGTHS_ErrorCount := COUNT(GROUP,h.gender_Invalid=3);
    gender_LENGTHS_WouldModifyCount := COUNT(GROUP,h.gender_Invalid=3 AND h.gender_wouldClean);
    gender_WORDS_ErrorCount := COUNT(GROUP,h.gender_Invalid=4);
    gender_WORDS_WouldModifyCount := COUNT(GROUP,h.gender_Invalid=4 AND h.gender_wouldClean);
    gender_Total_ErrorCount := COUNT(GROUP,h.gender_Invalid>0);
    additional_name_count_LEFTTRIM_ErrorCount := COUNT(GROUP,h.additional_name_count_Invalid=1);
    additional_name_count_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.additional_name_count_Invalid=1 AND h.additional_name_count_wouldClean);
    additional_name_count_ALLOW_ErrorCount := COUNT(GROUP,h.additional_name_count_Invalid=2);
    additional_name_count_ALLOW_WouldModifyCount := COUNT(GROUP,h.additional_name_count_Invalid=2 AND h.additional_name_count_wouldClean);
    additional_name_count_LENGTHS_ErrorCount := COUNT(GROUP,h.additional_name_count_Invalid=3);
    additional_name_count_LENGTHS_WouldModifyCount := COUNT(GROUP,h.additional_name_count_Invalid=3 AND h.additional_name_count_wouldClean);
    additional_name_count_WORDS_ErrorCount := COUNT(GROUP,h.additional_name_count_Invalid=4);
    additional_name_count_WORDS_WouldModifyCount := COUNT(GROUP,h.additional_name_count_Invalid=4 AND h.additional_name_count_wouldClean);
    additional_name_count_Total_ErrorCount := COUNT(GROUP,h.additional_name_count_Invalid>0);
    previous_address_count_LEFTTRIM_ErrorCount := COUNT(GROUP,h.previous_address_count_Invalid=1);
    previous_address_count_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.previous_address_count_Invalid=1 AND h.previous_address_count_wouldClean);
    previous_address_count_ALLOW_ErrorCount := COUNT(GROUP,h.previous_address_count_Invalid=2);
    previous_address_count_ALLOW_WouldModifyCount := COUNT(GROUP,h.previous_address_count_Invalid=2 AND h.previous_address_count_wouldClean);
    previous_address_count_LENGTHS_ErrorCount := COUNT(GROUP,h.previous_address_count_Invalid=3);
    previous_address_count_LENGTHS_WouldModifyCount := COUNT(GROUP,h.previous_address_count_Invalid=3 AND h.previous_address_count_wouldClean);
    previous_address_count_WORDS_ErrorCount := COUNT(GROUP,h.previous_address_count_Invalid=4);
    previous_address_count_WORDS_WouldModifyCount := COUNT(GROUP,h.previous_address_count_Invalid=4 AND h.previous_address_count_wouldClean);
    previous_address_count_Total_ErrorCount := COUNT(GROUP,h.previous_address_count_Invalid>0);
    nametype_LEFTTRIM_ErrorCount := COUNT(GROUP,h.nametype_Invalid=1);
    nametype_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.nametype_Invalid=1 AND h.nametype_wouldClean);
    nametype_ALLOW_ErrorCount := COUNT(GROUP,h.nametype_Invalid=2);
    nametype_ALLOW_WouldModifyCount := COUNT(GROUP,h.nametype_Invalid=2 AND h.nametype_wouldClean);
    nametype_LENGTHS_ErrorCount := COUNT(GROUP,h.nametype_Invalid=3);
    nametype_LENGTHS_WouldModifyCount := COUNT(GROUP,h.nametype_Invalid=3 AND h.nametype_wouldClean);
    nametype_WORDS_ErrorCount := COUNT(GROUP,h.nametype_Invalid=4);
    nametype_WORDS_WouldModifyCount := COUNT(GROUP,h.nametype_Invalid=4 AND h.nametype_wouldClean);
    nametype_Total_ErrorCount := COUNT(GROUP,h.nametype_Invalid>0);
    orig_consumer_create_date_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_consumer_create_date_Invalid=1);
    orig_consumer_create_date_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_consumer_create_date_Invalid=1 AND h.orig_consumer_create_date_wouldClean);
    orig_consumer_create_date_ALLOW_ErrorCount := COUNT(GROUP,h.orig_consumer_create_date_Invalid=2);
    orig_consumer_create_date_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_consumer_create_date_Invalid=2 AND h.orig_consumer_create_date_wouldClean);
    orig_consumer_create_date_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_consumer_create_date_Invalid=3);
    orig_consumer_create_date_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_consumer_create_date_Invalid=3 AND h.orig_consumer_create_date_wouldClean);
    orig_consumer_create_date_WORDS_ErrorCount := COUNT(GROUP,h.orig_consumer_create_date_Invalid=4);
    orig_consumer_create_date_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_consumer_create_date_Invalid=4 AND h.orig_consumer_create_date_wouldClean);
    orig_consumer_create_date_Total_ErrorCount := COUNT(GROUP,h.orig_consumer_create_date_Invalid>0);
    orig_fname_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_fname_Invalid=1);
    orig_fname_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_fname_Invalid=1 AND h.orig_fname_wouldClean);
    orig_fname_ALLOW_ErrorCount := COUNT(GROUP,h.orig_fname_Invalid=2);
    orig_fname_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_fname_Invalid=2 AND h.orig_fname_wouldClean);
    orig_fname_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_fname_Invalid=3);
    orig_fname_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_fname_Invalid=3 AND h.orig_fname_wouldClean);
    orig_fname_WORDS_ErrorCount := COUNT(GROUP,h.orig_fname_Invalid=4);
    orig_fname_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_fname_Invalid=4 AND h.orig_fname_wouldClean);
    orig_fname_Total_ErrorCount := COUNT(GROUP,h.orig_fname_Invalid>0);
    orig_mname_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_mname_Invalid=1);
    orig_mname_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_mname_Invalid=1 AND h.orig_mname_wouldClean);
    orig_mname_ALLOW_ErrorCount := COUNT(GROUP,h.orig_mname_Invalid=2);
    orig_mname_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_mname_Invalid=2 AND h.orig_mname_wouldClean);
    orig_mname_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_mname_Invalid=3);
    orig_mname_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_mname_Invalid=3 AND h.orig_mname_wouldClean);
    orig_mname_WORDS_ErrorCount := COUNT(GROUP,h.orig_mname_Invalid=4);
    orig_mname_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_mname_Invalid=4 AND h.orig_mname_wouldClean);
    orig_mname_Total_ErrorCount := COUNT(GROUP,h.orig_mname_Invalid>0);
    orig_lname_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_lname_Invalid=1);
    orig_lname_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_lname_Invalid=1 AND h.orig_lname_wouldClean);
    orig_lname_ALLOW_ErrorCount := COUNT(GROUP,h.orig_lname_Invalid=2);
    orig_lname_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_lname_Invalid=2 AND h.orig_lname_wouldClean);
    orig_lname_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_lname_Invalid=3);
    orig_lname_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_lname_Invalid=3 AND h.orig_lname_wouldClean);
    orig_lname_WORDS_ErrorCount := COUNT(GROUP,h.orig_lname_Invalid=4);
    orig_lname_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_lname_Invalid=4 AND h.orig_lname_wouldClean);
    orig_lname_Total_ErrorCount := COUNT(GROUP,h.orig_lname_Invalid>0);
    orig_suffix_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_suffix_Invalid=1);
    orig_suffix_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_suffix_Invalid=1 AND h.orig_suffix_wouldClean);
    orig_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.orig_suffix_Invalid=2);
    orig_suffix_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_suffix_Invalid=2 AND h.orig_suffix_wouldClean);
    orig_suffix_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_suffix_Invalid=3);
    orig_suffix_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_suffix_Invalid=3 AND h.orig_suffix_wouldClean);
    orig_suffix_WORDS_ErrorCount := COUNT(GROUP,h.orig_suffix_Invalid=4);
    orig_suffix_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_suffix_Invalid=4 AND h.orig_suffix_wouldClean);
    orig_suffix_Total_ErrorCount := COUNT(GROUP,h.orig_suffix_Invalid>0);
    title_LEFTTRIM_ErrorCount := COUNT(GROUP,h.title_Invalid=1);
    title_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.title_Invalid=1 AND h.title_wouldClean);
    title_ALLOW_ErrorCount := COUNT(GROUP,h.title_Invalid=2);
    title_ALLOW_WouldModifyCount := COUNT(GROUP,h.title_Invalid=2 AND h.title_wouldClean);
    title_LENGTHS_ErrorCount := COUNT(GROUP,h.title_Invalid=3);
    title_LENGTHS_WouldModifyCount := COUNT(GROUP,h.title_Invalid=3 AND h.title_wouldClean);
    title_WORDS_ErrorCount := COUNT(GROUP,h.title_Invalid=4);
    title_WORDS_WouldModifyCount := COUNT(GROUP,h.title_Invalid=4 AND h.title_wouldClean);
    title_Total_ErrorCount := COUNT(GROUP,h.title_Invalid>0);
    fname_LEFTTRIM_ErrorCount := COUNT(GROUP,h.fname_Invalid=1);
    fname_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.fname_Invalid=1 AND h.fname_wouldClean);
    fname_ALLOW_ErrorCount := COUNT(GROUP,h.fname_Invalid=2);
    fname_ALLOW_WouldModifyCount := COUNT(GROUP,h.fname_Invalid=2 AND h.fname_wouldClean);
    fname_LENGTHS_ErrorCount := COUNT(GROUP,h.fname_Invalid=3);
    fname_LENGTHS_WouldModifyCount := COUNT(GROUP,h.fname_Invalid=3 AND h.fname_wouldClean);
    fname_WORDS_ErrorCount := COUNT(GROUP,h.fname_Invalid=4);
    fname_WORDS_WouldModifyCount := COUNT(GROUP,h.fname_Invalid=4 AND h.fname_wouldClean);
    fname_Total_ErrorCount := COUNT(GROUP,h.fname_Invalid>0);
    mname_LEFTTRIM_ErrorCount := COUNT(GROUP,h.mname_Invalid=1);
    mname_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.mname_Invalid=1 AND h.mname_wouldClean);
    mname_ALLOW_ErrorCount := COUNT(GROUP,h.mname_Invalid=2);
    mname_ALLOW_WouldModifyCount := COUNT(GROUP,h.mname_Invalid=2 AND h.mname_wouldClean);
    mname_LENGTHS_ErrorCount := COUNT(GROUP,h.mname_Invalid=3);
    mname_LENGTHS_WouldModifyCount := COUNT(GROUP,h.mname_Invalid=3 AND h.mname_wouldClean);
    mname_WORDS_ErrorCount := COUNT(GROUP,h.mname_Invalid=4);
    mname_WORDS_WouldModifyCount := COUNT(GROUP,h.mname_Invalid=4 AND h.mname_wouldClean);
    mname_Total_ErrorCount := COUNT(GROUP,h.mname_Invalid>0);
    lname_LEFTTRIM_ErrorCount := COUNT(GROUP,h.lname_Invalid=1);
    lname_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.lname_Invalid=1 AND h.lname_wouldClean);
    lname_ALLOW_ErrorCount := COUNT(GROUP,h.lname_Invalid=2);
    lname_ALLOW_WouldModifyCount := COUNT(GROUP,h.lname_Invalid=2 AND h.lname_wouldClean);
    lname_LENGTHS_ErrorCount := COUNT(GROUP,h.lname_Invalid=3);
    lname_LENGTHS_WouldModifyCount := COUNT(GROUP,h.lname_Invalid=3 AND h.lname_wouldClean);
    lname_WORDS_ErrorCount := COUNT(GROUP,h.lname_Invalid=4);
    lname_WORDS_WouldModifyCount := COUNT(GROUP,h.lname_Invalid=4 AND h.lname_wouldClean);
    lname_Total_ErrorCount := COUNT(GROUP,h.lname_Invalid>0);
    name_suffix_LEFTTRIM_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid=1);
    name_suffix_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.name_suffix_Invalid=1 AND h.name_suffix_wouldClean);
    name_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid=2);
    name_suffix_ALLOW_WouldModifyCount := COUNT(GROUP,h.name_suffix_Invalid=2 AND h.name_suffix_wouldClean);
    name_suffix_LENGTHS_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid=3);
    name_suffix_LENGTHS_WouldModifyCount := COUNT(GROUP,h.name_suffix_Invalid=3 AND h.name_suffix_wouldClean);
    name_suffix_WORDS_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid=4);
    name_suffix_WORDS_WouldModifyCount := COUNT(GROUP,h.name_suffix_Invalid=4 AND h.name_suffix_wouldClean);
    name_suffix_Total_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid>0);
    name_score_LEFTTRIM_ErrorCount := COUNT(GROUP,h.name_score_Invalid=1);
    name_score_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.name_score_Invalid=1 AND h.name_score_wouldClean);
    name_score_ALLOW_ErrorCount := COUNT(GROUP,h.name_score_Invalid=2);
    name_score_ALLOW_WouldModifyCount := COUNT(GROUP,h.name_score_Invalid=2 AND h.name_score_wouldClean);
    name_score_LENGTHS_ErrorCount := COUNT(GROUP,h.name_score_Invalid=3);
    name_score_LENGTHS_WouldModifyCount := COUNT(GROUP,h.name_score_Invalid=3 AND h.name_score_wouldClean);
    name_score_WORDS_ErrorCount := COUNT(GROUP,h.name_score_Invalid=4);
    name_score_WORDS_WouldModifyCount := COUNT(GROUP,h.name_score_Invalid=4 AND h.name_score_wouldClean);
    name_score_Total_ErrorCount := COUNT(GROUP,h.name_score_Invalid>0);
    addressseq_LEFTTRIM_ErrorCount := COUNT(GROUP,h.addressseq_Invalid=1);
    addressseq_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.addressseq_Invalid=1 AND h.addressseq_wouldClean);
    addressseq_ALLOW_ErrorCount := COUNT(GROUP,h.addressseq_Invalid=2);
    addressseq_ALLOW_WouldModifyCount := COUNT(GROUP,h.addressseq_Invalid=2 AND h.addressseq_wouldClean);
    addressseq_LENGTHS_ErrorCount := COUNT(GROUP,h.addressseq_Invalid=3);
    addressseq_LENGTHS_WouldModifyCount := COUNT(GROUP,h.addressseq_Invalid=3 AND h.addressseq_wouldClean);
    addressseq_WORDS_ErrorCount := COUNT(GROUP,h.addressseq_Invalid=4);
    addressseq_WORDS_WouldModifyCount := COUNT(GROUP,h.addressseq_Invalid=4 AND h.addressseq_wouldClean);
    addressseq_Total_ErrorCount := COUNT(GROUP,h.addressseq_Invalid>0);
    orig_address_create_date_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_address_create_date_Invalid=1);
    orig_address_create_date_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_address_create_date_Invalid=1 AND h.orig_address_create_date_wouldClean);
    orig_address_create_date_ALLOW_ErrorCount := COUNT(GROUP,h.orig_address_create_date_Invalid=2);
    orig_address_create_date_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_address_create_date_Invalid=2 AND h.orig_address_create_date_wouldClean);
    orig_address_create_date_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_address_create_date_Invalid=3);
    orig_address_create_date_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_address_create_date_Invalid=3 AND h.orig_address_create_date_wouldClean);
    orig_address_create_date_WORDS_ErrorCount := COUNT(GROUP,h.orig_address_create_date_Invalid=4);
    orig_address_create_date_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_address_create_date_Invalid=4 AND h.orig_address_create_date_wouldClean);
    orig_address_create_date_Total_ErrorCount := COUNT(GROUP,h.orig_address_create_date_Invalid>0);
    orig_address_update_date_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_address_update_date_Invalid=1);
    orig_address_update_date_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_address_update_date_Invalid=1 AND h.orig_address_update_date_wouldClean);
    orig_address_update_date_ALLOW_ErrorCount := COUNT(GROUP,h.orig_address_update_date_Invalid=2);
    orig_address_update_date_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_address_update_date_Invalid=2 AND h.orig_address_update_date_wouldClean);
    orig_address_update_date_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_address_update_date_Invalid=3);
    orig_address_update_date_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_address_update_date_Invalid=3 AND h.orig_address_update_date_wouldClean);
    orig_address_update_date_WORDS_ErrorCount := COUNT(GROUP,h.orig_address_update_date_Invalid=4);
    orig_address_update_date_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_address_update_date_Invalid=4 AND h.orig_address_update_date_wouldClean);
    orig_address_update_date_Total_ErrorCount := COUNT(GROUP,h.orig_address_update_date_Invalid>0);
    orig_prim_range_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_prim_range_Invalid=1);
    orig_prim_range_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_prim_range_Invalid=1 AND h.orig_prim_range_wouldClean);
    orig_prim_range_ALLOW_ErrorCount := COUNT(GROUP,h.orig_prim_range_Invalid=2);
    orig_prim_range_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_prim_range_Invalid=2 AND h.orig_prim_range_wouldClean);
    orig_prim_range_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_prim_range_Invalid=3);
    orig_prim_range_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_prim_range_Invalid=3 AND h.orig_prim_range_wouldClean);
    orig_prim_range_WORDS_ErrorCount := COUNT(GROUP,h.orig_prim_range_Invalid=4);
    orig_prim_range_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_prim_range_Invalid=4 AND h.orig_prim_range_wouldClean);
    orig_prim_range_Total_ErrorCount := COUNT(GROUP,h.orig_prim_range_Invalid>0);
    orig_predir_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_predir_Invalid=1);
    orig_predir_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_predir_Invalid=1 AND h.orig_predir_wouldClean);
    orig_predir_ALLOW_ErrorCount := COUNT(GROUP,h.orig_predir_Invalid=2);
    orig_predir_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_predir_Invalid=2 AND h.orig_predir_wouldClean);
    orig_predir_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_predir_Invalid=3);
    orig_predir_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_predir_Invalid=3 AND h.orig_predir_wouldClean);
    orig_predir_WORDS_ErrorCount := COUNT(GROUP,h.orig_predir_Invalid=4);
    orig_predir_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_predir_Invalid=4 AND h.orig_predir_wouldClean);
    orig_predir_Total_ErrorCount := COUNT(GROUP,h.orig_predir_Invalid>0);
    orig_prim_name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_prim_name_Invalid=1);
    orig_prim_name_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_prim_name_Invalid=1 AND h.orig_prim_name_wouldClean);
    orig_prim_name_ALLOW_ErrorCount := COUNT(GROUP,h.orig_prim_name_Invalid=2);
    orig_prim_name_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_prim_name_Invalid=2 AND h.orig_prim_name_wouldClean);
    orig_prim_name_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_prim_name_Invalid=3);
    orig_prim_name_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_prim_name_Invalid=3 AND h.orig_prim_name_wouldClean);
    orig_prim_name_WORDS_ErrorCount := COUNT(GROUP,h.orig_prim_name_Invalid=4);
    orig_prim_name_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_prim_name_Invalid=4 AND h.orig_prim_name_wouldClean);
    orig_prim_name_Total_ErrorCount := COUNT(GROUP,h.orig_prim_name_Invalid>0);
    orig_addr_suffix_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_addr_suffix_Invalid=1);
    orig_addr_suffix_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_addr_suffix_Invalid=1 AND h.orig_addr_suffix_wouldClean);
    orig_addr_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.orig_addr_suffix_Invalid=2);
    orig_addr_suffix_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_addr_suffix_Invalid=2 AND h.orig_addr_suffix_wouldClean);
    orig_addr_suffix_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_addr_suffix_Invalid=3);
    orig_addr_suffix_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_addr_suffix_Invalid=3 AND h.orig_addr_suffix_wouldClean);
    orig_addr_suffix_WORDS_ErrorCount := COUNT(GROUP,h.orig_addr_suffix_Invalid=4);
    orig_addr_suffix_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_addr_suffix_Invalid=4 AND h.orig_addr_suffix_wouldClean);
    orig_addr_suffix_Total_ErrorCount := COUNT(GROUP,h.orig_addr_suffix_Invalid>0);
    orig_postdir_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_postdir_Invalid=1);
    orig_postdir_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_postdir_Invalid=1 AND h.orig_postdir_wouldClean);
    orig_postdir_ALLOW_ErrorCount := COUNT(GROUP,h.orig_postdir_Invalid=2);
    orig_postdir_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_postdir_Invalid=2 AND h.orig_postdir_wouldClean);
    orig_postdir_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_postdir_Invalid=3);
    orig_postdir_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_postdir_Invalid=3 AND h.orig_postdir_wouldClean);
    orig_postdir_WORDS_ErrorCount := COUNT(GROUP,h.orig_postdir_Invalid=4);
    orig_postdir_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_postdir_Invalid=4 AND h.orig_postdir_wouldClean);
    orig_postdir_Total_ErrorCount := COUNT(GROUP,h.orig_postdir_Invalid>0);
    orig_unit_desig_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_unit_desig_Invalid=1);
    orig_unit_desig_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_unit_desig_Invalid=1 AND h.orig_unit_desig_wouldClean);
    orig_unit_desig_ALLOW_ErrorCount := COUNT(GROUP,h.orig_unit_desig_Invalid=2);
    orig_unit_desig_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_unit_desig_Invalid=2 AND h.orig_unit_desig_wouldClean);
    orig_unit_desig_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_unit_desig_Invalid=3);
    orig_unit_desig_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_unit_desig_Invalid=3 AND h.orig_unit_desig_wouldClean);
    orig_unit_desig_WORDS_ErrorCount := COUNT(GROUP,h.orig_unit_desig_Invalid=4);
    orig_unit_desig_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_unit_desig_Invalid=4 AND h.orig_unit_desig_wouldClean);
    orig_unit_desig_Total_ErrorCount := COUNT(GROUP,h.orig_unit_desig_Invalid>0);
    orig_sec_range_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_sec_range_Invalid=1);
    orig_sec_range_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_sec_range_Invalid=1 AND h.orig_sec_range_wouldClean);
    orig_sec_range_ALLOW_ErrorCount := COUNT(GROUP,h.orig_sec_range_Invalid=2);
    orig_sec_range_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_sec_range_Invalid=2 AND h.orig_sec_range_wouldClean);
    orig_sec_range_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_sec_range_Invalid=3);
    orig_sec_range_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_sec_range_Invalid=3 AND h.orig_sec_range_wouldClean);
    orig_sec_range_WORDS_ErrorCount := COUNT(GROUP,h.orig_sec_range_Invalid=4);
    orig_sec_range_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_sec_range_Invalid=4 AND h.orig_sec_range_wouldClean);
    orig_sec_range_Total_ErrorCount := COUNT(GROUP,h.orig_sec_range_Invalid>0);
    orig_city_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_city_Invalid=1);
    orig_city_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_city_Invalid=1 AND h.orig_city_wouldClean);
    orig_city_ALLOW_ErrorCount := COUNT(GROUP,h.orig_city_Invalid=2);
    orig_city_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_city_Invalid=2 AND h.orig_city_wouldClean);
    orig_city_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_city_Invalid=3);
    orig_city_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_city_Invalid=3 AND h.orig_city_wouldClean);
    orig_city_WORDS_ErrorCount := COUNT(GROUP,h.orig_city_Invalid=4);
    orig_city_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_city_Invalid=4 AND h.orig_city_wouldClean);
    orig_city_Total_ErrorCount := COUNT(GROUP,h.orig_city_Invalid>0);
    orig_state_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_state_Invalid=1);
    orig_state_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_state_Invalid=1 AND h.orig_state_wouldClean);
    orig_state_ALLOW_ErrorCount := COUNT(GROUP,h.orig_state_Invalid=2);
    orig_state_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_state_Invalid=2 AND h.orig_state_wouldClean);
    orig_state_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_state_Invalid=3);
    orig_state_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_state_Invalid=3 AND h.orig_state_wouldClean);
    orig_state_WORDS_ErrorCount := COUNT(GROUP,h.orig_state_Invalid=4);
    orig_state_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_state_Invalid=4 AND h.orig_state_wouldClean);
    orig_state_Total_ErrorCount := COUNT(GROUP,h.orig_state_Invalid>0);
    orig_zipcode_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_zipcode_Invalid=1);
    orig_zipcode_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_zipcode_Invalid=1 AND h.orig_zipcode_wouldClean);
    orig_zipcode_ALLOW_ErrorCount := COUNT(GROUP,h.orig_zipcode_Invalid=2);
    orig_zipcode_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_zipcode_Invalid=2 AND h.orig_zipcode_wouldClean);
    orig_zipcode_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_zipcode_Invalid=3);
    orig_zipcode_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_zipcode_Invalid=3 AND h.orig_zipcode_wouldClean);
    orig_zipcode_WORDS_ErrorCount := COUNT(GROUP,h.orig_zipcode_Invalid=4);
    orig_zipcode_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_zipcode_Invalid=4 AND h.orig_zipcode_wouldClean);
    orig_zipcode_Total_ErrorCount := COUNT(GROUP,h.orig_zipcode_Invalid>0);
    orig_zipcode4_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orig_zipcode4_Invalid=1);
    orig_zipcode4_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.orig_zipcode4_Invalid=1 AND h.orig_zipcode4_wouldClean);
    orig_zipcode4_ALLOW_ErrorCount := COUNT(GROUP,h.orig_zipcode4_Invalid=2);
    orig_zipcode4_ALLOW_WouldModifyCount := COUNT(GROUP,h.orig_zipcode4_Invalid=2 AND h.orig_zipcode4_wouldClean);
    orig_zipcode4_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_zipcode4_Invalid=3);
    orig_zipcode4_LENGTHS_WouldModifyCount := COUNT(GROUP,h.orig_zipcode4_Invalid=3 AND h.orig_zipcode4_wouldClean);
    orig_zipcode4_WORDS_ErrorCount := COUNT(GROUP,h.orig_zipcode4_Invalid=4);
    orig_zipcode4_WORDS_WouldModifyCount := COUNT(GROUP,h.orig_zipcode4_Invalid=4 AND h.orig_zipcode4_wouldClean);
    orig_zipcode4_Total_ErrorCount := COUNT(GROUP,h.orig_zipcode4_Invalid>0);
    prim_range_LEFTTRIM_ErrorCount := COUNT(GROUP,h.prim_range_Invalid=1);
    prim_range_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.prim_range_Invalid=1 AND h.prim_range_wouldClean);
    prim_range_ALLOW_ErrorCount := COUNT(GROUP,h.prim_range_Invalid=2);
    prim_range_ALLOW_WouldModifyCount := COUNT(GROUP,h.prim_range_Invalid=2 AND h.prim_range_wouldClean);
    prim_range_LENGTHS_ErrorCount := COUNT(GROUP,h.prim_range_Invalid=3);
    prim_range_LENGTHS_WouldModifyCount := COUNT(GROUP,h.prim_range_Invalid=3 AND h.prim_range_wouldClean);
    prim_range_WORDS_ErrorCount := COUNT(GROUP,h.prim_range_Invalid=4);
    prim_range_WORDS_WouldModifyCount := COUNT(GROUP,h.prim_range_Invalid=4 AND h.prim_range_wouldClean);
    prim_range_Total_ErrorCount := COUNT(GROUP,h.prim_range_Invalid>0);
    predir_LEFTTRIM_ErrorCount := COUNT(GROUP,h.predir_Invalid=1);
    predir_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.predir_Invalid=1 AND h.predir_wouldClean);
    predir_ALLOW_ErrorCount := COUNT(GROUP,h.predir_Invalid=2);
    predir_ALLOW_WouldModifyCount := COUNT(GROUP,h.predir_Invalid=2 AND h.predir_wouldClean);
    predir_LENGTHS_ErrorCount := COUNT(GROUP,h.predir_Invalid=3);
    predir_LENGTHS_WouldModifyCount := COUNT(GROUP,h.predir_Invalid=3 AND h.predir_wouldClean);
    predir_WORDS_ErrorCount := COUNT(GROUP,h.predir_Invalid=4);
    predir_WORDS_WouldModifyCount := COUNT(GROUP,h.predir_Invalid=4 AND h.predir_wouldClean);
    predir_Total_ErrorCount := COUNT(GROUP,h.predir_Invalid>0);
    prim_name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.prim_name_Invalid=1);
    prim_name_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.prim_name_Invalid=1 AND h.prim_name_wouldClean);
    prim_name_ALLOW_ErrorCount := COUNT(GROUP,h.prim_name_Invalid=2);
    prim_name_ALLOW_WouldModifyCount := COUNT(GROUP,h.prim_name_Invalid=2 AND h.prim_name_wouldClean);
    prim_name_LENGTHS_ErrorCount := COUNT(GROUP,h.prim_name_Invalid=3);
    prim_name_LENGTHS_WouldModifyCount := COUNT(GROUP,h.prim_name_Invalid=3 AND h.prim_name_wouldClean);
    prim_name_WORDS_ErrorCount := COUNT(GROUP,h.prim_name_Invalid=4);
    prim_name_WORDS_WouldModifyCount := COUNT(GROUP,h.prim_name_Invalid=4 AND h.prim_name_wouldClean);
    prim_name_Total_ErrorCount := COUNT(GROUP,h.prim_name_Invalid>0);
    addr_suffix_LEFTTRIM_ErrorCount := COUNT(GROUP,h.addr_suffix_Invalid=1);
    addr_suffix_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.addr_suffix_Invalid=1 AND h.addr_suffix_wouldClean);
    addr_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.addr_suffix_Invalid=2);
    addr_suffix_ALLOW_WouldModifyCount := COUNT(GROUP,h.addr_suffix_Invalid=2 AND h.addr_suffix_wouldClean);
    addr_suffix_LENGTHS_ErrorCount := COUNT(GROUP,h.addr_suffix_Invalid=3);
    addr_suffix_LENGTHS_WouldModifyCount := COUNT(GROUP,h.addr_suffix_Invalid=3 AND h.addr_suffix_wouldClean);
    addr_suffix_WORDS_ErrorCount := COUNT(GROUP,h.addr_suffix_Invalid=4);
    addr_suffix_WORDS_WouldModifyCount := COUNT(GROUP,h.addr_suffix_Invalid=4 AND h.addr_suffix_wouldClean);
    addr_suffix_Total_ErrorCount := COUNT(GROUP,h.addr_suffix_Invalid>0);
    postdir_LEFTTRIM_ErrorCount := COUNT(GROUP,h.postdir_Invalid=1);
    postdir_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.postdir_Invalid=1 AND h.postdir_wouldClean);
    postdir_ALLOW_ErrorCount := COUNT(GROUP,h.postdir_Invalid=2);
    postdir_ALLOW_WouldModifyCount := COUNT(GROUP,h.postdir_Invalid=2 AND h.postdir_wouldClean);
    postdir_LENGTHS_ErrorCount := COUNT(GROUP,h.postdir_Invalid=3);
    postdir_LENGTHS_WouldModifyCount := COUNT(GROUP,h.postdir_Invalid=3 AND h.postdir_wouldClean);
    postdir_WORDS_ErrorCount := COUNT(GROUP,h.postdir_Invalid=4);
    postdir_WORDS_WouldModifyCount := COUNT(GROUP,h.postdir_Invalid=4 AND h.postdir_wouldClean);
    postdir_Total_ErrorCount := COUNT(GROUP,h.postdir_Invalid>0);
    unit_desig_LEFTTRIM_ErrorCount := COUNT(GROUP,h.unit_desig_Invalid=1);
    unit_desig_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.unit_desig_Invalid=1 AND h.unit_desig_wouldClean);
    unit_desig_ALLOW_ErrorCount := COUNT(GROUP,h.unit_desig_Invalid=2);
    unit_desig_ALLOW_WouldModifyCount := COUNT(GROUP,h.unit_desig_Invalid=2 AND h.unit_desig_wouldClean);
    unit_desig_LENGTHS_ErrorCount := COUNT(GROUP,h.unit_desig_Invalid=3);
    unit_desig_LENGTHS_WouldModifyCount := COUNT(GROUP,h.unit_desig_Invalid=3 AND h.unit_desig_wouldClean);
    unit_desig_WORDS_ErrorCount := COUNT(GROUP,h.unit_desig_Invalid=4);
    unit_desig_WORDS_WouldModifyCount := COUNT(GROUP,h.unit_desig_Invalid=4 AND h.unit_desig_wouldClean);
    unit_desig_Total_ErrorCount := COUNT(GROUP,h.unit_desig_Invalid>0);
    sec_range_LEFTTRIM_ErrorCount := COUNT(GROUP,h.sec_range_Invalid=1);
    sec_range_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.sec_range_Invalid=1 AND h.sec_range_wouldClean);
    sec_range_ALLOW_ErrorCount := COUNT(GROUP,h.sec_range_Invalid=2);
    sec_range_ALLOW_WouldModifyCount := COUNT(GROUP,h.sec_range_Invalid=2 AND h.sec_range_wouldClean);
    sec_range_LENGTHS_ErrorCount := COUNT(GROUP,h.sec_range_Invalid=3);
    sec_range_LENGTHS_WouldModifyCount := COUNT(GROUP,h.sec_range_Invalid=3 AND h.sec_range_wouldClean);
    sec_range_WORDS_ErrorCount := COUNT(GROUP,h.sec_range_Invalid=4);
    sec_range_WORDS_WouldModifyCount := COUNT(GROUP,h.sec_range_Invalid=4 AND h.sec_range_wouldClean);
    sec_range_Total_ErrorCount := COUNT(GROUP,h.sec_range_Invalid>0);
    p_city_name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.p_city_name_Invalid=1);
    p_city_name_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.p_city_name_Invalid=1 AND h.p_city_name_wouldClean);
    p_city_name_ALLOW_ErrorCount := COUNT(GROUP,h.p_city_name_Invalid=2);
    p_city_name_ALLOW_WouldModifyCount := COUNT(GROUP,h.p_city_name_Invalid=2 AND h.p_city_name_wouldClean);
    p_city_name_LENGTHS_ErrorCount := COUNT(GROUP,h.p_city_name_Invalid=3);
    p_city_name_LENGTHS_WouldModifyCount := COUNT(GROUP,h.p_city_name_Invalid=3 AND h.p_city_name_wouldClean);
    p_city_name_WORDS_ErrorCount := COUNT(GROUP,h.p_city_name_Invalid=4);
    p_city_name_WORDS_WouldModifyCount := COUNT(GROUP,h.p_city_name_Invalid=4 AND h.p_city_name_wouldClean);
    p_city_name_Total_ErrorCount := COUNT(GROUP,h.p_city_name_Invalid>0);
    v_city_name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.v_city_name_Invalid=1);
    v_city_name_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.v_city_name_Invalid=1 AND h.v_city_name_wouldClean);
    v_city_name_ALLOW_ErrorCount := COUNT(GROUP,h.v_city_name_Invalid=2);
    v_city_name_ALLOW_WouldModifyCount := COUNT(GROUP,h.v_city_name_Invalid=2 AND h.v_city_name_wouldClean);
    v_city_name_LENGTHS_ErrorCount := COUNT(GROUP,h.v_city_name_Invalid=3);
    v_city_name_LENGTHS_WouldModifyCount := COUNT(GROUP,h.v_city_name_Invalid=3 AND h.v_city_name_wouldClean);
    v_city_name_WORDS_ErrorCount := COUNT(GROUP,h.v_city_name_Invalid=4);
    v_city_name_WORDS_WouldModifyCount := COUNT(GROUP,h.v_city_name_Invalid=4 AND h.v_city_name_wouldClean);
    v_city_name_Total_ErrorCount := COUNT(GROUP,h.v_city_name_Invalid>0);
    st_LEFTTRIM_ErrorCount := COUNT(GROUP,h.st_Invalid=1);
    st_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.st_Invalid=1 AND h.st_wouldClean);
    st_ALLOW_ErrorCount := COUNT(GROUP,h.st_Invalid=2);
    st_ALLOW_WouldModifyCount := COUNT(GROUP,h.st_Invalid=2 AND h.st_wouldClean);
    st_LENGTHS_ErrorCount := COUNT(GROUP,h.st_Invalid=3);
    st_LENGTHS_WouldModifyCount := COUNT(GROUP,h.st_Invalid=3 AND h.st_wouldClean);
    st_WORDS_ErrorCount := COUNT(GROUP,h.st_Invalid=4);
    st_WORDS_WouldModifyCount := COUNT(GROUP,h.st_Invalid=4 AND h.st_wouldClean);
    st_Total_ErrorCount := COUNT(GROUP,h.st_Invalid>0);
    zip_LEFTTRIM_ErrorCount := COUNT(GROUP,h.zip_Invalid=1);
    zip_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.zip_Invalid=1 AND h.zip_wouldClean);
    zip_ALLOW_ErrorCount := COUNT(GROUP,h.zip_Invalid=2);
    zip_ALLOW_WouldModifyCount := COUNT(GROUP,h.zip_Invalid=2 AND h.zip_wouldClean);
    zip_LENGTHS_ErrorCount := COUNT(GROUP,h.zip_Invalid=3);
    zip_LENGTHS_WouldModifyCount := COUNT(GROUP,h.zip_Invalid=3 AND h.zip_wouldClean);
    zip_WORDS_ErrorCount := COUNT(GROUP,h.zip_Invalid=4);
    zip_WORDS_WouldModifyCount := COUNT(GROUP,h.zip_Invalid=4 AND h.zip_wouldClean);
    zip_Total_ErrorCount := COUNT(GROUP,h.zip_Invalid>0);
    zip4_LEFTTRIM_ErrorCount := COUNT(GROUP,h.zip4_Invalid=1);
    zip4_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.zip4_Invalid=1 AND h.zip4_wouldClean);
    zip4_ALLOW_ErrorCount := COUNT(GROUP,h.zip4_Invalid=2);
    zip4_ALLOW_WouldModifyCount := COUNT(GROUP,h.zip4_Invalid=2 AND h.zip4_wouldClean);
    zip4_LENGTHS_ErrorCount := COUNT(GROUP,h.zip4_Invalid=3);
    zip4_LENGTHS_WouldModifyCount := COUNT(GROUP,h.zip4_Invalid=3 AND h.zip4_wouldClean);
    zip4_WORDS_ErrorCount := COUNT(GROUP,h.zip4_Invalid=4);
    zip4_WORDS_WouldModifyCount := COUNT(GROUP,h.zip4_Invalid=4 AND h.zip4_wouldClean);
    zip4_Total_ErrorCount := COUNT(GROUP,h.zip4_Invalid>0);
    cart_LEFTTRIM_ErrorCount := COUNT(GROUP,h.cart_Invalid=1);
    cart_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.cart_Invalid=1 AND h.cart_wouldClean);
    cart_ALLOW_ErrorCount := COUNT(GROUP,h.cart_Invalid=2);
    cart_ALLOW_WouldModifyCount := COUNT(GROUP,h.cart_Invalid=2 AND h.cart_wouldClean);
    cart_LENGTHS_ErrorCount := COUNT(GROUP,h.cart_Invalid=3);
    cart_LENGTHS_WouldModifyCount := COUNT(GROUP,h.cart_Invalid=3 AND h.cart_wouldClean);
    cart_WORDS_ErrorCount := COUNT(GROUP,h.cart_Invalid=4);
    cart_WORDS_WouldModifyCount := COUNT(GROUP,h.cart_Invalid=4 AND h.cart_wouldClean);
    cart_Total_ErrorCount := COUNT(GROUP,h.cart_Invalid>0);
    cr_sort_sz_LEFTTRIM_ErrorCount := COUNT(GROUP,h.cr_sort_sz_Invalid=1);
    cr_sort_sz_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.cr_sort_sz_Invalid=1 AND h.cr_sort_sz_wouldClean);
    cr_sort_sz_ALLOW_ErrorCount := COUNT(GROUP,h.cr_sort_sz_Invalid=2);
    cr_sort_sz_ALLOW_WouldModifyCount := COUNT(GROUP,h.cr_sort_sz_Invalid=2 AND h.cr_sort_sz_wouldClean);
    cr_sort_sz_LENGTHS_ErrorCount := COUNT(GROUP,h.cr_sort_sz_Invalid=3);
    cr_sort_sz_LENGTHS_WouldModifyCount := COUNT(GROUP,h.cr_sort_sz_Invalid=3 AND h.cr_sort_sz_wouldClean);
    cr_sort_sz_WORDS_ErrorCount := COUNT(GROUP,h.cr_sort_sz_Invalid=4);
    cr_sort_sz_WORDS_WouldModifyCount := COUNT(GROUP,h.cr_sort_sz_Invalid=4 AND h.cr_sort_sz_wouldClean);
    cr_sort_sz_Total_ErrorCount := COUNT(GROUP,h.cr_sort_sz_Invalid>0);
    lot_LEFTTRIM_ErrorCount := COUNT(GROUP,h.lot_Invalid=1);
    lot_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.lot_Invalid=1 AND h.lot_wouldClean);
    lot_ALLOW_ErrorCount := COUNT(GROUP,h.lot_Invalid=2);
    lot_ALLOW_WouldModifyCount := COUNT(GROUP,h.lot_Invalid=2 AND h.lot_wouldClean);
    lot_LENGTHS_ErrorCount := COUNT(GROUP,h.lot_Invalid=3);
    lot_LENGTHS_WouldModifyCount := COUNT(GROUP,h.lot_Invalid=3 AND h.lot_wouldClean);
    lot_WORDS_ErrorCount := COUNT(GROUP,h.lot_Invalid=4);
    lot_WORDS_WouldModifyCount := COUNT(GROUP,h.lot_Invalid=4 AND h.lot_wouldClean);
    lot_Total_ErrorCount := COUNT(GROUP,h.lot_Invalid>0);
    lot_order_LEFTTRIM_ErrorCount := COUNT(GROUP,h.lot_order_Invalid=1);
    lot_order_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.lot_order_Invalid=1 AND h.lot_order_wouldClean);
    lot_order_ALLOW_ErrorCount := COUNT(GROUP,h.lot_order_Invalid=2);
    lot_order_ALLOW_WouldModifyCount := COUNT(GROUP,h.lot_order_Invalid=2 AND h.lot_order_wouldClean);
    lot_order_LENGTHS_ErrorCount := COUNT(GROUP,h.lot_order_Invalid=3);
    lot_order_LENGTHS_WouldModifyCount := COUNT(GROUP,h.lot_order_Invalid=3 AND h.lot_order_wouldClean);
    lot_order_WORDS_ErrorCount := COUNT(GROUP,h.lot_order_Invalid=4);
    lot_order_WORDS_WouldModifyCount := COUNT(GROUP,h.lot_order_Invalid=4 AND h.lot_order_wouldClean);
    lot_order_Total_ErrorCount := COUNT(GROUP,h.lot_order_Invalid>0);
    dbpc_LEFTTRIM_ErrorCount := COUNT(GROUP,h.dbpc_Invalid=1);
    dbpc_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.dbpc_Invalid=1 AND h.dbpc_wouldClean);
    dbpc_ALLOW_ErrorCount := COUNT(GROUP,h.dbpc_Invalid=2);
    dbpc_ALLOW_WouldModifyCount := COUNT(GROUP,h.dbpc_Invalid=2 AND h.dbpc_wouldClean);
    dbpc_LENGTHS_ErrorCount := COUNT(GROUP,h.dbpc_Invalid=3);
    dbpc_LENGTHS_WouldModifyCount := COUNT(GROUP,h.dbpc_Invalid=3 AND h.dbpc_wouldClean);
    dbpc_WORDS_ErrorCount := COUNT(GROUP,h.dbpc_Invalid=4);
    dbpc_WORDS_WouldModifyCount := COUNT(GROUP,h.dbpc_Invalid=4 AND h.dbpc_wouldClean);
    dbpc_Total_ErrorCount := COUNT(GROUP,h.dbpc_Invalid>0);
    chk_digit_LEFTTRIM_ErrorCount := COUNT(GROUP,h.chk_digit_Invalid=1);
    chk_digit_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.chk_digit_Invalid=1 AND h.chk_digit_wouldClean);
    chk_digit_ALLOW_ErrorCount := COUNT(GROUP,h.chk_digit_Invalid=2);
    chk_digit_ALLOW_WouldModifyCount := COUNT(GROUP,h.chk_digit_Invalid=2 AND h.chk_digit_wouldClean);
    chk_digit_LENGTHS_ErrorCount := COUNT(GROUP,h.chk_digit_Invalid=3);
    chk_digit_LENGTHS_WouldModifyCount := COUNT(GROUP,h.chk_digit_Invalid=3 AND h.chk_digit_wouldClean);
    chk_digit_WORDS_ErrorCount := COUNT(GROUP,h.chk_digit_Invalid=4);
    chk_digit_WORDS_WouldModifyCount := COUNT(GROUP,h.chk_digit_Invalid=4 AND h.chk_digit_wouldClean);
    chk_digit_Total_ErrorCount := COUNT(GROUP,h.chk_digit_Invalid>0);
    rec_type_LEFTTRIM_ErrorCount := COUNT(GROUP,h.rec_type_Invalid=1);
    rec_type_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.rec_type_Invalid=1 AND h.rec_type_wouldClean);
    rec_type_ALLOW_ErrorCount := COUNT(GROUP,h.rec_type_Invalid=2);
    rec_type_ALLOW_WouldModifyCount := COUNT(GROUP,h.rec_type_Invalid=2 AND h.rec_type_wouldClean);
    rec_type_LENGTHS_ErrorCount := COUNT(GROUP,h.rec_type_Invalid=3);
    rec_type_LENGTHS_WouldModifyCount := COUNT(GROUP,h.rec_type_Invalid=3 AND h.rec_type_wouldClean);
    rec_type_WORDS_ErrorCount := COUNT(GROUP,h.rec_type_Invalid=4);
    rec_type_WORDS_WouldModifyCount := COUNT(GROUP,h.rec_type_Invalid=4 AND h.rec_type_wouldClean);
    rec_type_Total_ErrorCount := COUNT(GROUP,h.rec_type_Invalid>0);
    county_LEFTTRIM_ErrorCount := COUNT(GROUP,h.county_Invalid=1);
    county_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.county_Invalid=1 AND h.county_wouldClean);
    county_ALLOW_ErrorCount := COUNT(GROUP,h.county_Invalid=2);
    county_ALLOW_WouldModifyCount := COUNT(GROUP,h.county_Invalid=2 AND h.county_wouldClean);
    county_LENGTHS_ErrorCount := COUNT(GROUP,h.county_Invalid=3);
    county_LENGTHS_WouldModifyCount := COUNT(GROUP,h.county_Invalid=3 AND h.county_wouldClean);
    county_WORDS_ErrorCount := COUNT(GROUP,h.county_Invalid=4);
    county_WORDS_WouldModifyCount := COUNT(GROUP,h.county_Invalid=4 AND h.county_wouldClean);
    county_Total_ErrorCount := COUNT(GROUP,h.county_Invalid>0);
    geo_lat_LEFTTRIM_ErrorCount := COUNT(GROUP,h.geo_lat_Invalid=1);
    geo_lat_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.geo_lat_Invalid=1 AND h.geo_lat_wouldClean);
    geo_lat_ALLOW_ErrorCount := COUNT(GROUP,h.geo_lat_Invalid=2);
    geo_lat_ALLOW_WouldModifyCount := COUNT(GROUP,h.geo_lat_Invalid=2 AND h.geo_lat_wouldClean);
    geo_lat_LENGTHS_ErrorCount := COUNT(GROUP,h.geo_lat_Invalid=3);
    geo_lat_LENGTHS_WouldModifyCount := COUNT(GROUP,h.geo_lat_Invalid=3 AND h.geo_lat_wouldClean);
    geo_lat_WORDS_ErrorCount := COUNT(GROUP,h.geo_lat_Invalid=4);
    geo_lat_WORDS_WouldModifyCount := COUNT(GROUP,h.geo_lat_Invalid=4 AND h.geo_lat_wouldClean);
    geo_lat_Total_ErrorCount := COUNT(GROUP,h.geo_lat_Invalid>0);
    geo_long_LEFTTRIM_ErrorCount := COUNT(GROUP,h.geo_long_Invalid=1);
    geo_long_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.geo_long_Invalid=1 AND h.geo_long_wouldClean);
    geo_long_ALLOW_ErrorCount := COUNT(GROUP,h.geo_long_Invalid=2);
    geo_long_ALLOW_WouldModifyCount := COUNT(GROUP,h.geo_long_Invalid=2 AND h.geo_long_wouldClean);
    geo_long_LENGTHS_ErrorCount := COUNT(GROUP,h.geo_long_Invalid=3);
    geo_long_LENGTHS_WouldModifyCount := COUNT(GROUP,h.geo_long_Invalid=3 AND h.geo_long_wouldClean);
    geo_long_WORDS_ErrorCount := COUNT(GROUP,h.geo_long_Invalid=4);
    geo_long_WORDS_WouldModifyCount := COUNT(GROUP,h.geo_long_Invalid=4 AND h.geo_long_wouldClean);
    geo_long_Total_ErrorCount := COUNT(GROUP,h.geo_long_Invalid>0);
    msa_LEFTTRIM_ErrorCount := COUNT(GROUP,h.msa_Invalid=1);
    msa_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.msa_Invalid=1 AND h.msa_wouldClean);
    msa_ALLOW_ErrorCount := COUNT(GROUP,h.msa_Invalid=2);
    msa_ALLOW_WouldModifyCount := COUNT(GROUP,h.msa_Invalid=2 AND h.msa_wouldClean);
    msa_LENGTHS_ErrorCount := COUNT(GROUP,h.msa_Invalid=3);
    msa_LENGTHS_WouldModifyCount := COUNT(GROUP,h.msa_Invalid=3 AND h.msa_wouldClean);
    msa_WORDS_ErrorCount := COUNT(GROUP,h.msa_Invalid=4);
    msa_WORDS_WouldModifyCount := COUNT(GROUP,h.msa_Invalid=4 AND h.msa_wouldClean);
    msa_Total_ErrorCount := COUNT(GROUP,h.msa_Invalid>0);
    geo_blk_LEFTTRIM_ErrorCount := COUNT(GROUP,h.geo_blk_Invalid=1);
    geo_blk_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.geo_blk_Invalid=1 AND h.geo_blk_wouldClean);
    geo_blk_ALLOW_ErrorCount := COUNT(GROUP,h.geo_blk_Invalid=2);
    geo_blk_ALLOW_WouldModifyCount := COUNT(GROUP,h.geo_blk_Invalid=2 AND h.geo_blk_wouldClean);
    geo_blk_LENGTHS_ErrorCount := COUNT(GROUP,h.geo_blk_Invalid=3);
    geo_blk_LENGTHS_WouldModifyCount := COUNT(GROUP,h.geo_blk_Invalid=3 AND h.geo_blk_wouldClean);
    geo_blk_WORDS_ErrorCount := COUNT(GROUP,h.geo_blk_Invalid=4);
    geo_blk_WORDS_WouldModifyCount := COUNT(GROUP,h.geo_blk_Invalid=4 AND h.geo_blk_wouldClean);
    geo_blk_Total_ErrorCount := COUNT(GROUP,h.geo_blk_Invalid>0);
    geo_match_LEFTTRIM_ErrorCount := COUNT(GROUP,h.geo_match_Invalid=1);
    geo_match_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.geo_match_Invalid=1 AND h.geo_match_wouldClean);
    geo_match_ALLOW_ErrorCount := COUNT(GROUP,h.geo_match_Invalid=2);
    geo_match_ALLOW_WouldModifyCount := COUNT(GROUP,h.geo_match_Invalid=2 AND h.geo_match_wouldClean);
    geo_match_LENGTHS_ErrorCount := COUNT(GROUP,h.geo_match_Invalid=3);
    geo_match_LENGTHS_WouldModifyCount := COUNT(GROUP,h.geo_match_Invalid=3 AND h.geo_match_wouldClean);
    geo_match_WORDS_ErrorCount := COUNT(GROUP,h.geo_match_Invalid=4);
    geo_match_WORDS_WouldModifyCount := COUNT(GROUP,h.geo_match_Invalid=4 AND h.geo_match_wouldClean);
    geo_match_Total_ErrorCount := COUNT(GROUP,h.geo_match_Invalid>0);
    err_stat_LEFTTRIM_ErrorCount := COUNT(GROUP,h.err_stat_Invalid=1);
    err_stat_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.err_stat_Invalid=1 AND h.err_stat_wouldClean);
    err_stat_ALLOW_ErrorCount := COUNT(GROUP,h.err_stat_Invalid=2);
    err_stat_ALLOW_WouldModifyCount := COUNT(GROUP,h.err_stat_Invalid=2 AND h.err_stat_wouldClean);
    err_stat_LENGTHS_ErrorCount := COUNT(GROUP,h.err_stat_Invalid=3);
    err_stat_LENGTHS_WouldModifyCount := COUNT(GROUP,h.err_stat_Invalid=3 AND h.err_stat_wouldClean);
    err_stat_WORDS_ErrorCount := COUNT(GROUP,h.err_stat_Invalid=4);
    err_stat_WORDS_WouldModifyCount := COUNT(GROUP,h.err_stat_Invalid=4 AND h.err_stat_wouldClean);
    err_stat_Total_ErrorCount := COUNT(GROUP,h.err_stat_Invalid>0);
    delete_flag_LEFTTRIM_ErrorCount := COUNT(GROUP,h.delete_flag_Invalid=1);
    delete_flag_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.delete_flag_Invalid=1 AND h.delete_flag_wouldClean);
    delete_flag_ALLOW_ErrorCount := COUNT(GROUP,h.delete_flag_Invalid=2);
    delete_flag_ALLOW_WouldModifyCount := COUNT(GROUP,h.delete_flag_Invalid=2 AND h.delete_flag_wouldClean);
    delete_flag_LENGTHS_ErrorCount := COUNT(GROUP,h.delete_flag_Invalid=3);
    delete_flag_LENGTHS_WouldModifyCount := COUNT(GROUP,h.delete_flag_Invalid=3 AND h.delete_flag_wouldClean);
    delete_flag_WORDS_ErrorCount := COUNT(GROUP,h.delete_flag_Invalid=4);
    delete_flag_WORDS_WouldModifyCount := COUNT(GROUP,h.delete_flag_Invalid=4 AND h.delete_flag_wouldClean);
    delete_flag_Total_ErrorCount := COUNT(GROUP,h.delete_flag_Invalid>0);
    delete_file_date_LEFTTRIM_ErrorCount := COUNT(GROUP,h.delete_file_date_Invalid=1);
    delete_file_date_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.delete_file_date_Invalid=1 AND h.delete_file_date_wouldClean);
    delete_file_date_ALLOW_ErrorCount := COUNT(GROUP,h.delete_file_date_Invalid=2);
    delete_file_date_ALLOW_WouldModifyCount := COUNT(GROUP,h.delete_file_date_Invalid=2 AND h.delete_file_date_wouldClean);
    delete_file_date_LENGTHS_ErrorCount := COUNT(GROUP,h.delete_file_date_Invalid=3);
    delete_file_date_LENGTHS_WouldModifyCount := COUNT(GROUP,h.delete_file_date_Invalid=3 AND h.delete_file_date_wouldClean);
    delete_file_date_WORDS_ErrorCount := COUNT(GROUP,h.delete_file_date_Invalid=4);
    delete_file_date_WORDS_WouldModifyCount := COUNT(GROUP,h.delete_file_date_Invalid=4 AND h.delete_file_date_wouldClean);
    delete_file_date_Total_ErrorCount := COUNT(GROUP,h.delete_file_date_Invalid>0);
    suppression_code_LEFTTRIM_ErrorCount := COUNT(GROUP,h.suppression_code_Invalid=1);
    suppression_code_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.suppression_code_Invalid=1 AND h.suppression_code_wouldClean);
    suppression_code_ALLOW_ErrorCount := COUNT(GROUP,h.suppression_code_Invalid=2);
    suppression_code_ALLOW_WouldModifyCount := COUNT(GROUP,h.suppression_code_Invalid=2 AND h.suppression_code_wouldClean);
    suppression_code_LENGTHS_ErrorCount := COUNT(GROUP,h.suppression_code_Invalid=3);
    suppression_code_LENGTHS_WouldModifyCount := COUNT(GROUP,h.suppression_code_Invalid=3 AND h.suppression_code_wouldClean);
    suppression_code_WORDS_ErrorCount := COUNT(GROUP,h.suppression_code_Invalid=4);
    suppression_code_WORDS_WouldModifyCount := COUNT(GROUP,h.suppression_code_Invalid=4 AND h.suppression_code_wouldClean);
    suppression_code_Total_ErrorCount := COUNT(GROUP,h.suppression_code_Invalid>0);
    deceased_ind_LEFTTRIM_ErrorCount := COUNT(GROUP,h.deceased_ind_Invalid=1);
    deceased_ind_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.deceased_ind_Invalid=1 AND h.deceased_ind_wouldClean);
    deceased_ind_ALLOW_ErrorCount := COUNT(GROUP,h.deceased_ind_Invalid=2);
    deceased_ind_ALLOW_WouldModifyCount := COUNT(GROUP,h.deceased_ind_Invalid=2 AND h.deceased_ind_wouldClean);
    deceased_ind_LENGTHS_ErrorCount := COUNT(GROUP,h.deceased_ind_Invalid=3);
    deceased_ind_LENGTHS_WouldModifyCount := COUNT(GROUP,h.deceased_ind_Invalid=3 AND h.deceased_ind_wouldClean);
    deceased_ind_WORDS_ErrorCount := COUNT(GROUP,h.deceased_ind_Invalid=4);
    deceased_ind_WORDS_WouldModifyCount := COUNT(GROUP,h.deceased_ind_Invalid=4 AND h.deceased_ind_wouldClean);
    deceased_ind_Total_ErrorCount := COUNT(GROUP,h.deceased_ind_Invalid>0);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.seq_rec_id_Invalid > 0 OR h.did_Invalid > 0 OR h.did_score_field_Invalid > 0 OR h.current_rec_flag_Invalid > 0 OR h.current_experian_pin_Invalid > 0 OR h.date_first_seen_Invalid > 0 OR h.date_last_seen_Invalid > 0 OR h.date_vendor_first_reported_Invalid > 0 OR h.date_vendor_last_reported_Invalid > 0 OR h.encrypted_experian_pin_Invalid > 0 OR h.social_security_number_Invalid > 0 OR h.date_of_birth_Invalid > 0 OR h.telephone_Invalid > 0 OR h.gender_Invalid > 0 OR h.additional_name_count_Invalid > 0 OR h.previous_address_count_Invalid > 0 OR h.nametype_Invalid > 0 OR h.orig_consumer_create_date_Invalid > 0 OR h.orig_fname_Invalid > 0 OR h.orig_mname_Invalid > 0 OR h.orig_lname_Invalid > 0 OR h.orig_suffix_Invalid > 0 OR h.title_Invalid > 0 OR h.fname_Invalid > 0 OR h.mname_Invalid > 0 OR h.lname_Invalid > 0 OR h.name_suffix_Invalid > 0 OR h.name_score_Invalid > 0 OR h.addressseq_Invalid > 0 OR h.orig_address_create_date_Invalid > 0 OR h.orig_address_update_date_Invalid > 0 OR h.orig_prim_range_Invalid > 0 OR h.orig_predir_Invalid > 0 OR h.orig_prim_name_Invalid > 0 OR h.orig_addr_suffix_Invalid > 0 OR h.orig_postdir_Invalid > 0 OR h.orig_unit_desig_Invalid > 0 OR h.orig_sec_range_Invalid > 0 OR h.orig_city_Invalid > 0 OR h.orig_state_Invalid > 0 OR h.orig_zipcode_Invalid > 0 OR h.orig_zipcode4_Invalid > 0 OR h.prim_range_Invalid > 0 OR h.predir_Invalid > 0 OR h.prim_name_Invalid > 0 OR h.addr_suffix_Invalid > 0 OR h.postdir_Invalid > 0 OR h.unit_desig_Invalid > 0 OR h.sec_range_Invalid > 0 OR h.p_city_name_Invalid > 0 OR h.v_city_name_Invalid > 0 OR h.st_Invalid > 0 OR h.zip_Invalid > 0 OR h.zip4_Invalid > 0 OR h.cart_Invalid > 0 OR h.cr_sort_sz_Invalid > 0 OR h.lot_Invalid > 0 OR h.lot_order_Invalid > 0 OR h.dbpc_Invalid > 0 OR h.chk_digit_Invalid > 0 OR h.rec_type_Invalid > 0 OR h.county_Invalid > 0 OR h.geo_lat_Invalid > 0 OR h.geo_long_Invalid > 0 OR h.msa_Invalid > 0 OR h.geo_blk_Invalid > 0 OR h.geo_match_Invalid > 0 OR h.err_stat_Invalid > 0 OR h.delete_flag_Invalid > 0 OR h.delete_file_date_Invalid > 0 OR h.suppression_code_Invalid > 0 OR h.deceased_ind_Invalid > 0);
    AnyRule_WithEditsCount := COUNT(GROUP, h.seq_rec_id_wouldClean OR h.did_wouldClean OR h.did_score_field_wouldClean OR h.current_rec_flag_wouldClean OR h.current_experian_pin_wouldClean OR h.date_first_seen_wouldClean OR h.date_last_seen_wouldClean OR h.date_vendor_first_reported_wouldClean OR h.date_vendor_last_reported_wouldClean OR h.encrypted_experian_pin_wouldClean OR h.social_security_number_wouldClean OR h.date_of_birth_wouldClean OR h.telephone_wouldClean OR h.gender_wouldClean OR h.additional_name_count_wouldClean OR h.previous_address_count_wouldClean OR h.nametype_wouldClean OR h.orig_consumer_create_date_wouldClean OR h.orig_fname_wouldClean OR h.orig_mname_wouldClean OR h.orig_lname_wouldClean OR h.orig_suffix_wouldClean OR h.title_wouldClean OR h.fname_wouldClean OR h.mname_wouldClean OR h.lname_wouldClean OR h.name_suffix_wouldClean OR h.name_score_wouldClean OR h.addressseq_wouldClean OR h.orig_address_create_date_wouldClean OR h.orig_address_update_date_wouldClean OR h.orig_prim_range_wouldClean OR h.orig_predir_wouldClean OR h.orig_prim_name_wouldClean OR h.orig_addr_suffix_wouldClean OR h.orig_postdir_wouldClean OR h.orig_unit_desig_wouldClean OR h.orig_sec_range_wouldClean OR h.orig_city_wouldClean OR h.orig_state_wouldClean OR h.orig_zipcode_wouldClean OR h.orig_zipcode4_wouldClean OR h.prim_range_wouldClean OR h.predir_wouldClean OR h.prim_name_wouldClean OR h.addr_suffix_wouldClean OR h.postdir_wouldClean OR h.unit_desig_wouldClean OR h.sec_range_wouldClean OR h.p_city_name_wouldClean OR h.v_city_name_wouldClean OR h.st_wouldClean OR h.zip_wouldClean OR h.zip4_wouldClean OR h.cart_wouldClean OR h.cr_sort_sz_wouldClean OR h.lot_wouldClean OR h.lot_order_wouldClean OR h.dbpc_wouldClean OR h.chk_digit_wouldClean OR h.rec_type_wouldClean OR h.county_wouldClean OR h.geo_lat_wouldClean OR h.geo_long_wouldClean OR h.msa_wouldClean OR h.geo_blk_wouldClean OR h.geo_match_wouldClean OR h.err_stat_wouldClean OR h.delete_flag_wouldClean OR h.delete_file_date_wouldClean OR h.suppression_code_wouldClean OR h.deceased_ind_wouldClean);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
    Rules_WithEdits := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.seq_rec_id_Total_ErrorCount > 0, 1, 0) + IF(le.did_Total_ErrorCount > 0, 1, 0) + IF(le.did_score_field_Total_ErrorCount > 0, 1, 0) + IF(le.current_rec_flag_Total_ErrorCount > 0, 1, 0) + IF(le.current_experian_pin_Total_ErrorCount > 0, 1, 0) + IF(le.date_first_seen_Total_ErrorCount > 0, 1, 0) + IF(le.date_last_seen_Total_ErrorCount > 0, 1, 0) + IF(le.date_vendor_first_reported_Total_ErrorCount > 0, 1, 0) + IF(le.date_vendor_last_reported_Total_ErrorCount > 0, 1, 0) + IF(le.encrypted_experian_pin_Total_ErrorCount > 0, 1, 0) + IF(le.social_security_number_Total_ErrorCount > 0, 1, 0) + IF(le.date_of_birth_Total_ErrorCount > 0, 1, 0) + IF(le.telephone_Total_ErrorCount > 0, 1, 0) + IF(le.gender_Total_ErrorCount > 0, 1, 0) + IF(le.additional_name_count_Total_ErrorCount > 0, 1, 0) + IF(le.previous_address_count_Total_ErrorCount > 0, 1, 0) + IF(le.nametype_Total_ErrorCount > 0, 1, 0) + IF(le.orig_consumer_create_date_Total_ErrorCount > 0, 1, 0) + IF(le.orig_fname_Total_ErrorCount > 0, 1, 0) + IF(le.orig_mname_Total_ErrorCount > 0, 1, 0) + IF(le.orig_lname_Total_ErrorCount > 0, 1, 0) + IF(le.orig_suffix_Total_ErrorCount > 0, 1, 0) + IF(le.title_Total_ErrorCount > 0, 1, 0) + IF(le.fname_Total_ErrorCount > 0, 1, 0) + IF(le.mname_Total_ErrorCount > 0, 1, 0) + IF(le.lname_Total_ErrorCount > 0, 1, 0) + IF(le.name_suffix_Total_ErrorCount > 0, 1, 0) + IF(le.name_score_Total_ErrorCount > 0, 1, 0) + IF(le.addressseq_Total_ErrorCount > 0, 1, 0) + IF(le.orig_address_create_date_Total_ErrorCount > 0, 1, 0) + IF(le.orig_address_update_date_Total_ErrorCount > 0, 1, 0) + IF(le.orig_prim_range_Total_ErrorCount > 0, 1, 0) + IF(le.orig_predir_Total_ErrorCount > 0, 1, 0) + IF(le.orig_prim_name_Total_ErrorCount > 0, 1, 0) + IF(le.orig_addr_suffix_Total_ErrorCount > 0, 1, 0) + IF(le.orig_postdir_Total_ErrorCount > 0, 1, 0) + IF(le.orig_unit_desig_Total_ErrorCount > 0, 1, 0) + IF(le.orig_sec_range_Total_ErrorCount > 0, 1, 0) + IF(le.orig_city_Total_ErrorCount > 0, 1, 0) + IF(le.orig_state_Total_ErrorCount > 0, 1, 0) + IF(le.orig_zipcode_Total_ErrorCount > 0, 1, 0) + IF(le.orig_zipcode4_Total_ErrorCount > 0, 1, 0) + IF(le.prim_range_Total_ErrorCount > 0, 1, 0) + IF(le.predir_Total_ErrorCount > 0, 1, 0) + IF(le.prim_name_Total_ErrorCount > 0, 1, 0) + IF(le.addr_suffix_Total_ErrorCount > 0, 1, 0) + IF(le.postdir_Total_ErrorCount > 0, 1, 0) + IF(le.unit_desig_Total_ErrorCount > 0, 1, 0) + IF(le.sec_range_Total_ErrorCount > 0, 1, 0) + IF(le.p_city_name_Total_ErrorCount > 0, 1, 0) + IF(le.v_city_name_Total_ErrorCount > 0, 1, 0) + IF(le.st_Total_ErrorCount > 0, 1, 0) + IF(le.zip_Total_ErrorCount > 0, 1, 0) + IF(le.zip4_Total_ErrorCount > 0, 1, 0) + IF(le.cart_Total_ErrorCount > 0, 1, 0) + IF(le.cr_sort_sz_Total_ErrorCount > 0, 1, 0) + IF(le.lot_Total_ErrorCount > 0, 1, 0) + IF(le.lot_order_Total_ErrorCount > 0, 1, 0) + IF(le.dbpc_Total_ErrorCount > 0, 1, 0) + IF(le.chk_digit_Total_ErrorCount > 0, 1, 0) + IF(le.rec_type_Total_ErrorCount > 0, 1, 0) + IF(le.county_Total_ErrorCount > 0, 1, 0) + IF(le.geo_lat_Total_ErrorCount > 0, 1, 0) + IF(le.geo_long_Total_ErrorCount > 0, 1, 0) + IF(le.msa_Total_ErrorCount > 0, 1, 0) + IF(le.geo_blk_Total_ErrorCount > 0, 1, 0) + IF(le.geo_match_Total_ErrorCount > 0, 1, 0) + IF(le.err_stat_Total_ErrorCount > 0, 1, 0) + IF(le.delete_flag_Total_ErrorCount > 0, 1, 0) + IF(le.delete_file_date_Total_ErrorCount > 0, 1, 0) + IF(le.suppression_code_Total_ErrorCount > 0, 1, 0) + IF(le.deceased_ind_Total_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.seq_rec_id_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.seq_rec_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.seq_rec_id_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.seq_rec_id_WORDS_ErrorCount > 0, 1, 0) + IF(le.did_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.did_ALLOW_ErrorCount > 0, 1, 0) + IF(le.did_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.did_WORDS_ErrorCount > 0, 1, 0) + IF(le.did_score_field_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.did_score_field_ALLOW_ErrorCount > 0, 1, 0) + IF(le.did_score_field_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.did_score_field_WORDS_ErrorCount > 0, 1, 0) + IF(le.current_rec_flag_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.current_rec_flag_ALLOW_ErrorCount > 0, 1, 0) + IF(le.current_rec_flag_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.current_rec_flag_WORDS_ErrorCount > 0, 1, 0) + IF(le.current_experian_pin_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.current_experian_pin_ALLOW_ErrorCount > 0, 1, 0) + IF(le.current_experian_pin_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.current_experian_pin_WORDS_ErrorCount > 0, 1, 0) + IF(le.date_first_seen_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.date_first_seen_ALLOW_ErrorCount > 0, 1, 0) + IF(le.date_first_seen_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.date_first_seen_WORDS_ErrorCount > 0, 1, 0) + IF(le.date_last_seen_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.date_last_seen_ALLOW_ErrorCount > 0, 1, 0) + IF(le.date_last_seen_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.date_last_seen_WORDS_ErrorCount > 0, 1, 0) + IF(le.date_vendor_first_reported_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.date_vendor_first_reported_ALLOW_ErrorCount > 0, 1, 0) + IF(le.date_vendor_first_reported_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.date_vendor_first_reported_WORDS_ErrorCount > 0, 1, 0) + IF(le.date_vendor_last_reported_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.date_vendor_last_reported_ALLOW_ErrorCount > 0, 1, 0) + IF(le.date_vendor_last_reported_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.date_vendor_last_reported_WORDS_ErrorCount > 0, 1, 0) + IF(le.encrypted_experian_pin_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.encrypted_experian_pin_ALLOW_ErrorCount > 0, 1, 0) + IF(le.encrypted_experian_pin_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.encrypted_experian_pin_WORDS_ErrorCount > 0, 1, 0) + IF(le.social_security_number_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.social_security_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.social_security_number_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.social_security_number_WORDS_ErrorCount > 0, 1, 0) + IF(le.date_of_birth_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.date_of_birth_ALLOW_ErrorCount > 0, 1, 0) + IF(le.date_of_birth_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.date_of_birth_WORDS_ErrorCount > 0, 1, 0) + IF(le.telephone_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.telephone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.telephone_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.telephone_WORDS_ErrorCount > 0, 1, 0) + IF(le.gender_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.gender_ALLOW_ErrorCount > 0, 1, 0) + IF(le.gender_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.gender_WORDS_ErrorCount > 0, 1, 0) + IF(le.additional_name_count_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.additional_name_count_ALLOW_ErrorCount > 0, 1, 0) + IF(le.additional_name_count_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.additional_name_count_WORDS_ErrorCount > 0, 1, 0) + IF(le.previous_address_count_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.previous_address_count_ALLOW_ErrorCount > 0, 1, 0) + IF(le.previous_address_count_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.previous_address_count_WORDS_ErrorCount > 0, 1, 0) + IF(le.nametype_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.nametype_ALLOW_ErrorCount > 0, 1, 0) + IF(le.nametype_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.nametype_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_consumer_create_date_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_consumer_create_date_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_consumer_create_date_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_consumer_create_date_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_fname_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_fname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_fname_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_fname_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_mname_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_mname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_mname_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_mname_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_lname_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_lname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_lname_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_lname_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_suffix_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_suffix_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_suffix_WORDS_ErrorCount > 0, 1, 0) + IF(le.title_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.title_ALLOW_ErrorCount > 0, 1, 0) + IF(le.title_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.title_WORDS_ErrorCount > 0, 1, 0) + IF(le.fname_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.fname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fname_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.fname_WORDS_ErrorCount > 0, 1, 0) + IF(le.mname_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.mname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mname_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.mname_WORDS_ErrorCount > 0, 1, 0) + IF(le.lname_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.lname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lname_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.lname_WORDS_ErrorCount > 0, 1, 0) + IF(le.name_suffix_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.name_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.name_suffix_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.name_suffix_WORDS_ErrorCount > 0, 1, 0) + IF(le.name_score_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.name_score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.name_score_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.name_score_WORDS_ErrorCount > 0, 1, 0) + IF(le.addressseq_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.addressseq_ALLOW_ErrorCount > 0, 1, 0) + IF(le.addressseq_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.addressseq_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_address_create_date_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_address_create_date_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_address_create_date_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_address_create_date_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_address_update_date_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_address_update_date_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_address_update_date_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_address_update_date_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_prim_range_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_prim_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_prim_range_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_prim_range_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_predir_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_predir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_predir_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_predir_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_prim_name_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_prim_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_prim_name_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_prim_name_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_addr_suffix_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_addr_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_addr_suffix_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_addr_suffix_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_postdir_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_postdir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_postdir_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_postdir_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_unit_desig_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_unit_desig_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_unit_desig_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_unit_desig_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_sec_range_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_sec_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_sec_range_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_sec_range_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_city_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_city_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_city_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_state_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_state_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_state_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_zipcode_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_zipcode_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_zipcode_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_zipcode_WORDS_ErrorCount > 0, 1, 0) + IF(le.orig_zipcode4_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.orig_zipcode4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_zipcode4_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_zipcode4_WORDS_ErrorCount > 0, 1, 0) + IF(le.prim_range_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.prim_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prim_range_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.prim_range_WORDS_ErrorCount > 0, 1, 0) + IF(le.predir_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.predir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.predir_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.predir_WORDS_ErrorCount > 0, 1, 0) + IF(le.prim_name_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.prim_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prim_name_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.prim_name_WORDS_ErrorCount > 0, 1, 0) + IF(le.addr_suffix_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.addr_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.addr_suffix_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.addr_suffix_WORDS_ErrorCount > 0, 1, 0) + IF(le.postdir_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.postdir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.postdir_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.postdir_WORDS_ErrorCount > 0, 1, 0) + IF(le.unit_desig_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.unit_desig_ALLOW_ErrorCount > 0, 1, 0) + IF(le.unit_desig_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.unit_desig_WORDS_ErrorCount > 0, 1, 0) + IF(le.sec_range_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.sec_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sec_range_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.sec_range_WORDS_ErrorCount > 0, 1, 0) + IF(le.p_city_name_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.p_city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.p_city_name_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.p_city_name_WORDS_ErrorCount > 0, 1, 0) + IF(le.v_city_name_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.v_city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.v_city_name_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.v_city_name_WORDS_ErrorCount > 0, 1, 0) + IF(le.st_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.st_ALLOW_ErrorCount > 0, 1, 0) + IF(le.st_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.st_WORDS_ErrorCount > 0, 1, 0) + IF(le.zip_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.zip_WORDS_ErrorCount > 0, 1, 0) + IF(le.zip4_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.zip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip4_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.zip4_WORDS_ErrorCount > 0, 1, 0) + IF(le.cart_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.cart_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cart_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.cart_WORDS_ErrorCount > 0, 1, 0) + IF(le.cr_sort_sz_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.cr_sort_sz_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cr_sort_sz_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.cr_sort_sz_WORDS_ErrorCount > 0, 1, 0) + IF(le.lot_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.lot_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lot_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.lot_WORDS_ErrorCount > 0, 1, 0) + IF(le.lot_order_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.lot_order_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lot_order_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.lot_order_WORDS_ErrorCount > 0, 1, 0) + IF(le.dbpc_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.dbpc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dbpc_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.dbpc_WORDS_ErrorCount > 0, 1, 0) + IF(le.chk_digit_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.chk_digit_ALLOW_ErrorCount > 0, 1, 0) + IF(le.chk_digit_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.chk_digit_WORDS_ErrorCount > 0, 1, 0) + IF(le.rec_type_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.rec_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rec_type_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.rec_type_WORDS_ErrorCount > 0, 1, 0) + IF(le.county_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.county_ALLOW_ErrorCount > 0, 1, 0) + IF(le.county_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.county_WORDS_ErrorCount > 0, 1, 0) + IF(le.geo_lat_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.geo_lat_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_lat_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.geo_lat_WORDS_ErrorCount > 0, 1, 0) + IF(le.geo_long_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.geo_long_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_long_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.geo_long_WORDS_ErrorCount > 0, 1, 0) + IF(le.msa_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.msa_ALLOW_ErrorCount > 0, 1, 0) + IF(le.msa_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.msa_WORDS_ErrorCount > 0, 1, 0) + IF(le.geo_blk_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.geo_blk_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_blk_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.geo_blk_WORDS_ErrorCount > 0, 1, 0) + IF(le.geo_match_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.geo_match_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_match_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.geo_match_WORDS_ErrorCount > 0, 1, 0) + IF(le.err_stat_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.err_stat_ALLOW_ErrorCount > 0, 1, 0) + IF(le.err_stat_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.err_stat_WORDS_ErrorCount > 0, 1, 0) + IF(le.delete_flag_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.delete_flag_ALLOW_ErrorCount > 0, 1, 0) + IF(le.delete_flag_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.delete_flag_WORDS_ErrorCount > 0, 1, 0) + IF(le.delete_file_date_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.delete_file_date_ALLOW_ErrorCount > 0, 1, 0) + IF(le.delete_file_date_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.delete_file_date_WORDS_ErrorCount > 0, 1, 0) + IF(le.suppression_code_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.suppression_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.suppression_code_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.suppression_code_WORDS_ErrorCount > 0, 1, 0) + IF(le.deceased_ind_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.deceased_ind_ALLOW_ErrorCount > 0, 1, 0) + IF(le.deceased_ind_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.deceased_ind_WORDS_ErrorCount > 0, 1, 0);
    SELF.Rules_NoErrors := NumRules - SELF.Rules_WithErrors;
    SELF.Rules_WithEdits := IF(le.seq_rec_id_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.seq_rec_id_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.seq_rec_id_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.seq_rec_id_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.did_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.did_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.did_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.did_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.did_score_field_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.did_score_field_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.did_score_field_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.did_score_field_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.current_rec_flag_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.current_rec_flag_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.current_rec_flag_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.current_rec_flag_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.current_experian_pin_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.current_experian_pin_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.current_experian_pin_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.current_experian_pin_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.date_first_seen_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.date_first_seen_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.date_first_seen_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.date_first_seen_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.date_last_seen_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.date_last_seen_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.date_last_seen_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.date_last_seen_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.date_vendor_first_reported_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.date_vendor_first_reported_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.date_vendor_first_reported_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.date_vendor_first_reported_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.date_vendor_last_reported_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.date_vendor_last_reported_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.date_vendor_last_reported_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.date_vendor_last_reported_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.encrypted_experian_pin_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.encrypted_experian_pin_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.encrypted_experian_pin_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.encrypted_experian_pin_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.social_security_number_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.social_security_number_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.social_security_number_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.social_security_number_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.date_of_birth_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.date_of_birth_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.date_of_birth_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.date_of_birth_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.telephone_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.telephone_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.telephone_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.telephone_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.gender_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.gender_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.gender_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.gender_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.additional_name_count_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.additional_name_count_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.additional_name_count_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.additional_name_count_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.previous_address_count_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.previous_address_count_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.previous_address_count_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.previous_address_count_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.nametype_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.nametype_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.nametype_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.nametype_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_consumer_create_date_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_consumer_create_date_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_consumer_create_date_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_consumer_create_date_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_fname_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_fname_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_fname_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_fname_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_mname_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_mname_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_mname_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_mname_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_lname_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_lname_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_lname_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_lname_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_suffix_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_suffix_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_suffix_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_suffix_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.title_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.title_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.title_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.title_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.fname_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.fname_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.fname_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.fname_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.mname_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.mname_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.mname_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.mname_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.lname_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.lname_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.lname_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.lname_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.name_suffix_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.name_suffix_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.name_suffix_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.name_suffix_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.name_score_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.name_score_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.name_score_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.name_score_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.addressseq_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.addressseq_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.addressseq_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.addressseq_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_address_create_date_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_address_create_date_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_address_create_date_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_address_create_date_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_address_update_date_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_address_update_date_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_address_update_date_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_address_update_date_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_prim_range_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_prim_range_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_prim_range_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_prim_range_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_predir_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_predir_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_predir_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_predir_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_prim_name_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_prim_name_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_prim_name_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_prim_name_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_addr_suffix_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_addr_suffix_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_addr_suffix_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_addr_suffix_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_postdir_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_postdir_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_postdir_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_postdir_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_unit_desig_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_unit_desig_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_unit_desig_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_unit_desig_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_sec_range_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_sec_range_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_sec_range_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_sec_range_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_city_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_city_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_city_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_city_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_state_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_state_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_state_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_state_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_zipcode_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_zipcode_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_zipcode_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_zipcode_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.orig_zipcode4_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.orig_zipcode4_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.orig_zipcode4_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.orig_zipcode4_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.prim_range_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.prim_range_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.prim_range_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.prim_range_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.predir_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.predir_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.predir_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.predir_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.prim_name_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.prim_name_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.prim_name_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.prim_name_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.addr_suffix_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.addr_suffix_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.addr_suffix_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.addr_suffix_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.postdir_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.postdir_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.postdir_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.postdir_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.unit_desig_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.unit_desig_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.unit_desig_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.unit_desig_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.sec_range_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.sec_range_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.sec_range_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.sec_range_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.p_city_name_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.p_city_name_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.p_city_name_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.p_city_name_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.v_city_name_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.v_city_name_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.v_city_name_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.v_city_name_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.st_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.st_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.st_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.st_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.zip_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.zip_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.zip_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.zip_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.zip4_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.zip4_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.zip4_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.zip4_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.cart_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.cart_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.cart_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.cart_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.cr_sort_sz_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.cr_sort_sz_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.cr_sort_sz_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.cr_sort_sz_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.lot_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.lot_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.lot_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.lot_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.lot_order_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.lot_order_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.lot_order_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.lot_order_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.dbpc_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.dbpc_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.dbpc_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.dbpc_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.chk_digit_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.chk_digit_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.chk_digit_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.chk_digit_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.rec_type_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.rec_type_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.rec_type_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.rec_type_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.county_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.county_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.county_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.county_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.geo_lat_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.geo_lat_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.geo_lat_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.geo_lat_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.geo_long_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.geo_long_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.geo_long_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.geo_long_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.msa_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.msa_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.msa_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.msa_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.geo_blk_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.geo_blk_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.geo_blk_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.geo_blk_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.geo_match_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.geo_match_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.geo_match_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.geo_match_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.err_stat_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.err_stat_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.err_stat_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.err_stat_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.delete_flag_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.delete_flag_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.delete_flag_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.delete_flag_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.delete_file_date_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.delete_file_date_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.delete_file_date_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.delete_file_date_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.suppression_code_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.suppression_code_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.suppression_code_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.suppression_code_WORDS_WouldModifyCount > 0, 1, 0) + IF(le.deceased_ind_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.deceased_ind_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.deceased_ind_LENGTHS_WouldModifyCount > 0, 1, 0) + IF(le.deceased_ind_WORDS_WouldModifyCount > 0, 1, 0);
    SELF := le;
  END;
  EXPORT SummaryStats := PROJECT(SummaryStats0, xAddErrSummary(LEFT));
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT311.StrType ErrorMessage;
    SALT311.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.seq_rec_id_Invalid,le.did_Invalid,le.did_score_field_Invalid,le.current_rec_flag_Invalid,le.current_experian_pin_Invalid,le.date_first_seen_Invalid,le.date_last_seen_Invalid,le.date_vendor_first_reported_Invalid,le.date_vendor_last_reported_Invalid,le.encrypted_experian_pin_Invalid,le.social_security_number_Invalid,le.date_of_birth_Invalid,le.telephone_Invalid,le.gender_Invalid,le.additional_name_count_Invalid,le.previous_address_count_Invalid,le.nametype_Invalid,le.orig_consumer_create_date_Invalid,le.orig_fname_Invalid,le.orig_mname_Invalid,le.orig_lname_Invalid,le.orig_suffix_Invalid,le.title_Invalid,le.fname_Invalid,le.mname_Invalid,le.lname_Invalid,le.name_suffix_Invalid,le.name_score_Invalid,le.addressseq_Invalid,le.orig_address_create_date_Invalid,le.orig_address_update_date_Invalid,le.orig_prim_range_Invalid,le.orig_predir_Invalid,le.orig_prim_name_Invalid,le.orig_addr_suffix_Invalid,le.orig_postdir_Invalid,le.orig_unit_desig_Invalid,le.orig_sec_range_Invalid,le.orig_city_Invalid,le.orig_state_Invalid,le.orig_zipcode_Invalid,le.orig_zipcode4_Invalid,le.prim_range_Invalid,le.predir_Invalid,le.prim_name_Invalid,le.addr_suffix_Invalid,le.postdir_Invalid,le.unit_desig_Invalid,le.sec_range_Invalid,le.p_city_name_Invalid,le.v_city_name_Invalid,le.st_Invalid,le.zip_Invalid,le.zip4_Invalid,le.cart_Invalid,le.cr_sort_sz_Invalid,le.lot_Invalid,le.lot_order_Invalid,le.dbpc_Invalid,le.chk_digit_Invalid,le.rec_type_Invalid,le.county_Invalid,le.geo_lat_Invalid,le.geo_long_Invalid,le.msa_Invalid,le.geo_blk_Invalid,le.geo_match_Invalid,le.err_stat_Invalid,le.delete_flag_Invalid,le.delete_file_date_Invalid,le.suppression_code_Invalid,le.deceased_ind_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_seq_rec_id(le.seq_rec_id_Invalid),Fields.InvalidMessage_did(le.did_Invalid),Fields.InvalidMessage_did_score_field(le.did_score_field_Invalid),Fields.InvalidMessage_current_rec_flag(le.current_rec_flag_Invalid),Fields.InvalidMessage_current_experian_pin(le.current_experian_pin_Invalid),Fields.InvalidMessage_date_first_seen(le.date_first_seen_Invalid),Fields.InvalidMessage_date_last_seen(le.date_last_seen_Invalid),Fields.InvalidMessage_date_vendor_first_reported(le.date_vendor_first_reported_Invalid),Fields.InvalidMessage_date_vendor_last_reported(le.date_vendor_last_reported_Invalid),Fields.InvalidMessage_encrypted_experian_pin(le.encrypted_experian_pin_Invalid),Fields.InvalidMessage_social_security_number(le.social_security_number_Invalid),Fields.InvalidMessage_date_of_birth(le.date_of_birth_Invalid),Fields.InvalidMessage_telephone(le.telephone_Invalid),Fields.InvalidMessage_gender(le.gender_Invalid),Fields.InvalidMessage_additional_name_count(le.additional_name_count_Invalid),Fields.InvalidMessage_previous_address_count(le.previous_address_count_Invalid),Fields.InvalidMessage_nametype(le.nametype_Invalid),Fields.InvalidMessage_orig_consumer_create_date(le.orig_consumer_create_date_Invalid),Fields.InvalidMessage_orig_fname(le.orig_fname_Invalid),Fields.InvalidMessage_orig_mname(le.orig_mname_Invalid),Fields.InvalidMessage_orig_lname(le.orig_lname_Invalid),Fields.InvalidMessage_orig_suffix(le.orig_suffix_Invalid),Fields.InvalidMessage_title(le.title_Invalid),Fields.InvalidMessage_fname(le.fname_Invalid),Fields.InvalidMessage_mname(le.mname_Invalid),Fields.InvalidMessage_lname(le.lname_Invalid),Fields.InvalidMessage_name_suffix(le.name_suffix_Invalid),Fields.InvalidMessage_name_score(le.name_score_Invalid),Fields.InvalidMessage_addressseq(le.addressseq_Invalid),Fields.InvalidMessage_orig_address_create_date(le.orig_address_create_date_Invalid),Fields.InvalidMessage_orig_address_update_date(le.orig_address_update_date_Invalid),Fields.InvalidMessage_orig_prim_range(le.orig_prim_range_Invalid),Fields.InvalidMessage_orig_predir(le.orig_predir_Invalid),Fields.InvalidMessage_orig_prim_name(le.orig_prim_name_Invalid),Fields.InvalidMessage_orig_addr_suffix(le.orig_addr_suffix_Invalid),Fields.InvalidMessage_orig_postdir(le.orig_postdir_Invalid),Fields.InvalidMessage_orig_unit_desig(le.orig_unit_desig_Invalid),Fields.InvalidMessage_orig_sec_range(le.orig_sec_range_Invalid),Fields.InvalidMessage_orig_city(le.orig_city_Invalid),Fields.InvalidMessage_orig_state(le.orig_state_Invalid),Fields.InvalidMessage_orig_zipcode(le.orig_zipcode_Invalid),Fields.InvalidMessage_orig_zipcode4(le.orig_zipcode4_Invalid),Fields.InvalidMessage_prim_range(le.prim_range_Invalid),Fields.InvalidMessage_predir(le.predir_Invalid),Fields.InvalidMessage_prim_name(le.prim_name_Invalid),Fields.InvalidMessage_addr_suffix(le.addr_suffix_Invalid),Fields.InvalidMessage_postdir(le.postdir_Invalid),Fields.InvalidMessage_unit_desig(le.unit_desig_Invalid),Fields.InvalidMessage_sec_range(le.sec_range_Invalid),Fields.InvalidMessage_p_city_name(le.p_city_name_Invalid),Fields.InvalidMessage_v_city_name(le.v_city_name_Invalid),Fields.InvalidMessage_st(le.st_Invalid),Fields.InvalidMessage_zip(le.zip_Invalid),Fields.InvalidMessage_zip4(le.zip4_Invalid),Fields.InvalidMessage_cart(le.cart_Invalid),Fields.InvalidMessage_cr_sort_sz(le.cr_sort_sz_Invalid),Fields.InvalidMessage_lot(le.lot_Invalid),Fields.InvalidMessage_lot_order(le.lot_order_Invalid),Fields.InvalidMessage_dbpc(le.dbpc_Invalid),Fields.InvalidMessage_chk_digit(le.chk_digit_Invalid),Fields.InvalidMessage_rec_type(le.rec_type_Invalid),Fields.InvalidMessage_county(le.county_Invalid),Fields.InvalidMessage_geo_lat(le.geo_lat_Invalid),Fields.InvalidMessage_geo_long(le.geo_long_Invalid),Fields.InvalidMessage_msa(le.msa_Invalid),Fields.InvalidMessage_geo_blk(le.geo_blk_Invalid),Fields.InvalidMessage_geo_match(le.geo_match_Invalid),Fields.InvalidMessage_err_stat(le.err_stat_Invalid),Fields.InvalidMessage_delete_flag(le.delete_flag_Invalid),Fields.InvalidMessage_delete_file_date(le.delete_file_date_Invalid),Fields.InvalidMessage_suppression_code(le.suppression_code_Invalid),Fields.InvalidMessage_deceased_ind(le.deceased_ind_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.seq_rec_id_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.did_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.did_score_field_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.current_rec_flag_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.current_experian_pin_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.date_first_seen_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.date_last_seen_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.date_vendor_first_reported_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.date_vendor_last_reported_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.encrypted_experian_pin_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.social_security_number_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.date_of_birth_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.telephone_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.gender_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.additional_name_count_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.previous_address_count_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.nametype_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_consumer_create_date_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_fname_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_mname_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_lname_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_suffix_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.title_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.fname_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.mname_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.lname_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.name_suffix_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.name_score_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.addressseq_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_address_create_date_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_address_update_date_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_prim_range_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_predir_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_prim_name_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_addr_suffix_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_postdir_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_unit_desig_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_sec_range_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_city_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_state_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_zipcode_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.orig_zipcode4_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.prim_range_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.predir_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.prim_name_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.addr_suffix_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.postdir_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.unit_desig_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.sec_range_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.p_city_name_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.v_city_name_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.st_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.zip_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.zip4_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.cart_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.cr_sort_sz_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.lot_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.lot_order_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.dbpc_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.chk_digit_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.rec_type_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.county_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.geo_lat_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.geo_long_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.msa_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.geo_blk_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.geo_match_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.err_stat_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.delete_flag_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.delete_file_date_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.suppression_code_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN')
          ,CHOOSE(le.deceased_ind_Invalid,'LEFTTRIM','ALLOW','LENGTHS','WORDS','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'seq_rec_id','did','did_score_field','current_rec_flag','current_experian_pin','date_first_seen','date_last_seen','date_vendor_first_reported','date_vendor_last_reported','encrypted_experian_pin','social_security_number','date_of_birth','telephone','gender','additional_name_count','previous_address_count','nametype','orig_consumer_create_date','orig_fname','orig_mname','orig_lname','orig_suffix','title','fname','mname','lname','name_suffix','name_score','addressseq','orig_address_create_date','orig_address_update_date','orig_prim_range','orig_predir','orig_prim_name','orig_addr_suffix','orig_postdir','orig_unit_desig','orig_sec_range','orig_city','orig_state','orig_zipcode','orig_zipcode4','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','delete_flag','delete_file_date','suppression_code','deceased_ind','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'seq_rec_id','did','did_score_field','current_rec_flag','current_experian_pin','date_first_seen','date_last_seen','date_vendor_first_reported','date_vendor_last_reported','encrypted_experian_pin','social_security_number','date_of_birth','telephone','gender','additional_name_count','previous_address_count','nametype','orig_consumer_create_date','orig_fname','orig_mname','orig_lname','orig_suffix','title','fname','mname','lname','name_suffix','name_score','addressseq','orig_address_create_date','orig_address_update_date','orig_prim_range','orig_predir','orig_prim_name','orig_addr_suffix','orig_postdir','orig_unit_desig','orig_sec_range','orig_city','orig_state','orig_zipcode','orig_zipcode4','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','delete_flag','delete_file_date','suppression_code','deceased_ind','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.seq_rec_id,(SALT311.StrType)le.did,(SALT311.StrType)le.did_score_field,(SALT311.StrType)le.current_rec_flag,(SALT311.StrType)le.current_experian_pin,(SALT311.StrType)le.date_first_seen,(SALT311.StrType)le.date_last_seen,(SALT311.StrType)le.date_vendor_first_reported,(SALT311.StrType)le.date_vendor_last_reported,(SALT311.StrType)le.encrypted_experian_pin,(SALT311.StrType)le.social_security_number,(SALT311.StrType)le.date_of_birth,(SALT311.StrType)le.telephone,(SALT311.StrType)le.gender,(SALT311.StrType)le.additional_name_count,(SALT311.StrType)le.previous_address_count,(SALT311.StrType)le.nametype,(SALT311.StrType)le.orig_consumer_create_date,(SALT311.StrType)le.orig_fname,(SALT311.StrType)le.orig_mname,(SALT311.StrType)le.orig_lname,(SALT311.StrType)le.orig_suffix,(SALT311.StrType)le.title,(SALT311.StrType)le.fname,(SALT311.StrType)le.mname,(SALT311.StrType)le.lname,(SALT311.StrType)le.name_suffix,(SALT311.StrType)le.name_score,(SALT311.StrType)le.addressseq,(SALT311.StrType)le.orig_address_create_date,(SALT311.StrType)le.orig_address_update_date,(SALT311.StrType)le.orig_prim_range,(SALT311.StrType)le.orig_predir,(SALT311.StrType)le.orig_prim_name,(SALT311.StrType)le.orig_addr_suffix,(SALT311.StrType)le.orig_postdir,(SALT311.StrType)le.orig_unit_desig,(SALT311.StrType)le.orig_sec_range,(SALT311.StrType)le.orig_city,(SALT311.StrType)le.orig_state,(SALT311.StrType)le.orig_zipcode,(SALT311.StrType)le.orig_zipcode4,(SALT311.StrType)le.prim_range,(SALT311.StrType)le.predir,(SALT311.StrType)le.prim_name,(SALT311.StrType)le.addr_suffix,(SALT311.StrType)le.postdir,(SALT311.StrType)le.unit_desig,(SALT311.StrType)le.sec_range,(SALT311.StrType)le.p_city_name,(SALT311.StrType)le.v_city_name,(SALT311.StrType)le.st,(SALT311.StrType)le.zip,(SALT311.StrType)le.zip4,(SALT311.StrType)le.cart,(SALT311.StrType)le.cr_sort_sz,(SALT311.StrType)le.lot,(SALT311.StrType)le.lot_order,(SALT311.StrType)le.dbpc,(SALT311.StrType)le.chk_digit,(SALT311.StrType)le.rec_type,(SALT311.StrType)le.county,(SALT311.StrType)le.geo_lat,(SALT311.StrType)le.geo_long,(SALT311.StrType)le.msa,(SALT311.StrType)le.geo_blk,(SALT311.StrType)le.geo_match,(SALT311.StrType)le.err_stat,(SALT311.StrType)le.delete_flag,(SALT311.StrType)le.delete_file_date,(SALT311.StrType)le.suppression_code,(SALT311.StrType)le.deceased_ind,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,72,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Layout_File) prevDS = DATASET([], Layout_File), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := toRuleDesc(c);
      SELF.ErrorMessage := toErrorMessage(c);
      SELF.rulecnt := CHOOSE(c
          ,le.seq_rec_id_LEFTTRIM_ErrorCount,le.seq_rec_id_ALLOW_ErrorCount,le.seq_rec_id_LENGTHS_ErrorCount,le.seq_rec_id_WORDS_ErrorCount
          ,le.did_LEFTTRIM_ErrorCount,le.did_ALLOW_ErrorCount,le.did_LENGTHS_ErrorCount,le.did_WORDS_ErrorCount
          ,le.did_score_field_LEFTTRIM_ErrorCount,le.did_score_field_ALLOW_ErrorCount,le.did_score_field_LENGTHS_ErrorCount,le.did_score_field_WORDS_ErrorCount
          ,le.current_rec_flag_LEFTTRIM_ErrorCount,le.current_rec_flag_ALLOW_ErrorCount,le.current_rec_flag_LENGTHS_ErrorCount,le.current_rec_flag_WORDS_ErrorCount
          ,le.current_experian_pin_LEFTTRIM_ErrorCount,le.current_experian_pin_ALLOW_ErrorCount,le.current_experian_pin_LENGTHS_ErrorCount,le.current_experian_pin_WORDS_ErrorCount
          ,le.date_first_seen_LEFTTRIM_ErrorCount,le.date_first_seen_ALLOW_ErrorCount,le.date_first_seen_LENGTHS_ErrorCount,le.date_first_seen_WORDS_ErrorCount
          ,le.date_last_seen_LEFTTRIM_ErrorCount,le.date_last_seen_ALLOW_ErrorCount,le.date_last_seen_LENGTHS_ErrorCount,le.date_last_seen_WORDS_ErrorCount
          ,le.date_vendor_first_reported_LEFTTRIM_ErrorCount,le.date_vendor_first_reported_ALLOW_ErrorCount,le.date_vendor_first_reported_LENGTHS_ErrorCount,le.date_vendor_first_reported_WORDS_ErrorCount
          ,le.date_vendor_last_reported_LEFTTRIM_ErrorCount,le.date_vendor_last_reported_ALLOW_ErrorCount,le.date_vendor_last_reported_LENGTHS_ErrorCount,le.date_vendor_last_reported_WORDS_ErrorCount
          ,le.encrypted_experian_pin_LEFTTRIM_ErrorCount,le.encrypted_experian_pin_ALLOW_ErrorCount,le.encrypted_experian_pin_LENGTHS_ErrorCount,le.encrypted_experian_pin_WORDS_ErrorCount
          ,le.social_security_number_LEFTTRIM_ErrorCount,le.social_security_number_ALLOW_ErrorCount,le.social_security_number_LENGTHS_ErrorCount,le.social_security_number_WORDS_ErrorCount
          ,le.date_of_birth_LEFTTRIM_ErrorCount,le.date_of_birth_ALLOW_ErrorCount,le.date_of_birth_LENGTHS_ErrorCount,le.date_of_birth_WORDS_ErrorCount
          ,le.telephone_LEFTTRIM_ErrorCount,le.telephone_ALLOW_ErrorCount,le.telephone_LENGTHS_ErrorCount,le.telephone_WORDS_ErrorCount
          ,le.gender_LEFTTRIM_ErrorCount,le.gender_ALLOW_ErrorCount,le.gender_LENGTHS_ErrorCount,le.gender_WORDS_ErrorCount
          ,le.additional_name_count_LEFTTRIM_ErrorCount,le.additional_name_count_ALLOW_ErrorCount,le.additional_name_count_LENGTHS_ErrorCount,le.additional_name_count_WORDS_ErrorCount
          ,le.previous_address_count_LEFTTRIM_ErrorCount,le.previous_address_count_ALLOW_ErrorCount,le.previous_address_count_LENGTHS_ErrorCount,le.previous_address_count_WORDS_ErrorCount
          ,le.nametype_LEFTTRIM_ErrorCount,le.nametype_ALLOW_ErrorCount,le.nametype_LENGTHS_ErrorCount,le.nametype_WORDS_ErrorCount
          ,le.orig_consumer_create_date_LEFTTRIM_ErrorCount,le.orig_consumer_create_date_ALLOW_ErrorCount,le.orig_consumer_create_date_LENGTHS_ErrorCount,le.orig_consumer_create_date_WORDS_ErrorCount
          ,le.orig_fname_LEFTTRIM_ErrorCount,le.orig_fname_ALLOW_ErrorCount,le.orig_fname_LENGTHS_ErrorCount,le.orig_fname_WORDS_ErrorCount
          ,le.orig_mname_LEFTTRIM_ErrorCount,le.orig_mname_ALLOW_ErrorCount,le.orig_mname_LENGTHS_ErrorCount,le.orig_mname_WORDS_ErrorCount
          ,le.orig_lname_LEFTTRIM_ErrorCount,le.orig_lname_ALLOW_ErrorCount,le.orig_lname_LENGTHS_ErrorCount,le.orig_lname_WORDS_ErrorCount
          ,le.orig_suffix_LEFTTRIM_ErrorCount,le.orig_suffix_ALLOW_ErrorCount,le.orig_suffix_LENGTHS_ErrorCount,le.orig_suffix_WORDS_ErrorCount
          ,le.title_LEFTTRIM_ErrorCount,le.title_ALLOW_ErrorCount,le.title_LENGTHS_ErrorCount,le.title_WORDS_ErrorCount
          ,le.fname_LEFTTRIM_ErrorCount,le.fname_ALLOW_ErrorCount,le.fname_LENGTHS_ErrorCount,le.fname_WORDS_ErrorCount
          ,le.mname_LEFTTRIM_ErrorCount,le.mname_ALLOW_ErrorCount,le.mname_LENGTHS_ErrorCount,le.mname_WORDS_ErrorCount
          ,le.lname_LEFTTRIM_ErrorCount,le.lname_ALLOW_ErrorCount,le.lname_LENGTHS_ErrorCount,le.lname_WORDS_ErrorCount
          ,le.name_suffix_LEFTTRIM_ErrorCount,le.name_suffix_ALLOW_ErrorCount,le.name_suffix_LENGTHS_ErrorCount,le.name_suffix_WORDS_ErrorCount
          ,le.name_score_LEFTTRIM_ErrorCount,le.name_score_ALLOW_ErrorCount,le.name_score_LENGTHS_ErrorCount,le.name_score_WORDS_ErrorCount
          ,le.addressseq_LEFTTRIM_ErrorCount,le.addressseq_ALLOW_ErrorCount,le.addressseq_LENGTHS_ErrorCount,le.addressseq_WORDS_ErrorCount
          ,le.orig_address_create_date_LEFTTRIM_ErrorCount,le.orig_address_create_date_ALLOW_ErrorCount,le.orig_address_create_date_LENGTHS_ErrorCount,le.orig_address_create_date_WORDS_ErrorCount
          ,le.orig_address_update_date_LEFTTRIM_ErrorCount,le.orig_address_update_date_ALLOW_ErrorCount,le.orig_address_update_date_LENGTHS_ErrorCount,le.orig_address_update_date_WORDS_ErrorCount
          ,le.orig_prim_range_LEFTTRIM_ErrorCount,le.orig_prim_range_ALLOW_ErrorCount,le.orig_prim_range_LENGTHS_ErrorCount,le.orig_prim_range_WORDS_ErrorCount
          ,le.orig_predir_LEFTTRIM_ErrorCount,le.orig_predir_ALLOW_ErrorCount,le.orig_predir_LENGTHS_ErrorCount,le.orig_predir_WORDS_ErrorCount
          ,le.orig_prim_name_LEFTTRIM_ErrorCount,le.orig_prim_name_ALLOW_ErrorCount,le.orig_prim_name_LENGTHS_ErrorCount,le.orig_prim_name_WORDS_ErrorCount
          ,le.orig_addr_suffix_LEFTTRIM_ErrorCount,le.orig_addr_suffix_ALLOW_ErrorCount,le.orig_addr_suffix_LENGTHS_ErrorCount,le.orig_addr_suffix_WORDS_ErrorCount
          ,le.orig_postdir_LEFTTRIM_ErrorCount,le.orig_postdir_ALLOW_ErrorCount,le.orig_postdir_LENGTHS_ErrorCount,le.orig_postdir_WORDS_ErrorCount
          ,le.orig_unit_desig_LEFTTRIM_ErrorCount,le.orig_unit_desig_ALLOW_ErrorCount,le.orig_unit_desig_LENGTHS_ErrorCount,le.orig_unit_desig_WORDS_ErrorCount
          ,le.orig_sec_range_LEFTTRIM_ErrorCount,le.orig_sec_range_ALLOW_ErrorCount,le.orig_sec_range_LENGTHS_ErrorCount,le.orig_sec_range_WORDS_ErrorCount
          ,le.orig_city_LEFTTRIM_ErrorCount,le.orig_city_ALLOW_ErrorCount,le.orig_city_LENGTHS_ErrorCount,le.orig_city_WORDS_ErrorCount
          ,le.orig_state_LEFTTRIM_ErrorCount,le.orig_state_ALLOW_ErrorCount,le.orig_state_LENGTHS_ErrorCount,le.orig_state_WORDS_ErrorCount
          ,le.orig_zipcode_LEFTTRIM_ErrorCount,le.orig_zipcode_ALLOW_ErrorCount,le.orig_zipcode_LENGTHS_ErrorCount,le.orig_zipcode_WORDS_ErrorCount
          ,le.orig_zipcode4_LEFTTRIM_ErrorCount,le.orig_zipcode4_ALLOW_ErrorCount,le.orig_zipcode4_LENGTHS_ErrorCount,le.orig_zipcode4_WORDS_ErrorCount
          ,le.prim_range_LEFTTRIM_ErrorCount,le.prim_range_ALLOW_ErrorCount,le.prim_range_LENGTHS_ErrorCount,le.prim_range_WORDS_ErrorCount
          ,le.predir_LEFTTRIM_ErrorCount,le.predir_ALLOW_ErrorCount,le.predir_LENGTHS_ErrorCount,le.predir_WORDS_ErrorCount
          ,le.prim_name_LEFTTRIM_ErrorCount,le.prim_name_ALLOW_ErrorCount,le.prim_name_LENGTHS_ErrorCount,le.prim_name_WORDS_ErrorCount
          ,le.addr_suffix_LEFTTRIM_ErrorCount,le.addr_suffix_ALLOW_ErrorCount,le.addr_suffix_LENGTHS_ErrorCount,le.addr_suffix_WORDS_ErrorCount
          ,le.postdir_LEFTTRIM_ErrorCount,le.postdir_ALLOW_ErrorCount,le.postdir_LENGTHS_ErrorCount,le.postdir_WORDS_ErrorCount
          ,le.unit_desig_LEFTTRIM_ErrorCount,le.unit_desig_ALLOW_ErrorCount,le.unit_desig_LENGTHS_ErrorCount,le.unit_desig_WORDS_ErrorCount
          ,le.sec_range_LEFTTRIM_ErrorCount,le.sec_range_ALLOW_ErrorCount,le.sec_range_LENGTHS_ErrorCount,le.sec_range_WORDS_ErrorCount
          ,le.p_city_name_LEFTTRIM_ErrorCount,le.p_city_name_ALLOW_ErrorCount,le.p_city_name_LENGTHS_ErrorCount,le.p_city_name_WORDS_ErrorCount
          ,le.v_city_name_LEFTTRIM_ErrorCount,le.v_city_name_ALLOW_ErrorCount,le.v_city_name_LENGTHS_ErrorCount,le.v_city_name_WORDS_ErrorCount
          ,le.st_LEFTTRIM_ErrorCount,le.st_ALLOW_ErrorCount,le.st_LENGTHS_ErrorCount,le.st_WORDS_ErrorCount
          ,le.zip_LEFTTRIM_ErrorCount,le.zip_ALLOW_ErrorCount,le.zip_LENGTHS_ErrorCount,le.zip_WORDS_ErrorCount
          ,le.zip4_LEFTTRIM_ErrorCount,le.zip4_ALLOW_ErrorCount,le.zip4_LENGTHS_ErrorCount,le.zip4_WORDS_ErrorCount
          ,le.cart_LEFTTRIM_ErrorCount,le.cart_ALLOW_ErrorCount,le.cart_LENGTHS_ErrorCount,le.cart_WORDS_ErrorCount
          ,le.cr_sort_sz_LEFTTRIM_ErrorCount,le.cr_sort_sz_ALLOW_ErrorCount,le.cr_sort_sz_LENGTHS_ErrorCount,le.cr_sort_sz_WORDS_ErrorCount
          ,le.lot_LEFTTRIM_ErrorCount,le.lot_ALLOW_ErrorCount,le.lot_LENGTHS_ErrorCount,le.lot_WORDS_ErrorCount
          ,le.lot_order_LEFTTRIM_ErrorCount,le.lot_order_ALLOW_ErrorCount,le.lot_order_LENGTHS_ErrorCount,le.lot_order_WORDS_ErrorCount
          ,le.dbpc_LEFTTRIM_ErrorCount,le.dbpc_ALLOW_ErrorCount,le.dbpc_LENGTHS_ErrorCount,le.dbpc_WORDS_ErrorCount
          ,le.chk_digit_LEFTTRIM_ErrorCount,le.chk_digit_ALLOW_ErrorCount,le.chk_digit_LENGTHS_ErrorCount,le.chk_digit_WORDS_ErrorCount
          ,le.rec_type_LEFTTRIM_ErrorCount,le.rec_type_ALLOW_ErrorCount,le.rec_type_LENGTHS_ErrorCount,le.rec_type_WORDS_ErrorCount
          ,le.county_LEFTTRIM_ErrorCount,le.county_ALLOW_ErrorCount,le.county_LENGTHS_ErrorCount,le.county_WORDS_ErrorCount
          ,le.geo_lat_LEFTTRIM_ErrorCount,le.geo_lat_ALLOW_ErrorCount,le.geo_lat_LENGTHS_ErrorCount,le.geo_lat_WORDS_ErrorCount
          ,le.geo_long_LEFTTRIM_ErrorCount,le.geo_long_ALLOW_ErrorCount,le.geo_long_LENGTHS_ErrorCount,le.geo_long_WORDS_ErrorCount
          ,le.msa_LEFTTRIM_ErrorCount,le.msa_ALLOW_ErrorCount,le.msa_LENGTHS_ErrorCount,le.msa_WORDS_ErrorCount
          ,le.geo_blk_LEFTTRIM_ErrorCount,le.geo_blk_ALLOW_ErrorCount,le.geo_blk_LENGTHS_ErrorCount,le.geo_blk_WORDS_ErrorCount
          ,le.geo_match_LEFTTRIM_ErrorCount,le.geo_match_ALLOW_ErrorCount,le.geo_match_LENGTHS_ErrorCount,le.geo_match_WORDS_ErrorCount
          ,le.err_stat_LEFTTRIM_ErrorCount,le.err_stat_ALLOW_ErrorCount,le.err_stat_LENGTHS_ErrorCount,le.err_stat_WORDS_ErrorCount
          ,le.delete_flag_LEFTTRIM_ErrorCount,le.delete_flag_ALLOW_ErrorCount,le.delete_flag_LENGTHS_ErrorCount,le.delete_flag_WORDS_ErrorCount
          ,le.delete_file_date_LEFTTRIM_ErrorCount,le.delete_file_date_ALLOW_ErrorCount,le.delete_file_date_LENGTHS_ErrorCount,le.delete_file_date_WORDS_ErrorCount
          ,le.suppression_code_LEFTTRIM_ErrorCount,le.suppression_code_ALLOW_ErrorCount,le.suppression_code_LENGTHS_ErrorCount,le.suppression_code_WORDS_ErrorCount
          ,le.deceased_ind_LEFTTRIM_ErrorCount,le.deceased_ind_ALLOW_ErrorCount,le.deceased_ind_LENGTHS_ErrorCount,le.deceased_ind_WORDS_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount
          ,le.AnyRule_WithEditsCount
          ,le.Rules_WithEdits,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.seq_rec_id_LEFTTRIM_ErrorCount,le.seq_rec_id_ALLOW_ErrorCount,le.seq_rec_id_LENGTHS_ErrorCount,le.seq_rec_id_WORDS_ErrorCount
          ,le.did_LEFTTRIM_ErrorCount,le.did_ALLOW_ErrorCount,le.did_LENGTHS_ErrorCount,le.did_WORDS_ErrorCount
          ,le.did_score_field_LEFTTRIM_ErrorCount,le.did_score_field_ALLOW_ErrorCount,le.did_score_field_LENGTHS_ErrorCount,le.did_score_field_WORDS_ErrorCount
          ,le.current_rec_flag_LEFTTRIM_ErrorCount,le.current_rec_flag_ALLOW_ErrorCount,le.current_rec_flag_LENGTHS_ErrorCount,le.current_rec_flag_WORDS_ErrorCount
          ,le.current_experian_pin_LEFTTRIM_ErrorCount,le.current_experian_pin_ALLOW_ErrorCount,le.current_experian_pin_LENGTHS_ErrorCount,le.current_experian_pin_WORDS_ErrorCount
          ,le.date_first_seen_LEFTTRIM_ErrorCount,le.date_first_seen_ALLOW_ErrorCount,le.date_first_seen_LENGTHS_ErrorCount,le.date_first_seen_WORDS_ErrorCount
          ,le.date_last_seen_LEFTTRIM_ErrorCount,le.date_last_seen_ALLOW_ErrorCount,le.date_last_seen_LENGTHS_ErrorCount,le.date_last_seen_WORDS_ErrorCount
          ,le.date_vendor_first_reported_LEFTTRIM_ErrorCount,le.date_vendor_first_reported_ALLOW_ErrorCount,le.date_vendor_first_reported_LENGTHS_ErrorCount,le.date_vendor_first_reported_WORDS_ErrorCount
          ,le.date_vendor_last_reported_LEFTTRIM_ErrorCount,le.date_vendor_last_reported_ALLOW_ErrorCount,le.date_vendor_last_reported_LENGTHS_ErrorCount,le.date_vendor_last_reported_WORDS_ErrorCount
          ,le.encrypted_experian_pin_LEFTTRIM_ErrorCount,le.encrypted_experian_pin_ALLOW_ErrorCount,le.encrypted_experian_pin_LENGTHS_ErrorCount,le.encrypted_experian_pin_WORDS_ErrorCount
          ,le.social_security_number_LEFTTRIM_ErrorCount,le.social_security_number_ALLOW_ErrorCount,le.social_security_number_LENGTHS_ErrorCount,le.social_security_number_WORDS_ErrorCount
          ,le.date_of_birth_LEFTTRIM_ErrorCount,le.date_of_birth_ALLOW_ErrorCount,le.date_of_birth_LENGTHS_ErrorCount,le.date_of_birth_WORDS_ErrorCount
          ,le.telephone_LEFTTRIM_ErrorCount,le.telephone_ALLOW_ErrorCount,le.telephone_LENGTHS_ErrorCount,le.telephone_WORDS_ErrorCount
          ,le.gender_LEFTTRIM_ErrorCount,le.gender_ALLOW_ErrorCount,le.gender_LENGTHS_ErrorCount,le.gender_WORDS_ErrorCount
          ,le.additional_name_count_LEFTTRIM_ErrorCount,le.additional_name_count_ALLOW_ErrorCount,le.additional_name_count_LENGTHS_ErrorCount,le.additional_name_count_WORDS_ErrorCount
          ,le.previous_address_count_LEFTTRIM_ErrorCount,le.previous_address_count_ALLOW_ErrorCount,le.previous_address_count_LENGTHS_ErrorCount,le.previous_address_count_WORDS_ErrorCount
          ,le.nametype_LEFTTRIM_ErrorCount,le.nametype_ALLOW_ErrorCount,le.nametype_LENGTHS_ErrorCount,le.nametype_WORDS_ErrorCount
          ,le.orig_consumer_create_date_LEFTTRIM_ErrorCount,le.orig_consumer_create_date_ALLOW_ErrorCount,le.orig_consumer_create_date_LENGTHS_ErrorCount,le.orig_consumer_create_date_WORDS_ErrorCount
          ,le.orig_fname_LEFTTRIM_ErrorCount,le.orig_fname_ALLOW_ErrorCount,le.orig_fname_LENGTHS_ErrorCount,le.orig_fname_WORDS_ErrorCount
          ,le.orig_mname_LEFTTRIM_ErrorCount,le.orig_mname_ALLOW_ErrorCount,le.orig_mname_LENGTHS_ErrorCount,le.orig_mname_WORDS_ErrorCount
          ,le.orig_lname_LEFTTRIM_ErrorCount,le.orig_lname_ALLOW_ErrorCount,le.orig_lname_LENGTHS_ErrorCount,le.orig_lname_WORDS_ErrorCount
          ,le.orig_suffix_LEFTTRIM_ErrorCount,le.orig_suffix_ALLOW_ErrorCount,le.orig_suffix_LENGTHS_ErrorCount,le.orig_suffix_WORDS_ErrorCount
          ,le.title_LEFTTRIM_ErrorCount,le.title_ALLOW_ErrorCount,le.title_LENGTHS_ErrorCount,le.title_WORDS_ErrorCount
          ,le.fname_LEFTTRIM_ErrorCount,le.fname_ALLOW_ErrorCount,le.fname_LENGTHS_ErrorCount,le.fname_WORDS_ErrorCount
          ,le.mname_LEFTTRIM_ErrorCount,le.mname_ALLOW_ErrorCount,le.mname_LENGTHS_ErrorCount,le.mname_WORDS_ErrorCount
          ,le.lname_LEFTTRIM_ErrorCount,le.lname_ALLOW_ErrorCount,le.lname_LENGTHS_ErrorCount,le.lname_WORDS_ErrorCount
          ,le.name_suffix_LEFTTRIM_ErrorCount,le.name_suffix_ALLOW_ErrorCount,le.name_suffix_LENGTHS_ErrorCount,le.name_suffix_WORDS_ErrorCount
          ,le.name_score_LEFTTRIM_ErrorCount,le.name_score_ALLOW_ErrorCount,le.name_score_LENGTHS_ErrorCount,le.name_score_WORDS_ErrorCount
          ,le.addressseq_LEFTTRIM_ErrorCount,le.addressseq_ALLOW_ErrorCount,le.addressseq_LENGTHS_ErrorCount,le.addressseq_WORDS_ErrorCount
          ,le.orig_address_create_date_LEFTTRIM_ErrorCount,le.orig_address_create_date_ALLOW_ErrorCount,le.orig_address_create_date_LENGTHS_ErrorCount,le.orig_address_create_date_WORDS_ErrorCount
          ,le.orig_address_update_date_LEFTTRIM_ErrorCount,le.orig_address_update_date_ALLOW_ErrorCount,le.orig_address_update_date_LENGTHS_ErrorCount,le.orig_address_update_date_WORDS_ErrorCount
          ,le.orig_prim_range_LEFTTRIM_ErrorCount,le.orig_prim_range_ALLOW_ErrorCount,le.orig_prim_range_LENGTHS_ErrorCount,le.orig_prim_range_WORDS_ErrorCount
          ,le.orig_predir_LEFTTRIM_ErrorCount,le.orig_predir_ALLOW_ErrorCount,le.orig_predir_LENGTHS_ErrorCount,le.orig_predir_WORDS_ErrorCount
          ,le.orig_prim_name_LEFTTRIM_ErrorCount,le.orig_prim_name_ALLOW_ErrorCount,le.orig_prim_name_LENGTHS_ErrorCount,le.orig_prim_name_WORDS_ErrorCount
          ,le.orig_addr_suffix_LEFTTRIM_ErrorCount,le.orig_addr_suffix_ALLOW_ErrorCount,le.orig_addr_suffix_LENGTHS_ErrorCount,le.orig_addr_suffix_WORDS_ErrorCount
          ,le.orig_postdir_LEFTTRIM_ErrorCount,le.orig_postdir_ALLOW_ErrorCount,le.orig_postdir_LENGTHS_ErrorCount,le.orig_postdir_WORDS_ErrorCount
          ,le.orig_unit_desig_LEFTTRIM_ErrorCount,le.orig_unit_desig_ALLOW_ErrorCount,le.orig_unit_desig_LENGTHS_ErrorCount,le.orig_unit_desig_WORDS_ErrorCount
          ,le.orig_sec_range_LEFTTRIM_ErrorCount,le.orig_sec_range_ALLOW_ErrorCount,le.orig_sec_range_LENGTHS_ErrorCount,le.orig_sec_range_WORDS_ErrorCount
          ,le.orig_city_LEFTTRIM_ErrorCount,le.orig_city_ALLOW_ErrorCount,le.orig_city_LENGTHS_ErrorCount,le.orig_city_WORDS_ErrorCount
          ,le.orig_state_LEFTTRIM_ErrorCount,le.orig_state_ALLOW_ErrorCount,le.orig_state_LENGTHS_ErrorCount,le.orig_state_WORDS_ErrorCount
          ,le.orig_zipcode_LEFTTRIM_ErrorCount,le.orig_zipcode_ALLOW_ErrorCount,le.orig_zipcode_LENGTHS_ErrorCount,le.orig_zipcode_WORDS_ErrorCount
          ,le.orig_zipcode4_LEFTTRIM_ErrorCount,le.orig_zipcode4_ALLOW_ErrorCount,le.orig_zipcode4_LENGTHS_ErrorCount,le.orig_zipcode4_WORDS_ErrorCount
          ,le.prim_range_LEFTTRIM_ErrorCount,le.prim_range_ALLOW_ErrorCount,le.prim_range_LENGTHS_ErrorCount,le.prim_range_WORDS_ErrorCount
          ,le.predir_LEFTTRIM_ErrorCount,le.predir_ALLOW_ErrorCount,le.predir_LENGTHS_ErrorCount,le.predir_WORDS_ErrorCount
          ,le.prim_name_LEFTTRIM_ErrorCount,le.prim_name_ALLOW_ErrorCount,le.prim_name_LENGTHS_ErrorCount,le.prim_name_WORDS_ErrorCount
          ,le.addr_suffix_LEFTTRIM_ErrorCount,le.addr_suffix_ALLOW_ErrorCount,le.addr_suffix_LENGTHS_ErrorCount,le.addr_suffix_WORDS_ErrorCount
          ,le.postdir_LEFTTRIM_ErrorCount,le.postdir_ALLOW_ErrorCount,le.postdir_LENGTHS_ErrorCount,le.postdir_WORDS_ErrorCount
          ,le.unit_desig_LEFTTRIM_ErrorCount,le.unit_desig_ALLOW_ErrorCount,le.unit_desig_LENGTHS_ErrorCount,le.unit_desig_WORDS_ErrorCount
          ,le.sec_range_LEFTTRIM_ErrorCount,le.sec_range_ALLOW_ErrorCount,le.sec_range_LENGTHS_ErrorCount,le.sec_range_WORDS_ErrorCount
          ,le.p_city_name_LEFTTRIM_ErrorCount,le.p_city_name_ALLOW_ErrorCount,le.p_city_name_LENGTHS_ErrorCount,le.p_city_name_WORDS_ErrorCount
          ,le.v_city_name_LEFTTRIM_ErrorCount,le.v_city_name_ALLOW_ErrorCount,le.v_city_name_LENGTHS_ErrorCount,le.v_city_name_WORDS_ErrorCount
          ,le.st_LEFTTRIM_ErrorCount,le.st_ALLOW_ErrorCount,le.st_LENGTHS_ErrorCount,le.st_WORDS_ErrorCount
          ,le.zip_LEFTTRIM_ErrorCount,le.zip_ALLOW_ErrorCount,le.zip_LENGTHS_ErrorCount,le.zip_WORDS_ErrorCount
          ,le.zip4_LEFTTRIM_ErrorCount,le.zip4_ALLOW_ErrorCount,le.zip4_LENGTHS_ErrorCount,le.zip4_WORDS_ErrorCount
          ,le.cart_LEFTTRIM_ErrorCount,le.cart_ALLOW_ErrorCount,le.cart_LENGTHS_ErrorCount,le.cart_WORDS_ErrorCount
          ,le.cr_sort_sz_LEFTTRIM_ErrorCount,le.cr_sort_sz_ALLOW_ErrorCount,le.cr_sort_sz_LENGTHS_ErrorCount,le.cr_sort_sz_WORDS_ErrorCount
          ,le.lot_LEFTTRIM_ErrorCount,le.lot_ALLOW_ErrorCount,le.lot_LENGTHS_ErrorCount,le.lot_WORDS_ErrorCount
          ,le.lot_order_LEFTTRIM_ErrorCount,le.lot_order_ALLOW_ErrorCount,le.lot_order_LENGTHS_ErrorCount,le.lot_order_WORDS_ErrorCount
          ,le.dbpc_LEFTTRIM_ErrorCount,le.dbpc_ALLOW_ErrorCount,le.dbpc_LENGTHS_ErrorCount,le.dbpc_WORDS_ErrorCount
          ,le.chk_digit_LEFTTRIM_ErrorCount,le.chk_digit_ALLOW_ErrorCount,le.chk_digit_LENGTHS_ErrorCount,le.chk_digit_WORDS_ErrorCount
          ,le.rec_type_LEFTTRIM_ErrorCount,le.rec_type_ALLOW_ErrorCount,le.rec_type_LENGTHS_ErrorCount,le.rec_type_WORDS_ErrorCount
          ,le.county_LEFTTRIM_ErrorCount,le.county_ALLOW_ErrorCount,le.county_LENGTHS_ErrorCount,le.county_WORDS_ErrorCount
          ,le.geo_lat_LEFTTRIM_ErrorCount,le.geo_lat_ALLOW_ErrorCount,le.geo_lat_LENGTHS_ErrorCount,le.geo_lat_WORDS_ErrorCount
          ,le.geo_long_LEFTTRIM_ErrorCount,le.geo_long_ALLOW_ErrorCount,le.geo_long_LENGTHS_ErrorCount,le.geo_long_WORDS_ErrorCount
          ,le.msa_LEFTTRIM_ErrorCount,le.msa_ALLOW_ErrorCount,le.msa_LENGTHS_ErrorCount,le.msa_WORDS_ErrorCount
          ,le.geo_blk_LEFTTRIM_ErrorCount,le.geo_blk_ALLOW_ErrorCount,le.geo_blk_LENGTHS_ErrorCount,le.geo_blk_WORDS_ErrorCount
          ,le.geo_match_LEFTTRIM_ErrorCount,le.geo_match_ALLOW_ErrorCount,le.geo_match_LENGTHS_ErrorCount,le.geo_match_WORDS_ErrorCount
          ,le.err_stat_LEFTTRIM_ErrorCount,le.err_stat_ALLOW_ErrorCount,le.err_stat_LENGTHS_ErrorCount,le.err_stat_WORDS_ErrorCount
          ,le.delete_flag_LEFTTRIM_ErrorCount,le.delete_flag_ALLOW_ErrorCount,le.delete_flag_LENGTHS_ErrorCount,le.delete_flag_WORDS_ErrorCount
          ,le.delete_file_date_LEFTTRIM_ErrorCount,le.delete_file_date_ALLOW_ErrorCount,le.delete_file_date_LENGTHS_ErrorCount,le.delete_file_date_WORDS_ErrorCount
          ,le.suppression_code_LEFTTRIM_ErrorCount,le.suppression_code_ALLOW_ErrorCount,le.suppression_code_LENGTHS_ErrorCount,le.suppression_code_WORDS_ErrorCount
          ,le.deceased_ind_LEFTTRIM_ErrorCount,le.deceased_ind_ALLOW_ErrorCount,le.deceased_ind_LENGTHS_ErrorCount,le.deceased_ind_WORDS_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
          ,IF(NumFieldsWithRules = 0, 0, le.FieldsChecked_WithErrors/NumFieldsWithRules * 100)
          ,IF(NumFieldsWithRules = 0, 0, le.FieldsChecked_NoErrors/NumFieldsWithRules * 100)
          ,IF(NumRules = 0, 0, le.Rules_WithErrors/NumRules * 100)
          ,IF(NumRules = 0, 0, le.Rules_NoErrors/NumRules * 100)
          ,0
          ,IF(SELF.recordstotal = 0, 0, le.AnyRule_WithErrorsCount/SELF.recordstotal * 100)
          ,IF(SELF.recordstotal = 0, 0, (SELF.recordstotal - le.AnyRule_WithErrorsCount)/SELF.recordstotal * 100)
          ,IF(SELF.recordstotal = 0, 0, le.AnyRule_WithEditsCount/SELF.recordstotal * 100)
          ,IF(NumRulesWithPossibleEdits = 0, 0, le.Rules_WithEdits/NumRulesWithPossibleEdits * 100),0));
    END;
    SummaryInfo := NORMALIZE(SummaryStats,NumRules + 9,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT311.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT311.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    FieldErrorStats := IF(examples>0,j,SummaryInfo);

    // field population stats
    mod_hygiene := hygiene(PROJECT(h, Layout_File));
    hygiene_summaryStats := mod_hygiene.Summary('');
    getFieldTypeText(infield) := FUNCTIONMACRO
      isNumField := (STRING)((TYPEOF(infield))'') = '0';
      RETURN IF(isNumField, 'nonzero', 'nonblank');
    ENDMACRO;
    SALT311.ScrubsOrbitLayout xNormHygieneStats(hygiene_summaryStats le, UNSIGNED c, STRING suffix) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'seq_rec_id:' + getFieldTypeText(h.seq_rec_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'did:' + getFieldTypeText(h.did) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'did_score_field:' + getFieldTypeText(h.did_score_field) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'current_rec_flag:' + getFieldTypeText(h.current_rec_flag) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'current_experian_pin:' + getFieldTypeText(h.current_experian_pin) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_first_seen:' + getFieldTypeText(h.date_first_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_last_seen:' + getFieldTypeText(h.date_last_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_vendor_first_reported:' + getFieldTypeText(h.date_vendor_first_reported) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_vendor_last_reported:' + getFieldTypeText(h.date_vendor_last_reported) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'encrypted_experian_pin:' + getFieldTypeText(h.encrypted_experian_pin) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'social_security_number:' + getFieldTypeText(h.social_security_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_of_birth:' + getFieldTypeText(h.date_of_birth) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'telephone:' + getFieldTypeText(h.telephone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'gender:' + getFieldTypeText(h.gender) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'additional_name_count:' + getFieldTypeText(h.additional_name_count) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'previous_address_count:' + getFieldTypeText(h.previous_address_count) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'nametype:' + getFieldTypeText(h.nametype) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_consumer_create_date:' + getFieldTypeText(h.orig_consumer_create_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_fname:' + getFieldTypeText(h.orig_fname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_mname:' + getFieldTypeText(h.orig_mname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_lname:' + getFieldTypeText(h.orig_lname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_suffix:' + getFieldTypeText(h.orig_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'title:' + getFieldTypeText(h.title) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fname:' + getFieldTypeText(h.fname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mname:' + getFieldTypeText(h.mname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lname:' + getFieldTypeText(h.lname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'name_suffix:' + getFieldTypeText(h.name_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'name_score:' + getFieldTypeText(h.name_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'addressseq:' + getFieldTypeText(h.addressseq) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_address_create_date:' + getFieldTypeText(h.orig_address_create_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_address_update_date:' + getFieldTypeText(h.orig_address_update_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_prim_range:' + getFieldTypeText(h.orig_prim_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_predir:' + getFieldTypeText(h.orig_predir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_prim_name:' + getFieldTypeText(h.orig_prim_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_addr_suffix:' + getFieldTypeText(h.orig_addr_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_postdir:' + getFieldTypeText(h.orig_postdir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_unit_desig:' + getFieldTypeText(h.orig_unit_desig) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_sec_range:' + getFieldTypeText(h.orig_sec_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_city:' + getFieldTypeText(h.orig_city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_state:' + getFieldTypeText(h.orig_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_zipcode:' + getFieldTypeText(h.orig_zipcode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_zipcode4:' + getFieldTypeText(h.orig_zipcode4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prim_range:' + getFieldTypeText(h.prim_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'predir:' + getFieldTypeText(h.predir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prim_name:' + getFieldTypeText(h.prim_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'addr_suffix:' + getFieldTypeText(h.addr_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'postdir:' + getFieldTypeText(h.postdir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'unit_desig:' + getFieldTypeText(h.unit_desig) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sec_range:' + getFieldTypeText(h.sec_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'p_city_name:' + getFieldTypeText(h.p_city_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v_city_name:' + getFieldTypeText(h.v_city_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'st:' + getFieldTypeText(h.st) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip:' + getFieldTypeText(h.zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip4:' + getFieldTypeText(h.zip4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cart:' + getFieldTypeText(h.cart) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cr_sort_sz:' + getFieldTypeText(h.cr_sort_sz) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lot:' + getFieldTypeText(h.lot) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lot_order:' + getFieldTypeText(h.lot_order) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dbpc:' + getFieldTypeText(h.dbpc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'chk_digit:' + getFieldTypeText(h.chk_digit) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rec_type:' + getFieldTypeText(h.rec_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'county:' + getFieldTypeText(h.county) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_lat:' + getFieldTypeText(h.geo_lat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_long:' + getFieldTypeText(h.geo_long) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'msa:' + getFieldTypeText(h.msa) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_blk:' + getFieldTypeText(h.geo_blk) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_match:' + getFieldTypeText(h.geo_match) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'err_stat:' + getFieldTypeText(h.err_stat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'delete_flag:' + getFieldTypeText(h.delete_flag) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'delete_file_date:' + getFieldTypeText(h.delete_file_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'suppression_code:' + getFieldTypeText(h.suppression_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'deceased_ind:' + getFieldTypeText(h.deceased_ind) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_seq_rec_id_cnt
          ,le.populated_did_cnt
          ,le.populated_did_score_field_cnt
          ,le.populated_current_rec_flag_cnt
          ,le.populated_current_experian_pin_cnt
          ,le.populated_date_first_seen_cnt
          ,le.populated_date_last_seen_cnt
          ,le.populated_date_vendor_first_reported_cnt
          ,le.populated_date_vendor_last_reported_cnt
          ,le.populated_encrypted_experian_pin_cnt
          ,le.populated_social_security_number_cnt
          ,le.populated_date_of_birth_cnt
          ,le.populated_telephone_cnt
          ,le.populated_gender_cnt
          ,le.populated_additional_name_count_cnt
          ,le.populated_previous_address_count_cnt
          ,le.populated_nametype_cnt
          ,le.populated_orig_consumer_create_date_cnt
          ,le.populated_orig_fname_cnt
          ,le.populated_orig_mname_cnt
          ,le.populated_orig_lname_cnt
          ,le.populated_orig_suffix_cnt
          ,le.populated_title_cnt
          ,le.populated_fname_cnt
          ,le.populated_mname_cnt
          ,le.populated_lname_cnt
          ,le.populated_name_suffix_cnt
          ,le.populated_name_score_cnt
          ,le.populated_addressseq_cnt
          ,le.populated_orig_address_create_date_cnt
          ,le.populated_orig_address_update_date_cnt
          ,le.populated_orig_prim_range_cnt
          ,le.populated_orig_predir_cnt
          ,le.populated_orig_prim_name_cnt
          ,le.populated_orig_addr_suffix_cnt
          ,le.populated_orig_postdir_cnt
          ,le.populated_orig_unit_desig_cnt
          ,le.populated_orig_sec_range_cnt
          ,le.populated_orig_city_cnt
          ,le.populated_orig_state_cnt
          ,le.populated_orig_zipcode_cnt
          ,le.populated_orig_zipcode4_cnt
          ,le.populated_prim_range_cnt
          ,le.populated_predir_cnt
          ,le.populated_prim_name_cnt
          ,le.populated_addr_suffix_cnt
          ,le.populated_postdir_cnt
          ,le.populated_unit_desig_cnt
          ,le.populated_sec_range_cnt
          ,le.populated_p_city_name_cnt
          ,le.populated_v_city_name_cnt
          ,le.populated_st_cnt
          ,le.populated_zip_cnt
          ,le.populated_zip4_cnt
          ,le.populated_cart_cnt
          ,le.populated_cr_sort_sz_cnt
          ,le.populated_lot_cnt
          ,le.populated_lot_order_cnt
          ,le.populated_dbpc_cnt
          ,le.populated_chk_digit_cnt
          ,le.populated_rec_type_cnt
          ,le.populated_county_cnt
          ,le.populated_geo_lat_cnt
          ,le.populated_geo_long_cnt
          ,le.populated_msa_cnt
          ,le.populated_geo_blk_cnt
          ,le.populated_geo_match_cnt
          ,le.populated_err_stat_cnt
          ,le.populated_delete_flag_cnt
          ,le.populated_delete_file_date_cnt
          ,le.populated_suppression_code_cnt
          ,le.populated_deceased_ind_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_seq_rec_id_pcnt
          ,le.populated_did_pcnt
          ,le.populated_did_score_field_pcnt
          ,le.populated_current_rec_flag_pcnt
          ,le.populated_current_experian_pin_pcnt
          ,le.populated_date_first_seen_pcnt
          ,le.populated_date_last_seen_pcnt
          ,le.populated_date_vendor_first_reported_pcnt
          ,le.populated_date_vendor_last_reported_pcnt
          ,le.populated_encrypted_experian_pin_pcnt
          ,le.populated_social_security_number_pcnt
          ,le.populated_date_of_birth_pcnt
          ,le.populated_telephone_pcnt
          ,le.populated_gender_pcnt
          ,le.populated_additional_name_count_pcnt
          ,le.populated_previous_address_count_pcnt
          ,le.populated_nametype_pcnt
          ,le.populated_orig_consumer_create_date_pcnt
          ,le.populated_orig_fname_pcnt
          ,le.populated_orig_mname_pcnt
          ,le.populated_orig_lname_pcnt
          ,le.populated_orig_suffix_pcnt
          ,le.populated_title_pcnt
          ,le.populated_fname_pcnt
          ,le.populated_mname_pcnt
          ,le.populated_lname_pcnt
          ,le.populated_name_suffix_pcnt
          ,le.populated_name_score_pcnt
          ,le.populated_addressseq_pcnt
          ,le.populated_orig_address_create_date_pcnt
          ,le.populated_orig_address_update_date_pcnt
          ,le.populated_orig_prim_range_pcnt
          ,le.populated_orig_predir_pcnt
          ,le.populated_orig_prim_name_pcnt
          ,le.populated_orig_addr_suffix_pcnt
          ,le.populated_orig_postdir_pcnt
          ,le.populated_orig_unit_desig_pcnt
          ,le.populated_orig_sec_range_pcnt
          ,le.populated_orig_city_pcnt
          ,le.populated_orig_state_pcnt
          ,le.populated_orig_zipcode_pcnt
          ,le.populated_orig_zipcode4_pcnt
          ,le.populated_prim_range_pcnt
          ,le.populated_predir_pcnt
          ,le.populated_prim_name_pcnt
          ,le.populated_addr_suffix_pcnt
          ,le.populated_postdir_pcnt
          ,le.populated_unit_desig_pcnt
          ,le.populated_sec_range_pcnt
          ,le.populated_p_city_name_pcnt
          ,le.populated_v_city_name_pcnt
          ,le.populated_st_pcnt
          ,le.populated_zip_pcnt
          ,le.populated_zip4_pcnt
          ,le.populated_cart_pcnt
          ,le.populated_cr_sort_sz_pcnt
          ,le.populated_lot_pcnt
          ,le.populated_lot_order_pcnt
          ,le.populated_dbpc_pcnt
          ,le.populated_chk_digit_pcnt
          ,le.populated_rec_type_pcnt
          ,le.populated_county_pcnt
          ,le.populated_geo_lat_pcnt
          ,le.populated_geo_long_pcnt
          ,le.populated_msa_pcnt
          ,le.populated_geo_blk_pcnt
          ,le.populated_geo_match_pcnt
          ,le.populated_err_stat_pcnt
          ,le.populated_delete_flag_pcnt
          ,le.populated_delete_file_date_pcnt
          ,le.populated_suppression_code_pcnt
          ,le.populated_deceased_ind_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,72,xNormHygieneStats(LEFT,COUNTER,'POP'));

  // record count stats
    SALT311.ScrubsOrbitLayout xTotalRecs(hygiene_summaryStats le, STRING inRuleDesc) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := inRuleDesc;
      SELF.ErrorMessage := '';
      SELF.rulecnt := le.NumberOfRecords;
      SELF.rulepcnt := 0;
    END;
    TotalRecsStats := PROJECT(hygiene_summaryStats, xTotalRecs(LEFT, 'records:total_records:POP'));

    mod_Delta := Delta(prevDS, PROJECT(h, Layout_File));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),72,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);

    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;

EXPORT StandardStats(DATASET(Layout_File) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;

  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_Experian_Monthly, Fields, 'RECORDOF(scrubsSummaryOverall)', '');
  scrubsSummaryOverall_Standard := NORMALIZE(scrubsSummaryOverall, (NumRulesFromFieldType + NumFieldsWithRules) * 4, xSummaryStats(LEFT, COUNTER, myTimeStamp, 'all', 'all'));

  allErrsOverall := mod_fromexpandedOverall.AllErrors;
  tErrsOverall := TABLE(DISTRIBUTE(allErrsOverall, HASH(FieldName, ErrorType)), {FieldName, ErrorType, FieldContents, cntExamples := COUNT(GROUP)}, FieldName, ErrorType, FieldContents, LOCAL);

  scrubsSummaryOverall_Standard_addErr   := IF(doErrorOverall,
                                               DENORMALIZE(SORT(DISTRIBUTE(scrubsSummaryOverall_Standard, HASH(field, ruletype)), field, ruletype, LOCAL),
  	                                                       SORT(tErrsOverall, FieldName, ErrorType, -cntExamples, FieldContents, LOCAL),
  	                                                       LEFT.field = RIGHT.FieldName AND LEFT.ruletype = RIGHT.ErrorType AND LEFT.MeasureType = 'CntRecs',
  	                                                       TRANSFORM(RECORDOF(LEFT),
  	                                                       SELF.dsExamples := LEFT.dsExamples & DATASET([{RIGHT.FieldContents, RIGHT.cntExamples, IF(LEFT.StatValue > 0, RIGHT.cntExamples/LEFT.StatValue * 100, 0)}], SALT311.Layout_Stats_Standard.Examples);
  	                                                       SELF := LEFT),
  	                                                       KEEP(10), LEFT OUTER, LOCAL, NOSORT));
  scrubsSummaryOverall_Standard_GeneralErrs := IF(doErrorOverall, SALT311.mod_StandardStatsTransforms.scrubsSummaryStatsGeneral(scrubsSummaryOverall,, myTimeStamp, 'all', 'all'));

  RETURN scrubsSummaryOverall_Standard_addErr & scrubsSummaryOverall_Standard_GeneralErrs;
END;
END;
