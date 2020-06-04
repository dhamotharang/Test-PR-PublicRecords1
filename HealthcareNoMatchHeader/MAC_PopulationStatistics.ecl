 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_nomatch_id = '',Input_rid = '',Input_lexid = '',Input_lexid_score = '',Input_guardian_lexid = '',Input_guardian_lexid_score = '',Input_crk = '',Input_src = '',Input_source_rid = '',Input_dt_first_seen = '',Input_dt_last_seen = '',Input_dt_vendor_first_reported = '',Input_dt_vendor_last_reported = '',Input_member_id = '',Input_customer_id = '',Input_account_id = '',Input_subscriber_id = '',Input_group_id = '',Input_relationship_code = '',Input_title = '',Input_fname = '',Input_mname = '',Input_lname = '',Input_suffix = '',Input_input_full_name = '',Input_dob = '',Input_gender = '',Input_ssn = '',Input_home_phone = '',Input_alt_phone = '',Input_primary_email_address = '',Input_prim_range = '',Input_predir = '',Input_prim_name = '',Input_addr_suffix = '',Input_postdir = '',Input_unit_desig = '',Input_sec_range = '',Input_city_name = '',Input_st = '',Input_zip = '',Input_zip4 = '',Input_rec_type = '',Input_county = '',Input_geo_lat = '',Input_geo_long = '',Input_msa = '',Input_geo_blk = '',Input_geo_match = '',Input_err_stat = '',Input_guardian_fname = '',Input_guardian_mname = '',Input_guardian_lname = '',Input_guardian_dob = '',Input_guardian_ssn = '',Input_udf1 = '',Input_udf2 = '',Input_udf3 = '',Input_persistent_rid = '',Input_global_sid = '',Input_record_sid = '',OutFile) := MACRO
  IMPORT SALT311,HealthcareNoMatchHeader;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_nomatch_id)='' )
      '' 
    #ELSE
        IF( le.Input_nomatch_id = (TYPEOF(le.Input_nomatch_id))'','',':nomatch_id')
    #END
 
+    #IF( #TEXT(Input_rid)='' )
      '' 
    #ELSE
        IF( le.Input_rid = (TYPEOF(le.Input_rid))'','',':rid')
    #END
 
+    #IF( #TEXT(Input_lexid)='' )
      '' 
    #ELSE
        IF( le.Input_lexid = (TYPEOF(le.Input_lexid))'','',':lexid')
    #END
 
+    #IF( #TEXT(Input_lexid_score)='' )
      '' 
    #ELSE
        IF( le.Input_lexid_score = (TYPEOF(le.Input_lexid_score))'','',':lexid_score')
    #END
 
+    #IF( #TEXT(Input_guardian_lexid)='' )
      '' 
    #ELSE
        IF( le.Input_guardian_lexid = (TYPEOF(le.Input_guardian_lexid))'','',':guardian_lexid')
    #END
 
+    #IF( #TEXT(Input_guardian_lexid_score)='' )
      '' 
    #ELSE
        IF( le.Input_guardian_lexid_score = (TYPEOF(le.Input_guardian_lexid_score))'','',':guardian_lexid_score')
    #END
 
+    #IF( #TEXT(Input_crk)='' )
      '' 
    #ELSE
        IF( le.Input_crk = (TYPEOF(le.Input_crk))'','',':crk')
    #END
 
+    #IF( #TEXT(Input_src)='' )
      '' 
    #ELSE
        IF( le.Input_src = (TYPEOF(le.Input_src))'','',':src')
    #END
 
+    #IF( #TEXT(Input_source_rid)='' )
      '' 
    #ELSE
        IF( le.Input_source_rid = (TYPEOF(le.Input_source_rid))'','',':source_rid')
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
 
+    #IF( #TEXT(Input_member_id)='' )
      '' 
    #ELSE
        IF( le.Input_member_id = (TYPEOF(le.Input_member_id))'','',':member_id')
    #END
 
+    #IF( #TEXT(Input_customer_id)='' )
      '' 
    #ELSE
        IF( le.Input_customer_id = (TYPEOF(le.Input_customer_id))'','',':customer_id')
    #END
 
+    #IF( #TEXT(Input_account_id)='' )
      '' 
    #ELSE
        IF( le.Input_account_id = (TYPEOF(le.Input_account_id))'','',':account_id')
    #END
 
+    #IF( #TEXT(Input_subscriber_id)='' )
      '' 
    #ELSE
        IF( le.Input_subscriber_id = (TYPEOF(le.Input_subscriber_id))'','',':subscriber_id')
    #END
 
+    #IF( #TEXT(Input_group_id)='' )
      '' 
    #ELSE
        IF( le.Input_group_id = (TYPEOF(le.Input_group_id))'','',':group_id')
    #END
 
+    #IF( #TEXT(Input_relationship_code)='' )
      '' 
    #ELSE
        IF( le.Input_relationship_code = (TYPEOF(le.Input_relationship_code))'','',':relationship_code')
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
 
+    #IF( #TEXT(Input_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_suffix = (TYPEOF(le.Input_suffix))'','',':suffix')
    #END
 
+    #IF( #TEXT(Input_input_full_name)='' )
      '' 
    #ELSE
        IF( le.Input_input_full_name = (TYPEOF(le.Input_input_full_name))'','',':input_full_name')
    #END
 
+    #IF( #TEXT(Input_dob)='' )
      '' 
    #ELSE
        IF( le.Input_dob = (TYPEOF(le.Input_dob))'','',':dob')
    #END
 
+    #IF( #TEXT(Input_gender)='' )
      '' 
    #ELSE
        IF( le.Input_gender = (TYPEOF(le.Input_gender))'','',':gender')
    #END
 
+    #IF( #TEXT(Input_ssn)='' )
      '' 
    #ELSE
        IF( le.Input_ssn = (TYPEOF(le.Input_ssn))'','',':ssn')
    #END
 
+    #IF( #TEXT(Input_home_phone)='' )
      '' 
    #ELSE
        IF( le.Input_home_phone = (TYPEOF(le.Input_home_phone))'','',':home_phone')
    #END
 
+    #IF( #TEXT(Input_alt_phone)='' )
      '' 
    #ELSE
        IF( le.Input_alt_phone = (TYPEOF(le.Input_alt_phone))'','',':alt_phone')
    #END
 
+    #IF( #TEXT(Input_primary_email_address)='' )
      '' 
    #ELSE
        IF( le.Input_primary_email_address = (TYPEOF(le.Input_primary_email_address))'','',':primary_email_address')
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
 
+    #IF( #TEXT(Input_rec_type)='' )
      '' 
    #ELSE
        IF( le.Input_rec_type = (TYPEOF(le.Input_rec_type))'','',':rec_type')
    #END
 
+    #IF( #TEXT(Input_county)='' )
      '' 
    #ELSE
        IF( le.Input_county = (TYPEOF(le.Input_county))'','',':county')
    #END
 
+    #IF( #TEXT(Input_geo_lat)='' )
      '' 
    #ELSE
        IF( le.Input_geo_lat = (TYPEOF(le.Input_geo_lat))'','',':geo_lat')
    #END
 
+    #IF( #TEXT(Input_geo_long)='' )
      '' 
    #ELSE
        IF( le.Input_geo_long = (TYPEOF(le.Input_geo_long))'','',':geo_long')
    #END
 
+    #IF( #TEXT(Input_msa)='' )
      '' 
    #ELSE
        IF( le.Input_msa = (TYPEOF(le.Input_msa))'','',':msa')
    #END
 
+    #IF( #TEXT(Input_geo_blk)='' )
      '' 
    #ELSE
        IF( le.Input_geo_blk = (TYPEOF(le.Input_geo_blk))'','',':geo_blk')
    #END
 
+    #IF( #TEXT(Input_geo_match)='' )
      '' 
    #ELSE
        IF( le.Input_geo_match = (TYPEOF(le.Input_geo_match))'','',':geo_match')
    #END
 
+    #IF( #TEXT(Input_err_stat)='' )
      '' 
    #ELSE
        IF( le.Input_err_stat = (TYPEOF(le.Input_err_stat))'','',':err_stat')
    #END
 
+    #IF( #TEXT(Input_guardian_fname)='' )
      '' 
    #ELSE
        IF( le.Input_guardian_fname = (TYPEOF(le.Input_guardian_fname))'','',':guardian_fname')
    #END
 
+    #IF( #TEXT(Input_guardian_mname)='' )
      '' 
    #ELSE
        IF( le.Input_guardian_mname = (TYPEOF(le.Input_guardian_mname))'','',':guardian_mname')
    #END
 
+    #IF( #TEXT(Input_guardian_lname)='' )
      '' 
    #ELSE
        IF( le.Input_guardian_lname = (TYPEOF(le.Input_guardian_lname))'','',':guardian_lname')
    #END
 
+    #IF( #TEXT(Input_guardian_dob)='' )
      '' 
    #ELSE
        IF( le.Input_guardian_dob = (TYPEOF(le.Input_guardian_dob))'','',':guardian_dob')
    #END
 
+    #IF( #TEXT(Input_guardian_ssn)='' )
      '' 
    #ELSE
        IF( le.Input_guardian_ssn = (TYPEOF(le.Input_guardian_ssn))'','',':guardian_ssn')
    #END
 
+    #IF( #TEXT(Input_udf1)='' )
      '' 
    #ELSE
        IF( le.Input_udf1 = (TYPEOF(le.Input_udf1))'','',':udf1')
    #END
 
+    #IF( #TEXT(Input_udf2)='' )
      '' 
    #ELSE
        IF( le.Input_udf2 = (TYPEOF(le.Input_udf2))'','',':udf2')
    #END
 
+    #IF( #TEXT(Input_udf3)='' )
      '' 
    #ELSE
        IF( le.Input_udf3 = (TYPEOF(le.Input_udf3))'','',':udf3')
    #END
 
+    #IF( #TEXT(Input_persistent_rid)='' )
      '' 
    #ELSE
        IF( le.Input_persistent_rid = (TYPEOF(le.Input_persistent_rid))'','',':persistent_rid')
    #END
 
+    #IF( #TEXT(Input_global_sid)='' )
      '' 
    #ELSE
        IF( le.Input_global_sid = (TYPEOF(le.Input_global_sid))'','',':global_sid')
    #END
 
+    #IF( #TEXT(Input_record_sid)='' )
      '' 
    #ELSE
        IF( le.Input_record_sid = (TYPEOF(le.Input_record_sid))'','',':record_sid')
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
