 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_duns_number = '',Input_business_name = '',Input_street = '',Input_city = '',Input_state = '',Input_zip_code = '',Input_mail_address = '',Input_mail_city = '',Input_mail_state = '',Input_mail_zip_code = '',Input_telephone_number = '',Input_county_name = '',Input_msa_code = '',Input_sic1 = '',Input_sic1a = '',Input_sic1b = '',Input_sic1c = '',Input_sic1d = '',Input_sic2 = '',Input_sic2a = '',Input_sic2b = '',Input_sic2c = '',Input_sic2d = '',Input_sic3 = '',Input_sic3a = '',Input_sic3b = '',Input_sic3c = '',Input_sic3d = '',Input_sic4 = '',Input_sic4a = '',Input_sic4b = '',Input_sic4c = '',Input_sic4d = '',Input_sic5 = '',Input_sic5a = '',Input_sic5b = '',Input_sic5c = '',Input_sic5d = '',Input_sic6 = '',Input_sic6a = '',Input_sic6b = '',Input_sic6c = '',Input_sic6d = '',Input_industry_group = '',Input_year_started = '',Input_date_of_incorporation = '',Input_state_of_incorporation_abbr = '',Input_annual_sales_code = '',Input_employees_here_code = '',Input_annual_sales_revision_date = '',Input_square_footage = '',Input_sals_territory = '',Input_owns_rents = '',Input_number_of_accounts = '',Input_small_business_indicator = '',Input_minority_owned = '',Input_cottage_indicator = '',Input_foreign_owned = '',Input_manufacturing_here_indicator = '',Input_public_indicator = '',Input_importer_exporter_indicator = '',Input_structure_type = '',Input_type_of_establishment = '',Input_parent_duns_number = '',Input_ultimate_duns_number = '',Input_headquarters_duns_number = '',Input_dias_code = '',Input_hierarchy_code = '',Input_ultimate_indicator = '',Input_hot_list_new_indicator = '',Input_hot_list_ownership_change_indicator = '',Input_hot_list_ceo_change_indicator = '',Input_hot_list_company_name_change_ind = '',Input_hot_list_address_change_indicator = '',Input_hot_list_telephone_change_indicator = '',Input_hot_list_new_change_date = '',Input_hot_list_ownership_change_date = '',Input_hot_list_ceo_change_date = '',Input_hot_list_company_name_chg_date = '',Input_hot_list_address_change_date = '',Input_hot_list_telephone_change_date = '',Input_report_date = '',Input_delete_record_indicator = '',OutFile) := MACRO
  IMPORT SALT34,Scrubs_DNB_DMI;
  #uniquename(of)
  %of% := RECORD
    SALT34.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_duns_number)='' )
      '' 
    #ELSE
        IF( le.Input_duns_number = (TYPEOF(le.Input_duns_number))'','',':duns_number')
    #END
 
+    #IF( #TEXT(Input_business_name)='' )
      '' 
    #ELSE
        IF( le.Input_business_name = (TYPEOF(le.Input_business_name))'','',':business_name')
    #END
 
+    #IF( #TEXT(Input_street)='' )
      '' 
    #ELSE
        IF( le.Input_street = (TYPEOF(le.Input_street))'','',':street')
    #END
 
+    #IF( #TEXT(Input_city)='' )
      '' 
    #ELSE
        IF( le.Input_city = (TYPEOF(le.Input_city))'','',':city')
    #END
 
+    #IF( #TEXT(Input_state)='' )
      '' 
    #ELSE
        IF( le.Input_state = (TYPEOF(le.Input_state))'','',':state')
    #END
 
+    #IF( #TEXT(Input_zip_code)='' )
      '' 
    #ELSE
        IF( le.Input_zip_code = (TYPEOF(le.Input_zip_code))'','',':zip_code')
    #END
 
+    #IF( #TEXT(Input_mail_address)='' )
      '' 
    #ELSE
        IF( le.Input_mail_address = (TYPEOF(le.Input_mail_address))'','',':mail_address')
    #END
 
+    #IF( #TEXT(Input_mail_city)='' )
      '' 
    #ELSE
        IF( le.Input_mail_city = (TYPEOF(le.Input_mail_city))'','',':mail_city')
    #END
 
+    #IF( #TEXT(Input_mail_state)='' )
      '' 
    #ELSE
        IF( le.Input_mail_state = (TYPEOF(le.Input_mail_state))'','',':mail_state')
    #END
 
+    #IF( #TEXT(Input_mail_zip_code)='' )
      '' 
    #ELSE
        IF( le.Input_mail_zip_code = (TYPEOF(le.Input_mail_zip_code))'','',':mail_zip_code')
    #END
 
+    #IF( #TEXT(Input_telephone_number)='' )
      '' 
    #ELSE
        IF( le.Input_telephone_number = (TYPEOF(le.Input_telephone_number))'','',':telephone_number')
    #END
 
+    #IF( #TEXT(Input_county_name)='' )
      '' 
    #ELSE
        IF( le.Input_county_name = (TYPEOF(le.Input_county_name))'','',':county_name')
    #END
 
+    #IF( #TEXT(Input_msa_code)='' )
      '' 
    #ELSE
        IF( le.Input_msa_code = (TYPEOF(le.Input_msa_code))'','',':msa_code')
    #END
 
+    #IF( #TEXT(Input_sic1)='' )
      '' 
    #ELSE
        IF( le.Input_sic1 = (TYPEOF(le.Input_sic1))'','',':sic1')
    #END
 
+    #IF( #TEXT(Input_sic1a)='' )
      '' 
    #ELSE
        IF( le.Input_sic1a = (TYPEOF(le.Input_sic1a))'','',':sic1a')
    #END
 
+    #IF( #TEXT(Input_sic1b)='' )
      '' 
    #ELSE
        IF( le.Input_sic1b = (TYPEOF(le.Input_sic1b))'','',':sic1b')
    #END
 
+    #IF( #TEXT(Input_sic1c)='' )
      '' 
    #ELSE
        IF( le.Input_sic1c = (TYPEOF(le.Input_sic1c))'','',':sic1c')
    #END
 
+    #IF( #TEXT(Input_sic1d)='' )
      '' 
    #ELSE
        IF( le.Input_sic1d = (TYPEOF(le.Input_sic1d))'','',':sic1d')
    #END
 
+    #IF( #TEXT(Input_sic2)='' )
      '' 
    #ELSE
        IF( le.Input_sic2 = (TYPEOF(le.Input_sic2))'','',':sic2')
    #END
 
+    #IF( #TEXT(Input_sic2a)='' )
      '' 
    #ELSE
        IF( le.Input_sic2a = (TYPEOF(le.Input_sic2a))'','',':sic2a')
    #END
 
+    #IF( #TEXT(Input_sic2b)='' )
      '' 
    #ELSE
        IF( le.Input_sic2b = (TYPEOF(le.Input_sic2b))'','',':sic2b')
    #END
 
+    #IF( #TEXT(Input_sic2c)='' )
      '' 
    #ELSE
        IF( le.Input_sic2c = (TYPEOF(le.Input_sic2c))'','',':sic2c')
    #END
 
+    #IF( #TEXT(Input_sic2d)='' )
      '' 
    #ELSE
        IF( le.Input_sic2d = (TYPEOF(le.Input_sic2d))'','',':sic2d')
    #END
 
+    #IF( #TEXT(Input_sic3)='' )
      '' 
    #ELSE
        IF( le.Input_sic3 = (TYPEOF(le.Input_sic3))'','',':sic3')
    #END
 
+    #IF( #TEXT(Input_sic3a)='' )
      '' 
    #ELSE
        IF( le.Input_sic3a = (TYPEOF(le.Input_sic3a))'','',':sic3a')
    #END
 
+    #IF( #TEXT(Input_sic3b)='' )
      '' 
    #ELSE
        IF( le.Input_sic3b = (TYPEOF(le.Input_sic3b))'','',':sic3b')
    #END
 
+    #IF( #TEXT(Input_sic3c)='' )
      '' 
    #ELSE
        IF( le.Input_sic3c = (TYPEOF(le.Input_sic3c))'','',':sic3c')
    #END
 
+    #IF( #TEXT(Input_sic3d)='' )
      '' 
    #ELSE
        IF( le.Input_sic3d = (TYPEOF(le.Input_sic3d))'','',':sic3d')
    #END
 
+    #IF( #TEXT(Input_sic4)='' )
      '' 
    #ELSE
        IF( le.Input_sic4 = (TYPEOF(le.Input_sic4))'','',':sic4')
    #END
 
+    #IF( #TEXT(Input_sic4a)='' )
      '' 
    #ELSE
        IF( le.Input_sic4a = (TYPEOF(le.Input_sic4a))'','',':sic4a')
    #END
 
+    #IF( #TEXT(Input_sic4b)='' )
      '' 
    #ELSE
        IF( le.Input_sic4b = (TYPEOF(le.Input_sic4b))'','',':sic4b')
    #END
 
+    #IF( #TEXT(Input_sic4c)='' )
      '' 
    #ELSE
        IF( le.Input_sic4c = (TYPEOF(le.Input_sic4c))'','',':sic4c')
    #END
 
+    #IF( #TEXT(Input_sic4d)='' )
      '' 
    #ELSE
        IF( le.Input_sic4d = (TYPEOF(le.Input_sic4d))'','',':sic4d')
    #END
 
+    #IF( #TEXT(Input_sic5)='' )
      '' 
    #ELSE
        IF( le.Input_sic5 = (TYPEOF(le.Input_sic5))'','',':sic5')
    #END
 
+    #IF( #TEXT(Input_sic5a)='' )
      '' 
    #ELSE
        IF( le.Input_sic5a = (TYPEOF(le.Input_sic5a))'','',':sic5a')
    #END
 
+    #IF( #TEXT(Input_sic5b)='' )
      '' 
    #ELSE
        IF( le.Input_sic5b = (TYPEOF(le.Input_sic5b))'','',':sic5b')
    #END
 
+    #IF( #TEXT(Input_sic5c)='' )
      '' 
    #ELSE
        IF( le.Input_sic5c = (TYPEOF(le.Input_sic5c))'','',':sic5c')
    #END
 
+    #IF( #TEXT(Input_sic5d)='' )
      '' 
    #ELSE
        IF( le.Input_sic5d = (TYPEOF(le.Input_sic5d))'','',':sic5d')
    #END
 
+    #IF( #TEXT(Input_sic6)='' )
      '' 
    #ELSE
        IF( le.Input_sic6 = (TYPEOF(le.Input_sic6))'','',':sic6')
    #END
 
+    #IF( #TEXT(Input_sic6a)='' )
      '' 
    #ELSE
        IF( le.Input_sic6a = (TYPEOF(le.Input_sic6a))'','',':sic6a')
    #END
 
+    #IF( #TEXT(Input_sic6b)='' )
      '' 
    #ELSE
        IF( le.Input_sic6b = (TYPEOF(le.Input_sic6b))'','',':sic6b')
    #END
 
+    #IF( #TEXT(Input_sic6c)='' )
      '' 
    #ELSE
        IF( le.Input_sic6c = (TYPEOF(le.Input_sic6c))'','',':sic6c')
    #END
 
+    #IF( #TEXT(Input_sic6d)='' )
      '' 
    #ELSE
        IF( le.Input_sic6d = (TYPEOF(le.Input_sic6d))'','',':sic6d')
    #END
 
+    #IF( #TEXT(Input_industry_group)='' )
      '' 
    #ELSE
        IF( le.Input_industry_group = (TYPEOF(le.Input_industry_group))'','',':industry_group')
    #END
 
+    #IF( #TEXT(Input_year_started)='' )
      '' 
    #ELSE
        IF( le.Input_year_started = (TYPEOF(le.Input_year_started))'','',':year_started')
    #END
 
+    #IF( #TEXT(Input_date_of_incorporation)='' )
      '' 
    #ELSE
        IF( le.Input_date_of_incorporation = (TYPEOF(le.Input_date_of_incorporation))'','',':date_of_incorporation')
    #END
 
+    #IF( #TEXT(Input_state_of_incorporation_abbr)='' )
      '' 
    #ELSE
        IF( le.Input_state_of_incorporation_abbr = (TYPEOF(le.Input_state_of_incorporation_abbr))'','',':state_of_incorporation_abbr')
    #END
 
+    #IF( #TEXT(Input_annual_sales_code)='' )
      '' 
    #ELSE
        IF( le.Input_annual_sales_code = (TYPEOF(le.Input_annual_sales_code))'','',':annual_sales_code')
    #END
 
+    #IF( #TEXT(Input_employees_here_code)='' )
      '' 
    #ELSE
        IF( le.Input_employees_here_code = (TYPEOF(le.Input_employees_here_code))'','',':employees_here_code')
    #END
 
+    #IF( #TEXT(Input_annual_sales_revision_date)='' )
      '' 
    #ELSE
        IF( le.Input_annual_sales_revision_date = (TYPEOF(le.Input_annual_sales_revision_date))'','',':annual_sales_revision_date')
    #END
 
+    #IF( #TEXT(Input_square_footage)='' )
      '' 
    #ELSE
        IF( le.Input_square_footage = (TYPEOF(le.Input_square_footage))'','',':square_footage')
    #END
 
+    #IF( #TEXT(Input_sals_territory)='' )
      '' 
    #ELSE
        IF( le.Input_sals_territory = (TYPEOF(le.Input_sals_territory))'','',':sals_territory')
    #END
 
+    #IF( #TEXT(Input_owns_rents)='' )
      '' 
    #ELSE
        IF( le.Input_owns_rents = (TYPEOF(le.Input_owns_rents))'','',':owns_rents')
    #END
 
+    #IF( #TEXT(Input_number_of_accounts)='' )
      '' 
    #ELSE
        IF( le.Input_number_of_accounts = (TYPEOF(le.Input_number_of_accounts))'','',':number_of_accounts')
    #END
 
+    #IF( #TEXT(Input_small_business_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_small_business_indicator = (TYPEOF(le.Input_small_business_indicator))'','',':small_business_indicator')
    #END
 
+    #IF( #TEXT(Input_minority_owned)='' )
      '' 
    #ELSE
        IF( le.Input_minority_owned = (TYPEOF(le.Input_minority_owned))'','',':minority_owned')
    #END
 
+    #IF( #TEXT(Input_cottage_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_cottage_indicator = (TYPEOF(le.Input_cottage_indicator))'','',':cottage_indicator')
    #END
 
+    #IF( #TEXT(Input_foreign_owned)='' )
      '' 
    #ELSE
        IF( le.Input_foreign_owned = (TYPEOF(le.Input_foreign_owned))'','',':foreign_owned')
    #END
 
+    #IF( #TEXT(Input_manufacturing_here_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_manufacturing_here_indicator = (TYPEOF(le.Input_manufacturing_here_indicator))'','',':manufacturing_here_indicator')
    #END
 
+    #IF( #TEXT(Input_public_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_public_indicator = (TYPEOF(le.Input_public_indicator))'','',':public_indicator')
    #END
 
+    #IF( #TEXT(Input_importer_exporter_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_importer_exporter_indicator = (TYPEOF(le.Input_importer_exporter_indicator))'','',':importer_exporter_indicator')
    #END
 
+    #IF( #TEXT(Input_structure_type)='' )
      '' 
    #ELSE
        IF( le.Input_structure_type = (TYPEOF(le.Input_structure_type))'','',':structure_type')
    #END
 
+    #IF( #TEXT(Input_type_of_establishment)='' )
      '' 
    #ELSE
        IF( le.Input_type_of_establishment = (TYPEOF(le.Input_type_of_establishment))'','',':type_of_establishment')
    #END
 
+    #IF( #TEXT(Input_parent_duns_number)='' )
      '' 
    #ELSE
        IF( le.Input_parent_duns_number = (TYPEOF(le.Input_parent_duns_number))'','',':parent_duns_number')
    #END
 
+    #IF( #TEXT(Input_ultimate_duns_number)='' )
      '' 
    #ELSE
        IF( le.Input_ultimate_duns_number = (TYPEOF(le.Input_ultimate_duns_number))'','',':ultimate_duns_number')
    #END
 
+    #IF( #TEXT(Input_headquarters_duns_number)='' )
      '' 
    #ELSE
        IF( le.Input_headquarters_duns_number = (TYPEOF(le.Input_headquarters_duns_number))'','',':headquarters_duns_number')
    #END
 
+    #IF( #TEXT(Input_dias_code)='' )
      '' 
    #ELSE
        IF( le.Input_dias_code = (TYPEOF(le.Input_dias_code))'','',':dias_code')
    #END
 
+    #IF( #TEXT(Input_hierarchy_code)='' )
      '' 
    #ELSE
        IF( le.Input_hierarchy_code = (TYPEOF(le.Input_hierarchy_code))'','',':hierarchy_code')
    #END
 
+    #IF( #TEXT(Input_ultimate_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_ultimate_indicator = (TYPEOF(le.Input_ultimate_indicator))'','',':ultimate_indicator')
    #END
 
+    #IF( #TEXT(Input_hot_list_new_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_hot_list_new_indicator = (TYPEOF(le.Input_hot_list_new_indicator))'','',':hot_list_new_indicator')
    #END
 
+    #IF( #TEXT(Input_hot_list_ownership_change_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_hot_list_ownership_change_indicator = (TYPEOF(le.Input_hot_list_ownership_change_indicator))'','',':hot_list_ownership_change_indicator')
    #END
 
+    #IF( #TEXT(Input_hot_list_ceo_change_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_hot_list_ceo_change_indicator = (TYPEOF(le.Input_hot_list_ceo_change_indicator))'','',':hot_list_ceo_change_indicator')
    #END
 
+    #IF( #TEXT(Input_hot_list_company_name_change_ind)='' )
      '' 
    #ELSE
        IF( le.Input_hot_list_company_name_change_ind = (TYPEOF(le.Input_hot_list_company_name_change_ind))'','',':hot_list_company_name_change_ind')
    #END
 
+    #IF( #TEXT(Input_hot_list_address_change_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_hot_list_address_change_indicator = (TYPEOF(le.Input_hot_list_address_change_indicator))'','',':hot_list_address_change_indicator')
    #END
 
+    #IF( #TEXT(Input_hot_list_telephone_change_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_hot_list_telephone_change_indicator = (TYPEOF(le.Input_hot_list_telephone_change_indicator))'','',':hot_list_telephone_change_indicator')
    #END
 
+    #IF( #TEXT(Input_hot_list_new_change_date)='' )
      '' 
    #ELSE
        IF( le.Input_hot_list_new_change_date = (TYPEOF(le.Input_hot_list_new_change_date))'','',':hot_list_new_change_date')
    #END
 
+    #IF( #TEXT(Input_hot_list_ownership_change_date)='' )
      '' 
    #ELSE
        IF( le.Input_hot_list_ownership_change_date = (TYPEOF(le.Input_hot_list_ownership_change_date))'','',':hot_list_ownership_change_date')
    #END
 
+    #IF( #TEXT(Input_hot_list_ceo_change_date)='' )
      '' 
    #ELSE
        IF( le.Input_hot_list_ceo_change_date = (TYPEOF(le.Input_hot_list_ceo_change_date))'','',':hot_list_ceo_change_date')
    #END
 
+    #IF( #TEXT(Input_hot_list_company_name_chg_date)='' )
      '' 
    #ELSE
        IF( le.Input_hot_list_company_name_chg_date = (TYPEOF(le.Input_hot_list_company_name_chg_date))'','',':hot_list_company_name_chg_date')
    #END
 
+    #IF( #TEXT(Input_hot_list_address_change_date)='' )
      '' 
    #ELSE
        IF( le.Input_hot_list_address_change_date = (TYPEOF(le.Input_hot_list_address_change_date))'','',':hot_list_address_change_date')
    #END
 
+    #IF( #TEXT(Input_hot_list_telephone_change_date)='' )
      '' 
    #ELSE
        IF( le.Input_hot_list_telephone_change_date = (TYPEOF(le.Input_hot_list_telephone_change_date))'','',':hot_list_telephone_change_date')
    #END
 
+    #IF( #TEXT(Input_report_date)='' )
      '' 
    #ELSE
        IF( le.Input_report_date = (TYPEOF(le.Input_report_date))'','',':report_date')
    #END
 
+    #IF( #TEXT(Input_delete_record_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_delete_record_indicator = (TYPEOF(le.Input_delete_record_indicator))'','',':delete_record_indicator')
    #END
;
  END;
  #uniquename(op)
  %op% := PROJECT(infile,%ot%(LEFT));
  #uniquename(ort)
  %ort% := RECORD
    %op%.fields;
    UNSIGNED cnt := COUNT(GROUP);
  END;
  outfile := TOPN( TABLE( %op%, %ort%, fields, FEW ), 1000, -cnt );
ENDMACRO;
