 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_occupation_id = '',Input_first_name = '',Input_middle_name = '',Input_last_name = '',Input_suffix = '',Input_address = '',Input_prim_range = '',Input_predir = '',Input_prim_name = '',Input_addr_suffix = '',Input_postdir = '',Input_unit_type = '',Input_unit_number = '',Input_city = '',Input_state = '',Input_zip = '',Input_zip4 = '',Input_bar = '',Input_ace_rec_type = '',Input_cart = '',Input_census_state_code = '',Input_census_county_code = '',Input_county_code_desc = '',Input_census_tract = '',Input_census_block_group = '',Input_match_code = '',Input_latitude = '',Input_longitude = '',Input_mail_score = '',Input_residential_business_ind = '',Input_employer_name = '',Input_family_id = '',Input_individual_id = '',Input_abi_number = '',Input_industry_title = '',Input_occupation_title = '',Input_specialty_title = '',Input_sic_code = '',Input_naics_group = '',Input_license_state = '',Input_license_id = '',Input_license_number = '',Input_exp_date = '',Input_status_code = '',Input_effective_date = '',Input_add_date = '',Input_change_date = '',Input_year_licensed = '',Input_carriage_return = '',OutFile) := MACRO
  IMPORT SALT37,Scrubs_Infogroup;
  #uniquename(of)
  %of% := RECORD
    SALT37.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_occupation_id)='' )
      '' 
    #ELSE
        IF( le.Input_occupation_id = (TYPEOF(le.Input_occupation_id))'','',':occupation_id')
    #END
 
+    #IF( #TEXT(Input_first_name)='' )
      '' 
    #ELSE
        IF( le.Input_first_name = (TYPEOF(le.Input_first_name))'','',':first_name')
    #END
 
+    #IF( #TEXT(Input_middle_name)='' )
      '' 
    #ELSE
        IF( le.Input_middle_name = (TYPEOF(le.Input_middle_name))'','',':middle_name')
    #END
 
+    #IF( #TEXT(Input_last_name)='' )
      '' 
    #ELSE
        IF( le.Input_last_name = (TYPEOF(le.Input_last_name))'','',':last_name')
    #END
 
+    #IF( #TEXT(Input_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_suffix = (TYPEOF(le.Input_suffix))'','',':suffix')
    #END
 
+    #IF( #TEXT(Input_address)='' )
      '' 
    #ELSE
        IF( le.Input_address = (TYPEOF(le.Input_address))'','',':address')
    #END
 
+    #IF( #TEXT(Input_prim_range)='' )
      '' 
    #ELSE
        IF( le.Input_prim_range = (TYPEOF(le.Input_prim_range))'','',':prim_range')
    #END
 
+    #IF( #TEXT(Input_predir)='' )
      '' 
    #ELSE
        IF( le.Input_predir = (TYPEOF(le.Input_predir))'','',':predir')
    #END
 
+    #IF( #TEXT(Input_prim_name)='' )
      '' 
    #ELSE
        IF( le.Input_prim_name = (TYPEOF(le.Input_prim_name))'','',':prim_name')
    #END
 
+    #IF( #TEXT(Input_addr_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_addr_suffix = (TYPEOF(le.Input_addr_suffix))'','',':addr_suffix')
    #END
 
+    #IF( #TEXT(Input_postdir)='' )
      '' 
    #ELSE
        IF( le.Input_postdir = (TYPEOF(le.Input_postdir))'','',':postdir')
    #END
 
+    #IF( #TEXT(Input_unit_type)='' )
      '' 
    #ELSE
        IF( le.Input_unit_type = (TYPEOF(le.Input_unit_type))'','',':unit_type')
    #END
 
+    #IF( #TEXT(Input_unit_number)='' )
      '' 
    #ELSE
        IF( le.Input_unit_number = (TYPEOF(le.Input_unit_number))'','',':unit_number')
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
 
+    #IF( #TEXT(Input_zip)='' )
      '' 
    #ELSE
        IF( le.Input_zip = (TYPEOF(le.Input_zip))'','',':zip')
    #END
 
+    #IF( #TEXT(Input_zip4)='' )
      '' 
    #ELSE
        IF( le.Input_zip4 = (TYPEOF(le.Input_zip4))'','',':zip4')
    #END
 
+    #IF( #TEXT(Input_bar)='' )
      '' 
    #ELSE
        IF( le.Input_bar = (TYPEOF(le.Input_bar))'','',':bar')
    #END
 
+    #IF( #TEXT(Input_ace_rec_type)='' )
      '' 
    #ELSE
        IF( le.Input_ace_rec_type = (TYPEOF(le.Input_ace_rec_type))'','',':ace_rec_type')
    #END
 
+    #IF( #TEXT(Input_cart)='' )
      '' 
    #ELSE
        IF( le.Input_cart = (TYPEOF(le.Input_cart))'','',':cart')
    #END
 
+    #IF( #TEXT(Input_census_state_code)='' )
      '' 
    #ELSE
        IF( le.Input_census_state_code = (TYPEOF(le.Input_census_state_code))'','',':census_state_code')
    #END
 
+    #IF( #TEXT(Input_census_county_code)='' )
      '' 
    #ELSE
        IF( le.Input_census_county_code = (TYPEOF(le.Input_census_county_code))'','',':census_county_code')
    #END
 
+    #IF( #TEXT(Input_county_code_desc)='' )
      '' 
    #ELSE
        IF( le.Input_county_code_desc = (TYPEOF(le.Input_county_code_desc))'','',':county_code_desc')
    #END
 
+    #IF( #TEXT(Input_census_tract)='' )
      '' 
    #ELSE
        IF( le.Input_census_tract = (TYPEOF(le.Input_census_tract))'','',':census_tract')
    #END
 
+    #IF( #TEXT(Input_census_block_group)='' )
      '' 
    #ELSE
        IF( le.Input_census_block_group = (TYPEOF(le.Input_census_block_group))'','',':census_block_group')
    #END
 
+    #IF( #TEXT(Input_match_code)='' )
      '' 
    #ELSE
        IF( le.Input_match_code = (TYPEOF(le.Input_match_code))'','',':match_code')
    #END
 
+    #IF( #TEXT(Input_latitude)='' )
      '' 
    #ELSE
        IF( le.Input_latitude = (TYPEOF(le.Input_latitude))'','',':latitude')
    #END
 
+    #IF( #TEXT(Input_longitude)='' )
      '' 
    #ELSE
        IF( le.Input_longitude = (TYPEOF(le.Input_longitude))'','',':longitude')
    #END
 
+    #IF( #TEXT(Input_mail_score)='' )
      '' 
    #ELSE
        IF( le.Input_mail_score = (TYPEOF(le.Input_mail_score))'','',':mail_score')
    #END
 
+    #IF( #TEXT(Input_residential_business_ind)='' )
      '' 
    #ELSE
        IF( le.Input_residential_business_ind = (TYPEOF(le.Input_residential_business_ind))'','',':residential_business_ind')
    #END
 
+    #IF( #TEXT(Input_employer_name)='' )
      '' 
    #ELSE
        IF( le.Input_employer_name = (TYPEOF(le.Input_employer_name))'','',':employer_name')
    #END
 
+    #IF( #TEXT(Input_family_id)='' )
      '' 
    #ELSE
        IF( le.Input_family_id = (TYPEOF(le.Input_family_id))'','',':family_id')
    #END
 
+    #IF( #TEXT(Input_individual_id)='' )
      '' 
    #ELSE
        IF( le.Input_individual_id = (TYPEOF(le.Input_individual_id))'','',':individual_id')
    #END
 
+    #IF( #TEXT(Input_abi_number)='' )
      '' 
    #ELSE
        IF( le.Input_abi_number = (TYPEOF(le.Input_abi_number))'','',':abi_number')
    #END
 
+    #IF( #TEXT(Input_industry_title)='' )
      '' 
    #ELSE
        IF( le.Input_industry_title = (TYPEOF(le.Input_industry_title))'','',':industry_title')
    #END
 
+    #IF( #TEXT(Input_occupation_title)='' )
      '' 
    #ELSE
        IF( le.Input_occupation_title = (TYPEOF(le.Input_occupation_title))'','',':occupation_title')
    #END
 
+    #IF( #TEXT(Input_specialty_title)='' )
      '' 
    #ELSE
        IF( le.Input_specialty_title = (TYPEOF(le.Input_specialty_title))'','',':specialty_title')
    #END
 
+    #IF( #TEXT(Input_sic_code)='' )
      '' 
    #ELSE
        IF( le.Input_sic_code = (TYPEOF(le.Input_sic_code))'','',':sic_code')
    #END
 
+    #IF( #TEXT(Input_naics_group)='' )
      '' 
    #ELSE
        IF( le.Input_naics_group = (TYPEOF(le.Input_naics_group))'','',':naics_group')
    #END
 
+    #IF( #TEXT(Input_license_state)='' )
      '' 
    #ELSE
        IF( le.Input_license_state = (TYPEOF(le.Input_license_state))'','',':license_state')
    #END
 
+    #IF( #TEXT(Input_license_id)='' )
      '' 
    #ELSE
        IF( le.Input_license_id = (TYPEOF(le.Input_license_id))'','',':license_id')
    #END
 
+    #IF( #TEXT(Input_license_number)='' )
      '' 
    #ELSE
        IF( le.Input_license_number = (TYPEOF(le.Input_license_number))'','',':license_number')
    #END
 
+    #IF( #TEXT(Input_exp_date)='' )
      '' 
    #ELSE
        IF( le.Input_exp_date = (TYPEOF(le.Input_exp_date))'','',':exp_date')
    #END
 
+    #IF( #TEXT(Input_status_code)='' )
      '' 
    #ELSE
        IF( le.Input_status_code = (TYPEOF(le.Input_status_code))'','',':status_code')
    #END
 
+    #IF( #TEXT(Input_effective_date)='' )
      '' 
    #ELSE
        IF( le.Input_effective_date = (TYPEOF(le.Input_effective_date))'','',':effective_date')
    #END
 
+    #IF( #TEXT(Input_add_date)='' )
      '' 
    #ELSE
        IF( le.Input_add_date = (TYPEOF(le.Input_add_date))'','',':add_date')
    #END
 
+    #IF( #TEXT(Input_change_date)='' )
      '' 
    #ELSE
        IF( le.Input_change_date = (TYPEOF(le.Input_change_date))'','',':change_date')
    #END
 
+    #IF( #TEXT(Input_year_licensed)='' )
      '' 
    #ELSE
        IF( le.Input_year_licensed = (TYPEOF(le.Input_year_licensed))'','',':year_licensed')
    #END
 
+    #IF( #TEXT(Input_carriage_return)='' )
      '' 
    #ELSE
        IF( le.Input_carriage_return = (TYPEOF(le.Input_carriage_return))'','',':carriage_return')
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
