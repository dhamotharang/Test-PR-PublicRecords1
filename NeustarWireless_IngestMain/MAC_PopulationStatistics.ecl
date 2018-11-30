 
EXPORT MAC_PopulationStatistics(infile,Ref='',source='',Input_phone = '',Input_fname = '',Input_mname = '',Input_lname = '',Input_salutation = '',Input_suffix = '',Input_gender = '',Input_dob = '',Input_house = '',Input_pre_dir = '',Input_street = '',Input_street_type = '',Input_post_dir = '',Input_apt_type = '',Input_apt_nbr = '',Input_zip = '',Input_plus4 = '',Input_dpc = '',Input_z4_type = '',Input_crte = '',Input_city = '',Input_state = '',Input_dpvcmra = '',Input_dpvconf = '',Input_fips_state = '',Input_fips_county = '',Input_census_tract = '',Input_census_block_group = '',Input_cbsa = '',Input_match_code = '',Input_latitude = '',Input_longitude = '',Input_email = '',Input_verified = '',Input_activity_status = '',Input_prepaid = '',Input_cord_cutter = '',Input_raw_file_name = '',Input_source = '',Input_date_first_seen = '',Input_date_last_seen = '',Input_date_vendor_first_reported = '',Input_date_vendor_last_reported = '',OutFile) := MACRO
  IMPORT SALT311,NeustarWireless_IngestMain;
  #uniquename(of)
  %of% := RECORD
    #IF (#TEXT(source)<>'')
    SALT311.StrType source;
    #END
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_phone)='' )
      '' 
    #ELSE
        IF( le.Input_phone = (TYPEOF(le.Input_phone))'','',':phone')
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
 
+    #IF( #TEXT(Input_salutation)='' )
      '' 
    #ELSE
        IF( le.Input_salutation = (TYPEOF(le.Input_salutation))'','',':salutation')
    #END
 
+    #IF( #TEXT(Input_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_suffix = (TYPEOF(le.Input_suffix))'','',':suffix')
    #END
 
+    #IF( #TEXT(Input_gender)='' )
      '' 
    #ELSE
        IF( le.Input_gender = (TYPEOF(le.Input_gender))'','',':gender')
    #END
 
+    #IF( #TEXT(Input_dob)='' )
      '' 
    #ELSE
        IF( le.Input_dob = (TYPEOF(le.Input_dob))'','',':dob')
    #END
 
+    #IF( #TEXT(Input_house)='' )
      '' 
    #ELSE
        IF( le.Input_house = (TYPEOF(le.Input_house))'','',':house')
    #END
 
+    #IF( #TEXT(Input_pre_dir)='' )
      '' 
    #ELSE
        IF( le.Input_pre_dir = (TYPEOF(le.Input_pre_dir))'','',':pre_dir')
    #END
 
+    #IF( #TEXT(Input_street)='' )
      '' 
    #ELSE
        IF( le.Input_street = (TYPEOF(le.Input_street))'','',':street')
    #END
 
+    #IF( #TEXT(Input_street_type)='' )
      '' 
    #ELSE
        IF( le.Input_street_type = (TYPEOF(le.Input_street_type))'','',':street_type')
    #END
 
+    #IF( #TEXT(Input_post_dir)='' )
      '' 
    #ELSE
        IF( le.Input_post_dir = (TYPEOF(le.Input_post_dir))'','',':post_dir')
    #END
 
+    #IF( #TEXT(Input_apt_type)='' )
      '' 
    #ELSE
        IF( le.Input_apt_type = (TYPEOF(le.Input_apt_type))'','',':apt_type')
    #END
 
+    #IF( #TEXT(Input_apt_nbr)='' )
      '' 
    #ELSE
        IF( le.Input_apt_nbr = (TYPEOF(le.Input_apt_nbr))'','',':apt_nbr')
    #END
 
+    #IF( #TEXT(Input_zip)='' )
      '' 
    #ELSE
        IF( le.Input_zip = (TYPEOF(le.Input_zip))'','',':zip')
    #END
 
+    #IF( #TEXT(Input_plus4)='' )
      '' 
    #ELSE
        IF( le.Input_plus4 = (TYPEOF(le.Input_plus4))'','',':plus4')
    #END
 
+    #IF( #TEXT(Input_dpc)='' )
      '' 
    #ELSE
        IF( le.Input_dpc = (TYPEOF(le.Input_dpc))'','',':dpc')
    #END
 
+    #IF( #TEXT(Input_z4_type)='' )
      '' 
    #ELSE
        IF( le.Input_z4_type = (TYPEOF(le.Input_z4_type))'','',':z4_type')
    #END
 
+    #IF( #TEXT(Input_crte)='' )
      '' 
    #ELSE
        IF( le.Input_crte = (TYPEOF(le.Input_crte))'','',':crte')
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
 
+    #IF( #TEXT(Input_dpvcmra)='' )
      '' 
    #ELSE
        IF( le.Input_dpvcmra = (TYPEOF(le.Input_dpvcmra))'','',':dpvcmra')
    #END
 
+    #IF( #TEXT(Input_dpvconf)='' )
      '' 
    #ELSE
        IF( le.Input_dpvconf = (TYPEOF(le.Input_dpvconf))'','',':dpvconf')
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
 
+    #IF( #TEXT(Input_cbsa)='' )
      '' 
    #ELSE
        IF( le.Input_cbsa = (TYPEOF(le.Input_cbsa))'','',':cbsa')
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
 
+    #IF( #TEXT(Input_email)='' )
      '' 
    #ELSE
        IF( le.Input_email = (TYPEOF(le.Input_email))'','',':email')
    #END
 
+    #IF( #TEXT(Input_verified)='' )
      '' 
    #ELSE
        IF( le.Input_verified = (TYPEOF(le.Input_verified))'','',':verified')
    #END
 
+    #IF( #TEXT(Input_activity_status)='' )
      '' 
    #ELSE
        IF( le.Input_activity_status = (TYPEOF(le.Input_activity_status))'','',':activity_status')
    #END
 
+    #IF( #TEXT(Input_prepaid)='' )
      '' 
    #ELSE
        IF( le.Input_prepaid = (TYPEOF(le.Input_prepaid))'','',':prepaid')
    #END
 
+    #IF( #TEXT(Input_cord_cutter)='' )
      '' 
    #ELSE
        IF( le.Input_cord_cutter = (TYPEOF(le.Input_cord_cutter))'','',':cord_cutter')
    #END
 
+    #IF( #TEXT(Input_raw_file_name)='' )
      '' 
    #ELSE
        IF( le.Input_raw_file_name = (TYPEOF(le.Input_raw_file_name))'','',':raw_file_name')
    #END
 
+    #IF( #TEXT(Input_source)='' )
      '' 
    #ELSE
        IF( le.Input_source = (TYPEOF(le.Input_source))'','',':source')
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
 
+    #IF( #TEXT(Input_date_vendor_first_reported)='' )
      '' 
    #ELSE
        IF( le.Input_date_vendor_first_reported = (TYPEOF(le.Input_date_vendor_first_reported))'','',':date_vendor_first_reported')
    #END
 
+    #IF( #TEXT(Input_date_vendor_last_reported)='' )
      '' 
    #ELSE
        IF( le.Input_date_vendor_last_reported = (TYPEOF(le.Input_date_vendor_last_reported))'','',':date_vendor_last_reported')
    #END
;
    #IF (#TEXT(source)<>'')
    SELF.source := le.source;
    #END
  END;
  #uniquename(op)
  %op% := PROJECT(infile,%ot%(LEFT));
  #uniquename(ort)
  %ort% := RECORD
    #IF (#TEXT(source)<>'')
    %op%.source;
    #END
    %op%.fields;
    UNSIGNED cnt := COUNT(GROUP);
  END;
  outfile := TOPN( TABLE( %op%, %ort%,#IF( #TEXT(source)<>'' ) source, #END fields, FEW ), 1000,#IF( #TEXT(source)<>'' ) source, #END -cnt );
ENDMACRO;
