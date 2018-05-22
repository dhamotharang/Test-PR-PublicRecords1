 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_did = '',Input_rid = '',Input_pflag1 = '',Input_pflag2 = '',Input_pflag3 = '',Input_src = '',Input_dt_first_seen = '',Input_dt_last_seen = '',Input_dt_vendor_last_reported = '',Input_dt_vendor_first_reported = '',Input_dt_nonglb_last_seen = '',Input_rec_type = '',Input_vendor_id = '',Input_phone = '',Input_ssn = '',Input_dob = '',Input_title = '',Input_fname = '',Input_mname = '',Input_lname = '',Input_name_suffix = '',Input_prim_range = '',Input_predir = '',Input_prim_name = '',Input_suffix = '',Input_postdir = '',Input_unit_desig = '',Input_sec_range = '',Input_city_name = '',Input_st = '',Input_zip = '',Input_zip4 = '',Input_county = '',Input_geo_blk = '',Input_cbsa = '',Input_tnt = '',Input_valid_ssn = '',Input_jflag1 = '',Input_jflag2 = '',Input_jflag3 = '',Input_rawaid = '',Input_dodgy_tracking = '',Input_nid = '',Input_address_ind = '',Input_name_ind = '',Input_persistent_record_id = '',OutFile) := MACRO
  IMPORT SALT39,Scrubs_Headers_Monthly;
  #uniquename(of)
  %of% := RECORD
    SALT39.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_did)='' )
      '' 
    #ELSE
        IF( le.Input_did = (TYPEOF(le.Input_did))'','',':did')
    #END
 
+    #IF( #TEXT(Input_rid)='' )
      '' 
    #ELSE
        IF( le.Input_rid = (TYPEOF(le.Input_rid))'','',':rid')
    #END
 
+    #IF( #TEXT(Input_pflag1)='' )
      '' 
    #ELSE
        IF( le.Input_pflag1 = (TYPEOF(le.Input_pflag1))'','',':pflag1')
    #END
 
+    #IF( #TEXT(Input_pflag2)='' )
      '' 
    #ELSE
        IF( le.Input_pflag2 = (TYPEOF(le.Input_pflag2))'','',':pflag2')
    #END
 
+    #IF( #TEXT(Input_pflag3)='' )
      '' 
    #ELSE
        IF( le.Input_pflag3 = (TYPEOF(le.Input_pflag3))'','',':pflag3')
    #END
 
+    #IF( #TEXT(Input_src)='' )
      '' 
    #ELSE
        IF( le.Input_src = (TYPEOF(le.Input_src))'','',':src')
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
 
+    #IF( #TEXT(Input_dt_vendor_last_reported)='' )
      '' 
    #ELSE
        IF( le.Input_dt_vendor_last_reported = (TYPEOF(le.Input_dt_vendor_last_reported))'','',':dt_vendor_last_reported')
    #END
 
+    #IF( #TEXT(Input_dt_vendor_first_reported)='' )
      '' 
    #ELSE
        IF( le.Input_dt_vendor_first_reported = (TYPEOF(le.Input_dt_vendor_first_reported))'','',':dt_vendor_first_reported')
    #END
 
+    #IF( #TEXT(Input_dt_nonglb_last_seen)='' )
      '' 
    #ELSE
        IF( le.Input_dt_nonglb_last_seen = (TYPEOF(le.Input_dt_nonglb_last_seen))'','',':dt_nonglb_last_seen')
    #END
 
+    #IF( #TEXT(Input_rec_type)='' )
      '' 
    #ELSE
        IF( le.Input_rec_type = (TYPEOF(le.Input_rec_type))'','',':rec_type')
    #END
 
+    #IF( #TEXT(Input_vendor_id)='' )
      '' 
    #ELSE
        IF( le.Input_vendor_id = (TYPEOF(le.Input_vendor_id))'','',':vendor_id')
    #END
 
+    #IF( #TEXT(Input_phone)='' )
      '' 
    #ELSE
        IF( le.Input_phone = (TYPEOF(le.Input_phone))'','',':phone')
    #END
 
+    #IF( #TEXT(Input_ssn)='' )
      '' 
    #ELSE
        IF( le.Input_ssn = (TYPEOF(le.Input_ssn))'','',':ssn')
    #END
 
+    #IF( #TEXT(Input_dob)='' )
      '' 
    #ELSE
        IF( le.Input_dob = (TYPEOF(le.Input_dob))'','',':dob')
    #END
 
+    #IF( #TEXT(Input_title)='' )
      '' 
    #ELSE
        IF( le.Input_title = (TYPEOF(le.Input_title))'','',':title')
    #END
 
+    #IF( #TEXT(Input_fname)='' )
      '' 
    #ELSE
        IF( le.Input_fname = (TYPEOF(le.Input_fname))'','',':fname')
    #END
 
+    #IF( #TEXT(Input_mname)='' )
      '' 
    #ELSE
        IF( le.Input_mname = (TYPEOF(le.Input_mname))'','',':mname')
    #END
 
+    #IF( #TEXT(Input_lname)='' )
      '' 
    #ELSE
        IF( le.Input_lname = (TYPEOF(le.Input_lname))'','',':lname')
    #END
 
+    #IF( #TEXT(Input_name_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_name_suffix = (TYPEOF(le.Input_name_suffix))'','',':name_suffix')
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
 
+    #IF( #TEXT(Input_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_suffix = (TYPEOF(le.Input_suffix))'','',':suffix')
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
 
+    #IF( #TEXT(Input_city_name)='' )
      '' 
    #ELSE
        IF( le.Input_city_name = (TYPEOF(le.Input_city_name))'','',':city_name')
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
 
+    #IF( #TEXT(Input_county)='' )
      '' 
    #ELSE
        IF( le.Input_county = (TYPEOF(le.Input_county))'','',':county')
    #END
 
+    #IF( #TEXT(Input_geo_blk)='' )
      '' 
    #ELSE
        IF( le.Input_geo_blk = (TYPEOF(le.Input_geo_blk))'','',':geo_blk')
    #END
 
+    #IF( #TEXT(Input_cbsa)='' )
      '' 
    #ELSE
        IF( le.Input_cbsa = (TYPEOF(le.Input_cbsa))'','',':cbsa')
    #END
 
+    #IF( #TEXT(Input_tnt)='' )
      '' 
    #ELSE
        IF( le.Input_tnt = (TYPEOF(le.Input_tnt))'','',':tnt')
    #END
 
+    #IF( #TEXT(Input_valid_ssn)='' )
      '' 
    #ELSE
        IF( le.Input_valid_ssn = (TYPEOF(le.Input_valid_ssn))'','',':valid_ssn')
    #END
 
+    #IF( #TEXT(Input_jflag1)='' )
      '' 
    #ELSE
        IF( le.Input_jflag1 = (TYPEOF(le.Input_jflag1))'','',':jflag1')
    #END
 
+    #IF( #TEXT(Input_jflag2)='' )
      '' 
    #ELSE
        IF( le.Input_jflag2 = (TYPEOF(le.Input_jflag2))'','',':jflag2')
    #END
 
+    #IF( #TEXT(Input_jflag3)='' )
      '' 
    #ELSE
        IF( le.Input_jflag3 = (TYPEOF(le.Input_jflag3))'','',':jflag3')
    #END
 
+    #IF( #TEXT(Input_rawaid)='' )
      '' 
    #ELSE
        IF( le.Input_rawaid = (TYPEOF(le.Input_rawaid))'','',':rawaid')
    #END
 
+    #IF( #TEXT(Input_dodgy_tracking)='' )
      '' 
    #ELSE
        IF( le.Input_dodgy_tracking = (TYPEOF(le.Input_dodgy_tracking))'','',':dodgy_tracking')
    #END
 
+    #IF( #TEXT(Input_nid)='' )
      '' 
    #ELSE
        IF( le.Input_nid = (TYPEOF(le.Input_nid))'','',':nid')
    #END
 
+    #IF( #TEXT(Input_address_ind)='' )
      '' 
    #ELSE
        IF( le.Input_address_ind = (TYPEOF(le.Input_address_ind))'','',':address_ind')
    #END
 
+    #IF( #TEXT(Input_name_ind)='' )
      '' 
    #ELSE
        IF( le.Input_name_ind = (TYPEOF(le.Input_name_ind))'','',':name_ind')
    #END
 
+    #IF( #TEXT(Input_persistent_record_id)='' )
      '' 
    #ELSE
        IF( le.Input_persistent_record_id = (TYPEOF(le.Input_persistent_record_id))'','',':persistent_record_id')
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
