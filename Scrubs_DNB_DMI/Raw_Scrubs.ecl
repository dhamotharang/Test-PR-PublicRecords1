IMPORT ut,SALT34;
IMPORT Scrubs_DNB_DMI; // Import modules for FieldTypes attribute definitions
EXPORT Raw_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Raw_Layout_DNB_DMI)
    UNSIGNED1 duns_number_Invalid;
    UNSIGNED1 business_name_Invalid;
    UNSIGNED1 street_Invalid;
    UNSIGNED1 city_Invalid;
    UNSIGNED1 state_Invalid;
    UNSIGNED1 zip_code_Invalid;
    UNSIGNED1 mail_address_Invalid;
    UNSIGNED1 mail_city_Invalid;
    UNSIGNED1 mail_state_Invalid;
    UNSIGNED1 mail_zip_code_Invalid;
    UNSIGNED1 telephone_number_Invalid;
    UNSIGNED1 county_name_Invalid;
    UNSIGNED1 msa_code_Invalid;
    UNSIGNED1 sic1_Invalid;
    UNSIGNED1 sic1a_Invalid;
    UNSIGNED1 sic1b_Invalid;
    UNSIGNED1 sic1c_Invalid;
    UNSIGNED1 sic1d_Invalid;
    UNSIGNED1 sic2_Invalid;
    UNSIGNED1 sic2a_Invalid;
    UNSIGNED1 sic2b_Invalid;
    UNSIGNED1 sic2c_Invalid;
    UNSIGNED1 sic2d_Invalid;
    UNSIGNED1 sic3_Invalid;
    UNSIGNED1 sic3a_Invalid;
    UNSIGNED1 sic3b_Invalid;
    UNSIGNED1 sic3c_Invalid;
    UNSIGNED1 sic3d_Invalid;
    UNSIGNED1 sic4_Invalid;
    UNSIGNED1 sic4a_Invalid;
    UNSIGNED1 sic4b_Invalid;
    UNSIGNED1 sic4c_Invalid;
    UNSIGNED1 sic4d_Invalid;
    UNSIGNED1 sic5_Invalid;
    UNSIGNED1 sic5a_Invalid;
    UNSIGNED1 sic5b_Invalid;
    UNSIGNED1 sic5c_Invalid;
    UNSIGNED1 sic5d_Invalid;
    UNSIGNED1 sic6_Invalid;
    UNSIGNED1 sic6a_Invalid;
    UNSIGNED1 sic6b_Invalid;
    UNSIGNED1 sic6c_Invalid;
    UNSIGNED1 sic6d_Invalid;
    UNSIGNED1 industry_group_Invalid;
    UNSIGNED1 year_started_Invalid;
    UNSIGNED1 date_of_incorporation_Invalid;
    UNSIGNED1 state_of_incorporation_abbr_Invalid;
    UNSIGNED1 annual_sales_code_Invalid;
    UNSIGNED1 employees_here_code_Invalid;
    UNSIGNED1 annual_sales_revision_date_Invalid;
    UNSIGNED1 square_footage_Invalid;
    UNSIGNED1 sals_territory_Invalid;
    UNSIGNED1 owns_rents_Invalid;
    UNSIGNED1 number_of_accounts_Invalid;
    UNSIGNED1 small_business_indicator_Invalid;
    UNSIGNED1 minority_owned_Invalid;
    UNSIGNED1 cottage_indicator_Invalid;
    UNSIGNED1 foreign_owned_Invalid;
    UNSIGNED1 manufacturing_here_indicator_Invalid;
    UNSIGNED1 public_indicator_Invalid;
    UNSIGNED1 importer_exporter_indicator_Invalid;
    UNSIGNED1 structure_type_Invalid;
    UNSIGNED1 type_of_establishment_Invalid;
    UNSIGNED1 parent_duns_number_Invalid;
    UNSIGNED1 ultimate_duns_number_Invalid;
    UNSIGNED1 headquarters_duns_number_Invalid;
    UNSIGNED1 dias_code_Invalid;
    UNSIGNED1 hierarchy_code_Invalid;
    UNSIGNED1 ultimate_indicator_Invalid;
    UNSIGNED1 hot_list_new_indicator_Invalid;
    UNSIGNED1 hot_list_ownership_change_indicator_Invalid;
    UNSIGNED1 hot_list_ceo_change_indicator_Invalid;
    UNSIGNED1 hot_list_company_name_change_ind_Invalid;
    UNSIGNED1 hot_list_address_change_indicator_Invalid;
    UNSIGNED1 hot_list_telephone_change_indicator_Invalid;
    UNSIGNED1 hot_list_new_change_date_Invalid;
    UNSIGNED1 hot_list_ownership_change_date_Invalid;
    UNSIGNED1 hot_list_ceo_change_date_Invalid;
    UNSIGNED1 hot_list_company_name_chg_date_Invalid;
    UNSIGNED1 hot_list_address_change_date_Invalid;
    UNSIGNED1 hot_list_telephone_change_date_Invalid;
    UNSIGNED1 report_date_Invalid;
    UNSIGNED1 delete_record_indicator_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Raw_Layout_DNB_DMI)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsBits2;
  END;
EXPORT FromNone(DATASET(Raw_Layout_DNB_DMI) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.duns_number_Invalid := Raw_Fields.InValid_duns_number((SALT34.StrType)le.duns_number);
    SELF.business_name_Invalid := Raw_Fields.InValid_business_name((SALT34.StrType)le.business_name);
    SELF.street_Invalid := Raw_Fields.InValid_street((SALT34.StrType)le.street);
    SELF.city_Invalid := Raw_Fields.InValid_city((SALT34.StrType)le.city);
    SELF.state_Invalid := Raw_Fields.InValid_state((SALT34.StrType)le.state);
    SELF.zip_code_Invalid := Raw_Fields.InValid_zip_code((SALT34.StrType)le.zip_code);
    SELF.mail_address_Invalid := Raw_Fields.InValid_mail_address((SALT34.StrType)le.mail_address);
    SELF.mail_city_Invalid := Raw_Fields.InValid_mail_city((SALT34.StrType)le.mail_city);
    SELF.mail_state_Invalid := Raw_Fields.InValid_mail_state((SALT34.StrType)le.mail_state);
    SELF.mail_zip_code_Invalid := Raw_Fields.InValid_mail_zip_code((SALT34.StrType)le.mail_zip_code);
    SELF.telephone_number_Invalid := Raw_Fields.InValid_telephone_number((SALT34.StrType)le.telephone_number);
    SELF.county_name_Invalid := Raw_Fields.InValid_county_name((SALT34.StrType)le.county_name);
    SELF.msa_code_Invalid := Raw_Fields.InValid_msa_code((SALT34.StrType)le.msa_code);
    SELF.sic1_Invalid := Raw_Fields.InValid_sic1((SALT34.StrType)le.sic1);
    SELF.sic1a_Invalid := Raw_Fields.InValid_sic1a((SALT34.StrType)le.sic1a);
    SELF.sic1b_Invalid := Raw_Fields.InValid_sic1b((SALT34.StrType)le.sic1b);
    SELF.sic1c_Invalid := Raw_Fields.InValid_sic1c((SALT34.StrType)le.sic1c);
    SELF.sic1d_Invalid := Raw_Fields.InValid_sic1d((SALT34.StrType)le.sic1d);
    SELF.sic2_Invalid := Raw_Fields.InValid_sic2((SALT34.StrType)le.sic2);
    SELF.sic2a_Invalid := Raw_Fields.InValid_sic2a((SALT34.StrType)le.sic2a);
    SELF.sic2b_Invalid := Raw_Fields.InValid_sic2b((SALT34.StrType)le.sic2b);
    SELF.sic2c_Invalid := Raw_Fields.InValid_sic2c((SALT34.StrType)le.sic2c);
    SELF.sic2d_Invalid := Raw_Fields.InValid_sic2d((SALT34.StrType)le.sic2d);
    SELF.sic3_Invalid := Raw_Fields.InValid_sic3((SALT34.StrType)le.sic3);
    SELF.sic3a_Invalid := Raw_Fields.InValid_sic3a((SALT34.StrType)le.sic3a);
    SELF.sic3b_Invalid := Raw_Fields.InValid_sic3b((SALT34.StrType)le.sic3b);
    SELF.sic3c_Invalid := Raw_Fields.InValid_sic3c((SALT34.StrType)le.sic3c);
    SELF.sic3d_Invalid := Raw_Fields.InValid_sic3d((SALT34.StrType)le.sic3d);
    SELF.sic4_Invalid := Raw_Fields.InValid_sic4((SALT34.StrType)le.sic4);
    SELF.sic4a_Invalid := Raw_Fields.InValid_sic4a((SALT34.StrType)le.sic4a);
    SELF.sic4b_Invalid := Raw_Fields.InValid_sic4b((SALT34.StrType)le.sic4b);
    SELF.sic4c_Invalid := Raw_Fields.InValid_sic4c((SALT34.StrType)le.sic4c);
    SELF.sic4d_Invalid := Raw_Fields.InValid_sic4d((SALT34.StrType)le.sic4d);
    SELF.sic5_Invalid := Raw_Fields.InValid_sic5((SALT34.StrType)le.sic5);
    SELF.sic5a_Invalid := Raw_Fields.InValid_sic5a((SALT34.StrType)le.sic5a);
    SELF.sic5b_Invalid := Raw_Fields.InValid_sic5b((SALT34.StrType)le.sic5b);
    SELF.sic5c_Invalid := Raw_Fields.InValid_sic5c((SALT34.StrType)le.sic5c);
    SELF.sic5d_Invalid := Raw_Fields.InValid_sic5d((SALT34.StrType)le.sic5d);
    SELF.sic6_Invalid := Raw_Fields.InValid_sic6((SALT34.StrType)le.sic6);
    SELF.sic6a_Invalid := Raw_Fields.InValid_sic6a((SALT34.StrType)le.sic6a);
    SELF.sic6b_Invalid := Raw_Fields.InValid_sic6b((SALT34.StrType)le.sic6b);
    SELF.sic6c_Invalid := Raw_Fields.InValid_sic6c((SALT34.StrType)le.sic6c);
    SELF.sic6d_Invalid := Raw_Fields.InValid_sic6d((SALT34.StrType)le.sic6d);
    SELF.industry_group_Invalid := Raw_Fields.InValid_industry_group((SALT34.StrType)le.industry_group);
    SELF.year_started_Invalid := Raw_Fields.InValid_year_started((SALT34.StrType)le.year_started);
    SELF.date_of_incorporation_Invalid := Raw_Fields.InValid_date_of_incorporation((SALT34.StrType)le.date_of_incorporation);
    SELF.state_of_incorporation_abbr_Invalid := Raw_Fields.InValid_state_of_incorporation_abbr((SALT34.StrType)le.state_of_incorporation_abbr);
    SELF.annual_sales_code_Invalid := Raw_Fields.InValid_annual_sales_code((SALT34.StrType)le.annual_sales_code);
    SELF.employees_here_code_Invalid := Raw_Fields.InValid_employees_here_code((SALT34.StrType)le.employees_here_code);
    SELF.annual_sales_revision_date_Invalid := Raw_Fields.InValid_annual_sales_revision_date((SALT34.StrType)le.annual_sales_revision_date);
    SELF.square_footage_Invalid := Raw_Fields.InValid_square_footage((SALT34.StrType)le.square_footage);
    SELF.sals_territory_Invalid := Raw_Fields.InValid_sals_territory((SALT34.StrType)le.sals_territory);
    SELF.owns_rents_Invalid := Raw_Fields.InValid_owns_rents((SALT34.StrType)le.owns_rents);
    SELF.number_of_accounts_Invalid := Raw_Fields.InValid_number_of_accounts((SALT34.StrType)le.number_of_accounts);
    SELF.small_business_indicator_Invalid := Raw_Fields.InValid_small_business_indicator((SALT34.StrType)le.small_business_indicator);
    SELF.minority_owned_Invalid := Raw_Fields.InValid_minority_owned((SALT34.StrType)le.minority_owned);
    SELF.cottage_indicator_Invalid := Raw_Fields.InValid_cottage_indicator((SALT34.StrType)le.cottage_indicator);
    SELF.foreign_owned_Invalid := Raw_Fields.InValid_foreign_owned((SALT34.StrType)le.foreign_owned);
    SELF.manufacturing_here_indicator_Invalid := Raw_Fields.InValid_manufacturing_here_indicator((SALT34.StrType)le.manufacturing_here_indicator);
    SELF.public_indicator_Invalid := Raw_Fields.InValid_public_indicator((SALT34.StrType)le.public_indicator);
    SELF.importer_exporter_indicator_Invalid := Raw_Fields.InValid_importer_exporter_indicator((SALT34.StrType)le.importer_exporter_indicator);
    SELF.structure_type_Invalid := Raw_Fields.InValid_structure_type((SALT34.StrType)le.structure_type);
    SELF.type_of_establishment_Invalid := Raw_Fields.InValid_type_of_establishment((SALT34.StrType)le.type_of_establishment);
    SELF.parent_duns_number_Invalid := Raw_Fields.InValid_parent_duns_number((SALT34.StrType)le.parent_duns_number);
    SELF.ultimate_duns_number_Invalid := Raw_Fields.InValid_ultimate_duns_number((SALT34.StrType)le.ultimate_duns_number);
    SELF.headquarters_duns_number_Invalid := Raw_Fields.InValid_headquarters_duns_number((SALT34.StrType)le.headquarters_duns_number);
    SELF.dias_code_Invalid := Raw_Fields.InValid_dias_code((SALT34.StrType)le.dias_code);
    SELF.hierarchy_code_Invalid := Raw_Fields.InValid_hierarchy_code((SALT34.StrType)le.hierarchy_code);
    SELF.ultimate_indicator_Invalid := Raw_Fields.InValid_ultimate_indicator((SALT34.StrType)le.ultimate_indicator);
    SELF.hot_list_new_indicator_Invalid := Raw_Fields.InValid_hot_list_new_indicator((SALT34.StrType)le.hot_list_new_indicator);
    SELF.hot_list_ownership_change_indicator_Invalid := Raw_Fields.InValid_hot_list_ownership_change_indicator((SALT34.StrType)le.hot_list_ownership_change_indicator);
    SELF.hot_list_ceo_change_indicator_Invalid := Raw_Fields.InValid_hot_list_ceo_change_indicator((SALT34.StrType)le.hot_list_ceo_change_indicator);
    SELF.hot_list_company_name_change_ind_Invalid := Raw_Fields.InValid_hot_list_company_name_change_ind((SALT34.StrType)le.hot_list_company_name_change_ind);
    SELF.hot_list_address_change_indicator_Invalid := Raw_Fields.InValid_hot_list_address_change_indicator((SALT34.StrType)le.hot_list_address_change_indicator);
    SELF.hot_list_telephone_change_indicator_Invalid := Raw_Fields.InValid_hot_list_telephone_change_indicator((SALT34.StrType)le.hot_list_telephone_change_indicator);
    SELF.hot_list_new_change_date_Invalid := Raw_Fields.InValid_hot_list_new_change_date((SALT34.StrType)le.hot_list_new_change_date);
    SELF.hot_list_ownership_change_date_Invalid := Raw_Fields.InValid_hot_list_ownership_change_date((SALT34.StrType)le.hot_list_ownership_change_date);
    SELF.hot_list_ceo_change_date_Invalid := Raw_Fields.InValid_hot_list_ceo_change_date((SALT34.StrType)le.hot_list_ceo_change_date);
    SELF.hot_list_company_name_chg_date_Invalid := Raw_Fields.InValid_hot_list_company_name_chg_date((SALT34.StrType)le.hot_list_company_name_chg_date);
    SELF.hot_list_address_change_date_Invalid := Raw_Fields.InValid_hot_list_address_change_date((SALT34.StrType)le.hot_list_address_change_date);
    SELF.hot_list_telephone_change_date_Invalid := Raw_Fields.InValid_hot_list_telephone_change_date((SALT34.StrType)le.hot_list_telephone_change_date);
    SELF.report_date_Invalid := Raw_Fields.InValid_report_date((SALT34.StrType)le.report_date);
    SELF.delete_record_indicator_Invalid := Raw_Fields.InValid_delete_record_indicator((SALT34.StrType)le.delete_record_indicator);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Raw_Layout_DNB_DMI);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.duns_number_Invalid << 0 ) + ( le.business_name_Invalid << 1 ) + ( le.street_Invalid << 2 ) + ( le.city_Invalid << 3 ) + ( le.state_Invalid << 4 ) + ( le.zip_code_Invalid << 5 ) + ( le.mail_address_Invalid << 6 ) + ( le.mail_city_Invalid << 7 ) + ( le.mail_state_Invalid << 8 ) + ( le.mail_zip_code_Invalid << 9 ) + ( le.telephone_number_Invalid << 10 ) + ( le.county_name_Invalid << 12 ) + ( le.msa_code_Invalid << 13 ) + ( le.sic1_Invalid << 15 ) + ( le.sic1a_Invalid << 16 ) + ( le.sic1b_Invalid << 17 ) + ( le.sic1c_Invalid << 18 ) + ( le.sic1d_Invalid << 19 ) + ( le.sic2_Invalid << 20 ) + ( le.sic2a_Invalid << 21 ) + ( le.sic2b_Invalid << 22 ) + ( le.sic2c_Invalid << 23 ) + ( le.sic2d_Invalid << 24 ) + ( le.sic3_Invalid << 25 ) + ( le.sic3a_Invalid << 26 ) + ( le.sic3b_Invalid << 27 ) + ( le.sic3c_Invalid << 28 ) + ( le.sic3d_Invalid << 29 ) + ( le.sic4_Invalid << 30 ) + ( le.sic4a_Invalid << 31 ) + ( le.sic4b_Invalid << 32 ) + ( le.sic4c_Invalid << 33 ) + ( le.sic4d_Invalid << 34 ) + ( le.sic5_Invalid << 35 ) + ( le.sic5a_Invalid << 36 ) + ( le.sic5b_Invalid << 37 ) + ( le.sic5c_Invalid << 38 ) + ( le.sic5d_Invalid << 39 ) + ( le.sic6_Invalid << 40 ) + ( le.sic6a_Invalid << 41 ) + ( le.sic6b_Invalid << 42 ) + ( le.sic6c_Invalid << 43 ) + ( le.sic6d_Invalid << 44 ) + ( le.industry_group_Invalid << 45 ) + ( le.year_started_Invalid << 46 ) + ( le.date_of_incorporation_Invalid << 48 ) + ( le.state_of_incorporation_abbr_Invalid << 49 ) + ( le.annual_sales_code_Invalid << 50 ) + ( le.employees_here_code_Invalid << 51 ) + ( le.annual_sales_revision_date_Invalid << 52 ) + ( le.square_footage_Invalid << 53 ) + ( le.sals_territory_Invalid << 54 ) + ( le.owns_rents_Invalid << 55 ) + ( le.number_of_accounts_Invalid << 56 ) + ( le.small_business_indicator_Invalid << 57 ) + ( le.minority_owned_Invalid << 58 ) + ( le.cottage_indicator_Invalid << 59 ) + ( le.foreign_owned_Invalid << 60 ) + ( le.manufacturing_here_indicator_Invalid << 61 ) + ( le.public_indicator_Invalid << 62 ) + ( le.importer_exporter_indicator_Invalid << 63 );
    SELF.ScrubsBits2 := ( le.structure_type_Invalid << 0 ) + ( le.type_of_establishment_Invalid << 1 ) + ( le.parent_duns_number_Invalid << 2 ) + ( le.ultimate_duns_number_Invalid << 3 ) + ( le.headquarters_duns_number_Invalid << 4 ) + ( le.dias_code_Invalid << 5 ) + ( le.hierarchy_code_Invalid << 6 ) + ( le.ultimate_indicator_Invalid << 7 ) + ( le.hot_list_new_indicator_Invalid << 8 ) + ( le.hot_list_ownership_change_indicator_Invalid << 9 ) + ( le.hot_list_ceo_change_indicator_Invalid << 10 ) + ( le.hot_list_company_name_change_ind_Invalid << 11 ) + ( le.hot_list_address_change_indicator_Invalid << 12 ) + ( le.hot_list_telephone_change_indicator_Invalid << 13 ) + ( le.hot_list_new_change_date_Invalid << 14 ) + ( le.hot_list_ownership_change_date_Invalid << 16 ) + ( le.hot_list_ceo_change_date_Invalid << 18 ) + ( le.hot_list_company_name_chg_date_Invalid << 20 ) + ( le.hot_list_address_change_date_Invalid << 22 ) + ( le.hot_list_telephone_change_date_Invalid << 24 ) + ( le.report_date_Invalid << 26 ) + ( le.delete_record_indicator_Invalid << 27 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Raw_Layout_DNB_DMI);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.duns_number_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.business_name_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.street_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.city_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.state_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.zip_code_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.mail_address_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.mail_city_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.mail_state_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.mail_zip_code_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.telephone_number_Invalid := (le.ScrubsBits1 >> 10) & 3;
    SELF.county_name_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.msa_code_Invalid := (le.ScrubsBits1 >> 13) & 3;
    SELF.sic1_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.sic1a_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.sic1b_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.sic1c_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.sic1d_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.sic2_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.sic2a_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.sic2b_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.sic2c_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.sic2d_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.sic3_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.sic3a_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.sic3b_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.sic3c_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.sic3d_Invalid := (le.ScrubsBits1 >> 29) & 1;
    SELF.sic4_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.sic4a_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.sic4b_Invalid := (le.ScrubsBits1 >> 32) & 1;
    SELF.sic4c_Invalid := (le.ScrubsBits1 >> 33) & 1;
    SELF.sic4d_Invalid := (le.ScrubsBits1 >> 34) & 1;
    SELF.sic5_Invalid := (le.ScrubsBits1 >> 35) & 1;
    SELF.sic5a_Invalid := (le.ScrubsBits1 >> 36) & 1;
    SELF.sic5b_Invalid := (le.ScrubsBits1 >> 37) & 1;
    SELF.sic5c_Invalid := (le.ScrubsBits1 >> 38) & 1;
    SELF.sic5d_Invalid := (le.ScrubsBits1 >> 39) & 1;
    SELF.sic6_Invalid := (le.ScrubsBits1 >> 40) & 1;
    SELF.sic6a_Invalid := (le.ScrubsBits1 >> 41) & 1;
    SELF.sic6b_Invalid := (le.ScrubsBits1 >> 42) & 1;
    SELF.sic6c_Invalid := (le.ScrubsBits1 >> 43) & 1;
    SELF.sic6d_Invalid := (le.ScrubsBits1 >> 44) & 1;
    SELF.industry_group_Invalid := (le.ScrubsBits1 >> 45) & 1;
    SELF.year_started_Invalid := (le.ScrubsBits1 >> 46) & 3;
    SELF.date_of_incorporation_Invalid := (le.ScrubsBits1 >> 48) & 1;
    SELF.state_of_incorporation_abbr_Invalid := (le.ScrubsBits1 >> 49) & 1;
    SELF.annual_sales_code_Invalid := (le.ScrubsBits1 >> 50) & 1;
    SELF.employees_here_code_Invalid := (le.ScrubsBits1 >> 51) & 1;
    SELF.annual_sales_revision_date_Invalid := (le.ScrubsBits1 >> 52) & 1;
    SELF.square_footage_Invalid := (le.ScrubsBits1 >> 53) & 1;
    SELF.sals_territory_Invalid := (le.ScrubsBits1 >> 54) & 1;
    SELF.owns_rents_Invalid := (le.ScrubsBits1 >> 55) & 1;
    SELF.number_of_accounts_Invalid := (le.ScrubsBits1 >> 56) & 1;
    SELF.small_business_indicator_Invalid := (le.ScrubsBits1 >> 57) & 1;
    SELF.minority_owned_Invalid := (le.ScrubsBits1 >> 58) & 1;
    SELF.cottage_indicator_Invalid := (le.ScrubsBits1 >> 59) & 1;
    SELF.foreign_owned_Invalid := (le.ScrubsBits1 >> 60) & 1;
    SELF.manufacturing_here_indicator_Invalid := (le.ScrubsBits1 >> 61) & 1;
    SELF.public_indicator_Invalid := (le.ScrubsBits1 >> 62) & 1;
    SELF.importer_exporter_indicator_Invalid := (le.ScrubsBits1 >> 63) & 1;
    SELF.structure_type_Invalid := (le.ScrubsBits2 >> 0) & 1;
    SELF.type_of_establishment_Invalid := (le.ScrubsBits2 >> 1) & 1;
    SELF.parent_duns_number_Invalid := (le.ScrubsBits2 >> 2) & 1;
    SELF.ultimate_duns_number_Invalid := (le.ScrubsBits2 >> 3) & 1;
    SELF.headquarters_duns_number_Invalid := (le.ScrubsBits2 >> 4) & 1;
    SELF.dias_code_Invalid := (le.ScrubsBits2 >> 5) & 1;
    SELF.hierarchy_code_Invalid := (le.ScrubsBits2 >> 6) & 1;
    SELF.ultimate_indicator_Invalid := (le.ScrubsBits2 >> 7) & 1;
    SELF.hot_list_new_indicator_Invalid := (le.ScrubsBits2 >> 8) & 1;
    SELF.hot_list_ownership_change_indicator_Invalid := (le.ScrubsBits2 >> 9) & 1;
    SELF.hot_list_ceo_change_indicator_Invalid := (le.ScrubsBits2 >> 10) & 1;
    SELF.hot_list_company_name_change_ind_Invalid := (le.ScrubsBits2 >> 11) & 1;
    SELF.hot_list_address_change_indicator_Invalid := (le.ScrubsBits2 >> 12) & 1;
    SELF.hot_list_telephone_change_indicator_Invalid := (le.ScrubsBits2 >> 13) & 1;
    SELF.hot_list_new_change_date_Invalid := (le.ScrubsBits2 >> 14) & 3;
    SELF.hot_list_ownership_change_date_Invalid := (le.ScrubsBits2 >> 16) & 3;
    SELF.hot_list_ceo_change_date_Invalid := (le.ScrubsBits2 >> 18) & 3;
    SELF.hot_list_company_name_chg_date_Invalid := (le.ScrubsBits2 >> 20) & 3;
    SELF.hot_list_address_change_date_Invalid := (le.ScrubsBits2 >> 22) & 3;
    SELF.hot_list_telephone_change_date_Invalid := (le.ScrubsBits2 >> 24) & 3;
    SELF.report_date_Invalid := (le.ScrubsBits2 >> 26) & 1;
    SELF.delete_record_indicator_Invalid := (le.ScrubsBits2 >> 27) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    duns_number_CUSTOM_ErrorCount := COUNT(GROUP,h.duns_number_Invalid=1);
    business_name_LENGTH_ErrorCount := COUNT(GROUP,h.business_name_Invalid=1);
    street_ALLOW_ErrorCount := COUNT(GROUP,h.street_Invalid=1);
    city_ALLOW_ErrorCount := COUNT(GROUP,h.city_Invalid=1);
    state_ENUM_ErrorCount := COUNT(GROUP,h.state_Invalid=1);
    zip_code_CUSTOM_ErrorCount := COUNT(GROUP,h.zip_code_Invalid=1);
    mail_address_ALLOW_ErrorCount := COUNT(GROUP,h.mail_address_Invalid=1);
    mail_city_ALLOW_ErrorCount := COUNT(GROUP,h.mail_city_Invalid=1);
    mail_state_ENUM_ErrorCount := COUNT(GROUP,h.mail_state_Invalid=1);
    mail_zip_code_CUSTOM_ErrorCount := COUNT(GROUP,h.mail_zip_code_Invalid=1);
    telephone_number_ALLOW_ErrorCount := COUNT(GROUP,h.telephone_number_Invalid=1);
    telephone_number_LENGTH_ErrorCount := COUNT(GROUP,h.telephone_number_Invalid=2);
    telephone_number_Total_ErrorCount := COUNT(GROUP,h.telephone_number_Invalid>0);
    county_name_ALLOW_ErrorCount := COUNT(GROUP,h.county_name_Invalid=1);
    msa_code_ALLOW_ErrorCount := COUNT(GROUP,h.msa_code_Invalid=1);
    msa_code_LENGTH_ErrorCount := COUNT(GROUP,h.msa_code_Invalid=2);
    msa_code_Total_ErrorCount := COUNT(GROUP,h.msa_code_Invalid>0);
    sic1_CUSTOM_ErrorCount := COUNT(GROUP,h.sic1_Invalid=1);
    sic1a_CUSTOM_ErrorCount := COUNT(GROUP,h.sic1a_Invalid=1);
    sic1b_CUSTOM_ErrorCount := COUNT(GROUP,h.sic1b_Invalid=1);
    sic1c_CUSTOM_ErrorCount := COUNT(GROUP,h.sic1c_Invalid=1);
    sic1d_CUSTOM_ErrorCount := COUNT(GROUP,h.sic1d_Invalid=1);
    sic2_CUSTOM_ErrorCount := COUNT(GROUP,h.sic2_Invalid=1);
    sic2a_CUSTOM_ErrorCount := COUNT(GROUP,h.sic2a_Invalid=1);
    sic2b_CUSTOM_ErrorCount := COUNT(GROUP,h.sic2b_Invalid=1);
    sic2c_CUSTOM_ErrorCount := COUNT(GROUP,h.sic2c_Invalid=1);
    sic2d_CUSTOM_ErrorCount := COUNT(GROUP,h.sic2d_Invalid=1);
    sic3_CUSTOM_ErrorCount := COUNT(GROUP,h.sic3_Invalid=1);
    sic3a_CUSTOM_ErrorCount := COUNT(GROUP,h.sic3a_Invalid=1);
    sic3b_CUSTOM_ErrorCount := COUNT(GROUP,h.sic3b_Invalid=1);
    sic3c_CUSTOM_ErrorCount := COUNT(GROUP,h.sic3c_Invalid=1);
    sic3d_CUSTOM_ErrorCount := COUNT(GROUP,h.sic3d_Invalid=1);
    sic4_CUSTOM_ErrorCount := COUNT(GROUP,h.sic4_Invalid=1);
    sic4a_CUSTOM_ErrorCount := COUNT(GROUP,h.sic4a_Invalid=1);
    sic4b_CUSTOM_ErrorCount := COUNT(GROUP,h.sic4b_Invalid=1);
    sic4c_CUSTOM_ErrorCount := COUNT(GROUP,h.sic4c_Invalid=1);
    sic4d_CUSTOM_ErrorCount := COUNT(GROUP,h.sic4d_Invalid=1);
    sic5_CUSTOM_ErrorCount := COUNT(GROUP,h.sic5_Invalid=1);
    sic5a_CUSTOM_ErrorCount := COUNT(GROUP,h.sic5a_Invalid=1);
    sic5b_CUSTOM_ErrorCount := COUNT(GROUP,h.sic5b_Invalid=1);
    sic5c_CUSTOM_ErrorCount := COUNT(GROUP,h.sic5c_Invalid=1);
    sic5d_CUSTOM_ErrorCount := COUNT(GROUP,h.sic5d_Invalid=1);
    sic6_CUSTOM_ErrorCount := COUNT(GROUP,h.sic6_Invalid=1);
    sic6a_CUSTOM_ErrorCount := COUNT(GROUP,h.sic6a_Invalid=1);
    sic6b_CUSTOM_ErrorCount := COUNT(GROUP,h.sic6b_Invalid=1);
    sic6c_CUSTOM_ErrorCount := COUNT(GROUP,h.sic6c_Invalid=1);
    sic6d_CUSTOM_ErrorCount := COUNT(GROUP,h.sic6d_Invalid=1);
    industry_group_ENUM_ErrorCount := COUNT(GROUP,h.industry_group_Invalid=1);
    year_started_ALLOW_ErrorCount := COUNT(GROUP,h.year_started_Invalid=1);
    year_started_LENGTH_ErrorCount := COUNT(GROUP,h.year_started_Invalid=2);
    year_started_Total_ErrorCount := COUNT(GROUP,h.year_started_Invalid>0);
    date_of_incorporation_ALLOW_ErrorCount := COUNT(GROUP,h.date_of_incorporation_Invalid=1);
    state_of_incorporation_abbr_ENUM_ErrorCount := COUNT(GROUP,h.state_of_incorporation_abbr_Invalid=1);
    annual_sales_code_ENUM_ErrorCount := COUNT(GROUP,h.annual_sales_code_Invalid=1);
    employees_here_code_ENUM_ErrorCount := COUNT(GROUP,h.employees_here_code_Invalid=1);
    annual_sales_revision_date_CUSTOM_ErrorCount := COUNT(GROUP,h.annual_sales_revision_date_Invalid=1);
    square_footage_ALLOW_ErrorCount := COUNT(GROUP,h.square_footage_Invalid=1);
    sals_territory_ENUM_ErrorCount := COUNT(GROUP,h.sals_territory_Invalid=1);
    owns_rents_ENUM_ErrorCount := COUNT(GROUP,h.owns_rents_Invalid=1);
    number_of_accounts_CUSTOM_ErrorCount := COUNT(GROUP,h.number_of_accounts_Invalid=1);
    small_business_indicator_ENUM_ErrorCount := COUNT(GROUP,h.small_business_indicator_Invalid=1);
    minority_owned_ENUM_ErrorCount := COUNT(GROUP,h.minority_owned_Invalid=1);
    cottage_indicator_ENUM_ErrorCount := COUNT(GROUP,h.cottage_indicator_Invalid=1);
    foreign_owned_ENUM_ErrorCount := COUNT(GROUP,h.foreign_owned_Invalid=1);
    manufacturing_here_indicator_ENUM_ErrorCount := COUNT(GROUP,h.manufacturing_here_indicator_Invalid=1);
    public_indicator_ENUM_ErrorCount := COUNT(GROUP,h.public_indicator_Invalid=1);
    importer_exporter_indicator_ENUM_ErrorCount := COUNT(GROUP,h.importer_exporter_indicator_Invalid=1);
    structure_type_ENUM_ErrorCount := COUNT(GROUP,h.structure_type_Invalid=1);
    type_of_establishment_ENUM_ErrorCount := COUNT(GROUP,h.type_of_establishment_Invalid=1);
    parent_duns_number_CUSTOM_ErrorCount := COUNT(GROUP,h.parent_duns_number_Invalid=1);
    ultimate_duns_number_CUSTOM_ErrorCount := COUNT(GROUP,h.ultimate_duns_number_Invalid=1);
    headquarters_duns_number_CUSTOM_ErrorCount := COUNT(GROUP,h.headquarters_duns_number_Invalid=1);
    dias_code_CUSTOM_ErrorCount := COUNT(GROUP,h.dias_code_Invalid=1);
    hierarchy_code_CUSTOM_ErrorCount := COUNT(GROUP,h.hierarchy_code_Invalid=1);
    ultimate_indicator_ENUM_ErrorCount := COUNT(GROUP,h.ultimate_indicator_Invalid=1);
    hot_list_new_indicator_ENUM_ErrorCount := COUNT(GROUP,h.hot_list_new_indicator_Invalid=1);
    hot_list_ownership_change_indicator_ENUM_ErrorCount := COUNT(GROUP,h.hot_list_ownership_change_indicator_Invalid=1);
    hot_list_ceo_change_indicator_ENUM_ErrorCount := COUNT(GROUP,h.hot_list_ceo_change_indicator_Invalid=1);
    hot_list_company_name_change_ind_ENUM_ErrorCount := COUNT(GROUP,h.hot_list_company_name_change_ind_Invalid=1);
    hot_list_address_change_indicator_ENUM_ErrorCount := COUNT(GROUP,h.hot_list_address_change_indicator_Invalid=1);
    hot_list_telephone_change_indicator_ENUM_ErrorCount := COUNT(GROUP,h.hot_list_telephone_change_indicator_Invalid=1);
    hot_list_new_change_date_ALLOW_ErrorCount := COUNT(GROUP,h.hot_list_new_change_date_Invalid=1);
    hot_list_new_change_date_LENGTH_ErrorCount := COUNT(GROUP,h.hot_list_new_change_date_Invalid=2);
    hot_list_new_change_date_Total_ErrorCount := COUNT(GROUP,h.hot_list_new_change_date_Invalid>0);
    hot_list_ownership_change_date_ALLOW_ErrorCount := COUNT(GROUP,h.hot_list_ownership_change_date_Invalid=1);
    hot_list_ownership_change_date_LENGTH_ErrorCount := COUNT(GROUP,h.hot_list_ownership_change_date_Invalid=2);
    hot_list_ownership_change_date_Total_ErrorCount := COUNT(GROUP,h.hot_list_ownership_change_date_Invalid>0);
    hot_list_ceo_change_date_ALLOW_ErrorCount := COUNT(GROUP,h.hot_list_ceo_change_date_Invalid=1);
    hot_list_ceo_change_date_LENGTH_ErrorCount := COUNT(GROUP,h.hot_list_ceo_change_date_Invalid=2);
    hot_list_ceo_change_date_Total_ErrorCount := COUNT(GROUP,h.hot_list_ceo_change_date_Invalid>0);
    hot_list_company_name_chg_date_ALLOW_ErrorCount := COUNT(GROUP,h.hot_list_company_name_chg_date_Invalid=1);
    hot_list_company_name_chg_date_LENGTH_ErrorCount := COUNT(GROUP,h.hot_list_company_name_chg_date_Invalid=2);
    hot_list_company_name_chg_date_Total_ErrorCount := COUNT(GROUP,h.hot_list_company_name_chg_date_Invalid>0);
    hot_list_address_change_date_ALLOW_ErrorCount := COUNT(GROUP,h.hot_list_address_change_date_Invalid=1);
    hot_list_address_change_date_LENGTH_ErrorCount := COUNT(GROUP,h.hot_list_address_change_date_Invalid=2);
    hot_list_address_change_date_Total_ErrorCount := COUNT(GROUP,h.hot_list_address_change_date_Invalid>0);
    hot_list_telephone_change_date_ALLOW_ErrorCount := COUNT(GROUP,h.hot_list_telephone_change_date_Invalid=1);
    hot_list_telephone_change_date_LENGTH_ErrorCount := COUNT(GROUP,h.hot_list_telephone_change_date_Invalid=2);
    hot_list_telephone_change_date_Total_ErrorCount := COUNT(GROUP,h.hot_list_telephone_change_date_Invalid>0);
    report_date_CUSTOM_ErrorCount := COUNT(GROUP,h.report_date_Invalid=1);
    delete_record_indicator_ENUM_ErrorCount := COUNT(GROUP,h.delete_record_indicator_Invalid=1);
  END;
  EXPORT SummaryStats := TABLE(h,r);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT34.StrType ErrorMessage;
    SALT34.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.duns_number_Invalid,le.business_name_Invalid,le.street_Invalid,le.city_Invalid,le.state_Invalid,le.zip_code_Invalid,le.mail_address_Invalid,le.mail_city_Invalid,le.mail_state_Invalid,le.mail_zip_code_Invalid,le.telephone_number_Invalid,le.county_name_Invalid,le.msa_code_Invalid,le.sic1_Invalid,le.sic1a_Invalid,le.sic1b_Invalid,le.sic1c_Invalid,le.sic1d_Invalid,le.sic2_Invalid,le.sic2a_Invalid,le.sic2b_Invalid,le.sic2c_Invalid,le.sic2d_Invalid,le.sic3_Invalid,le.sic3a_Invalid,le.sic3b_Invalid,le.sic3c_Invalid,le.sic3d_Invalid,le.sic4_Invalid,le.sic4a_Invalid,le.sic4b_Invalid,le.sic4c_Invalid,le.sic4d_Invalid,le.sic5_Invalid,le.sic5a_Invalid,le.sic5b_Invalid,le.sic5c_Invalid,le.sic5d_Invalid,le.sic6_Invalid,le.sic6a_Invalid,le.sic6b_Invalid,le.sic6c_Invalid,le.sic6d_Invalid,le.industry_group_Invalid,le.year_started_Invalid,le.date_of_incorporation_Invalid,le.state_of_incorporation_abbr_Invalid,le.annual_sales_code_Invalid,le.employees_here_code_Invalid,le.annual_sales_revision_date_Invalid,le.square_footage_Invalid,le.sals_territory_Invalid,le.owns_rents_Invalid,le.number_of_accounts_Invalid,le.small_business_indicator_Invalid,le.minority_owned_Invalid,le.cottage_indicator_Invalid,le.foreign_owned_Invalid,le.manufacturing_here_indicator_Invalid,le.public_indicator_Invalid,le.importer_exporter_indicator_Invalid,le.structure_type_Invalid,le.type_of_establishment_Invalid,le.parent_duns_number_Invalid,le.ultimate_duns_number_Invalid,le.headquarters_duns_number_Invalid,le.dias_code_Invalid,le.hierarchy_code_Invalid,le.ultimate_indicator_Invalid,le.hot_list_new_indicator_Invalid,le.hot_list_ownership_change_indicator_Invalid,le.hot_list_ceo_change_indicator_Invalid,le.hot_list_company_name_change_ind_Invalid,le.hot_list_address_change_indicator_Invalid,le.hot_list_telephone_change_indicator_Invalid,le.hot_list_new_change_date_Invalid,le.hot_list_ownership_change_date_Invalid,le.hot_list_ceo_change_date_Invalid,le.hot_list_company_name_chg_date_Invalid,le.hot_list_address_change_date_Invalid,le.hot_list_telephone_change_date_Invalid,le.report_date_Invalid,le.delete_record_indicator_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Raw_Fields.InvalidMessage_duns_number(le.duns_number_Invalid),Raw_Fields.InvalidMessage_business_name(le.business_name_Invalid),Raw_Fields.InvalidMessage_street(le.street_Invalid),Raw_Fields.InvalidMessage_city(le.city_Invalid),Raw_Fields.InvalidMessage_state(le.state_Invalid),Raw_Fields.InvalidMessage_zip_code(le.zip_code_Invalid),Raw_Fields.InvalidMessage_mail_address(le.mail_address_Invalid),Raw_Fields.InvalidMessage_mail_city(le.mail_city_Invalid),Raw_Fields.InvalidMessage_mail_state(le.mail_state_Invalid),Raw_Fields.InvalidMessage_mail_zip_code(le.mail_zip_code_Invalid),Raw_Fields.InvalidMessage_telephone_number(le.telephone_number_Invalid),Raw_Fields.InvalidMessage_county_name(le.county_name_Invalid),Raw_Fields.InvalidMessage_msa_code(le.msa_code_Invalid),Raw_Fields.InvalidMessage_sic1(le.sic1_Invalid),Raw_Fields.InvalidMessage_sic1a(le.sic1a_Invalid),Raw_Fields.InvalidMessage_sic1b(le.sic1b_Invalid),Raw_Fields.InvalidMessage_sic1c(le.sic1c_Invalid),Raw_Fields.InvalidMessage_sic1d(le.sic1d_Invalid),Raw_Fields.InvalidMessage_sic2(le.sic2_Invalid),Raw_Fields.InvalidMessage_sic2a(le.sic2a_Invalid),Raw_Fields.InvalidMessage_sic2b(le.sic2b_Invalid),Raw_Fields.InvalidMessage_sic2c(le.sic2c_Invalid),Raw_Fields.InvalidMessage_sic2d(le.sic2d_Invalid),Raw_Fields.InvalidMessage_sic3(le.sic3_Invalid),Raw_Fields.InvalidMessage_sic3a(le.sic3a_Invalid),Raw_Fields.InvalidMessage_sic3b(le.sic3b_Invalid),Raw_Fields.InvalidMessage_sic3c(le.sic3c_Invalid),Raw_Fields.InvalidMessage_sic3d(le.sic3d_Invalid),Raw_Fields.InvalidMessage_sic4(le.sic4_Invalid),Raw_Fields.InvalidMessage_sic4a(le.sic4a_Invalid),Raw_Fields.InvalidMessage_sic4b(le.sic4b_Invalid),Raw_Fields.InvalidMessage_sic4c(le.sic4c_Invalid),Raw_Fields.InvalidMessage_sic4d(le.sic4d_Invalid),Raw_Fields.InvalidMessage_sic5(le.sic5_Invalid),Raw_Fields.InvalidMessage_sic5a(le.sic5a_Invalid),Raw_Fields.InvalidMessage_sic5b(le.sic5b_Invalid),Raw_Fields.InvalidMessage_sic5c(le.sic5c_Invalid),Raw_Fields.InvalidMessage_sic5d(le.sic5d_Invalid),Raw_Fields.InvalidMessage_sic6(le.sic6_Invalid),Raw_Fields.InvalidMessage_sic6a(le.sic6a_Invalid),Raw_Fields.InvalidMessage_sic6b(le.sic6b_Invalid),Raw_Fields.InvalidMessage_sic6c(le.sic6c_Invalid),Raw_Fields.InvalidMessage_sic6d(le.sic6d_Invalid),Raw_Fields.InvalidMessage_industry_group(le.industry_group_Invalid),Raw_Fields.InvalidMessage_year_started(le.year_started_Invalid),Raw_Fields.InvalidMessage_date_of_incorporation(le.date_of_incorporation_Invalid),Raw_Fields.InvalidMessage_state_of_incorporation_abbr(le.state_of_incorporation_abbr_Invalid),Raw_Fields.InvalidMessage_annual_sales_code(le.annual_sales_code_Invalid),Raw_Fields.InvalidMessage_employees_here_code(le.employees_here_code_Invalid),Raw_Fields.InvalidMessage_annual_sales_revision_date(le.annual_sales_revision_date_Invalid),Raw_Fields.InvalidMessage_square_footage(le.square_footage_Invalid),Raw_Fields.InvalidMessage_sals_territory(le.sals_territory_Invalid),Raw_Fields.InvalidMessage_owns_rents(le.owns_rents_Invalid),Raw_Fields.InvalidMessage_number_of_accounts(le.number_of_accounts_Invalid),Raw_Fields.InvalidMessage_small_business_indicator(le.small_business_indicator_Invalid),Raw_Fields.InvalidMessage_minority_owned(le.minority_owned_Invalid),Raw_Fields.InvalidMessage_cottage_indicator(le.cottage_indicator_Invalid),Raw_Fields.InvalidMessage_foreign_owned(le.foreign_owned_Invalid),Raw_Fields.InvalidMessage_manufacturing_here_indicator(le.manufacturing_here_indicator_Invalid),Raw_Fields.InvalidMessage_public_indicator(le.public_indicator_Invalid),Raw_Fields.InvalidMessage_importer_exporter_indicator(le.importer_exporter_indicator_Invalid),Raw_Fields.InvalidMessage_structure_type(le.structure_type_Invalid),Raw_Fields.InvalidMessage_type_of_establishment(le.type_of_establishment_Invalid),Raw_Fields.InvalidMessage_parent_duns_number(le.parent_duns_number_Invalid),Raw_Fields.InvalidMessage_ultimate_duns_number(le.ultimate_duns_number_Invalid),Raw_Fields.InvalidMessage_headquarters_duns_number(le.headquarters_duns_number_Invalid),Raw_Fields.InvalidMessage_dias_code(le.dias_code_Invalid),Raw_Fields.InvalidMessage_hierarchy_code(le.hierarchy_code_Invalid),Raw_Fields.InvalidMessage_ultimate_indicator(le.ultimate_indicator_Invalid),Raw_Fields.InvalidMessage_hot_list_new_indicator(le.hot_list_new_indicator_Invalid),Raw_Fields.InvalidMessage_hot_list_ownership_change_indicator(le.hot_list_ownership_change_indicator_Invalid),Raw_Fields.InvalidMessage_hot_list_ceo_change_indicator(le.hot_list_ceo_change_indicator_Invalid),Raw_Fields.InvalidMessage_hot_list_company_name_change_ind(le.hot_list_company_name_change_ind_Invalid),Raw_Fields.InvalidMessage_hot_list_address_change_indicator(le.hot_list_address_change_indicator_Invalid),Raw_Fields.InvalidMessage_hot_list_telephone_change_indicator(le.hot_list_telephone_change_indicator_Invalid),Raw_Fields.InvalidMessage_hot_list_new_change_date(le.hot_list_new_change_date_Invalid),Raw_Fields.InvalidMessage_hot_list_ownership_change_date(le.hot_list_ownership_change_date_Invalid),Raw_Fields.InvalidMessage_hot_list_ceo_change_date(le.hot_list_ceo_change_date_Invalid),Raw_Fields.InvalidMessage_hot_list_company_name_chg_date(le.hot_list_company_name_chg_date_Invalid),Raw_Fields.InvalidMessage_hot_list_address_change_date(le.hot_list_address_change_date_Invalid),Raw_Fields.InvalidMessage_hot_list_telephone_change_date(le.hot_list_telephone_change_date_Invalid),Raw_Fields.InvalidMessage_report_date(le.report_date_Invalid),Raw_Fields.InvalidMessage_delete_record_indicator(le.delete_record_indicator_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.duns_number_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.business_name_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.street_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.city_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.state_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.zip_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.mail_address_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mail_city_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mail_state_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.mail_zip_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.telephone_number_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.county_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.msa_code_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.sic1_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sic1a_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sic1b_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sic1c_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sic1d_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sic2_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sic2a_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sic2b_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sic2c_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sic2d_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sic3_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sic3a_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sic3b_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sic3c_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sic3d_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sic4_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sic4a_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sic4b_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sic4c_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sic4d_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sic5_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sic5a_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sic5b_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sic5c_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sic5d_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sic6_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sic6a_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sic6b_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sic6c_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sic6d_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.industry_group_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.year_started_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.date_of_incorporation_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.state_of_incorporation_abbr_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.annual_sales_code_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.employees_here_code_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.annual_sales_revision_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.square_footage_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.sals_territory_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.owns_rents_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.number_of_accounts_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.small_business_indicator_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.minority_owned_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.cottage_indicator_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.foreign_owned_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.manufacturing_here_indicator_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.public_indicator_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.importer_exporter_indicator_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.structure_type_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.type_of_establishment_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.parent_duns_number_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.ultimate_duns_number_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.headquarters_duns_number_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dias_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.hierarchy_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.ultimate_indicator_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.hot_list_new_indicator_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.hot_list_ownership_change_indicator_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.hot_list_ceo_change_indicator_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.hot_list_company_name_change_ind_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.hot_list_address_change_indicator_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.hot_list_telephone_change_indicator_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.hot_list_new_change_date_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.hot_list_ownership_change_date_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.hot_list_ceo_change_date_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.hot_list_company_name_chg_date_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.hot_list_address_change_date_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.hot_list_telephone_change_date_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.report_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.delete_record_indicator_Invalid,'ENUM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'duns_number','business_name','street','city','state','zip_code','mail_address','mail_city','mail_state','mail_zip_code','telephone_number','county_name','msa_code','sic1','sic1a','sic1b','sic1c','sic1d','sic2','sic2a','sic2b','sic2c','sic2d','sic3','sic3a','sic3b','sic3c','sic3d','sic4','sic4a','sic4b','sic4c','sic4d','sic5','sic5a','sic5b','sic5c','sic5d','sic6','sic6a','sic6b','sic6c','sic6d','industry_group','year_started','date_of_incorporation','state_of_incorporation_abbr','annual_sales_code','employees_here_code','annual_sales_revision_date','square_footage','sals_territory','owns_rents','number_of_accounts','small_business_indicator','minority_owned','cottage_indicator','foreign_owned','manufacturing_here_indicator','public_indicator','importer_exporter_indicator','structure_type','type_of_establishment','parent_duns_number','ultimate_duns_number','headquarters_duns_number','dias_code','hierarchy_code','ultimate_indicator','hot_list_new_indicator','hot_list_ownership_change_indicator','hot_list_ceo_change_indicator','hot_list_company_name_change_ind','hot_list_address_change_indicator','hot_list_telephone_change_indicator','hot_list_new_change_date','hot_list_ownership_change_date','hot_list_ceo_change_date','hot_list_company_name_chg_date','hot_list_address_change_date','hot_list_telephone_change_date','report_date','delete_record_indicator','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid__duns','invalid__mandatory','invalid__street','invalid__city','invalid__state','invalid__zip','invalid__street','invalid__city','invalid__state','invalid__zip','invalid__phone','invalid__county','invalid__msa','invalid__sic','invalid__sic','invalid__sic','invalid__sic','invalid__sic','invalid__sic','invalid__sic','invalid__sic','invalid__sic','invalid__sic','invalid__sic','invalid__sic','invalid__sic','invalid__sic','invalid__sic','invalid__sic','invalid__sic','invalid__sic','invalid__sic','invalid__sic','invalid__sic','invalid__sic','invalid__sic','invalid__sic','invalid__sic','invalid__sic','invalid__sic','invalid__sic','invalid__sic','invalid__sic','invalid__industry','invalid__year','invalid__chars','invalid__state','invalid__code','invalid__code','invalid__optional_date','invalid__square_ft','invalid__code5','invalid__owns_rent','invalid__all_digits','invalid__yes_no','invalid__yes_no','invalid__yes_no','invalid__yes_no','invalid__yes_no','invalid__yes_no','invalid__code','invalid__code','invalid__code5','invalid__duns','invalid__duns','invalid__duns','invalid__all_digits','invalid__hierarchy','invalid__yes_no','invalid__code','invalid__4orBlank','invalid__5orBlank','invalid__6orBlank','invalid__7orBlank','invalid__8orBlank','invalid__year','invalid__year','invalid__year','invalid__year','invalid__year','invalid__year','invalid__report_date','invalid__delete_indicator','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT34.StrType)le.duns_number,(SALT34.StrType)le.business_name,(SALT34.StrType)le.street,(SALT34.StrType)le.city,(SALT34.StrType)le.state,(SALT34.StrType)le.zip_code,(SALT34.StrType)le.mail_address,(SALT34.StrType)le.mail_city,(SALT34.StrType)le.mail_state,(SALT34.StrType)le.mail_zip_code,(SALT34.StrType)le.telephone_number,(SALT34.StrType)le.county_name,(SALT34.StrType)le.msa_code,(SALT34.StrType)le.sic1,(SALT34.StrType)le.sic1a,(SALT34.StrType)le.sic1b,(SALT34.StrType)le.sic1c,(SALT34.StrType)le.sic1d,(SALT34.StrType)le.sic2,(SALT34.StrType)le.sic2a,(SALT34.StrType)le.sic2b,(SALT34.StrType)le.sic2c,(SALT34.StrType)le.sic2d,(SALT34.StrType)le.sic3,(SALT34.StrType)le.sic3a,(SALT34.StrType)le.sic3b,(SALT34.StrType)le.sic3c,(SALT34.StrType)le.sic3d,(SALT34.StrType)le.sic4,(SALT34.StrType)le.sic4a,(SALT34.StrType)le.sic4b,(SALT34.StrType)le.sic4c,(SALT34.StrType)le.sic4d,(SALT34.StrType)le.sic5,(SALT34.StrType)le.sic5a,(SALT34.StrType)le.sic5b,(SALT34.StrType)le.sic5c,(SALT34.StrType)le.sic5d,(SALT34.StrType)le.sic6,(SALT34.StrType)le.sic6a,(SALT34.StrType)le.sic6b,(SALT34.StrType)le.sic6c,(SALT34.StrType)le.sic6d,(SALT34.StrType)le.industry_group,(SALT34.StrType)le.year_started,(SALT34.StrType)le.date_of_incorporation,(SALT34.StrType)le.state_of_incorporation_abbr,(SALT34.StrType)le.annual_sales_code,(SALT34.StrType)le.employees_here_code,(SALT34.StrType)le.annual_sales_revision_date,(SALT34.StrType)le.square_footage,(SALT34.StrType)le.sals_territory,(SALT34.StrType)le.owns_rents,(SALT34.StrType)le.number_of_accounts,(SALT34.StrType)le.small_business_indicator,(SALT34.StrType)le.minority_owned,(SALT34.StrType)le.cottage_indicator,(SALT34.StrType)le.foreign_owned,(SALT34.StrType)le.manufacturing_here_indicator,(SALT34.StrType)le.public_indicator,(SALT34.StrType)le.importer_exporter_indicator,(SALT34.StrType)le.structure_type,(SALT34.StrType)le.type_of_establishment,(SALT34.StrType)le.parent_duns_number,(SALT34.StrType)le.ultimate_duns_number,(SALT34.StrType)le.headquarters_duns_number,(SALT34.StrType)le.dias_code,(SALT34.StrType)le.hierarchy_code,(SALT34.StrType)le.ultimate_indicator,(SALT34.StrType)le.hot_list_new_indicator,(SALT34.StrType)le.hot_list_ownership_change_indicator,(SALT34.StrType)le.hot_list_ceo_change_indicator,(SALT34.StrType)le.hot_list_company_name_change_ind,(SALT34.StrType)le.hot_list_address_change_indicator,(SALT34.StrType)le.hot_list_telephone_change_indicator,(SALT34.StrType)le.hot_list_new_change_date,(SALT34.StrType)le.hot_list_ownership_change_date,(SALT34.StrType)le.hot_list_ceo_change_date,(SALT34.StrType)le.hot_list_company_name_chg_date,(SALT34.StrType)le.hot_list_address_change_date,(SALT34.StrType)le.hot_list_telephone_change_date,(SALT34.StrType)le.report_date,(SALT34.StrType)le.delete_record_indicator,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,83,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT34.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'duns_number:invalid__duns:CUSTOM'
          ,'business_name:invalid__mandatory:LENGTH'
          ,'street:invalid__street:ALLOW'
          ,'city:invalid__city:ALLOW'
          ,'state:invalid__state:ENUM'
          ,'zip_code:invalid__zip:CUSTOM'
          ,'mail_address:invalid__street:ALLOW'
          ,'mail_city:invalid__city:ALLOW'
          ,'mail_state:invalid__state:ENUM'
          ,'mail_zip_code:invalid__zip:CUSTOM'
          ,'telephone_number:invalid__phone:ALLOW','telephone_number:invalid__phone:LENGTH'
          ,'county_name:invalid__county:ALLOW'
          ,'msa_code:invalid__msa:ALLOW','msa_code:invalid__msa:LENGTH'
          ,'sic1:invalid__sic:CUSTOM'
          ,'sic1a:invalid__sic:CUSTOM'
          ,'sic1b:invalid__sic:CUSTOM'
          ,'sic1c:invalid__sic:CUSTOM'
          ,'sic1d:invalid__sic:CUSTOM'
          ,'sic2:invalid__sic:CUSTOM'
          ,'sic2a:invalid__sic:CUSTOM'
          ,'sic2b:invalid__sic:CUSTOM'
          ,'sic2c:invalid__sic:CUSTOM'
          ,'sic2d:invalid__sic:CUSTOM'
          ,'sic3:invalid__sic:CUSTOM'
          ,'sic3a:invalid__sic:CUSTOM'
          ,'sic3b:invalid__sic:CUSTOM'
          ,'sic3c:invalid__sic:CUSTOM'
          ,'sic3d:invalid__sic:CUSTOM'
          ,'sic4:invalid__sic:CUSTOM'
          ,'sic4a:invalid__sic:CUSTOM'
          ,'sic4b:invalid__sic:CUSTOM'
          ,'sic4c:invalid__sic:CUSTOM'
          ,'sic4d:invalid__sic:CUSTOM'
          ,'sic5:invalid__sic:CUSTOM'
          ,'sic5a:invalid__sic:CUSTOM'
          ,'sic5b:invalid__sic:CUSTOM'
          ,'sic5c:invalid__sic:CUSTOM'
          ,'sic5d:invalid__sic:CUSTOM'
          ,'sic6:invalid__sic:CUSTOM'
          ,'sic6a:invalid__sic:CUSTOM'
          ,'sic6b:invalid__sic:CUSTOM'
          ,'sic6c:invalid__sic:CUSTOM'
          ,'sic6d:invalid__sic:CUSTOM'
          ,'industry_group:invalid__industry:ENUM'
          ,'year_started:invalid__year:ALLOW','year_started:invalid__year:LENGTH'
          ,'date_of_incorporation:invalid__chars:ALLOW'
          ,'state_of_incorporation_abbr:invalid__state:ENUM'
          ,'annual_sales_code:invalid__code:ENUM'
          ,'employees_here_code:invalid__code:ENUM'
          ,'annual_sales_revision_date:invalid__optional_date:CUSTOM'
          ,'square_footage:invalid__square_ft:ALLOW'
          ,'sals_territory:invalid__code5:ENUM'
          ,'owns_rents:invalid__owns_rent:ENUM'
          ,'number_of_accounts:invalid__all_digits:CUSTOM'
          ,'small_business_indicator:invalid__yes_no:ENUM'
          ,'minority_owned:invalid__yes_no:ENUM'
          ,'cottage_indicator:invalid__yes_no:ENUM'
          ,'foreign_owned:invalid__yes_no:ENUM'
          ,'manufacturing_here_indicator:invalid__yes_no:ENUM'
          ,'public_indicator:invalid__yes_no:ENUM'
          ,'importer_exporter_indicator:invalid__code:ENUM'
          ,'structure_type:invalid__code:ENUM'
          ,'type_of_establishment:invalid__code5:ENUM'
          ,'parent_duns_number:invalid__duns:CUSTOM'
          ,'ultimate_duns_number:invalid__duns:CUSTOM'
          ,'headquarters_duns_number:invalid__duns:CUSTOM'
          ,'dias_code:invalid__all_digits:CUSTOM'
          ,'hierarchy_code:invalid__hierarchy:CUSTOM'
          ,'ultimate_indicator:invalid__yes_no:ENUM'
          ,'hot_list_new_indicator:invalid__code:ENUM'
          ,'hot_list_ownership_change_indicator:invalid__4orBlank:ENUM'
          ,'hot_list_ceo_change_indicator:invalid__5orBlank:ENUM'
          ,'hot_list_company_name_change_ind:invalid__6orBlank:ENUM'
          ,'hot_list_address_change_indicator:invalid__7orBlank:ENUM'
          ,'hot_list_telephone_change_indicator:invalid__8orBlank:ENUM'
          ,'hot_list_new_change_date:invalid__year:ALLOW','hot_list_new_change_date:invalid__year:LENGTH'
          ,'hot_list_ownership_change_date:invalid__year:ALLOW','hot_list_ownership_change_date:invalid__year:LENGTH'
          ,'hot_list_ceo_change_date:invalid__year:ALLOW','hot_list_ceo_change_date:invalid__year:LENGTH'
          ,'hot_list_company_name_chg_date:invalid__year:ALLOW','hot_list_company_name_chg_date:invalid__year:LENGTH'
          ,'hot_list_address_change_date:invalid__year:ALLOW','hot_list_address_change_date:invalid__year:LENGTH'
          ,'hot_list_telephone_change_date:invalid__year:ALLOW','hot_list_telephone_change_date:invalid__year:LENGTH'
          ,'report_date:invalid__report_date:CUSTOM'
          ,'delete_record_indicator:invalid__delete_indicator:ENUM','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Raw_Fields.InvalidMessage_duns_number(1)
          ,Raw_Fields.InvalidMessage_business_name(1)
          ,Raw_Fields.InvalidMessage_street(1)
          ,Raw_Fields.InvalidMessage_city(1)
          ,Raw_Fields.InvalidMessage_state(1)
          ,Raw_Fields.InvalidMessage_zip_code(1)
          ,Raw_Fields.InvalidMessage_mail_address(1)
          ,Raw_Fields.InvalidMessage_mail_city(1)
          ,Raw_Fields.InvalidMessage_mail_state(1)
          ,Raw_Fields.InvalidMessage_mail_zip_code(1)
          ,Raw_Fields.InvalidMessage_telephone_number(1),Raw_Fields.InvalidMessage_telephone_number(2)
          ,Raw_Fields.InvalidMessage_county_name(1)
          ,Raw_Fields.InvalidMessage_msa_code(1),Raw_Fields.InvalidMessage_msa_code(2)
          ,Raw_Fields.InvalidMessage_sic1(1)
          ,Raw_Fields.InvalidMessage_sic1a(1)
          ,Raw_Fields.InvalidMessage_sic1b(1)
          ,Raw_Fields.InvalidMessage_sic1c(1)
          ,Raw_Fields.InvalidMessage_sic1d(1)
          ,Raw_Fields.InvalidMessage_sic2(1)
          ,Raw_Fields.InvalidMessage_sic2a(1)
          ,Raw_Fields.InvalidMessage_sic2b(1)
          ,Raw_Fields.InvalidMessage_sic2c(1)
          ,Raw_Fields.InvalidMessage_sic2d(1)
          ,Raw_Fields.InvalidMessage_sic3(1)
          ,Raw_Fields.InvalidMessage_sic3a(1)
          ,Raw_Fields.InvalidMessage_sic3b(1)
          ,Raw_Fields.InvalidMessage_sic3c(1)
          ,Raw_Fields.InvalidMessage_sic3d(1)
          ,Raw_Fields.InvalidMessage_sic4(1)
          ,Raw_Fields.InvalidMessage_sic4a(1)
          ,Raw_Fields.InvalidMessage_sic4b(1)
          ,Raw_Fields.InvalidMessage_sic4c(1)
          ,Raw_Fields.InvalidMessage_sic4d(1)
          ,Raw_Fields.InvalidMessage_sic5(1)
          ,Raw_Fields.InvalidMessage_sic5a(1)
          ,Raw_Fields.InvalidMessage_sic5b(1)
          ,Raw_Fields.InvalidMessage_sic5c(1)
          ,Raw_Fields.InvalidMessage_sic5d(1)
          ,Raw_Fields.InvalidMessage_sic6(1)
          ,Raw_Fields.InvalidMessage_sic6a(1)
          ,Raw_Fields.InvalidMessage_sic6b(1)
          ,Raw_Fields.InvalidMessage_sic6c(1)
          ,Raw_Fields.InvalidMessage_sic6d(1)
          ,Raw_Fields.InvalidMessage_industry_group(1)
          ,Raw_Fields.InvalidMessage_year_started(1),Raw_Fields.InvalidMessage_year_started(2)
          ,Raw_Fields.InvalidMessage_date_of_incorporation(1)
          ,Raw_Fields.InvalidMessage_state_of_incorporation_abbr(1)
          ,Raw_Fields.InvalidMessage_annual_sales_code(1)
          ,Raw_Fields.InvalidMessage_employees_here_code(1)
          ,Raw_Fields.InvalidMessage_annual_sales_revision_date(1)
          ,Raw_Fields.InvalidMessage_square_footage(1)
          ,Raw_Fields.InvalidMessage_sals_territory(1)
          ,Raw_Fields.InvalidMessage_owns_rents(1)
          ,Raw_Fields.InvalidMessage_number_of_accounts(1)
          ,Raw_Fields.InvalidMessage_small_business_indicator(1)
          ,Raw_Fields.InvalidMessage_minority_owned(1)
          ,Raw_Fields.InvalidMessage_cottage_indicator(1)
          ,Raw_Fields.InvalidMessage_foreign_owned(1)
          ,Raw_Fields.InvalidMessage_manufacturing_here_indicator(1)
          ,Raw_Fields.InvalidMessage_public_indicator(1)
          ,Raw_Fields.InvalidMessage_importer_exporter_indicator(1)
          ,Raw_Fields.InvalidMessage_structure_type(1)
          ,Raw_Fields.InvalidMessage_type_of_establishment(1)
          ,Raw_Fields.InvalidMessage_parent_duns_number(1)
          ,Raw_Fields.InvalidMessage_ultimate_duns_number(1)
          ,Raw_Fields.InvalidMessage_headquarters_duns_number(1)
          ,Raw_Fields.InvalidMessage_dias_code(1)
          ,Raw_Fields.InvalidMessage_hierarchy_code(1)
          ,Raw_Fields.InvalidMessage_ultimate_indicator(1)
          ,Raw_Fields.InvalidMessage_hot_list_new_indicator(1)
          ,Raw_Fields.InvalidMessage_hot_list_ownership_change_indicator(1)
          ,Raw_Fields.InvalidMessage_hot_list_ceo_change_indicator(1)
          ,Raw_Fields.InvalidMessage_hot_list_company_name_change_ind(1)
          ,Raw_Fields.InvalidMessage_hot_list_address_change_indicator(1)
          ,Raw_Fields.InvalidMessage_hot_list_telephone_change_indicator(1)
          ,Raw_Fields.InvalidMessage_hot_list_new_change_date(1),Raw_Fields.InvalidMessage_hot_list_new_change_date(2)
          ,Raw_Fields.InvalidMessage_hot_list_ownership_change_date(1),Raw_Fields.InvalidMessage_hot_list_ownership_change_date(2)
          ,Raw_Fields.InvalidMessage_hot_list_ceo_change_date(1),Raw_Fields.InvalidMessage_hot_list_ceo_change_date(2)
          ,Raw_Fields.InvalidMessage_hot_list_company_name_chg_date(1),Raw_Fields.InvalidMessage_hot_list_company_name_chg_date(2)
          ,Raw_Fields.InvalidMessage_hot_list_address_change_date(1),Raw_Fields.InvalidMessage_hot_list_address_change_date(2)
          ,Raw_Fields.InvalidMessage_hot_list_telephone_change_date(1),Raw_Fields.InvalidMessage_hot_list_telephone_change_date(2)
          ,Raw_Fields.InvalidMessage_report_date(1)
          ,Raw_Fields.InvalidMessage_delete_record_indicator(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.duns_number_CUSTOM_ErrorCount
          ,le.business_name_LENGTH_ErrorCount
          ,le.street_ALLOW_ErrorCount
          ,le.city_ALLOW_ErrorCount
          ,le.state_ENUM_ErrorCount
          ,le.zip_code_CUSTOM_ErrorCount
          ,le.mail_address_ALLOW_ErrorCount
          ,le.mail_city_ALLOW_ErrorCount
          ,le.mail_state_ENUM_ErrorCount
          ,le.mail_zip_code_CUSTOM_ErrorCount
          ,le.telephone_number_ALLOW_ErrorCount,le.telephone_number_LENGTH_ErrorCount
          ,le.county_name_ALLOW_ErrorCount
          ,le.msa_code_ALLOW_ErrorCount,le.msa_code_LENGTH_ErrorCount
          ,le.sic1_CUSTOM_ErrorCount
          ,le.sic1a_CUSTOM_ErrorCount
          ,le.sic1b_CUSTOM_ErrorCount
          ,le.sic1c_CUSTOM_ErrorCount
          ,le.sic1d_CUSTOM_ErrorCount
          ,le.sic2_CUSTOM_ErrorCount
          ,le.sic2a_CUSTOM_ErrorCount
          ,le.sic2b_CUSTOM_ErrorCount
          ,le.sic2c_CUSTOM_ErrorCount
          ,le.sic2d_CUSTOM_ErrorCount
          ,le.sic3_CUSTOM_ErrorCount
          ,le.sic3a_CUSTOM_ErrorCount
          ,le.sic3b_CUSTOM_ErrorCount
          ,le.sic3c_CUSTOM_ErrorCount
          ,le.sic3d_CUSTOM_ErrorCount
          ,le.sic4_CUSTOM_ErrorCount
          ,le.sic4a_CUSTOM_ErrorCount
          ,le.sic4b_CUSTOM_ErrorCount
          ,le.sic4c_CUSTOM_ErrorCount
          ,le.sic4d_CUSTOM_ErrorCount
          ,le.sic5_CUSTOM_ErrorCount
          ,le.sic5a_CUSTOM_ErrorCount
          ,le.sic5b_CUSTOM_ErrorCount
          ,le.sic5c_CUSTOM_ErrorCount
          ,le.sic5d_CUSTOM_ErrorCount
          ,le.sic6_CUSTOM_ErrorCount
          ,le.sic6a_CUSTOM_ErrorCount
          ,le.sic6b_CUSTOM_ErrorCount
          ,le.sic6c_CUSTOM_ErrorCount
          ,le.sic6d_CUSTOM_ErrorCount
          ,le.industry_group_ENUM_ErrorCount
          ,le.year_started_ALLOW_ErrorCount,le.year_started_LENGTH_ErrorCount
          ,le.date_of_incorporation_ALLOW_ErrorCount
          ,le.state_of_incorporation_abbr_ENUM_ErrorCount
          ,le.annual_sales_code_ENUM_ErrorCount
          ,le.employees_here_code_ENUM_ErrorCount
          ,le.annual_sales_revision_date_CUSTOM_ErrorCount
          ,le.square_footage_ALLOW_ErrorCount
          ,le.sals_territory_ENUM_ErrorCount
          ,le.owns_rents_ENUM_ErrorCount
          ,le.number_of_accounts_CUSTOM_ErrorCount
          ,le.small_business_indicator_ENUM_ErrorCount
          ,le.minority_owned_ENUM_ErrorCount
          ,le.cottage_indicator_ENUM_ErrorCount
          ,le.foreign_owned_ENUM_ErrorCount
          ,le.manufacturing_here_indicator_ENUM_ErrorCount
          ,le.public_indicator_ENUM_ErrorCount
          ,le.importer_exporter_indicator_ENUM_ErrorCount
          ,le.structure_type_ENUM_ErrorCount
          ,le.type_of_establishment_ENUM_ErrorCount
          ,le.parent_duns_number_CUSTOM_ErrorCount
          ,le.ultimate_duns_number_CUSTOM_ErrorCount
          ,le.headquarters_duns_number_CUSTOM_ErrorCount
          ,le.dias_code_CUSTOM_ErrorCount
          ,le.hierarchy_code_CUSTOM_ErrorCount
          ,le.ultimate_indicator_ENUM_ErrorCount
          ,le.hot_list_new_indicator_ENUM_ErrorCount
          ,le.hot_list_ownership_change_indicator_ENUM_ErrorCount
          ,le.hot_list_ceo_change_indicator_ENUM_ErrorCount
          ,le.hot_list_company_name_change_ind_ENUM_ErrorCount
          ,le.hot_list_address_change_indicator_ENUM_ErrorCount
          ,le.hot_list_telephone_change_indicator_ENUM_ErrorCount
          ,le.hot_list_new_change_date_ALLOW_ErrorCount,le.hot_list_new_change_date_LENGTH_ErrorCount
          ,le.hot_list_ownership_change_date_ALLOW_ErrorCount,le.hot_list_ownership_change_date_LENGTH_ErrorCount
          ,le.hot_list_ceo_change_date_ALLOW_ErrorCount,le.hot_list_ceo_change_date_LENGTH_ErrorCount
          ,le.hot_list_company_name_chg_date_ALLOW_ErrorCount,le.hot_list_company_name_chg_date_LENGTH_ErrorCount
          ,le.hot_list_address_change_date_ALLOW_ErrorCount,le.hot_list_address_change_date_LENGTH_ErrorCount
          ,le.hot_list_telephone_change_date_ALLOW_ErrorCount,le.hot_list_telephone_change_date_LENGTH_ErrorCount
          ,le.report_date_CUSTOM_ErrorCount
          ,le.delete_record_indicator_ENUM_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.duns_number_CUSTOM_ErrorCount
          ,le.business_name_LENGTH_ErrorCount
          ,le.street_ALLOW_ErrorCount
          ,le.city_ALLOW_ErrorCount
          ,le.state_ENUM_ErrorCount
          ,le.zip_code_CUSTOM_ErrorCount
          ,le.mail_address_ALLOW_ErrorCount
          ,le.mail_city_ALLOW_ErrorCount
          ,le.mail_state_ENUM_ErrorCount
          ,le.mail_zip_code_CUSTOM_ErrorCount
          ,le.telephone_number_ALLOW_ErrorCount,le.telephone_number_LENGTH_ErrorCount
          ,le.county_name_ALLOW_ErrorCount
          ,le.msa_code_ALLOW_ErrorCount,le.msa_code_LENGTH_ErrorCount
          ,le.sic1_CUSTOM_ErrorCount
          ,le.sic1a_CUSTOM_ErrorCount
          ,le.sic1b_CUSTOM_ErrorCount
          ,le.sic1c_CUSTOM_ErrorCount
          ,le.sic1d_CUSTOM_ErrorCount
          ,le.sic2_CUSTOM_ErrorCount
          ,le.sic2a_CUSTOM_ErrorCount
          ,le.sic2b_CUSTOM_ErrorCount
          ,le.sic2c_CUSTOM_ErrorCount
          ,le.sic2d_CUSTOM_ErrorCount
          ,le.sic3_CUSTOM_ErrorCount
          ,le.sic3a_CUSTOM_ErrorCount
          ,le.sic3b_CUSTOM_ErrorCount
          ,le.sic3c_CUSTOM_ErrorCount
          ,le.sic3d_CUSTOM_ErrorCount
          ,le.sic4_CUSTOM_ErrorCount
          ,le.sic4a_CUSTOM_ErrorCount
          ,le.sic4b_CUSTOM_ErrorCount
          ,le.sic4c_CUSTOM_ErrorCount
          ,le.sic4d_CUSTOM_ErrorCount
          ,le.sic5_CUSTOM_ErrorCount
          ,le.sic5a_CUSTOM_ErrorCount
          ,le.sic5b_CUSTOM_ErrorCount
          ,le.sic5c_CUSTOM_ErrorCount
          ,le.sic5d_CUSTOM_ErrorCount
          ,le.sic6_CUSTOM_ErrorCount
          ,le.sic6a_CUSTOM_ErrorCount
          ,le.sic6b_CUSTOM_ErrorCount
          ,le.sic6c_CUSTOM_ErrorCount
          ,le.sic6d_CUSTOM_ErrorCount
          ,le.industry_group_ENUM_ErrorCount
          ,le.year_started_ALLOW_ErrorCount,le.year_started_LENGTH_ErrorCount
          ,le.date_of_incorporation_ALLOW_ErrorCount
          ,le.state_of_incorporation_abbr_ENUM_ErrorCount
          ,le.annual_sales_code_ENUM_ErrorCount
          ,le.employees_here_code_ENUM_ErrorCount
          ,le.annual_sales_revision_date_CUSTOM_ErrorCount
          ,le.square_footage_ALLOW_ErrorCount
          ,le.sals_territory_ENUM_ErrorCount
          ,le.owns_rents_ENUM_ErrorCount
          ,le.number_of_accounts_CUSTOM_ErrorCount
          ,le.small_business_indicator_ENUM_ErrorCount
          ,le.minority_owned_ENUM_ErrorCount
          ,le.cottage_indicator_ENUM_ErrorCount
          ,le.foreign_owned_ENUM_ErrorCount
          ,le.manufacturing_here_indicator_ENUM_ErrorCount
          ,le.public_indicator_ENUM_ErrorCount
          ,le.importer_exporter_indicator_ENUM_ErrorCount
          ,le.structure_type_ENUM_ErrorCount
          ,le.type_of_establishment_ENUM_ErrorCount
          ,le.parent_duns_number_CUSTOM_ErrorCount
          ,le.ultimate_duns_number_CUSTOM_ErrorCount
          ,le.headquarters_duns_number_CUSTOM_ErrorCount
          ,le.dias_code_CUSTOM_ErrorCount
          ,le.hierarchy_code_CUSTOM_ErrorCount
          ,le.ultimate_indicator_ENUM_ErrorCount
          ,le.hot_list_new_indicator_ENUM_ErrorCount
          ,le.hot_list_ownership_change_indicator_ENUM_ErrorCount
          ,le.hot_list_ceo_change_indicator_ENUM_ErrorCount
          ,le.hot_list_company_name_change_ind_ENUM_ErrorCount
          ,le.hot_list_address_change_indicator_ENUM_ErrorCount
          ,le.hot_list_telephone_change_indicator_ENUM_ErrorCount
          ,le.hot_list_new_change_date_ALLOW_ErrorCount,le.hot_list_new_change_date_LENGTH_ErrorCount
          ,le.hot_list_ownership_change_date_ALLOW_ErrorCount,le.hot_list_ownership_change_date_LENGTH_ErrorCount
          ,le.hot_list_ceo_change_date_ALLOW_ErrorCount,le.hot_list_ceo_change_date_LENGTH_ErrorCount
          ,le.hot_list_company_name_chg_date_ALLOW_ErrorCount,le.hot_list_company_name_chg_date_LENGTH_ErrorCount
          ,le.hot_list_address_change_date_ALLOW_ErrorCount,le.hot_list_address_change_date_LENGTH_ErrorCount
          ,le.hot_list_telephone_change_date_ALLOW_ErrorCount,le.hot_list_telephone_change_date_LENGTH_ErrorCount
          ,le.report_date_CUSTOM_ErrorCount
          ,le.delete_record_indicator_ENUM_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,92,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT34.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT34.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    RETURN IF(examples>0,j,SummaryInfo);
  END;
END;
END;
