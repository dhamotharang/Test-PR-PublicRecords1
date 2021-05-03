IMPORT SALT311,STD;
EXPORT Base_hygiene(dataset(Base_layout_Frandx) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_ace_aid_cnt := COUNT(GROUP,h.ace_aid <> (TYPEOF(h.ace_aid))'');
    populated_ace_aid_pcnt := AVE(GROUP,IF(h.ace_aid = (TYPEOF(h.ace_aid))'',0,100));
    maxlength_ace_aid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ace_aid)));
    avelength_ace_aid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ace_aid)),h.ace_aid<>(typeof(h.ace_aid))'');
    populated_address1_cnt := COUNT(GROUP,h.address1 <> (TYPEOF(h.address1))'');
    populated_address1_pcnt := AVE(GROUP,IF(h.address1 = (TYPEOF(h.address1))'',0,100));
    maxlength_address1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.address1)));
    avelength_address1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.address1)),h.address1<>(typeof(h.address1))'');
    populated_brand_name_cnt := COUNT(GROUP,h.brand_name <> (TYPEOF(h.brand_name))'');
    populated_brand_name_pcnt := AVE(GROUP,IF(h.brand_name = (TYPEOF(h.brand_name))'',0,100));
    maxlength_brand_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.brand_name)));
    avelength_brand_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.brand_name)),h.brand_name<>(typeof(h.brand_name))'');
    populated_chk_digit_cnt := COUNT(GROUP,h.chk_digit <> (TYPEOF(h.chk_digit))'');
    populated_chk_digit_pcnt := AVE(GROUP,IF(h.chk_digit = (TYPEOF(h.chk_digit))'',0,100));
    maxlength_chk_digit := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.chk_digit)));
    avelength_chk_digit := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.chk_digit)),h.chk_digit<>(typeof(h.chk_digit))'');
    populated_city_cnt := COUNT(GROUP,h.city <> (TYPEOF(h.city))'');
    populated_city_pcnt := AVE(GROUP,IF(h.city = (TYPEOF(h.city))'',0,100));
    maxlength_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.city)));
    avelength_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.city)),h.city<>(typeof(h.city))'');
    populated_clean_phone_cnt := COUNT(GROUP,h.clean_phone <> (TYPEOF(h.clean_phone))'');
    populated_clean_phone_pcnt := AVE(GROUP,IF(h.clean_phone = (TYPEOF(h.clean_phone))'',0,100));
    maxlength_clean_phone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_phone)));
    avelength_clean_phone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_phone)),h.clean_phone<>(typeof(h.clean_phone))'');
    populated_clean_secondary_phone_cnt := COUNT(GROUP,h.clean_secondary_phone <> (TYPEOF(h.clean_secondary_phone))'');
    populated_clean_secondary_phone_pcnt := AVE(GROUP,IF(h.clean_secondary_phone = (TYPEOF(h.clean_secondary_phone))'',0,100));
    maxlength_clean_secondary_phone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_secondary_phone)));
    avelength_clean_secondary_phone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_secondary_phone)),h.clean_secondary_phone<>(typeof(h.clean_secondary_phone))'');
    populated_company_name_cnt := COUNT(GROUP,h.company_name <> (TYPEOF(h.company_name))'');
    populated_company_name_pcnt := AVE(GROUP,IF(h.company_name = (TYPEOF(h.company_name))'',0,100));
    maxlength_company_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_name)));
    avelength_company_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_name)),h.company_name<>(typeof(h.company_name))'');
    populated_dt_first_seen_cnt := COUNT(GROUP,h.dt_first_seen <> (TYPEOF(h.dt_first_seen))'');
    populated_dt_first_seen_pcnt := AVE(GROUP,IF(h.dt_first_seen = (TYPEOF(h.dt_first_seen))'',0,100));
    maxlength_dt_first_seen := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_first_seen)));
    avelength_dt_first_seen := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_first_seen)),h.dt_first_seen<>(typeof(h.dt_first_seen))'');
    populated_dt_last_seen_cnt := COUNT(GROUP,h.dt_last_seen <> (TYPEOF(h.dt_last_seen))'');
    populated_dt_last_seen_pcnt := AVE(GROUP,IF(h.dt_last_seen = (TYPEOF(h.dt_last_seen))'',0,100));
    maxlength_dt_last_seen := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_last_seen)));
    avelength_dt_last_seen := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_last_seen)),h.dt_last_seen<>(typeof(h.dt_last_seen))'');
    populated_dt_vendor_first_reported_cnt := COUNT(GROUP,h.dt_vendor_first_reported <> (TYPEOF(h.dt_vendor_first_reported))'');
    populated_dt_vendor_first_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_first_reported = (TYPEOF(h.dt_vendor_first_reported))'',0,100));
    maxlength_dt_vendor_first_reported := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_vendor_first_reported)));
    avelength_dt_vendor_first_reported := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_vendor_first_reported)),h.dt_vendor_first_reported<>(typeof(h.dt_vendor_first_reported))'');
    populated_dt_vendor_last_reported_cnt := COUNT(GROUP,h.dt_vendor_last_reported <> (TYPEOF(h.dt_vendor_last_reported))'');
    populated_dt_vendor_last_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_last_reported = (TYPEOF(h.dt_vendor_last_reported))'',0,100));
    maxlength_dt_vendor_last_reported := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_vendor_last_reported)));
    avelength_dt_vendor_last_reported := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_vendor_last_reported)),h.dt_vendor_last_reported<>(typeof(h.dt_vendor_last_reported))'');
    populated_err_stat_cnt := COUNT(GROUP,h.err_stat <> (TYPEOF(h.err_stat))'');
    populated_err_stat_pcnt := AVE(GROUP,IF(h.err_stat = (TYPEOF(h.err_stat))'',0,100));
    maxlength_err_stat := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.err_stat)));
    avelength_err_stat := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.err_stat)),h.err_stat<>(typeof(h.err_stat))'');
    populated_fips_county_cnt := COUNT(GROUP,h.fips_county <> (TYPEOF(h.fips_county))'');
    populated_fips_county_pcnt := AVE(GROUP,IF(h.fips_county = (TYPEOF(h.fips_county))'',0,100));
    maxlength_fips_county := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fips_county)));
    avelength_fips_county := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fips_county)),h.fips_county<>(typeof(h.fips_county))'');
    populated_fips_state_cnt := COUNT(GROUP,h.fips_state <> (TYPEOF(h.fips_state))'');
    populated_fips_state_pcnt := AVE(GROUP,IF(h.fips_state = (TYPEOF(h.fips_state))'',0,100));
    maxlength_fips_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fips_state)));
    avelength_fips_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fips_state)),h.fips_state<>(typeof(h.fips_state))'');
    populated_franchisee_id_cnt := COUNT(GROUP,h.franchisee_id <> (TYPEOF(h.franchisee_id))'');
    populated_franchisee_id_pcnt := AVE(GROUP,IF(h.franchisee_id = (TYPEOF(h.franchisee_id))'',0,100));
    maxlength_franchisee_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.franchisee_id)));
    avelength_franchisee_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.franchisee_id)),h.franchisee_id<>(typeof(h.franchisee_id))'');
    populated_fruns_cnt := COUNT(GROUP,h.fruns <> (TYPEOF(h.fruns))'');
    populated_fruns_pcnt := AVE(GROUP,IF(h.fruns = (TYPEOF(h.fruns))'',0,100));
    maxlength_fruns := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fruns)));
    avelength_fruns := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fruns)),h.fruns<>(typeof(h.fruns))'');
    populated_f_units_cnt := COUNT(GROUP,h.f_units <> (TYPEOF(h.f_units))'');
    populated_f_units_pcnt := AVE(GROUP,IF(h.f_units = (TYPEOF(h.f_units))'',0,100));
    maxlength_f_units := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.f_units)));
    avelength_f_units := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.f_units)),h.f_units<>(typeof(h.f_units))'');
    populated_industry_cnt := COUNT(GROUP,h.industry <> (TYPEOF(h.industry))'');
    populated_industry_pcnt := AVE(GROUP,IF(h.industry = (TYPEOF(h.industry))'',0,100));
    maxlength_industry := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.industry)));
    avelength_industry := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.industry)),h.industry<>(typeof(h.industry))'');
    populated_industry_type_cnt := COUNT(GROUP,h.industry_type <> (TYPEOF(h.industry_type))'');
    populated_industry_type_pcnt := AVE(GROUP,IF(h.industry_type = (TYPEOF(h.industry_type))'',0,100));
    maxlength_industry_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.industry_type)));
    avelength_industry_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.industry_type)),h.industry_type<>(typeof(h.industry_type))'');
    populated_p_city_name_cnt := COUNT(GROUP,h.p_city_name <> (TYPEOF(h.p_city_name))'');
    populated_p_city_name_pcnt := AVE(GROUP,IF(h.p_city_name = (TYPEOF(h.p_city_name))'',0,100));
    maxlength_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.p_city_name)));
    avelength_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.p_city_name)),h.p_city_name<>(typeof(h.p_city_name))'');
    populated_phone_cnt := COUNT(GROUP,h.phone <> (TYPEOF(h.phone))'');
    populated_phone_pcnt := AVE(GROUP,IF(h.phone = (TYPEOF(h.phone))'',0,100));
    maxlength_phone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone)));
    avelength_phone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone)),h.phone<>(typeof(h.phone))'');
    populated_phone_extension_cnt := COUNT(GROUP,h.phone_extension <> (TYPEOF(h.phone_extension))'');
    populated_phone_extension_pcnt := AVE(GROUP,IF(h.phone_extension = (TYPEOF(h.phone_extension))'',0,100));
    maxlength_phone_extension := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone_extension)));
    avelength_phone_extension := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone_extension)),h.phone_extension<>(typeof(h.phone_extension))'');
    populated_prim_name_cnt := COUNT(GROUP,h.prim_name <> (TYPEOF(h.prim_name))'');
    populated_prim_name_pcnt := AVE(GROUP,IF(h.prim_name = (TYPEOF(h.prim_name))'',0,100));
    maxlength_prim_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_name)));
    avelength_prim_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_name)),h.prim_name<>(typeof(h.prim_name))'');
    populated_record_id_cnt := COUNT(GROUP,h.record_id <> (TYPEOF(h.record_id))'');
    populated_record_id_pcnt := AVE(GROUP,IF(h.record_id = (TYPEOF(h.record_id))'',0,100));
    maxlength_record_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.record_id)));
    avelength_record_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.record_id)),h.record_id<>(typeof(h.record_id))'');
    populated_record_type_cnt := COUNT(GROUP,h.record_type <> (TYPEOF(h.record_type))'');
    populated_record_type_pcnt := AVE(GROUP,IF(h.record_type = (TYPEOF(h.record_type))'',0,100));
    maxlength_record_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.record_type)));
    avelength_record_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.record_type)),h.record_type<>(typeof(h.record_type))'');
    populated_relationship_code_cnt := COUNT(GROUP,h.relationship_code <> (TYPEOF(h.relationship_code))'');
    populated_relationship_code_pcnt := AVE(GROUP,IF(h.relationship_code = (TYPEOF(h.relationship_code))'',0,100));
    maxlength_relationship_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.relationship_code)));
    avelength_relationship_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.relationship_code)),h.relationship_code<>(typeof(h.relationship_code))'');
    populated_relationship_code_exp_cnt := COUNT(GROUP,h.relationship_code_exp <> (TYPEOF(h.relationship_code_exp))'');
    populated_relationship_code_exp_pcnt := AVE(GROUP,IF(h.relationship_code_exp = (TYPEOF(h.relationship_code_exp))'',0,100));
    maxlength_relationship_code_exp := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.relationship_code_exp)));
    avelength_relationship_code_exp := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.relationship_code_exp)),h.relationship_code_exp<>(typeof(h.relationship_code_exp))'');
    populated_secondary_phone_cnt := COUNT(GROUP,h.secondary_phone <> (TYPEOF(h.secondary_phone))'');
    populated_secondary_phone_pcnt := AVE(GROUP,IF(h.secondary_phone = (TYPEOF(h.secondary_phone))'',0,100));
    maxlength_secondary_phone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.secondary_phone)));
    avelength_secondary_phone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.secondary_phone)),h.secondary_phone<>(typeof(h.secondary_phone))'');
    populated_sector_cnt := COUNT(GROUP,h.sector <> (TYPEOF(h.sector))'');
    populated_sector_pcnt := AVE(GROUP,IF(h.sector = (TYPEOF(h.sector))'',0,100));
    maxlength_sector := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sector)));
    avelength_sector := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sector)),h.sector<>(typeof(h.sector))'');
    populated_sic_code_cnt := COUNT(GROUP,h.sic_code <> (TYPEOF(h.sic_code))'');
    populated_sic_code_pcnt := AVE(GROUP,IF(h.sic_code = (TYPEOF(h.sic_code))'',0,100));
    maxlength_sic_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic_code)));
    avelength_sic_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic_code)),h.sic_code<>(typeof(h.sic_code))'');
    populated_state_cnt := COUNT(GROUP,h.state <> (TYPEOF(h.state))'');
    populated_state_pcnt := AVE(GROUP,IF(h.state = (TYPEOF(h.state))'',0,100));
    maxlength_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.state)));
    avelength_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.state)),h.state<>(typeof(h.state))'');
    populated_unit_flag_cnt := COUNT(GROUP,h.unit_flag <> (TYPEOF(h.unit_flag))'');
    populated_unit_flag_pcnt := AVE(GROUP,IF(h.unit_flag = (TYPEOF(h.unit_flag))'',0,100));
    maxlength_unit_flag := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.unit_flag)));
    avelength_unit_flag := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.unit_flag)),h.unit_flag<>(typeof(h.unit_flag))'');
    populated_unit_flag_exp_cnt := COUNT(GROUP,h.unit_flag_exp <> (TYPEOF(h.unit_flag_exp))'');
    populated_unit_flag_exp_pcnt := AVE(GROUP,IF(h.unit_flag_exp = (TYPEOF(h.unit_flag_exp))'',0,100));
    maxlength_unit_flag_exp := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.unit_flag_exp)));
    avelength_unit_flag_exp := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.unit_flag_exp)),h.unit_flag_exp<>(typeof(h.unit_flag_exp))'');
    populated_v_city_name_cnt := COUNT(GROUP,h.v_city_name <> (TYPEOF(h.v_city_name))'');
    populated_v_city_name_pcnt := AVE(GROUP,IF(h.v_city_name = (TYPEOF(h.v_city_name))'',0,100));
    maxlength_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.v_city_name)));
    avelength_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.v_city_name)),h.v_city_name<>(typeof(h.v_city_name))'');
    populated_zip_code_cnt := COUNT(GROUP,h.zip_code <> (TYPEOF(h.zip_code))'');
    populated_zip_code_pcnt := AVE(GROUP,IF(h.zip_code = (TYPEOF(h.zip_code))'',0,100));
    maxlength_zip_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_code)));
    avelength_zip_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_code)),h.zip_code<>(typeof(h.zip_code))'');
    populated_zip_code4_cnt := COUNT(GROUP,h.zip_code4 <> (TYPEOF(h.zip_code4))'');
    populated_zip_code4_pcnt := AVE(GROUP,IF(h.zip_code4 = (TYPEOF(h.zip_code4))'',0,100));
    maxlength_zip_code4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_code4)));
    avelength_zip_code4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_code4)),h.zip_code4<>(typeof(h.zip_code4))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_ace_aid_pcnt *   0.00 / 100 + T.Populated_address1_pcnt *   0.00 / 100 + T.Populated_brand_name_pcnt *   0.00 / 100 + T.Populated_chk_digit_pcnt *   0.00 / 100 + T.Populated_city_pcnt *   0.00 / 100 + T.Populated_clean_phone_pcnt *   0.00 / 100 + T.Populated_clean_secondary_phone_pcnt *   0.00 / 100 + T.Populated_company_name_pcnt *   0.00 / 100 + T.Populated_dt_first_seen_pcnt *   0.00 / 100 + T.Populated_dt_last_seen_pcnt *   0.00 / 100 + T.Populated_dt_vendor_first_reported_pcnt *   0.00 / 100 + T.Populated_dt_vendor_last_reported_pcnt *   0.00 / 100 + T.Populated_err_stat_pcnt *   0.00 / 100 + T.Populated_fips_county_pcnt *   0.00 / 100 + T.Populated_fips_state_pcnt *   0.00 / 100 + T.Populated_franchisee_id_pcnt *   0.00 / 100 + T.Populated_fruns_pcnt *   0.00 / 100 + T.Populated_f_units_pcnt *   0.00 / 100 + T.Populated_industry_pcnt *   0.00 / 100 + T.Populated_industry_type_pcnt *   0.00 / 100 + T.Populated_p_city_name_pcnt *   0.00 / 100 + T.Populated_phone_pcnt *   0.00 / 100 + T.Populated_phone_extension_pcnt *   0.00 / 100 + T.Populated_prim_name_pcnt *   0.00 / 100 + T.Populated_record_id_pcnt *   0.00 / 100 + T.Populated_record_type_pcnt *   0.00 / 100 + T.Populated_relationship_code_pcnt *   0.00 / 100 + T.Populated_relationship_code_exp_pcnt *   0.00 / 100 + T.Populated_secondary_phone_pcnt *   0.00 / 100 + T.Populated_sector_pcnt *   0.00 / 100 + T.Populated_sic_code_pcnt *   0.00 / 100 + T.Populated_state_pcnt *   0.00 / 100 + T.Populated_unit_flag_pcnt *   0.00 / 100 + T.Populated_unit_flag_exp_pcnt *   0.00 / 100 + T.Populated_v_city_name_pcnt *   0.00 / 100 + T.Populated_zip_code_pcnt *   0.00 / 100 + T.Populated_zip_code4_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
  invRec := RECORD
  UNSIGNED  FldNo;
  SALT311.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'ace_aid','address1','brand_name','chk_digit','city','clean_phone','clean_secondary_phone','company_name','dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','err_stat','fips_county','fips_state','franchisee_id','fruns','f_units','industry','industry_type','p_city_name','phone','phone_extension','prim_name','record_id','record_type','relationship_code','relationship_code_exp','secondary_phone','sector','sic_code','state','unit_flag','unit_flag_exp','v_city_name','zip_code','zip_code4');
  SELF.populated_pcnt := CHOOSE(C,le.populated_ace_aid_pcnt,le.populated_address1_pcnt,le.populated_brand_name_pcnt,le.populated_chk_digit_pcnt,le.populated_city_pcnt,le.populated_clean_phone_pcnt,le.populated_clean_secondary_phone_pcnt,le.populated_company_name_pcnt,le.populated_dt_first_seen_pcnt,le.populated_dt_last_seen_pcnt,le.populated_dt_vendor_first_reported_pcnt,le.populated_dt_vendor_last_reported_pcnt,le.populated_err_stat_pcnt,le.populated_fips_county_pcnt,le.populated_fips_state_pcnt,le.populated_franchisee_id_pcnt,le.populated_fruns_pcnt,le.populated_f_units_pcnt,le.populated_industry_pcnt,le.populated_industry_type_pcnt,le.populated_p_city_name_pcnt,le.populated_phone_pcnt,le.populated_phone_extension_pcnt,le.populated_prim_name_pcnt,le.populated_record_id_pcnt,le.populated_record_type_pcnt,le.populated_relationship_code_pcnt,le.populated_relationship_code_exp_pcnt,le.populated_secondary_phone_pcnt,le.populated_sector_pcnt,le.populated_sic_code_pcnt,le.populated_state_pcnt,le.populated_unit_flag_pcnt,le.populated_unit_flag_exp_pcnt,le.populated_v_city_name_pcnt,le.populated_zip_code_pcnt,le.populated_zip_code4_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_ace_aid,le.maxlength_address1,le.maxlength_brand_name,le.maxlength_chk_digit,le.maxlength_city,le.maxlength_clean_phone,le.maxlength_clean_secondary_phone,le.maxlength_company_name,le.maxlength_dt_first_seen,le.maxlength_dt_last_seen,le.maxlength_dt_vendor_first_reported,le.maxlength_dt_vendor_last_reported,le.maxlength_err_stat,le.maxlength_fips_county,le.maxlength_fips_state,le.maxlength_franchisee_id,le.maxlength_fruns,le.maxlength_f_units,le.maxlength_industry,le.maxlength_industry_type,le.maxlength_p_city_name,le.maxlength_phone,le.maxlength_phone_extension,le.maxlength_prim_name,le.maxlength_record_id,le.maxlength_record_type,le.maxlength_relationship_code,le.maxlength_relationship_code_exp,le.maxlength_secondary_phone,le.maxlength_sector,le.maxlength_sic_code,le.maxlength_state,le.maxlength_unit_flag,le.maxlength_unit_flag_exp,le.maxlength_v_city_name,le.maxlength_zip_code,le.maxlength_zip_code4);
  SELF.avelength := CHOOSE(C,le.avelength_ace_aid,le.avelength_address1,le.avelength_brand_name,le.avelength_chk_digit,le.avelength_city,le.avelength_clean_phone,le.avelength_clean_secondary_phone,le.avelength_company_name,le.avelength_dt_first_seen,le.avelength_dt_last_seen,le.avelength_dt_vendor_first_reported,le.avelength_dt_vendor_last_reported,le.avelength_err_stat,le.avelength_fips_county,le.avelength_fips_state,le.avelength_franchisee_id,le.avelength_fruns,le.avelength_f_units,le.avelength_industry,le.avelength_industry_type,le.avelength_p_city_name,le.avelength_phone,le.avelength_phone_extension,le.avelength_prim_name,le.avelength_record_id,le.avelength_record_type,le.avelength_relationship_code,le.avelength_relationship_code_exp,le.avelength_secondary_phone,le.avelength_sector,le.avelength_sic_code,le.avelength_state,le.avelength_unit_flag,le.avelength_unit_flag_exp,le.avelength_v_city_name,le.avelength_zip_code,le.avelength_zip_code4);
END;
EXPORT invSummary := NORMALIZE(summary0, 37, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,IF (le.ace_aid <> 0,TRIM((SALT311.StrType)le.ace_aid), ''),TRIM((SALT311.StrType)le.address1),TRIM((SALT311.StrType)le.brand_name),TRIM((SALT311.StrType)le.chk_digit),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.clean_phone),TRIM((SALT311.StrType)le.clean_secondary_phone),TRIM((SALT311.StrType)le.company_name),TRIM((SALT311.StrType)le.dt_first_seen),TRIM((SALT311.StrType)le.dt_last_seen),TRIM((SALT311.StrType)le.dt_vendor_first_reported),TRIM((SALT311.StrType)le.dt_vendor_last_reported),TRIM((SALT311.StrType)le.err_stat),TRIM((SALT311.StrType)le.fips_county),TRIM((SALT311.StrType)le.fips_state),TRIM((SALT311.StrType)le.franchisee_id),TRIM((SALT311.StrType)le.fruns),TRIM((SALT311.StrType)le.f_units),TRIM((SALT311.StrType)le.industry),TRIM((SALT311.StrType)le.industry_type),TRIM((SALT311.StrType)le.p_city_name),TRIM((SALT311.StrType)le.phone),TRIM((SALT311.StrType)le.phone_extension),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.record_id),TRIM((SALT311.StrType)le.record_type),TRIM((SALT311.StrType)le.relationship_code),TRIM((SALT311.StrType)le.relationship_code_exp),TRIM((SALT311.StrType)le.secondary_phone),TRIM((SALT311.StrType)le.sector),TRIM((SALT311.StrType)le.sic_code),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.unit_flag),TRIM((SALT311.StrType)le.unit_flag_exp),TRIM((SALT311.StrType)le.v_city_name),TRIM((SALT311.StrType)le.zip_code),TRIM((SALT311.StrType)le.zip_code4)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,37,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 37);
  SELF.FldNo2 := 1 + (C % 37);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,IF (le.ace_aid <> 0,TRIM((SALT311.StrType)le.ace_aid), ''),TRIM((SALT311.StrType)le.address1),TRIM((SALT311.StrType)le.brand_name),TRIM((SALT311.StrType)le.chk_digit),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.clean_phone),TRIM((SALT311.StrType)le.clean_secondary_phone),TRIM((SALT311.StrType)le.company_name),TRIM((SALT311.StrType)le.dt_first_seen),TRIM((SALT311.StrType)le.dt_last_seen),TRIM((SALT311.StrType)le.dt_vendor_first_reported),TRIM((SALT311.StrType)le.dt_vendor_last_reported),TRIM((SALT311.StrType)le.err_stat),TRIM((SALT311.StrType)le.fips_county),TRIM((SALT311.StrType)le.fips_state),TRIM((SALT311.StrType)le.franchisee_id),TRIM((SALT311.StrType)le.fruns),TRIM((SALT311.StrType)le.f_units),TRIM((SALT311.StrType)le.industry),TRIM((SALT311.StrType)le.industry_type),TRIM((SALT311.StrType)le.p_city_name),TRIM((SALT311.StrType)le.phone),TRIM((SALT311.StrType)le.phone_extension),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.record_id),TRIM((SALT311.StrType)le.record_type),TRIM((SALT311.StrType)le.relationship_code),TRIM((SALT311.StrType)le.relationship_code_exp),TRIM((SALT311.StrType)le.secondary_phone),TRIM((SALT311.StrType)le.sector),TRIM((SALT311.StrType)le.sic_code),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.unit_flag),TRIM((SALT311.StrType)le.unit_flag_exp),TRIM((SALT311.StrType)le.v_city_name),TRIM((SALT311.StrType)le.zip_code),TRIM((SALT311.StrType)le.zip_code4)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,IF (le.ace_aid <> 0,TRIM((SALT311.StrType)le.ace_aid), ''),TRIM((SALT311.StrType)le.address1),TRIM((SALT311.StrType)le.brand_name),TRIM((SALT311.StrType)le.chk_digit),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.clean_phone),TRIM((SALT311.StrType)le.clean_secondary_phone),TRIM((SALT311.StrType)le.company_name),TRIM((SALT311.StrType)le.dt_first_seen),TRIM((SALT311.StrType)le.dt_last_seen),TRIM((SALT311.StrType)le.dt_vendor_first_reported),TRIM((SALT311.StrType)le.dt_vendor_last_reported),TRIM((SALT311.StrType)le.err_stat),TRIM((SALT311.StrType)le.fips_county),TRIM((SALT311.StrType)le.fips_state),TRIM((SALT311.StrType)le.franchisee_id),TRIM((SALT311.StrType)le.fruns),TRIM((SALT311.StrType)le.f_units),TRIM((SALT311.StrType)le.industry),TRIM((SALT311.StrType)le.industry_type),TRIM((SALT311.StrType)le.p_city_name),TRIM((SALT311.StrType)le.phone),TRIM((SALT311.StrType)le.phone_extension),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.record_id),TRIM((SALT311.StrType)le.record_type),TRIM((SALT311.StrType)le.relationship_code),TRIM((SALT311.StrType)le.relationship_code_exp),TRIM((SALT311.StrType)le.secondary_phone),TRIM((SALT311.StrType)le.sector),TRIM((SALT311.StrType)le.sic_code),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.unit_flag),TRIM((SALT311.StrType)le.unit_flag_exp),TRIM((SALT311.StrType)le.v_city_name),TRIM((SALT311.StrType)le.zip_code),TRIM((SALT311.StrType)le.zip_code4)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),37*37,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'ace_aid'}
      ,{2,'address1'}
      ,{3,'brand_name'}
      ,{4,'chk_digit'}
      ,{5,'city'}
      ,{6,'clean_phone'}
      ,{7,'clean_secondary_phone'}
      ,{8,'company_name'}
      ,{9,'dt_first_seen'}
      ,{10,'dt_last_seen'}
      ,{11,'dt_vendor_first_reported'}
      ,{12,'dt_vendor_last_reported'}
      ,{13,'err_stat'}
      ,{14,'fips_county'}
      ,{15,'fips_state'}
      ,{16,'franchisee_id'}
      ,{17,'fruns'}
      ,{18,'f_units'}
      ,{19,'industry'}
      ,{20,'industry_type'}
      ,{21,'p_city_name'}
      ,{22,'phone'}
      ,{23,'phone_extension'}
      ,{24,'prim_name'}
      ,{25,'record_id'}
      ,{26,'record_type'}
      ,{27,'relationship_code'}
      ,{28,'relationship_code_exp'}
      ,{29,'secondary_phone'}
      ,{30,'sector'}
      ,{31,'sic_code'}
      ,{32,'state'}
      ,{33,'unit_flag'}
      ,{34,'unit_flag_exp'}
      ,{35,'v_city_name'}
      ,{36,'zip_code'}
      ,{37,'zip_code4'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Base_Fields.InValid_ace_aid((SALT311.StrType)le.ace_aid),
    Base_Fields.InValid_address1((SALT311.StrType)le.address1),
    Base_Fields.InValid_brand_name((SALT311.StrType)le.brand_name),
    Base_Fields.InValid_chk_digit((SALT311.StrType)le.chk_digit),
    Base_Fields.InValid_city((SALT311.StrType)le.city),
    Base_Fields.InValid_clean_phone((SALT311.StrType)le.clean_phone),
    Base_Fields.InValid_clean_secondary_phone((SALT311.StrType)le.clean_secondary_phone),
    Base_Fields.InValid_company_name((SALT311.StrType)le.company_name),
    Base_Fields.InValid_dt_first_seen((SALT311.StrType)le.dt_first_seen),
    Base_Fields.InValid_dt_last_seen((SALT311.StrType)le.dt_last_seen),
    Base_Fields.InValid_dt_vendor_first_reported((SALT311.StrType)le.dt_vendor_first_reported),
    Base_Fields.InValid_dt_vendor_last_reported((SALT311.StrType)le.dt_vendor_last_reported),
    Base_Fields.InValid_err_stat((SALT311.StrType)le.err_stat),
    Base_Fields.InValid_fips_county((SALT311.StrType)le.fips_county),
    Base_Fields.InValid_fips_state((SALT311.StrType)le.fips_state),
    Base_Fields.InValid_franchisee_id((SALT311.StrType)le.franchisee_id),
    Base_Fields.InValid_fruns((SALT311.StrType)le.fruns),
    Base_Fields.InValid_f_units((SALT311.StrType)le.f_units),
    Base_Fields.InValid_industry((SALT311.StrType)le.industry),
    Base_Fields.InValid_industry_type((SALT311.StrType)le.industry_type),
    Base_Fields.InValid_p_city_name((SALT311.StrType)le.p_city_name),
    Base_Fields.InValid_phone((SALT311.StrType)le.phone),
    Base_Fields.InValid_phone_extension((SALT311.StrType)le.phone_extension),
    Base_Fields.InValid_prim_name((SALT311.StrType)le.prim_name),
    Base_Fields.InValid_record_id((SALT311.StrType)le.record_id),
    Base_Fields.InValid_record_type((SALT311.StrType)le.record_type),
    Base_Fields.InValid_relationship_code((SALT311.StrType)le.relationship_code),
    Base_Fields.InValid_relationship_code_exp((SALT311.StrType)le.relationship_code_exp),
    Base_Fields.InValid_secondary_phone((SALT311.StrType)le.secondary_phone),
    Base_Fields.InValid_sector((SALT311.StrType)le.sector),
    Base_Fields.InValid_sic_code((SALT311.StrType)le.sic_code),
    Base_Fields.InValid_state((SALT311.StrType)le.state),
    Base_Fields.InValid_unit_flag((SALT311.StrType)le.unit_flag),
    Base_Fields.InValid_unit_flag_exp((SALT311.StrType)le.unit_flag_exp),
    Base_Fields.InValid_v_city_name((SALT311.StrType)le.v_city_name),
    Base_Fields.InValid_zip_code((SALT311.StrType)le.zip_code),
    Base_Fields.InValid_zip_code4((SALT311.StrType)le.zip_code4),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,37,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Base_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_ace_aid','invalid_alpha','invalid_alpha','invalid_chk_digit','invalid_alpha','invalid_phone','invalid_secondary_phone','invalid_company_name','invalid_date','invalid_date','invalid_date','invalid_date','invalid_err_stat','invalid_fips_county','invalid_fips_state','invalid_franchisee_id','invalid_fruns','invalid_nonempty_number','invalid_alpha','invalid_industry_type','invalid_alpha','invalid_phone','invalid_numeric','invalid_alpha','invalid_nonempty_number','invalid_record_type','invalid_relationship_code','invalid_relationship_code_exp','invalid_secondary_phone','invalid_alpha','invalid_sic_code','invalid_state','invalid_unit_flag','invalid_unit_flag_exp','invalid_alpha','invalid_zip_code','invalid_zip_code4');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Base_Fields.InValidMessage_ace_aid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_address1(TotalErrors.ErrorNum),Base_Fields.InValidMessage_brand_name(TotalErrors.ErrorNum),Base_Fields.InValidMessage_chk_digit(TotalErrors.ErrorNum),Base_Fields.InValidMessage_city(TotalErrors.ErrorNum),Base_Fields.InValidMessage_clean_phone(TotalErrors.ErrorNum),Base_Fields.InValidMessage_clean_secondary_phone(TotalErrors.ErrorNum),Base_Fields.InValidMessage_company_name(TotalErrors.ErrorNum),Base_Fields.InValidMessage_dt_first_seen(TotalErrors.ErrorNum),Base_Fields.InValidMessage_dt_last_seen(TotalErrors.ErrorNum),Base_Fields.InValidMessage_dt_vendor_first_reported(TotalErrors.ErrorNum),Base_Fields.InValidMessage_dt_vendor_last_reported(TotalErrors.ErrorNum),Base_Fields.InValidMessage_err_stat(TotalErrors.ErrorNum),Base_Fields.InValidMessage_fips_county(TotalErrors.ErrorNum),Base_Fields.InValidMessage_fips_state(TotalErrors.ErrorNum),Base_Fields.InValidMessage_franchisee_id(TotalErrors.ErrorNum),Base_Fields.InValidMessage_fruns(TotalErrors.ErrorNum),Base_Fields.InValidMessage_f_units(TotalErrors.ErrorNum),Base_Fields.InValidMessage_industry(TotalErrors.ErrorNum),Base_Fields.InValidMessage_industry_type(TotalErrors.ErrorNum),Base_Fields.InValidMessage_p_city_name(TotalErrors.ErrorNum),Base_Fields.InValidMessage_phone(TotalErrors.ErrorNum),Base_Fields.InValidMessage_phone_extension(TotalErrors.ErrorNum),Base_Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Base_Fields.InValidMessage_record_id(TotalErrors.ErrorNum),Base_Fields.InValidMessage_record_type(TotalErrors.ErrorNum),Base_Fields.InValidMessage_relationship_code(TotalErrors.ErrorNum),Base_Fields.InValidMessage_relationship_code_exp(TotalErrors.ErrorNum),Base_Fields.InValidMessage_secondary_phone(TotalErrors.ErrorNum),Base_Fields.InValidMessage_sector(TotalErrors.ErrorNum),Base_Fields.InValidMessage_sic_code(TotalErrors.ErrorNum),Base_Fields.InValidMessage_state(TotalErrors.ErrorNum),Base_Fields.InValidMessage_unit_flag(TotalErrors.ErrorNum),Base_Fields.InValidMessage_unit_flag_exp(TotalErrors.ErrorNum),Base_Fields.InValidMessage_v_city_name(TotalErrors.ErrorNum),Base_Fields.InValidMessage_zip_code(TotalErrors.ErrorNum),Base_Fields.InValidMessage_zip_code4(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Frandx, Base_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
