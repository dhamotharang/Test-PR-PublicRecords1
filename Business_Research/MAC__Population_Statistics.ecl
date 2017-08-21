export MAC__Population_Statistics(infile,Ref='',Input_rcid = '',Input_bdid = '',Input_source = '',Input_source_group = '',Input_pflag = '',Input_group1_id = '',Input_vendor_id = '',Input_dt_first_seen = '',Input_dt_last_seen = '',Input_dt_vendor_first_reported = '',Input_dt_vendor_last_reported = '',Input_company_name = '',Input_prim_range = '',Input_predir = '',Input_prim_name = '',Input_addr_suffix = '',Input_postdir = '',Input_unit_desig = '',Input_sec_range = '',Input_city = '',Input_state = '',Input_zip = '',Input_zip4 = '',Input_county = '',Input_msa = '',Input_geo_lat = '',Input_geo_long = '',Input_phone = '',Input_phone_score = '',Input_fein = '',Input_current = '',Input_dppa = '',Input_vl_id = '',Input_RawAID = '',OutFile) := MACRO
  #uniquename(of)
  %of% := record
    string512 fields;
  end;
  #uniquename(ot)
  %of% %ot%(infile le) := transform
    self.fields :=
    #IF( #TEXT(Input_rcid)='' )
      '' 
    #ELSE
        IF( le.Input_rcid = (typeof(le.Input_rcid))'','',':rcid')
    #END
+
    #IF( #TEXT(Input_bdid)='' )
      '' 
    #ELSE
        IF( le.Input_bdid = (typeof(le.Input_bdid))'','',':bdid')
    #END
+
    #IF( #TEXT(Input_source)='' )
      '' 
    #ELSE
        IF( le.Input_source = (typeof(le.Input_source))'','',':source')
    #END
+
    #IF( #TEXT(Input_source_group)='' )
      '' 
    #ELSE
        IF( le.Input_source_group = (typeof(le.Input_source_group))'','',':source_group')
    #END
+
    #IF( #TEXT(Input_pflag)='' )
      '' 
    #ELSE
        IF( le.Input_pflag = (typeof(le.Input_pflag))'','',':pflag')
    #END
+
    #IF( #TEXT(Input_group1_id)='' )
      '' 
    #ELSE
        IF( le.Input_group1_id = (typeof(le.Input_group1_id))'','',':group1_id')
    #END
+
    #IF( #TEXT(Input_vendor_id)='' )
      '' 
    #ELSE
        IF( le.Input_vendor_id = (typeof(le.Input_vendor_id))'','',':vendor_id')
    #END
+
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
    #IF( #TEXT(Input_dt_vendor_first_reported)='' )
      '' 
    #ELSE
        IF( le.Input_dt_vendor_first_reported = (typeof(le.Input_dt_vendor_first_reported))'','',':dt_vendor_first_reported')
    #END
+
    #IF( #TEXT(Input_dt_vendor_last_reported)='' )
      '' 
    #ELSE
        IF( le.Input_dt_vendor_last_reported = (typeof(le.Input_dt_vendor_last_reported))'','',':dt_vendor_last_reported')
    #END
+
    #IF( #TEXT(Input_company_name)='' )
      '' 
    #ELSE
        IF( le.Input_company_name = (typeof(le.Input_company_name))'','',':company_name')
    #END
+
    #IF( #TEXT(Input_prim_range)='' )
      '' 
    #ELSE
        IF( le.Input_prim_range = (typeof(le.Input_prim_range))'','',':prim_range')
    #END
+
    #IF( #TEXT(Input_predir)='' )
      '' 
    #ELSE
        IF( le.Input_predir = (typeof(le.Input_predir))'','',':predir')
    #END
+
    #IF( #TEXT(Input_prim_name)='' )
      '' 
    #ELSE
        IF( le.Input_prim_name = (typeof(le.Input_prim_name))'','',':prim_name')
    #END
+
    #IF( #TEXT(Input_addr_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_addr_suffix = (typeof(le.Input_addr_suffix))'','',':addr_suffix')
    #END
+
    #IF( #TEXT(Input_postdir)='' )
      '' 
    #ELSE
        IF( le.Input_postdir = (typeof(le.Input_postdir))'','',':postdir')
    #END
+
    #IF( #TEXT(Input_unit_desig)='' )
      '' 
    #ELSE
        IF( le.Input_unit_desig = (typeof(le.Input_unit_desig))'','',':unit_desig')
    #END
+
    #IF( #TEXT(Input_sec_range)='' )
      '' 
    #ELSE
        IF( le.Input_sec_range = (typeof(le.Input_sec_range))'','',':sec_range')
    #END
+
    #IF( #TEXT(Input_city)='' )
      '' 
    #ELSE
        IF( le.Input_city = (typeof(le.Input_city))'','',':city')
    #END
+
    #IF( #TEXT(Input_state)='' )
      '' 
    #ELSE
        IF( le.Input_state = (typeof(le.Input_state))'','',':state')
    #END
+
    #IF( #TEXT(Input_zip)='' )
      '' 
    #ELSE
        IF( le.Input_zip = (typeof(le.Input_zip))'','',':zip')
    #END
+
    #IF( #TEXT(Input_zip4)='' )
      '' 
    #ELSE
        IF( le.Input_zip4 = (typeof(le.Input_zip4))'','',':zip4')
    #END
+
    #IF( #TEXT(Input_county)='' )
      '' 
    #ELSE
        IF( le.Input_county = (typeof(le.Input_county))'','',':county')
    #END
+
    #IF( #TEXT(Input_msa)='' )
      '' 
    #ELSE
        IF( le.Input_msa = (typeof(le.Input_msa))'','',':msa')
    #END
+
    #IF( #TEXT(Input_geo_lat)='' )
      '' 
    #ELSE
        IF( le.Input_geo_lat = (typeof(le.Input_geo_lat))'','',':geo_lat')
    #END
+
    #IF( #TEXT(Input_geo_long)='' )
      '' 
    #ELSE
        IF( le.Input_geo_long = (typeof(le.Input_geo_long))'','',':geo_long')
    #END
+
    #IF( #TEXT(Input_phone)='' )
      '' 
    #ELSE
        IF( le.Input_phone = (typeof(le.Input_phone))'','',':phone')
    #END
+
    #IF( #TEXT(Input_phone_score)='' )
      '' 
    #ELSE
        IF( le.Input_phone_score = (typeof(le.Input_phone_score))'','',':phone_score')
    #END
+
    #IF( #TEXT(Input_fein)='' )
      '' 
    #ELSE
        IF( le.Input_fein = (typeof(le.Input_fein))'','',':fein')
    #END
+
    #IF( #TEXT(Input_current)='' )
      '' 
    #ELSE
        IF( le.Input_current = (typeof(le.Input_current))'','',':current')
    #END
+
    #IF( #TEXT(Input_dppa)='' )
      '' 
    #ELSE
        IF( le.Input_dppa = (typeof(le.Input_dppa))'','',':dppa')
    #END
+
    #IF( #TEXT(Input_vl_id)='' )
      '' 
    #ELSE
        IF( le.Input_vl_id = (typeof(le.Input_vl_id))'','',':vl_id')
    #END
+
    #IF( #TEXT(Input_RawAID)='' )
      '' 
    #ELSE
        IF( le.Input_RawAID = (typeof(le.Input_RawAID))'','',':RawAID')
    #END
;
  end;
  #uniquename(op)
  %op% := project(infile,%ot%(left));
  #uniquename(ort)
  %ort% := record
    %op%.fields;
    unsigned cnt := count(group);
  end;
  outfile := topn( table( %op%, %ort%, fields, few ), 1000, -cnt );
ENDMACRO;
