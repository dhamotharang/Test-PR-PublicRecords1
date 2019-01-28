 
EXPORT MAC_PopulationStatistics(infile,Ref='',cleancollegeid='',Input_cleanaddr1 = '',Input_cleanaddr2 = '',Input_cleanattendancedte = '',Input_cleancity = '',Input_cleanstate = '',Input_cleandob = '',Input_cleanupdatedte = '',Input_cleanemail = '',Input_append_email_username = '',Input_append_domain = '',Input_append_domain_type = '',Input_append_domain_root = '',Input_append_domain_ext = '',Input_append_is_tld_state = '',Input_append_is_tld_generic = '',Input_append_is_tld_country = '',Input_append_is_valid_domain_ext = '',Input_cleancollegeId = '',Input_cleantitle = '',Input_cleanfirstname = '',Input_cleanmidname = '',Input_cleanlastname = '',Input_cleansuffixname = '',Input_cleanzip = '',Input_cleanzip4 = '',Input_cleanmajor = '',Input_cleanphone = '',Input_rcid = '',Input_did = '',Input_process_date = '',Input_date_first_seen = '',Input_date_last_seen = '',Input_vendor_first_reported = '',Input_vendor_last_reported = '',Input_dateupdated = '',Input_studentid = '',Input_dartid = '',Input_collegeid = '',Input_projectsource = '',Input_collegestate = '',Input_college = '',Input_semester = '',Input_year = '',Input_firstname = '',Input_middlename = '',Input_lastname = '',Input_suffix = '',Input_major = '',Input_COLLEGE_MAJOR = '',Input_NEW_COLLEGE_MAJOR = '',Input_grade = '',Input_email = '',Input_dateofbirth = '',Input_dob_formatted = '',Input_attendancedate = '',Input_enrollmentstatus = '',Input_addresstype = '',Input_address1 = '',Input_address2 = '',Input_city = '',Input_state = '',Input_zip = '',Input_zip4 = '',Input_phonetyp = '',Input_phonenumber = '',Input_tier = '',Input_school_size_code = '',Input_competitive_code = '',Input_tuition_code = '',Input_title = '',Input_fname = '',Input_mname = '',Input_lname = '',Input_name_suffix = '',Input_name_score = '',Input_prim_range = '',Input_predir = '',Input_prim_name = '',Input_addr_suffix = '',Input_postdir = '',Input_unit_desig = '',Input_sec_range = '',Input_p_city_name = '',Input_v_city_name = '',Input_st = '',Input_z5 = '',Input_z4 = '',Input_cart = '',Input_cr_sort_sz = '',Input_lot = '',Input_lot_order = '',Input_dbpc = '',Input_chk_digit = '',Input_rec_type = '',Input_county = '',Input_fips_state = '',Input_fips_county = '',Input_geo_lat = '',Input_geo_long = '',Input_msa = '',Input_geo_blk = '',Input_geo_match = '',Input_err_stat = '',Input_telephone = '',Input_tier2 = '',Input_source = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_OKC_Student_List_V2;
  #uniquename(of)
  %of% := RECORD
    #IF (#TEXT(cleancollegeid)<>'')
    SALT311.StrType source;
    #END
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_cleanaddr1)='' )
      '' 
    #ELSE
        IF( le.Input_cleanaddr1 = (TYPEOF(le.Input_cleanaddr1))'','',':cleanaddr1')
    #END
 
+    #IF( #TEXT(Input_cleanaddr2)='' )
      '' 
    #ELSE
        IF( le.Input_cleanaddr2 = (TYPEOF(le.Input_cleanaddr2))'','',':cleanaddr2')
    #END
 
+    #IF( #TEXT(Input_cleanattendancedte)='' )
      '' 
    #ELSE
        IF( le.Input_cleanattendancedte = (TYPEOF(le.Input_cleanattendancedte))'','',':cleanattendancedte')
    #END
 
+    #IF( #TEXT(Input_cleancity)='' )
      '' 
    #ELSE
        IF( le.Input_cleancity = (TYPEOF(le.Input_cleancity))'','',':cleancity')
    #END
 
+    #IF( #TEXT(Input_cleanstate)='' )
      '' 
    #ELSE
        IF( le.Input_cleanstate = (TYPEOF(le.Input_cleanstate))'','',':cleanstate')
    #END
 
+    #IF( #TEXT(Input_cleandob)='' )
      '' 
    #ELSE
        IF( le.Input_cleandob = (TYPEOF(le.Input_cleandob))'','',':cleandob')
    #END
 
+    #IF( #TEXT(Input_cleanupdatedte)='' )
      '' 
    #ELSE
        IF( le.Input_cleanupdatedte = (TYPEOF(le.Input_cleanupdatedte))'','',':cleanupdatedte')
    #END
 
+    #IF( #TEXT(Input_cleanemail)='' )
      '' 
    #ELSE
        IF( le.Input_cleanemail = (TYPEOF(le.Input_cleanemail))'','',':cleanemail')
    #END
 
+    #IF( #TEXT(Input_append_email_username)='' )
      '' 
    #ELSE
        IF( le.Input_append_email_username = (TYPEOF(le.Input_append_email_username))'','',':append_email_username')
    #END
 
+    #IF( #TEXT(Input_append_domain)='' )
      '' 
    #ELSE
        IF( le.Input_append_domain = (TYPEOF(le.Input_append_domain))'','',':append_domain')
    #END
 
+    #IF( #TEXT(Input_append_domain_type)='' )
      '' 
    #ELSE
        IF( le.Input_append_domain_type = (TYPEOF(le.Input_append_domain_type))'','',':append_domain_type')
    #END
 
+    #IF( #TEXT(Input_append_domain_root)='' )
      '' 
    #ELSE
        IF( le.Input_append_domain_root = (TYPEOF(le.Input_append_domain_root))'','',':append_domain_root')
    #END
 
+    #IF( #TEXT(Input_append_domain_ext)='' )
      '' 
    #ELSE
        IF( le.Input_append_domain_ext = (TYPEOF(le.Input_append_domain_ext))'','',':append_domain_ext')
    #END
 
+    #IF( #TEXT(Input_append_is_tld_state)='' )
      '' 
    #ELSE
        IF( le.Input_append_is_tld_state = (TYPEOF(le.Input_append_is_tld_state))'','',':append_is_tld_state')
    #END
 
+    #IF( #TEXT(Input_append_is_tld_generic)='' )
      '' 
    #ELSE
        IF( le.Input_append_is_tld_generic = (TYPEOF(le.Input_append_is_tld_generic))'','',':append_is_tld_generic')
    #END
 
+    #IF( #TEXT(Input_append_is_tld_country)='' )
      '' 
    #ELSE
        IF( le.Input_append_is_tld_country = (TYPEOF(le.Input_append_is_tld_country))'','',':append_is_tld_country')
    #END
 
+    #IF( #TEXT(Input_append_is_valid_domain_ext)='' )
      '' 
    #ELSE
        IF( le.Input_append_is_valid_domain_ext = (TYPEOF(le.Input_append_is_valid_domain_ext))'','',':append_is_valid_domain_ext')
    #END
 
+    #IF( #TEXT(Input_cleancollegeId)='' )
      '' 
    #ELSE
        IF( le.Input_cleancollegeId = (TYPEOF(le.Input_cleancollegeId))'','',':cleancollegeId')
    #END
 
+    #IF( #TEXT(Input_cleantitle)='' )
      '' 
    #ELSE
        IF( le.Input_cleantitle = (TYPEOF(le.Input_cleantitle))'','',':cleantitle')
    #END
 
+    #IF( #TEXT(Input_cleanfirstname)='' )
      '' 
    #ELSE
        IF( le.Input_cleanfirstname = (TYPEOF(le.Input_cleanfirstname))'','',':cleanfirstname')
    #END
 
+    #IF( #TEXT(Input_cleanmidname)='' )
      '' 
    #ELSE
        IF( le.Input_cleanmidname = (TYPEOF(le.Input_cleanmidname))'','',':cleanmidname')
    #END
 
+    #IF( #TEXT(Input_cleanlastname)='' )
      '' 
    #ELSE
        IF( le.Input_cleanlastname = (TYPEOF(le.Input_cleanlastname))'','',':cleanlastname')
    #END
 
+    #IF( #TEXT(Input_cleansuffixname)='' )
      '' 
    #ELSE
        IF( le.Input_cleansuffixname = (TYPEOF(le.Input_cleansuffixname))'','',':cleansuffixname')
    #END
 
+    #IF( #TEXT(Input_cleanzip)='' )
      '' 
    #ELSE
        IF( le.Input_cleanzip = (TYPEOF(le.Input_cleanzip))'','',':cleanzip')
    #END
 
+    #IF( #TEXT(Input_cleanzip4)='' )
      '' 
    #ELSE
        IF( le.Input_cleanzip4 = (TYPEOF(le.Input_cleanzip4))'','',':cleanzip4')
    #END
 
+    #IF( #TEXT(Input_cleanmajor)='' )
      '' 
    #ELSE
        IF( le.Input_cleanmajor = (TYPEOF(le.Input_cleanmajor))'','',':cleanmajor')
    #END
 
+    #IF( #TEXT(Input_cleanphone)='' )
      '' 
    #ELSE
        IF( le.Input_cleanphone = (TYPEOF(le.Input_cleanphone))'','',':cleanphone')
    #END
 
+    #IF( #TEXT(Input_rcid)='' )
      '' 
    #ELSE
        IF( le.Input_rcid = (TYPEOF(le.Input_rcid))'','',':rcid')
    #END
 
+    #IF( #TEXT(Input_did)='' )
      '' 
    #ELSE
        IF( le.Input_did = (TYPEOF(le.Input_did))'','',':did')
    #END
 
+    #IF( #TEXT(Input_process_date)='' )
      '' 
    #ELSE
        IF( le.Input_process_date = (TYPEOF(le.Input_process_date))'','',':process_date')
    #END
 
+    #IF( #TEXT(Input_date_first_seen)='' )
      '' 
    #ELSE
        IF( le.Input_date_first_seen = (TYPEOF(le.Input_date_first_seen))'','',':date_first_seen')
    #END
 
+    #IF( #TEXT(Input_date_last_seen)='' )
      '' 
    #ELSE
        IF( le.Input_date_last_seen = (TYPEOF(le.Input_date_last_seen))'','',':date_last_seen')
    #END
 
+    #IF( #TEXT(Input_vendor_first_reported)='' )
      '' 
    #ELSE
        IF( le.Input_vendor_first_reported = (TYPEOF(le.Input_vendor_first_reported))'','',':vendor_first_reported')
    #END
 
+    #IF( #TEXT(Input_vendor_last_reported)='' )
      '' 
    #ELSE
        IF( le.Input_vendor_last_reported = (TYPEOF(le.Input_vendor_last_reported))'','',':vendor_last_reported')
    #END
 
+    #IF( #TEXT(Input_dateupdated)='' )
      '' 
    #ELSE
        IF( le.Input_dateupdated = (TYPEOF(le.Input_dateupdated))'','',':dateupdated')
    #END
 
+    #IF( #TEXT(Input_studentid)='' )
      '' 
    #ELSE
        IF( le.Input_studentid = (TYPEOF(le.Input_studentid))'','',':studentid')
    #END
 
+    #IF( #TEXT(Input_dartid)='' )
      '' 
    #ELSE
        IF( le.Input_dartid = (TYPEOF(le.Input_dartid))'','',':dartid')
    #END
 
+    #IF( #TEXT(Input_collegeid)='' )
      '' 
    #ELSE
        IF( le.Input_collegeid = (TYPEOF(le.Input_collegeid))'','',':collegeid')
    #END
 
+    #IF( #TEXT(Input_projectsource)='' )
      '' 
    #ELSE
        IF( le.Input_projectsource = (TYPEOF(le.Input_projectsource))'','',':projectsource')
    #END
 
+    #IF( #TEXT(Input_collegestate)='' )
      '' 
    #ELSE
        IF( le.Input_collegestate = (TYPEOF(le.Input_collegestate))'','',':collegestate')
    #END
 
+    #IF( #TEXT(Input_college)='' )
      '' 
    #ELSE
        IF( le.Input_college = (TYPEOF(le.Input_college))'','',':college')
    #END
 
+    #IF( #TEXT(Input_semester)='' )
      '' 
    #ELSE
        IF( le.Input_semester = (TYPEOF(le.Input_semester))'','',':semester')
    #END
 
+    #IF( #TEXT(Input_year)='' )
      '' 
    #ELSE
        IF( le.Input_year = (TYPEOF(le.Input_year))'','',':year')
    #END
 
+    #IF( #TEXT(Input_firstname)='' )
      '' 
    #ELSE
        IF( le.Input_firstname = (TYPEOF(le.Input_firstname))'','',':firstname')
    #END
 
+    #IF( #TEXT(Input_middlename)='' )
      '' 
    #ELSE
        IF( le.Input_middlename = (TYPEOF(le.Input_middlename))'','',':middlename')
    #END
 
+    #IF( #TEXT(Input_lastname)='' )
      '' 
    #ELSE
        IF( le.Input_lastname = (TYPEOF(le.Input_lastname))'','',':lastname')
    #END
 
+    #IF( #TEXT(Input_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_suffix = (TYPEOF(le.Input_suffix))'','',':suffix')
    #END
 
+    #IF( #TEXT(Input_major)='' )
      '' 
    #ELSE
        IF( le.Input_major = (TYPEOF(le.Input_major))'','',':major')
    #END
 
+    #IF( #TEXT(Input_COLLEGE_MAJOR)='' )
      '' 
    #ELSE
        IF( le.Input_COLLEGE_MAJOR = (TYPEOF(le.Input_COLLEGE_MAJOR))'','',':COLLEGE_MAJOR')
    #END
 
+    #IF( #TEXT(Input_NEW_COLLEGE_MAJOR)='' )
      '' 
    #ELSE
        IF( le.Input_NEW_COLLEGE_MAJOR = (TYPEOF(le.Input_NEW_COLLEGE_MAJOR))'','',':NEW_COLLEGE_MAJOR')
    #END
 
+    #IF( #TEXT(Input_grade)='' )
      '' 
    #ELSE
        IF( le.Input_grade = (TYPEOF(le.Input_grade))'','',':grade')
    #END
 
+    #IF( #TEXT(Input_email)='' )
      '' 
    #ELSE
        IF( le.Input_email = (TYPEOF(le.Input_email))'','',':email')
    #END
 
+    #IF( #TEXT(Input_dateofbirth)='' )
      '' 
    #ELSE
        IF( le.Input_dateofbirth = (TYPEOF(le.Input_dateofbirth))'','',':dateofbirth')
    #END
 
+    #IF( #TEXT(Input_dob_formatted)='' )
      '' 
    #ELSE
        IF( le.Input_dob_formatted = (TYPEOF(le.Input_dob_formatted))'','',':dob_formatted')
    #END
 
+    #IF( #TEXT(Input_attendancedate)='' )
      '' 
    #ELSE
        IF( le.Input_attendancedate = (TYPEOF(le.Input_attendancedate))'','',':attendancedate')
    #END
 
+    #IF( #TEXT(Input_enrollmentstatus)='' )
      '' 
    #ELSE
        IF( le.Input_enrollmentstatus = (TYPEOF(le.Input_enrollmentstatus))'','',':enrollmentstatus')
    #END
 
+    #IF( #TEXT(Input_addresstype)='' )
      '' 
    #ELSE
        IF( le.Input_addresstype = (TYPEOF(le.Input_addresstype))'','',':addresstype')
    #END
 
+    #IF( #TEXT(Input_address1)='' )
      '' 
    #ELSE
        IF( le.Input_address1 = (TYPEOF(le.Input_address1))'','',':address1')
    #END
 
+    #IF( #TEXT(Input_address2)='' )
      '' 
    #ELSE
        IF( le.Input_address2 = (TYPEOF(le.Input_address2))'','',':address2')
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
 
+    #IF( #TEXT(Input_phonetyp)='' )
      '' 
    #ELSE
        IF( le.Input_phonetyp = (TYPEOF(le.Input_phonetyp))'','',':phonetyp')
    #END
 
+    #IF( #TEXT(Input_phonenumber)='' )
      '' 
    #ELSE
        IF( le.Input_phonenumber = (TYPEOF(le.Input_phonenumber))'','',':phonenumber')
    #END
 
+    #IF( #TEXT(Input_tier)='' )
      '' 
    #ELSE
        IF( le.Input_tier = (TYPEOF(le.Input_tier))'','',':tier')
    #END
 
+    #IF( #TEXT(Input_school_size_code)='' )
      '' 
    #ELSE
        IF( le.Input_school_size_code = (TYPEOF(le.Input_school_size_code))'','',':school_size_code')
    #END
 
+    #IF( #TEXT(Input_competitive_code)='' )
      '' 
    #ELSE
        IF( le.Input_competitive_code = (TYPEOF(le.Input_competitive_code))'','',':competitive_code')
    #END
 
+    #IF( #TEXT(Input_tuition_code)='' )
      '' 
    #ELSE
        IF( le.Input_tuition_code = (TYPEOF(le.Input_tuition_code))'','',':tuition_code')
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
 
+    #IF( #TEXT(Input_name_score)='' )
      '' 
    #ELSE
        IF( le.Input_name_score = (TYPEOF(le.Input_name_score))'','',':name_score')
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
 
+    #IF( #TEXT(Input_z5)='' )
      '' 
    #ELSE
        IF( le.Input_z5 = (TYPEOF(le.Input_z5))'','',':z5')
    #END
 
+    #IF( #TEXT(Input_z4)='' )
      '' 
    #ELSE
        IF( le.Input_z4 = (TYPEOF(le.Input_z4))'','',':z4')
    #END
 
+    #IF( #TEXT(Input_cart)='' )
      '' 
    #ELSE
        IF( le.Input_cart = (TYPEOF(le.Input_cart))'','',':cart')
    #END
 
+    #IF( #TEXT(Input_cr_sort_sz)='' )
      '' 
    #ELSE
        IF( le.Input_cr_sort_sz = (TYPEOF(le.Input_cr_sort_sz))'','',':cr_sort_sz')
    #END
 
+    #IF( #TEXT(Input_lot)='' )
      '' 
    #ELSE
        IF( le.Input_lot = (TYPEOF(le.Input_lot))'','',':lot')
    #END
 
+    #IF( #TEXT(Input_lot_order)='' )
      '' 
    #ELSE
        IF( le.Input_lot_order = (TYPEOF(le.Input_lot_order))'','',':lot_order')
    #END
 
+    #IF( #TEXT(Input_dbpc)='' )
      '' 
    #ELSE
        IF( le.Input_dbpc = (TYPEOF(le.Input_dbpc))'','',':dbpc')
    #END
 
+    #IF( #TEXT(Input_chk_digit)='' )
      '' 
    #ELSE
        IF( le.Input_chk_digit = (TYPEOF(le.Input_chk_digit))'','',':chk_digit')
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
 
+    #IF( #TEXT(Input_telephone)='' )
      '' 
    #ELSE
        IF( le.Input_telephone = (TYPEOF(le.Input_telephone))'','',':telephone')
    #END
 
+    #IF( #TEXT(Input_tier2)='' )
      '' 
    #ELSE
        IF( le.Input_tier2 = (TYPEOF(le.Input_tier2))'','',':tier2')
    #END
 
+    #IF( #TEXT(Input_source)='' )
      '' 
    #ELSE
        IF( le.Input_source = (TYPEOF(le.Input_source))'','',':source')
    #END
;
    #IF (#TEXT(cleancollegeid)<>'')
    SELF.source := le.cleancollegeid;
    #END
  END;
  #uniquename(op)
  %op% := PROJECT(infile,%ot%(LEFT));
  #uniquename(ort)
  %ort% := RECORD
    #IF (#TEXT(cleancollegeid)<>'')
    %op%.source;
    #END
    %op%.fields;
    UNSIGNED cnt := COUNT(GROUP);
  END;
  outfile := TOPN( TABLE( %op%, %ort%,#IF( #TEXT(cleancollegeid)<>'' ) source, #END fields, FEW ), 1000,#IF( #TEXT(cleancollegeid)<>'' ) source, #END -cnt );
ENDMACRO;
