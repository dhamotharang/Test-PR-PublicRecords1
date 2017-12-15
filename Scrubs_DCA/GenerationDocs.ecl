﻿Generated by SALT V3.4.3
Command line options: -MScrubs_DCA -eC:\Users\mireleaa\AppData\Local\Temp\TFR320E.tmp 
File being processed :-
OPTIONS:-gh
MODULE:Scrubs_DCA
FILENAME:DCA
NAMESCOPE:Base_Companies
//--------------------------
//FIELDTYPE DEFINITIONS
//--------------------------
FIELDTYPE:invalid_mandatory:LENGTHS(1..)
FIELDTYPE:invalid_src_rid:CUSTOM(Scrubs_DCA.Functions.fn_src_rid > 0)
FIELDTYPE:invalid_rid:CUSTOM(Scrubs_DCA.Functions.fn_rid > 0)
FIELDTYPE:invalid_bdid:CUSTOM(Scrubs_DCA.Functions.fn_bdid > 0)
FIELDTYPE:invalid_numeric:CUSTOM(Scrubs_DCA.Functions.fn_numeric > 0)
FIELDTYPE:invalid_pastdate:CUSTOM(Scrubs_DCA.Functions.fn_past_yyyymmdd > 0)
FIELDTYPE:invalid_numeric_or_blank:CUSTOM(Scrubs_DCA.Functions.fn_numeric_or_blank > 0)
FIELDTYPE:invalid_record_type:ENUM(4|5)
FIELDTYPE:invalid_file_type:ENUM(PRIVCO|INT|PRV|PUB)
FIELDTYPE:invalid_company_type:ALLOW( AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz-&(),./:)
FIELDTYPE:invalid_email:ALLOW( 0123456789AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz-.@_,)
FIELDTYPE:invalid_url:CUSTOM(Scrubs_DCA.Functions.fn_url > 0) 
FIELDTYPE:invalid_alphablank:ALLOW( AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz)
FIELDTYPE:invalid_sic:CUSTOM(Scrubs_DCA.Functions.fn_sic > 0)
FIELDTYPE:invalid_naics:CUSTOM(Scrubs_DCA.Functions.fn_naics > 0)
FIELDTYPE:invalid_phone:CUSTOM(Scrubs_DCA.Functions.fn_verify_phone>0)
 
//----------------------------- 
//FIELDS BEING SCRUBBED
//-----------------------------
FIELD:src_rid:TYPE(UNSIGNED6):LIKE(invalid_src_rid):0,0
FIELD:rid:TYPE(UNSIGNED6):LIKE(invalid_rid):0,0
FIELD:bdid:TYPE(UNSIGNED6):LIKE(invalid_bdid):0,0
FIELD:powid:TYPE(UNSIGNED6):LIKE(invalid_numeric):0,0
FIELD:proxid:TYPE(UNSIGNED6):LIKE(invalid_numeric):0,0
FIELD:seleid:TYPE(UNSIGNED6):LIKE(invalid_numeric):0,0
FIELD:orgid:TYPE(UNSIGNED6):LIKE(invalid_numeric):0,0
FIELD:ultid:TYPE(UNSIGNED6):LIKE(invalid_numeric):0,0
FIELD:date_first_seen:TYPE(UNSIGNED4):LIKE(invalid_pastdate):0,0
FIELD:date_last_seen:TYPE(UNSIGNED4):LIKE(invalid_pastdate):0,0
FIELD:date_vendor_first_reported:TYPE(UNSIGNED4):LIKE(invalid_pastdate):0,0
FIELD:date_vendor_last_reported:TYPE(UNSIGNED4):LIKE(invalid_pastdate):0,0
FIELD:physical_rawaid:TYPE(UNSIGNED8):LIKE(invalid_numeric_or_blank):0,0
FIELD:physical_aceaid:TYPE(UNSIGNED8):LIKE(invalid_numeric_or_blank):0,0
FIELD:mailing_rawaid:TYPE(UNSIGNED8):LIKE(invalid_numeric_or_blank):0,0
FIELD:mailing_aceaid:TYPE(UNSIGNED8):LIKE(invalid_numeric_or_blank):0,0
FIELD:record_type:TYPE(UNSIGNED1):LIKE(invalid_record_type):0,0
FIELD:file_type:TYPE(STRING6):LIKE(invalid_file_type):0,0
FIELD:lncagid:TYPE(UNSIGNED3):LIKE(invalid_numeric_or_blank):0,0
FIELD:lncaghid:TYPE(UNSIGNED3):LIKE(invalid_numeric_or_blank):0,0
FIELD:lncaiid:TYPE(UNSIGNED2):LIKE(invalid_numeric_or_blank):0,0
FIELD:rawfields_enterprise_num:TYPE(STRING9):LIKE(invalid_numeric_or_blank):0,0
FIELD:rawfields_parent_enterprise_number:TYPE(STRING9):LIKE(invalid_numeric_or_blank):0,0
FIELD:rawfields_ultimate_enterprise_number:TYPE(STRING9):LIKE(invalid_numeric_or_blank):0,0
FIELD:rawfields_company_type:TYPE(STRING70):LIKE(invalid_company_type):0,0
FIELD:rawfields_name:TYPE(STRING150):LIKE(invalid_mandatory):0,0
FIELD:rawfields_e_mail:TYPE(STRING120):LIKE(invalid_email):0,0
FIELD:rawfields_url:TYPE(STRING120):LIKE(invalid_url):0,0
FIELD:rawfields_incorp:TYPE(STRING2):LIKE(invalid_alphablank):0,0
FIELD:rawfields_sic1:TYPE(STRING30):LIKE(invalid_sic):0,0
FIELD:rawfields_sic2:TYPE(STRING30):LIKE(invalid_sic):0,0
FIELD:rawfields_sic3:TYPE(STRING30):LIKE(invalid_sic):0,0
FIELD:rawfields_sic4:TYPE(STRING30):LIKE(invalid_sic):0,0
FIELD:rawfields_sic5:TYPE(STRING30):LIKE(invalid_sic):0,0
FIELD:rawfields_sic6:TYPE(STRING30):LIKE(invalid_sic):0,0
FIELD:rawfields_sic7:TYPE(STRING30):LIKE(invalid_sic):0,0
FIELD:rawfields_sic8:TYPE(STRING30):LIKE(invalid_sic):0,0
FIELD:rawfields_sic9:TYPE(STRING30):LIKE(invalid_sic):0,0
FIELD:rawfields_sic10:TYPE(STRING30):LIKE(invalid_sic):0,0
FIELD:rawfields_naics1:TYPE(STRING7):LIKE(invalid_naics):0,0
FIELD:rawfields_naics2:TYPE(STRING7):LIKE(invalid_naics):0,0
FIELD:rawfields_naics3:TYPE(STRING7):LIKE(invalid_naics):0,0
FIELD:rawfields_naics4:TYPE(STRING7):LIKE(invalid_naics):0,0
FIELD:rawfields_naics5:TYPE(STRING7):LIKE(invalid_naics):0,0
FIELD:rawfields_naics6:TYPE(STRING7):LIKE(invalid_naics):0,0
FIELD:rawfields_naics7:TYPE(STRING7):LIKE(invalid_naics):0,0
FIELD:rawfields_naics8:TYPE(STRING7):LIKE(invalid_naics):0,0
FIELD:rawfields_naics9:TYPE(STRING7):LIKE(invalid_naics):0,0
FIELD:rawfields_naics10:TYPE(STRING7):LIKE(invalid_naics):0,0
FIELD:physical_address_prim_name:TYPE(STRING28):LIKE(invalid_mandatory):0,0
FIELD:physical_address_p_city_name:TYPE(STRING25):LIKE(invalid_mandatory):0,0
FIELD:physical_address_v_city_name:TYPE(STRING25):LIKE(invalid_mandatory):0,0
FIELD:physical_address_st:TYPE(STRING2):LIKE(invalid_mandatory):0,0
FIELD:physical_address_zip:TYPE(STRING5):LIKE(invalid_mandatory):0,0
FIELD:mailing_address_prim_name:TYPE(STRING28):LIKE(invalid_mandatory):0,0
FIELD:mailing_address_p_city_name:TYPE(STRING25):LIKE(invalid_mandatory):0,0
FIELD:mailing_address_v_city_name:TYPE(STRING25):LIKE(invalid_mandatory):0,0
FIELD:mailing_address_st:TYPE(STRING2):LIKE(invalid_mandatory):0,0
FIELD:mailing_address_zip:TYPE(STRING5):LIKE(invalid_mandatory):0,0
FIELD:clean_phones_phone:TYPE(STRING10):LIKE(invalid_phone):0,0
FIELD:clean_phones_fax:TYPE(STRING10):LIKE(invalid_phone):0,0
FIELD:clean_phones_telex:TYPE(STRING10):LIKE(invalid_phone):0,0
FIELD:clean_dates_update_date:TYPE(STRING8):LIKE(invalid_pastdate):0,0
 
//-----------------------------
//FIELDS NOT BEING SCRUBBED
//-----------------------------
// FIELD:dotid:TYPE(UNSIGNED6):0,0
// FIELD:dotscore:TYPE(UNSIGNED2):0,0
// FIELD:dotweight:TYPE(UNSIGNED2):0,0
// FIELD:empid:TYPE(UNSIGNED6):0,0
// FIELD:empscore:TYPE(UNSIGNED2):0,0
// FIELD:empweight:TYPE(UNSIGNED2):0,0
// FIELD:bdid_score:TYPE(UNSIGNED1):0,0
// FIELD:powscore:TYPE(UNSIGNED2):0,0
// FIELD:powweight:TYPE(UNSIGNED2):0,0
// FIELD:proxscore:TYPE(UNSIGNED2):0,0
// FIELD:proxweight:TYPE(UNSIGNED2):0,0
// FIELD:selescore:TYPE(UNSIGNED2):0,0
// FIELD:seleweight:TYPE(UNSIGNED2):0,0
// FIELD:orgscore:TYPE(UNSIGNED2):0,0
// FIELD:orgweight:TYPE(UNSIGNED2):0,0
// FIELD:ultscore:TYPE(UNSIGNED2):0,0
// FIELD:ultweight:TYPE(UNSIGNED2):0,0
// FIELD:rawfields_note:TYPE(STRING150):0,0
// FIELD:rawfields_level:TYPE(STRING2):0,0
// FIELD:rawfields_root:TYPE(STRING9):0,0
// FIELD:rawfields_sub:TYPE(STRING4):0,0
// FIELD:rawfields_parent_name:TYPE(STRING150):0,0
// FIELD:rawfields_parent_number:TYPE(STRING15):0,0
// FIELD:rawfields_jv_parent1:TYPE(STRING150):0,0
// FIELD:rawfields_jv1_num:TYPE(STRING15):0,0
// FIELD:rawfields_jv_parent2:TYPE(STRING150):0,0
// FIELD:rawfields_jv2_num:TYPE(STRING15):0,0
// FIELD:rawfields_address1_po_box_bldg:TYPE(STRING30):0,0
// FIELD:rawfields_address1_street:TYPE(STRING70):0,0
// FIELD:rawfields_address1_foreign_po:TYPE(STRING70):0,0
// FIELD:rawfields_address1_misc__adr:TYPE(STRING80):0,0
// FIELD:rawfields_address1_postal_code_1:TYPE(STRING15):0,0
// FIELD:rawfields_address1_city:TYPE(STRING30):0,0
// FIELD:rawfields_address1_state:TYPE(STRING2):0,0
// FIELD:rawfields_address1_zip:TYPE(STRING15):0,0
// FIELD:rawfields_address1_province:TYPE(STRING20):0,0
// FIELD:rawfields_address1_postal_code_2:TYPE(STRING15):0,0
// FIELD:rawfields_address1_country:TYPE(STRING30):0,0
// FIELD:rawfields_address1_postal_code_3:TYPE(STRING15):0,0
// FIELD:rawfields_phone:TYPE(STRING50):0,0
// FIELD:rawfields_fax:TYPE(STRING50):0,0
// FIELD:rawfields_telex:TYPE(STRING50):0,0
// FIELD:rawfields_address2_po_box_bldg:TYPE(STRING30):0,0
// FIELD:rawfields_address2_street:TYPE(STRING70):0,0
// FIELD:rawfields_address2_foreign_po:TYPE(STRING70):0,0
// FIELD:rawfields_address2_misc__adr:TYPE(STRING80):0,0
// FIELD:rawfields_address2_postal_code_1:TYPE(STRING15):0,0
// FIELD:rawfields_address2_city:TYPE(STRING30):0,0
// FIELD:rawfields_address2_state:TYPE(STRING2):0,0
// FIELD:rawfields_address2_zip:TYPE(STRING15):0,0
// FIELD:rawfields_address2_province:TYPE(STRING20):0,0
// FIELD:rawfields_address2_postal_code_2:TYPE(STRING15):0,0
// FIELD:rawfields_address2_country:TYPE(STRING30):0,0
// FIELD:rawfields_address2_postal_code_3:TYPE(STRING15):0,0
// FIELD:rawfields_percent_owned:TYPE(STRING5):0,0
// FIELD:rawfields_earnings:TYPE(STRING12):0,0
// FIELD:rawfields_sales:TYPE(STRING12):0,0
// FIELD:rawfields_sales_desc:TYPE(STRING50):0,0
// FIELD:rawfields_assets:TYPE(STRING12):0,0
// FIELD:rawfields_liabilities:TYPE(STRING12):0,0
// FIELD:rawfields_net_worth:TYPE(STRING12):0,0
// FIELD:rawfields_fye:TYPE(STRING6):0,0
// FIELD:rawfields_emp_num:TYPE(STRING9):0,0
// FIELD:rawfields_doesimport:TYPE(STRING1):0,0
// FIELD:rawfields_doesexport:TYPE(STRING50):0,0
// FIELD:rawfields_bus_desc:TYPE(STRING4000):0,0
// FIELD:rawfields_text1:TYPE(STRING150):0,0
// FIELD:rawfields_text2:TYPE(STRING150):0,0
// FIELD:rawfields_text3:TYPE(STRING150):0,0
// FIELD:rawfields_text4:TYPE(STRING150):0,0
// FIELD:rawfields_text5:TYPE(STRING150):0,0
// FIELD:rawfields_text6:TYPE(STRING150):0,0
// FIELD:rawfields_text7:TYPE(STRING150):0,0
// FIELD:rawfields_text8:TYPE(STRING150):0,0
// FIELD:rawfields_text9:TYPE(STRING150):0,0
// FIELD:rawfields_text10:TYPE(STRING150):0,0
// FIELD:rawfields_ticker_symbol:TYPE(STRING20):0,0
// FIELD:rawfields_exchange1:TYPE(STRING450):0,0
// FIELD:rawfields_exchange2:TYPE(STRING450):0,0
// FIELD:rawfields_exchange3:TYPE(STRING450):0,0
// FIELD:rawfields_exchange4:TYPE(STRING450):0,0
// FIELD:rawfields_exchange5:TYPE(STRING450):0,0
// FIELD:rawfields_exchange6:TYPE(STRING450):0,0
// FIELD:rawfields_exchange7:TYPE(STRING450):0,0
// FIELD:rawfields_exchange8:TYPE(STRING450):0,0
// FIELD:rawfields_exchange9:TYPE(STRING450):0,0
// FIELD:rawfields_exchange10:TYPE(STRING450):0,0
// FIELD:rawfields_exchange11:TYPE(STRING450):0,0
// FIELD:rawfields_exchange12:TYPE(STRING450):0,0
// FIELD:rawfields_exchange13:TYPE(STRING450):0,0
// FIELD:rawfields_exchange14:TYPE(STRING450):0,0
// FIELD:rawfields_exchange15:TYPE(STRING450):0,0
// FIELD:rawfields_exchange16:TYPE(STRING450):0,0
// FIELD:rawfields_exchange17:TYPE(STRING450):0,0
// FIELD:rawfields_exchange18:TYPE(STRING450):0,0
// FIELD:rawfields_exchange19:TYPE(STRING450):0,0
// FIELD:rawfields_exchange20:TYPE(STRING450):0,0
// FIELD:rawfields_extended_profile:TYPE(STRING4000):0,0
// FIELD:rawfields_cbsa:TYPE(STRING60):0,0
// FIELD:rawfields_competitors:TYPE(STRING5000):0,0
// FIELD:rawfields_naics_text1:TYPE(STRING150):0,0
// FIELD:rawfields_naics_text2:TYPE(STRING150):0,0
// FIELD:rawfields_naics_text3:TYPE(STRING150):0,0
// FIELD:rawfields_naics_text4:TYPE(STRING150):0,0
// FIELD:rawfields_naics_text5:TYPE(STRING150):0,0
// FIELD:rawfields_naics_text6:TYPE(STRING150):0,0
// FIELD:rawfields_naics_text7:TYPE(STRING150):0,0
// FIELD:rawfields_naics_text8:TYPE(STRING150):0,0
// FIELD:rawfields_naics_text9:TYPE(STRING150):0,0
// FIELD:rawfields_naics_text10:TYPE(STRING150):0,0
// FIELD:rawfields_update_date:TYPE(STRING8):0,0
// FIELD:killreport_company_id:TYPE(STRING12):0,0
// FIELD:killreport_company_name:TYPE(STRING150):0,0
// FIELD:killreport_is_major_us_stk:TYPE(STRING1):0,0
// FIELD:killreport_comp_type:TYPE(STRING2):0,0
// FIELD:killreport_kill_reason:TYPE(STRING100):0,0
// FIELD:killreport_kill_date_raw:TYPE(STRING10):0,0
// FIELD:killreport_kill_date_clean:TYPE(STRING8):0,0
// FIELD:killreport_kill_reason_clean:TYPE(STRING20):0,0
// FIELD:killreport_kill_enterprise_nbr:TYPE(STRING9):0,0
// FIELD:killreport_filedate:TYPE(STRING8):0,0
// FIELD:mergeracquis_mna_type:TYPE(STRING25):0,0
// FIELD:mergeracquis_mna_status:TYPE(STRING9):0,0
// FIELD:mergeracquis_status_marked_in_db:TYPE(STRING3):0,0
// FIELD:mergeracquis_target_company:TYPE(STRING150):0,0
// FIELD:mergeracquis_what_happened:TYPE(STRING300):0,0
// FIELD:mergeracquis_mna_amount_offered:TYPE(STRING15):0,0
// FIELD:mergeracquis_mna_close_date:TYPE(STRING9):0,0
// FIELD:mergeracquis_lexisnexis_posting_date:TYPE(STRING20):0,0
// FIELD:mergeracquis_editorial_comments:TYPE(STRING10):0,0
// FIELD:mergeracquis_last_change_date:TYPE(STRING20):0,0
// FIELD:mergeracquis_updated_by:TYPE(STRING9):0,0
// FIELD:mergeracquis_target_enterprise_nbr:TYPE(STRING9):0,0
// FIELD:mergeracquis_buyer1_enterprise_nbr:TYPE(STRING9):0,0
// FIELD:mergeracquis_buyer2_enterprise_nbr:TYPE(STRING9):0,0
// FIELD:mergeracquis_buyer3_enterprise_nbr:TYPE(STRING9):0,0
// FIELD:mergeracquis_seller1_enterprise_nbr:TYPE(STRING9):0,0
// FIELD:mergeracquis_seller2_enterprise_nbr:TYPE(STRING9):0,0
// FIELD:mergeracquis_seller3_enterprise_nbr:TYPE(STRING9):0,0
// FIELD:mergeracquis_mna_close_date_clean:TYPE(STRING8):0,0
// FIELD:mergeracquis_ln_posting_date_clean:TYPE(STRING8):0,0
// FIELD:mergeracquis_last_change_date_clean:TYPE(STRING8):0,0
// FIELD:mergeracquis_filedate:TYPE(STRING8):0,0
// FIELD:physical_address_prim_range:TYPE(STRING10):0,0
// FIELD:physical_address_predir:TYPE(STRING2):0,0
// FIELD:physical_address_addr_suffix:TYPE(STRING4):0,0
// FIELD:physical_address_postdir:TYPE(STRING2):0,0
// FIELD:physical_address_unit_desig:TYPE(STRING10):0,0
// FIELD:physical_address_sec_range:TYPE(STRING8):0,0
// FIELD:physical_address_zip4:TYPE(STRING4):0,0
// FIELD:physical_address_cart:TYPE(STRING4):0,0
// FIELD:physical_address_cr_sort_sz:TYPE(STRING1):0,0
// FIELD:physical_address_lot:TYPE(STRING4):0,0
// FIELD:physical_address_lot_order:TYPE(STRING1):0,0
// FIELD:physical_address_dbpc:TYPE(STRING2):0,0
// FIELD:physical_address_chk_digit:TYPE(STRING1):0,0
// FIELD:physical_address_rec_type:TYPE(STRING2):0,0
// FIELD:physical_address_fips_state:TYPE(STRING2):0,0
// FIELD:physical_address_fips_county:TYPE(STRING3):0,0
// FIELD:physical_address_geo_lat:TYPE(STRING10):0,0
// FIELD:physical_address_geo_long:TYPE(STRING11):0,0
// FIELD:physical_address_msa:TYPE(STRING4):0,0
// FIELD:physical_address_geo_blk:TYPE(STRING7):0,0
// FIELD:physical_address_geo_match:TYPE(STRING1):0,0
// FIELD:physical_address_err_stat:TYPE(STRING4):0,0
// FIELD:mailing_address_prim_range:TYPE(STRING10):0,0
// FIELD:mailing_address_predir:TYPE(STRING2):0,0
// FIELD:mailing_address_addr_suffix:TYPE(STRING4):0,0
// FIELD:mailing_address_postdir:TYPE(STRING2):0,0
// FIELD:mailing_address_unit_desig:TYPE(STRING10):0,0
// FIELD:mailing_address_sec_range:TYPE(STRING8):0,0
// FIELD:mailing_address_zip4:TYPE(STRING4):0,0
// FIELD:mailing_address_cart:TYPE(STRING4):0,0
// FIELD:mailing_address_cr_sort_sz:TYPE(STRING1):0,0
// FIELD:mailing_address_lot:TYPE(STRING4):0,0
// FIELD:mailing_address_lot_order:TYPE(STRING1):0,0
// FIELD:mailing_address_dbpc:TYPE(STRING2):0,0
// FIELD:mailing_address_chk_digit:TYPE(STRING1):0,0
// FIELD:mailing_address_rec_type:TYPE(STRING2):0,0
// FIELD:mailing_address_fips_state:TYPE(STRING2):0,0
// FIELD:mailing_address_fips_county:TYPE(STRING3):0,0
// FIELD:mailing_address_geo_lat:TYPE(STRING10):0,0
// FIELD:mailing_address_geo_long:TYPE(STRING11):0,0
// FIELD:mailing_address_msa:TYPE(STRING4):0,0
// FIELD:mailing_address_geo_blk:TYPE(STRING7):0,0
// FIELD:mailing_address_geo_match:TYPE(STRING1):0,0
// FIELD:mailing_address_err_stat:TYPE(STRING4):0,0
 
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
 
