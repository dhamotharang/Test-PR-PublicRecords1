/*
  after layouts.key is updated, in the following build the layouts.key_static will need to be updated to layouts.key.
  similar to the bipv2.commonbase.layout_static and layout_dynamic.
  We need to do this because of BIPV2.fn_derive_pn uses bipv2_Best.Key_LinkIds.key_static before the new key is built
  so it needs to use the previous layout of the key.
  Need a better solution for this.
*/
import BIPV2;
EXPORT Layouts := MODULE
EXPORT In_Base_with_flags := record
recordof(BIPV2.Files.business_header_building);
string48 source_for_votes := '';
string1 company_name_flag := '';
string1 company_fein_flag := '';
string1 company_phone_flag := '';
string1 company_url_flag := '';
string1 address_flag := '';
string1 duns_number_flag := '';
string1 company_sic_code1_flag := '';
string1 company_naics_code1_flag := '';
end;
EXPORT linkids := RECORD
  unsigned6 proxid;
  unsigned6 seleid;
  unsigned6 ultid := 0;
  unsigned6 orgid := 0;
END;
EXPORT Source := RECORD
  string2 source;
  unsigned8 source_record_id;
  string34 vl_id;
END;
EXPORT company_name := RECORD
   string120 company_name;
   unsigned2 company_name_data_permits;
   unsigned1 company_name_method;
  END;
EXPORT company_name_case_layout := RECORD
    company_name;
    unsigned4 dt_first_seen;
    unsigned4 dt_last_seen;
    unsigned1 score := 0 ;
    DATASET(Source) Sources;
  END;
EXPORT company_address := RECORD
   string10 address_prim_range;
   string2 address_predir;
   string28 address_prim_name;
   string4 address_addr_suffix;
   string2 address_postdir;
   string10 address_unit_desig;
   string8 address_sec_range;
   string25 address_p_city_name;
   string2 address_st;
   string5 address_zip;
   string4 address_zip4;
   unsigned2 address_data_permits;
   unsigned1 address_method;
  END;
EXPORT company_address_case_layout := RECORD
  string10 company_prim_range;
  string2 company_predir;
  string28 company_prim_name;
  string4 company_addr_suffix;
  string2 company_postdir;
  string10 company_unit_desig;
  string8 company_sec_range;
  string25 company_p_city_name;
  string25 address_v_city_name;
  string2 company_st;
  string5 company_zip5;
  string4 company_zip4;
  string2 state_fips;
  string3 county_fips;
  string18 county_name;
  unsigned2 company_address_data_permits;
  unsigned1 company_address_method; // This value could come from multiple BESTTYPE; track which one
  unsigned1 score := 0 ;
  END;
EXPORT company_phone := RECORD
   string10 company_phone;
   unsigned2 company_phone_data_permits;
   unsigned1 company_phone_method;
  END;
EXPORT company_phone_case_layout := RECORD
  company_phone;
  unsigned1 score := 0 ;
  END;
EXPORT company_fein := RECORD
   string9 company_fein;
   unsigned2 company_fein_data_permits;
   unsigned1 company_fein_method;
   unsigned company_fein_cnt;
   boolean company_fein_owns;
  END;
EXPORT company_fein_case_layout := RECORD
  company_fein;
  unsigned1 score := 0 ;
  DATASET(Source) Sources;
  END;
EXPORT company_url := RECORD
   string80 company_url;
   unsigned2 company_url_data_permits;
   unsigned1 company_url_method;
  END;
EXPORT company_url_case_layout := RECORD
  company_url ;
  unsigned1 score := 0 ;
  END;
EXPORT company_incorporation_date := RECORD
  unsigned4 company_incorporation_date := 0;
  unsigned2 company_incorporation_date_permits := 0;
  unsigned1 company_incorporation_date_method := 0;
  END;
EXPORT company_incorporation_date_layout := RECORD
  company_incorporation_date;
  unsigned1 score := 0 ;
  DATASET(Source) Sources;
END;
EXPORT duns_number := RECORD
   string9 duns_number;
   unsigned2 duns_number_data_permits;
   unsigned1 duns_number_method;
  END;
EXPORT duns_number_case_layout := RECORD
  duns_number;
  unsigned1 score := 0 ;
END;
EXPORT sic_code:=RECORD
  STRING8 company_sic_code1;
  UNSIGNED2 company_sic_code1_data_permits;
  UNSIGNED1 company_sic_code1_method;
END;
EXPORT sic_code_case_layout:=RECORD
  sic_code;
  UNSIGNED1 score :=0;
END;
EXPORT naics_code:=RECORD
  STRING6 company_naics_code1;
  UNSIGNED2 company_naics_code1_data_permits;
  UNSIGNED1 company_naics_code1_method;
END;
EXPORT naics_code_case_layout:=RECORD
  naics_code;
  UNSIGNED score := 0;
END;
export base := RECORD
    linkids;
    unsigned6 company_bdid;
    DATASET(company_name_case_layout) company_name;
    DATASET(company_address_case_layout) company_address;
    DATASET(company_phone_case_layout) company_phone;
    DATASET(company_fein_case_layout) company_fein;
    DATASET(company_url_case_layout) company_url;
    DATASET(company_incorporation_date_layout) company_incorporation_date;
    DATASET(duns_number_case_layout) duns_number;
    DATASET(sic_code_case_layout) sic_code;
    DATASET(naics_code_case_layout) naics_code;
  END;
EXPORT key := RECORD
    BIPV2.IDlayouts.l_xlink_ids;
    boolean isActive ; //seleid level
    boolean isDefunct; //seleid level   
    unsigned6 company_bdid;
    DATASET(company_name_case_layout and not score) company_name;
    DATASET(company_address_case_layout  and not [score, state_fips, county_fips]) company_address;
    DATASET(company_phone_case_layout  and not score) company_phone;
    DATASET(company_fein_case_layout and not [score, company_fein_cnt,company_fein_owns]) company_fein;
    DATASET(company_url_case_layout  and not score) company_url;
    DATASET(company_incorporation_date_layout  and not score) company_incorporation_date;
    DATASET(duns_number_case_layout and not score) duns_number;
    DATASET(sic_code_case_layout and not score) sic_code;
    DATASET(naics_code_case_layout and not score) naics_code;
END;
EXPORT key_static := RECORD
    BIPV2.IDlayouts.l_xlink_ids;
    boolean isActive ; //seleid level
    boolean isDefunct; //seleid level   
    unsigned6 company_bdid;
    DATASET(company_name_case_layout and not score) company_name;
    DATASET(company_address_case_layout  and not [score, state_fips, county_fips]) company_address;
    DATASET(company_phone_case_layout  and not score) company_phone;
    DATASET(company_fein_case_layout and not [score, company_fein_cnt,company_fein_owns]) company_fein;
    DATASET(company_url_case_layout  and not score) company_url;
    DATASET(company_incorporation_date_layout  and not score) company_incorporation_date;
    DATASET(duns_number_case_layout and not score) duns_number;
    DATASET(sic_code_case_layout and not score) sic_code;
    DATASET(naics_code_case_layout and not score) naics_code;
END;
END;
