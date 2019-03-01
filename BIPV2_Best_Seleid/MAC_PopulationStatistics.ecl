EXPORT MAC_PopulationStatistics(infile,Ref='',source_for_votes='',Input_dt_first_seen = '',Input_dt_last_seen = '',Input_source_for_votes = '',Input_company_name = '',Input_company_fein = '',Input_company_phone = '',Input_company_url = '',Input_duns_number = '',Input_company_sic_code1 = '',Input_company_naics_code1 = '',Input_prim_range = '',Input_predir = '',Input_prim_name = '',Input_addr_suffix = '',Input_postdir = '',Input_unit_desig = '',Input_sec_range = '',Input_p_city_name = '',Input_v_city_name = '',Input_st = '',Input_zip = '',Input_zip4 = '',Input_fips_state = '',Input_fips_county = '',Input_address = '',OutFile) := MACRO
  IMPORT SALT30,BIPV2_Best_Seleid;
  #uniquename(of)
  %of% := RECORD
    #IF (#TEXT(source_for_votes)<>'')
    SALT30.StrType source;
    #END
    SALT30.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_dt_first_seen)='' )
      ''
    #ELSE
        IF( le.Input_dt_first_seen = (TYPEOF(le.Input_dt_first_seen))'','',':dt_first_seen')
    #END
+    #IF( #TEXT(Input_dt_last_seen)='' )
      ''
    #ELSE
        IF( le.Input_dt_last_seen = (TYPEOF(le.Input_dt_last_seen))'','',':dt_last_seen')
    #END
+    #IF( #TEXT(Input_source_for_votes)='' )
      ''
    #ELSE
        IF( le.Input_source_for_votes = (TYPEOF(le.Input_source_for_votes))'','',':source_for_votes')
    #END
+    #IF( #TEXT(Input_company_name)='' )
      ''
    #ELSE
        IF( le.Input_company_name = (TYPEOF(le.Input_company_name))'','',':company_name')
    #END
+    #IF( #TEXT(Input_company_fein)='' )
      ''
    #ELSE
        IF( le.Input_company_fein = (TYPEOF(le.Input_company_fein))'','',':company_fein')
    #END
+    #IF( #TEXT(Input_company_phone)='' )
      ''
    #ELSE
        IF( le.Input_company_phone = (TYPEOF(le.Input_company_phone))'','',':company_phone')
    #END
+    #IF( #TEXT(Input_company_url)='' )
      ''
    #ELSE
        IF( le.Input_company_url = (TYPEOF(le.Input_company_url))'','',':company_url')
    #END
+    #IF( #TEXT(Input_duns_number)='' )
      ''
    #ELSE
        IF( le.Input_duns_number = (TYPEOF(le.Input_duns_number))'','',':duns_number')
    #END
+    #IF( #TEXT(Input_company_sic_code1)='' )
      ''
    #ELSE
        IF( le.Input_company_sic_code1 = (TYPEOF(le.Input_company_sic_code1))'','',':company_sic_code1')
    #END
+    #IF( #TEXT(Input_company_naics_code1)='' )
      ''
    #ELSE
        IF( le.Input_company_naics_code1 = (TYPEOF(le.Input_company_naics_code1))'','',':company_naics_code1')
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
+    #IF( #TEXT(Input_unit_desig)='' )
      ''
    #ELSE
        IF( le.Input_unit_desig = (TYPEOF(le.Input_unit_desig))'','',':unit_desig')
    #END
+    #IF( #TEXT(Input_sec_range)='' )
      ''
    #ELSE
        IF( le.Input_sec_range = (TYPEOF(le.Input_sec_range))'','',':sec_range')
    #END
+    #IF( #TEXT(Input_p_city_name)='' )
      ''
    #ELSE
        IF( le.Input_p_city_name = (TYPEOF(le.Input_p_city_name))'','',':p_city_name')
    #END
+    #IF( #TEXT(Input_v_city_name)='' )
      ''
    #ELSE
        IF( le.Input_v_city_name = (TYPEOF(le.Input_v_city_name))'','',':v_city_name')
    #END
+    #IF( #TEXT(Input_st)='' )
      ''
    #ELSE
        IF( le.Input_st = (TYPEOF(le.Input_st))'','',':st')
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
+    #IF( #TEXT(Input_fips_state)='' )
      ''
    #ELSE
        IF( le.Input_fips_state = (TYPEOF(le.Input_fips_state))'','',':fips_state')
    #END
+    #IF( #TEXT(Input_fips_county)='' )
      ''
    #ELSE
        IF( le.Input_fips_county = (TYPEOF(le.Input_fips_county))'','',':fips_county')
    #END
+    #IF( #TEXT(Input_address)='' )
      ''
    #ELSE
        IF( le.Input_address = (TYPEOF(le.Input_address))'','',':address')
    #END
;
    #IF (#TEXT(source_for_votes)<>'')
    SELF.source := le.source_for_votes;
    #END
  END;
  #uniquename(op)
  %op% := PROJECT(infile,%ot%(LEFT));
  #uniquename(ort)
  %ort% := RECORD
    #IF (#TEXT(source_for_votes)<>'')
    %op%.source;
    #END
    %op%.fields;
    UNSIGNED cnt := COUNT(GROUP);
  END;
  outfile := TOPN( TABLE( %op%, %ort%,#IF( #TEXT(source_for_votes)<>'' ) source, #END fields, FEW ), 1000,#IF( #TEXT(source_for_votes)<>'' ) source, #END -cnt );
ENDMACRO;