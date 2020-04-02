 
EXPORT Base_MAC_PopulationStatistics(infile,Ref='',Input_ace_aid = '',Input_address1 = '',Input_brand_name = '',Input_chk_digit = '',Input_city = '',Input_clean_phone = '',Input_clean_secondary_phone = '',Input_company_name = '',Input_dt_first_seen = '',Input_dt_last_seen = '',Input_dt_vendor_first_reported = '',Input_dt_vendor_last_reported = '',Input_err_stat = '',Input_fips_county = '',Input_fips_state = '',Input_franchisee_id = '',Input_fruns = '',Input_f_units = '',Input_industry = '',Input_industry_type = '',Input_p_city_name = '',Input_phone = '',Input_phone_extension = '',Input_prim_name = '',Input_record_id = '',Input_record_type = '',Input_relationship_code = '',Input_relationship_code_exp = '',Input_secondary_phone = '',Input_sector = '',Input_sic_code = '',Input_state = '',Input_unit_flag = '',Input_unit_flag_exp = '',Input_v_city_name = '',Input_zip_code = '',Input_zip_code4 = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_Frandx;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_ace_aid)='' )
      '' 
    #ELSE
        IF( le.Input_ace_aid = (TYPEOF(le.Input_ace_aid))'','',':ace_aid')
    #END
 
+    #IF( #TEXT(Input_address1)='' )
      '' 
    #ELSE
        IF( le.Input_address1 = (TYPEOF(le.Input_address1))'','',':address1')
    #END
 
+    #IF( #TEXT(Input_brand_name)='' )
      '' 
    #ELSE
        IF( le.Input_brand_name = (TYPEOF(le.Input_brand_name))'','',':brand_name')
    #END
 
+    #IF( #TEXT(Input_chk_digit)='' )
      '' 
    #ELSE
        IF( le.Input_chk_digit = (TYPEOF(le.Input_chk_digit))'','',':chk_digit')
    #END
 
+    #IF( #TEXT(Input_city)='' )
      '' 
    #ELSE
        IF( le.Input_city = (TYPEOF(le.Input_city))'','',':city')
    #END
 
+    #IF( #TEXT(Input_clean_phone)='' )
      '' 
    #ELSE
        IF( le.Input_clean_phone = (TYPEOF(le.Input_clean_phone))'','',':clean_phone')
    #END
 
+    #IF( #TEXT(Input_clean_secondary_phone)='' )
      '' 
    #ELSE
        IF( le.Input_clean_secondary_phone = (TYPEOF(le.Input_clean_secondary_phone))'','',':clean_secondary_phone')
    #END
 
+    #IF( #TEXT(Input_company_name)='' )
      '' 
    #ELSE
        IF( le.Input_company_name = (TYPEOF(le.Input_company_name))'','',':company_name')
    #END
 
+    #IF( #TEXT(Input_dt_first_seen)='' )
      '' 
    #ELSE
        IF( le.Input_dt_first_seen = (TYPEOF(le.Input_dt_first_seen))'','',':dt_first_seen')
    #END
 
+    #IF( #TEXT(Input_dt_last_seen)='' )
      '' 
    #ELSE
        IF( le.Input_dt_last_seen = (TYPEOF(le.Input_dt_last_seen))'','',':dt_last_seen')
    #END
 
+    #IF( #TEXT(Input_dt_vendor_first_reported)='' )
      '' 
    #ELSE
        IF( le.Input_dt_vendor_first_reported = (TYPEOF(le.Input_dt_vendor_first_reported))'','',':dt_vendor_first_reported')
    #END
 
+    #IF( #TEXT(Input_dt_vendor_last_reported)='' )
      '' 
    #ELSE
        IF( le.Input_dt_vendor_last_reported = (TYPEOF(le.Input_dt_vendor_last_reported))'','',':dt_vendor_last_reported')
    #END
 
+    #IF( #TEXT(Input_err_stat)='' )
      '' 
    #ELSE
        IF( le.Input_err_stat = (TYPEOF(le.Input_err_stat))'','',':err_stat')
    #END
 
+    #IF( #TEXT(Input_fips_county)='' )
      '' 
    #ELSE
        IF( le.Input_fips_county = (TYPEOF(le.Input_fips_county))'','',':fips_county')
    #END
 
+    #IF( #TEXT(Input_fips_state)='' )
      '' 
    #ELSE
        IF( le.Input_fips_state = (TYPEOF(le.Input_fips_state))'','',':fips_state')
    #END
 
+    #IF( #TEXT(Input_franchisee_id)='' )
      '' 
    #ELSE
        IF( le.Input_franchisee_id = (TYPEOF(le.Input_franchisee_id))'','',':franchisee_id')
    #END
 
+    #IF( #TEXT(Input_fruns)='' )
      '' 
    #ELSE
        IF( le.Input_fruns = (TYPEOF(le.Input_fruns))'','',':fruns')
    #END
 
+    #IF( #TEXT(Input_f_units)='' )
      '' 
    #ELSE
        IF( le.Input_f_units = (TYPEOF(le.Input_f_units))'','',':f_units')
    #END
 
+    #IF( #TEXT(Input_industry)='' )
      '' 
    #ELSE
        IF( le.Input_industry = (TYPEOF(le.Input_industry))'','',':industry')
    #END
 
+    #IF( #TEXT(Input_industry_type)='' )
      '' 
    #ELSE
        IF( le.Input_industry_type = (TYPEOF(le.Input_industry_type))'','',':industry_type')
    #END
 
+    #IF( #TEXT(Input_p_city_name)='' )
      '' 
    #ELSE
        IF( le.Input_p_city_name = (TYPEOF(le.Input_p_city_name))'','',':p_city_name')
    #END
 
+    #IF( #TEXT(Input_phone)='' )
      '' 
    #ELSE
        IF( le.Input_phone = (TYPEOF(le.Input_phone))'','',':phone')
    #END
 
+    #IF( #TEXT(Input_phone_extension)='' )
      '' 
    #ELSE
        IF( le.Input_phone_extension = (TYPEOF(le.Input_phone_extension))'','',':phone_extension')
    #END
 
+    #IF( #TEXT(Input_prim_name)='' )
      '' 
    #ELSE
        IF( le.Input_prim_name = (TYPEOF(le.Input_prim_name))'','',':prim_name')
    #END
 
+    #IF( #TEXT(Input_record_id)='' )
      '' 
    #ELSE
        IF( le.Input_record_id = (TYPEOF(le.Input_record_id))'','',':record_id')
    #END
 
+    #IF( #TEXT(Input_record_type)='' )
      '' 
    #ELSE
        IF( le.Input_record_type = (TYPEOF(le.Input_record_type))'','',':record_type')
    #END
 
+    #IF( #TEXT(Input_relationship_code)='' )
      '' 
    #ELSE
        IF( le.Input_relationship_code = (TYPEOF(le.Input_relationship_code))'','',':relationship_code')
    #END
 
+    #IF( #TEXT(Input_relationship_code_exp)='' )
      '' 
    #ELSE
        IF( le.Input_relationship_code_exp = (TYPEOF(le.Input_relationship_code_exp))'','',':relationship_code_exp')
    #END
 
+    #IF( #TEXT(Input_secondary_phone)='' )
      '' 
    #ELSE
        IF( le.Input_secondary_phone = (TYPEOF(le.Input_secondary_phone))'','',':secondary_phone')
    #END
 
+    #IF( #TEXT(Input_sector)='' )
      '' 
    #ELSE
        IF( le.Input_sector = (TYPEOF(le.Input_sector))'','',':sector')
    #END
 
+    #IF( #TEXT(Input_sic_code)='' )
      '' 
    #ELSE
        IF( le.Input_sic_code = (TYPEOF(le.Input_sic_code))'','',':sic_code')
    #END
 
+    #IF( #TEXT(Input_state)='' )
      '' 
    #ELSE
        IF( le.Input_state = (TYPEOF(le.Input_state))'','',':state')
    #END
 
+    #IF( #TEXT(Input_unit_flag)='' )
      '' 
    #ELSE
        IF( le.Input_unit_flag = (TYPEOF(le.Input_unit_flag))'','',':unit_flag')
    #END
 
+    #IF( #TEXT(Input_unit_flag_exp)='' )
      '' 
    #ELSE
        IF( le.Input_unit_flag_exp = (TYPEOF(le.Input_unit_flag_exp))'','',':unit_flag_exp')
    #END
 
+    #IF( #TEXT(Input_v_city_name)='' )
      '' 
    #ELSE
        IF( le.Input_v_city_name = (TYPEOF(le.Input_v_city_name))'','',':v_city_name')
    #END
 
+    #IF( #TEXT(Input_zip_code)='' )
      '' 
    #ELSE
        IF( le.Input_zip_code = (TYPEOF(le.Input_zip_code))'','',':zip_code')
    #END
 
+    #IF( #TEXT(Input_zip_code4)='' )
      '' 
    #ELSE
        IF( le.Input_zip_code4 = (TYPEOF(le.Input_zip_code4))'','',':zip_code4')
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
