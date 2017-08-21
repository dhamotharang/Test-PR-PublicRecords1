Generated by SALT V2.8 Gold SR1
File being processed :-
MODULE:sshah
FILENAME:inquiry_Acclogs_FCRA_SSN
//Uncomment up to NINES for internal or external adl
//IDFIELD:EXISTS:<NameOfIDField>
//RIDFIELD:<NameOfRidField>
//RECORDS:<NumberOfRecordsInDataFile>
//POPULATION:<ExpectedNumberOfEntitiesInDataFile>
//NINES:<Precision required 3 = 99.9, 2 = 99 2.951583e+255tc>
//Uncomment Process if doing external adl
//PROCESS:<ProcessName>
//FIELDTYPE statements can be used to clean up (or check the cleaning) of individual fields
//BESTTYPE statements declare methods of generating the best value for a given cluster; this can also improve linking
//FUZZY can be used to create new types of FUZZY linking
FIELD:ssn:TYPE(STRING9):0,0
FIELD:mbs_company_id:TYPE(STRING):0,0
FIELD:mbs_global_company_id:TYPE(STRING):0,0
FIELD:allow_flags_allowflags:TYPE(UNSIGNED8):0,0
FIELD:bus_intel_primary_market_code:TYPE(STRING):0,0
FIELD:bus_intel_secondary_market_code:TYPE(STRING):0,0
FIELD:bus_intel_industry_1_code:TYPE(STRING):0,0
FIELD:bus_intel_industry_2_code:TYPE(STRING):0,0
FIELD:bus_intel_sub_market:TYPE(STRING):0,0
FIELD:bus_intel_vertical:TYPE(STRING):0,0
FIELD:bus_intel_use:TYPE(STRING):0,0
FIELD:bus_intel_industry:TYPE(STRING):0,0
FIELD:person_q_full_name:TYPE(STRING):0,0
FIELD:person_q_first_name:TYPE(STRING):0,0
FIELD:person_q_middle_name:TYPE(STRING):0,0
FIELD:person_q_last_name:TYPE(STRING):0,0
FIELD:person_q_address:TYPE(STRING):0,0
FIELD:person_q_city:TYPE(STRING):0,0
FIELD:person_q_state:TYPE(STRING):0,0
FIELD:person_q_zip:TYPE(STRING):0,0
FIELD:person_q_personal_phone:TYPE(STRING):0,0
FIELD:person_q_work_phone:TYPE(STRING):0,0
FIELD:person_q_dob:TYPE(STRING):0,0
FIELD:person_q_dl:TYPE(STRING):0,0
FIELD:person_q_dl_st:TYPE(STRING):0,0
FIELD:person_q_email_address:TYPE(STRING):0,0
FIELD:person_q_ssn:TYPE(STRING):0,0
FIELD:person_q_linkid:TYPE(STRING):0,0
FIELD:person_q_ipaddr:TYPE(STRING):0,0
FIELD:person_q_title:TYPE(STRING5):0,0
FIELD:person_q_fname:TYPE(STRING20):0,0
FIELD:person_q_mname:TYPE(STRING20):0,0
FIELD:person_q_lname:TYPE(STRING20):0,0
FIELD:person_q_name_suffix:TYPE(STRING5):0,0
FIELD:person_q_prim_range:TYPE(STRING10):0,0
FIELD:person_q_predir:TYPE(STRING2):0,0
FIELD:person_q_prim_name:TYPE(STRING28):0,0
FIELD:person_q_addr_suffix:TYPE(STRING4):0,0
FIELD:person_q_postdir:TYPE(STRING2):0,0
FIELD:person_q_unit_desig:TYPE(STRING10):0,0
FIELD:person_q_sec_range:TYPE(STRING8):0,0
FIELD:person_q_v_city_name:TYPE(STRING25):0,0
FIELD:person_q_st:TYPE(STRING2):0,0
FIELD:person_q_zip5:TYPE(STRING5):0,0
FIELD:person_q_zip4:TYPE(STRING4):0,0
FIELD:person_q_addr_rec_type:TYPE(STRING2):0,0
FIELD:person_q_fips_state:TYPE(STRING2):0,0
FIELD:person_q_fips_county:TYPE(STRING3):0,0
FIELD:person_q_geo_lat:TYPE(STRING10):0,0
FIELD:person_q_geo_long:TYPE(STRING11):0,0
FIELD:person_q_cbsa:TYPE(STRING4):0,0
FIELD:person_q_geo_blk:TYPE(STRING7):0,0
FIELD:person_q_geo_match:TYPE(STRING1):0,0
FIELD:person_q_err_stat:TYPE(STRING4):0,0
FIELD:person_q_appended_ssn:TYPE(STRING):0,0
FIELD:person_q_appended_adl:TYPE(UNSIGNED6):0,0
FIELD:bus_q_cname:TYPE(STRING):0,0
FIELD:bus_q_address:TYPE(STRING):0,0
FIELD:bus_q_city:TYPE(STRING):0,0
FIELD:bus_q_state:TYPE(STRING):0,0
FIELD:bus_q_zip:TYPE(STRING):0,0
FIELD:bus_q_company_phone:TYPE(STRING):0,0
FIELD:bus_q_ein:TYPE(STRING):0,0
FIELD:bus_q_charter_number:TYPE(STRING):0,0
FIELD:bus_q_ucc_number:TYPE(STRING):0,0
FIELD:bus_q_domain_name:TYPE(STRING):0,0
FIELD:bus_q_prim_range:TYPE(STRING10):0,0
FIELD:bus_q_predir:TYPE(STRING2):0,0
FIELD:bus_q_prim_name:TYPE(STRING28):0,0
FIELD:bus_q_addr_suffix:TYPE(STRING4):0,0
FIELD:bus_q_postdir:TYPE(STRING2):0,0
FIELD:bus_q_unit_desig:TYPE(STRING10):0,0
FIELD:bus_q_sec_range:TYPE(STRING8):0,0
FIELD:bus_q_v_city_name:TYPE(STRING25):0,0
FIELD:bus_q_st:TYPE(STRING2):0,0
FIELD:bus_q_zip5:TYPE(STRING5):0,0
FIELD:bus_q_zip4:TYPE(STRING4):0,0
FIELD:bus_q_addr_rec_type:TYPE(STRING2):0,0
FIELD:bus_q_fips_state:TYPE(STRING2):0,0
FIELD:bus_q_fips_county:TYPE(STRING3):0,0
FIELD:bus_q_geo_lat:TYPE(STRING10):0,0
FIELD:bus_q_geo_long:TYPE(STRING11):0,0
FIELD:bus_q_cbsa:TYPE(STRING4):0,0
FIELD:bus_q_geo_blk:TYPE(STRING7):0,0
FIELD:bus_q_geo_match:TYPE(STRING1):0,0
FIELD:bus_q_err_stat:TYPE(STRING4):0,0
FIELD:bus_q_appended_bdid:TYPE(UNSIGNED6):0,0
FIELD:bus_q_appended_ein:TYPE(STRING):0,0
FIELD:bususer_q_personal_phone:TYPE(STRING):0,0
FIELD:bususer_q_dob:TYPE(STRING):0,0
FIELD:bususer_q_dl:TYPE(STRING):0,0
FIELD:bususer_q_dl_st:TYPE(STRING):0,0
FIELD:bususer_q_ssn:TYPE(STRING):0,0
FIELD:bususer_q_title:TYPE(STRING5):0,0
FIELD:bususer_q_fname:TYPE(STRING20):0,0
FIELD:bususer_q_mname:TYPE(STRING20):0,0
FIELD:bususer_q_lname:TYPE(STRING20):0,0
FIELD:bususer_q_name_suffix:TYPE(STRING5):0,0
FIELD:bususer_q_prim_range:TYPE(STRING10):0,0
FIELD:bususer_q_predir:TYPE(STRING2):0,0
FIELD:bususer_q_prim_name:TYPE(STRING28):0,0
FIELD:bususer_q_addr_suffix:TYPE(STRING4):0,0
FIELD:bususer_q_postdir:TYPE(STRING2):0,0
FIELD:bususer_q_unit_desig:TYPE(STRING10):0,0
FIELD:bususer_q_sec_range:TYPE(STRING8):0,0
FIELD:bususer_q_v_city_name:TYPE(STRING25):0,0
FIELD:bususer_q_st:TYPE(STRING2):0,0
FIELD:bususer_q_zip5:TYPE(STRING5):0,0
FIELD:bususer_q_zip4:TYPE(STRING4):0,0
FIELD:bususer_q_addr_rec_type:TYPE(STRING2):0,0
FIELD:bususer_q_fips_state:TYPE(STRING2):0,0
FIELD:bususer_q_fips_county:TYPE(STRING3):0,0
FIELD:bususer_q_geo_lat:TYPE(STRING10):0,0
FIELD:bususer_q_geo_long:TYPE(STRING11):0,0
FIELD:bususer_q_cbsa:TYPE(STRING4):0,0
FIELD:bususer_q_geo_blk:TYPE(STRING7):0,0
FIELD:bususer_q_geo_match:TYPE(STRING1):0,0
FIELD:bususer_q_err_stat:TYPE(STRING4):0,0
FIELD:bususer_q_appended_ssn:TYPE(STRING):0,0
FIELD:bususer_q_appended_adl:TYPE(UNSIGNED6):0,0
FIELD:permissions_glb_purpose:TYPE(STRING):0,0
FIELD:permissions_dppa_purpose:TYPE(STRING):0,0
FIELD:permissions_fcra_purpose:TYPE(STRING):0,0
FIELD:search_info_datetime:TYPE(STRING):0,0
FIELD:search_info_start_monitor:TYPE(STRING):0,0
FIELD:search_info_stop_monitor:TYPE(STRING):0,0
FIELD:search_info_login_history_id:TYPE(STRING):0,0
FIELD:search_info_transaction_id:TYPE(STRING):0,0
FIELD:search_info_sequence_number:TYPE(STRING):0,0
FIELD:search_info_method:TYPE(STRING):0,0
FIELD:search_info_product_code:TYPE(STRING):0,0
FIELD:search_info_transaction_type:TYPE(STRING):0,0
FIELD:search_info_function_description:TYPE(STRING):0,0
FIELD:search_info_ipaddr:TYPE(STRING):0,0
//CONCEPT statements should be used to group together interellated fields; such as address
//RELATIONSHIP is used to find non-obvious relationships between the clusters
//SOURCEFIELD is used if a field of the file denotes a source of the records in that file
//LINKPATH is used to define access paths for external linking
Total available specificity:0
Search Threshold set at -4
Use of PERSISTs in code set at:3
__Glossary__
Edit Distance: An edit distance of (say) one implies that one string can be converted into another by doing one of
  - Changing one character
  - Deleting one character
  - Transposing two characters
Forcing Criteria: In addition to the general 'best match' logic it is possible to insist that
one particular field must match to some degree or the whole record is considered a bad match.
The criterial applied to that one field is the forcing criteria.
Cascade: Best Type rules are applied in such a way that the rules are applied one by one UNTIL the first rule succeeds; subsequent rules are then skipped.
__General Notes__
How is it decided how much to subtract for a bad match?
SALT computes for each field the percentage likelihood that a valid cluster will have two or more values for a given field
this value (called the switch value in the SALT literature) is then used to produce the subtraction value from the match value.
The value in this document is the one typed into the SPC file; the code will use a value computed at run-time.
