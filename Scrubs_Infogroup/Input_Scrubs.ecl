IMPORT SALT37;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Input_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Input_Layout_Infogroup)
    UNSIGNED1 occupation_id_Invalid;
    UNSIGNED1 first_name_Invalid;
    UNSIGNED1 middle_name_Invalid;
    UNSIGNED1 last_name_Invalid;
    UNSIGNED1 suffix_Invalid;
    UNSIGNED1 address_Invalid;
    UNSIGNED1 predir_Invalid;
    UNSIGNED1 addr_suffix_Invalid;
    UNSIGNED1 postdir_Invalid;
    UNSIGNED1 unit_type_Invalid;
    UNSIGNED1 city_Invalid;
    UNSIGNED1 state_Invalid;
    UNSIGNED1 zip_Invalid;
    UNSIGNED1 zip4_Invalid;
    UNSIGNED1 bar_Invalid;
    UNSIGNED1 ace_rec_type_Invalid;
    UNSIGNED1 cart_Invalid;
    UNSIGNED1 census_state_code_Invalid;
    UNSIGNED1 census_county_code_Invalid;
    UNSIGNED1 county_code_desc_Invalid;
    UNSIGNED1 census_tract_Invalid;
    UNSIGNED1 census_block_group_Invalid;
    UNSIGNED1 match_code_Invalid;
    UNSIGNED1 latitude_Invalid;
    UNSIGNED1 longitude_Invalid;
    UNSIGNED1 mail_score_Invalid;
    UNSIGNED1 residential_business_ind_Invalid;
    UNSIGNED1 family_id_Invalid;
    UNSIGNED1 individual_id_Invalid;
    UNSIGNED1 industry_title_Invalid;
    UNSIGNED1 occupation_title_Invalid;
    UNSIGNED1 specialty_title_Invalid;
    UNSIGNED1 sic_code_Invalid;
    UNSIGNED1 naics_group_Invalid;
    UNSIGNED1 license_state_Invalid;
    UNSIGNED1 license_id_Invalid;
    UNSIGNED1 license_number_Invalid;
    UNSIGNED1 exp_date_Invalid;
    UNSIGNED1 status_code_Invalid;
    UNSIGNED1 effective_date_Invalid;
    UNSIGNED1 add_date_Invalid;
    UNSIGNED1 change_date_Invalid;
    UNSIGNED1 year_licensed_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Input_Layout_Infogroup)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Input_Layout_Infogroup) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.occupation_id_Invalid := Input_Fields.InValid_occupation_id((SALT37.StrType)le.occupation_id);
    SELF.first_name_Invalid := Input_Fields.InValid_first_name((SALT37.StrType)le.first_name);
    SELF.middle_name_Invalid := Input_Fields.InValid_middle_name((SALT37.StrType)le.middle_name);
    SELF.last_name_Invalid := Input_Fields.InValid_last_name((SALT37.StrType)le.last_name);
    SELF.suffix_Invalid := Input_Fields.InValid_suffix((SALT37.StrType)le.suffix);
    SELF.address_Invalid := Input_Fields.InValid_address((SALT37.StrType)le.address);
    SELF.predir_Invalid := Input_Fields.InValid_predir((SALT37.StrType)le.predir);
    SELF.addr_suffix_Invalid := Input_Fields.InValid_addr_suffix((SALT37.StrType)le.addr_suffix);
    SELF.postdir_Invalid := Input_Fields.InValid_postdir((SALT37.StrType)le.postdir);
    SELF.unit_type_Invalid := Input_Fields.InValid_unit_type((SALT37.StrType)le.unit_type);
    SELF.city_Invalid := Input_Fields.InValid_city((SALT37.StrType)le.city);
    SELF.state_Invalid := Input_Fields.InValid_state((SALT37.StrType)le.state);
    SELF.zip_Invalid := Input_Fields.InValid_zip((SALT37.StrType)le.zip);
    SELF.zip4_Invalid := Input_Fields.InValid_zip4((SALT37.StrType)le.zip4);
    SELF.bar_Invalid := Input_Fields.InValid_bar((SALT37.StrType)le.bar);
    SELF.ace_rec_type_Invalid := Input_Fields.InValid_ace_rec_type((SALT37.StrType)le.ace_rec_type);
    SELF.cart_Invalid := Input_Fields.InValid_cart((SALT37.StrType)le.cart);
    SELF.census_state_code_Invalid := Input_Fields.InValid_census_state_code((SALT37.StrType)le.census_state_code);
    SELF.census_county_code_Invalid := Input_Fields.InValid_census_county_code((SALT37.StrType)le.census_county_code);
    SELF.county_code_desc_Invalid := Input_Fields.InValid_county_code_desc((SALT37.StrType)le.county_code_desc);
    SELF.census_tract_Invalid := Input_Fields.InValid_census_tract((SALT37.StrType)le.census_tract);
    SELF.census_block_group_Invalid := Input_Fields.InValid_census_block_group((SALT37.StrType)le.census_block_group);
    SELF.match_code_Invalid := Input_Fields.InValid_match_code((SALT37.StrType)le.match_code);
    SELF.latitude_Invalid := Input_Fields.InValid_latitude((SALT37.StrType)le.latitude);
    SELF.longitude_Invalid := Input_Fields.InValid_longitude((SALT37.StrType)le.longitude);
    SELF.mail_score_Invalid := Input_Fields.InValid_mail_score((SALT37.StrType)le.mail_score);
    SELF.residential_business_ind_Invalid := Input_Fields.InValid_residential_business_ind((SALT37.StrType)le.residential_business_ind);
    SELF.family_id_Invalid := Input_Fields.InValid_family_id((SALT37.StrType)le.family_id);
    SELF.individual_id_Invalid := Input_Fields.InValid_individual_id((SALT37.StrType)le.individual_id);
    SELF.industry_title_Invalid := Input_Fields.InValid_industry_title((SALT37.StrType)le.industry_title);
    SELF.occupation_title_Invalid := Input_Fields.InValid_occupation_title((SALT37.StrType)le.occupation_title);
    SELF.specialty_title_Invalid := Input_Fields.InValid_specialty_title((SALT37.StrType)le.specialty_title);
    SELF.sic_code_Invalid := Input_Fields.InValid_sic_code((SALT37.StrType)le.sic_code);
    SELF.naics_group_Invalid := Input_Fields.InValid_naics_group((SALT37.StrType)le.naics_group);
    SELF.license_state_Invalid := Input_Fields.InValid_license_state((SALT37.StrType)le.license_state);
    SELF.license_id_Invalid := Input_Fields.InValid_license_id((SALT37.StrType)le.license_id);
    SELF.license_number_Invalid := Input_Fields.InValid_license_number((SALT37.StrType)le.license_number);
    SELF.exp_date_Invalid := Input_Fields.InValid_exp_date((SALT37.StrType)le.exp_date);
    SELF.status_code_Invalid := Input_Fields.InValid_status_code((SALT37.StrType)le.status_code);
    SELF.effective_date_Invalid := Input_Fields.InValid_effective_date((SALT37.StrType)le.effective_date);
    SELF.add_date_Invalid := Input_Fields.InValid_add_date((SALT37.StrType)le.add_date);
    SELF.change_date_Invalid := Input_Fields.InValid_change_date((SALT37.StrType)le.change_date);
    SELF.year_licensed_Invalid := Input_Fields.InValid_year_licensed((SALT37.StrType)le.year_licensed);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Input_Layout_Infogroup);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.occupation_id_Invalid << 0 ) + ( le.first_name_Invalid << 1 ) + ( le.middle_name_Invalid << 3 ) + ( le.last_name_Invalid << 4 ) + ( le.suffix_Invalid << 6 ) + ( le.address_Invalid << 7 ) + ( le.predir_Invalid << 8 ) + ( le.addr_suffix_Invalid << 9 ) + ( le.postdir_Invalid << 10 ) + ( le.unit_type_Invalid << 11 ) + ( le.city_Invalid << 12 ) + ( le.state_Invalid << 13 ) + ( le.zip_Invalid << 14 ) + ( le.zip4_Invalid << 15 ) + ( le.bar_Invalid << 16 ) + ( le.ace_rec_type_Invalid << 17 ) + ( le.cart_Invalid << 18 ) + ( le.census_state_code_Invalid << 19 ) + ( le.census_county_code_Invalid << 20 ) + ( le.county_code_desc_Invalid << 21 ) + ( le.census_tract_Invalid << 22 ) + ( le.census_block_group_Invalid << 23 ) + ( le.match_code_Invalid << 24 ) + ( le.latitude_Invalid << 25 ) + ( le.longitude_Invalid << 26 ) + ( le.mail_score_Invalid << 27 ) + ( le.residential_business_ind_Invalid << 28 ) + ( le.family_id_Invalid << 29 ) + ( le.individual_id_Invalid << 30 ) + ( le.industry_title_Invalid << 31 ) + ( le.occupation_title_Invalid << 32 ) + ( le.specialty_title_Invalid << 34 ) + ( le.sic_code_Invalid << 35 ) + ( le.naics_group_Invalid << 36 ) + ( le.license_state_Invalid << 37 ) + ( le.license_id_Invalid << 39 ) + ( le.license_number_Invalid << 40 ) + ( le.exp_date_Invalid << 41 ) + ( le.status_code_Invalid << 43 ) + ( le.effective_date_Invalid << 45 ) + ( le.add_date_Invalid << 47 ) + ( le.change_date_Invalid << 49 ) + ( le.year_licensed_Invalid << 51 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Input_Layout_Infogroup);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.occupation_id_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.first_name_Invalid := (le.ScrubsBits1 >> 1) & 3;
    SELF.middle_name_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.last_name_Invalid := (le.ScrubsBits1 >> 4) & 3;
    SELF.suffix_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.address_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.predir_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.addr_suffix_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.postdir_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.unit_type_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.city_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.state_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.zip_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.zip4_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.bar_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.ace_rec_type_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.cart_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.census_state_code_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.census_county_code_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.county_code_desc_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.census_tract_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.census_block_group_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.match_code_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.latitude_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.longitude_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.mail_score_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.residential_business_ind_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.family_id_Invalid := (le.ScrubsBits1 >> 29) & 1;
    SELF.individual_id_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.industry_title_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.occupation_title_Invalid := (le.ScrubsBits1 >> 32) & 3;
    SELF.specialty_title_Invalid := (le.ScrubsBits1 >> 34) & 1;
    SELF.sic_code_Invalid := (le.ScrubsBits1 >> 35) & 1;
    SELF.naics_group_Invalid := (le.ScrubsBits1 >> 36) & 1;
    SELF.license_state_Invalid := (le.ScrubsBits1 >> 37) & 3;
    SELF.license_id_Invalid := (le.ScrubsBits1 >> 39) & 1;
    SELF.license_number_Invalid := (le.ScrubsBits1 >> 40) & 1;
    SELF.exp_date_Invalid := (le.ScrubsBits1 >> 41) & 3;
    SELF.status_code_Invalid := (le.ScrubsBits1 >> 43) & 3;
    SELF.effective_date_Invalid := (le.ScrubsBits1 >> 45) & 3;
    SELF.add_date_Invalid := (le.ScrubsBits1 >> 47) & 3;
    SELF.change_date_Invalid := (le.ScrubsBits1 >> 49) & 3;
    SELF.year_licensed_Invalid := (le.ScrubsBits1 >> 51) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    occupation_id_ALLOW_ErrorCount := COUNT(GROUP,h.occupation_id_Invalid=1);
    first_name_ALLOW_ErrorCount := COUNT(GROUP,h.first_name_Invalid=1);
    first_name_LENGTH_ErrorCount := COUNT(GROUP,h.first_name_Invalid=2);
    first_name_Total_ErrorCount := COUNT(GROUP,h.first_name_Invalid>0);
    middle_name_ALLOW_ErrorCount := COUNT(GROUP,h.middle_name_Invalid=1);
    last_name_ALLOW_ErrorCount := COUNT(GROUP,h.last_name_Invalid=1);
    last_name_LENGTH_ErrorCount := COUNT(GROUP,h.last_name_Invalid=2);
    last_name_Total_ErrorCount := COUNT(GROUP,h.last_name_Invalid>0);
    suffix_ENUM_ErrorCount := COUNT(GROUP,h.suffix_Invalid=1);
    address_LENGTH_ErrorCount := COUNT(GROUP,h.address_Invalid=1);
    predir_ALLOW_ErrorCount := COUNT(GROUP,h.predir_Invalid=1);
    addr_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.addr_suffix_Invalid=1);
    postdir_ALLOW_ErrorCount := COUNT(GROUP,h.postdir_Invalid=1);
    unit_type_ENUM_ErrorCount := COUNT(GROUP,h.unit_type_Invalid=1);
    city_ALLOW_ErrorCount := COUNT(GROUP,h.city_Invalid=1);
    state_ALLOW_ErrorCount := COUNT(GROUP,h.state_Invalid=1);
    zip_ALLOW_ErrorCount := COUNT(GROUP,h.zip_Invalid=1);
    zip4_ALLOW_ErrorCount := COUNT(GROUP,h.zip4_Invalid=1);
    bar_ALLOW_ErrorCount := COUNT(GROUP,h.bar_Invalid=1);
    ace_rec_type_ENUM_ErrorCount := COUNT(GROUP,h.ace_rec_type_Invalid=1);
    cart_ALLOW_ErrorCount := COUNT(GROUP,h.cart_Invalid=1);
    census_state_code_ALLOW_ErrorCount := COUNT(GROUP,h.census_state_code_Invalid=1);
    census_county_code_ALLOW_ErrorCount := COUNT(GROUP,h.census_county_code_Invalid=1);
    county_code_desc_ALLOW_ErrorCount := COUNT(GROUP,h.county_code_desc_Invalid=1);
    census_tract_ALLOW_ErrorCount := COUNT(GROUP,h.census_tract_Invalid=1);
    census_block_group_ALLOW_ErrorCount := COUNT(GROUP,h.census_block_group_Invalid=1);
    match_code_ENUM_ErrorCount := COUNT(GROUP,h.match_code_Invalid=1);
    latitude_ALLOW_ErrorCount := COUNT(GROUP,h.latitude_Invalid=1);
    longitude_ALLOW_ErrorCount := COUNT(GROUP,h.longitude_Invalid=1);
    mail_score_ALLOW_ErrorCount := COUNT(GROUP,h.mail_score_Invalid=1);
    residential_business_ind_ENUM_ErrorCount := COUNT(GROUP,h.residential_business_ind_Invalid=1);
    family_id_ALLOW_ErrorCount := COUNT(GROUP,h.family_id_Invalid=1);
    individual_id_ALLOW_ErrorCount := COUNT(GROUP,h.individual_id_Invalid=1);
    industry_title_ALLOW_ErrorCount := COUNT(GROUP,h.industry_title_Invalid=1);
    occupation_title_ALLOW_ErrorCount := COUNT(GROUP,h.occupation_title_Invalid=1);
    occupation_title_LENGTH_ErrorCount := COUNT(GROUP,h.occupation_title_Invalid=2);
    occupation_title_Total_ErrorCount := COUNT(GROUP,h.occupation_title_Invalid>0);
    specialty_title_ALLOW_ErrorCount := COUNT(GROUP,h.specialty_title_Invalid=1);
    sic_code_ALLOW_ErrorCount := COUNT(GROUP,h.sic_code_Invalid=1);
    naics_group_ALLOW_ErrorCount := COUNT(GROUP,h.naics_group_Invalid=1);
    license_state_ALLOW_ErrorCount := COUNT(GROUP,h.license_state_Invalid=1);
    license_state_LENGTH_ErrorCount := COUNT(GROUP,h.license_state_Invalid=2);
    license_state_Total_ErrorCount := COUNT(GROUP,h.license_state_Invalid>0);
    license_id_ALLOW_ErrorCount := COUNT(GROUP,h.license_id_Invalid=1);
    license_number_ALLOW_ErrorCount := COUNT(GROUP,h.license_number_Invalid=1);
    exp_date_ALLOW_ErrorCount := COUNT(GROUP,h.exp_date_Invalid=1);
    exp_date_CUSTOM_ErrorCount := COUNT(GROUP,h.exp_date_Invalid=2);
    exp_date_Total_ErrorCount := COUNT(GROUP,h.exp_date_Invalid>0);
    status_code_ENUM_ErrorCount := COUNT(GROUP,h.status_code_Invalid=1);
    status_code_LENGTH_ErrorCount := COUNT(GROUP,h.status_code_Invalid=2);
    status_code_Total_ErrorCount := COUNT(GROUP,h.status_code_Invalid>0);
    effective_date_ALLOW_ErrorCount := COUNT(GROUP,h.effective_date_Invalid=1);
    effective_date_CUSTOM_ErrorCount := COUNT(GROUP,h.effective_date_Invalid=2);
    effective_date_Total_ErrorCount := COUNT(GROUP,h.effective_date_Invalid>0);
    add_date_ALLOW_ErrorCount := COUNT(GROUP,h.add_date_Invalid=1);
    add_date_CUSTOM_ErrorCount := COUNT(GROUP,h.add_date_Invalid=2);
    add_date_Total_ErrorCount := COUNT(GROUP,h.add_date_Invalid>0);
    change_date_ALLOW_ErrorCount := COUNT(GROUP,h.change_date_Invalid=1);
    change_date_CUSTOM_ErrorCount := COUNT(GROUP,h.change_date_Invalid=2);
    change_date_Total_ErrorCount := COUNT(GROUP,h.change_date_Invalid>0);
    year_licensed_ALLOW_ErrorCount := COUNT(GROUP,h.year_licensed_Invalid=1);
  END;
  EXPORT SummaryStats := TABLE(h,r);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT37.StrType ErrorMessage;
    SALT37.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.occupation_id_Invalid,le.first_name_Invalid,le.middle_name_Invalid,le.last_name_Invalid,le.suffix_Invalid,le.address_Invalid,le.predir_Invalid,le.addr_suffix_Invalid,le.postdir_Invalid,le.unit_type_Invalid,le.city_Invalid,le.state_Invalid,le.zip_Invalid,le.zip4_Invalid,le.bar_Invalid,le.ace_rec_type_Invalid,le.cart_Invalid,le.census_state_code_Invalid,le.census_county_code_Invalid,le.county_code_desc_Invalid,le.census_tract_Invalid,le.census_block_group_Invalid,le.match_code_Invalid,le.latitude_Invalid,le.longitude_Invalid,le.mail_score_Invalid,le.residential_business_ind_Invalid,le.family_id_Invalid,le.individual_id_Invalid,le.industry_title_Invalid,le.occupation_title_Invalid,le.specialty_title_Invalid,le.sic_code_Invalid,le.naics_group_Invalid,le.license_state_Invalid,le.license_id_Invalid,le.license_number_Invalid,le.exp_date_Invalid,le.status_code_Invalid,le.effective_date_Invalid,le.add_date_Invalid,le.change_date_Invalid,le.year_licensed_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Input_Fields.InvalidMessage_occupation_id(le.occupation_id_Invalid),Input_Fields.InvalidMessage_first_name(le.first_name_Invalid),Input_Fields.InvalidMessage_middle_name(le.middle_name_Invalid),Input_Fields.InvalidMessage_last_name(le.last_name_Invalid),Input_Fields.InvalidMessage_suffix(le.suffix_Invalid),Input_Fields.InvalidMessage_address(le.address_Invalid),Input_Fields.InvalidMessage_predir(le.predir_Invalid),Input_Fields.InvalidMessage_addr_suffix(le.addr_suffix_Invalid),Input_Fields.InvalidMessage_postdir(le.postdir_Invalid),Input_Fields.InvalidMessage_unit_type(le.unit_type_Invalid),Input_Fields.InvalidMessage_city(le.city_Invalid),Input_Fields.InvalidMessage_state(le.state_Invalid),Input_Fields.InvalidMessage_zip(le.zip_Invalid),Input_Fields.InvalidMessage_zip4(le.zip4_Invalid),Input_Fields.InvalidMessage_bar(le.bar_Invalid),Input_Fields.InvalidMessage_ace_rec_type(le.ace_rec_type_Invalid),Input_Fields.InvalidMessage_cart(le.cart_Invalid),Input_Fields.InvalidMessage_census_state_code(le.census_state_code_Invalid),Input_Fields.InvalidMessage_census_county_code(le.census_county_code_Invalid),Input_Fields.InvalidMessage_county_code_desc(le.county_code_desc_Invalid),Input_Fields.InvalidMessage_census_tract(le.census_tract_Invalid),Input_Fields.InvalidMessage_census_block_group(le.census_block_group_Invalid),Input_Fields.InvalidMessage_match_code(le.match_code_Invalid),Input_Fields.InvalidMessage_latitude(le.latitude_Invalid),Input_Fields.InvalidMessage_longitude(le.longitude_Invalid),Input_Fields.InvalidMessage_mail_score(le.mail_score_Invalid),Input_Fields.InvalidMessage_residential_business_ind(le.residential_business_ind_Invalid),Input_Fields.InvalidMessage_family_id(le.family_id_Invalid),Input_Fields.InvalidMessage_individual_id(le.individual_id_Invalid),Input_Fields.InvalidMessage_industry_title(le.industry_title_Invalid),Input_Fields.InvalidMessage_occupation_title(le.occupation_title_Invalid),Input_Fields.InvalidMessage_specialty_title(le.specialty_title_Invalid),Input_Fields.InvalidMessage_sic_code(le.sic_code_Invalid),Input_Fields.InvalidMessage_naics_group(le.naics_group_Invalid),Input_Fields.InvalidMessage_license_state(le.license_state_Invalid),Input_Fields.InvalidMessage_license_id(le.license_id_Invalid),Input_Fields.InvalidMessage_license_number(le.license_number_Invalid),Input_Fields.InvalidMessage_exp_date(le.exp_date_Invalid),Input_Fields.InvalidMessage_status_code(le.status_code_Invalid),Input_Fields.InvalidMessage_effective_date(le.effective_date_Invalid),Input_Fields.InvalidMessage_add_date(le.add_date_Invalid),Input_Fields.InvalidMessage_change_date(le.change_date_Invalid),Input_Fields.InvalidMessage_year_licensed(le.year_licensed_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.occupation_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.first_name_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.middle_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.last_name_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.suffix_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.address_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.predir_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.addr_suffix_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.postdir_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.unit_type_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.city_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.state_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip4_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.bar_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ace_rec_type_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.cart_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.census_state_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.census_county_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.county_code_desc_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.census_tract_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.census_block_group_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.match_code_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.latitude_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.longitude_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mail_score_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.residential_business_ind_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.family_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.individual_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.industry_title_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.occupation_title_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.specialty_title_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.sic_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.naics_group_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.license_state_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.license_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.license_number_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.exp_date_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.status_code_Invalid,'ENUM','LENGTH','UNKNOWN')
          ,CHOOSE(le.effective_date_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.add_date_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.change_date_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.year_licensed_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'occupation_id','first_name','middle_name','last_name','suffix','address','predir','addr_suffix','postdir','unit_type','city','state','zip','zip4','bar','ace_rec_type','cart','census_state_code','census_county_code','county_code_desc','census_tract','census_block_group','match_code','latitude','longitude','mail_score','residential_business_ind','family_id','individual_id','industry_title','occupation_title','specialty_title','sic_code','naics_group','license_state','license_id','license_number','exp_date','status_code','effective_date','add_date','change_date','year_licensed','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_numeric','invalid_first_name','invalid_alphaspacehyphenquote','invalid_last_name','invalid_suffix','invalid_address','invalid_alpha','invalid_alpha','invalid_alpha','invalid_unit_type','invalid_alphanumericspacehyphen','invalid_alpha','invalid_numeric','invalid_numeric','invalid_numeric','invalid_ace_rec_type','invalid_alphanumeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_match_code','invalid_numeric','invalid_numeric','invalid_alphanumeric','invalid_residential_business_ind','invalid_numeric','invalid_numeric','invalid_alphaspacecommaslash','invalid_occupational_title','invalid_alphaspacecommaslashhyphenparenampquote','invalid_numeric','invalid_numeric','invalid_license_state','invalid_numeric','invalid_license_number','invalid_date','invalid_status_code','invalid_past_date','invalid_past_date','invalid_past_date','invalid_numeric','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT37.StrType)le.occupation_id,(SALT37.StrType)le.first_name,(SALT37.StrType)le.middle_name,(SALT37.StrType)le.last_name,(SALT37.StrType)le.suffix,(SALT37.StrType)le.address,(SALT37.StrType)le.predir,(SALT37.StrType)le.addr_suffix,(SALT37.StrType)le.postdir,(SALT37.StrType)le.unit_type,(SALT37.StrType)le.city,(SALT37.StrType)le.state,(SALT37.StrType)le.zip,(SALT37.StrType)le.zip4,(SALT37.StrType)le.bar,(SALT37.StrType)le.ace_rec_type,(SALT37.StrType)le.cart,(SALT37.StrType)le.census_state_code,(SALT37.StrType)le.census_county_code,(SALT37.StrType)le.county_code_desc,(SALT37.StrType)le.census_tract,(SALT37.StrType)le.census_block_group,(SALT37.StrType)le.match_code,(SALT37.StrType)le.latitude,(SALT37.StrType)le.longitude,(SALT37.StrType)le.mail_score,(SALT37.StrType)le.residential_business_ind,(SALT37.StrType)le.family_id,(SALT37.StrType)le.individual_id,(SALT37.StrType)le.industry_title,(SALT37.StrType)le.occupation_title,(SALT37.StrType)le.specialty_title,(SALT37.StrType)le.sic_code,(SALT37.StrType)le.naics_group,(SALT37.StrType)le.license_state,(SALT37.StrType)le.license_id,(SALT37.StrType)le.license_number,(SALT37.StrType)le.exp_date,(SALT37.StrType)le.status_code,(SALT37.StrType)le.effective_date,(SALT37.StrType)le.add_date,(SALT37.StrType)le.change_date,(SALT37.StrType)le.year_licensed,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,43,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT37.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'occupation_id:invalid_numeric:ALLOW'
          ,'first_name:invalid_first_name:ALLOW','first_name:invalid_first_name:LENGTH'
          ,'middle_name:invalid_alphaspacehyphenquote:ALLOW'
          ,'last_name:invalid_last_name:ALLOW','last_name:invalid_last_name:LENGTH'
          ,'suffix:invalid_suffix:ENUM'
          ,'address:invalid_address:LENGTH'
          ,'predir:invalid_alpha:ALLOW'
          ,'addr_suffix:invalid_alpha:ALLOW'
          ,'postdir:invalid_alpha:ALLOW'
          ,'unit_type:invalid_unit_type:ENUM'
          ,'city:invalid_alphanumericspacehyphen:ALLOW'
          ,'state:invalid_alpha:ALLOW'
          ,'zip:invalid_numeric:ALLOW'
          ,'zip4:invalid_numeric:ALLOW'
          ,'bar:invalid_numeric:ALLOW'
          ,'ace_rec_type:invalid_ace_rec_type:ENUM'
          ,'cart:invalid_alphanumeric:ALLOW'
          ,'census_state_code:invalid_numeric:ALLOW'
          ,'census_county_code:invalid_numeric:ALLOW'
          ,'county_code_desc:invalid_numeric:ALLOW'
          ,'census_tract:invalid_numeric:ALLOW'
          ,'census_block_group:invalid_numeric:ALLOW'
          ,'match_code:invalid_match_code:ENUM'
          ,'latitude:invalid_numeric:ALLOW'
          ,'longitude:invalid_numeric:ALLOW'
          ,'mail_score:invalid_alphanumeric:ALLOW'
          ,'residential_business_ind:invalid_residential_business_ind:ENUM'
          ,'family_id:invalid_numeric:ALLOW'
          ,'individual_id:invalid_numeric:ALLOW'
          ,'industry_title:invalid_alphaspacecommaslash:ALLOW'
          ,'occupation_title:invalid_occupational_title:ALLOW','occupation_title:invalid_occupational_title:LENGTH'
          ,'specialty_title:invalid_alphaspacecommaslashhyphenparenampquote:ALLOW'
          ,'sic_code:invalid_numeric:ALLOW'
          ,'naics_group:invalid_numeric:ALLOW'
          ,'license_state:invalid_license_state:ALLOW','license_state:invalid_license_state:LENGTH'
          ,'license_id:invalid_numeric:ALLOW'
          ,'license_number:invalid_license_number:ALLOW'
          ,'exp_date:invalid_date:ALLOW','exp_date:invalid_date:CUSTOM'
          ,'status_code:invalid_status_code:ENUM','status_code:invalid_status_code:LENGTH'
          ,'effective_date:invalid_past_date:ALLOW','effective_date:invalid_past_date:CUSTOM'
          ,'add_date:invalid_past_date:ALLOW','add_date:invalid_past_date:CUSTOM'
          ,'change_date:invalid_past_date:ALLOW','change_date:invalid_past_date:CUSTOM'
          ,'year_licensed:invalid_numeric:ALLOW','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Input_Fields.InvalidMessage_occupation_id(1)
          ,Input_Fields.InvalidMessage_first_name(1),Input_Fields.InvalidMessage_first_name(2)
          ,Input_Fields.InvalidMessage_middle_name(1)
          ,Input_Fields.InvalidMessage_last_name(1),Input_Fields.InvalidMessage_last_name(2)
          ,Input_Fields.InvalidMessage_suffix(1)
          ,Input_Fields.InvalidMessage_address(1)
          ,Input_Fields.InvalidMessage_predir(1)
          ,Input_Fields.InvalidMessage_addr_suffix(1)
          ,Input_Fields.InvalidMessage_postdir(1)
          ,Input_Fields.InvalidMessage_unit_type(1)
          ,Input_Fields.InvalidMessage_city(1)
          ,Input_Fields.InvalidMessage_state(1)
          ,Input_Fields.InvalidMessage_zip(1)
          ,Input_Fields.InvalidMessage_zip4(1)
          ,Input_Fields.InvalidMessage_bar(1)
          ,Input_Fields.InvalidMessage_ace_rec_type(1)
          ,Input_Fields.InvalidMessage_cart(1)
          ,Input_Fields.InvalidMessage_census_state_code(1)
          ,Input_Fields.InvalidMessage_census_county_code(1)
          ,Input_Fields.InvalidMessage_county_code_desc(1)
          ,Input_Fields.InvalidMessage_census_tract(1)
          ,Input_Fields.InvalidMessage_census_block_group(1)
          ,Input_Fields.InvalidMessage_match_code(1)
          ,Input_Fields.InvalidMessage_latitude(1)
          ,Input_Fields.InvalidMessage_longitude(1)
          ,Input_Fields.InvalidMessage_mail_score(1)
          ,Input_Fields.InvalidMessage_residential_business_ind(1)
          ,Input_Fields.InvalidMessage_family_id(1)
          ,Input_Fields.InvalidMessage_individual_id(1)
          ,Input_Fields.InvalidMessage_industry_title(1)
          ,Input_Fields.InvalidMessage_occupation_title(1),Input_Fields.InvalidMessage_occupation_title(2)
          ,Input_Fields.InvalidMessage_specialty_title(1)
          ,Input_Fields.InvalidMessage_sic_code(1)
          ,Input_Fields.InvalidMessage_naics_group(1)
          ,Input_Fields.InvalidMessage_license_state(1),Input_Fields.InvalidMessage_license_state(2)
          ,Input_Fields.InvalidMessage_license_id(1)
          ,Input_Fields.InvalidMessage_license_number(1)
          ,Input_Fields.InvalidMessage_exp_date(1),Input_Fields.InvalidMessage_exp_date(2)
          ,Input_Fields.InvalidMessage_status_code(1),Input_Fields.InvalidMessage_status_code(2)
          ,Input_Fields.InvalidMessage_effective_date(1),Input_Fields.InvalidMessage_effective_date(2)
          ,Input_Fields.InvalidMessage_add_date(1),Input_Fields.InvalidMessage_add_date(2)
          ,Input_Fields.InvalidMessage_change_date(1),Input_Fields.InvalidMessage_change_date(2)
          ,Input_Fields.InvalidMessage_year_licensed(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.occupation_id_ALLOW_ErrorCount
          ,le.first_name_ALLOW_ErrorCount,le.first_name_LENGTH_ErrorCount
          ,le.middle_name_ALLOW_ErrorCount
          ,le.last_name_ALLOW_ErrorCount,le.last_name_LENGTH_ErrorCount
          ,le.suffix_ENUM_ErrorCount
          ,le.address_LENGTH_ErrorCount
          ,le.predir_ALLOW_ErrorCount
          ,le.addr_suffix_ALLOW_ErrorCount
          ,le.postdir_ALLOW_ErrorCount
          ,le.unit_type_ENUM_ErrorCount
          ,le.city_ALLOW_ErrorCount
          ,le.state_ALLOW_ErrorCount
          ,le.zip_ALLOW_ErrorCount
          ,le.zip4_ALLOW_ErrorCount
          ,le.bar_ALLOW_ErrorCount
          ,le.ace_rec_type_ENUM_ErrorCount
          ,le.cart_ALLOW_ErrorCount
          ,le.census_state_code_ALLOW_ErrorCount
          ,le.census_county_code_ALLOW_ErrorCount
          ,le.county_code_desc_ALLOW_ErrorCount
          ,le.census_tract_ALLOW_ErrorCount
          ,le.census_block_group_ALLOW_ErrorCount
          ,le.match_code_ENUM_ErrorCount
          ,le.latitude_ALLOW_ErrorCount
          ,le.longitude_ALLOW_ErrorCount
          ,le.mail_score_ALLOW_ErrorCount
          ,le.residential_business_ind_ENUM_ErrorCount
          ,le.family_id_ALLOW_ErrorCount
          ,le.individual_id_ALLOW_ErrorCount
          ,le.industry_title_ALLOW_ErrorCount
          ,le.occupation_title_ALLOW_ErrorCount,le.occupation_title_LENGTH_ErrorCount
          ,le.specialty_title_ALLOW_ErrorCount
          ,le.sic_code_ALLOW_ErrorCount
          ,le.naics_group_ALLOW_ErrorCount
          ,le.license_state_ALLOW_ErrorCount,le.license_state_LENGTH_ErrorCount
          ,le.license_id_ALLOW_ErrorCount
          ,le.license_number_ALLOW_ErrorCount
          ,le.exp_date_ALLOW_ErrorCount,le.exp_date_CUSTOM_ErrorCount
          ,le.status_code_ENUM_ErrorCount,le.status_code_LENGTH_ErrorCount
          ,le.effective_date_ALLOW_ErrorCount,le.effective_date_CUSTOM_ErrorCount
          ,le.add_date_ALLOW_ErrorCount,le.add_date_CUSTOM_ErrorCount
          ,le.change_date_ALLOW_ErrorCount,le.change_date_CUSTOM_ErrorCount
          ,le.year_licensed_ALLOW_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.occupation_id_ALLOW_ErrorCount
          ,le.first_name_ALLOW_ErrorCount,le.first_name_LENGTH_ErrorCount
          ,le.middle_name_ALLOW_ErrorCount
          ,le.last_name_ALLOW_ErrorCount,le.last_name_LENGTH_ErrorCount
          ,le.suffix_ENUM_ErrorCount
          ,le.address_LENGTH_ErrorCount
          ,le.predir_ALLOW_ErrorCount
          ,le.addr_suffix_ALLOW_ErrorCount
          ,le.postdir_ALLOW_ErrorCount
          ,le.unit_type_ENUM_ErrorCount
          ,le.city_ALLOW_ErrorCount
          ,le.state_ALLOW_ErrorCount
          ,le.zip_ALLOW_ErrorCount
          ,le.zip4_ALLOW_ErrorCount
          ,le.bar_ALLOW_ErrorCount
          ,le.ace_rec_type_ENUM_ErrorCount
          ,le.cart_ALLOW_ErrorCount
          ,le.census_state_code_ALLOW_ErrorCount
          ,le.census_county_code_ALLOW_ErrorCount
          ,le.county_code_desc_ALLOW_ErrorCount
          ,le.census_tract_ALLOW_ErrorCount
          ,le.census_block_group_ALLOW_ErrorCount
          ,le.match_code_ENUM_ErrorCount
          ,le.latitude_ALLOW_ErrorCount
          ,le.longitude_ALLOW_ErrorCount
          ,le.mail_score_ALLOW_ErrorCount
          ,le.residential_business_ind_ENUM_ErrorCount
          ,le.family_id_ALLOW_ErrorCount
          ,le.individual_id_ALLOW_ErrorCount
          ,le.industry_title_ALLOW_ErrorCount
          ,le.occupation_title_ALLOW_ErrorCount,le.occupation_title_LENGTH_ErrorCount
          ,le.specialty_title_ALLOW_ErrorCount
          ,le.sic_code_ALLOW_ErrorCount
          ,le.naics_group_ALLOW_ErrorCount
          ,le.license_state_ALLOW_ErrorCount,le.license_state_LENGTH_ErrorCount
          ,le.license_id_ALLOW_ErrorCount
          ,le.license_number_ALLOW_ErrorCount
          ,le.exp_date_ALLOW_ErrorCount,le.exp_date_CUSTOM_ErrorCount
          ,le.status_code_ENUM_ErrorCount,le.status_code_LENGTH_ErrorCount
          ,le.effective_date_ALLOW_ErrorCount,le.effective_date_CUSTOM_ErrorCount
          ,le.add_date_ALLOW_ErrorCount,le.add_date_CUSTOM_ErrorCount
          ,le.change_date_ALLOW_ErrorCount,le.change_date_CUSTOM_ErrorCount
          ,le.year_licensed_ALLOW_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,52,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT37.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT37.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    RETURN IF(examples>0,j,SummaryInfo);
  END;
END;
END;
