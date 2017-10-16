IMPORT ut,SALT34;
EXPORT Raw_hygiene(dataset(Raw_layout_DNB_DMI) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT34.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_duns_number_pcnt := AVE(GROUP,IF(h.duns_number = (TYPEOF(h.duns_number))'',0,100));
    maxlength_duns_number := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.duns_number)));
    avelength_duns_number := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.duns_number)),h.duns_number<>(typeof(h.duns_number))'');
    populated_business_name_pcnt := AVE(GROUP,IF(h.business_name = (TYPEOF(h.business_name))'',0,100));
    maxlength_business_name := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.business_name)));
    avelength_business_name := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.business_name)),h.business_name<>(typeof(h.business_name))'');
    populated_street_pcnt := AVE(GROUP,IF(h.street = (TYPEOF(h.street))'',0,100));
    maxlength_street := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.street)));
    avelength_street := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.street)),h.street<>(typeof(h.street))'');
    populated_city_pcnt := AVE(GROUP,IF(h.city = (TYPEOF(h.city))'',0,100));
    maxlength_city := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.city)));
    avelength_city := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.city)),h.city<>(typeof(h.city))'');
    populated_state_pcnt := AVE(GROUP,IF(h.state = (TYPEOF(h.state))'',0,100));
    maxlength_state := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.state)));
    avelength_state := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.state)),h.state<>(typeof(h.state))'');
    populated_zip_code_pcnt := AVE(GROUP,IF(h.zip_code = (TYPEOF(h.zip_code))'',0,100));
    maxlength_zip_code := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.zip_code)));
    avelength_zip_code := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.zip_code)),h.zip_code<>(typeof(h.zip_code))'');
    populated_mail_address_pcnt := AVE(GROUP,IF(h.mail_address = (TYPEOF(h.mail_address))'',0,100));
    maxlength_mail_address := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.mail_address)));
    avelength_mail_address := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.mail_address)),h.mail_address<>(typeof(h.mail_address))'');
    populated_mail_city_pcnt := AVE(GROUP,IF(h.mail_city = (TYPEOF(h.mail_city))'',0,100));
    maxlength_mail_city := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.mail_city)));
    avelength_mail_city := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.mail_city)),h.mail_city<>(typeof(h.mail_city))'');
    populated_mail_state_pcnt := AVE(GROUP,IF(h.mail_state = (TYPEOF(h.mail_state))'',0,100));
    maxlength_mail_state := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.mail_state)));
    avelength_mail_state := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.mail_state)),h.mail_state<>(typeof(h.mail_state))'');
    populated_mail_zip_code_pcnt := AVE(GROUP,IF(h.mail_zip_code = (TYPEOF(h.mail_zip_code))'',0,100));
    maxlength_mail_zip_code := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.mail_zip_code)));
    avelength_mail_zip_code := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.mail_zip_code)),h.mail_zip_code<>(typeof(h.mail_zip_code))'');
    populated_telephone_number_pcnt := AVE(GROUP,IF(h.telephone_number = (TYPEOF(h.telephone_number))'',0,100));
    maxlength_telephone_number := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.telephone_number)));
    avelength_telephone_number := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.telephone_number)),h.telephone_number<>(typeof(h.telephone_number))'');
    populated_county_name_pcnt := AVE(GROUP,IF(h.county_name = (TYPEOF(h.county_name))'',0,100));
    maxlength_county_name := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.county_name)));
    avelength_county_name := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.county_name)),h.county_name<>(typeof(h.county_name))'');
    populated_msa_code_pcnt := AVE(GROUP,IF(h.msa_code = (TYPEOF(h.msa_code))'',0,100));
    maxlength_msa_code := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.msa_code)));
    avelength_msa_code := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.msa_code)),h.msa_code<>(typeof(h.msa_code))'');
    populated_sic1_pcnt := AVE(GROUP,IF(h.sic1 = (TYPEOF(h.sic1))'',0,100));
    maxlength_sic1 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.sic1)));
    avelength_sic1 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.sic1)),h.sic1<>(typeof(h.sic1))'');
    populated_sic1a_pcnt := AVE(GROUP,IF(h.sic1a = (TYPEOF(h.sic1a))'',0,100));
    maxlength_sic1a := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.sic1a)));
    avelength_sic1a := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.sic1a)),h.sic1a<>(typeof(h.sic1a))'');
    populated_sic1b_pcnt := AVE(GROUP,IF(h.sic1b = (TYPEOF(h.sic1b))'',0,100));
    maxlength_sic1b := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.sic1b)));
    avelength_sic1b := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.sic1b)),h.sic1b<>(typeof(h.sic1b))'');
    populated_sic1c_pcnt := AVE(GROUP,IF(h.sic1c = (TYPEOF(h.sic1c))'',0,100));
    maxlength_sic1c := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.sic1c)));
    avelength_sic1c := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.sic1c)),h.sic1c<>(typeof(h.sic1c))'');
    populated_sic1d_pcnt := AVE(GROUP,IF(h.sic1d = (TYPEOF(h.sic1d))'',0,100));
    maxlength_sic1d := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.sic1d)));
    avelength_sic1d := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.sic1d)),h.sic1d<>(typeof(h.sic1d))'');
    populated_sic2_pcnt := AVE(GROUP,IF(h.sic2 = (TYPEOF(h.sic2))'',0,100));
    maxlength_sic2 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.sic2)));
    avelength_sic2 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.sic2)),h.sic2<>(typeof(h.sic2))'');
    populated_sic2a_pcnt := AVE(GROUP,IF(h.sic2a = (TYPEOF(h.sic2a))'',0,100));
    maxlength_sic2a := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.sic2a)));
    avelength_sic2a := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.sic2a)),h.sic2a<>(typeof(h.sic2a))'');
    populated_sic2b_pcnt := AVE(GROUP,IF(h.sic2b = (TYPEOF(h.sic2b))'',0,100));
    maxlength_sic2b := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.sic2b)));
    avelength_sic2b := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.sic2b)),h.sic2b<>(typeof(h.sic2b))'');
    populated_sic2c_pcnt := AVE(GROUP,IF(h.sic2c = (TYPEOF(h.sic2c))'',0,100));
    maxlength_sic2c := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.sic2c)));
    avelength_sic2c := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.sic2c)),h.sic2c<>(typeof(h.sic2c))'');
    populated_sic2d_pcnt := AVE(GROUP,IF(h.sic2d = (TYPEOF(h.sic2d))'',0,100));
    maxlength_sic2d := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.sic2d)));
    avelength_sic2d := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.sic2d)),h.sic2d<>(typeof(h.sic2d))'');
    populated_sic3_pcnt := AVE(GROUP,IF(h.sic3 = (TYPEOF(h.sic3))'',0,100));
    maxlength_sic3 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.sic3)));
    avelength_sic3 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.sic3)),h.sic3<>(typeof(h.sic3))'');
    populated_sic3a_pcnt := AVE(GROUP,IF(h.sic3a = (TYPEOF(h.sic3a))'',0,100));
    maxlength_sic3a := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.sic3a)));
    avelength_sic3a := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.sic3a)),h.sic3a<>(typeof(h.sic3a))'');
    populated_sic3b_pcnt := AVE(GROUP,IF(h.sic3b = (TYPEOF(h.sic3b))'',0,100));
    maxlength_sic3b := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.sic3b)));
    avelength_sic3b := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.sic3b)),h.sic3b<>(typeof(h.sic3b))'');
    populated_sic3c_pcnt := AVE(GROUP,IF(h.sic3c = (TYPEOF(h.sic3c))'',0,100));
    maxlength_sic3c := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.sic3c)));
    avelength_sic3c := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.sic3c)),h.sic3c<>(typeof(h.sic3c))'');
    populated_sic3d_pcnt := AVE(GROUP,IF(h.sic3d = (TYPEOF(h.sic3d))'',0,100));
    maxlength_sic3d := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.sic3d)));
    avelength_sic3d := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.sic3d)),h.sic3d<>(typeof(h.sic3d))'');
    populated_sic4_pcnt := AVE(GROUP,IF(h.sic4 = (TYPEOF(h.sic4))'',0,100));
    maxlength_sic4 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.sic4)));
    avelength_sic4 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.sic4)),h.sic4<>(typeof(h.sic4))'');
    populated_sic4a_pcnt := AVE(GROUP,IF(h.sic4a = (TYPEOF(h.sic4a))'',0,100));
    maxlength_sic4a := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.sic4a)));
    avelength_sic4a := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.sic4a)),h.sic4a<>(typeof(h.sic4a))'');
    populated_sic4b_pcnt := AVE(GROUP,IF(h.sic4b = (TYPEOF(h.sic4b))'',0,100));
    maxlength_sic4b := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.sic4b)));
    avelength_sic4b := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.sic4b)),h.sic4b<>(typeof(h.sic4b))'');
    populated_sic4c_pcnt := AVE(GROUP,IF(h.sic4c = (TYPEOF(h.sic4c))'',0,100));
    maxlength_sic4c := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.sic4c)));
    avelength_sic4c := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.sic4c)),h.sic4c<>(typeof(h.sic4c))'');
    populated_sic4d_pcnt := AVE(GROUP,IF(h.sic4d = (TYPEOF(h.sic4d))'',0,100));
    maxlength_sic4d := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.sic4d)));
    avelength_sic4d := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.sic4d)),h.sic4d<>(typeof(h.sic4d))'');
    populated_sic5_pcnt := AVE(GROUP,IF(h.sic5 = (TYPEOF(h.sic5))'',0,100));
    maxlength_sic5 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.sic5)));
    avelength_sic5 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.sic5)),h.sic5<>(typeof(h.sic5))'');
    populated_sic5a_pcnt := AVE(GROUP,IF(h.sic5a = (TYPEOF(h.sic5a))'',0,100));
    maxlength_sic5a := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.sic5a)));
    avelength_sic5a := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.sic5a)),h.sic5a<>(typeof(h.sic5a))'');
    populated_sic5b_pcnt := AVE(GROUP,IF(h.sic5b = (TYPEOF(h.sic5b))'',0,100));
    maxlength_sic5b := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.sic5b)));
    avelength_sic5b := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.sic5b)),h.sic5b<>(typeof(h.sic5b))'');
    populated_sic5c_pcnt := AVE(GROUP,IF(h.sic5c = (TYPEOF(h.sic5c))'',0,100));
    maxlength_sic5c := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.sic5c)));
    avelength_sic5c := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.sic5c)),h.sic5c<>(typeof(h.sic5c))'');
    populated_sic5d_pcnt := AVE(GROUP,IF(h.sic5d = (TYPEOF(h.sic5d))'',0,100));
    maxlength_sic5d := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.sic5d)));
    avelength_sic5d := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.sic5d)),h.sic5d<>(typeof(h.sic5d))'');
    populated_sic6_pcnt := AVE(GROUP,IF(h.sic6 = (TYPEOF(h.sic6))'',0,100));
    maxlength_sic6 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.sic6)));
    avelength_sic6 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.sic6)),h.sic6<>(typeof(h.sic6))'');
    populated_sic6a_pcnt := AVE(GROUP,IF(h.sic6a = (TYPEOF(h.sic6a))'',0,100));
    maxlength_sic6a := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.sic6a)));
    avelength_sic6a := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.sic6a)),h.sic6a<>(typeof(h.sic6a))'');
    populated_sic6b_pcnt := AVE(GROUP,IF(h.sic6b = (TYPEOF(h.sic6b))'',0,100));
    maxlength_sic6b := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.sic6b)));
    avelength_sic6b := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.sic6b)),h.sic6b<>(typeof(h.sic6b))'');
    populated_sic6c_pcnt := AVE(GROUP,IF(h.sic6c = (TYPEOF(h.sic6c))'',0,100));
    maxlength_sic6c := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.sic6c)));
    avelength_sic6c := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.sic6c)),h.sic6c<>(typeof(h.sic6c))'');
    populated_sic6d_pcnt := AVE(GROUP,IF(h.sic6d = (TYPEOF(h.sic6d))'',0,100));
    maxlength_sic6d := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.sic6d)));
    avelength_sic6d := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.sic6d)),h.sic6d<>(typeof(h.sic6d))'');
    populated_industry_group_pcnt := AVE(GROUP,IF(h.industry_group = (TYPEOF(h.industry_group))'',0,100));
    maxlength_industry_group := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.industry_group)));
    avelength_industry_group := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.industry_group)),h.industry_group<>(typeof(h.industry_group))'');
    populated_year_started_pcnt := AVE(GROUP,IF(h.year_started = (TYPEOF(h.year_started))'',0,100));
    maxlength_year_started := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.year_started)));
    avelength_year_started := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.year_started)),h.year_started<>(typeof(h.year_started))'');
    populated_date_of_incorporation_pcnt := AVE(GROUP,IF(h.date_of_incorporation = (TYPEOF(h.date_of_incorporation))'',0,100));
    maxlength_date_of_incorporation := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.date_of_incorporation)));
    avelength_date_of_incorporation := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.date_of_incorporation)),h.date_of_incorporation<>(typeof(h.date_of_incorporation))'');
    populated_state_of_incorporation_abbr_pcnt := AVE(GROUP,IF(h.state_of_incorporation_abbr = (TYPEOF(h.state_of_incorporation_abbr))'',0,100));
    maxlength_state_of_incorporation_abbr := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.state_of_incorporation_abbr)));
    avelength_state_of_incorporation_abbr := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.state_of_incorporation_abbr)),h.state_of_incorporation_abbr<>(typeof(h.state_of_incorporation_abbr))'');
    populated_annual_sales_code_pcnt := AVE(GROUP,IF(h.annual_sales_code = (TYPEOF(h.annual_sales_code))'',0,100));
    maxlength_annual_sales_code := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.annual_sales_code)));
    avelength_annual_sales_code := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.annual_sales_code)),h.annual_sales_code<>(typeof(h.annual_sales_code))'');
    populated_employees_here_code_pcnt := AVE(GROUP,IF(h.employees_here_code = (TYPEOF(h.employees_here_code))'',0,100));
    maxlength_employees_here_code := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.employees_here_code)));
    avelength_employees_here_code := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.employees_here_code)),h.employees_here_code<>(typeof(h.employees_here_code))'');
    populated_annual_sales_revision_date_pcnt := AVE(GROUP,IF(h.annual_sales_revision_date = (TYPEOF(h.annual_sales_revision_date))'',0,100));
    maxlength_annual_sales_revision_date := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.annual_sales_revision_date)));
    avelength_annual_sales_revision_date := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.annual_sales_revision_date)),h.annual_sales_revision_date<>(typeof(h.annual_sales_revision_date))'');
    populated_square_footage_pcnt := AVE(GROUP,IF(h.square_footage = (TYPEOF(h.square_footage))'',0,100));
    maxlength_square_footage := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.square_footage)));
    avelength_square_footage := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.square_footage)),h.square_footage<>(typeof(h.square_footage))'');
    populated_sals_territory_pcnt := AVE(GROUP,IF(h.sals_territory = (TYPEOF(h.sals_territory))'',0,100));
    maxlength_sals_territory := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.sals_territory)));
    avelength_sals_territory := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.sals_territory)),h.sals_territory<>(typeof(h.sals_territory))'');
    populated_owns_rents_pcnt := AVE(GROUP,IF(h.owns_rents = (TYPEOF(h.owns_rents))'',0,100));
    maxlength_owns_rents := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.owns_rents)));
    avelength_owns_rents := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.owns_rents)),h.owns_rents<>(typeof(h.owns_rents))'');
    populated_number_of_accounts_pcnt := AVE(GROUP,IF(h.number_of_accounts = (TYPEOF(h.number_of_accounts))'',0,100));
    maxlength_number_of_accounts := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.number_of_accounts)));
    avelength_number_of_accounts := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.number_of_accounts)),h.number_of_accounts<>(typeof(h.number_of_accounts))'');
    populated_small_business_indicator_pcnt := AVE(GROUP,IF(h.small_business_indicator = (TYPEOF(h.small_business_indicator))'',0,100));
    maxlength_small_business_indicator := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.small_business_indicator)));
    avelength_small_business_indicator := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.small_business_indicator)),h.small_business_indicator<>(typeof(h.small_business_indicator))'');
    populated_minority_owned_pcnt := AVE(GROUP,IF(h.minority_owned = (TYPEOF(h.minority_owned))'',0,100));
    maxlength_minority_owned := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.minority_owned)));
    avelength_minority_owned := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.minority_owned)),h.minority_owned<>(typeof(h.minority_owned))'');
    populated_cottage_indicator_pcnt := AVE(GROUP,IF(h.cottage_indicator = (TYPEOF(h.cottage_indicator))'',0,100));
    maxlength_cottage_indicator := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.cottage_indicator)));
    avelength_cottage_indicator := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.cottage_indicator)),h.cottage_indicator<>(typeof(h.cottage_indicator))'');
    populated_foreign_owned_pcnt := AVE(GROUP,IF(h.foreign_owned = (TYPEOF(h.foreign_owned))'',0,100));
    maxlength_foreign_owned := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.foreign_owned)));
    avelength_foreign_owned := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.foreign_owned)),h.foreign_owned<>(typeof(h.foreign_owned))'');
    populated_manufacturing_here_indicator_pcnt := AVE(GROUP,IF(h.manufacturing_here_indicator = (TYPEOF(h.manufacturing_here_indicator))'',0,100));
    maxlength_manufacturing_here_indicator := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.manufacturing_here_indicator)));
    avelength_manufacturing_here_indicator := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.manufacturing_here_indicator)),h.manufacturing_here_indicator<>(typeof(h.manufacturing_here_indicator))'');
    populated_public_indicator_pcnt := AVE(GROUP,IF(h.public_indicator = (TYPEOF(h.public_indicator))'',0,100));
    maxlength_public_indicator := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.public_indicator)));
    avelength_public_indicator := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.public_indicator)),h.public_indicator<>(typeof(h.public_indicator))'');
    populated_importer_exporter_indicator_pcnt := AVE(GROUP,IF(h.importer_exporter_indicator = (TYPEOF(h.importer_exporter_indicator))'',0,100));
    maxlength_importer_exporter_indicator := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.importer_exporter_indicator)));
    avelength_importer_exporter_indicator := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.importer_exporter_indicator)),h.importer_exporter_indicator<>(typeof(h.importer_exporter_indicator))'');
    populated_structure_type_pcnt := AVE(GROUP,IF(h.structure_type = (TYPEOF(h.structure_type))'',0,100));
    maxlength_structure_type := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.structure_type)));
    avelength_structure_type := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.structure_type)),h.structure_type<>(typeof(h.structure_type))'');
    populated_type_of_establishment_pcnt := AVE(GROUP,IF(h.type_of_establishment = (TYPEOF(h.type_of_establishment))'',0,100));
    maxlength_type_of_establishment := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.type_of_establishment)));
    avelength_type_of_establishment := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.type_of_establishment)),h.type_of_establishment<>(typeof(h.type_of_establishment))'');
    populated_parent_duns_number_pcnt := AVE(GROUP,IF(h.parent_duns_number = (TYPEOF(h.parent_duns_number))'',0,100));
    maxlength_parent_duns_number := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.parent_duns_number)));
    avelength_parent_duns_number := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.parent_duns_number)),h.parent_duns_number<>(typeof(h.parent_duns_number))'');
    populated_ultimate_duns_number_pcnt := AVE(GROUP,IF(h.ultimate_duns_number = (TYPEOF(h.ultimate_duns_number))'',0,100));
    maxlength_ultimate_duns_number := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.ultimate_duns_number)));
    avelength_ultimate_duns_number := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.ultimate_duns_number)),h.ultimate_duns_number<>(typeof(h.ultimate_duns_number))'');
    populated_headquarters_duns_number_pcnt := AVE(GROUP,IF(h.headquarters_duns_number = (TYPEOF(h.headquarters_duns_number))'',0,100));
    maxlength_headquarters_duns_number := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.headquarters_duns_number)));
    avelength_headquarters_duns_number := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.headquarters_duns_number)),h.headquarters_duns_number<>(typeof(h.headquarters_duns_number))'');
    populated_dias_code_pcnt := AVE(GROUP,IF(h.dias_code = (TYPEOF(h.dias_code))'',0,100));
    maxlength_dias_code := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.dias_code)));
    avelength_dias_code := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.dias_code)),h.dias_code<>(typeof(h.dias_code))'');
    populated_hierarchy_code_pcnt := AVE(GROUP,IF(h.hierarchy_code = (TYPEOF(h.hierarchy_code))'',0,100));
    maxlength_hierarchy_code := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.hierarchy_code)));
    avelength_hierarchy_code := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.hierarchy_code)),h.hierarchy_code<>(typeof(h.hierarchy_code))'');
    populated_ultimate_indicator_pcnt := AVE(GROUP,IF(h.ultimate_indicator = (TYPEOF(h.ultimate_indicator))'',0,100));
    maxlength_ultimate_indicator := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.ultimate_indicator)));
    avelength_ultimate_indicator := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.ultimate_indicator)),h.ultimate_indicator<>(typeof(h.ultimate_indicator))'');
    populated_hot_list_new_indicator_pcnt := AVE(GROUP,IF(h.hot_list_new_indicator = (TYPEOF(h.hot_list_new_indicator))'',0,100));
    maxlength_hot_list_new_indicator := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.hot_list_new_indicator)));
    avelength_hot_list_new_indicator := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.hot_list_new_indicator)),h.hot_list_new_indicator<>(typeof(h.hot_list_new_indicator))'');
    populated_hot_list_ownership_change_indicator_pcnt := AVE(GROUP,IF(h.hot_list_ownership_change_indicator = (TYPEOF(h.hot_list_ownership_change_indicator))'',0,100));
    maxlength_hot_list_ownership_change_indicator := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.hot_list_ownership_change_indicator)));
    avelength_hot_list_ownership_change_indicator := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.hot_list_ownership_change_indicator)),h.hot_list_ownership_change_indicator<>(typeof(h.hot_list_ownership_change_indicator))'');
    populated_hot_list_ceo_change_indicator_pcnt := AVE(GROUP,IF(h.hot_list_ceo_change_indicator = (TYPEOF(h.hot_list_ceo_change_indicator))'',0,100));
    maxlength_hot_list_ceo_change_indicator := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.hot_list_ceo_change_indicator)));
    avelength_hot_list_ceo_change_indicator := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.hot_list_ceo_change_indicator)),h.hot_list_ceo_change_indicator<>(typeof(h.hot_list_ceo_change_indicator))'');
    populated_hot_list_company_name_change_ind_pcnt := AVE(GROUP,IF(h.hot_list_company_name_change_ind = (TYPEOF(h.hot_list_company_name_change_ind))'',0,100));
    maxlength_hot_list_company_name_change_ind := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.hot_list_company_name_change_ind)));
    avelength_hot_list_company_name_change_ind := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.hot_list_company_name_change_ind)),h.hot_list_company_name_change_ind<>(typeof(h.hot_list_company_name_change_ind))'');
    populated_hot_list_address_change_indicator_pcnt := AVE(GROUP,IF(h.hot_list_address_change_indicator = (TYPEOF(h.hot_list_address_change_indicator))'',0,100));
    maxlength_hot_list_address_change_indicator := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.hot_list_address_change_indicator)));
    avelength_hot_list_address_change_indicator := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.hot_list_address_change_indicator)),h.hot_list_address_change_indicator<>(typeof(h.hot_list_address_change_indicator))'');
    populated_hot_list_telephone_change_indicator_pcnt := AVE(GROUP,IF(h.hot_list_telephone_change_indicator = (TYPEOF(h.hot_list_telephone_change_indicator))'',0,100));
    maxlength_hot_list_telephone_change_indicator := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.hot_list_telephone_change_indicator)));
    avelength_hot_list_telephone_change_indicator := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.hot_list_telephone_change_indicator)),h.hot_list_telephone_change_indicator<>(typeof(h.hot_list_telephone_change_indicator))'');
    populated_hot_list_new_change_date_pcnt := AVE(GROUP,IF(h.hot_list_new_change_date = (TYPEOF(h.hot_list_new_change_date))'',0,100));
    maxlength_hot_list_new_change_date := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.hot_list_new_change_date)));
    avelength_hot_list_new_change_date := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.hot_list_new_change_date)),h.hot_list_new_change_date<>(typeof(h.hot_list_new_change_date))'');
    populated_hot_list_ownership_change_date_pcnt := AVE(GROUP,IF(h.hot_list_ownership_change_date = (TYPEOF(h.hot_list_ownership_change_date))'',0,100));
    maxlength_hot_list_ownership_change_date := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.hot_list_ownership_change_date)));
    avelength_hot_list_ownership_change_date := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.hot_list_ownership_change_date)),h.hot_list_ownership_change_date<>(typeof(h.hot_list_ownership_change_date))'');
    populated_hot_list_ceo_change_date_pcnt := AVE(GROUP,IF(h.hot_list_ceo_change_date = (TYPEOF(h.hot_list_ceo_change_date))'',0,100));
    maxlength_hot_list_ceo_change_date := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.hot_list_ceo_change_date)));
    avelength_hot_list_ceo_change_date := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.hot_list_ceo_change_date)),h.hot_list_ceo_change_date<>(typeof(h.hot_list_ceo_change_date))'');
    populated_hot_list_company_name_chg_date_pcnt := AVE(GROUP,IF(h.hot_list_company_name_chg_date = (TYPEOF(h.hot_list_company_name_chg_date))'',0,100));
    maxlength_hot_list_company_name_chg_date := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.hot_list_company_name_chg_date)));
    avelength_hot_list_company_name_chg_date := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.hot_list_company_name_chg_date)),h.hot_list_company_name_chg_date<>(typeof(h.hot_list_company_name_chg_date))'');
    populated_hot_list_address_change_date_pcnt := AVE(GROUP,IF(h.hot_list_address_change_date = (TYPEOF(h.hot_list_address_change_date))'',0,100));
    maxlength_hot_list_address_change_date := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.hot_list_address_change_date)));
    avelength_hot_list_address_change_date := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.hot_list_address_change_date)),h.hot_list_address_change_date<>(typeof(h.hot_list_address_change_date))'');
    populated_hot_list_telephone_change_date_pcnt := AVE(GROUP,IF(h.hot_list_telephone_change_date = (TYPEOF(h.hot_list_telephone_change_date))'',0,100));
    maxlength_hot_list_telephone_change_date := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.hot_list_telephone_change_date)));
    avelength_hot_list_telephone_change_date := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.hot_list_telephone_change_date)),h.hot_list_telephone_change_date<>(typeof(h.hot_list_telephone_change_date))'');
    populated_report_date_pcnt := AVE(GROUP,IF(h.report_date = (TYPEOF(h.report_date))'',0,100));
    maxlength_report_date := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.report_date)));
    avelength_report_date := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.report_date)),h.report_date<>(typeof(h.report_date))'');
    populated_delete_record_indicator_pcnt := AVE(GROUP,IF(h.delete_record_indicator = (TYPEOF(h.delete_record_indicator))'',0,100));
    maxlength_delete_record_indicator := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.delete_record_indicator)));
    avelength_delete_record_indicator := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.delete_record_indicator)),h.delete_record_indicator<>(typeof(h.delete_record_indicator))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_duns_number_pcnt *   0.00 / 100 + T.Populated_business_name_pcnt *   0.00 / 100 + T.Populated_street_pcnt *   0.00 / 100 + T.Populated_city_pcnt *   0.00 / 100 + T.Populated_state_pcnt *   0.00 / 100 + T.Populated_zip_code_pcnt *   0.00 / 100 + T.Populated_mail_address_pcnt *   0.00 / 100 + T.Populated_mail_city_pcnt *   0.00 / 100 + T.Populated_mail_state_pcnt *   0.00 / 100 + T.Populated_mail_zip_code_pcnt *   0.00 / 100 + T.Populated_telephone_number_pcnt *   0.00 / 100 + T.Populated_county_name_pcnt *   0.00 / 100 + T.Populated_msa_code_pcnt *   0.00 / 100 + T.Populated_sic1_pcnt *   0.00 / 100 + T.Populated_sic1a_pcnt *   0.00 / 100 + T.Populated_sic1b_pcnt *   0.00 / 100 + T.Populated_sic1c_pcnt *   0.00 / 100 + T.Populated_sic1d_pcnt *   0.00 / 100 + T.Populated_sic2_pcnt *   0.00 / 100 + T.Populated_sic2a_pcnt *   0.00 / 100 + T.Populated_sic2b_pcnt *   0.00 / 100 + T.Populated_sic2c_pcnt *   0.00 / 100 + T.Populated_sic2d_pcnt *   0.00 / 100 + T.Populated_sic3_pcnt *   0.00 / 100 + T.Populated_sic3a_pcnt *   0.00 / 100 + T.Populated_sic3b_pcnt *   0.00 / 100 + T.Populated_sic3c_pcnt *   0.00 / 100 + T.Populated_sic3d_pcnt *   0.00 / 100 + T.Populated_sic4_pcnt *   0.00 / 100 + T.Populated_sic4a_pcnt *   0.00 / 100 + T.Populated_sic4b_pcnt *   0.00 / 100 + T.Populated_sic4c_pcnt *   0.00 / 100 + T.Populated_sic4d_pcnt *   0.00 / 100 + T.Populated_sic5_pcnt *   0.00 / 100 + T.Populated_sic5a_pcnt *   0.00 / 100 + T.Populated_sic5b_pcnt *   0.00 / 100 + T.Populated_sic5c_pcnt *   0.00 / 100 + T.Populated_sic5d_pcnt *   0.00 / 100 + T.Populated_sic6_pcnt *   0.00 / 100 + T.Populated_sic6a_pcnt *   0.00 / 100 + T.Populated_sic6b_pcnt *   0.00 / 100 + T.Populated_sic6c_pcnt *   0.00 / 100 + T.Populated_sic6d_pcnt *   0.00 / 100 + T.Populated_industry_group_pcnt *   0.00 / 100 + T.Populated_year_started_pcnt *   0.00 / 100 + T.Populated_date_of_incorporation_pcnt *   0.00 / 100 + T.Populated_state_of_incorporation_abbr_pcnt *   0.00 / 100 + T.Populated_annual_sales_code_pcnt *   0.00 / 100 + T.Populated_employees_here_code_pcnt *   0.00 / 100 + T.Populated_annual_sales_revision_date_pcnt *   0.00 / 100 + T.Populated_square_footage_pcnt *   0.00 / 100 + T.Populated_sals_territory_pcnt *   0.00 / 100 + T.Populated_owns_rents_pcnt *   0.00 / 100 + T.Populated_number_of_accounts_pcnt *   0.00 / 100 + T.Populated_small_business_indicator_pcnt *   0.00 / 100 + T.Populated_minority_owned_pcnt *   0.00 / 100 + T.Populated_cottage_indicator_pcnt *   0.00 / 100 + T.Populated_foreign_owned_pcnt *   0.00 / 100 + T.Populated_manufacturing_here_indicator_pcnt *   0.00 / 100 + T.Populated_public_indicator_pcnt *   0.00 / 100 + T.Populated_importer_exporter_indicator_pcnt *   0.00 / 100 + T.Populated_structure_type_pcnt *   0.00 / 100 + T.Populated_type_of_establishment_pcnt *   0.00 / 100 + T.Populated_parent_duns_number_pcnt *   0.00 / 100 + T.Populated_ultimate_duns_number_pcnt *   0.00 / 100 + T.Populated_headquarters_duns_number_pcnt *   0.00 / 100 + T.Populated_dias_code_pcnt *   0.00 / 100 + T.Populated_hierarchy_code_pcnt *   0.00 / 100 + T.Populated_ultimate_indicator_pcnt *   0.00 / 100 + T.Populated_hot_list_new_indicator_pcnt *   0.00 / 100 + T.Populated_hot_list_ownership_change_indicator_pcnt *   0.00 / 100 + T.Populated_hot_list_ceo_change_indicator_pcnt *   0.00 / 100 + T.Populated_hot_list_company_name_change_ind_pcnt *   0.00 / 100 + T.Populated_hot_list_address_change_indicator_pcnt *   0.00 / 100 + T.Populated_hot_list_telephone_change_indicator_pcnt *   0.00 / 100 + T.Populated_hot_list_new_change_date_pcnt *   0.00 / 100 + T.Populated_hot_list_ownership_change_date_pcnt *   0.00 / 100 + T.Populated_hot_list_ceo_change_date_pcnt *   0.00 / 100 + T.Populated_hot_list_company_name_chg_date_pcnt *   0.00 / 100 + T.Populated_hot_list_address_change_date_pcnt *   0.00 / 100 + T.Populated_hot_list_telephone_change_date_pcnt *   0.00 / 100 + T.Populated_report_date_pcnt *   0.00 / 100 + T.Populated_delete_record_indicator_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
invRec := RECORD
  UNSIGNED  FldNo;
  SALT34.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'duns_number','business_name','street','city','state','zip_code','mail_address','mail_city','mail_state','mail_zip_code','telephone_number','county_name','msa_code','sic1','sic1a','sic1b','sic1c','sic1d','sic2','sic2a','sic2b','sic2c','sic2d','sic3','sic3a','sic3b','sic3c','sic3d','sic4','sic4a','sic4b','sic4c','sic4d','sic5','sic5a','sic5b','sic5c','sic5d','sic6','sic6a','sic6b','sic6c','sic6d','industry_group','year_started','date_of_incorporation','state_of_incorporation_abbr','annual_sales_code','employees_here_code','annual_sales_revision_date','square_footage','sals_territory','owns_rents','number_of_accounts','small_business_indicator','minority_owned','cottage_indicator','foreign_owned','manufacturing_here_indicator','public_indicator','importer_exporter_indicator','structure_type','type_of_establishment','parent_duns_number','ultimate_duns_number','headquarters_duns_number','dias_code','hierarchy_code','ultimate_indicator','hot_list_new_indicator','hot_list_ownership_change_indicator','hot_list_ceo_change_indicator','hot_list_company_name_change_ind','hot_list_address_change_indicator','hot_list_telephone_change_indicator','hot_list_new_change_date','hot_list_ownership_change_date','hot_list_ceo_change_date','hot_list_company_name_chg_date','hot_list_address_change_date','hot_list_telephone_change_date','report_date','delete_record_indicator');
  SELF.populated_pcnt := CHOOSE(C,le.populated_duns_number_pcnt,le.populated_business_name_pcnt,le.populated_street_pcnt,le.populated_city_pcnt,le.populated_state_pcnt,le.populated_zip_code_pcnt,le.populated_mail_address_pcnt,le.populated_mail_city_pcnt,le.populated_mail_state_pcnt,le.populated_mail_zip_code_pcnt,le.populated_telephone_number_pcnt,le.populated_county_name_pcnt,le.populated_msa_code_pcnt,le.populated_sic1_pcnt,le.populated_sic1a_pcnt,le.populated_sic1b_pcnt,le.populated_sic1c_pcnt,le.populated_sic1d_pcnt,le.populated_sic2_pcnt,le.populated_sic2a_pcnt,le.populated_sic2b_pcnt,le.populated_sic2c_pcnt,le.populated_sic2d_pcnt,le.populated_sic3_pcnt,le.populated_sic3a_pcnt,le.populated_sic3b_pcnt,le.populated_sic3c_pcnt,le.populated_sic3d_pcnt,le.populated_sic4_pcnt,le.populated_sic4a_pcnt,le.populated_sic4b_pcnt,le.populated_sic4c_pcnt,le.populated_sic4d_pcnt,le.populated_sic5_pcnt,le.populated_sic5a_pcnt,le.populated_sic5b_pcnt,le.populated_sic5c_pcnt,le.populated_sic5d_pcnt,le.populated_sic6_pcnt,le.populated_sic6a_pcnt,le.populated_sic6b_pcnt,le.populated_sic6c_pcnt,le.populated_sic6d_pcnt,le.populated_industry_group_pcnt,le.populated_year_started_pcnt,le.populated_date_of_incorporation_pcnt,le.populated_state_of_incorporation_abbr_pcnt,le.populated_annual_sales_code_pcnt,le.populated_employees_here_code_pcnt,le.populated_annual_sales_revision_date_pcnt,le.populated_square_footage_pcnt,le.populated_sals_territory_pcnt,le.populated_owns_rents_pcnt,le.populated_number_of_accounts_pcnt,le.populated_small_business_indicator_pcnt,le.populated_minority_owned_pcnt,le.populated_cottage_indicator_pcnt,le.populated_foreign_owned_pcnt,le.populated_manufacturing_here_indicator_pcnt,le.populated_public_indicator_pcnt,le.populated_importer_exporter_indicator_pcnt,le.populated_structure_type_pcnt,le.populated_type_of_establishment_pcnt,le.populated_parent_duns_number_pcnt,le.populated_ultimate_duns_number_pcnt,le.populated_headquarters_duns_number_pcnt,le.populated_dias_code_pcnt,le.populated_hierarchy_code_pcnt,le.populated_ultimate_indicator_pcnt,le.populated_hot_list_new_indicator_pcnt,le.populated_hot_list_ownership_change_indicator_pcnt,le.populated_hot_list_ceo_change_indicator_pcnt,le.populated_hot_list_company_name_change_ind_pcnt,le.populated_hot_list_address_change_indicator_pcnt,le.populated_hot_list_telephone_change_indicator_pcnt,le.populated_hot_list_new_change_date_pcnt,le.populated_hot_list_ownership_change_date_pcnt,le.populated_hot_list_ceo_change_date_pcnt,le.populated_hot_list_company_name_chg_date_pcnt,le.populated_hot_list_address_change_date_pcnt,le.populated_hot_list_telephone_change_date_pcnt,le.populated_report_date_pcnt,le.populated_delete_record_indicator_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_duns_number,le.maxlength_business_name,le.maxlength_street,le.maxlength_city,le.maxlength_state,le.maxlength_zip_code,le.maxlength_mail_address,le.maxlength_mail_city,le.maxlength_mail_state,le.maxlength_mail_zip_code,le.maxlength_telephone_number,le.maxlength_county_name,le.maxlength_msa_code,le.maxlength_sic1,le.maxlength_sic1a,le.maxlength_sic1b,le.maxlength_sic1c,le.maxlength_sic1d,le.maxlength_sic2,le.maxlength_sic2a,le.maxlength_sic2b,le.maxlength_sic2c,le.maxlength_sic2d,le.maxlength_sic3,le.maxlength_sic3a,le.maxlength_sic3b,le.maxlength_sic3c,le.maxlength_sic3d,le.maxlength_sic4,le.maxlength_sic4a,le.maxlength_sic4b,le.maxlength_sic4c,le.maxlength_sic4d,le.maxlength_sic5,le.maxlength_sic5a,le.maxlength_sic5b,le.maxlength_sic5c,le.maxlength_sic5d,le.maxlength_sic6,le.maxlength_sic6a,le.maxlength_sic6b,le.maxlength_sic6c,le.maxlength_sic6d,le.maxlength_industry_group,le.maxlength_year_started,le.maxlength_date_of_incorporation,le.maxlength_state_of_incorporation_abbr,le.maxlength_annual_sales_code,le.maxlength_employees_here_code,le.maxlength_annual_sales_revision_date,le.maxlength_square_footage,le.maxlength_sals_territory,le.maxlength_owns_rents,le.maxlength_number_of_accounts,le.maxlength_small_business_indicator,le.maxlength_minority_owned,le.maxlength_cottage_indicator,le.maxlength_foreign_owned,le.maxlength_manufacturing_here_indicator,le.maxlength_public_indicator,le.maxlength_importer_exporter_indicator,le.maxlength_structure_type,le.maxlength_type_of_establishment,le.maxlength_parent_duns_number,le.maxlength_ultimate_duns_number,le.maxlength_headquarters_duns_number,le.maxlength_dias_code,le.maxlength_hierarchy_code,le.maxlength_ultimate_indicator,le.maxlength_hot_list_new_indicator,le.maxlength_hot_list_ownership_change_indicator,le.maxlength_hot_list_ceo_change_indicator,le.maxlength_hot_list_company_name_change_ind,le.maxlength_hot_list_address_change_indicator,le.maxlength_hot_list_telephone_change_indicator,le.maxlength_hot_list_new_change_date,le.maxlength_hot_list_ownership_change_date,le.maxlength_hot_list_ceo_change_date,le.maxlength_hot_list_company_name_chg_date,le.maxlength_hot_list_address_change_date,le.maxlength_hot_list_telephone_change_date,le.maxlength_report_date,le.maxlength_delete_record_indicator);
  SELF.avelength := CHOOSE(C,le.avelength_duns_number,le.avelength_business_name,le.avelength_street,le.avelength_city,le.avelength_state,le.avelength_zip_code,le.avelength_mail_address,le.avelength_mail_city,le.avelength_mail_state,le.avelength_mail_zip_code,le.avelength_telephone_number,le.avelength_county_name,le.avelength_msa_code,le.avelength_sic1,le.avelength_sic1a,le.avelength_sic1b,le.avelength_sic1c,le.avelength_sic1d,le.avelength_sic2,le.avelength_sic2a,le.avelength_sic2b,le.avelength_sic2c,le.avelength_sic2d,le.avelength_sic3,le.avelength_sic3a,le.avelength_sic3b,le.avelength_sic3c,le.avelength_sic3d,le.avelength_sic4,le.avelength_sic4a,le.avelength_sic4b,le.avelength_sic4c,le.avelength_sic4d,le.avelength_sic5,le.avelength_sic5a,le.avelength_sic5b,le.avelength_sic5c,le.avelength_sic5d,le.avelength_sic6,le.avelength_sic6a,le.avelength_sic6b,le.avelength_sic6c,le.avelength_sic6d,le.avelength_industry_group,le.avelength_year_started,le.avelength_date_of_incorporation,le.avelength_state_of_incorporation_abbr,le.avelength_annual_sales_code,le.avelength_employees_here_code,le.avelength_annual_sales_revision_date,le.avelength_square_footage,le.avelength_sals_territory,le.avelength_owns_rents,le.avelength_number_of_accounts,le.avelength_small_business_indicator,le.avelength_minority_owned,le.avelength_cottage_indicator,le.avelength_foreign_owned,le.avelength_manufacturing_here_indicator,le.avelength_public_indicator,le.avelength_importer_exporter_indicator,le.avelength_structure_type,le.avelength_type_of_establishment,le.avelength_parent_duns_number,le.avelength_ultimate_duns_number,le.avelength_headquarters_duns_number,le.avelength_dias_code,le.avelength_hierarchy_code,le.avelength_ultimate_indicator,le.avelength_hot_list_new_indicator,le.avelength_hot_list_ownership_change_indicator,le.avelength_hot_list_ceo_change_indicator,le.avelength_hot_list_company_name_change_ind,le.avelength_hot_list_address_change_indicator,le.avelength_hot_list_telephone_change_indicator,le.avelength_hot_list_new_change_date,le.avelength_hot_list_ownership_change_date,le.avelength_hot_list_ceo_change_date,le.avelength_hot_list_company_name_chg_date,le.avelength_hot_list_address_change_date,le.avelength_hot_list_telephone_change_date,le.avelength_report_date,le.avelength_delete_record_indicator);
END;
EXPORT invSummary := NORMALIZE(summary0, 83, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT34.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT34.StrType)le.duns_number),TRIM((SALT34.StrType)le.business_name),TRIM((SALT34.StrType)le.street),TRIM((SALT34.StrType)le.city),TRIM((SALT34.StrType)le.state),TRIM((SALT34.StrType)le.zip_code),TRIM((SALT34.StrType)le.mail_address),TRIM((SALT34.StrType)le.mail_city),TRIM((SALT34.StrType)le.mail_state),TRIM((SALT34.StrType)le.mail_zip_code),TRIM((SALT34.StrType)le.telephone_number),TRIM((SALT34.StrType)le.county_name),TRIM((SALT34.StrType)le.msa_code),TRIM((SALT34.StrType)le.sic1),TRIM((SALT34.StrType)le.sic1a),TRIM((SALT34.StrType)le.sic1b),TRIM((SALT34.StrType)le.sic1c),TRIM((SALT34.StrType)le.sic1d),TRIM((SALT34.StrType)le.sic2),TRIM((SALT34.StrType)le.sic2a),TRIM((SALT34.StrType)le.sic2b),TRIM((SALT34.StrType)le.sic2c),TRIM((SALT34.StrType)le.sic2d),TRIM((SALT34.StrType)le.sic3),TRIM((SALT34.StrType)le.sic3a),TRIM((SALT34.StrType)le.sic3b),TRIM((SALT34.StrType)le.sic3c),TRIM((SALT34.StrType)le.sic3d),TRIM((SALT34.StrType)le.sic4),TRIM((SALT34.StrType)le.sic4a),TRIM((SALT34.StrType)le.sic4b),TRIM((SALT34.StrType)le.sic4c),TRIM((SALT34.StrType)le.sic4d),TRIM((SALT34.StrType)le.sic5),TRIM((SALT34.StrType)le.sic5a),TRIM((SALT34.StrType)le.sic5b),TRIM((SALT34.StrType)le.sic5c),TRIM((SALT34.StrType)le.sic5d),TRIM((SALT34.StrType)le.sic6),TRIM((SALT34.StrType)le.sic6a),TRIM((SALT34.StrType)le.sic6b),TRIM((SALT34.StrType)le.sic6c),TRIM((SALT34.StrType)le.sic6d),TRIM((SALT34.StrType)le.industry_group),TRIM((SALT34.StrType)le.year_started),TRIM((SALT34.StrType)le.date_of_incorporation),TRIM((SALT34.StrType)le.state_of_incorporation_abbr),TRIM((SALT34.StrType)le.annual_sales_code),TRIM((SALT34.StrType)le.employees_here_code),TRIM((SALT34.StrType)le.annual_sales_revision_date),TRIM((SALT34.StrType)le.square_footage),TRIM((SALT34.StrType)le.sals_territory),TRIM((SALT34.StrType)le.owns_rents),TRIM((SALT34.StrType)le.number_of_accounts),TRIM((SALT34.StrType)le.small_business_indicator),TRIM((SALT34.StrType)le.minority_owned),TRIM((SALT34.StrType)le.cottage_indicator),TRIM((SALT34.StrType)le.foreign_owned),TRIM((SALT34.StrType)le.manufacturing_here_indicator),TRIM((SALT34.StrType)le.public_indicator),TRIM((SALT34.StrType)le.importer_exporter_indicator),TRIM((SALT34.StrType)le.structure_type),TRIM((SALT34.StrType)le.type_of_establishment),TRIM((SALT34.StrType)le.parent_duns_number),TRIM((SALT34.StrType)le.ultimate_duns_number),TRIM((SALT34.StrType)le.headquarters_duns_number),TRIM((SALT34.StrType)le.dias_code),TRIM((SALT34.StrType)le.hierarchy_code),TRIM((SALT34.StrType)le.ultimate_indicator),TRIM((SALT34.StrType)le.hot_list_new_indicator),TRIM((SALT34.StrType)le.hot_list_ownership_change_indicator),TRIM((SALT34.StrType)le.hot_list_ceo_change_indicator),TRIM((SALT34.StrType)le.hot_list_company_name_change_ind),TRIM((SALT34.StrType)le.hot_list_address_change_indicator),TRIM((SALT34.StrType)le.hot_list_telephone_change_indicator),TRIM((SALT34.StrType)le.hot_list_new_change_date),TRIM((SALT34.StrType)le.hot_list_ownership_change_date),TRIM((SALT34.StrType)le.hot_list_ceo_change_date),TRIM((SALT34.StrType)le.hot_list_company_name_chg_date),TRIM((SALT34.StrType)le.hot_list_address_change_date),TRIM((SALT34.StrType)le.hot_list_telephone_change_date),TRIM((SALT34.StrType)le.report_date),TRIM((SALT34.StrType)le.delete_record_indicator)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,83,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT34.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 83);
  SELF.FldNo2 := 1 + (C % 83);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT34.StrType)le.duns_number),TRIM((SALT34.StrType)le.business_name),TRIM((SALT34.StrType)le.street),TRIM((SALT34.StrType)le.city),TRIM((SALT34.StrType)le.state),TRIM((SALT34.StrType)le.zip_code),TRIM((SALT34.StrType)le.mail_address),TRIM((SALT34.StrType)le.mail_city),TRIM((SALT34.StrType)le.mail_state),TRIM((SALT34.StrType)le.mail_zip_code),TRIM((SALT34.StrType)le.telephone_number),TRIM((SALT34.StrType)le.county_name),TRIM((SALT34.StrType)le.msa_code),TRIM((SALT34.StrType)le.sic1),TRIM((SALT34.StrType)le.sic1a),TRIM((SALT34.StrType)le.sic1b),TRIM((SALT34.StrType)le.sic1c),TRIM((SALT34.StrType)le.sic1d),TRIM((SALT34.StrType)le.sic2),TRIM((SALT34.StrType)le.sic2a),TRIM((SALT34.StrType)le.sic2b),TRIM((SALT34.StrType)le.sic2c),TRIM((SALT34.StrType)le.sic2d),TRIM((SALT34.StrType)le.sic3),TRIM((SALT34.StrType)le.sic3a),TRIM((SALT34.StrType)le.sic3b),TRIM((SALT34.StrType)le.sic3c),TRIM((SALT34.StrType)le.sic3d),TRIM((SALT34.StrType)le.sic4),TRIM((SALT34.StrType)le.sic4a),TRIM((SALT34.StrType)le.sic4b),TRIM((SALT34.StrType)le.sic4c),TRIM((SALT34.StrType)le.sic4d),TRIM((SALT34.StrType)le.sic5),TRIM((SALT34.StrType)le.sic5a),TRIM((SALT34.StrType)le.sic5b),TRIM((SALT34.StrType)le.sic5c),TRIM((SALT34.StrType)le.sic5d),TRIM((SALT34.StrType)le.sic6),TRIM((SALT34.StrType)le.sic6a),TRIM((SALT34.StrType)le.sic6b),TRIM((SALT34.StrType)le.sic6c),TRIM((SALT34.StrType)le.sic6d),TRIM((SALT34.StrType)le.industry_group),TRIM((SALT34.StrType)le.year_started),TRIM((SALT34.StrType)le.date_of_incorporation),TRIM((SALT34.StrType)le.state_of_incorporation_abbr),TRIM((SALT34.StrType)le.annual_sales_code),TRIM((SALT34.StrType)le.employees_here_code),TRIM((SALT34.StrType)le.annual_sales_revision_date),TRIM((SALT34.StrType)le.square_footage),TRIM((SALT34.StrType)le.sals_territory),TRIM((SALT34.StrType)le.owns_rents),TRIM((SALT34.StrType)le.number_of_accounts),TRIM((SALT34.StrType)le.small_business_indicator),TRIM((SALT34.StrType)le.minority_owned),TRIM((SALT34.StrType)le.cottage_indicator),TRIM((SALT34.StrType)le.foreign_owned),TRIM((SALT34.StrType)le.manufacturing_here_indicator),TRIM((SALT34.StrType)le.public_indicator),TRIM((SALT34.StrType)le.importer_exporter_indicator),TRIM((SALT34.StrType)le.structure_type),TRIM((SALT34.StrType)le.type_of_establishment),TRIM((SALT34.StrType)le.parent_duns_number),TRIM((SALT34.StrType)le.ultimate_duns_number),TRIM((SALT34.StrType)le.headquarters_duns_number),TRIM((SALT34.StrType)le.dias_code),TRIM((SALT34.StrType)le.hierarchy_code),TRIM((SALT34.StrType)le.ultimate_indicator),TRIM((SALT34.StrType)le.hot_list_new_indicator),TRIM((SALT34.StrType)le.hot_list_ownership_change_indicator),TRIM((SALT34.StrType)le.hot_list_ceo_change_indicator),TRIM((SALT34.StrType)le.hot_list_company_name_change_ind),TRIM((SALT34.StrType)le.hot_list_address_change_indicator),TRIM((SALT34.StrType)le.hot_list_telephone_change_indicator),TRIM((SALT34.StrType)le.hot_list_new_change_date),TRIM((SALT34.StrType)le.hot_list_ownership_change_date),TRIM((SALT34.StrType)le.hot_list_ceo_change_date),TRIM((SALT34.StrType)le.hot_list_company_name_chg_date),TRIM((SALT34.StrType)le.hot_list_address_change_date),TRIM((SALT34.StrType)le.hot_list_telephone_change_date),TRIM((SALT34.StrType)le.report_date),TRIM((SALT34.StrType)le.delete_record_indicator)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT34.StrType)le.duns_number),TRIM((SALT34.StrType)le.business_name),TRIM((SALT34.StrType)le.street),TRIM((SALT34.StrType)le.city),TRIM((SALT34.StrType)le.state),TRIM((SALT34.StrType)le.zip_code),TRIM((SALT34.StrType)le.mail_address),TRIM((SALT34.StrType)le.mail_city),TRIM((SALT34.StrType)le.mail_state),TRIM((SALT34.StrType)le.mail_zip_code),TRIM((SALT34.StrType)le.telephone_number),TRIM((SALT34.StrType)le.county_name),TRIM((SALT34.StrType)le.msa_code),TRIM((SALT34.StrType)le.sic1),TRIM((SALT34.StrType)le.sic1a),TRIM((SALT34.StrType)le.sic1b),TRIM((SALT34.StrType)le.sic1c),TRIM((SALT34.StrType)le.sic1d),TRIM((SALT34.StrType)le.sic2),TRIM((SALT34.StrType)le.sic2a),TRIM((SALT34.StrType)le.sic2b),TRIM((SALT34.StrType)le.sic2c),TRIM((SALT34.StrType)le.sic2d),TRIM((SALT34.StrType)le.sic3),TRIM((SALT34.StrType)le.sic3a),TRIM((SALT34.StrType)le.sic3b),TRIM((SALT34.StrType)le.sic3c),TRIM((SALT34.StrType)le.sic3d),TRIM((SALT34.StrType)le.sic4),TRIM((SALT34.StrType)le.sic4a),TRIM((SALT34.StrType)le.sic4b),TRIM((SALT34.StrType)le.sic4c),TRIM((SALT34.StrType)le.sic4d),TRIM((SALT34.StrType)le.sic5),TRIM((SALT34.StrType)le.sic5a),TRIM((SALT34.StrType)le.sic5b),TRIM((SALT34.StrType)le.sic5c),TRIM((SALT34.StrType)le.sic5d),TRIM((SALT34.StrType)le.sic6),TRIM((SALT34.StrType)le.sic6a),TRIM((SALT34.StrType)le.sic6b),TRIM((SALT34.StrType)le.sic6c),TRIM((SALT34.StrType)le.sic6d),TRIM((SALT34.StrType)le.industry_group),TRIM((SALT34.StrType)le.year_started),TRIM((SALT34.StrType)le.date_of_incorporation),TRIM((SALT34.StrType)le.state_of_incorporation_abbr),TRIM((SALT34.StrType)le.annual_sales_code),TRIM((SALT34.StrType)le.employees_here_code),TRIM((SALT34.StrType)le.annual_sales_revision_date),TRIM((SALT34.StrType)le.square_footage),TRIM((SALT34.StrType)le.sals_territory),TRIM((SALT34.StrType)le.owns_rents),TRIM((SALT34.StrType)le.number_of_accounts),TRIM((SALT34.StrType)le.small_business_indicator),TRIM((SALT34.StrType)le.minority_owned),TRIM((SALT34.StrType)le.cottage_indicator),TRIM((SALT34.StrType)le.foreign_owned),TRIM((SALT34.StrType)le.manufacturing_here_indicator),TRIM((SALT34.StrType)le.public_indicator),TRIM((SALT34.StrType)le.importer_exporter_indicator),TRIM((SALT34.StrType)le.structure_type),TRIM((SALT34.StrType)le.type_of_establishment),TRIM((SALT34.StrType)le.parent_duns_number),TRIM((SALT34.StrType)le.ultimate_duns_number),TRIM((SALT34.StrType)le.headquarters_duns_number),TRIM((SALT34.StrType)le.dias_code),TRIM((SALT34.StrType)le.hierarchy_code),TRIM((SALT34.StrType)le.ultimate_indicator),TRIM((SALT34.StrType)le.hot_list_new_indicator),TRIM((SALT34.StrType)le.hot_list_ownership_change_indicator),TRIM((SALT34.StrType)le.hot_list_ceo_change_indicator),TRIM((SALT34.StrType)le.hot_list_company_name_change_ind),TRIM((SALT34.StrType)le.hot_list_address_change_indicator),TRIM((SALT34.StrType)le.hot_list_telephone_change_indicator),TRIM((SALT34.StrType)le.hot_list_new_change_date),TRIM((SALT34.StrType)le.hot_list_ownership_change_date),TRIM((SALT34.StrType)le.hot_list_ceo_change_date),TRIM((SALT34.StrType)le.hot_list_company_name_chg_date),TRIM((SALT34.StrType)le.hot_list_address_change_date),TRIM((SALT34.StrType)le.hot_list_telephone_change_date),TRIM((SALT34.StrType)le.report_date),TRIM((SALT34.StrType)le.delete_record_indicator)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),83*83,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'duns_number'}
      ,{2,'business_name'}
      ,{3,'street'}
      ,{4,'city'}
      ,{5,'state'}
      ,{6,'zip_code'}
      ,{7,'mail_address'}
      ,{8,'mail_city'}
      ,{9,'mail_state'}
      ,{10,'mail_zip_code'}
      ,{11,'telephone_number'}
      ,{12,'county_name'}
      ,{13,'msa_code'}
      ,{14,'sic1'}
      ,{15,'sic1a'}
      ,{16,'sic1b'}
      ,{17,'sic1c'}
      ,{18,'sic1d'}
      ,{19,'sic2'}
      ,{20,'sic2a'}
      ,{21,'sic2b'}
      ,{22,'sic2c'}
      ,{23,'sic2d'}
      ,{24,'sic3'}
      ,{25,'sic3a'}
      ,{26,'sic3b'}
      ,{27,'sic3c'}
      ,{28,'sic3d'}
      ,{29,'sic4'}
      ,{30,'sic4a'}
      ,{31,'sic4b'}
      ,{32,'sic4c'}
      ,{33,'sic4d'}
      ,{34,'sic5'}
      ,{35,'sic5a'}
      ,{36,'sic5b'}
      ,{37,'sic5c'}
      ,{38,'sic5d'}
      ,{39,'sic6'}
      ,{40,'sic6a'}
      ,{41,'sic6b'}
      ,{42,'sic6c'}
      ,{43,'sic6d'}
      ,{44,'industry_group'}
      ,{45,'year_started'}
      ,{46,'date_of_incorporation'}
      ,{47,'state_of_incorporation_abbr'}
      ,{48,'annual_sales_code'}
      ,{49,'employees_here_code'}
      ,{50,'annual_sales_revision_date'}
      ,{51,'square_footage'}
      ,{52,'sals_territory'}
      ,{53,'owns_rents'}
      ,{54,'number_of_accounts'}
      ,{55,'small_business_indicator'}
      ,{56,'minority_owned'}
      ,{57,'cottage_indicator'}
      ,{58,'foreign_owned'}
      ,{59,'manufacturing_here_indicator'}
      ,{60,'public_indicator'}
      ,{61,'importer_exporter_indicator'}
      ,{62,'structure_type'}
      ,{63,'type_of_establishment'}
      ,{64,'parent_duns_number'}
      ,{65,'ultimate_duns_number'}
      ,{66,'headquarters_duns_number'}
      ,{67,'dias_code'}
      ,{68,'hierarchy_code'}
      ,{69,'ultimate_indicator'}
      ,{70,'hot_list_new_indicator'}
      ,{71,'hot_list_ownership_change_indicator'}
      ,{72,'hot_list_ceo_change_indicator'}
      ,{73,'hot_list_company_name_change_ind'}
      ,{74,'hot_list_address_change_indicator'}
      ,{75,'hot_list_telephone_change_indicator'}
      ,{76,'hot_list_new_change_date'}
      ,{77,'hot_list_ownership_change_date'}
      ,{78,'hot_list_ceo_change_date'}
      ,{79,'hot_list_company_name_chg_date'}
      ,{80,'hot_list_address_change_date'}
      ,{81,'hot_list_telephone_change_date'}
      ,{82,'report_date'}
      ,{83,'delete_record_indicator'}],SALT34.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT34.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT34.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT34.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Raw_Fields.InValid_duns_number((SALT34.StrType)le.duns_number),
    Raw_Fields.InValid_business_name((SALT34.StrType)le.business_name),
    Raw_Fields.InValid_street((SALT34.StrType)le.street),
    Raw_Fields.InValid_city((SALT34.StrType)le.city),
    Raw_Fields.InValid_state((SALT34.StrType)le.state),
    Raw_Fields.InValid_zip_code((SALT34.StrType)le.zip_code),
    Raw_Fields.InValid_mail_address((SALT34.StrType)le.mail_address),
    Raw_Fields.InValid_mail_city((SALT34.StrType)le.mail_city),
    Raw_Fields.InValid_mail_state((SALT34.StrType)le.mail_state),
    Raw_Fields.InValid_mail_zip_code((SALT34.StrType)le.mail_zip_code),
    Raw_Fields.InValid_telephone_number((SALT34.StrType)le.telephone_number),
    Raw_Fields.InValid_county_name((SALT34.StrType)le.county_name),
    Raw_Fields.InValid_msa_code((SALT34.StrType)le.msa_code),
    Raw_Fields.InValid_sic1((SALT34.StrType)le.sic1),
    Raw_Fields.InValid_sic1a((SALT34.StrType)le.sic1a),
    Raw_Fields.InValid_sic1b((SALT34.StrType)le.sic1b),
    Raw_Fields.InValid_sic1c((SALT34.StrType)le.sic1c),
    Raw_Fields.InValid_sic1d((SALT34.StrType)le.sic1d),
    Raw_Fields.InValid_sic2((SALT34.StrType)le.sic2),
    Raw_Fields.InValid_sic2a((SALT34.StrType)le.sic2a),
    Raw_Fields.InValid_sic2b((SALT34.StrType)le.sic2b),
    Raw_Fields.InValid_sic2c((SALT34.StrType)le.sic2c),
    Raw_Fields.InValid_sic2d((SALT34.StrType)le.sic2d),
    Raw_Fields.InValid_sic3((SALT34.StrType)le.sic3),
    Raw_Fields.InValid_sic3a((SALT34.StrType)le.sic3a),
    Raw_Fields.InValid_sic3b((SALT34.StrType)le.sic3b),
    Raw_Fields.InValid_sic3c((SALT34.StrType)le.sic3c),
    Raw_Fields.InValid_sic3d((SALT34.StrType)le.sic3d),
    Raw_Fields.InValid_sic4((SALT34.StrType)le.sic4),
    Raw_Fields.InValid_sic4a((SALT34.StrType)le.sic4a),
    Raw_Fields.InValid_sic4b((SALT34.StrType)le.sic4b),
    Raw_Fields.InValid_sic4c((SALT34.StrType)le.sic4c),
    Raw_Fields.InValid_sic4d((SALT34.StrType)le.sic4d),
    Raw_Fields.InValid_sic5((SALT34.StrType)le.sic5),
    Raw_Fields.InValid_sic5a((SALT34.StrType)le.sic5a),
    Raw_Fields.InValid_sic5b((SALT34.StrType)le.sic5b),
    Raw_Fields.InValid_sic5c((SALT34.StrType)le.sic5c),
    Raw_Fields.InValid_sic5d((SALT34.StrType)le.sic5d),
    Raw_Fields.InValid_sic6((SALT34.StrType)le.sic6),
    Raw_Fields.InValid_sic6a((SALT34.StrType)le.sic6a),
    Raw_Fields.InValid_sic6b((SALT34.StrType)le.sic6b),
    Raw_Fields.InValid_sic6c((SALT34.StrType)le.sic6c),
    Raw_Fields.InValid_sic6d((SALT34.StrType)le.sic6d),
    Raw_Fields.InValid_industry_group((SALT34.StrType)le.industry_group),
    Raw_Fields.InValid_year_started((SALT34.StrType)le.year_started),
    Raw_Fields.InValid_date_of_incorporation((SALT34.StrType)le.date_of_incorporation),
    Raw_Fields.InValid_state_of_incorporation_abbr((SALT34.StrType)le.state_of_incorporation_abbr),
    Raw_Fields.InValid_annual_sales_code((SALT34.StrType)le.annual_sales_code),
    Raw_Fields.InValid_employees_here_code((SALT34.StrType)le.employees_here_code),
    Raw_Fields.InValid_annual_sales_revision_date((SALT34.StrType)le.annual_sales_revision_date),
    Raw_Fields.InValid_square_footage((SALT34.StrType)le.square_footage),
    Raw_Fields.InValid_sals_territory((SALT34.StrType)le.sals_territory),
    Raw_Fields.InValid_owns_rents((SALT34.StrType)le.owns_rents),
    Raw_Fields.InValid_number_of_accounts((SALT34.StrType)le.number_of_accounts),
    Raw_Fields.InValid_small_business_indicator((SALT34.StrType)le.small_business_indicator),
    Raw_Fields.InValid_minority_owned((SALT34.StrType)le.minority_owned),
    Raw_Fields.InValid_cottage_indicator((SALT34.StrType)le.cottage_indicator),
    Raw_Fields.InValid_foreign_owned((SALT34.StrType)le.foreign_owned),
    Raw_Fields.InValid_manufacturing_here_indicator((SALT34.StrType)le.manufacturing_here_indicator),
    Raw_Fields.InValid_public_indicator((SALT34.StrType)le.public_indicator),
    Raw_Fields.InValid_importer_exporter_indicator((SALT34.StrType)le.importer_exporter_indicator),
    Raw_Fields.InValid_structure_type((SALT34.StrType)le.structure_type),
    Raw_Fields.InValid_type_of_establishment((SALT34.StrType)le.type_of_establishment),
    Raw_Fields.InValid_parent_duns_number((SALT34.StrType)le.parent_duns_number),
    Raw_Fields.InValid_ultimate_duns_number((SALT34.StrType)le.ultimate_duns_number),
    Raw_Fields.InValid_headquarters_duns_number((SALT34.StrType)le.headquarters_duns_number),
    Raw_Fields.InValid_dias_code((SALT34.StrType)le.dias_code),
    Raw_Fields.InValid_hierarchy_code((SALT34.StrType)le.hierarchy_code),
    Raw_Fields.InValid_ultimate_indicator((SALT34.StrType)le.ultimate_indicator),
    Raw_Fields.InValid_hot_list_new_indicator((SALT34.StrType)le.hot_list_new_indicator),
    Raw_Fields.InValid_hot_list_ownership_change_indicator((SALT34.StrType)le.hot_list_ownership_change_indicator),
    Raw_Fields.InValid_hot_list_ceo_change_indicator((SALT34.StrType)le.hot_list_ceo_change_indicator),
    Raw_Fields.InValid_hot_list_company_name_change_ind((SALT34.StrType)le.hot_list_company_name_change_ind),
    Raw_Fields.InValid_hot_list_address_change_indicator((SALT34.StrType)le.hot_list_address_change_indicator),
    Raw_Fields.InValid_hot_list_telephone_change_indicator((SALT34.StrType)le.hot_list_telephone_change_indicator),
    Raw_Fields.InValid_hot_list_new_change_date((SALT34.StrType)le.hot_list_new_change_date),
    Raw_Fields.InValid_hot_list_ownership_change_date((SALT34.StrType)le.hot_list_ownership_change_date),
    Raw_Fields.InValid_hot_list_ceo_change_date((SALT34.StrType)le.hot_list_ceo_change_date),
    Raw_Fields.InValid_hot_list_company_name_chg_date((SALT34.StrType)le.hot_list_company_name_chg_date),
    Raw_Fields.InValid_hot_list_address_change_date((SALT34.StrType)le.hot_list_address_change_date),
    Raw_Fields.InValid_hot_list_telephone_change_date((SALT34.StrType)le.hot_list_telephone_change_date),
    Raw_Fields.InValid_report_date((SALT34.StrType)le.report_date),
    Raw_Fields.InValid_delete_record_indicator((SALT34.StrType)le.delete_record_indicator),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,83,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Raw_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid__duns','invalid__mandatory','invalid__street','invalid__city','invalid__state','invalid__zip','invalid__street','invalid__city','invalid__state','invalid__zip','invalid__phone','invalid__county','invalid__msa','invalid__sic','invalid__sic','invalid__sic','invalid__sic','invalid__sic','invalid__sic','invalid__sic','invalid__sic','invalid__sic','invalid__sic','invalid__sic','invalid__sic','invalid__sic','invalid__sic','invalid__sic','invalid__sic','invalid__sic','invalid__sic','invalid__sic','invalid__sic','invalid__sic','invalid__sic','invalid__sic','invalid__sic','invalid__sic','invalid__sic','invalid__sic','invalid__sic','invalid__sic','invalid__sic','invalid__industry','invalid__year','invalid__chars','invalid__state','invalid__code','invalid__code','invalid__optional_date','invalid__square_ft','invalid__code5','invalid__owns_rent','invalid__all_digits','invalid__yes_no','invalid__yes_no','invalid__yes_no','invalid__yes_no','invalid__yes_no','invalid__yes_no','invalid__code','invalid__code','invalid__code5','invalid__duns','invalid__duns','invalid__duns','invalid__all_digits','invalid__hierarchy','invalid__yes_no','invalid__code','invalid__4orBlank','invalid__5orBlank','invalid__6orBlank','invalid__7orBlank','invalid__8orBlank','invalid__year','invalid__year','invalid__year','invalid__year','invalid__year','invalid__year','invalid__report_date','invalid__delete_indicator');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Raw_Fields.InValidMessage_duns_number(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_business_name(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_street(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_city(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_state(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_zip_code(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_mail_address(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_mail_city(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_mail_state(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_mail_zip_code(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_telephone_number(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_county_name(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_msa_code(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_sic1(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_sic1a(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_sic1b(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_sic1c(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_sic1d(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_sic2(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_sic2a(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_sic2b(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_sic2c(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_sic2d(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_sic3(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_sic3a(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_sic3b(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_sic3c(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_sic3d(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_sic4(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_sic4a(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_sic4b(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_sic4c(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_sic4d(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_sic5(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_sic5a(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_sic5b(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_sic5c(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_sic5d(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_sic6(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_sic6a(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_sic6b(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_sic6c(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_sic6d(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_industry_group(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_year_started(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_date_of_incorporation(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_state_of_incorporation_abbr(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_annual_sales_code(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_employees_here_code(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_annual_sales_revision_date(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_square_footage(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_sals_territory(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_owns_rents(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_number_of_accounts(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_small_business_indicator(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_minority_owned(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_cottage_indicator(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_foreign_owned(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_manufacturing_here_indicator(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_public_indicator(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_importer_exporter_indicator(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_structure_type(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_type_of_establishment(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_parent_duns_number(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_ultimate_duns_number(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_headquarters_duns_number(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_dias_code(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_hierarchy_code(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_ultimate_indicator(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_hot_list_new_indicator(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_hot_list_ownership_change_indicator(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_hot_list_ceo_change_indicator(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_hot_list_company_name_change_ind(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_hot_list_address_change_indicator(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_hot_list_telephone_change_indicator(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_hot_list_new_change_date(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_hot_list_ownership_change_date(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_hot_list_ceo_change_date(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_hot_list_company_name_chg_date(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_hot_list_address_change_date(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_hot_list_telephone_change_date(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_report_date(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_delete_record_indicator(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
