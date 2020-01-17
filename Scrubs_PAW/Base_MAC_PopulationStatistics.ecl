 
EXPORT Base_MAC_PopulationStatistics(infile,Ref='',Input_contact_id = '',Input_company_phone = '',Input_company_name = '',Input_active_phone_flag = '',Input_source_count = '',Input_source = '',Input_record_type = '',Input_record_sid = '',Input_global_sid = '',Input_GLB = '',Input_lname = '',Input_fname = '',Input_dt_last_seen = '',Input_dt_first_seen = '',Input_RawAid = '',Input_zip = '',Input_state = '',Input_bdid = '',Input_zip4 = '',Input_geo_long = '',Input_geo_lat = '',Input_county = '',Input_company_zip = '',Input_company_state = '',Input_Company_RawAid = '',Input_company_zip4 = '',Input_msa = '',Input_did = '',Input_ssn = '',Input_phone = '',Input_predir = '',Input_company_predir = '',Input_company_postdir = '',Input_postdir = '',Input_from_hdr = '',Input_dead_flag = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_PAW;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_contact_id)='' )
      '' 
    #ELSE
        IF( le.Input_contact_id = (TYPEOF(le.Input_contact_id))'','',':contact_id')
    #END
 
+    #IF( #TEXT(Input_company_phone)='' )
      '' 
    #ELSE
        IF( le.Input_company_phone = (TYPEOF(le.Input_company_phone))'','',':company_phone')
    #END
 
+    #IF( #TEXT(Input_company_name)='' )
      '' 
    #ELSE
        IF( le.Input_company_name = (TYPEOF(le.Input_company_name))'','',':company_name')
    #END
 
+    #IF( #TEXT(Input_active_phone_flag)='' )
      '' 
    #ELSE
        IF( le.Input_active_phone_flag = (TYPEOF(le.Input_active_phone_flag))'','',':active_phone_flag')
    #END
 
+    #IF( #TEXT(Input_source_count)='' )
      '' 
    #ELSE
        IF( le.Input_source_count = (TYPEOF(le.Input_source_count))'','',':source_count')
    #END
 
+    #IF( #TEXT(Input_source)='' )
      '' 
    #ELSE
        IF( le.Input_source = (TYPEOF(le.Input_source))'','',':source')
    #END
 
+    #IF( #TEXT(Input_record_type)='' )
      '' 
    #ELSE
        IF( le.Input_record_type = (TYPEOF(le.Input_record_type))'','',':record_type')
    #END
 
+    #IF( #TEXT(Input_record_sid)='' )
      '' 
    #ELSE
        IF( le.Input_record_sid = (TYPEOF(le.Input_record_sid))'','',':record_sid')
    #END
 
+    #IF( #TEXT(Input_global_sid)='' )
      '' 
    #ELSE
        IF( le.Input_global_sid = (TYPEOF(le.Input_global_sid))'','',':global_sid')
    #END
 
+    #IF( #TEXT(Input_GLB)='' )
      '' 
    #ELSE
        IF( le.Input_GLB = (TYPEOF(le.Input_GLB))'','',':GLB')
    #END
 
+    #IF( #TEXT(Input_lname)='' )
      '' 
    #ELSE
        IF( le.Input_lname = (TYPEOF(le.Input_lname))'','',':lname')
    #END
 
+    #IF( #TEXT(Input_fname)='' )
      '' 
    #ELSE
        IF( le.Input_fname = (TYPEOF(le.Input_fname))'','',':fname')
    #END
 
+    #IF( #TEXT(Input_dt_last_seen)='' )
      '' 
    #ELSE
        IF( le.Input_dt_last_seen = (TYPEOF(le.Input_dt_last_seen))'','',':dt_last_seen')
    #END
 
+    #IF( #TEXT(Input_dt_first_seen)='' )
      '' 
    #ELSE
        IF( le.Input_dt_first_seen = (TYPEOF(le.Input_dt_first_seen))'','',':dt_first_seen')
    #END
 
+    #IF( #TEXT(Input_RawAid)='' )
      '' 
    #ELSE
        IF( le.Input_RawAid = (TYPEOF(le.Input_RawAid))'','',':RawAid')
    #END
 
+    #IF( #TEXT(Input_zip)='' )
      '' 
    #ELSE
        IF( le.Input_zip = (TYPEOF(le.Input_zip))'','',':zip')
    #END
 
+    #IF( #TEXT(Input_state)='' )
      '' 
    #ELSE
        IF( le.Input_state = (TYPEOF(le.Input_state))'','',':state')
    #END
 
+    #IF( #TEXT(Input_bdid)='' )
      '' 
    #ELSE
        IF( le.Input_bdid = (TYPEOF(le.Input_bdid))'','',':bdid')
    #END
 
+    #IF( #TEXT(Input_zip4)='' )
      '' 
    #ELSE
        IF( le.Input_zip4 = (TYPEOF(le.Input_zip4))'','',':zip4')
    #END
 
+    #IF( #TEXT(Input_geo_long)='' )
      '' 
    #ELSE
        IF( le.Input_geo_long = (TYPEOF(le.Input_geo_long))'','',':geo_long')
    #END
 
+    #IF( #TEXT(Input_geo_lat)='' )
      '' 
    #ELSE
        IF( le.Input_geo_lat = (TYPEOF(le.Input_geo_lat))'','',':geo_lat')
    #END
 
+    #IF( #TEXT(Input_county)='' )
      '' 
    #ELSE
        IF( le.Input_county = (TYPEOF(le.Input_county))'','',':county')
    #END
 
+    #IF( #TEXT(Input_company_zip)='' )
      '' 
    #ELSE
        IF( le.Input_company_zip = (TYPEOF(le.Input_company_zip))'','',':company_zip')
    #END
 
+    #IF( #TEXT(Input_company_state)='' )
      '' 
    #ELSE
        IF( le.Input_company_state = (TYPEOF(le.Input_company_state))'','',':company_state')
    #END
 
+    #IF( #TEXT(Input_Company_RawAid)='' )
      '' 
    #ELSE
        IF( le.Input_Company_RawAid = (TYPEOF(le.Input_Company_RawAid))'','',':Company_RawAid')
    #END
 
+    #IF( #TEXT(Input_company_zip4)='' )
      '' 
    #ELSE
        IF( le.Input_company_zip4 = (TYPEOF(le.Input_company_zip4))'','',':company_zip4')
    #END
 
+    #IF( #TEXT(Input_msa)='' )
      '' 
    #ELSE
        IF( le.Input_msa = (TYPEOF(le.Input_msa))'','',':msa')
    #END
 
+    #IF( #TEXT(Input_did)='' )
      '' 
    #ELSE
        IF( le.Input_did = (TYPEOF(le.Input_did))'','',':did')
    #END
 
+    #IF( #TEXT(Input_ssn)='' )
      '' 
    #ELSE
        IF( le.Input_ssn = (TYPEOF(le.Input_ssn))'','',':ssn')
    #END
 
+    #IF( #TEXT(Input_phone)='' )
      '' 
    #ELSE
        IF( le.Input_phone = (TYPEOF(le.Input_phone))'','',':phone')
    #END
 
+    #IF( #TEXT(Input_predir)='' )
      '' 
    #ELSE
        IF( le.Input_predir = (TYPEOF(le.Input_predir))'','',':predir')
    #END
 
+    #IF( #TEXT(Input_company_predir)='' )
      '' 
    #ELSE
        IF( le.Input_company_predir = (TYPEOF(le.Input_company_predir))'','',':company_predir')
    #END
 
+    #IF( #TEXT(Input_company_postdir)='' )
      '' 
    #ELSE
        IF( le.Input_company_postdir = (TYPEOF(le.Input_company_postdir))'','',':company_postdir')
    #END
 
+    #IF( #TEXT(Input_postdir)='' )
      '' 
    #ELSE
        IF( le.Input_postdir = (TYPEOF(le.Input_postdir))'','',':postdir')
    #END
 
+    #IF( #TEXT(Input_from_hdr)='' )
      '' 
    #ELSE
        IF( le.Input_from_hdr = (TYPEOF(le.Input_from_hdr))'','',':from_hdr')
    #END
 
+    #IF( #TEXT(Input_dead_flag)='' )
      '' 
    #ELSE
        IF( le.Input_dead_flag = (TYPEOF(le.Input_dead_flag))'','',':dead_flag')
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
