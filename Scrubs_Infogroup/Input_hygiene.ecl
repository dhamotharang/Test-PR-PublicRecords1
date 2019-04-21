IMPORT SALT37;
EXPORT Input_hygiene(dataset(Input_layout_Infogroup) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT37.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_occupation_id_pcnt := AVE(GROUP,IF(h.occupation_id = (TYPEOF(h.occupation_id))'',0,100));
    maxlength_occupation_id := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.occupation_id)));
    avelength_occupation_id := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.occupation_id)),h.occupation_id<>(typeof(h.occupation_id))'');
    populated_first_name_pcnt := AVE(GROUP,IF(h.first_name = (TYPEOF(h.first_name))'',0,100));
    maxlength_first_name := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.first_name)));
    avelength_first_name := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.first_name)),h.first_name<>(typeof(h.first_name))'');
    populated_middle_name_pcnt := AVE(GROUP,IF(h.middle_name = (TYPEOF(h.middle_name))'',0,100));
    maxlength_middle_name := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.middle_name)));
    avelength_middle_name := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.middle_name)),h.middle_name<>(typeof(h.middle_name))'');
    populated_last_name_pcnt := AVE(GROUP,IF(h.last_name = (TYPEOF(h.last_name))'',0,100));
    maxlength_last_name := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.last_name)));
    avelength_last_name := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.last_name)),h.last_name<>(typeof(h.last_name))'');
    populated_suffix_pcnt := AVE(GROUP,IF(h.suffix = (TYPEOF(h.suffix))'',0,100));
    maxlength_suffix := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.suffix)));
    avelength_suffix := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.suffix)),h.suffix<>(typeof(h.suffix))'');
    populated_address_pcnt := AVE(GROUP,IF(h.address = (TYPEOF(h.address))'',0,100));
    maxlength_address := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.address)));
    avelength_address := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.address)),h.address<>(typeof(h.address))'');
    populated_prim_range_pcnt := AVE(GROUP,IF(h.prim_range = (TYPEOF(h.prim_range))'',0,100));
    maxlength_prim_range := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.prim_range)));
    avelength_prim_range := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.prim_range)),h.prim_range<>(typeof(h.prim_range))'');
    populated_predir_pcnt := AVE(GROUP,IF(h.predir = (TYPEOF(h.predir))'',0,100));
    maxlength_predir := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.predir)));
    avelength_predir := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.predir)),h.predir<>(typeof(h.predir))'');
    populated_prim_name_pcnt := AVE(GROUP,IF(h.prim_name = (TYPEOF(h.prim_name))'',0,100));
    maxlength_prim_name := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.prim_name)));
    avelength_prim_name := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.prim_name)),h.prim_name<>(typeof(h.prim_name))'');
    populated_addr_suffix_pcnt := AVE(GROUP,IF(h.addr_suffix = (TYPEOF(h.addr_suffix))'',0,100));
    maxlength_addr_suffix := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.addr_suffix)));
    avelength_addr_suffix := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.addr_suffix)),h.addr_suffix<>(typeof(h.addr_suffix))'');
    populated_postdir_pcnt := AVE(GROUP,IF(h.postdir = (TYPEOF(h.postdir))'',0,100));
    maxlength_postdir := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.postdir)));
    avelength_postdir := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.postdir)),h.postdir<>(typeof(h.postdir))'');
    populated_unit_type_pcnt := AVE(GROUP,IF(h.unit_type = (TYPEOF(h.unit_type))'',0,100));
    maxlength_unit_type := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.unit_type)));
    avelength_unit_type := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.unit_type)),h.unit_type<>(typeof(h.unit_type))'');
    populated_unit_number_pcnt := AVE(GROUP,IF(h.unit_number = (TYPEOF(h.unit_number))'',0,100));
    maxlength_unit_number := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.unit_number)));
    avelength_unit_number := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.unit_number)),h.unit_number<>(typeof(h.unit_number))'');
    populated_city_pcnt := AVE(GROUP,IF(h.city = (TYPEOF(h.city))'',0,100));
    maxlength_city := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.city)));
    avelength_city := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.city)),h.city<>(typeof(h.city))'');
    populated_state_pcnt := AVE(GROUP,IF(h.state = (TYPEOF(h.state))'',0,100));
    maxlength_state := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.state)));
    avelength_state := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.state)),h.state<>(typeof(h.state))'');
    populated_zip_pcnt := AVE(GROUP,IF(h.zip = (TYPEOF(h.zip))'',0,100));
    maxlength_zip := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.zip)));
    avelength_zip := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.zip)),h.zip<>(typeof(h.zip))'');
    populated_zip4_pcnt := AVE(GROUP,IF(h.zip4 = (TYPEOF(h.zip4))'',0,100));
    maxlength_zip4 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.zip4)));
    avelength_zip4 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.zip4)),h.zip4<>(typeof(h.zip4))'');
    populated_bar_pcnt := AVE(GROUP,IF(h.bar = (TYPEOF(h.bar))'',0,100));
    maxlength_bar := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.bar)));
    avelength_bar := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.bar)),h.bar<>(typeof(h.bar))'');
    populated_ace_rec_type_pcnt := AVE(GROUP,IF(h.ace_rec_type = (TYPEOF(h.ace_rec_type))'',0,100));
    maxlength_ace_rec_type := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.ace_rec_type)));
    avelength_ace_rec_type := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.ace_rec_type)),h.ace_rec_type<>(typeof(h.ace_rec_type))'');
    populated_cart_pcnt := AVE(GROUP,IF(h.cart = (TYPEOF(h.cart))'',0,100));
    maxlength_cart := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.cart)));
    avelength_cart := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.cart)),h.cart<>(typeof(h.cart))'');
    populated_census_state_code_pcnt := AVE(GROUP,IF(h.census_state_code = (TYPEOF(h.census_state_code))'',0,100));
    maxlength_census_state_code := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.census_state_code)));
    avelength_census_state_code := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.census_state_code)),h.census_state_code<>(typeof(h.census_state_code))'');
    populated_census_county_code_pcnt := AVE(GROUP,IF(h.census_county_code = (TYPEOF(h.census_county_code))'',0,100));
    maxlength_census_county_code := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.census_county_code)));
    avelength_census_county_code := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.census_county_code)),h.census_county_code<>(typeof(h.census_county_code))'');
    populated_county_code_desc_pcnt := AVE(GROUP,IF(h.county_code_desc = (TYPEOF(h.county_code_desc))'',0,100));
    maxlength_county_code_desc := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.county_code_desc)));
    avelength_county_code_desc := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.county_code_desc)),h.county_code_desc<>(typeof(h.county_code_desc))'');
    populated_census_tract_pcnt := AVE(GROUP,IF(h.census_tract = (TYPEOF(h.census_tract))'',0,100));
    maxlength_census_tract := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.census_tract)));
    avelength_census_tract := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.census_tract)),h.census_tract<>(typeof(h.census_tract))'');
    populated_census_block_group_pcnt := AVE(GROUP,IF(h.census_block_group = (TYPEOF(h.census_block_group))'',0,100));
    maxlength_census_block_group := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.census_block_group)));
    avelength_census_block_group := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.census_block_group)),h.census_block_group<>(typeof(h.census_block_group))'');
    populated_match_code_pcnt := AVE(GROUP,IF(h.match_code = (TYPEOF(h.match_code))'',0,100));
    maxlength_match_code := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.match_code)));
    avelength_match_code := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.match_code)),h.match_code<>(typeof(h.match_code))'');
    populated_latitude_pcnt := AVE(GROUP,IF(h.latitude = (TYPEOF(h.latitude))'',0,100));
    maxlength_latitude := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.latitude)));
    avelength_latitude := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.latitude)),h.latitude<>(typeof(h.latitude))'');
    populated_longitude_pcnt := AVE(GROUP,IF(h.longitude = (TYPEOF(h.longitude))'',0,100));
    maxlength_longitude := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.longitude)));
    avelength_longitude := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.longitude)),h.longitude<>(typeof(h.longitude))'');
    populated_mail_score_pcnt := AVE(GROUP,IF(h.mail_score = (TYPEOF(h.mail_score))'',0,100));
    maxlength_mail_score := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.mail_score)));
    avelength_mail_score := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.mail_score)),h.mail_score<>(typeof(h.mail_score))'');
    populated_residential_business_ind_pcnt := AVE(GROUP,IF(h.residential_business_ind = (TYPEOF(h.residential_business_ind))'',0,100));
    maxlength_residential_business_ind := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.residential_business_ind)));
    avelength_residential_business_ind := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.residential_business_ind)),h.residential_business_ind<>(typeof(h.residential_business_ind))'');
    populated_employer_name_pcnt := AVE(GROUP,IF(h.employer_name = (TYPEOF(h.employer_name))'',0,100));
    maxlength_employer_name := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.employer_name)));
    avelength_employer_name := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.employer_name)),h.employer_name<>(typeof(h.employer_name))'');
    populated_family_id_pcnt := AVE(GROUP,IF(h.family_id = (TYPEOF(h.family_id))'',0,100));
    maxlength_family_id := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.family_id)));
    avelength_family_id := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.family_id)),h.family_id<>(typeof(h.family_id))'');
    populated_individual_id_pcnt := AVE(GROUP,IF(h.individual_id = (TYPEOF(h.individual_id))'',0,100));
    maxlength_individual_id := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.individual_id)));
    avelength_individual_id := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.individual_id)),h.individual_id<>(typeof(h.individual_id))'');
    populated_abi_number_pcnt := AVE(GROUP,IF(h.abi_number = (TYPEOF(h.abi_number))'',0,100));
    maxlength_abi_number := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.abi_number)));
    avelength_abi_number := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.abi_number)),h.abi_number<>(typeof(h.abi_number))'');
    populated_industry_title_pcnt := AVE(GROUP,IF(h.industry_title = (TYPEOF(h.industry_title))'',0,100));
    maxlength_industry_title := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.industry_title)));
    avelength_industry_title := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.industry_title)),h.industry_title<>(typeof(h.industry_title))'');
    populated_occupation_title_pcnt := AVE(GROUP,IF(h.occupation_title = (TYPEOF(h.occupation_title))'',0,100));
    maxlength_occupation_title := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.occupation_title)));
    avelength_occupation_title := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.occupation_title)),h.occupation_title<>(typeof(h.occupation_title))'');
    populated_specialty_title_pcnt := AVE(GROUP,IF(h.specialty_title = (TYPEOF(h.specialty_title))'',0,100));
    maxlength_specialty_title := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.specialty_title)));
    avelength_specialty_title := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.specialty_title)),h.specialty_title<>(typeof(h.specialty_title))'');
    populated_sic_code_pcnt := AVE(GROUP,IF(h.sic_code = (TYPEOF(h.sic_code))'',0,100));
    maxlength_sic_code := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.sic_code)));
    avelength_sic_code := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.sic_code)),h.sic_code<>(typeof(h.sic_code))'');
    populated_naics_group_pcnt := AVE(GROUP,IF(h.naics_group = (TYPEOF(h.naics_group))'',0,100));
    maxlength_naics_group := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.naics_group)));
    avelength_naics_group := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.naics_group)),h.naics_group<>(typeof(h.naics_group))'');
    populated_license_state_pcnt := AVE(GROUP,IF(h.license_state = (TYPEOF(h.license_state))'',0,100));
    maxlength_license_state := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.license_state)));
    avelength_license_state := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.license_state)),h.license_state<>(typeof(h.license_state))'');
    populated_license_id_pcnt := AVE(GROUP,IF(h.license_id = (TYPEOF(h.license_id))'',0,100));
    maxlength_license_id := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.license_id)));
    avelength_license_id := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.license_id)),h.license_id<>(typeof(h.license_id))'');
    populated_license_number_pcnt := AVE(GROUP,IF(h.license_number = (TYPEOF(h.license_number))'',0,100));
    maxlength_license_number := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.license_number)));
    avelength_license_number := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.license_number)),h.license_number<>(typeof(h.license_number))'');
    populated_exp_date_pcnt := AVE(GROUP,IF(h.exp_date = (TYPEOF(h.exp_date))'',0,100));
    maxlength_exp_date := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.exp_date)));
    avelength_exp_date := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.exp_date)),h.exp_date<>(typeof(h.exp_date))'');
    populated_status_code_pcnt := AVE(GROUP,IF(h.status_code = (TYPEOF(h.status_code))'',0,100));
    maxlength_status_code := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.status_code)));
    avelength_status_code := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.status_code)),h.status_code<>(typeof(h.status_code))'');
    populated_effective_date_pcnt := AVE(GROUP,IF(h.effective_date = (TYPEOF(h.effective_date))'',0,100));
    maxlength_effective_date := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.effective_date)));
    avelength_effective_date := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.effective_date)),h.effective_date<>(typeof(h.effective_date))'');
    populated_add_date_pcnt := AVE(GROUP,IF(h.add_date = (TYPEOF(h.add_date))'',0,100));
    maxlength_add_date := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.add_date)));
    avelength_add_date := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.add_date)),h.add_date<>(typeof(h.add_date))'');
    populated_change_date_pcnt := AVE(GROUP,IF(h.change_date = (TYPEOF(h.change_date))'',0,100));
    maxlength_change_date := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.change_date)));
    avelength_change_date := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.change_date)),h.change_date<>(typeof(h.change_date))'');
    populated_year_licensed_pcnt := AVE(GROUP,IF(h.year_licensed = (TYPEOF(h.year_licensed))'',0,100));
    maxlength_year_licensed := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.year_licensed)));
    avelength_year_licensed := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.year_licensed)),h.year_licensed<>(typeof(h.year_licensed))'');
    populated_carriage_return_pcnt := AVE(GROUP,IF(h.carriage_return = (TYPEOF(h.carriage_return))'',0,100));
    maxlength_carriage_return := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.carriage_return)));
    avelength_carriage_return := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.carriage_return)),h.carriage_return<>(typeof(h.carriage_return))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_occupation_id_pcnt *   0.00 / 100 + T.Populated_first_name_pcnt *   0.00 / 100 + T.Populated_middle_name_pcnt *   0.00 / 100 + T.Populated_last_name_pcnt *   0.00 / 100 + T.Populated_suffix_pcnt *   0.00 / 100 + T.Populated_address_pcnt *   0.00 / 100 + T.Populated_prim_range_pcnt *   0.00 / 100 + T.Populated_predir_pcnt *   0.00 / 100 + T.Populated_prim_name_pcnt *   0.00 / 100 + T.Populated_addr_suffix_pcnt *   0.00 / 100 + T.Populated_postdir_pcnt *   0.00 / 100 + T.Populated_unit_type_pcnt *   0.00 / 100 + T.Populated_unit_number_pcnt *   0.00 / 100 + T.Populated_city_pcnt *   0.00 / 100 + T.Populated_state_pcnt *   0.00 / 100 + T.Populated_zip_pcnt *   0.00 / 100 + T.Populated_zip4_pcnt *   0.00 / 100 + T.Populated_bar_pcnt *   0.00 / 100 + T.Populated_ace_rec_type_pcnt *   0.00 / 100 + T.Populated_cart_pcnt *   0.00 / 100 + T.Populated_census_state_code_pcnt *   0.00 / 100 + T.Populated_census_county_code_pcnt *   0.00 / 100 + T.Populated_county_code_desc_pcnt *   0.00 / 100 + T.Populated_census_tract_pcnt *   0.00 / 100 + T.Populated_census_block_group_pcnt *   0.00 / 100 + T.Populated_match_code_pcnt *   0.00 / 100 + T.Populated_latitude_pcnt *   0.00 / 100 + T.Populated_longitude_pcnt *   0.00 / 100 + T.Populated_mail_score_pcnt *   0.00 / 100 + T.Populated_residential_business_ind_pcnt *   0.00 / 100 + T.Populated_employer_name_pcnt *   0.00 / 100 + T.Populated_family_id_pcnt *   0.00 / 100 + T.Populated_individual_id_pcnt *   0.00 / 100 + T.Populated_abi_number_pcnt *   0.00 / 100 + T.Populated_industry_title_pcnt *   0.00 / 100 + T.Populated_occupation_title_pcnt *   0.00 / 100 + T.Populated_specialty_title_pcnt *   0.00 / 100 + T.Populated_sic_code_pcnt *   0.00 / 100 + T.Populated_naics_group_pcnt *   0.00 / 100 + T.Populated_license_state_pcnt *   0.00 / 100 + T.Populated_license_id_pcnt *   0.00 / 100 + T.Populated_license_number_pcnt *   0.00 / 100 + T.Populated_exp_date_pcnt *   0.00 / 100 + T.Populated_status_code_pcnt *   0.00 / 100 + T.Populated_effective_date_pcnt *   0.00 / 100 + T.Populated_add_date_pcnt *   0.00 / 100 + T.Populated_change_date_pcnt *   0.00 / 100 + T.Populated_year_licensed_pcnt *   0.00 / 100 + T.Populated_carriage_return_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
invRec := RECORD
  UNSIGNED  FldNo;
  SALT37.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'occupation_id','first_name','middle_name','last_name','suffix','address','prim_range','predir','prim_name','addr_suffix','postdir','unit_type','unit_number','city','state','zip','zip4','bar','ace_rec_type','cart','census_state_code','census_county_code','county_code_desc','census_tract','census_block_group','match_code','latitude','longitude','mail_score','residential_business_ind','employer_name','family_id','individual_id','abi_number','industry_title','occupation_title','specialty_title','sic_code','naics_group','license_state','license_id','license_number','exp_date','status_code','effective_date','add_date','change_date','year_licensed','carriage_return');
  SELF.populated_pcnt := CHOOSE(C,le.populated_occupation_id_pcnt,le.populated_first_name_pcnt,le.populated_middle_name_pcnt,le.populated_last_name_pcnt,le.populated_suffix_pcnt,le.populated_address_pcnt,le.populated_prim_range_pcnt,le.populated_predir_pcnt,le.populated_prim_name_pcnt,le.populated_addr_suffix_pcnt,le.populated_postdir_pcnt,le.populated_unit_type_pcnt,le.populated_unit_number_pcnt,le.populated_city_pcnt,le.populated_state_pcnt,le.populated_zip_pcnt,le.populated_zip4_pcnt,le.populated_bar_pcnt,le.populated_ace_rec_type_pcnt,le.populated_cart_pcnt,le.populated_census_state_code_pcnt,le.populated_census_county_code_pcnt,le.populated_county_code_desc_pcnt,le.populated_census_tract_pcnt,le.populated_census_block_group_pcnt,le.populated_match_code_pcnt,le.populated_latitude_pcnt,le.populated_longitude_pcnt,le.populated_mail_score_pcnt,le.populated_residential_business_ind_pcnt,le.populated_employer_name_pcnt,le.populated_family_id_pcnt,le.populated_individual_id_pcnt,le.populated_abi_number_pcnt,le.populated_industry_title_pcnt,le.populated_occupation_title_pcnt,le.populated_specialty_title_pcnt,le.populated_sic_code_pcnt,le.populated_naics_group_pcnt,le.populated_license_state_pcnt,le.populated_license_id_pcnt,le.populated_license_number_pcnt,le.populated_exp_date_pcnt,le.populated_status_code_pcnt,le.populated_effective_date_pcnt,le.populated_add_date_pcnt,le.populated_change_date_pcnt,le.populated_year_licensed_pcnt,le.populated_carriage_return_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_occupation_id,le.maxlength_first_name,le.maxlength_middle_name,le.maxlength_last_name,le.maxlength_suffix,le.maxlength_address,le.maxlength_prim_range,le.maxlength_predir,le.maxlength_prim_name,le.maxlength_addr_suffix,le.maxlength_postdir,le.maxlength_unit_type,le.maxlength_unit_number,le.maxlength_city,le.maxlength_state,le.maxlength_zip,le.maxlength_zip4,le.maxlength_bar,le.maxlength_ace_rec_type,le.maxlength_cart,le.maxlength_census_state_code,le.maxlength_census_county_code,le.maxlength_county_code_desc,le.maxlength_census_tract,le.maxlength_census_block_group,le.maxlength_match_code,le.maxlength_latitude,le.maxlength_longitude,le.maxlength_mail_score,le.maxlength_residential_business_ind,le.maxlength_employer_name,le.maxlength_family_id,le.maxlength_individual_id,le.maxlength_abi_number,le.maxlength_industry_title,le.maxlength_occupation_title,le.maxlength_specialty_title,le.maxlength_sic_code,le.maxlength_naics_group,le.maxlength_license_state,le.maxlength_license_id,le.maxlength_license_number,le.maxlength_exp_date,le.maxlength_status_code,le.maxlength_effective_date,le.maxlength_add_date,le.maxlength_change_date,le.maxlength_year_licensed,le.maxlength_carriage_return);
  SELF.avelength := CHOOSE(C,le.avelength_occupation_id,le.avelength_first_name,le.avelength_middle_name,le.avelength_last_name,le.avelength_suffix,le.avelength_address,le.avelength_prim_range,le.avelength_predir,le.avelength_prim_name,le.avelength_addr_suffix,le.avelength_postdir,le.avelength_unit_type,le.avelength_unit_number,le.avelength_city,le.avelength_state,le.avelength_zip,le.avelength_zip4,le.avelength_bar,le.avelength_ace_rec_type,le.avelength_cart,le.avelength_census_state_code,le.avelength_census_county_code,le.avelength_county_code_desc,le.avelength_census_tract,le.avelength_census_block_group,le.avelength_match_code,le.avelength_latitude,le.avelength_longitude,le.avelength_mail_score,le.avelength_residential_business_ind,le.avelength_employer_name,le.avelength_family_id,le.avelength_individual_id,le.avelength_abi_number,le.avelength_industry_title,le.avelength_occupation_title,le.avelength_specialty_title,le.avelength_sic_code,le.avelength_naics_group,le.avelength_license_state,le.avelength_license_id,le.avelength_license_number,le.avelength_exp_date,le.avelength_status_code,le.avelength_effective_date,le.avelength_add_date,le.avelength_change_date,le.avelength_year_licensed,le.avelength_carriage_return);
END;
EXPORT invSummary := NORMALIZE(summary0, 49, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT37.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT37.StrType)le.occupation_id),TRIM((SALT37.StrType)le.first_name),TRIM((SALT37.StrType)le.middle_name),TRIM((SALT37.StrType)le.last_name),TRIM((SALT37.StrType)le.suffix),TRIM((SALT37.StrType)le.address),TRIM((SALT37.StrType)le.prim_range),TRIM((SALT37.StrType)le.predir),TRIM((SALT37.StrType)le.prim_name),TRIM((SALT37.StrType)le.addr_suffix),TRIM((SALT37.StrType)le.postdir),TRIM((SALT37.StrType)le.unit_type),TRIM((SALT37.StrType)le.unit_number),TRIM((SALT37.StrType)le.city),TRIM((SALT37.StrType)le.state),TRIM((SALT37.StrType)le.zip),TRIM((SALT37.StrType)le.zip4),TRIM((SALT37.StrType)le.bar),TRIM((SALT37.StrType)le.ace_rec_type),TRIM((SALT37.StrType)le.cart),TRIM((SALT37.StrType)le.census_state_code),TRIM((SALT37.StrType)le.census_county_code),TRIM((SALT37.StrType)le.county_code_desc),TRIM((SALT37.StrType)le.census_tract),TRIM((SALT37.StrType)le.census_block_group),TRIM((SALT37.StrType)le.match_code),TRIM((SALT37.StrType)le.latitude),TRIM((SALT37.StrType)le.longitude),TRIM((SALT37.StrType)le.mail_score),TRIM((SALT37.StrType)le.residential_business_ind),TRIM((SALT37.StrType)le.employer_name),TRIM((SALT37.StrType)le.family_id),TRIM((SALT37.StrType)le.individual_id),TRIM((SALT37.StrType)le.abi_number),TRIM((SALT37.StrType)le.industry_title),TRIM((SALT37.StrType)le.occupation_title),TRIM((SALT37.StrType)le.specialty_title),TRIM((SALT37.StrType)le.sic_code),TRIM((SALT37.StrType)le.naics_group),TRIM((SALT37.StrType)le.license_state),TRIM((SALT37.StrType)le.license_id),TRIM((SALT37.StrType)le.license_number),TRIM((SALT37.StrType)le.exp_date),TRIM((SALT37.StrType)le.status_code),TRIM((SALT37.StrType)le.effective_date),TRIM((SALT37.StrType)le.add_date),TRIM((SALT37.StrType)le.change_date),TRIM((SALT37.StrType)le.year_licensed),TRIM((SALT37.StrType)le.carriage_return)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,49,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT37.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 49);
  SELF.FldNo2 := 1 + (C % 49);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT37.StrType)le.occupation_id),TRIM((SALT37.StrType)le.first_name),TRIM((SALT37.StrType)le.middle_name),TRIM((SALT37.StrType)le.last_name),TRIM((SALT37.StrType)le.suffix),TRIM((SALT37.StrType)le.address),TRIM((SALT37.StrType)le.prim_range),TRIM((SALT37.StrType)le.predir),TRIM((SALT37.StrType)le.prim_name),TRIM((SALT37.StrType)le.addr_suffix),TRIM((SALT37.StrType)le.postdir),TRIM((SALT37.StrType)le.unit_type),TRIM((SALT37.StrType)le.unit_number),TRIM((SALT37.StrType)le.city),TRIM((SALT37.StrType)le.state),TRIM((SALT37.StrType)le.zip),TRIM((SALT37.StrType)le.zip4),TRIM((SALT37.StrType)le.bar),TRIM((SALT37.StrType)le.ace_rec_type),TRIM((SALT37.StrType)le.cart),TRIM((SALT37.StrType)le.census_state_code),TRIM((SALT37.StrType)le.census_county_code),TRIM((SALT37.StrType)le.county_code_desc),TRIM((SALT37.StrType)le.census_tract),TRIM((SALT37.StrType)le.census_block_group),TRIM((SALT37.StrType)le.match_code),TRIM((SALT37.StrType)le.latitude),TRIM((SALT37.StrType)le.longitude),TRIM((SALT37.StrType)le.mail_score),TRIM((SALT37.StrType)le.residential_business_ind),TRIM((SALT37.StrType)le.employer_name),TRIM((SALT37.StrType)le.family_id),TRIM((SALT37.StrType)le.individual_id),TRIM((SALT37.StrType)le.abi_number),TRIM((SALT37.StrType)le.industry_title),TRIM((SALT37.StrType)le.occupation_title),TRIM((SALT37.StrType)le.specialty_title),TRIM((SALT37.StrType)le.sic_code),TRIM((SALT37.StrType)le.naics_group),TRIM((SALT37.StrType)le.license_state),TRIM((SALT37.StrType)le.license_id),TRIM((SALT37.StrType)le.license_number),TRIM((SALT37.StrType)le.exp_date),TRIM((SALT37.StrType)le.status_code),TRIM((SALT37.StrType)le.effective_date),TRIM((SALT37.StrType)le.add_date),TRIM((SALT37.StrType)le.change_date),TRIM((SALT37.StrType)le.year_licensed),TRIM((SALT37.StrType)le.carriage_return)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT37.StrType)le.occupation_id),TRIM((SALT37.StrType)le.first_name),TRIM((SALT37.StrType)le.middle_name),TRIM((SALT37.StrType)le.last_name),TRIM((SALT37.StrType)le.suffix),TRIM((SALT37.StrType)le.address),TRIM((SALT37.StrType)le.prim_range),TRIM((SALT37.StrType)le.predir),TRIM((SALT37.StrType)le.prim_name),TRIM((SALT37.StrType)le.addr_suffix),TRIM((SALT37.StrType)le.postdir),TRIM((SALT37.StrType)le.unit_type),TRIM((SALT37.StrType)le.unit_number),TRIM((SALT37.StrType)le.city),TRIM((SALT37.StrType)le.state),TRIM((SALT37.StrType)le.zip),TRIM((SALT37.StrType)le.zip4),TRIM((SALT37.StrType)le.bar),TRIM((SALT37.StrType)le.ace_rec_type),TRIM((SALT37.StrType)le.cart),TRIM((SALT37.StrType)le.census_state_code),TRIM((SALT37.StrType)le.census_county_code),TRIM((SALT37.StrType)le.county_code_desc),TRIM((SALT37.StrType)le.census_tract),TRIM((SALT37.StrType)le.census_block_group),TRIM((SALT37.StrType)le.match_code),TRIM((SALT37.StrType)le.latitude),TRIM((SALT37.StrType)le.longitude),TRIM((SALT37.StrType)le.mail_score),TRIM((SALT37.StrType)le.residential_business_ind),TRIM((SALT37.StrType)le.employer_name),TRIM((SALT37.StrType)le.family_id),TRIM((SALT37.StrType)le.individual_id),TRIM((SALT37.StrType)le.abi_number),TRIM((SALT37.StrType)le.industry_title),TRIM((SALT37.StrType)le.occupation_title),TRIM((SALT37.StrType)le.specialty_title),TRIM((SALT37.StrType)le.sic_code),TRIM((SALT37.StrType)le.naics_group),TRIM((SALT37.StrType)le.license_state),TRIM((SALT37.StrType)le.license_id),TRIM((SALT37.StrType)le.license_number),TRIM((SALT37.StrType)le.exp_date),TRIM((SALT37.StrType)le.status_code),TRIM((SALT37.StrType)le.effective_date),TRIM((SALT37.StrType)le.add_date),TRIM((SALT37.StrType)le.change_date),TRIM((SALT37.StrType)le.year_licensed),TRIM((SALT37.StrType)le.carriage_return)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),49*49,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'occupation_id'}
      ,{2,'first_name'}
      ,{3,'middle_name'}
      ,{4,'last_name'}
      ,{5,'suffix'}
      ,{6,'address'}
      ,{7,'prim_range'}
      ,{8,'predir'}
      ,{9,'prim_name'}
      ,{10,'addr_suffix'}
      ,{11,'postdir'}
      ,{12,'unit_type'}
      ,{13,'unit_number'}
      ,{14,'city'}
      ,{15,'state'}
      ,{16,'zip'}
      ,{17,'zip4'}
      ,{18,'bar'}
      ,{19,'ace_rec_type'}
      ,{20,'cart'}
      ,{21,'census_state_code'}
      ,{22,'census_county_code'}
      ,{23,'county_code_desc'}
      ,{24,'census_tract'}
      ,{25,'census_block_group'}
      ,{26,'match_code'}
      ,{27,'latitude'}
      ,{28,'longitude'}
      ,{29,'mail_score'}
      ,{30,'residential_business_ind'}
      ,{31,'employer_name'}
      ,{32,'family_id'}
      ,{33,'individual_id'}
      ,{34,'abi_number'}
      ,{35,'industry_title'}
      ,{36,'occupation_title'}
      ,{37,'specialty_title'}
      ,{38,'sic_code'}
      ,{39,'naics_group'}
      ,{40,'license_state'}
      ,{41,'license_id'}
      ,{42,'license_number'}
      ,{43,'exp_date'}
      ,{44,'status_code'}
      ,{45,'effective_date'}
      ,{46,'add_date'}
      ,{47,'change_date'}
      ,{48,'year_licensed'}
      ,{49,'carriage_return'}],SALT37.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT37.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT37.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT37.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Input_Fields.InValid_occupation_id((SALT37.StrType)le.occupation_id),
    Input_Fields.InValid_first_name((SALT37.StrType)le.first_name),
    Input_Fields.InValid_middle_name((SALT37.StrType)le.middle_name),
    Input_Fields.InValid_last_name((SALT37.StrType)le.last_name),
    Input_Fields.InValid_suffix((SALT37.StrType)le.suffix),
    Input_Fields.InValid_address((SALT37.StrType)le.address),
    Input_Fields.InValid_prim_range((SALT37.StrType)le.prim_range),
    Input_Fields.InValid_predir((SALT37.StrType)le.predir),
    Input_Fields.InValid_prim_name((SALT37.StrType)le.prim_name),
    Input_Fields.InValid_addr_suffix((SALT37.StrType)le.addr_suffix),
    Input_Fields.InValid_postdir((SALT37.StrType)le.postdir),
    Input_Fields.InValid_unit_type((SALT37.StrType)le.unit_type),
    Input_Fields.InValid_unit_number((SALT37.StrType)le.unit_number),
    Input_Fields.InValid_city((SALT37.StrType)le.city),
    Input_Fields.InValid_state((SALT37.StrType)le.state),
    Input_Fields.InValid_zip((SALT37.StrType)le.zip),
    Input_Fields.InValid_zip4((SALT37.StrType)le.zip4),
    Input_Fields.InValid_bar((SALT37.StrType)le.bar),
    Input_Fields.InValid_ace_rec_type((SALT37.StrType)le.ace_rec_type),
    Input_Fields.InValid_cart((SALT37.StrType)le.cart),
    Input_Fields.InValid_census_state_code((SALT37.StrType)le.census_state_code),
    Input_Fields.InValid_census_county_code((SALT37.StrType)le.census_county_code),
    Input_Fields.InValid_county_code_desc((SALT37.StrType)le.county_code_desc),
    Input_Fields.InValid_census_tract((SALT37.StrType)le.census_tract),
    Input_Fields.InValid_census_block_group((SALT37.StrType)le.census_block_group),
    Input_Fields.InValid_match_code((SALT37.StrType)le.match_code),
    Input_Fields.InValid_latitude((SALT37.StrType)le.latitude),
    Input_Fields.InValid_longitude((SALT37.StrType)le.longitude),
    Input_Fields.InValid_mail_score((SALT37.StrType)le.mail_score),
    Input_Fields.InValid_residential_business_ind((SALT37.StrType)le.residential_business_ind),
    Input_Fields.InValid_employer_name((SALT37.StrType)le.employer_name),
    Input_Fields.InValid_family_id((SALT37.StrType)le.family_id),
    Input_Fields.InValid_individual_id((SALT37.StrType)le.individual_id),
    Input_Fields.InValid_abi_number((SALT37.StrType)le.abi_number),
    Input_Fields.InValid_industry_title((SALT37.StrType)le.industry_title),
    Input_Fields.InValid_occupation_title((SALT37.StrType)le.occupation_title),
    Input_Fields.InValid_specialty_title((SALT37.StrType)le.specialty_title),
    Input_Fields.InValid_sic_code((SALT37.StrType)le.sic_code),
    Input_Fields.InValid_naics_group((SALT37.StrType)le.naics_group),
    Input_Fields.InValid_license_state((SALT37.StrType)le.license_state),
    Input_Fields.InValid_license_id((SALT37.StrType)le.license_id),
    Input_Fields.InValid_license_number((SALT37.StrType)le.license_number),
    Input_Fields.InValid_exp_date((SALT37.StrType)le.exp_date),
    Input_Fields.InValid_status_code((SALT37.StrType)le.status_code),
    Input_Fields.InValid_effective_date((SALT37.StrType)le.effective_date),
    Input_Fields.InValid_add_date((SALT37.StrType)le.add_date),
    Input_Fields.InValid_change_date((SALT37.StrType)le.change_date),
    Input_Fields.InValid_year_licensed((SALT37.StrType)le.year_licensed),
    Input_Fields.InValid_carriage_return((SALT37.StrType)le.carriage_return),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,49,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Input_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_numeric','invalid_first_name','invalid_alphaspacehyphenquote','invalid_last_name','invalid_suffix','invalid_address','Unknown','invalid_alpha','Unknown','invalid_alpha','invalid_alpha','invalid_unit_type','Unknown','invalid_alphanumericspacehyphen','invalid_alpha','invalid_numeric','invalid_numeric','invalid_numeric','invalid_ace_rec_type','invalid_alphanumeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_match_code','invalid_numeric','invalid_numeric','invalid_alphanumeric','invalid_residential_business_ind','Unknown','invalid_numeric','invalid_numeric','Unknown','invalid_alphaspacecommaslash','invalid_occupational_title','invalid_alphaspacecommaslashhyphenparenampquote','invalid_numeric','invalid_numeric','invalid_license_state','invalid_numeric','invalid_license_number','invalid_date','invalid_status_code','invalid_past_date','invalid_past_date','invalid_past_date','invalid_numeric','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Input_Fields.InValidMessage_occupation_id(TotalErrors.ErrorNum),Input_Fields.InValidMessage_first_name(TotalErrors.ErrorNum),Input_Fields.InValidMessage_middle_name(TotalErrors.ErrorNum),Input_Fields.InValidMessage_last_name(TotalErrors.ErrorNum),Input_Fields.InValidMessage_suffix(TotalErrors.ErrorNum),Input_Fields.InValidMessage_address(TotalErrors.ErrorNum),Input_Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Input_Fields.InValidMessage_predir(TotalErrors.ErrorNum),Input_Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Input_Fields.InValidMessage_addr_suffix(TotalErrors.ErrorNum),Input_Fields.InValidMessage_postdir(TotalErrors.ErrorNum),Input_Fields.InValidMessage_unit_type(TotalErrors.ErrorNum),Input_Fields.InValidMessage_unit_number(TotalErrors.ErrorNum),Input_Fields.InValidMessage_city(TotalErrors.ErrorNum),Input_Fields.InValidMessage_state(TotalErrors.ErrorNum),Input_Fields.InValidMessage_zip(TotalErrors.ErrorNum),Input_Fields.InValidMessage_zip4(TotalErrors.ErrorNum),Input_Fields.InValidMessage_bar(TotalErrors.ErrorNum),Input_Fields.InValidMessage_ace_rec_type(TotalErrors.ErrorNum),Input_Fields.InValidMessage_cart(TotalErrors.ErrorNum),Input_Fields.InValidMessage_census_state_code(TotalErrors.ErrorNum),Input_Fields.InValidMessage_census_county_code(TotalErrors.ErrorNum),Input_Fields.InValidMessage_county_code_desc(TotalErrors.ErrorNum),Input_Fields.InValidMessage_census_tract(TotalErrors.ErrorNum),Input_Fields.InValidMessage_census_block_group(TotalErrors.ErrorNum),Input_Fields.InValidMessage_match_code(TotalErrors.ErrorNum),Input_Fields.InValidMessage_latitude(TotalErrors.ErrorNum),Input_Fields.InValidMessage_longitude(TotalErrors.ErrorNum),Input_Fields.InValidMessage_mail_score(TotalErrors.ErrorNum),Input_Fields.InValidMessage_residential_business_ind(TotalErrors.ErrorNum),Input_Fields.InValidMessage_employer_name(TotalErrors.ErrorNum),Input_Fields.InValidMessage_family_id(TotalErrors.ErrorNum),Input_Fields.InValidMessage_individual_id(TotalErrors.ErrorNum),Input_Fields.InValidMessage_abi_number(TotalErrors.ErrorNum),Input_Fields.InValidMessage_industry_title(TotalErrors.ErrorNum),Input_Fields.InValidMessage_occupation_title(TotalErrors.ErrorNum),Input_Fields.InValidMessage_specialty_title(TotalErrors.ErrorNum),Input_Fields.InValidMessage_sic_code(TotalErrors.ErrorNum),Input_Fields.InValidMessage_naics_group(TotalErrors.ErrorNum),Input_Fields.InValidMessage_license_state(TotalErrors.ErrorNum),Input_Fields.InValidMessage_license_id(TotalErrors.ErrorNum),Input_Fields.InValidMessage_license_number(TotalErrors.ErrorNum),Input_Fields.InValidMessage_exp_date(TotalErrors.ErrorNum),Input_Fields.InValidMessage_status_code(TotalErrors.ErrorNum),Input_Fields.InValidMessage_effective_date(TotalErrors.ErrorNum),Input_Fields.InValidMessage_add_date(TotalErrors.ErrorNum),Input_Fields.InValidMessage_change_date(TotalErrors.ErrorNum),Input_Fields.InValidMessage_year_licensed(TotalErrors.ErrorNum),Input_Fields.InValidMessage_carriage_return(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
