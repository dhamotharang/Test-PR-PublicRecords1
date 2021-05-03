IMPORT SALT311,STD;
EXPORT Contacts_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 90;
  EXPORT NumRulesFromFieldType := 90;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 86;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Contacts_Layout_Sheila_Greco)
    UNSIGNED1 dt_first_seen_Invalid;
    UNSIGNED1 dt_last_seen_Invalid;
    UNSIGNED1 dt_vendor_first_reported_Invalid;
    UNSIGNED1 dt_vendor_last_reported_Invalid;
    UNSIGNED1 record_type_Invalid;
    UNSIGNED1 rawfields_maincontactid_Invalid;
    UNSIGNED1 rawfields_maincompanyid_Invalid;
    UNSIGNED1 rawfields_active_Invalid;
    UNSIGNED1 rawfields_firstname_Invalid;
    UNSIGNED1 rawfields_midinital_Invalid;
    UNSIGNED1 rawfields_lastname_Invalid;
    UNSIGNED1 rawfields_age_Invalid;
    UNSIGNED1 rawfields_gender_Invalid;
    UNSIGNED1 rawfields_primarytitle_Invalid;
    UNSIGNED1 rawfields_titlelevel1_Invalid;
    UNSIGNED1 rawfields_primarydept_Invalid;
    UNSIGNED1 rawfields_secondtitle_Invalid;
    UNSIGNED1 rawfields_titlelevel2_Invalid;
    UNSIGNED1 rawfields_seconddept_Invalid;
    UNSIGNED1 rawfields_thirdtitle_Invalid;
    UNSIGNED1 rawfields_titlelevel3_Invalid;
    UNSIGNED1 rawfields_thirddept_Invalid;
    UNSIGNED1 rawfields_skillcategory_Invalid;
    UNSIGNED1 rawfields_skillsubcategory_Invalid;
    UNSIGNED1 rawfields_reportto_Invalid;
    UNSIGNED1 rawfields_officephone_Invalid;
    UNSIGNED1 rawfields_officeext_Invalid;
    UNSIGNED1 rawfields_officefax_Invalid;
    UNSIGNED1 rawfields_officeemail_Invalid;
    UNSIGNED1 rawfields_directdial_Invalid;
    UNSIGNED1 rawfields_mobilephone_Invalid;
    UNSIGNED1 rawfields_officeaddress1_Invalid;
    UNSIGNED1 rawfields_officeaddress2_Invalid;
    UNSIGNED1 rawfields_officecity_Invalid;
    UNSIGNED1 rawfields_officestate_Invalid;
    UNSIGNED1 rawfields_officezip_Invalid;
    UNSIGNED1 rawfields_officecountry_Invalid;
    UNSIGNED1 rawfields_school_Invalid;
    UNSIGNED1 rawfields_degree_Invalid;
    UNSIGNED1 rawfields_graduationyear_Invalid;
    UNSIGNED1 rawfields_country_Invalid;
    UNSIGNED1 rawfields_salary_Invalid;
    UNSIGNED1 rawfields_bonus_Invalid;
    UNSIGNED1 rawfields_compensation_Invalid;
    UNSIGNED1 rawfields_citizenship_Invalid;
    UNSIGNED1 rawfields_diversitycandidate_Invalid;
    UNSIGNED1 rawfields_entrydate_Invalid;
    UNSIGNED1 rawfields_lastupdate_Invalid;
    UNSIGNED1 clean_contact_name_title_Invalid;
    UNSIGNED1 clean_contact_name_fname_Invalid;
    UNSIGNED1 clean_contact_name_mname_Invalid;
    UNSIGNED1 clean_contact_name_lname_Invalid;
    UNSIGNED1 clean_contact_name_name_suffix_Invalid;
    UNSIGNED1 clean_contact_name_name_score_Invalid;
    UNSIGNED1 clean_contact_address_prim_range_Invalid;
    UNSIGNED1 clean_contact_address_predir_Invalid;
    UNSIGNED1 clean_contact_address_prim_name_Invalid;
    UNSIGNED1 clean_contact_address_addr_suffix_Invalid;
    UNSIGNED1 clean_contact_address_postdir_Invalid;
    UNSIGNED1 clean_contact_address_unit_desig_Invalid;
    UNSIGNED1 clean_contact_address_sec_range_Invalid;
    UNSIGNED1 clean_contact_address_p_city_name_Invalid;
    UNSIGNED1 clean_contact_address_v_city_name_Invalid;
    UNSIGNED1 clean_contact_address_st_Invalid;
    UNSIGNED1 clean_contact_address_zip_Invalid;
    UNSIGNED1 clean_contact_address_zip4_Invalid;
    UNSIGNED1 clean_contact_address_cart_Invalid;
    UNSIGNED1 clean_contact_address_cr_sort_sz_Invalid;
    UNSIGNED1 clean_contact_address_lot_Invalid;
    UNSIGNED1 clean_contact_address_lot_order_Invalid;
    UNSIGNED1 clean_contact_address_dbpc_Invalid;
    UNSIGNED1 clean_contact_address_chk_digit_Invalid;
    UNSIGNED1 clean_contact_address_rec_type_Invalid;
    UNSIGNED1 clean_contact_address_fips_state_Invalid;
    UNSIGNED1 clean_contact_address_fips_county_Invalid;
    UNSIGNED1 clean_contact_address_geo_lat_Invalid;
    UNSIGNED1 clean_contact_address_geo_long_Invalid;
    UNSIGNED1 clean_contact_address_msa_Invalid;
    UNSIGNED1 clean_contact_address_geo_blk_Invalid;
    UNSIGNED1 clean_contact_address_geo_match_Invalid;
    UNSIGNED1 clean_contact_address_err_stat_Invalid;
    UNSIGNED1 clean_dates_entrydate_Invalid;
    UNSIGNED1 clean_dates_lastupdate_Invalid;
    UNSIGNED1 clean_phones_officephone_Invalid;
    UNSIGNED1 clean_phones_directdial_Invalid;
    UNSIGNED1 clean_phones_mobilephone_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Contacts_Layout_Sheila_Greco)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsBits2;
  END;
  EXPORT Rule_Layout := RECORD(Contacts_Layout_Sheila_Greco)
    STRING Rules {MAXLENGTH(1000)};
  END;
  SHARED toRuleDesc(UNSIGNED c) := CHOOSE(c
          ,'dt_first_seen:Invalid_Date:CUSTOM'
          ,'dt_last_seen:Invalid_Date:CUSTOM'
          ,'dt_vendor_first_reported:Invalid_Date:CUSTOM'
          ,'dt_vendor_last_reported:Invalid_Date:CUSTOM'
          ,'record_type:Invalid_AlphaCaps:ALLOW'
          ,'rawfields_maincontactid:Invalid_No:ALLOW'
          ,'rawfields_maincompanyid:Invalid_No:ALLOW'
          ,'rawfields_active:Invalid_No:ALLOW'
          ,'rawfields_firstname:Invalid_Alpha:ALLOW'
          ,'rawfields_midinital:Invalid_Alpha:ALLOW'
          ,'rawfields_lastname:Invalid_Alpha:ALLOW'
          ,'rawfields_age:Invalid_No:ALLOW'
          ,'rawfields_gender:Invalid_AlphaCaps:ALLOW'
          ,'rawfields_primarytitle:Invalid_AlphaChar:ALLOW'
          ,'rawfields_titlelevel1:Invalid_No:ALLOW'
          ,'rawfields_primarydept:Invalid_AlphaChar:ALLOW'
          ,'rawfields_secondtitle:Invalid_AlphaChar:ALLOW'
          ,'rawfields_titlelevel2:Invalid_No:ALLOW'
          ,'rawfields_seconddept:Invalid_AlphaChar:ALLOW'
          ,'rawfields_thirdtitle:Invalid_AlphaChar:ALLOW'
          ,'rawfields_titlelevel3:Invalid_No:ALLOW'
          ,'rawfields_thirddept:Invalid_AlphaChar:ALLOW'
          ,'rawfields_skillcategory:Invalid_AlphaChar:ALLOW'
          ,'rawfields_skillsubcategory:Invalid_AlphaChar:ALLOW'
          ,'rawfields_reportto:Invalid_Alpha:ALLOW'
          ,'rawfields_officephone:Invalid_Float:ALLOW'
          ,'rawfields_officeext:Invalid_Float:ALLOW'
          ,'rawfields_officefax:Invalid_Float:ALLOW'
          ,'rawfields_officeemail:Invalid_AlphaChar:ALLOW'
          ,'rawfields_directdial:Invalid_Float:ALLOW'
          ,'rawfields_mobilephone:Invalid_Float:ALLOW'
          ,'rawfields_officeaddress1:Invalid_AlphaNumChar:ALLOW'
          ,'rawfields_officeaddress2:Invalid_AlphaNumChar:ALLOW'
          ,'rawfields_officecity:Invalid_Alpha:ALLOW'
          ,'rawfields_officestate:Invalid_State:ALLOW','rawfields_officestate:Invalid_State:LENGTHS'
          ,'rawfields_officezip:Invalid_Zip:ALLOW','rawfields_officezip:Invalid_Zip:LENGTHS'
          ,'rawfields_officecountry:Invalid_AlphaCaps:ALLOW'
          ,'rawfields_school:Invalid_Alpha:ALLOW'
          ,'rawfields_degree:Invalid_Alpha:ALLOW'
          ,'rawfields_graduationyear:Invalid_No:ALLOW'
          ,'rawfields_country:Invalid_AlphaCaps:ALLOW'
          ,'rawfields_salary:Invalid_Float:ALLOW'
          ,'rawfields_bonus:Invalid_Float:ALLOW'
          ,'rawfields_compensation:Invalid_Float:ALLOW'
          ,'rawfields_citizenship:Invalid_AlphaCaps:ALLOW'
          ,'rawfields_diversitycandidate:Invalid_Alpha:ALLOW'
          ,'rawfields_entrydate:Invalid_Date:CUSTOM'
          ,'rawfields_lastupdate:Invalid_Date:CUSTOM'
          ,'clean_contact_name_title:Invalid_AlphaCaps:ALLOW'
          ,'clean_contact_name_fname:Invalid_AlphaCaps:ALLOW'
          ,'clean_contact_name_mname:Invalid_AlphaCaps:ALLOW'
          ,'clean_contact_name_lname:Invalid_AlphaCaps:ALLOW'
          ,'clean_contact_name_name_suffix:Invalid_AlphaCaps:ALLOW'
          ,'clean_contact_name_name_score:Invalid_No:ALLOW'
          ,'clean_contact_address_prim_range:Invalid_No:ALLOW'
          ,'clean_contact_address_predir:Invalid_AlphaCaps:ALLOW'
          ,'clean_contact_address_prim_name:Invalid_AlphaNum:ALLOW'
          ,'clean_contact_address_addr_suffix:Invalid_AlphaCaps:ALLOW'
          ,'clean_contact_address_postdir:Invalid_AlphaCaps:ALLOW'
          ,'clean_contact_address_unit_desig:Invalid_AlphaCaps:ALLOW'
          ,'clean_contact_address_sec_range:Invalid_No:ALLOW'
          ,'clean_contact_address_p_city_name:Invalid_AlphaCaps:ALLOW'
          ,'clean_contact_address_v_city_name:Invalid_AlphaCaps:ALLOW'
          ,'clean_contact_address_st:Invalid_State:ALLOW','clean_contact_address_st:Invalid_State:LENGTHS'
          ,'clean_contact_address_zip:Invalid_Zip:ALLOW','clean_contact_address_zip:Invalid_Zip:LENGTHS'
          ,'clean_contact_address_zip4:Invalid_No:ALLOW'
          ,'clean_contact_address_cart:Invalid_AlphaNum:ALLOW'
          ,'clean_contact_address_cr_sort_sz:Invalid_AlphaCaps:ALLOW'
          ,'clean_contact_address_lot:Invalid_No:ALLOW'
          ,'clean_contact_address_lot_order:Invalid_AlphaCaps:ALLOW'
          ,'clean_contact_address_dbpc:Invalid_No:ALLOW'
          ,'clean_contact_address_chk_digit:Invalid_No:ALLOW'
          ,'clean_contact_address_rec_type:Invalid_AlphaCaps:ALLOW'
          ,'clean_contact_address_fips_state:Invalid_No:ALLOW'
          ,'clean_contact_address_fips_county:Invalid_No:ALLOW'
          ,'clean_contact_address_geo_lat:Invalid_Float:ALLOW'
          ,'clean_contact_address_geo_long:Invalid_Float:ALLOW'
          ,'clean_contact_address_msa:Invalid_No:ALLOW'
          ,'clean_contact_address_geo_blk:Invalid_No:ALLOW'
          ,'clean_contact_address_geo_match:Invalid_No:ALLOW'
          ,'clean_contact_address_err_stat:Invalid_AlphaNum:ALLOW'
          ,'clean_dates_entrydate:Invalid_Date:CUSTOM'
          ,'clean_dates_lastupdate:Invalid_Date:CUSTOM'
          ,'clean_phones_officephone:Invalid_Float:ALLOW'
          ,'clean_phones_directdial:Invalid_Float:ALLOW'
          ,'clean_phones_mobilephone:Invalid_Float:ALLOW'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
  SHARED toErrorMessage(UNSIGNED c) := CHOOSE(c
          ,Contacts_Fields.InvalidMessage_dt_first_seen(1)
          ,Contacts_Fields.InvalidMessage_dt_last_seen(1)
          ,Contacts_Fields.InvalidMessage_dt_vendor_first_reported(1)
          ,Contacts_Fields.InvalidMessage_dt_vendor_last_reported(1)
          ,Contacts_Fields.InvalidMessage_record_type(1)
          ,Contacts_Fields.InvalidMessage_rawfields_maincontactid(1)
          ,Contacts_Fields.InvalidMessage_rawfields_maincompanyid(1)
          ,Contacts_Fields.InvalidMessage_rawfields_active(1)
          ,Contacts_Fields.InvalidMessage_rawfields_firstname(1)
          ,Contacts_Fields.InvalidMessage_rawfields_midinital(1)
          ,Contacts_Fields.InvalidMessage_rawfields_lastname(1)
          ,Contacts_Fields.InvalidMessage_rawfields_age(1)
          ,Contacts_Fields.InvalidMessage_rawfields_gender(1)
          ,Contacts_Fields.InvalidMessage_rawfields_primarytitle(1)
          ,Contacts_Fields.InvalidMessage_rawfields_titlelevel1(1)
          ,Contacts_Fields.InvalidMessage_rawfields_primarydept(1)
          ,Contacts_Fields.InvalidMessage_rawfields_secondtitle(1)
          ,Contacts_Fields.InvalidMessage_rawfields_titlelevel2(1)
          ,Contacts_Fields.InvalidMessage_rawfields_seconddept(1)
          ,Contacts_Fields.InvalidMessage_rawfields_thirdtitle(1)
          ,Contacts_Fields.InvalidMessage_rawfields_titlelevel3(1)
          ,Contacts_Fields.InvalidMessage_rawfields_thirddept(1)
          ,Contacts_Fields.InvalidMessage_rawfields_skillcategory(1)
          ,Contacts_Fields.InvalidMessage_rawfields_skillsubcategory(1)
          ,Contacts_Fields.InvalidMessage_rawfields_reportto(1)
          ,Contacts_Fields.InvalidMessage_rawfields_officephone(1)
          ,Contacts_Fields.InvalidMessage_rawfields_officeext(1)
          ,Contacts_Fields.InvalidMessage_rawfields_officefax(1)
          ,Contacts_Fields.InvalidMessage_rawfields_officeemail(1)
          ,Contacts_Fields.InvalidMessage_rawfields_directdial(1)
          ,Contacts_Fields.InvalidMessage_rawfields_mobilephone(1)
          ,Contacts_Fields.InvalidMessage_rawfields_officeaddress1(1)
          ,Contacts_Fields.InvalidMessage_rawfields_officeaddress2(1)
          ,Contacts_Fields.InvalidMessage_rawfields_officecity(1)
          ,Contacts_Fields.InvalidMessage_rawfields_officestate(1),Contacts_Fields.InvalidMessage_rawfields_officestate(2)
          ,Contacts_Fields.InvalidMessage_rawfields_officezip(1),Contacts_Fields.InvalidMessage_rawfields_officezip(2)
          ,Contacts_Fields.InvalidMessage_rawfields_officecountry(1)
          ,Contacts_Fields.InvalidMessage_rawfields_school(1)
          ,Contacts_Fields.InvalidMessage_rawfields_degree(1)
          ,Contacts_Fields.InvalidMessage_rawfields_graduationyear(1)
          ,Contacts_Fields.InvalidMessage_rawfields_country(1)
          ,Contacts_Fields.InvalidMessage_rawfields_salary(1)
          ,Contacts_Fields.InvalidMessage_rawfields_bonus(1)
          ,Contacts_Fields.InvalidMessage_rawfields_compensation(1)
          ,Contacts_Fields.InvalidMessage_rawfields_citizenship(1)
          ,Contacts_Fields.InvalidMessage_rawfields_diversitycandidate(1)
          ,Contacts_Fields.InvalidMessage_rawfields_entrydate(1)
          ,Contacts_Fields.InvalidMessage_rawfields_lastupdate(1)
          ,Contacts_Fields.InvalidMessage_clean_contact_name_title(1)
          ,Contacts_Fields.InvalidMessage_clean_contact_name_fname(1)
          ,Contacts_Fields.InvalidMessage_clean_contact_name_mname(1)
          ,Contacts_Fields.InvalidMessage_clean_contact_name_lname(1)
          ,Contacts_Fields.InvalidMessage_clean_contact_name_name_suffix(1)
          ,Contacts_Fields.InvalidMessage_clean_contact_name_name_score(1)
          ,Contacts_Fields.InvalidMessage_clean_contact_address_prim_range(1)
          ,Contacts_Fields.InvalidMessage_clean_contact_address_predir(1)
          ,Contacts_Fields.InvalidMessage_clean_contact_address_prim_name(1)
          ,Contacts_Fields.InvalidMessage_clean_contact_address_addr_suffix(1)
          ,Contacts_Fields.InvalidMessage_clean_contact_address_postdir(1)
          ,Contacts_Fields.InvalidMessage_clean_contact_address_unit_desig(1)
          ,Contacts_Fields.InvalidMessage_clean_contact_address_sec_range(1)
          ,Contacts_Fields.InvalidMessage_clean_contact_address_p_city_name(1)
          ,Contacts_Fields.InvalidMessage_clean_contact_address_v_city_name(1)
          ,Contacts_Fields.InvalidMessage_clean_contact_address_st(1),Contacts_Fields.InvalidMessage_clean_contact_address_st(2)
          ,Contacts_Fields.InvalidMessage_clean_contact_address_zip(1),Contacts_Fields.InvalidMessage_clean_contact_address_zip(2)
          ,Contacts_Fields.InvalidMessage_clean_contact_address_zip4(1)
          ,Contacts_Fields.InvalidMessage_clean_contact_address_cart(1)
          ,Contacts_Fields.InvalidMessage_clean_contact_address_cr_sort_sz(1)
          ,Contacts_Fields.InvalidMessage_clean_contact_address_lot(1)
          ,Contacts_Fields.InvalidMessage_clean_contact_address_lot_order(1)
          ,Contacts_Fields.InvalidMessage_clean_contact_address_dbpc(1)
          ,Contacts_Fields.InvalidMessage_clean_contact_address_chk_digit(1)
          ,Contacts_Fields.InvalidMessage_clean_contact_address_rec_type(1)
          ,Contacts_Fields.InvalidMessage_clean_contact_address_fips_state(1)
          ,Contacts_Fields.InvalidMessage_clean_contact_address_fips_county(1)
          ,Contacts_Fields.InvalidMessage_clean_contact_address_geo_lat(1)
          ,Contacts_Fields.InvalidMessage_clean_contact_address_geo_long(1)
          ,Contacts_Fields.InvalidMessage_clean_contact_address_msa(1)
          ,Contacts_Fields.InvalidMessage_clean_contact_address_geo_blk(1)
          ,Contacts_Fields.InvalidMessage_clean_contact_address_geo_match(1)
          ,Contacts_Fields.InvalidMessage_clean_contact_address_err_stat(1)
          ,Contacts_Fields.InvalidMessage_clean_dates_entrydate(1)
          ,Contacts_Fields.InvalidMessage_clean_dates_lastupdate(1)
          ,Contacts_Fields.InvalidMessage_clean_phones_officephone(1)
          ,Contacts_Fields.InvalidMessage_clean_phones_directdial(1)
          ,Contacts_Fields.InvalidMessage_clean_phones_mobilephone(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
EXPORT FromNone(DATASET(Contacts_Layout_Sheila_Greco) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.dt_first_seen_Invalid := Contacts_Fields.InValid_dt_first_seen((SALT311.StrType)le.dt_first_seen);
    SELF.dt_last_seen_Invalid := Contacts_Fields.InValid_dt_last_seen((SALT311.StrType)le.dt_last_seen);
    SELF.dt_vendor_first_reported_Invalid := Contacts_Fields.InValid_dt_vendor_first_reported((SALT311.StrType)le.dt_vendor_first_reported);
    SELF.dt_vendor_last_reported_Invalid := Contacts_Fields.InValid_dt_vendor_last_reported((SALT311.StrType)le.dt_vendor_last_reported);
    SELF.record_type_Invalid := Contacts_Fields.InValid_record_type((SALT311.StrType)le.record_type);
    SELF.rawfields_maincontactid_Invalid := Contacts_Fields.InValid_rawfields_maincontactid((SALT311.StrType)le.rawfields_maincontactid);
    SELF.rawfields_maincompanyid_Invalid := Contacts_Fields.InValid_rawfields_maincompanyid((SALT311.StrType)le.rawfields_maincompanyid);
    SELF.rawfields_active_Invalid := Contacts_Fields.InValid_rawfields_active((SALT311.StrType)le.rawfields_active);
    SELF.rawfields_firstname_Invalid := Contacts_Fields.InValid_rawfields_firstname((SALT311.StrType)le.rawfields_firstname);
    SELF.rawfields_midinital_Invalid := Contacts_Fields.InValid_rawfields_midinital((SALT311.StrType)le.rawfields_midinital);
    SELF.rawfields_lastname_Invalid := Contacts_Fields.InValid_rawfields_lastname((SALT311.StrType)le.rawfields_lastname);
    SELF.rawfields_age_Invalid := Contacts_Fields.InValid_rawfields_age((SALT311.StrType)le.rawfields_age);
    SELF.rawfields_gender_Invalid := Contacts_Fields.InValid_rawfields_gender((SALT311.StrType)le.rawfields_gender);
    SELF.rawfields_primarytitle_Invalid := Contacts_Fields.InValid_rawfields_primarytitle((SALT311.StrType)le.rawfields_primarytitle);
    SELF.rawfields_titlelevel1_Invalid := Contacts_Fields.InValid_rawfields_titlelevel1((SALT311.StrType)le.rawfields_titlelevel1);
    SELF.rawfields_primarydept_Invalid := Contacts_Fields.InValid_rawfields_primarydept((SALT311.StrType)le.rawfields_primarydept);
    SELF.rawfields_secondtitle_Invalid := Contacts_Fields.InValid_rawfields_secondtitle((SALT311.StrType)le.rawfields_secondtitle);
    SELF.rawfields_titlelevel2_Invalid := Contacts_Fields.InValid_rawfields_titlelevel2((SALT311.StrType)le.rawfields_titlelevel2);
    SELF.rawfields_seconddept_Invalid := Contacts_Fields.InValid_rawfields_seconddept((SALT311.StrType)le.rawfields_seconddept);
    SELF.rawfields_thirdtitle_Invalid := Contacts_Fields.InValid_rawfields_thirdtitle((SALT311.StrType)le.rawfields_thirdtitle);
    SELF.rawfields_titlelevel3_Invalid := Contacts_Fields.InValid_rawfields_titlelevel3((SALT311.StrType)le.rawfields_titlelevel3);
    SELF.rawfields_thirddept_Invalid := Contacts_Fields.InValid_rawfields_thirddept((SALT311.StrType)le.rawfields_thirddept);
    SELF.rawfields_skillcategory_Invalid := Contacts_Fields.InValid_rawfields_skillcategory((SALT311.StrType)le.rawfields_skillcategory);
    SELF.rawfields_skillsubcategory_Invalid := Contacts_Fields.InValid_rawfields_skillsubcategory((SALT311.StrType)le.rawfields_skillsubcategory);
    SELF.rawfields_reportto_Invalid := Contacts_Fields.InValid_rawfields_reportto((SALT311.StrType)le.rawfields_reportto);
    SELF.rawfields_officephone_Invalid := Contacts_Fields.InValid_rawfields_officephone((SALT311.StrType)le.rawfields_officephone);
    SELF.rawfields_officeext_Invalid := Contacts_Fields.InValid_rawfields_officeext((SALT311.StrType)le.rawfields_officeext);
    SELF.rawfields_officefax_Invalid := Contacts_Fields.InValid_rawfields_officefax((SALT311.StrType)le.rawfields_officefax);
    SELF.rawfields_officeemail_Invalid := Contacts_Fields.InValid_rawfields_officeemail((SALT311.StrType)le.rawfields_officeemail);
    SELF.rawfields_directdial_Invalid := Contacts_Fields.InValid_rawfields_directdial((SALT311.StrType)le.rawfields_directdial);
    SELF.rawfields_mobilephone_Invalid := Contacts_Fields.InValid_rawfields_mobilephone((SALT311.StrType)le.rawfields_mobilephone);
    SELF.rawfields_officeaddress1_Invalid := Contacts_Fields.InValid_rawfields_officeaddress1((SALT311.StrType)le.rawfields_officeaddress1);
    SELF.rawfields_officeaddress2_Invalid := Contacts_Fields.InValid_rawfields_officeaddress2((SALT311.StrType)le.rawfields_officeaddress2);
    SELF.rawfields_officecity_Invalid := Contacts_Fields.InValid_rawfields_officecity((SALT311.StrType)le.rawfields_officecity);
    SELF.rawfields_officestate_Invalid := Contacts_Fields.InValid_rawfields_officestate((SALT311.StrType)le.rawfields_officestate);
    SELF.rawfields_officezip_Invalid := Contacts_Fields.InValid_rawfields_officezip((SALT311.StrType)le.rawfields_officezip);
    SELF.rawfields_officecountry_Invalid := Contacts_Fields.InValid_rawfields_officecountry((SALT311.StrType)le.rawfields_officecountry);
    SELF.rawfields_school_Invalid := Contacts_Fields.InValid_rawfields_school((SALT311.StrType)le.rawfields_school);
    SELF.rawfields_degree_Invalid := Contacts_Fields.InValid_rawfields_degree((SALT311.StrType)le.rawfields_degree);
    SELF.rawfields_graduationyear_Invalid := Contacts_Fields.InValid_rawfields_graduationyear((SALT311.StrType)le.rawfields_graduationyear);
    SELF.rawfields_country_Invalid := Contacts_Fields.InValid_rawfields_country((SALT311.StrType)le.rawfields_country);
    SELF.rawfields_salary_Invalid := Contacts_Fields.InValid_rawfields_salary((SALT311.StrType)le.rawfields_salary);
    SELF.rawfields_bonus_Invalid := Contacts_Fields.InValid_rawfields_bonus((SALT311.StrType)le.rawfields_bonus);
    SELF.rawfields_compensation_Invalid := Contacts_Fields.InValid_rawfields_compensation((SALT311.StrType)le.rawfields_compensation);
    SELF.rawfields_citizenship_Invalid := Contacts_Fields.InValid_rawfields_citizenship((SALT311.StrType)le.rawfields_citizenship);
    SELF.rawfields_diversitycandidate_Invalid := Contacts_Fields.InValid_rawfields_diversitycandidate((SALT311.StrType)le.rawfields_diversitycandidate);
    SELF.rawfields_entrydate_Invalid := Contacts_Fields.InValid_rawfields_entrydate((SALT311.StrType)le.rawfields_entrydate);
    SELF.rawfields_lastupdate_Invalid := Contacts_Fields.InValid_rawfields_lastupdate((SALT311.StrType)le.rawfields_lastupdate);
    SELF.clean_contact_name_title_Invalid := Contacts_Fields.InValid_clean_contact_name_title((SALT311.StrType)le.clean_contact_name_title);
    SELF.clean_contact_name_fname_Invalid := Contacts_Fields.InValid_clean_contact_name_fname((SALT311.StrType)le.clean_contact_name_fname);
    SELF.clean_contact_name_mname_Invalid := Contacts_Fields.InValid_clean_contact_name_mname((SALT311.StrType)le.clean_contact_name_mname);
    SELF.clean_contact_name_lname_Invalid := Contacts_Fields.InValid_clean_contact_name_lname((SALT311.StrType)le.clean_contact_name_lname);
    SELF.clean_contact_name_name_suffix_Invalid := Contacts_Fields.InValid_clean_contact_name_name_suffix((SALT311.StrType)le.clean_contact_name_name_suffix);
    SELF.clean_contact_name_name_score_Invalid := Contacts_Fields.InValid_clean_contact_name_name_score((SALT311.StrType)le.clean_contact_name_name_score);
    SELF.clean_contact_address_prim_range_Invalid := Contacts_Fields.InValid_clean_contact_address_prim_range((SALT311.StrType)le.clean_contact_address_prim_range);
    SELF.clean_contact_address_predir_Invalid := Contacts_Fields.InValid_clean_contact_address_predir((SALT311.StrType)le.clean_contact_address_predir);
    SELF.clean_contact_address_prim_name_Invalid := Contacts_Fields.InValid_clean_contact_address_prim_name((SALT311.StrType)le.clean_contact_address_prim_name);
    SELF.clean_contact_address_addr_suffix_Invalid := Contacts_Fields.InValid_clean_contact_address_addr_suffix((SALT311.StrType)le.clean_contact_address_addr_suffix);
    SELF.clean_contact_address_postdir_Invalid := Contacts_Fields.InValid_clean_contact_address_postdir((SALT311.StrType)le.clean_contact_address_postdir);
    SELF.clean_contact_address_unit_desig_Invalid := Contacts_Fields.InValid_clean_contact_address_unit_desig((SALT311.StrType)le.clean_contact_address_unit_desig);
    SELF.clean_contact_address_sec_range_Invalid := Contacts_Fields.InValid_clean_contact_address_sec_range((SALT311.StrType)le.clean_contact_address_sec_range);
    SELF.clean_contact_address_p_city_name_Invalid := Contacts_Fields.InValid_clean_contact_address_p_city_name((SALT311.StrType)le.clean_contact_address_p_city_name);
    SELF.clean_contact_address_v_city_name_Invalid := Contacts_Fields.InValid_clean_contact_address_v_city_name((SALT311.StrType)le.clean_contact_address_v_city_name);
    SELF.clean_contact_address_st_Invalid := Contacts_Fields.InValid_clean_contact_address_st((SALT311.StrType)le.clean_contact_address_st);
    SELF.clean_contact_address_zip_Invalid := Contacts_Fields.InValid_clean_contact_address_zip((SALT311.StrType)le.clean_contact_address_zip);
    SELF.clean_contact_address_zip4_Invalid := Contacts_Fields.InValid_clean_contact_address_zip4((SALT311.StrType)le.clean_contact_address_zip4);
    SELF.clean_contact_address_cart_Invalid := Contacts_Fields.InValid_clean_contact_address_cart((SALT311.StrType)le.clean_contact_address_cart);
    SELF.clean_contact_address_cr_sort_sz_Invalid := Contacts_Fields.InValid_clean_contact_address_cr_sort_sz((SALT311.StrType)le.clean_contact_address_cr_sort_sz);
    SELF.clean_contact_address_lot_Invalid := Contacts_Fields.InValid_clean_contact_address_lot((SALT311.StrType)le.clean_contact_address_lot);
    SELF.clean_contact_address_lot_order_Invalid := Contacts_Fields.InValid_clean_contact_address_lot_order((SALT311.StrType)le.clean_contact_address_lot_order);
    SELF.clean_contact_address_dbpc_Invalid := Contacts_Fields.InValid_clean_contact_address_dbpc((SALT311.StrType)le.clean_contact_address_dbpc);
    SELF.clean_contact_address_chk_digit_Invalid := Contacts_Fields.InValid_clean_contact_address_chk_digit((SALT311.StrType)le.clean_contact_address_chk_digit);
    SELF.clean_contact_address_rec_type_Invalid := Contacts_Fields.InValid_clean_contact_address_rec_type((SALT311.StrType)le.clean_contact_address_rec_type);
    SELF.clean_contact_address_fips_state_Invalid := Contacts_Fields.InValid_clean_contact_address_fips_state((SALT311.StrType)le.clean_contact_address_fips_state);
    SELF.clean_contact_address_fips_county_Invalid := Contacts_Fields.InValid_clean_contact_address_fips_county((SALT311.StrType)le.clean_contact_address_fips_county);
    SELF.clean_contact_address_geo_lat_Invalid := Contacts_Fields.InValid_clean_contact_address_geo_lat((SALT311.StrType)le.clean_contact_address_geo_lat);
    SELF.clean_contact_address_geo_long_Invalid := Contacts_Fields.InValid_clean_contact_address_geo_long((SALT311.StrType)le.clean_contact_address_geo_long);
    SELF.clean_contact_address_msa_Invalid := Contacts_Fields.InValid_clean_contact_address_msa((SALT311.StrType)le.clean_contact_address_msa);
    SELF.clean_contact_address_geo_blk_Invalid := Contacts_Fields.InValid_clean_contact_address_geo_blk((SALT311.StrType)le.clean_contact_address_geo_blk);
    SELF.clean_contact_address_geo_match_Invalid := Contacts_Fields.InValid_clean_contact_address_geo_match((SALT311.StrType)le.clean_contact_address_geo_match);
    SELF.clean_contact_address_err_stat_Invalid := Contacts_Fields.InValid_clean_contact_address_err_stat((SALT311.StrType)le.clean_contact_address_err_stat);
    SELF.clean_dates_entrydate_Invalid := Contacts_Fields.InValid_clean_dates_entrydate((SALT311.StrType)le.clean_dates_entrydate);
    SELF.clean_dates_lastupdate_Invalid := Contacts_Fields.InValid_clean_dates_lastupdate((SALT311.StrType)le.clean_dates_lastupdate);
    SELF.clean_phones_officephone_Invalid := Contacts_Fields.InValid_clean_phones_officephone((SALT311.StrType)le.clean_phones_officephone);
    SELF.clean_phones_directdial_Invalid := Contacts_Fields.InValid_clean_phones_directdial((SALT311.StrType)le.clean_phones_directdial);
    SELF.clean_phones_mobilephone_Invalid := Contacts_Fields.InValid_clean_phones_mobilephone((SALT311.StrType)le.clean_phones_mobilephone);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Contacts_Layout_Sheila_Greco);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.dt_first_seen_Invalid << 0 ) + ( le.dt_last_seen_Invalid << 1 ) + ( le.dt_vendor_first_reported_Invalid << 2 ) + ( le.dt_vendor_last_reported_Invalid << 3 ) + ( le.record_type_Invalid << 4 ) + ( le.rawfields_maincontactid_Invalid << 5 ) + ( le.rawfields_maincompanyid_Invalid << 6 ) + ( le.rawfields_active_Invalid << 7 ) + ( le.rawfields_firstname_Invalid << 8 ) + ( le.rawfields_midinital_Invalid << 9 ) + ( le.rawfields_lastname_Invalid << 10 ) + ( le.rawfields_age_Invalid << 11 ) + ( le.rawfields_gender_Invalid << 12 ) + ( le.rawfields_primarytitle_Invalid << 13 ) + ( le.rawfields_titlelevel1_Invalid << 14 ) + ( le.rawfields_primarydept_Invalid << 15 ) + ( le.rawfields_secondtitle_Invalid << 16 ) + ( le.rawfields_titlelevel2_Invalid << 17 ) + ( le.rawfields_seconddept_Invalid << 18 ) + ( le.rawfields_thirdtitle_Invalid << 19 ) + ( le.rawfields_titlelevel3_Invalid << 20 ) + ( le.rawfields_thirddept_Invalid << 21 ) + ( le.rawfields_skillcategory_Invalid << 22 ) + ( le.rawfields_skillsubcategory_Invalid << 23 ) + ( le.rawfields_reportto_Invalid << 24 ) + ( le.rawfields_officephone_Invalid << 25 ) + ( le.rawfields_officeext_Invalid << 26 ) + ( le.rawfields_officefax_Invalid << 27 ) + ( le.rawfields_officeemail_Invalid << 28 ) + ( le.rawfields_directdial_Invalid << 29 ) + ( le.rawfields_mobilephone_Invalid << 30 ) + ( le.rawfields_officeaddress1_Invalid << 31 ) + ( le.rawfields_officeaddress2_Invalid << 32 ) + ( le.rawfields_officecity_Invalid << 33 ) + ( le.rawfields_officestate_Invalid << 34 ) + ( le.rawfields_officezip_Invalid << 36 ) + ( le.rawfields_officecountry_Invalid << 38 ) + ( le.rawfields_school_Invalid << 39 ) + ( le.rawfields_degree_Invalid << 40 ) + ( le.rawfields_graduationyear_Invalid << 41 ) + ( le.rawfields_country_Invalid << 42 ) + ( le.rawfields_salary_Invalid << 43 ) + ( le.rawfields_bonus_Invalid << 44 ) + ( le.rawfields_compensation_Invalid << 45 ) + ( le.rawfields_citizenship_Invalid << 46 ) + ( le.rawfields_diversitycandidate_Invalid << 47 ) + ( le.rawfields_entrydate_Invalid << 48 ) + ( le.rawfields_lastupdate_Invalid << 49 ) + ( le.clean_contact_name_title_Invalid << 50 ) + ( le.clean_contact_name_fname_Invalid << 51 ) + ( le.clean_contact_name_mname_Invalid << 52 ) + ( le.clean_contact_name_lname_Invalid << 53 ) + ( le.clean_contact_name_name_suffix_Invalid << 54 ) + ( le.clean_contact_name_name_score_Invalid << 55 ) + ( le.clean_contact_address_prim_range_Invalid << 56 ) + ( le.clean_contact_address_predir_Invalid << 57 ) + ( le.clean_contact_address_prim_name_Invalid << 58 ) + ( le.clean_contact_address_addr_suffix_Invalid << 59 ) + ( le.clean_contact_address_postdir_Invalid << 60 ) + ( le.clean_contact_address_unit_desig_Invalid << 61 ) + ( le.clean_contact_address_sec_range_Invalid << 62 ) + ( le.clean_contact_address_p_city_name_Invalid << 63 );
    SELF.ScrubsBits2 := ( le.clean_contact_address_v_city_name_Invalid << 0 ) + ( le.clean_contact_address_st_Invalid << 1 ) + ( le.clean_contact_address_zip_Invalid << 3 ) + ( le.clean_contact_address_zip4_Invalid << 5 ) + ( le.clean_contact_address_cart_Invalid << 6 ) + ( le.clean_contact_address_cr_sort_sz_Invalid << 7 ) + ( le.clean_contact_address_lot_Invalid << 8 ) + ( le.clean_contact_address_lot_order_Invalid << 9 ) + ( le.clean_contact_address_dbpc_Invalid << 10 ) + ( le.clean_contact_address_chk_digit_Invalid << 11 ) + ( le.clean_contact_address_rec_type_Invalid << 12 ) + ( le.clean_contact_address_fips_state_Invalid << 13 ) + ( le.clean_contact_address_fips_county_Invalid << 14 ) + ( le.clean_contact_address_geo_lat_Invalid << 15 ) + ( le.clean_contact_address_geo_long_Invalid << 16 ) + ( le.clean_contact_address_msa_Invalid << 17 ) + ( le.clean_contact_address_geo_blk_Invalid << 18 ) + ( le.clean_contact_address_geo_match_Invalid << 19 ) + ( le.clean_contact_address_err_stat_Invalid << 20 ) + ( le.clean_dates_entrydate_Invalid << 21 ) + ( le.clean_dates_lastupdate_Invalid << 22 ) + ( le.clean_phones_officephone_Invalid << 23 ) + ( le.clean_phones_directdial_Invalid << 24 ) + ( le.clean_phones_mobilephone_Invalid << 25 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
  STRING escQuotes(STRING s) := STD.Str.FindReplace(s,'\'','\\\'');
  Rule_Layout IntoRule(BitmapInfile le, UNSIGNED c) := TRANSFORM
    mask := 1<<(c-1);
    hasError := (mask&le.ScrubsBits1)>0 OR (mask&le.ScrubsBits2)>0;
    SELF.Rules := IF(hasError,TRIM(toRuleDesc(c))+':\''+escQuotes(TRIM(toErrorMessage(c)))+'\'',IF(le.ScrubsBits1=0 AND le.ScrubsBits2=0 AND c=1,'',SKIP));
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
  EXPORT Infile := PROJECT(h,Contacts_Layout_Sheila_Greco);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.dt_first_seen_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.dt_last_seen_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.dt_vendor_first_reported_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.dt_vendor_last_reported_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.record_type_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.rawfields_maincontactid_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.rawfields_maincompanyid_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.rawfields_active_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.rawfields_firstname_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.rawfields_midinital_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.rawfields_lastname_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.rawfields_age_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.rawfields_gender_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.rawfields_primarytitle_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.rawfields_titlelevel1_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.rawfields_primarydept_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.rawfields_secondtitle_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.rawfields_titlelevel2_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.rawfields_seconddept_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.rawfields_thirdtitle_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.rawfields_titlelevel3_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.rawfields_thirddept_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.rawfields_skillcategory_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.rawfields_skillsubcategory_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.rawfields_reportto_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.rawfields_officephone_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.rawfields_officeext_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.rawfields_officefax_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.rawfields_officeemail_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.rawfields_directdial_Invalid := (le.ScrubsBits1 >> 29) & 1;
    SELF.rawfields_mobilephone_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.rawfields_officeaddress1_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.rawfields_officeaddress2_Invalid := (le.ScrubsBits1 >> 32) & 1;
    SELF.rawfields_officecity_Invalid := (le.ScrubsBits1 >> 33) & 1;
    SELF.rawfields_officestate_Invalid := (le.ScrubsBits1 >> 34) & 3;
    SELF.rawfields_officezip_Invalid := (le.ScrubsBits1 >> 36) & 3;
    SELF.rawfields_officecountry_Invalid := (le.ScrubsBits1 >> 38) & 1;
    SELF.rawfields_school_Invalid := (le.ScrubsBits1 >> 39) & 1;
    SELF.rawfields_degree_Invalid := (le.ScrubsBits1 >> 40) & 1;
    SELF.rawfields_graduationyear_Invalid := (le.ScrubsBits1 >> 41) & 1;
    SELF.rawfields_country_Invalid := (le.ScrubsBits1 >> 42) & 1;
    SELF.rawfields_salary_Invalid := (le.ScrubsBits1 >> 43) & 1;
    SELF.rawfields_bonus_Invalid := (le.ScrubsBits1 >> 44) & 1;
    SELF.rawfields_compensation_Invalid := (le.ScrubsBits1 >> 45) & 1;
    SELF.rawfields_citizenship_Invalid := (le.ScrubsBits1 >> 46) & 1;
    SELF.rawfields_diversitycandidate_Invalid := (le.ScrubsBits1 >> 47) & 1;
    SELF.rawfields_entrydate_Invalid := (le.ScrubsBits1 >> 48) & 1;
    SELF.rawfields_lastupdate_Invalid := (le.ScrubsBits1 >> 49) & 1;
    SELF.clean_contact_name_title_Invalid := (le.ScrubsBits1 >> 50) & 1;
    SELF.clean_contact_name_fname_Invalid := (le.ScrubsBits1 >> 51) & 1;
    SELF.clean_contact_name_mname_Invalid := (le.ScrubsBits1 >> 52) & 1;
    SELF.clean_contact_name_lname_Invalid := (le.ScrubsBits1 >> 53) & 1;
    SELF.clean_contact_name_name_suffix_Invalid := (le.ScrubsBits1 >> 54) & 1;
    SELF.clean_contact_name_name_score_Invalid := (le.ScrubsBits1 >> 55) & 1;
    SELF.clean_contact_address_prim_range_Invalid := (le.ScrubsBits1 >> 56) & 1;
    SELF.clean_contact_address_predir_Invalid := (le.ScrubsBits1 >> 57) & 1;
    SELF.clean_contact_address_prim_name_Invalid := (le.ScrubsBits1 >> 58) & 1;
    SELF.clean_contact_address_addr_suffix_Invalid := (le.ScrubsBits1 >> 59) & 1;
    SELF.clean_contact_address_postdir_Invalid := (le.ScrubsBits1 >> 60) & 1;
    SELF.clean_contact_address_unit_desig_Invalid := (le.ScrubsBits1 >> 61) & 1;
    SELF.clean_contact_address_sec_range_Invalid := (le.ScrubsBits1 >> 62) & 1;
    SELF.clean_contact_address_p_city_name_Invalid := (le.ScrubsBits1 >> 63) & 1;
    SELF.clean_contact_address_v_city_name_Invalid := (le.ScrubsBits2 >> 0) & 1;
    SELF.clean_contact_address_st_Invalid := (le.ScrubsBits2 >> 1) & 3;
    SELF.clean_contact_address_zip_Invalid := (le.ScrubsBits2 >> 3) & 3;
    SELF.clean_contact_address_zip4_Invalid := (le.ScrubsBits2 >> 5) & 1;
    SELF.clean_contact_address_cart_Invalid := (le.ScrubsBits2 >> 6) & 1;
    SELF.clean_contact_address_cr_sort_sz_Invalid := (le.ScrubsBits2 >> 7) & 1;
    SELF.clean_contact_address_lot_Invalid := (le.ScrubsBits2 >> 8) & 1;
    SELF.clean_contact_address_lot_order_Invalid := (le.ScrubsBits2 >> 9) & 1;
    SELF.clean_contact_address_dbpc_Invalid := (le.ScrubsBits2 >> 10) & 1;
    SELF.clean_contact_address_chk_digit_Invalid := (le.ScrubsBits2 >> 11) & 1;
    SELF.clean_contact_address_rec_type_Invalid := (le.ScrubsBits2 >> 12) & 1;
    SELF.clean_contact_address_fips_state_Invalid := (le.ScrubsBits2 >> 13) & 1;
    SELF.clean_contact_address_fips_county_Invalid := (le.ScrubsBits2 >> 14) & 1;
    SELF.clean_contact_address_geo_lat_Invalid := (le.ScrubsBits2 >> 15) & 1;
    SELF.clean_contact_address_geo_long_Invalid := (le.ScrubsBits2 >> 16) & 1;
    SELF.clean_contact_address_msa_Invalid := (le.ScrubsBits2 >> 17) & 1;
    SELF.clean_contact_address_geo_blk_Invalid := (le.ScrubsBits2 >> 18) & 1;
    SELF.clean_contact_address_geo_match_Invalid := (le.ScrubsBits2 >> 19) & 1;
    SELF.clean_contact_address_err_stat_Invalid := (le.ScrubsBits2 >> 20) & 1;
    SELF.clean_dates_entrydate_Invalid := (le.ScrubsBits2 >> 21) & 1;
    SELF.clean_dates_lastupdate_Invalid := (le.ScrubsBits2 >> 22) & 1;
    SELF.clean_phones_officephone_Invalid := (le.ScrubsBits2 >> 23) & 1;
    SELF.clean_phones_directdial_Invalid := (le.ScrubsBits2 >> 24) & 1;
    SELF.clean_phones_mobilephone_Invalid := (le.ScrubsBits2 >> 25) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    dt_first_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid=1);
    dt_last_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid=1);
    dt_vendor_first_reported_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid=1);
    dt_vendor_last_reported_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid=1);
    record_type_ALLOW_ErrorCount := COUNT(GROUP,h.record_type_Invalid=1);
    rawfields_maincontactid_ALLOW_ErrorCount := COUNT(GROUP,h.rawfields_maincontactid_Invalid=1);
    rawfields_maincompanyid_ALLOW_ErrorCount := COUNT(GROUP,h.rawfields_maincompanyid_Invalid=1);
    rawfields_active_ALLOW_ErrorCount := COUNT(GROUP,h.rawfields_active_Invalid=1);
    rawfields_firstname_ALLOW_ErrorCount := COUNT(GROUP,h.rawfields_firstname_Invalid=1);
    rawfields_midinital_ALLOW_ErrorCount := COUNT(GROUP,h.rawfields_midinital_Invalid=1);
    rawfields_lastname_ALLOW_ErrorCount := COUNT(GROUP,h.rawfields_lastname_Invalid=1);
    rawfields_age_ALLOW_ErrorCount := COUNT(GROUP,h.rawfields_age_Invalid=1);
    rawfields_gender_ALLOW_ErrorCount := COUNT(GROUP,h.rawfields_gender_Invalid=1);
    rawfields_primarytitle_ALLOW_ErrorCount := COUNT(GROUP,h.rawfields_primarytitle_Invalid=1);
    rawfields_titlelevel1_ALLOW_ErrorCount := COUNT(GROUP,h.rawfields_titlelevel1_Invalid=1);
    rawfields_primarydept_ALLOW_ErrorCount := COUNT(GROUP,h.rawfields_primarydept_Invalid=1);
    rawfields_secondtitle_ALLOW_ErrorCount := COUNT(GROUP,h.rawfields_secondtitle_Invalid=1);
    rawfields_titlelevel2_ALLOW_ErrorCount := COUNT(GROUP,h.rawfields_titlelevel2_Invalid=1);
    rawfields_seconddept_ALLOW_ErrorCount := COUNT(GROUP,h.rawfields_seconddept_Invalid=1);
    rawfields_thirdtitle_ALLOW_ErrorCount := COUNT(GROUP,h.rawfields_thirdtitle_Invalid=1);
    rawfields_titlelevel3_ALLOW_ErrorCount := COUNT(GROUP,h.rawfields_titlelevel3_Invalid=1);
    rawfields_thirddept_ALLOW_ErrorCount := COUNT(GROUP,h.rawfields_thirddept_Invalid=1);
    rawfields_skillcategory_ALLOW_ErrorCount := COUNT(GROUP,h.rawfields_skillcategory_Invalid=1);
    rawfields_skillsubcategory_ALLOW_ErrorCount := COUNT(GROUP,h.rawfields_skillsubcategory_Invalid=1);
    rawfields_reportto_ALLOW_ErrorCount := COUNT(GROUP,h.rawfields_reportto_Invalid=1);
    rawfields_officephone_ALLOW_ErrorCount := COUNT(GROUP,h.rawfields_officephone_Invalid=1);
    rawfields_officeext_ALLOW_ErrorCount := COUNT(GROUP,h.rawfields_officeext_Invalid=1);
    rawfields_officefax_ALLOW_ErrorCount := COUNT(GROUP,h.rawfields_officefax_Invalid=1);
    rawfields_officeemail_ALLOW_ErrorCount := COUNT(GROUP,h.rawfields_officeemail_Invalid=1);
    rawfields_directdial_ALLOW_ErrorCount := COUNT(GROUP,h.rawfields_directdial_Invalid=1);
    rawfields_mobilephone_ALLOW_ErrorCount := COUNT(GROUP,h.rawfields_mobilephone_Invalid=1);
    rawfields_officeaddress1_ALLOW_ErrorCount := COUNT(GROUP,h.rawfields_officeaddress1_Invalid=1);
    rawfields_officeaddress2_ALLOW_ErrorCount := COUNT(GROUP,h.rawfields_officeaddress2_Invalid=1);
    rawfields_officecity_ALLOW_ErrorCount := COUNT(GROUP,h.rawfields_officecity_Invalid=1);
    rawfields_officestate_ALLOW_ErrorCount := COUNT(GROUP,h.rawfields_officestate_Invalid=1);
    rawfields_officestate_LENGTHS_ErrorCount := COUNT(GROUP,h.rawfields_officestate_Invalid=2);
    rawfields_officestate_Total_ErrorCount := COUNT(GROUP,h.rawfields_officestate_Invalid>0);
    rawfields_officezip_ALLOW_ErrorCount := COUNT(GROUP,h.rawfields_officezip_Invalid=1);
    rawfields_officezip_LENGTHS_ErrorCount := COUNT(GROUP,h.rawfields_officezip_Invalid=2);
    rawfields_officezip_Total_ErrorCount := COUNT(GROUP,h.rawfields_officezip_Invalid>0);
    rawfields_officecountry_ALLOW_ErrorCount := COUNT(GROUP,h.rawfields_officecountry_Invalid=1);
    rawfields_school_ALLOW_ErrorCount := COUNT(GROUP,h.rawfields_school_Invalid=1);
    rawfields_degree_ALLOW_ErrorCount := COUNT(GROUP,h.rawfields_degree_Invalid=1);
    rawfields_graduationyear_ALLOW_ErrorCount := COUNT(GROUP,h.rawfields_graduationyear_Invalid=1);
    rawfields_country_ALLOW_ErrorCount := COUNT(GROUP,h.rawfields_country_Invalid=1);
    rawfields_salary_ALLOW_ErrorCount := COUNT(GROUP,h.rawfields_salary_Invalid=1);
    rawfields_bonus_ALLOW_ErrorCount := COUNT(GROUP,h.rawfields_bonus_Invalid=1);
    rawfields_compensation_ALLOW_ErrorCount := COUNT(GROUP,h.rawfields_compensation_Invalid=1);
    rawfields_citizenship_ALLOW_ErrorCount := COUNT(GROUP,h.rawfields_citizenship_Invalid=1);
    rawfields_diversitycandidate_ALLOW_ErrorCount := COUNT(GROUP,h.rawfields_diversitycandidate_Invalid=1);
    rawfields_entrydate_CUSTOM_ErrorCount := COUNT(GROUP,h.rawfields_entrydate_Invalid=1);
    rawfields_lastupdate_CUSTOM_ErrorCount := COUNT(GROUP,h.rawfields_lastupdate_Invalid=1);
    clean_contact_name_title_ALLOW_ErrorCount := COUNT(GROUP,h.clean_contact_name_title_Invalid=1);
    clean_contact_name_fname_ALLOW_ErrorCount := COUNT(GROUP,h.clean_contact_name_fname_Invalid=1);
    clean_contact_name_mname_ALLOW_ErrorCount := COUNT(GROUP,h.clean_contact_name_mname_Invalid=1);
    clean_contact_name_lname_ALLOW_ErrorCount := COUNT(GROUP,h.clean_contact_name_lname_Invalid=1);
    clean_contact_name_name_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.clean_contact_name_name_suffix_Invalid=1);
    clean_contact_name_name_score_ALLOW_ErrorCount := COUNT(GROUP,h.clean_contact_name_name_score_Invalid=1);
    clean_contact_address_prim_range_ALLOW_ErrorCount := COUNT(GROUP,h.clean_contact_address_prim_range_Invalid=1);
    clean_contact_address_predir_ALLOW_ErrorCount := COUNT(GROUP,h.clean_contact_address_predir_Invalid=1);
    clean_contact_address_prim_name_ALLOW_ErrorCount := COUNT(GROUP,h.clean_contact_address_prim_name_Invalid=1);
    clean_contact_address_addr_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.clean_contact_address_addr_suffix_Invalid=1);
    clean_contact_address_postdir_ALLOW_ErrorCount := COUNT(GROUP,h.clean_contact_address_postdir_Invalid=1);
    clean_contact_address_unit_desig_ALLOW_ErrorCount := COUNT(GROUP,h.clean_contact_address_unit_desig_Invalid=1);
    clean_contact_address_sec_range_ALLOW_ErrorCount := COUNT(GROUP,h.clean_contact_address_sec_range_Invalid=1);
    clean_contact_address_p_city_name_ALLOW_ErrorCount := COUNT(GROUP,h.clean_contact_address_p_city_name_Invalid=1);
    clean_contact_address_v_city_name_ALLOW_ErrorCount := COUNT(GROUP,h.clean_contact_address_v_city_name_Invalid=1);
    clean_contact_address_st_ALLOW_ErrorCount := COUNT(GROUP,h.clean_contact_address_st_Invalid=1);
    clean_contact_address_st_LENGTHS_ErrorCount := COUNT(GROUP,h.clean_contact_address_st_Invalid=2);
    clean_contact_address_st_Total_ErrorCount := COUNT(GROUP,h.clean_contact_address_st_Invalid>0);
    clean_contact_address_zip_ALLOW_ErrorCount := COUNT(GROUP,h.clean_contact_address_zip_Invalid=1);
    clean_contact_address_zip_LENGTHS_ErrorCount := COUNT(GROUP,h.clean_contact_address_zip_Invalid=2);
    clean_contact_address_zip_Total_ErrorCount := COUNT(GROUP,h.clean_contact_address_zip_Invalid>0);
    clean_contact_address_zip4_ALLOW_ErrorCount := COUNT(GROUP,h.clean_contact_address_zip4_Invalid=1);
    clean_contact_address_cart_ALLOW_ErrorCount := COUNT(GROUP,h.clean_contact_address_cart_Invalid=1);
    clean_contact_address_cr_sort_sz_ALLOW_ErrorCount := COUNT(GROUP,h.clean_contact_address_cr_sort_sz_Invalid=1);
    clean_contact_address_lot_ALLOW_ErrorCount := COUNT(GROUP,h.clean_contact_address_lot_Invalid=1);
    clean_contact_address_lot_order_ALLOW_ErrorCount := COUNT(GROUP,h.clean_contact_address_lot_order_Invalid=1);
    clean_contact_address_dbpc_ALLOW_ErrorCount := COUNT(GROUP,h.clean_contact_address_dbpc_Invalid=1);
    clean_contact_address_chk_digit_ALLOW_ErrorCount := COUNT(GROUP,h.clean_contact_address_chk_digit_Invalid=1);
    clean_contact_address_rec_type_ALLOW_ErrorCount := COUNT(GROUP,h.clean_contact_address_rec_type_Invalid=1);
    clean_contact_address_fips_state_ALLOW_ErrorCount := COUNT(GROUP,h.clean_contact_address_fips_state_Invalid=1);
    clean_contact_address_fips_county_ALLOW_ErrorCount := COUNT(GROUP,h.clean_contact_address_fips_county_Invalid=1);
    clean_contact_address_geo_lat_ALLOW_ErrorCount := COUNT(GROUP,h.clean_contact_address_geo_lat_Invalid=1);
    clean_contact_address_geo_long_ALLOW_ErrorCount := COUNT(GROUP,h.clean_contact_address_geo_long_Invalid=1);
    clean_contact_address_msa_ALLOW_ErrorCount := COUNT(GROUP,h.clean_contact_address_msa_Invalid=1);
    clean_contact_address_geo_blk_ALLOW_ErrorCount := COUNT(GROUP,h.clean_contact_address_geo_blk_Invalid=1);
    clean_contact_address_geo_match_ALLOW_ErrorCount := COUNT(GROUP,h.clean_contact_address_geo_match_Invalid=1);
    clean_contact_address_err_stat_ALLOW_ErrorCount := COUNT(GROUP,h.clean_contact_address_err_stat_Invalid=1);
    clean_dates_entrydate_CUSTOM_ErrorCount := COUNT(GROUP,h.clean_dates_entrydate_Invalid=1);
    clean_dates_lastupdate_CUSTOM_ErrorCount := COUNT(GROUP,h.clean_dates_lastupdate_Invalid=1);
    clean_phones_officephone_ALLOW_ErrorCount := COUNT(GROUP,h.clean_phones_officephone_Invalid=1);
    clean_phones_directdial_ALLOW_ErrorCount := COUNT(GROUP,h.clean_phones_directdial_Invalid=1);
    clean_phones_mobilephone_ALLOW_ErrorCount := COUNT(GROUP,h.clean_phones_mobilephone_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.dt_first_seen_Invalid > 0 OR h.dt_last_seen_Invalid > 0 OR h.dt_vendor_first_reported_Invalid > 0 OR h.dt_vendor_last_reported_Invalid > 0 OR h.record_type_Invalid > 0 OR h.rawfields_maincontactid_Invalid > 0 OR h.rawfields_maincompanyid_Invalid > 0 OR h.rawfields_active_Invalid > 0 OR h.rawfields_firstname_Invalid > 0 OR h.rawfields_midinital_Invalid > 0 OR h.rawfields_lastname_Invalid > 0 OR h.rawfields_age_Invalid > 0 OR h.rawfields_gender_Invalid > 0 OR h.rawfields_primarytitle_Invalid > 0 OR h.rawfields_titlelevel1_Invalid > 0 OR h.rawfields_primarydept_Invalid > 0 OR h.rawfields_secondtitle_Invalid > 0 OR h.rawfields_titlelevel2_Invalid > 0 OR h.rawfields_seconddept_Invalid > 0 OR h.rawfields_thirdtitle_Invalid > 0 OR h.rawfields_titlelevel3_Invalid > 0 OR h.rawfields_thirddept_Invalid > 0 OR h.rawfields_skillcategory_Invalid > 0 OR h.rawfields_skillsubcategory_Invalid > 0 OR h.rawfields_reportto_Invalid > 0 OR h.rawfields_officephone_Invalid > 0 OR h.rawfields_officeext_Invalid > 0 OR h.rawfields_officefax_Invalid > 0 OR h.rawfields_officeemail_Invalid > 0 OR h.rawfields_directdial_Invalid > 0 OR h.rawfields_mobilephone_Invalid > 0 OR h.rawfields_officeaddress1_Invalid > 0 OR h.rawfields_officeaddress2_Invalid > 0 OR h.rawfields_officecity_Invalid > 0 OR h.rawfields_officestate_Invalid > 0 OR h.rawfields_officezip_Invalid > 0 OR h.rawfields_officecountry_Invalid > 0 OR h.rawfields_school_Invalid > 0 OR h.rawfields_degree_Invalid > 0 OR h.rawfields_graduationyear_Invalid > 0 OR h.rawfields_country_Invalid > 0 OR h.rawfields_salary_Invalid > 0 OR h.rawfields_bonus_Invalid > 0 OR h.rawfields_compensation_Invalid > 0 OR h.rawfields_citizenship_Invalid > 0 OR h.rawfields_diversitycandidate_Invalid > 0 OR h.rawfields_entrydate_Invalid > 0 OR h.rawfields_lastupdate_Invalid > 0 OR h.clean_contact_name_title_Invalid > 0 OR h.clean_contact_name_fname_Invalid > 0 OR h.clean_contact_name_mname_Invalid > 0 OR h.clean_contact_name_lname_Invalid > 0 OR h.clean_contact_name_name_suffix_Invalid > 0 OR h.clean_contact_name_name_score_Invalid > 0 OR h.clean_contact_address_prim_range_Invalid > 0 OR h.clean_contact_address_predir_Invalid > 0 OR h.clean_contact_address_prim_name_Invalid > 0 OR h.clean_contact_address_addr_suffix_Invalid > 0 OR h.clean_contact_address_postdir_Invalid > 0 OR h.clean_contact_address_unit_desig_Invalid > 0 OR h.clean_contact_address_sec_range_Invalid > 0 OR h.clean_contact_address_p_city_name_Invalid > 0 OR h.clean_contact_address_v_city_name_Invalid > 0 OR h.clean_contact_address_st_Invalid > 0 OR h.clean_contact_address_zip_Invalid > 0 OR h.clean_contact_address_zip4_Invalid > 0 OR h.clean_contact_address_cart_Invalid > 0 OR h.clean_contact_address_cr_sort_sz_Invalid > 0 OR h.clean_contact_address_lot_Invalid > 0 OR h.clean_contact_address_lot_order_Invalid > 0 OR h.clean_contact_address_dbpc_Invalid > 0 OR h.clean_contact_address_chk_digit_Invalid > 0 OR h.clean_contact_address_rec_type_Invalid > 0 OR h.clean_contact_address_fips_state_Invalid > 0 OR h.clean_contact_address_fips_county_Invalid > 0 OR h.clean_contact_address_geo_lat_Invalid > 0 OR h.clean_contact_address_geo_long_Invalid > 0 OR h.clean_contact_address_msa_Invalid > 0 OR h.clean_contact_address_geo_blk_Invalid > 0 OR h.clean_contact_address_geo_match_Invalid > 0 OR h.clean_contact_address_err_stat_Invalid > 0 OR h.clean_dates_entrydate_Invalid > 0 OR h.clean_dates_lastupdate_Invalid > 0 OR h.clean_phones_officephone_Invalid > 0 OR h.clean_phones_directdial_Invalid > 0 OR h.clean_phones_mobilephone_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.dt_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_first_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_last_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.record_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_maincontactid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_maincompanyid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_active_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_firstname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_midinital_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_lastname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_age_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_gender_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_primarytitle_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_titlelevel1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_primarydept_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_secondtitle_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_titlelevel2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_seconddept_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_thirdtitle_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_titlelevel3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_thirddept_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_skillcategory_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_skillsubcategory_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_reportto_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_officephone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_officeext_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_officefax_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_officeemail_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_directdial_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_mobilephone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_officeaddress1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_officeaddress2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_officecity_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_officestate_Total_ErrorCount > 0, 1, 0) + IF(le.rawfields_officezip_Total_ErrorCount > 0, 1, 0) + IF(le.rawfields_officecountry_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_school_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_degree_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_graduationyear_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_country_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_salary_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_bonus_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_compensation_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_citizenship_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_diversitycandidate_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_entrydate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.rawfields_lastupdate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_contact_name_title_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_contact_name_fname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_contact_name_mname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_contact_name_lname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_contact_name_name_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_contact_name_name_score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_contact_address_prim_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_contact_address_predir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_contact_address_prim_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_contact_address_addr_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_contact_address_postdir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_contact_address_unit_desig_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_contact_address_sec_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_contact_address_p_city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_contact_address_v_city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_contact_address_st_Total_ErrorCount > 0, 1, 0) + IF(le.clean_contact_address_zip_Total_ErrorCount > 0, 1, 0) + IF(le.clean_contact_address_zip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_contact_address_cart_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_contact_address_cr_sort_sz_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_contact_address_lot_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_contact_address_lot_order_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_contact_address_dbpc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_contact_address_chk_digit_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_contact_address_rec_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_contact_address_fips_state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_contact_address_fips_county_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_contact_address_geo_lat_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_contact_address_geo_long_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_contact_address_msa_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_contact_address_geo_blk_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_contact_address_geo_match_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_contact_address_err_stat_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_dates_entrydate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_dates_lastupdate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_phones_officephone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_phones_directdial_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_phones_mobilephone_ALLOW_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.dt_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_first_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_last_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.record_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_maincontactid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_maincompanyid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_active_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_firstname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_midinital_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_lastname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_age_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_gender_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_primarytitle_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_titlelevel1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_primarydept_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_secondtitle_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_titlelevel2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_seconddept_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_thirdtitle_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_titlelevel3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_thirddept_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_skillcategory_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_skillsubcategory_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_reportto_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_officephone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_officeext_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_officefax_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_officeemail_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_directdial_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_mobilephone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_officeaddress1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_officeaddress2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_officecity_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_officestate_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_officestate_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.rawfields_officezip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_officezip_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.rawfields_officecountry_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_school_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_degree_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_graduationyear_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_country_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_salary_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_bonus_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_compensation_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_citizenship_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_diversitycandidate_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_entrydate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.rawfields_lastupdate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_contact_name_title_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_contact_name_fname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_contact_name_mname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_contact_name_lname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_contact_name_name_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_contact_name_name_score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_contact_address_prim_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_contact_address_predir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_contact_address_prim_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_contact_address_addr_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_contact_address_postdir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_contact_address_unit_desig_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_contact_address_sec_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_contact_address_p_city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_contact_address_v_city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_contact_address_st_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_contact_address_st_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.clean_contact_address_zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_contact_address_zip_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.clean_contact_address_zip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_contact_address_cart_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_contact_address_cr_sort_sz_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_contact_address_lot_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_contact_address_lot_order_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_contact_address_dbpc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_contact_address_chk_digit_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_contact_address_rec_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_contact_address_fips_state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_contact_address_fips_county_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_contact_address_geo_lat_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_contact_address_geo_long_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_contact_address_msa_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_contact_address_geo_blk_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_contact_address_geo_match_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_contact_address_err_stat_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_dates_entrydate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_dates_lastupdate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_phones_officephone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_phones_directdial_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_phones_mobilephone_ALLOW_ErrorCount > 0, 1, 0);
    SELF.Rules_NoErrors := NumRules - SELF.Rules_WithErrors;
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.dt_first_seen_Invalid,le.dt_last_seen_Invalid,le.dt_vendor_first_reported_Invalid,le.dt_vendor_last_reported_Invalid,le.record_type_Invalid,le.rawfields_maincontactid_Invalid,le.rawfields_maincompanyid_Invalid,le.rawfields_active_Invalid,le.rawfields_firstname_Invalid,le.rawfields_midinital_Invalid,le.rawfields_lastname_Invalid,le.rawfields_age_Invalid,le.rawfields_gender_Invalid,le.rawfields_primarytitle_Invalid,le.rawfields_titlelevel1_Invalid,le.rawfields_primarydept_Invalid,le.rawfields_secondtitle_Invalid,le.rawfields_titlelevel2_Invalid,le.rawfields_seconddept_Invalid,le.rawfields_thirdtitle_Invalid,le.rawfields_titlelevel3_Invalid,le.rawfields_thirddept_Invalid,le.rawfields_skillcategory_Invalid,le.rawfields_skillsubcategory_Invalid,le.rawfields_reportto_Invalid,le.rawfields_officephone_Invalid,le.rawfields_officeext_Invalid,le.rawfields_officefax_Invalid,le.rawfields_officeemail_Invalid,le.rawfields_directdial_Invalid,le.rawfields_mobilephone_Invalid,le.rawfields_officeaddress1_Invalid,le.rawfields_officeaddress2_Invalid,le.rawfields_officecity_Invalid,le.rawfields_officestate_Invalid,le.rawfields_officezip_Invalid,le.rawfields_officecountry_Invalid,le.rawfields_school_Invalid,le.rawfields_degree_Invalid,le.rawfields_graduationyear_Invalid,le.rawfields_country_Invalid,le.rawfields_salary_Invalid,le.rawfields_bonus_Invalid,le.rawfields_compensation_Invalid,le.rawfields_citizenship_Invalid,le.rawfields_diversitycandidate_Invalid,le.rawfields_entrydate_Invalid,le.rawfields_lastupdate_Invalid,le.clean_contact_name_title_Invalid,le.clean_contact_name_fname_Invalid,le.clean_contact_name_mname_Invalid,le.clean_contact_name_lname_Invalid,le.clean_contact_name_name_suffix_Invalid,le.clean_contact_name_name_score_Invalid,le.clean_contact_address_prim_range_Invalid,le.clean_contact_address_predir_Invalid,le.clean_contact_address_prim_name_Invalid,le.clean_contact_address_addr_suffix_Invalid,le.clean_contact_address_postdir_Invalid,le.clean_contact_address_unit_desig_Invalid,le.clean_contact_address_sec_range_Invalid,le.clean_contact_address_p_city_name_Invalid,le.clean_contact_address_v_city_name_Invalid,le.clean_contact_address_st_Invalid,le.clean_contact_address_zip_Invalid,le.clean_contact_address_zip4_Invalid,le.clean_contact_address_cart_Invalid,le.clean_contact_address_cr_sort_sz_Invalid,le.clean_contact_address_lot_Invalid,le.clean_contact_address_lot_order_Invalid,le.clean_contact_address_dbpc_Invalid,le.clean_contact_address_chk_digit_Invalid,le.clean_contact_address_rec_type_Invalid,le.clean_contact_address_fips_state_Invalid,le.clean_contact_address_fips_county_Invalid,le.clean_contact_address_geo_lat_Invalid,le.clean_contact_address_geo_long_Invalid,le.clean_contact_address_msa_Invalid,le.clean_contact_address_geo_blk_Invalid,le.clean_contact_address_geo_match_Invalid,le.clean_contact_address_err_stat_Invalid,le.clean_dates_entrydate_Invalid,le.clean_dates_lastupdate_Invalid,le.clean_phones_officephone_Invalid,le.clean_phones_directdial_Invalid,le.clean_phones_mobilephone_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Contacts_Fields.InvalidMessage_dt_first_seen(le.dt_first_seen_Invalid),Contacts_Fields.InvalidMessage_dt_last_seen(le.dt_last_seen_Invalid),Contacts_Fields.InvalidMessage_dt_vendor_first_reported(le.dt_vendor_first_reported_Invalid),Contacts_Fields.InvalidMessage_dt_vendor_last_reported(le.dt_vendor_last_reported_Invalid),Contacts_Fields.InvalidMessage_record_type(le.record_type_Invalid),Contacts_Fields.InvalidMessage_rawfields_maincontactid(le.rawfields_maincontactid_Invalid),Contacts_Fields.InvalidMessage_rawfields_maincompanyid(le.rawfields_maincompanyid_Invalid),Contacts_Fields.InvalidMessage_rawfields_active(le.rawfields_active_Invalid),Contacts_Fields.InvalidMessage_rawfields_firstname(le.rawfields_firstname_Invalid),Contacts_Fields.InvalidMessage_rawfields_midinital(le.rawfields_midinital_Invalid),Contacts_Fields.InvalidMessage_rawfields_lastname(le.rawfields_lastname_Invalid),Contacts_Fields.InvalidMessage_rawfields_age(le.rawfields_age_Invalid),Contacts_Fields.InvalidMessage_rawfields_gender(le.rawfields_gender_Invalid),Contacts_Fields.InvalidMessage_rawfields_primarytitle(le.rawfields_primarytitle_Invalid),Contacts_Fields.InvalidMessage_rawfields_titlelevel1(le.rawfields_titlelevel1_Invalid),Contacts_Fields.InvalidMessage_rawfields_primarydept(le.rawfields_primarydept_Invalid),Contacts_Fields.InvalidMessage_rawfields_secondtitle(le.rawfields_secondtitle_Invalid),Contacts_Fields.InvalidMessage_rawfields_titlelevel2(le.rawfields_titlelevel2_Invalid),Contacts_Fields.InvalidMessage_rawfields_seconddept(le.rawfields_seconddept_Invalid),Contacts_Fields.InvalidMessage_rawfields_thirdtitle(le.rawfields_thirdtitle_Invalid),Contacts_Fields.InvalidMessage_rawfields_titlelevel3(le.rawfields_titlelevel3_Invalid),Contacts_Fields.InvalidMessage_rawfields_thirddept(le.rawfields_thirddept_Invalid),Contacts_Fields.InvalidMessage_rawfields_skillcategory(le.rawfields_skillcategory_Invalid),Contacts_Fields.InvalidMessage_rawfields_skillsubcategory(le.rawfields_skillsubcategory_Invalid),Contacts_Fields.InvalidMessage_rawfields_reportto(le.rawfields_reportto_Invalid),Contacts_Fields.InvalidMessage_rawfields_officephone(le.rawfields_officephone_Invalid),Contacts_Fields.InvalidMessage_rawfields_officeext(le.rawfields_officeext_Invalid),Contacts_Fields.InvalidMessage_rawfields_officefax(le.rawfields_officefax_Invalid),Contacts_Fields.InvalidMessage_rawfields_officeemail(le.rawfields_officeemail_Invalid),Contacts_Fields.InvalidMessage_rawfields_directdial(le.rawfields_directdial_Invalid),Contacts_Fields.InvalidMessage_rawfields_mobilephone(le.rawfields_mobilephone_Invalid),Contacts_Fields.InvalidMessage_rawfields_officeaddress1(le.rawfields_officeaddress1_Invalid),Contacts_Fields.InvalidMessage_rawfields_officeaddress2(le.rawfields_officeaddress2_Invalid),Contacts_Fields.InvalidMessage_rawfields_officecity(le.rawfields_officecity_Invalid),Contacts_Fields.InvalidMessage_rawfields_officestate(le.rawfields_officestate_Invalid),Contacts_Fields.InvalidMessage_rawfields_officezip(le.rawfields_officezip_Invalid),Contacts_Fields.InvalidMessage_rawfields_officecountry(le.rawfields_officecountry_Invalid),Contacts_Fields.InvalidMessage_rawfields_school(le.rawfields_school_Invalid),Contacts_Fields.InvalidMessage_rawfields_degree(le.rawfields_degree_Invalid),Contacts_Fields.InvalidMessage_rawfields_graduationyear(le.rawfields_graduationyear_Invalid),Contacts_Fields.InvalidMessage_rawfields_country(le.rawfields_country_Invalid),Contacts_Fields.InvalidMessage_rawfields_salary(le.rawfields_salary_Invalid),Contacts_Fields.InvalidMessage_rawfields_bonus(le.rawfields_bonus_Invalid),Contacts_Fields.InvalidMessage_rawfields_compensation(le.rawfields_compensation_Invalid),Contacts_Fields.InvalidMessage_rawfields_citizenship(le.rawfields_citizenship_Invalid),Contacts_Fields.InvalidMessage_rawfields_diversitycandidate(le.rawfields_diversitycandidate_Invalid),Contacts_Fields.InvalidMessage_rawfields_entrydate(le.rawfields_entrydate_Invalid),Contacts_Fields.InvalidMessage_rawfields_lastupdate(le.rawfields_lastupdate_Invalid),Contacts_Fields.InvalidMessage_clean_contact_name_title(le.clean_contact_name_title_Invalid),Contacts_Fields.InvalidMessage_clean_contact_name_fname(le.clean_contact_name_fname_Invalid),Contacts_Fields.InvalidMessage_clean_contact_name_mname(le.clean_contact_name_mname_Invalid),Contacts_Fields.InvalidMessage_clean_contact_name_lname(le.clean_contact_name_lname_Invalid),Contacts_Fields.InvalidMessage_clean_contact_name_name_suffix(le.clean_contact_name_name_suffix_Invalid),Contacts_Fields.InvalidMessage_clean_contact_name_name_score(le.clean_contact_name_name_score_Invalid),Contacts_Fields.InvalidMessage_clean_contact_address_prim_range(le.clean_contact_address_prim_range_Invalid),Contacts_Fields.InvalidMessage_clean_contact_address_predir(le.clean_contact_address_predir_Invalid),Contacts_Fields.InvalidMessage_clean_contact_address_prim_name(le.clean_contact_address_prim_name_Invalid),Contacts_Fields.InvalidMessage_clean_contact_address_addr_suffix(le.clean_contact_address_addr_suffix_Invalid),Contacts_Fields.InvalidMessage_clean_contact_address_postdir(le.clean_contact_address_postdir_Invalid),Contacts_Fields.InvalidMessage_clean_contact_address_unit_desig(le.clean_contact_address_unit_desig_Invalid),Contacts_Fields.InvalidMessage_clean_contact_address_sec_range(le.clean_contact_address_sec_range_Invalid),Contacts_Fields.InvalidMessage_clean_contact_address_p_city_name(le.clean_contact_address_p_city_name_Invalid),Contacts_Fields.InvalidMessage_clean_contact_address_v_city_name(le.clean_contact_address_v_city_name_Invalid),Contacts_Fields.InvalidMessage_clean_contact_address_st(le.clean_contact_address_st_Invalid),Contacts_Fields.InvalidMessage_clean_contact_address_zip(le.clean_contact_address_zip_Invalid),Contacts_Fields.InvalidMessage_clean_contact_address_zip4(le.clean_contact_address_zip4_Invalid),Contacts_Fields.InvalidMessage_clean_contact_address_cart(le.clean_contact_address_cart_Invalid),Contacts_Fields.InvalidMessage_clean_contact_address_cr_sort_sz(le.clean_contact_address_cr_sort_sz_Invalid),Contacts_Fields.InvalidMessage_clean_contact_address_lot(le.clean_contact_address_lot_Invalid),Contacts_Fields.InvalidMessage_clean_contact_address_lot_order(le.clean_contact_address_lot_order_Invalid),Contacts_Fields.InvalidMessage_clean_contact_address_dbpc(le.clean_contact_address_dbpc_Invalid),Contacts_Fields.InvalidMessage_clean_contact_address_chk_digit(le.clean_contact_address_chk_digit_Invalid),Contacts_Fields.InvalidMessage_clean_contact_address_rec_type(le.clean_contact_address_rec_type_Invalid),Contacts_Fields.InvalidMessage_clean_contact_address_fips_state(le.clean_contact_address_fips_state_Invalid),Contacts_Fields.InvalidMessage_clean_contact_address_fips_county(le.clean_contact_address_fips_county_Invalid),Contacts_Fields.InvalidMessage_clean_contact_address_geo_lat(le.clean_contact_address_geo_lat_Invalid),Contacts_Fields.InvalidMessage_clean_contact_address_geo_long(le.clean_contact_address_geo_long_Invalid),Contacts_Fields.InvalidMessage_clean_contact_address_msa(le.clean_contact_address_msa_Invalid),Contacts_Fields.InvalidMessage_clean_contact_address_geo_blk(le.clean_contact_address_geo_blk_Invalid),Contacts_Fields.InvalidMessage_clean_contact_address_geo_match(le.clean_contact_address_geo_match_Invalid),Contacts_Fields.InvalidMessage_clean_contact_address_err_stat(le.clean_contact_address_err_stat_Invalid),Contacts_Fields.InvalidMessage_clean_dates_entrydate(le.clean_dates_entrydate_Invalid),Contacts_Fields.InvalidMessage_clean_dates_lastupdate(le.clean_dates_lastupdate_Invalid),Contacts_Fields.InvalidMessage_clean_phones_officephone(le.clean_phones_officephone_Invalid),Contacts_Fields.InvalidMessage_clean_phones_directdial(le.clean_phones_directdial_Invalid),Contacts_Fields.InvalidMessage_clean_phones_mobilephone(le.clean_phones_mobilephone_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.dt_first_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dt_last_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dt_vendor_first_reported_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dt_vendor_last_reported_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.record_type_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.rawfields_maincontactid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.rawfields_maincompanyid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.rawfields_active_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.rawfields_firstname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.rawfields_midinital_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.rawfields_lastname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.rawfields_age_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.rawfields_gender_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.rawfields_primarytitle_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.rawfields_titlelevel1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.rawfields_primarydept_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.rawfields_secondtitle_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.rawfields_titlelevel2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.rawfields_seconddept_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.rawfields_thirdtitle_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.rawfields_titlelevel3_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.rawfields_thirddept_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.rawfields_skillcategory_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.rawfields_skillsubcategory_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.rawfields_reportto_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.rawfields_officephone_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.rawfields_officeext_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.rawfields_officefax_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.rawfields_officeemail_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.rawfields_directdial_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.rawfields_mobilephone_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.rawfields_officeaddress1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.rawfields_officeaddress2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.rawfields_officecity_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.rawfields_officestate_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.rawfields_officezip_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.rawfields_officecountry_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.rawfields_school_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.rawfields_degree_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.rawfields_graduationyear_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.rawfields_country_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.rawfields_salary_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.rawfields_bonus_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.rawfields_compensation_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.rawfields_citizenship_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.rawfields_diversitycandidate_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.rawfields_entrydate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.rawfields_lastupdate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.clean_contact_name_title_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_contact_name_fname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_contact_name_mname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_contact_name_lname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_contact_name_name_suffix_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_contact_name_name_score_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_contact_address_prim_range_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_contact_address_predir_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_contact_address_prim_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_contact_address_addr_suffix_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_contact_address_postdir_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_contact_address_unit_desig_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_contact_address_sec_range_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_contact_address_p_city_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_contact_address_v_city_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_contact_address_st_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.clean_contact_address_zip_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.clean_contact_address_zip4_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_contact_address_cart_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_contact_address_cr_sort_sz_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_contact_address_lot_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_contact_address_lot_order_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_contact_address_dbpc_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_contact_address_chk_digit_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_contact_address_rec_type_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_contact_address_fips_state_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_contact_address_fips_county_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_contact_address_geo_lat_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_contact_address_geo_long_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_contact_address_msa_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_contact_address_geo_blk_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_contact_address_geo_match_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_contact_address_err_stat_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_dates_entrydate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.clean_dates_lastupdate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.clean_phones_officephone_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_phones_directdial_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_phones_mobilephone_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','record_type','rawfields_maincontactid','rawfields_maincompanyid','rawfields_active','rawfields_firstname','rawfields_midinital','rawfields_lastname','rawfields_age','rawfields_gender','rawfields_primarytitle','rawfields_titlelevel1','rawfields_primarydept','rawfields_secondtitle','rawfields_titlelevel2','rawfields_seconddept','rawfields_thirdtitle','rawfields_titlelevel3','rawfields_thirddept','rawfields_skillcategory','rawfields_skillsubcategory','rawfields_reportto','rawfields_officephone','rawfields_officeext','rawfields_officefax','rawfields_officeemail','rawfields_directdial','rawfields_mobilephone','rawfields_officeaddress1','rawfields_officeaddress2','rawfields_officecity','rawfields_officestate','rawfields_officezip','rawfields_officecountry','rawfields_school','rawfields_degree','rawfields_graduationyear','rawfields_country','rawfields_salary','rawfields_bonus','rawfields_compensation','rawfields_citizenship','rawfields_diversitycandidate','rawfields_entrydate','rawfields_lastupdate','clean_contact_name_title','clean_contact_name_fname','clean_contact_name_mname','clean_contact_name_lname','clean_contact_name_name_suffix','clean_contact_name_name_score','clean_contact_address_prim_range','clean_contact_address_predir','clean_contact_address_prim_name','clean_contact_address_addr_suffix','clean_contact_address_postdir','clean_contact_address_unit_desig','clean_contact_address_sec_range','clean_contact_address_p_city_name','clean_contact_address_v_city_name','clean_contact_address_st','clean_contact_address_zip','clean_contact_address_zip4','clean_contact_address_cart','clean_contact_address_cr_sort_sz','clean_contact_address_lot','clean_contact_address_lot_order','clean_contact_address_dbpc','clean_contact_address_chk_digit','clean_contact_address_rec_type','clean_contact_address_fips_state','clean_contact_address_fips_county','clean_contact_address_geo_lat','clean_contact_address_geo_long','clean_contact_address_msa','clean_contact_address_geo_blk','clean_contact_address_geo_match','clean_contact_address_err_stat','clean_dates_entrydate','clean_dates_lastupdate','clean_phones_officephone','clean_phones_directdial','clean_phones_mobilephone','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_Date','Invalid_Date','Invalid_Date','Invalid_Date','Invalid_AlphaCaps','Invalid_No','Invalid_No','Invalid_No','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_No','Invalid_AlphaCaps','Invalid_AlphaChar','Invalid_No','Invalid_AlphaChar','Invalid_AlphaChar','Invalid_No','Invalid_AlphaChar','Invalid_AlphaChar','Invalid_No','Invalid_AlphaChar','Invalid_AlphaChar','Invalid_AlphaChar','Invalid_Alpha','Invalid_Float','Invalid_Float','Invalid_Float','Invalid_AlphaChar','Invalid_Float','Invalid_Float','Invalid_AlphaNumChar','Invalid_AlphaNumChar','Invalid_Alpha','Invalid_State','Invalid_Zip','Invalid_AlphaCaps','Invalid_Alpha','Invalid_Alpha','Invalid_No','Invalid_AlphaCaps','Invalid_Float','Invalid_Float','Invalid_Float','Invalid_AlphaCaps','Invalid_Alpha','Invalid_Date','Invalid_Date','Invalid_AlphaCaps','Invalid_AlphaCaps','Invalid_AlphaCaps','Invalid_AlphaCaps','Invalid_AlphaCaps','Invalid_No','Invalid_No','Invalid_AlphaCaps','Invalid_AlphaNum','Invalid_AlphaCaps','Invalid_AlphaCaps','Invalid_AlphaCaps','Invalid_No','Invalid_AlphaCaps','Invalid_AlphaCaps','Invalid_State','Invalid_Zip','Invalid_No','Invalid_AlphaNum','Invalid_AlphaCaps','Invalid_No','Invalid_AlphaCaps','Invalid_No','Invalid_No','Invalid_AlphaCaps','Invalid_No','Invalid_No','Invalid_Float','Invalid_Float','Invalid_No','Invalid_No','Invalid_No','Invalid_AlphaNum','Invalid_Date','Invalid_Date','Invalid_Float','Invalid_Float','Invalid_Float','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.dt_first_seen,(SALT311.StrType)le.dt_last_seen,(SALT311.StrType)le.dt_vendor_first_reported,(SALT311.StrType)le.dt_vendor_last_reported,(SALT311.StrType)le.record_type,(SALT311.StrType)le.rawfields_maincontactid,(SALT311.StrType)le.rawfields_maincompanyid,(SALT311.StrType)le.rawfields_active,(SALT311.StrType)le.rawfields_firstname,(SALT311.StrType)le.rawfields_midinital,(SALT311.StrType)le.rawfields_lastname,(SALT311.StrType)le.rawfields_age,(SALT311.StrType)le.rawfields_gender,(SALT311.StrType)le.rawfields_primarytitle,(SALT311.StrType)le.rawfields_titlelevel1,(SALT311.StrType)le.rawfields_primarydept,(SALT311.StrType)le.rawfields_secondtitle,(SALT311.StrType)le.rawfields_titlelevel2,(SALT311.StrType)le.rawfields_seconddept,(SALT311.StrType)le.rawfields_thirdtitle,(SALT311.StrType)le.rawfields_titlelevel3,(SALT311.StrType)le.rawfields_thirddept,(SALT311.StrType)le.rawfields_skillcategory,(SALT311.StrType)le.rawfields_skillsubcategory,(SALT311.StrType)le.rawfields_reportto,(SALT311.StrType)le.rawfields_officephone,(SALT311.StrType)le.rawfields_officeext,(SALT311.StrType)le.rawfields_officefax,(SALT311.StrType)le.rawfields_officeemail,(SALT311.StrType)le.rawfields_directdial,(SALT311.StrType)le.rawfields_mobilephone,(SALT311.StrType)le.rawfields_officeaddress1,(SALT311.StrType)le.rawfields_officeaddress2,(SALT311.StrType)le.rawfields_officecity,(SALT311.StrType)le.rawfields_officestate,(SALT311.StrType)le.rawfields_officezip,(SALT311.StrType)le.rawfields_officecountry,(SALT311.StrType)le.rawfields_school,(SALT311.StrType)le.rawfields_degree,(SALT311.StrType)le.rawfields_graduationyear,(SALT311.StrType)le.rawfields_country,(SALT311.StrType)le.rawfields_salary,(SALT311.StrType)le.rawfields_bonus,(SALT311.StrType)le.rawfields_compensation,(SALT311.StrType)le.rawfields_citizenship,(SALT311.StrType)le.rawfields_diversitycandidate,(SALT311.StrType)le.rawfields_entrydate,(SALT311.StrType)le.rawfields_lastupdate,(SALT311.StrType)le.clean_contact_name_title,(SALT311.StrType)le.clean_contact_name_fname,(SALT311.StrType)le.clean_contact_name_mname,(SALT311.StrType)le.clean_contact_name_lname,(SALT311.StrType)le.clean_contact_name_name_suffix,(SALT311.StrType)le.clean_contact_name_name_score,(SALT311.StrType)le.clean_contact_address_prim_range,(SALT311.StrType)le.clean_contact_address_predir,(SALT311.StrType)le.clean_contact_address_prim_name,(SALT311.StrType)le.clean_contact_address_addr_suffix,(SALT311.StrType)le.clean_contact_address_postdir,(SALT311.StrType)le.clean_contact_address_unit_desig,(SALT311.StrType)le.clean_contact_address_sec_range,(SALT311.StrType)le.clean_contact_address_p_city_name,(SALT311.StrType)le.clean_contact_address_v_city_name,(SALT311.StrType)le.clean_contact_address_st,(SALT311.StrType)le.clean_contact_address_zip,(SALT311.StrType)le.clean_contact_address_zip4,(SALT311.StrType)le.clean_contact_address_cart,(SALT311.StrType)le.clean_contact_address_cr_sort_sz,(SALT311.StrType)le.clean_contact_address_lot,(SALT311.StrType)le.clean_contact_address_lot_order,(SALT311.StrType)le.clean_contact_address_dbpc,(SALT311.StrType)le.clean_contact_address_chk_digit,(SALT311.StrType)le.clean_contact_address_rec_type,(SALT311.StrType)le.clean_contact_address_fips_state,(SALT311.StrType)le.clean_contact_address_fips_county,(SALT311.StrType)le.clean_contact_address_geo_lat,(SALT311.StrType)le.clean_contact_address_geo_long,(SALT311.StrType)le.clean_contact_address_msa,(SALT311.StrType)le.clean_contact_address_geo_blk,(SALT311.StrType)le.clean_contact_address_geo_match,(SALT311.StrType)le.clean_contact_address_err_stat,(SALT311.StrType)le.clean_dates_entrydate,(SALT311.StrType)le.clean_dates_lastupdate,(SALT311.StrType)le.clean_phones_officephone,(SALT311.StrType)le.clean_phones_directdial,(SALT311.StrType)le.clean_phones_mobilephone,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,86,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Contacts_Layout_Sheila_Greco) prevDS = DATASET([], Contacts_Layout_Sheila_Greco), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := toRuleDesc(c);
      SELF.ErrorMessage := toErrorMessage(c);
      SELF.rulecnt := CHOOSE(c
          ,le.dt_first_seen_CUSTOM_ErrorCount
          ,le.dt_last_seen_CUSTOM_ErrorCount
          ,le.dt_vendor_first_reported_CUSTOM_ErrorCount
          ,le.dt_vendor_last_reported_CUSTOM_ErrorCount
          ,le.record_type_ALLOW_ErrorCount
          ,le.rawfields_maincontactid_ALLOW_ErrorCount
          ,le.rawfields_maincompanyid_ALLOW_ErrorCount
          ,le.rawfields_active_ALLOW_ErrorCount
          ,le.rawfields_firstname_ALLOW_ErrorCount
          ,le.rawfields_midinital_ALLOW_ErrorCount
          ,le.rawfields_lastname_ALLOW_ErrorCount
          ,le.rawfields_age_ALLOW_ErrorCount
          ,le.rawfields_gender_ALLOW_ErrorCount
          ,le.rawfields_primarytitle_ALLOW_ErrorCount
          ,le.rawfields_titlelevel1_ALLOW_ErrorCount
          ,le.rawfields_primarydept_ALLOW_ErrorCount
          ,le.rawfields_secondtitle_ALLOW_ErrorCount
          ,le.rawfields_titlelevel2_ALLOW_ErrorCount
          ,le.rawfields_seconddept_ALLOW_ErrorCount
          ,le.rawfields_thirdtitle_ALLOW_ErrorCount
          ,le.rawfields_titlelevel3_ALLOW_ErrorCount
          ,le.rawfields_thirddept_ALLOW_ErrorCount
          ,le.rawfields_skillcategory_ALLOW_ErrorCount
          ,le.rawfields_skillsubcategory_ALLOW_ErrorCount
          ,le.rawfields_reportto_ALLOW_ErrorCount
          ,le.rawfields_officephone_ALLOW_ErrorCount
          ,le.rawfields_officeext_ALLOW_ErrorCount
          ,le.rawfields_officefax_ALLOW_ErrorCount
          ,le.rawfields_officeemail_ALLOW_ErrorCount
          ,le.rawfields_directdial_ALLOW_ErrorCount
          ,le.rawfields_mobilephone_ALLOW_ErrorCount
          ,le.rawfields_officeaddress1_ALLOW_ErrorCount
          ,le.rawfields_officeaddress2_ALLOW_ErrorCount
          ,le.rawfields_officecity_ALLOW_ErrorCount
          ,le.rawfields_officestate_ALLOW_ErrorCount,le.rawfields_officestate_LENGTHS_ErrorCount
          ,le.rawfields_officezip_ALLOW_ErrorCount,le.rawfields_officezip_LENGTHS_ErrorCount
          ,le.rawfields_officecountry_ALLOW_ErrorCount
          ,le.rawfields_school_ALLOW_ErrorCount
          ,le.rawfields_degree_ALLOW_ErrorCount
          ,le.rawfields_graduationyear_ALLOW_ErrorCount
          ,le.rawfields_country_ALLOW_ErrorCount
          ,le.rawfields_salary_ALLOW_ErrorCount
          ,le.rawfields_bonus_ALLOW_ErrorCount
          ,le.rawfields_compensation_ALLOW_ErrorCount
          ,le.rawfields_citizenship_ALLOW_ErrorCount
          ,le.rawfields_diversitycandidate_ALLOW_ErrorCount
          ,le.rawfields_entrydate_CUSTOM_ErrorCount
          ,le.rawfields_lastupdate_CUSTOM_ErrorCount
          ,le.clean_contact_name_title_ALLOW_ErrorCount
          ,le.clean_contact_name_fname_ALLOW_ErrorCount
          ,le.clean_contact_name_mname_ALLOW_ErrorCount
          ,le.clean_contact_name_lname_ALLOW_ErrorCount
          ,le.clean_contact_name_name_suffix_ALLOW_ErrorCount
          ,le.clean_contact_name_name_score_ALLOW_ErrorCount
          ,le.clean_contact_address_prim_range_ALLOW_ErrorCount
          ,le.clean_contact_address_predir_ALLOW_ErrorCount
          ,le.clean_contact_address_prim_name_ALLOW_ErrorCount
          ,le.clean_contact_address_addr_suffix_ALLOW_ErrorCount
          ,le.clean_contact_address_postdir_ALLOW_ErrorCount
          ,le.clean_contact_address_unit_desig_ALLOW_ErrorCount
          ,le.clean_contact_address_sec_range_ALLOW_ErrorCount
          ,le.clean_contact_address_p_city_name_ALLOW_ErrorCount
          ,le.clean_contact_address_v_city_name_ALLOW_ErrorCount
          ,le.clean_contact_address_st_ALLOW_ErrorCount,le.clean_contact_address_st_LENGTHS_ErrorCount
          ,le.clean_contact_address_zip_ALLOW_ErrorCount,le.clean_contact_address_zip_LENGTHS_ErrorCount
          ,le.clean_contact_address_zip4_ALLOW_ErrorCount
          ,le.clean_contact_address_cart_ALLOW_ErrorCount
          ,le.clean_contact_address_cr_sort_sz_ALLOW_ErrorCount
          ,le.clean_contact_address_lot_ALLOW_ErrorCount
          ,le.clean_contact_address_lot_order_ALLOW_ErrorCount
          ,le.clean_contact_address_dbpc_ALLOW_ErrorCount
          ,le.clean_contact_address_chk_digit_ALLOW_ErrorCount
          ,le.clean_contact_address_rec_type_ALLOW_ErrorCount
          ,le.clean_contact_address_fips_state_ALLOW_ErrorCount
          ,le.clean_contact_address_fips_county_ALLOW_ErrorCount
          ,le.clean_contact_address_geo_lat_ALLOW_ErrorCount
          ,le.clean_contact_address_geo_long_ALLOW_ErrorCount
          ,le.clean_contact_address_msa_ALLOW_ErrorCount
          ,le.clean_contact_address_geo_blk_ALLOW_ErrorCount
          ,le.clean_contact_address_geo_match_ALLOW_ErrorCount
          ,le.clean_contact_address_err_stat_ALLOW_ErrorCount
          ,le.clean_dates_entrydate_CUSTOM_ErrorCount
          ,le.clean_dates_lastupdate_CUSTOM_ErrorCount
          ,le.clean_phones_officephone_ALLOW_ErrorCount
          ,le.clean_phones_directdial_ALLOW_ErrorCount
          ,le.clean_phones_mobilephone_ALLOW_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.dt_first_seen_CUSTOM_ErrorCount
          ,le.dt_last_seen_CUSTOM_ErrorCount
          ,le.dt_vendor_first_reported_CUSTOM_ErrorCount
          ,le.dt_vendor_last_reported_CUSTOM_ErrorCount
          ,le.record_type_ALLOW_ErrorCount
          ,le.rawfields_maincontactid_ALLOW_ErrorCount
          ,le.rawfields_maincompanyid_ALLOW_ErrorCount
          ,le.rawfields_active_ALLOW_ErrorCount
          ,le.rawfields_firstname_ALLOW_ErrorCount
          ,le.rawfields_midinital_ALLOW_ErrorCount
          ,le.rawfields_lastname_ALLOW_ErrorCount
          ,le.rawfields_age_ALLOW_ErrorCount
          ,le.rawfields_gender_ALLOW_ErrorCount
          ,le.rawfields_primarytitle_ALLOW_ErrorCount
          ,le.rawfields_titlelevel1_ALLOW_ErrorCount
          ,le.rawfields_primarydept_ALLOW_ErrorCount
          ,le.rawfields_secondtitle_ALLOW_ErrorCount
          ,le.rawfields_titlelevel2_ALLOW_ErrorCount
          ,le.rawfields_seconddept_ALLOW_ErrorCount
          ,le.rawfields_thirdtitle_ALLOW_ErrorCount
          ,le.rawfields_titlelevel3_ALLOW_ErrorCount
          ,le.rawfields_thirddept_ALLOW_ErrorCount
          ,le.rawfields_skillcategory_ALLOW_ErrorCount
          ,le.rawfields_skillsubcategory_ALLOW_ErrorCount
          ,le.rawfields_reportto_ALLOW_ErrorCount
          ,le.rawfields_officephone_ALLOW_ErrorCount
          ,le.rawfields_officeext_ALLOW_ErrorCount
          ,le.rawfields_officefax_ALLOW_ErrorCount
          ,le.rawfields_officeemail_ALLOW_ErrorCount
          ,le.rawfields_directdial_ALLOW_ErrorCount
          ,le.rawfields_mobilephone_ALLOW_ErrorCount
          ,le.rawfields_officeaddress1_ALLOW_ErrorCount
          ,le.rawfields_officeaddress2_ALLOW_ErrorCount
          ,le.rawfields_officecity_ALLOW_ErrorCount
          ,le.rawfields_officestate_ALLOW_ErrorCount,le.rawfields_officestate_LENGTHS_ErrorCount
          ,le.rawfields_officezip_ALLOW_ErrorCount,le.rawfields_officezip_LENGTHS_ErrorCount
          ,le.rawfields_officecountry_ALLOW_ErrorCount
          ,le.rawfields_school_ALLOW_ErrorCount
          ,le.rawfields_degree_ALLOW_ErrorCount
          ,le.rawfields_graduationyear_ALLOW_ErrorCount
          ,le.rawfields_country_ALLOW_ErrorCount
          ,le.rawfields_salary_ALLOW_ErrorCount
          ,le.rawfields_bonus_ALLOW_ErrorCount
          ,le.rawfields_compensation_ALLOW_ErrorCount
          ,le.rawfields_citizenship_ALLOW_ErrorCount
          ,le.rawfields_diversitycandidate_ALLOW_ErrorCount
          ,le.rawfields_entrydate_CUSTOM_ErrorCount
          ,le.rawfields_lastupdate_CUSTOM_ErrorCount
          ,le.clean_contact_name_title_ALLOW_ErrorCount
          ,le.clean_contact_name_fname_ALLOW_ErrorCount
          ,le.clean_contact_name_mname_ALLOW_ErrorCount
          ,le.clean_contact_name_lname_ALLOW_ErrorCount
          ,le.clean_contact_name_name_suffix_ALLOW_ErrorCount
          ,le.clean_contact_name_name_score_ALLOW_ErrorCount
          ,le.clean_contact_address_prim_range_ALLOW_ErrorCount
          ,le.clean_contact_address_predir_ALLOW_ErrorCount
          ,le.clean_contact_address_prim_name_ALLOW_ErrorCount
          ,le.clean_contact_address_addr_suffix_ALLOW_ErrorCount
          ,le.clean_contact_address_postdir_ALLOW_ErrorCount
          ,le.clean_contact_address_unit_desig_ALLOW_ErrorCount
          ,le.clean_contact_address_sec_range_ALLOW_ErrorCount
          ,le.clean_contact_address_p_city_name_ALLOW_ErrorCount
          ,le.clean_contact_address_v_city_name_ALLOW_ErrorCount
          ,le.clean_contact_address_st_ALLOW_ErrorCount,le.clean_contact_address_st_LENGTHS_ErrorCount
          ,le.clean_contact_address_zip_ALLOW_ErrorCount,le.clean_contact_address_zip_LENGTHS_ErrorCount
          ,le.clean_contact_address_zip4_ALLOW_ErrorCount
          ,le.clean_contact_address_cart_ALLOW_ErrorCount
          ,le.clean_contact_address_cr_sort_sz_ALLOW_ErrorCount
          ,le.clean_contact_address_lot_ALLOW_ErrorCount
          ,le.clean_contact_address_lot_order_ALLOW_ErrorCount
          ,le.clean_contact_address_dbpc_ALLOW_ErrorCount
          ,le.clean_contact_address_chk_digit_ALLOW_ErrorCount
          ,le.clean_contact_address_rec_type_ALLOW_ErrorCount
          ,le.clean_contact_address_fips_state_ALLOW_ErrorCount
          ,le.clean_contact_address_fips_county_ALLOW_ErrorCount
          ,le.clean_contact_address_geo_lat_ALLOW_ErrorCount
          ,le.clean_contact_address_geo_long_ALLOW_ErrorCount
          ,le.clean_contact_address_msa_ALLOW_ErrorCount
          ,le.clean_contact_address_geo_blk_ALLOW_ErrorCount
          ,le.clean_contact_address_geo_match_ALLOW_ErrorCount
          ,le.clean_contact_address_err_stat_ALLOW_ErrorCount
          ,le.clean_dates_entrydate_CUSTOM_ErrorCount
          ,le.clean_dates_lastupdate_CUSTOM_ErrorCount
          ,le.clean_phones_officephone_ALLOW_ErrorCount
          ,le.clean_phones_directdial_ALLOW_ErrorCount
          ,le.clean_phones_mobilephone_ALLOW_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
          ,IF(NumFieldsWithRules = 0, 0, le.FieldsChecked_WithErrors/NumFieldsWithRules * 100)
          ,IF(NumFieldsWithRules = 0, 0, le.FieldsChecked_NoErrors/NumFieldsWithRules * 100)
          ,IF(NumRules = 0, 0, le.Rules_WithErrors/NumRules * 100)
          ,IF(NumRules = 0, 0, le.Rules_NoErrors/NumRules * 100)
          ,0
          ,IF(SELF.recordstotal = 0, 0, le.AnyRule_WithErrorsCount/SELF.recordstotal * 100)
          ,IF(SELF.recordstotal = 0, 0, (SELF.recordstotal - le.AnyRule_WithErrorsCount)/SELF.recordstotal * 100),0));
    END;
    SummaryInfo := NORMALIZE(SummaryStats,NumRules + 7,Into(LEFT,COUNTER));
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
    mod_hygiene := Contacts_hygiene(PROJECT(h, Contacts_Layout_Sheila_Greco));
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
          ,'did:' + getFieldTypeText(h.did) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'did_score:' + getFieldTypeText(h.did_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bdid:' + getFieldTypeText(h.bdid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bdid_score:' + getFieldTypeText(h.bdid_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'raw_aid:' + getFieldTypeText(h.raw_aid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ace_aid:' + getFieldTypeText(h.ace_aid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_first_seen:' + getFieldTypeText(h.dt_first_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_last_seen:' + getFieldTypeText(h.dt_last_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_vendor_first_reported:' + getFieldTypeText(h.dt_vendor_first_reported) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_vendor_last_reported:' + getFieldTypeText(h.dt_vendor_last_reported) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'record_type:' + getFieldTypeText(h.record_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_maincontactid:' + getFieldTypeText(h.rawfields_maincontactid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_maincompanyid:' + getFieldTypeText(h.rawfields_maincompanyid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_active:' + getFieldTypeText(h.rawfields_active) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_firstname:' + getFieldTypeText(h.rawfields_firstname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_midinital:' + getFieldTypeText(h.rawfields_midinital) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_lastname:' + getFieldTypeText(h.rawfields_lastname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_age:' + getFieldTypeText(h.rawfields_age) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_gender:' + getFieldTypeText(h.rawfields_gender) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_primarytitle:' + getFieldTypeText(h.rawfields_primarytitle) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_titlelevel1:' + getFieldTypeText(h.rawfields_titlelevel1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_primarydept:' + getFieldTypeText(h.rawfields_primarydept) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_secondtitle:' + getFieldTypeText(h.rawfields_secondtitle) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_titlelevel2:' + getFieldTypeText(h.rawfields_titlelevel2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_seconddept:' + getFieldTypeText(h.rawfields_seconddept) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_thirdtitle:' + getFieldTypeText(h.rawfields_thirdtitle) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_titlelevel3:' + getFieldTypeText(h.rawfields_titlelevel3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_thirddept:' + getFieldTypeText(h.rawfields_thirddept) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_skillcategory:' + getFieldTypeText(h.rawfields_skillcategory) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_skillsubcategory:' + getFieldTypeText(h.rawfields_skillsubcategory) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_reportto:' + getFieldTypeText(h.rawfields_reportto) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_officephone:' + getFieldTypeText(h.rawfields_officephone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_officeext:' + getFieldTypeText(h.rawfields_officeext) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_officefax:' + getFieldTypeText(h.rawfields_officefax) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_officeemail:' + getFieldTypeText(h.rawfields_officeemail) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_directdial:' + getFieldTypeText(h.rawfields_directdial) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_mobilephone:' + getFieldTypeText(h.rawfields_mobilephone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_officeaddress1:' + getFieldTypeText(h.rawfields_officeaddress1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_officeaddress2:' + getFieldTypeText(h.rawfields_officeaddress2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_officecity:' + getFieldTypeText(h.rawfields_officecity) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_officestate:' + getFieldTypeText(h.rawfields_officestate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_officezip:' + getFieldTypeText(h.rawfields_officezip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_officecountry:' + getFieldTypeText(h.rawfields_officecountry) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_school:' + getFieldTypeText(h.rawfields_school) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_degree:' + getFieldTypeText(h.rawfields_degree) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_graduationyear:' + getFieldTypeText(h.rawfields_graduationyear) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_country:' + getFieldTypeText(h.rawfields_country) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_salary:' + getFieldTypeText(h.rawfields_salary) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_bonus:' + getFieldTypeText(h.rawfields_bonus) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_compensation:' + getFieldTypeText(h.rawfields_compensation) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_citizenship:' + getFieldTypeText(h.rawfields_citizenship) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_diversitycandidate:' + getFieldTypeText(h.rawfields_diversitycandidate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_entrydate:' + getFieldTypeText(h.rawfields_entrydate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_lastupdate:' + getFieldTypeText(h.rawfields_lastupdate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_contact_name_title:' + getFieldTypeText(h.clean_contact_name_title) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_contact_name_fname:' + getFieldTypeText(h.clean_contact_name_fname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_contact_name_mname:' + getFieldTypeText(h.clean_contact_name_mname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_contact_name_lname:' + getFieldTypeText(h.clean_contact_name_lname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_contact_name_name_suffix:' + getFieldTypeText(h.clean_contact_name_name_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_contact_name_name_score:' + getFieldTypeText(h.clean_contact_name_name_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_contact_address_prim_range:' + getFieldTypeText(h.clean_contact_address_prim_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_contact_address_predir:' + getFieldTypeText(h.clean_contact_address_predir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_contact_address_prim_name:' + getFieldTypeText(h.clean_contact_address_prim_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_contact_address_addr_suffix:' + getFieldTypeText(h.clean_contact_address_addr_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_contact_address_postdir:' + getFieldTypeText(h.clean_contact_address_postdir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_contact_address_unit_desig:' + getFieldTypeText(h.clean_contact_address_unit_desig) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_contact_address_sec_range:' + getFieldTypeText(h.clean_contact_address_sec_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_contact_address_p_city_name:' + getFieldTypeText(h.clean_contact_address_p_city_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_contact_address_v_city_name:' + getFieldTypeText(h.clean_contact_address_v_city_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_contact_address_st:' + getFieldTypeText(h.clean_contact_address_st) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_contact_address_zip:' + getFieldTypeText(h.clean_contact_address_zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_contact_address_zip4:' + getFieldTypeText(h.clean_contact_address_zip4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_contact_address_cart:' + getFieldTypeText(h.clean_contact_address_cart) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_contact_address_cr_sort_sz:' + getFieldTypeText(h.clean_contact_address_cr_sort_sz) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_contact_address_lot:' + getFieldTypeText(h.clean_contact_address_lot) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_contact_address_lot_order:' + getFieldTypeText(h.clean_contact_address_lot_order) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_contact_address_dbpc:' + getFieldTypeText(h.clean_contact_address_dbpc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_contact_address_chk_digit:' + getFieldTypeText(h.clean_contact_address_chk_digit) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_contact_address_rec_type:' + getFieldTypeText(h.clean_contact_address_rec_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_contact_address_fips_state:' + getFieldTypeText(h.clean_contact_address_fips_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_contact_address_fips_county:' + getFieldTypeText(h.clean_contact_address_fips_county) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_contact_address_geo_lat:' + getFieldTypeText(h.clean_contact_address_geo_lat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_contact_address_geo_long:' + getFieldTypeText(h.clean_contact_address_geo_long) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_contact_address_msa:' + getFieldTypeText(h.clean_contact_address_msa) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_contact_address_geo_blk:' + getFieldTypeText(h.clean_contact_address_geo_blk) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_contact_address_geo_match:' + getFieldTypeText(h.clean_contact_address_geo_match) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_contact_address_err_stat:' + getFieldTypeText(h.clean_contact_address_err_stat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_dates_entrydate:' + getFieldTypeText(h.clean_dates_entrydate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_dates_lastupdate:' + getFieldTypeText(h.clean_dates_lastupdate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_phones_officephone:' + getFieldTypeText(h.clean_phones_officephone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_phones_directdial:' + getFieldTypeText(h.clean_phones_directdial) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_phones_mobilephone:' + getFieldTypeText(h.clean_phones_mobilephone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'global_sid:' + getFieldTypeText(h.global_sid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'record_sid:' + getFieldTypeText(h.record_sid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_did_cnt
          ,le.populated_did_score_cnt
          ,le.populated_bdid_cnt
          ,le.populated_bdid_score_cnt
          ,le.populated_raw_aid_cnt
          ,le.populated_ace_aid_cnt
          ,le.populated_dt_first_seen_cnt
          ,le.populated_dt_last_seen_cnt
          ,le.populated_dt_vendor_first_reported_cnt
          ,le.populated_dt_vendor_last_reported_cnt
          ,le.populated_record_type_cnt
          ,le.populated_rawfields_maincontactid_cnt
          ,le.populated_rawfields_maincompanyid_cnt
          ,le.populated_rawfields_active_cnt
          ,le.populated_rawfields_firstname_cnt
          ,le.populated_rawfields_midinital_cnt
          ,le.populated_rawfields_lastname_cnt
          ,le.populated_rawfields_age_cnt
          ,le.populated_rawfields_gender_cnt
          ,le.populated_rawfields_primarytitle_cnt
          ,le.populated_rawfields_titlelevel1_cnt
          ,le.populated_rawfields_primarydept_cnt
          ,le.populated_rawfields_secondtitle_cnt
          ,le.populated_rawfields_titlelevel2_cnt
          ,le.populated_rawfields_seconddept_cnt
          ,le.populated_rawfields_thirdtitle_cnt
          ,le.populated_rawfields_titlelevel3_cnt
          ,le.populated_rawfields_thirddept_cnt
          ,le.populated_rawfields_skillcategory_cnt
          ,le.populated_rawfields_skillsubcategory_cnt
          ,le.populated_rawfields_reportto_cnt
          ,le.populated_rawfields_officephone_cnt
          ,le.populated_rawfields_officeext_cnt
          ,le.populated_rawfields_officefax_cnt
          ,le.populated_rawfields_officeemail_cnt
          ,le.populated_rawfields_directdial_cnt
          ,le.populated_rawfields_mobilephone_cnt
          ,le.populated_rawfields_officeaddress1_cnt
          ,le.populated_rawfields_officeaddress2_cnt
          ,le.populated_rawfields_officecity_cnt
          ,le.populated_rawfields_officestate_cnt
          ,le.populated_rawfields_officezip_cnt
          ,le.populated_rawfields_officecountry_cnt
          ,le.populated_rawfields_school_cnt
          ,le.populated_rawfields_degree_cnt
          ,le.populated_rawfields_graduationyear_cnt
          ,le.populated_rawfields_country_cnt
          ,le.populated_rawfields_salary_cnt
          ,le.populated_rawfields_bonus_cnt
          ,le.populated_rawfields_compensation_cnt
          ,le.populated_rawfields_citizenship_cnt
          ,le.populated_rawfields_diversitycandidate_cnt
          ,le.populated_rawfields_entrydate_cnt
          ,le.populated_rawfields_lastupdate_cnt
          ,le.populated_clean_contact_name_title_cnt
          ,le.populated_clean_contact_name_fname_cnt
          ,le.populated_clean_contact_name_mname_cnt
          ,le.populated_clean_contact_name_lname_cnt
          ,le.populated_clean_contact_name_name_suffix_cnt
          ,le.populated_clean_contact_name_name_score_cnt
          ,le.populated_clean_contact_address_prim_range_cnt
          ,le.populated_clean_contact_address_predir_cnt
          ,le.populated_clean_contact_address_prim_name_cnt
          ,le.populated_clean_contact_address_addr_suffix_cnt
          ,le.populated_clean_contact_address_postdir_cnt
          ,le.populated_clean_contact_address_unit_desig_cnt
          ,le.populated_clean_contact_address_sec_range_cnt
          ,le.populated_clean_contact_address_p_city_name_cnt
          ,le.populated_clean_contact_address_v_city_name_cnt
          ,le.populated_clean_contact_address_st_cnt
          ,le.populated_clean_contact_address_zip_cnt
          ,le.populated_clean_contact_address_zip4_cnt
          ,le.populated_clean_contact_address_cart_cnt
          ,le.populated_clean_contact_address_cr_sort_sz_cnt
          ,le.populated_clean_contact_address_lot_cnt
          ,le.populated_clean_contact_address_lot_order_cnt
          ,le.populated_clean_contact_address_dbpc_cnt
          ,le.populated_clean_contact_address_chk_digit_cnt
          ,le.populated_clean_contact_address_rec_type_cnt
          ,le.populated_clean_contact_address_fips_state_cnt
          ,le.populated_clean_contact_address_fips_county_cnt
          ,le.populated_clean_contact_address_geo_lat_cnt
          ,le.populated_clean_contact_address_geo_long_cnt
          ,le.populated_clean_contact_address_msa_cnt
          ,le.populated_clean_contact_address_geo_blk_cnt
          ,le.populated_clean_contact_address_geo_match_cnt
          ,le.populated_clean_contact_address_err_stat_cnt
          ,le.populated_clean_dates_entrydate_cnt
          ,le.populated_clean_dates_lastupdate_cnt
          ,le.populated_clean_phones_officephone_cnt
          ,le.populated_clean_phones_directdial_cnt
          ,le.populated_clean_phones_mobilephone_cnt
          ,le.populated_global_sid_cnt
          ,le.populated_record_sid_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_did_pcnt
          ,le.populated_did_score_pcnt
          ,le.populated_bdid_pcnt
          ,le.populated_bdid_score_pcnt
          ,le.populated_raw_aid_pcnt
          ,le.populated_ace_aid_pcnt
          ,le.populated_dt_first_seen_pcnt
          ,le.populated_dt_last_seen_pcnt
          ,le.populated_dt_vendor_first_reported_pcnt
          ,le.populated_dt_vendor_last_reported_pcnt
          ,le.populated_record_type_pcnt
          ,le.populated_rawfields_maincontactid_pcnt
          ,le.populated_rawfields_maincompanyid_pcnt
          ,le.populated_rawfields_active_pcnt
          ,le.populated_rawfields_firstname_pcnt
          ,le.populated_rawfields_midinital_pcnt
          ,le.populated_rawfields_lastname_pcnt
          ,le.populated_rawfields_age_pcnt
          ,le.populated_rawfields_gender_pcnt
          ,le.populated_rawfields_primarytitle_pcnt
          ,le.populated_rawfields_titlelevel1_pcnt
          ,le.populated_rawfields_primarydept_pcnt
          ,le.populated_rawfields_secondtitle_pcnt
          ,le.populated_rawfields_titlelevel2_pcnt
          ,le.populated_rawfields_seconddept_pcnt
          ,le.populated_rawfields_thirdtitle_pcnt
          ,le.populated_rawfields_titlelevel3_pcnt
          ,le.populated_rawfields_thirddept_pcnt
          ,le.populated_rawfields_skillcategory_pcnt
          ,le.populated_rawfields_skillsubcategory_pcnt
          ,le.populated_rawfields_reportto_pcnt
          ,le.populated_rawfields_officephone_pcnt
          ,le.populated_rawfields_officeext_pcnt
          ,le.populated_rawfields_officefax_pcnt
          ,le.populated_rawfields_officeemail_pcnt
          ,le.populated_rawfields_directdial_pcnt
          ,le.populated_rawfields_mobilephone_pcnt
          ,le.populated_rawfields_officeaddress1_pcnt
          ,le.populated_rawfields_officeaddress2_pcnt
          ,le.populated_rawfields_officecity_pcnt
          ,le.populated_rawfields_officestate_pcnt
          ,le.populated_rawfields_officezip_pcnt
          ,le.populated_rawfields_officecountry_pcnt
          ,le.populated_rawfields_school_pcnt
          ,le.populated_rawfields_degree_pcnt
          ,le.populated_rawfields_graduationyear_pcnt
          ,le.populated_rawfields_country_pcnt
          ,le.populated_rawfields_salary_pcnt
          ,le.populated_rawfields_bonus_pcnt
          ,le.populated_rawfields_compensation_pcnt
          ,le.populated_rawfields_citizenship_pcnt
          ,le.populated_rawfields_diversitycandidate_pcnt
          ,le.populated_rawfields_entrydate_pcnt
          ,le.populated_rawfields_lastupdate_pcnt
          ,le.populated_clean_contact_name_title_pcnt
          ,le.populated_clean_contact_name_fname_pcnt
          ,le.populated_clean_contact_name_mname_pcnt
          ,le.populated_clean_contact_name_lname_pcnt
          ,le.populated_clean_contact_name_name_suffix_pcnt
          ,le.populated_clean_contact_name_name_score_pcnt
          ,le.populated_clean_contact_address_prim_range_pcnt
          ,le.populated_clean_contact_address_predir_pcnt
          ,le.populated_clean_contact_address_prim_name_pcnt
          ,le.populated_clean_contact_address_addr_suffix_pcnt
          ,le.populated_clean_contact_address_postdir_pcnt
          ,le.populated_clean_contact_address_unit_desig_pcnt
          ,le.populated_clean_contact_address_sec_range_pcnt
          ,le.populated_clean_contact_address_p_city_name_pcnt
          ,le.populated_clean_contact_address_v_city_name_pcnt
          ,le.populated_clean_contact_address_st_pcnt
          ,le.populated_clean_contact_address_zip_pcnt
          ,le.populated_clean_contact_address_zip4_pcnt
          ,le.populated_clean_contact_address_cart_pcnt
          ,le.populated_clean_contact_address_cr_sort_sz_pcnt
          ,le.populated_clean_contact_address_lot_pcnt
          ,le.populated_clean_contact_address_lot_order_pcnt
          ,le.populated_clean_contact_address_dbpc_pcnt
          ,le.populated_clean_contact_address_chk_digit_pcnt
          ,le.populated_clean_contact_address_rec_type_pcnt
          ,le.populated_clean_contact_address_fips_state_pcnt
          ,le.populated_clean_contact_address_fips_county_pcnt
          ,le.populated_clean_contact_address_geo_lat_pcnt
          ,le.populated_clean_contact_address_geo_long_pcnt
          ,le.populated_clean_contact_address_msa_pcnt
          ,le.populated_clean_contact_address_geo_blk_pcnt
          ,le.populated_clean_contact_address_geo_match_pcnt
          ,le.populated_clean_contact_address_err_stat_pcnt
          ,le.populated_clean_dates_entrydate_pcnt
          ,le.populated_clean_dates_lastupdate_pcnt
          ,le.populated_clean_phones_officephone_pcnt
          ,le.populated_clean_phones_directdial_pcnt
          ,le.populated_clean_phones_mobilephone_pcnt
          ,le.populated_global_sid_pcnt
          ,le.populated_record_sid_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,94,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Contacts_Delta(prevDS, PROJECT(h, Contacts_Layout_Sheila_Greco));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),94,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Contacts_Layout_Sheila_Greco) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_Sheila_Greco, Contacts_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
