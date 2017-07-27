EXPORT MAC_PopulationStatistics(infile,Ref='',Input_dt_first_seen = '',Input_dt_last_seen = '',Input_source = '',Input_company_name = '',Input_company_fein = '',Input_company_phone = '',Input_company_url = '',Input_company_prim_range = '',Input_company_predir = '',Input_company_prim_name = '',Input_company_addr_suffix = '',Input_company_postdir = '',Input_company_unit_desig = '',Input_company_sec_range = '',Input_company_p_city_name = '',Input_company_v_city_name = '',Input_company_st = '',Input_company_zip5 = '',Input_company_zip4 = '',Input_company_csz = '',Input_company_addr1 = '',Input_company_address = '',OutFile) := MACRO
  IMPORT SALT24,BIPV2_Best;
  #uniquename(of)
  %of% := RECORD
    SALT24.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_dt_first_seen)='' )
      '' 
    #ELSE
        IF( le.Input_dt_first_seen = (typeof(le.Input_dt_first_seen))'','',':dt_first_seen')
    #END
+
    #IF( #TEXT(Input_dt_last_seen)='' )
      '' 
    #ELSE
        IF( le.Input_dt_last_seen = (typeof(le.Input_dt_last_seen))'','',':dt_last_seen')
    #END
+
    #IF( #TEXT(Input_source)='' )
      '' 
    #ELSE
        IF( le.Input_source = (typeof(le.Input_source))'','',':source')
    #END
+
    #IF( #TEXT(Input_company_name)='' )
      '' 
    #ELSE
        IF( le.Input_company_name = (typeof(le.Input_company_name))'','',':company_name')
    #END
+
    #IF( #TEXT(Input_company_fein)='' )
      '' 
    #ELSE
        IF( le.Input_company_fein = (typeof(le.Input_company_fein))'','',':company_fein')
    #END
+
    #IF( #TEXT(Input_company_phone)='' )
      '' 
    #ELSE
        IF( le.Input_company_phone = (typeof(le.Input_company_phone))'','',':company_phone')
    #END
+
    #IF( #TEXT(Input_company_url)='' )
      '' 
    #ELSE
        IF( le.Input_company_url = (typeof(le.Input_company_url))'','',':company_url')
    #END
+
    #IF( #TEXT(Input_company_prim_range)='' )
      '' 
    #ELSE
        IF( le.Input_company_prim_range = (typeof(le.Input_company_prim_range))'','',':company_prim_range')
    #END
+
    #IF( #TEXT(Input_company_predir)='' )
      '' 
    #ELSE
        IF( le.Input_company_predir = (typeof(le.Input_company_predir))'','',':company_predir')
    #END
+
    #IF( #TEXT(Input_company_prim_name)='' )
      '' 
    #ELSE
        IF( le.Input_company_prim_name = (typeof(le.Input_company_prim_name))'','',':company_prim_name')
    #END
+
    #IF( #TEXT(Input_company_addr_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_company_addr_suffix = (typeof(le.Input_company_addr_suffix))'','',':company_addr_suffix')
    #END
+
    #IF( #TEXT(Input_company_postdir)='' )
      '' 
    #ELSE
        IF( le.Input_company_postdir = (typeof(le.Input_company_postdir))'','',':company_postdir')
    #END
+
    #IF( #TEXT(Input_company_unit_desig)='' )
      '' 
    #ELSE
        IF( le.Input_company_unit_desig = (typeof(le.Input_company_unit_desig))'','',':company_unit_desig')
    #END
+
    #IF( #TEXT(Input_company_sec_range)='' )
      '' 
    #ELSE
        IF( le.Input_company_sec_range = (typeof(le.Input_company_sec_range))'','',':company_sec_range')
    #END
+
    #IF( #TEXT(Input_company_p_city_name)='' )
      '' 
    #ELSE
        IF( le.Input_company_p_city_name = (typeof(le.Input_company_p_city_name))'','',':company_p_city_name')
    #END
+
    #IF( #TEXT(Input_company_v_city_name)='' )
      '' 
    #ELSE
        IF( le.Input_company_v_city_name = (typeof(le.Input_company_v_city_name))'','',':company_v_city_name')
    #END
+
    #IF( #TEXT(Input_company_st)='' )
      '' 
    #ELSE
        IF( le.Input_company_st = (typeof(le.Input_company_st))'','',':company_st')
    #END
+
    #IF( #TEXT(Input_company_zip5)='' )
      '' 
    #ELSE
        IF( le.Input_company_zip5 = (typeof(le.Input_company_zip5))'','',':company_zip5')
    #END
+
    #IF( #TEXT(Input_company_zip4)='' )
      '' 
    #ELSE
        IF( le.Input_company_zip4 = (typeof(le.Input_company_zip4))'','',':company_zip4')
    #END
+
    #IF( #TEXT(Input_company_csz)='' )
      '' 
    #ELSE
        IF( le.Input_company_csz = (typeof(le.Input_company_csz))'','',':company_csz')
    #END
+
    #IF( #TEXT(Input_company_addr1)='' )
      '' 
    #ELSE
        IF( le.Input_company_addr1 = (typeof(le.Input_company_addr1))'','',':company_addr1')
    #END
+
    #IF( #TEXT(Input_company_address)='' )
      '' 
    #ELSE
        IF( le.Input_company_address = (typeof(le.Input_company_address))'','',':company_address')
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
