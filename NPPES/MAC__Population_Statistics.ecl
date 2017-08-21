export MAC__Population_Statistics(infile,Ref='',Input_did = '',Input_src = '',Input_dt_first_seen = '',Input_dt_last_seen = '',Input_dt_vendor_first_reported = '',Input_dt_vendor_last_reported = '',Input_vendor_id = '',Input_phone = '',Input_title = '',Input_fname = '',Input_mname = '',Input_lname = '',Input_name_suffix = '',Input_prim_range = '',Input_predir = '',Input_prim_name = '',Input_suffix = '',Input_postdir = '',Input_unit_desig = '',Input_sec_range = '',Input_city_name = '',Input_st = '',Input_zip = '',Input_zip4 = '',Input_county = '',Input_msa = '',Input_geo_blk = '',Input_RawAID = '',OutFile) := MACRO
  #uniquename(of)
  %of% := record
    string512 fields;
  end;
  #uniquename(ot)
  %of% %ot%(infile le) := transform
    self.fields :=
    #IF( #TEXT(Input_did)='' )
      '' 
    #ELSE
        IF( le.Input_did = (typeof(le.Input_did))'','',':did')
    #END
+
    #IF( #TEXT(Input_src)='' )
      '' 
    #ELSE
        IF( le.Input_src = (typeof(le.Input_src))'','',':src')
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
    #IF( #TEXT(Input_vendor_id)='' )
      '' 
    #ELSE
        IF( le.Input_vendor_id = (typeof(le.Input_vendor_id))'','',':vendor_id')
    #END
+
    #IF( #TEXT(Input_phone)='' )
      '' 
    #ELSE
        IF( le.Input_phone = (typeof(le.Input_phone))'','',':phone')
    #END
+
    #IF( #TEXT(Input_title)='' )
      '' 
    #ELSE
        IF( le.Input_title = (typeof(le.Input_title))'','',':title')
    #END
+
    #IF( #TEXT(Input_fname)='' )
      '' 
    #ELSE
        IF( le.Input_fname = (typeof(le.Input_fname))'','',':fname')
    #END
+
    #IF( #TEXT(Input_mname)='' )
      '' 
    #ELSE
        IF( le.Input_mname = (typeof(le.Input_mname))'','',':mname')
    #END
+
    #IF( #TEXT(Input_lname)='' )
      '' 
    #ELSE
        IF( le.Input_lname = (typeof(le.Input_lname))'','',':lname')
    #END
+
    #IF( #TEXT(Input_name_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_name_suffix = (typeof(le.Input_name_suffix))'','',':name_suffix')
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
    #IF( #TEXT(Input_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_suffix = (typeof(le.Input_suffix))'','',':suffix')
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
    #IF( #TEXT(Input_city_name)='' )
      '' 
    #ELSE
        IF( le.Input_city_name = (typeof(le.Input_city_name))'','',':city_name')
    #END
+
    #IF( #TEXT(Input_st)='' )
      '' 
    #ELSE
        IF( le.Input_st = (typeof(le.Input_st))'','',':st')
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
    #IF( #TEXT(Input_geo_blk)='' )
      '' 
    #ELSE
        IF( le.Input_geo_blk = (typeof(le.Input_geo_blk))'','',':geo_blk')
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
