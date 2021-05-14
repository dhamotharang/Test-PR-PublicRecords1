 
EXPORT Contacts_MAC_PopulationStatistics(infile,Ref='',Input_did = '',Input_did_score = '',Input_bdid = '',Input_bdid_score = '',Input_raw_aid = '',Input_ace_aid = '',Input_dt_first_seen = '',Input_dt_last_seen = '',Input_dt_vendor_first_reported = '',Input_dt_vendor_last_reported = '',Input_record_type = '',Input_rawfields_maincontactid = '',Input_rawfields_maincompanyid = '',Input_rawfields_active = '',Input_rawfields_firstname = '',Input_rawfields_midinital = '',Input_rawfields_lastname = '',Input_rawfields_age = '',Input_rawfields_gender = '',Input_rawfields_primarytitle = '',Input_rawfields_titlelevel1 = '',Input_rawfields_primarydept = '',Input_rawfields_secondtitle = '',Input_rawfields_titlelevel2 = '',Input_rawfields_seconddept = '',Input_rawfields_thirdtitle = '',Input_rawfields_titlelevel3 = '',Input_rawfields_thirddept = '',Input_rawfields_skillcategory = '',Input_rawfields_skillsubcategory = '',Input_rawfields_reportto = '',Input_rawfields_officephone = '',Input_rawfields_officeext = '',Input_rawfields_officefax = '',Input_rawfields_officeemail = '',Input_rawfields_directdial = '',Input_rawfields_mobilephone = '',Input_rawfields_officeaddress1 = '',Input_rawfields_officeaddress2 = '',Input_rawfields_officecity = '',Input_rawfields_officestate = '',Input_rawfields_officezip = '',Input_rawfields_officecountry = '',Input_rawfields_school = '',Input_rawfields_degree = '',Input_rawfields_graduationyear = '',Input_rawfields_country = '',Input_rawfields_salary = '',Input_rawfields_bonus = '',Input_rawfields_compensation = '',Input_rawfields_citizenship = '',Input_rawfields_diversitycandidate = '',Input_rawfields_entrydate = '',Input_rawfields_lastupdate = '',Input_clean_contact_name_title = '',Input_clean_contact_name_fname = '',Input_clean_contact_name_mname = '',Input_clean_contact_name_lname = '',Input_clean_contact_name_name_suffix = '',Input_clean_contact_name_name_score = '',Input_clean_contact_address_prim_range = '',Input_clean_contact_address_predir = '',Input_clean_contact_address_prim_name = '',Input_clean_contact_address_addr_suffix = '',Input_clean_contact_address_postdir = '',Input_clean_contact_address_unit_desig = '',Input_clean_contact_address_sec_range = '',Input_clean_contact_address_p_city_name = '',Input_clean_contact_address_v_city_name = '',Input_clean_contact_address_st = '',Input_clean_contact_address_zip = '',Input_clean_contact_address_zip4 = '',Input_clean_contact_address_cart = '',Input_clean_contact_address_cr_sort_sz = '',Input_clean_contact_address_lot = '',Input_clean_contact_address_lot_order = '',Input_clean_contact_address_dbpc = '',Input_clean_contact_address_chk_digit = '',Input_clean_contact_address_rec_type = '',Input_clean_contact_address_fips_state = '',Input_clean_contact_address_fips_county = '',Input_clean_contact_address_geo_lat = '',Input_clean_contact_address_geo_long = '',Input_clean_contact_address_msa = '',Input_clean_contact_address_geo_blk = '',Input_clean_contact_address_geo_match = '',Input_clean_contact_address_err_stat = '',Input_clean_dates_entrydate = '',Input_clean_dates_lastupdate = '',Input_clean_phones_officephone = '',Input_clean_phones_directdial = '',Input_clean_phones_mobilephone = '',Input_global_sid = '',Input_record_sid = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_Sheila_Greco;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_did)='' )
      '' 
    #ELSE
        IF( le.Input_did = (TYPEOF(le.Input_did))'','',':did')
    #END
 
+    #IF( #TEXT(Input_did_score)='' )
      '' 
    #ELSE
        IF( le.Input_did_score = (TYPEOF(le.Input_did_score))'','',':did_score')
    #END
 
+    #IF( #TEXT(Input_bdid)='' )
      '' 
    #ELSE
        IF( le.Input_bdid = (TYPEOF(le.Input_bdid))'','',':bdid')
    #END
 
+    #IF( #TEXT(Input_bdid_score)='' )
      '' 
    #ELSE
        IF( le.Input_bdid_score = (TYPEOF(le.Input_bdid_score))'','',':bdid_score')
    #END
 
+    #IF( #TEXT(Input_raw_aid)='' )
      '' 
    #ELSE
        IF( le.Input_raw_aid = (TYPEOF(le.Input_raw_aid))'','',':raw_aid')
    #END
 
+    #IF( #TEXT(Input_ace_aid)='' )
      '' 
    #ELSE
        IF( le.Input_ace_aid = (TYPEOF(le.Input_ace_aid))'','',':ace_aid')
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
 
+    #IF( #TEXT(Input_record_type)='' )
      '' 
    #ELSE
        IF( le.Input_record_type = (TYPEOF(le.Input_record_type))'','',':record_type')
    #END
 
+    #IF( #TEXT(Input_rawfields_maincontactid)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_maincontactid = (TYPEOF(le.Input_rawfields_maincontactid))'','',':rawfields_maincontactid')
    #END
 
+    #IF( #TEXT(Input_rawfields_maincompanyid)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_maincompanyid = (TYPEOF(le.Input_rawfields_maincompanyid))'','',':rawfields_maincompanyid')
    #END
 
+    #IF( #TEXT(Input_rawfields_active)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_active = (TYPEOF(le.Input_rawfields_active))'','',':rawfields_active')
    #END
 
+    #IF( #TEXT(Input_rawfields_firstname)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_firstname = (TYPEOF(le.Input_rawfields_firstname))'','',':rawfields_firstname')
    #END
 
+    #IF( #TEXT(Input_rawfields_midinital)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_midinital = (TYPEOF(le.Input_rawfields_midinital))'','',':rawfields_midinital')
    #END
 
+    #IF( #TEXT(Input_rawfields_lastname)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_lastname = (TYPEOF(le.Input_rawfields_lastname))'','',':rawfields_lastname')
    #END
 
+    #IF( #TEXT(Input_rawfields_age)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_age = (TYPEOF(le.Input_rawfields_age))'','',':rawfields_age')
    #END
 
+    #IF( #TEXT(Input_rawfields_gender)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_gender = (TYPEOF(le.Input_rawfields_gender))'','',':rawfields_gender')
    #END
 
+    #IF( #TEXT(Input_rawfields_primarytitle)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_primarytitle = (TYPEOF(le.Input_rawfields_primarytitle))'','',':rawfields_primarytitle')
    #END
 
+    #IF( #TEXT(Input_rawfields_titlelevel1)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_titlelevel1 = (TYPEOF(le.Input_rawfields_titlelevel1))'','',':rawfields_titlelevel1')
    #END
 
+    #IF( #TEXT(Input_rawfields_primarydept)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_primarydept = (TYPEOF(le.Input_rawfields_primarydept))'','',':rawfields_primarydept')
    #END
 
+    #IF( #TEXT(Input_rawfields_secondtitle)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_secondtitle = (TYPEOF(le.Input_rawfields_secondtitle))'','',':rawfields_secondtitle')
    #END
 
+    #IF( #TEXT(Input_rawfields_titlelevel2)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_titlelevel2 = (TYPEOF(le.Input_rawfields_titlelevel2))'','',':rawfields_titlelevel2')
    #END
 
+    #IF( #TEXT(Input_rawfields_seconddept)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_seconddept = (TYPEOF(le.Input_rawfields_seconddept))'','',':rawfields_seconddept')
    #END
 
+    #IF( #TEXT(Input_rawfields_thirdtitle)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_thirdtitle = (TYPEOF(le.Input_rawfields_thirdtitle))'','',':rawfields_thirdtitle')
    #END
 
+    #IF( #TEXT(Input_rawfields_titlelevel3)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_titlelevel3 = (TYPEOF(le.Input_rawfields_titlelevel3))'','',':rawfields_titlelevel3')
    #END
 
+    #IF( #TEXT(Input_rawfields_thirddept)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_thirddept = (TYPEOF(le.Input_rawfields_thirddept))'','',':rawfields_thirddept')
    #END
 
+    #IF( #TEXT(Input_rawfields_skillcategory)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_skillcategory = (TYPEOF(le.Input_rawfields_skillcategory))'','',':rawfields_skillcategory')
    #END
 
+    #IF( #TEXT(Input_rawfields_skillsubcategory)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_skillsubcategory = (TYPEOF(le.Input_rawfields_skillsubcategory))'','',':rawfields_skillsubcategory')
    #END
 
+    #IF( #TEXT(Input_rawfields_reportto)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_reportto = (TYPEOF(le.Input_rawfields_reportto))'','',':rawfields_reportto')
    #END
 
+    #IF( #TEXT(Input_rawfields_officephone)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_officephone = (TYPEOF(le.Input_rawfields_officephone))'','',':rawfields_officephone')
    #END
 
+    #IF( #TEXT(Input_rawfields_officeext)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_officeext = (TYPEOF(le.Input_rawfields_officeext))'','',':rawfields_officeext')
    #END
 
+    #IF( #TEXT(Input_rawfields_officefax)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_officefax = (TYPEOF(le.Input_rawfields_officefax))'','',':rawfields_officefax')
    #END
 
+    #IF( #TEXT(Input_rawfields_officeemail)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_officeemail = (TYPEOF(le.Input_rawfields_officeemail))'','',':rawfields_officeemail')
    #END
 
+    #IF( #TEXT(Input_rawfields_directdial)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_directdial = (TYPEOF(le.Input_rawfields_directdial))'','',':rawfields_directdial')
    #END
 
+    #IF( #TEXT(Input_rawfields_mobilephone)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_mobilephone = (TYPEOF(le.Input_rawfields_mobilephone))'','',':rawfields_mobilephone')
    #END
 
+    #IF( #TEXT(Input_rawfields_officeaddress1)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_officeaddress1 = (TYPEOF(le.Input_rawfields_officeaddress1))'','',':rawfields_officeaddress1')
    #END
 
+    #IF( #TEXT(Input_rawfields_officeaddress2)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_officeaddress2 = (TYPEOF(le.Input_rawfields_officeaddress2))'','',':rawfields_officeaddress2')
    #END
 
+    #IF( #TEXT(Input_rawfields_officecity)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_officecity = (TYPEOF(le.Input_rawfields_officecity))'','',':rawfields_officecity')
    #END
 
+    #IF( #TEXT(Input_rawfields_officestate)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_officestate = (TYPEOF(le.Input_rawfields_officestate))'','',':rawfields_officestate')
    #END
 
+    #IF( #TEXT(Input_rawfields_officezip)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_officezip = (TYPEOF(le.Input_rawfields_officezip))'','',':rawfields_officezip')
    #END
 
+    #IF( #TEXT(Input_rawfields_officecountry)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_officecountry = (TYPEOF(le.Input_rawfields_officecountry))'','',':rawfields_officecountry')
    #END
 
+    #IF( #TEXT(Input_rawfields_school)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_school = (TYPEOF(le.Input_rawfields_school))'','',':rawfields_school')
    #END
 
+    #IF( #TEXT(Input_rawfields_degree)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_degree = (TYPEOF(le.Input_rawfields_degree))'','',':rawfields_degree')
    #END
 
+    #IF( #TEXT(Input_rawfields_graduationyear)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_graduationyear = (TYPEOF(le.Input_rawfields_graduationyear))'','',':rawfields_graduationyear')
    #END
 
+    #IF( #TEXT(Input_rawfields_country)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_country = (TYPEOF(le.Input_rawfields_country))'','',':rawfields_country')
    #END
 
+    #IF( #TEXT(Input_rawfields_salary)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_salary = (TYPEOF(le.Input_rawfields_salary))'','',':rawfields_salary')
    #END
 
+    #IF( #TEXT(Input_rawfields_bonus)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_bonus = (TYPEOF(le.Input_rawfields_bonus))'','',':rawfields_bonus')
    #END
 
+    #IF( #TEXT(Input_rawfields_compensation)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_compensation = (TYPEOF(le.Input_rawfields_compensation))'','',':rawfields_compensation')
    #END
 
+    #IF( #TEXT(Input_rawfields_citizenship)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_citizenship = (TYPEOF(le.Input_rawfields_citizenship))'','',':rawfields_citizenship')
    #END
 
+    #IF( #TEXT(Input_rawfields_diversitycandidate)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_diversitycandidate = (TYPEOF(le.Input_rawfields_diversitycandidate))'','',':rawfields_diversitycandidate')
    #END
 
+    #IF( #TEXT(Input_rawfields_entrydate)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_entrydate = (TYPEOF(le.Input_rawfields_entrydate))'','',':rawfields_entrydate')
    #END
 
+    #IF( #TEXT(Input_rawfields_lastupdate)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_lastupdate = (TYPEOF(le.Input_rawfields_lastupdate))'','',':rawfields_lastupdate')
    #END
 
+    #IF( #TEXT(Input_clean_contact_name_title)='' )
      '' 
    #ELSE
        IF( le.Input_clean_contact_name_title = (TYPEOF(le.Input_clean_contact_name_title))'','',':clean_contact_name_title')
    #END
 
+    #IF( #TEXT(Input_clean_contact_name_fname)='' )
      '' 
    #ELSE
        IF( le.Input_clean_contact_name_fname = (TYPEOF(le.Input_clean_contact_name_fname))'','',':clean_contact_name_fname')
    #END
 
+    #IF( #TEXT(Input_clean_contact_name_mname)='' )
      '' 
    #ELSE
        IF( le.Input_clean_contact_name_mname = (TYPEOF(le.Input_clean_contact_name_mname))'','',':clean_contact_name_mname')
    #END
 
+    #IF( #TEXT(Input_clean_contact_name_lname)='' )
      '' 
    #ELSE
        IF( le.Input_clean_contact_name_lname = (TYPEOF(le.Input_clean_contact_name_lname))'','',':clean_contact_name_lname')
    #END
 
+    #IF( #TEXT(Input_clean_contact_name_name_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_clean_contact_name_name_suffix = (TYPEOF(le.Input_clean_contact_name_name_suffix))'','',':clean_contact_name_name_suffix')
    #END
 
+    #IF( #TEXT(Input_clean_contact_name_name_score)='' )
      '' 
    #ELSE
        IF( le.Input_clean_contact_name_name_score = (TYPEOF(le.Input_clean_contact_name_name_score))'','',':clean_contact_name_name_score')
    #END
 
+    #IF( #TEXT(Input_clean_contact_address_prim_range)='' )
      '' 
    #ELSE
        IF( le.Input_clean_contact_address_prim_range = (TYPEOF(le.Input_clean_contact_address_prim_range))'','',':clean_contact_address_prim_range')
    #END
 
+    #IF( #TEXT(Input_clean_contact_address_predir)='' )
      '' 
    #ELSE
        IF( le.Input_clean_contact_address_predir = (TYPEOF(le.Input_clean_contact_address_predir))'','',':clean_contact_address_predir')
    #END
 
+    #IF( #TEXT(Input_clean_contact_address_prim_name)='' )
      '' 
    #ELSE
        IF( le.Input_clean_contact_address_prim_name = (TYPEOF(le.Input_clean_contact_address_prim_name))'','',':clean_contact_address_prim_name')
    #END
 
+    #IF( #TEXT(Input_clean_contact_address_addr_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_clean_contact_address_addr_suffix = (TYPEOF(le.Input_clean_contact_address_addr_suffix))'','',':clean_contact_address_addr_suffix')
    #END
 
+    #IF( #TEXT(Input_clean_contact_address_postdir)='' )
      '' 
    #ELSE
        IF( le.Input_clean_contact_address_postdir = (TYPEOF(le.Input_clean_contact_address_postdir))'','',':clean_contact_address_postdir')
    #END
 
+    #IF( #TEXT(Input_clean_contact_address_unit_desig)='' )
      '' 
    #ELSE
        IF( le.Input_clean_contact_address_unit_desig = (TYPEOF(le.Input_clean_contact_address_unit_desig))'','',':clean_contact_address_unit_desig')
    #END
 
+    #IF( #TEXT(Input_clean_contact_address_sec_range)='' )
      '' 
    #ELSE
        IF( le.Input_clean_contact_address_sec_range = (TYPEOF(le.Input_clean_contact_address_sec_range))'','',':clean_contact_address_sec_range')
    #END
 
+    #IF( #TEXT(Input_clean_contact_address_p_city_name)='' )
      '' 
    #ELSE
        IF( le.Input_clean_contact_address_p_city_name = (TYPEOF(le.Input_clean_contact_address_p_city_name))'','',':clean_contact_address_p_city_name')
    #END
 
+    #IF( #TEXT(Input_clean_contact_address_v_city_name)='' )
      '' 
    #ELSE
        IF( le.Input_clean_contact_address_v_city_name = (TYPEOF(le.Input_clean_contact_address_v_city_name))'','',':clean_contact_address_v_city_name')
    #END
 
+    #IF( #TEXT(Input_clean_contact_address_st)='' )
      '' 
    #ELSE
        IF( le.Input_clean_contact_address_st = (TYPEOF(le.Input_clean_contact_address_st))'','',':clean_contact_address_st')
    #END
 
+    #IF( #TEXT(Input_clean_contact_address_zip)='' )
      '' 
    #ELSE
        IF( le.Input_clean_contact_address_zip = (TYPEOF(le.Input_clean_contact_address_zip))'','',':clean_contact_address_zip')
    #END
 
+    #IF( #TEXT(Input_clean_contact_address_zip4)='' )
      '' 
    #ELSE
        IF( le.Input_clean_contact_address_zip4 = (TYPEOF(le.Input_clean_contact_address_zip4))'','',':clean_contact_address_zip4')
    #END
 
+    #IF( #TEXT(Input_clean_contact_address_cart)='' )
      '' 
    #ELSE
        IF( le.Input_clean_contact_address_cart = (TYPEOF(le.Input_clean_contact_address_cart))'','',':clean_contact_address_cart')
    #END
 
+    #IF( #TEXT(Input_clean_contact_address_cr_sort_sz)='' )
      '' 
    #ELSE
        IF( le.Input_clean_contact_address_cr_sort_sz = (TYPEOF(le.Input_clean_contact_address_cr_sort_sz))'','',':clean_contact_address_cr_sort_sz')
    #END
 
+    #IF( #TEXT(Input_clean_contact_address_lot)='' )
      '' 
    #ELSE
        IF( le.Input_clean_contact_address_lot = (TYPEOF(le.Input_clean_contact_address_lot))'','',':clean_contact_address_lot')
    #END
 
+    #IF( #TEXT(Input_clean_contact_address_lot_order)='' )
      '' 
    #ELSE
        IF( le.Input_clean_contact_address_lot_order = (TYPEOF(le.Input_clean_contact_address_lot_order))'','',':clean_contact_address_lot_order')
    #END
 
+    #IF( #TEXT(Input_clean_contact_address_dbpc)='' )
      '' 
    #ELSE
        IF( le.Input_clean_contact_address_dbpc = (TYPEOF(le.Input_clean_contact_address_dbpc))'','',':clean_contact_address_dbpc')
    #END
 
+    #IF( #TEXT(Input_clean_contact_address_chk_digit)='' )
      '' 
    #ELSE
        IF( le.Input_clean_contact_address_chk_digit = (TYPEOF(le.Input_clean_contact_address_chk_digit))'','',':clean_contact_address_chk_digit')
    #END
 
+    #IF( #TEXT(Input_clean_contact_address_rec_type)='' )
      '' 
    #ELSE
        IF( le.Input_clean_contact_address_rec_type = (TYPEOF(le.Input_clean_contact_address_rec_type))'','',':clean_contact_address_rec_type')
    #END
 
+    #IF( #TEXT(Input_clean_contact_address_fips_state)='' )
      '' 
    #ELSE
        IF( le.Input_clean_contact_address_fips_state = (TYPEOF(le.Input_clean_contact_address_fips_state))'','',':clean_contact_address_fips_state')
    #END
 
+    #IF( #TEXT(Input_clean_contact_address_fips_county)='' )
      '' 
    #ELSE
        IF( le.Input_clean_contact_address_fips_county = (TYPEOF(le.Input_clean_contact_address_fips_county))'','',':clean_contact_address_fips_county')
    #END
 
+    #IF( #TEXT(Input_clean_contact_address_geo_lat)='' )
      '' 
    #ELSE
        IF( le.Input_clean_contact_address_geo_lat = (TYPEOF(le.Input_clean_contact_address_geo_lat))'','',':clean_contact_address_geo_lat')
    #END
 
+    #IF( #TEXT(Input_clean_contact_address_geo_long)='' )
      '' 
    #ELSE
        IF( le.Input_clean_contact_address_geo_long = (TYPEOF(le.Input_clean_contact_address_geo_long))'','',':clean_contact_address_geo_long')
    #END
 
+    #IF( #TEXT(Input_clean_contact_address_msa)='' )
      '' 
    #ELSE
        IF( le.Input_clean_contact_address_msa = (TYPEOF(le.Input_clean_contact_address_msa))'','',':clean_contact_address_msa')
    #END
 
+    #IF( #TEXT(Input_clean_contact_address_geo_blk)='' )
      '' 
    #ELSE
        IF( le.Input_clean_contact_address_geo_blk = (TYPEOF(le.Input_clean_contact_address_geo_blk))'','',':clean_contact_address_geo_blk')
    #END
 
+    #IF( #TEXT(Input_clean_contact_address_geo_match)='' )
      '' 
    #ELSE
        IF( le.Input_clean_contact_address_geo_match = (TYPEOF(le.Input_clean_contact_address_geo_match))'','',':clean_contact_address_geo_match')
    #END
 
+    #IF( #TEXT(Input_clean_contact_address_err_stat)='' )
      '' 
    #ELSE
        IF( le.Input_clean_contact_address_err_stat = (TYPEOF(le.Input_clean_contact_address_err_stat))'','',':clean_contact_address_err_stat')
    #END
 
+    #IF( #TEXT(Input_clean_dates_entrydate)='' )
      '' 
    #ELSE
        IF( le.Input_clean_dates_entrydate = (TYPEOF(le.Input_clean_dates_entrydate))'','',':clean_dates_entrydate')
    #END
 
+    #IF( #TEXT(Input_clean_dates_lastupdate)='' )
      '' 
    #ELSE
        IF( le.Input_clean_dates_lastupdate = (TYPEOF(le.Input_clean_dates_lastupdate))'','',':clean_dates_lastupdate')
    #END
 
+    #IF( #TEXT(Input_clean_phones_officephone)='' )
      '' 
    #ELSE
        IF( le.Input_clean_phones_officephone = (TYPEOF(le.Input_clean_phones_officephone))'','',':clean_phones_officephone')
    #END
 
+    #IF( #TEXT(Input_clean_phones_directdial)='' )
      '' 
    #ELSE
        IF( le.Input_clean_phones_directdial = (TYPEOF(le.Input_clean_phones_directdial))'','',':clean_phones_directdial')
    #END
 
+    #IF( #TEXT(Input_clean_phones_mobilephone)='' )
      '' 
    #ELSE
        IF( le.Input_clean_phones_mobilephone = (TYPEOF(le.Input_clean_phones_mobilephone))'','',':clean_phones_mobilephone')
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
