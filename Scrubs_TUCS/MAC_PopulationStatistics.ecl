 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_dt_first_seen = '',Input_dt_last_seen = '',Input_dt_vendor_first_reported = '',Input_dt_vendor_last_reported = '',Input_filetype = '',Input_filedate = '',Input_vendordocumentidentifier = '',Input_transferdate = '',Input_currentname_firstname = '',Input_currentname_middlename = '',Input_currentname_middleinitial = '',Input_currentname_lastname = '',Input_currentname_suffix = '',Input_currentname_gender = '',Input_currentname_dob_mm = '',Input_currentname_dob_dd = '',Input_currentname_dob_yyyy = '',Input_currentname_deathindicator = '',Input_ssnfull = '',Input_ssnfirst5digit = '',Input_ssnlast4digit = '',Input_consumerupdatedate = '',Input_telephonenumber = '',Input_citedid = '',Input_fileid = '',Input_publication = '',Input_currentaddress_address1 = '',Input_currentaddress_address2 = '',Input_currentaddress_city = '',Input_currentaddress_state = '',Input_currentaddress_zipcode = '',Input_currentaddress_updateddate = '',Input_housenumber = '',Input_streettype = '',Input_streetdirection = '',Input_streetname = '',Input_apartmentnumber = '',Input_city = '',Input_state = '',Input_zipcode = '',Input_zip4u = '',Input_previousaddress_address1 = '',Input_previousaddress_address2 = '',Input_previousaddress_city = '',Input_previousaddress_state = '',Input_previousaddress_zipcode = '',Input_previousaddress_updateddate = '',Input_formername_firstname = '',Input_formername_middlename = '',Input_formername_middleinitial = '',Input_formername_lastname = '',Input_formername_suffix = '',Input_aliasname_firstname = '',Input_aliasname_middlename = '',Input_aliasname_middleinitial = '',Input_aliasname_lastname = '',Input_aliasname_suffix = '',Input_additionalname_firstname = '',Input_additionalname_middlename = '',Input_additionalname_middleinitial = '',Input_additionalname_lastname = '',Input_additionalname_suffix = '',Input_aka1 = '',Input_aka2 = '',Input_aka3 = '',Input_recordtype = '',Input_addressstandardization = '',Input_filesincedate = '',Input_compilationdate = '',Input_birthdateind = '',Input_orig_deceasedindicator = '',Input_deceaseddate = '',Input_addressseq = '',Input_normaddress_address1 = '',Input_normaddress_address2 = '',Input_normaddress_city = '',Input_normaddress_state = '',Input_normaddress_zipcode = '',Input_normaddress_updateddate = '',Input_name = '',Input_nametype = '',Input_title = '',Input_fname = '',Input_mname = '',Input_lname = '',Input_name_suffix = '',Input_name_score = '',Input_prim_range = '',Input_predir = '',Input_prim_name = '',Input_addr_suffix = '',Input_postdir = '',Input_unit_desig = '',Input_sec_range = '',Input_p_city_name = '',Input_v_city_name = '',Input_st = '',Input_zip = '',Input_zip4 = '',Input_cart = '',Input_cr_sort_sz = '',Input_lot = '',Input_lot_order = '',Input_dbpc = '',Input_chk_digit = '',Input_rec_type = '',Input_county = '',Input_geo_lat = '',Input_geo_long = '',Input_msa = '',Input_geo_blk = '',Input_geo_match = '',Input_err_stat = '',Input_transferdate_unformatted = '',Input_birthdate_unformatted = '',Input_dob_no_conflict = '',Input_updatedate_unformatted = '',Input_consumerupdatedate_unformatted = '',Input_filesincedate_unformatted = '',Input_compilationdate_unformatted = '',Input_ssn_unformatted = '',Input_ssn_no_conflict = '',Input_telephone_unformatted = '',Input_deceasedindicator = '',Input_did = '',Input_did_score_field = '',Input_is_current = '',OutFile) := MACRO
  IMPORT SALT34,Scrubs_TUCS;
  #uniquename(of)
  %of% := RECORD
    SALT34.Str512Type fields;
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
 
+    #IF( #TEXT(Input_filetype)='' )
      '' 
    #ELSE
        IF( le.Input_filetype = (TYPEOF(le.Input_filetype))'','',':filetype')
    #END
 
+    #IF( #TEXT(Input_filedate)='' )
      '' 
    #ELSE
        IF( le.Input_filedate = (TYPEOF(le.Input_filedate))'','',':filedate')
    #END
 
+    #IF( #TEXT(Input_vendordocumentidentifier)='' )
      '' 
    #ELSE
        IF( le.Input_vendordocumentidentifier = (TYPEOF(le.Input_vendordocumentidentifier))'','',':vendordocumentidentifier')
    #END
 
+    #IF( #TEXT(Input_transferdate)='' )
      '' 
    #ELSE
        IF( le.Input_transferdate = (TYPEOF(le.Input_transferdate))'','',':transferdate')
    #END
 
+    #IF( #TEXT(Input_currentname_firstname)='' )
      '' 
    #ELSE
        IF( le.Input_currentname_firstname = (TYPEOF(le.Input_currentname_firstname))'','',':currentname_firstname')
    #END
 
+    #IF( #TEXT(Input_currentname_middlename)='' )
      '' 
    #ELSE
        IF( le.Input_currentname_middlename = (TYPEOF(le.Input_currentname_middlename))'','',':currentname_middlename')
    #END
 
+    #IF( #TEXT(Input_currentname_middleinitial)='' )
      '' 
    #ELSE
        IF( le.Input_currentname_middleinitial = (TYPEOF(le.Input_currentname_middleinitial))'','',':currentname_middleinitial')
    #END
 
+    #IF( #TEXT(Input_currentname_lastname)='' )
      '' 
    #ELSE
        IF( le.Input_currentname_lastname = (TYPEOF(le.Input_currentname_lastname))'','',':currentname_lastname')
    #END
 
+    #IF( #TEXT(Input_currentname_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_currentname_suffix = (TYPEOF(le.Input_currentname_suffix))'','',':currentname_suffix')
    #END
 
+    #IF( #TEXT(Input_currentname_gender)='' )
      '' 
    #ELSE
        IF( le.Input_currentname_gender = (TYPEOF(le.Input_currentname_gender))'','',':currentname_gender')
    #END
 
+    #IF( #TEXT(Input_currentname_dob_mm)='' )
      '' 
    #ELSE
        IF( le.Input_currentname_dob_mm = (TYPEOF(le.Input_currentname_dob_mm))'','',':currentname_dob_mm')
    #END
 
+    #IF( #TEXT(Input_currentname_dob_dd)='' )
      '' 
    #ELSE
        IF( le.Input_currentname_dob_dd = (TYPEOF(le.Input_currentname_dob_dd))'','',':currentname_dob_dd')
    #END
 
+    #IF( #TEXT(Input_currentname_dob_yyyy)='' )
      '' 
    #ELSE
        IF( le.Input_currentname_dob_yyyy = (TYPEOF(le.Input_currentname_dob_yyyy))'','',':currentname_dob_yyyy')
    #END
 
+    #IF( #TEXT(Input_currentname_deathindicator)='' )
      '' 
    #ELSE
        IF( le.Input_currentname_deathindicator = (TYPEOF(le.Input_currentname_deathindicator))'','',':currentname_deathindicator')
    #END
 
+    #IF( #TEXT(Input_ssnfull)='' )
      '' 
    #ELSE
        IF( le.Input_ssnfull = (TYPEOF(le.Input_ssnfull))'','',':ssnfull')
    #END
 
+    #IF( #TEXT(Input_ssnfirst5digit)='' )
      '' 
    #ELSE
        IF( le.Input_ssnfirst5digit = (TYPEOF(le.Input_ssnfirst5digit))'','',':ssnfirst5digit')
    #END
 
+    #IF( #TEXT(Input_ssnlast4digit)='' )
      '' 
    #ELSE
        IF( le.Input_ssnlast4digit = (TYPEOF(le.Input_ssnlast4digit))'','',':ssnlast4digit')
    #END
 
+    #IF( #TEXT(Input_consumerupdatedate)='' )
      '' 
    #ELSE
        IF( le.Input_consumerupdatedate = (TYPEOF(le.Input_consumerupdatedate))'','',':consumerupdatedate')
    #END
 
+    #IF( #TEXT(Input_telephonenumber)='' )
      '' 
    #ELSE
        IF( le.Input_telephonenumber = (TYPEOF(le.Input_telephonenumber))'','',':telephonenumber')
    #END
 
+    #IF( #TEXT(Input_citedid)='' )
      '' 
    #ELSE
        IF( le.Input_citedid = (TYPEOF(le.Input_citedid))'','',':citedid')
    #END
 
+    #IF( #TEXT(Input_fileid)='' )
      '' 
    #ELSE
        IF( le.Input_fileid = (TYPEOF(le.Input_fileid))'','',':fileid')
    #END
 
+    #IF( #TEXT(Input_publication)='' )
      '' 
    #ELSE
        IF( le.Input_publication = (TYPEOF(le.Input_publication))'','',':publication')
    #END
 
+    #IF( #TEXT(Input_currentaddress_address1)='' )
      '' 
    #ELSE
        IF( le.Input_currentaddress_address1 = (TYPEOF(le.Input_currentaddress_address1))'','',':currentaddress_address1')
    #END
 
+    #IF( #TEXT(Input_currentaddress_address2)='' )
      '' 
    #ELSE
        IF( le.Input_currentaddress_address2 = (TYPEOF(le.Input_currentaddress_address2))'','',':currentaddress_address2')
    #END
 
+    #IF( #TEXT(Input_currentaddress_city)='' )
      '' 
    #ELSE
        IF( le.Input_currentaddress_city = (TYPEOF(le.Input_currentaddress_city))'','',':currentaddress_city')
    #END
 
+    #IF( #TEXT(Input_currentaddress_state)='' )
      '' 
    #ELSE
        IF( le.Input_currentaddress_state = (TYPEOF(le.Input_currentaddress_state))'','',':currentaddress_state')
    #END
 
+    #IF( #TEXT(Input_currentaddress_zipcode)='' )
      '' 
    #ELSE
        IF( le.Input_currentaddress_zipcode = (TYPEOF(le.Input_currentaddress_zipcode))'','',':currentaddress_zipcode')
    #END
 
+    #IF( #TEXT(Input_currentaddress_updateddate)='' )
      '' 
    #ELSE
        IF( le.Input_currentaddress_updateddate = (TYPEOF(le.Input_currentaddress_updateddate))'','',':currentaddress_updateddate')
    #END
 
+    #IF( #TEXT(Input_housenumber)='' )
      '' 
    #ELSE
        IF( le.Input_housenumber = (TYPEOF(le.Input_housenumber))'','',':housenumber')
    #END
 
+    #IF( #TEXT(Input_streettype)='' )
      '' 
    #ELSE
        IF( le.Input_streettype = (TYPEOF(le.Input_streettype))'','',':streettype')
    #END
 
+    #IF( #TEXT(Input_streetdirection)='' )
      '' 
    #ELSE
        IF( le.Input_streetdirection = (TYPEOF(le.Input_streetdirection))'','',':streetdirection')
    #END
 
+    #IF( #TEXT(Input_streetname)='' )
      '' 
    #ELSE
        IF( le.Input_streetname = (TYPEOF(le.Input_streetname))'','',':streetname')
    #END
 
+    #IF( #TEXT(Input_apartmentnumber)='' )
      '' 
    #ELSE
        IF( le.Input_apartmentnumber = (TYPEOF(le.Input_apartmentnumber))'','',':apartmentnumber')
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
 
+    #IF( #TEXT(Input_zipcode)='' )
      '' 
    #ELSE
        IF( le.Input_zipcode = (TYPEOF(le.Input_zipcode))'','',':zipcode')
    #END
 
+    #IF( #TEXT(Input_zip4u)='' )
      '' 
    #ELSE
        IF( le.Input_zip4u = (TYPEOF(le.Input_zip4u))'','',':zip4u')
    #END
 
+    #IF( #TEXT(Input_previousaddress_address1)='' )
      '' 
    #ELSE
        IF( le.Input_previousaddress_address1 = (TYPEOF(le.Input_previousaddress_address1))'','',':previousaddress_address1')
    #END
 
+    #IF( #TEXT(Input_previousaddress_address2)='' )
      '' 
    #ELSE
        IF( le.Input_previousaddress_address2 = (TYPEOF(le.Input_previousaddress_address2))'','',':previousaddress_address2')
    #END
 
+    #IF( #TEXT(Input_previousaddress_city)='' )
      '' 
    #ELSE
        IF( le.Input_previousaddress_city = (TYPEOF(le.Input_previousaddress_city))'','',':previousaddress_city')
    #END
 
+    #IF( #TEXT(Input_previousaddress_state)='' )
      '' 
    #ELSE
        IF( le.Input_previousaddress_state = (TYPEOF(le.Input_previousaddress_state))'','',':previousaddress_state')
    #END
 
+    #IF( #TEXT(Input_previousaddress_zipcode)='' )
      '' 
    #ELSE
        IF( le.Input_previousaddress_zipcode = (TYPEOF(le.Input_previousaddress_zipcode))'','',':previousaddress_zipcode')
    #END
 
+    #IF( #TEXT(Input_previousaddress_updateddate)='' )
      '' 
    #ELSE
        IF( le.Input_previousaddress_updateddate = (TYPEOF(le.Input_previousaddress_updateddate))'','',':previousaddress_updateddate')
    #END
 
+    #IF( #TEXT(Input_formername_firstname)='' )
      '' 
    #ELSE
        IF( le.Input_formername_firstname = (TYPEOF(le.Input_formername_firstname))'','',':formername_firstname')
    #END
 
+    #IF( #TEXT(Input_formername_middlename)='' )
      '' 
    #ELSE
        IF( le.Input_formername_middlename = (TYPEOF(le.Input_formername_middlename))'','',':formername_middlename')
    #END
 
+    #IF( #TEXT(Input_formername_middleinitial)='' )
      '' 
    #ELSE
        IF( le.Input_formername_middleinitial = (TYPEOF(le.Input_formername_middleinitial))'','',':formername_middleinitial')
    #END
 
+    #IF( #TEXT(Input_formername_lastname)='' )
      '' 
    #ELSE
        IF( le.Input_formername_lastname = (TYPEOF(le.Input_formername_lastname))'','',':formername_lastname')
    #END
 
+    #IF( #TEXT(Input_formername_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_formername_suffix = (TYPEOF(le.Input_formername_suffix))'','',':formername_suffix')
    #END
 
+    #IF( #TEXT(Input_aliasname_firstname)='' )
      '' 
    #ELSE
        IF( le.Input_aliasname_firstname = (TYPEOF(le.Input_aliasname_firstname))'','',':aliasname_firstname')
    #END
 
+    #IF( #TEXT(Input_aliasname_middlename)='' )
      '' 
    #ELSE
        IF( le.Input_aliasname_middlename = (TYPEOF(le.Input_aliasname_middlename))'','',':aliasname_middlename')
    #END
 
+    #IF( #TEXT(Input_aliasname_middleinitial)='' )
      '' 
    #ELSE
        IF( le.Input_aliasname_middleinitial = (TYPEOF(le.Input_aliasname_middleinitial))'','',':aliasname_middleinitial')
    #END
 
+    #IF( #TEXT(Input_aliasname_lastname)='' )
      '' 
    #ELSE
        IF( le.Input_aliasname_lastname = (TYPEOF(le.Input_aliasname_lastname))'','',':aliasname_lastname')
    #END
 
+    #IF( #TEXT(Input_aliasname_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_aliasname_suffix = (TYPEOF(le.Input_aliasname_suffix))'','',':aliasname_suffix')
    #END
 
+    #IF( #TEXT(Input_additionalname_firstname)='' )
      '' 
    #ELSE
        IF( le.Input_additionalname_firstname = (TYPEOF(le.Input_additionalname_firstname))'','',':additionalname_firstname')
    #END
 
+    #IF( #TEXT(Input_additionalname_middlename)='' )
      '' 
    #ELSE
        IF( le.Input_additionalname_middlename = (TYPEOF(le.Input_additionalname_middlename))'','',':additionalname_middlename')
    #END
 
+    #IF( #TEXT(Input_additionalname_middleinitial)='' )
      '' 
    #ELSE
        IF( le.Input_additionalname_middleinitial = (TYPEOF(le.Input_additionalname_middleinitial))'','',':additionalname_middleinitial')
    #END
 
+    #IF( #TEXT(Input_additionalname_lastname)='' )
      '' 
    #ELSE
        IF( le.Input_additionalname_lastname = (TYPEOF(le.Input_additionalname_lastname))'','',':additionalname_lastname')
    #END
 
+    #IF( #TEXT(Input_additionalname_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_additionalname_suffix = (TYPEOF(le.Input_additionalname_suffix))'','',':additionalname_suffix')
    #END
 
+    #IF( #TEXT(Input_aka1)='' )
      '' 
    #ELSE
        IF( le.Input_aka1 = (TYPEOF(le.Input_aka1))'','',':aka1')
    #END
 
+    #IF( #TEXT(Input_aka2)='' )
      '' 
    #ELSE
        IF( le.Input_aka2 = (TYPEOF(le.Input_aka2))'','',':aka2')
    #END
 
+    #IF( #TEXT(Input_aka3)='' )
      '' 
    #ELSE
        IF( le.Input_aka3 = (TYPEOF(le.Input_aka3))'','',':aka3')
    #END
 
+    #IF( #TEXT(Input_recordtype)='' )
      '' 
    #ELSE
        IF( le.Input_recordtype = (TYPEOF(le.Input_recordtype))'','',':recordtype')
    #END
 
+    #IF( #TEXT(Input_addressstandardization)='' )
      '' 
    #ELSE
        IF( le.Input_addressstandardization = (TYPEOF(le.Input_addressstandardization))'','',':addressstandardization')
    #END
 
+    #IF( #TEXT(Input_filesincedate)='' )
      '' 
    #ELSE
        IF( le.Input_filesincedate = (TYPEOF(le.Input_filesincedate))'','',':filesincedate')
    #END
 
+    #IF( #TEXT(Input_compilationdate)='' )
      '' 
    #ELSE
        IF( le.Input_compilationdate = (TYPEOF(le.Input_compilationdate))'','',':compilationdate')
    #END
 
+    #IF( #TEXT(Input_birthdateind)='' )
      '' 
    #ELSE
        IF( le.Input_birthdateind = (TYPEOF(le.Input_birthdateind))'','',':birthdateind')
    #END
 
+    #IF( #TEXT(Input_orig_deceasedindicator)='' )
      '' 
    #ELSE
        IF( le.Input_orig_deceasedindicator = (TYPEOF(le.Input_orig_deceasedindicator))'','',':orig_deceasedindicator')
    #END
 
+    #IF( #TEXT(Input_deceaseddate)='' )
      '' 
    #ELSE
        IF( le.Input_deceaseddate = (TYPEOF(le.Input_deceaseddate))'','',':deceaseddate')
    #END
 
+    #IF( #TEXT(Input_addressseq)='' )
      '' 
    #ELSE
        IF( le.Input_addressseq = (TYPEOF(le.Input_addressseq))'','',':addressseq')
    #END
 
+    #IF( #TEXT(Input_normaddress_address1)='' )
      '' 
    #ELSE
        IF( le.Input_normaddress_address1 = (TYPEOF(le.Input_normaddress_address1))'','',':normaddress_address1')
    #END
 
+    #IF( #TEXT(Input_normaddress_address2)='' )
      '' 
    #ELSE
        IF( le.Input_normaddress_address2 = (TYPEOF(le.Input_normaddress_address2))'','',':normaddress_address2')
    #END
 
+    #IF( #TEXT(Input_normaddress_city)='' )
      '' 
    #ELSE
        IF( le.Input_normaddress_city = (TYPEOF(le.Input_normaddress_city))'','',':normaddress_city')
    #END
 
+    #IF( #TEXT(Input_normaddress_state)='' )
      '' 
    #ELSE
        IF( le.Input_normaddress_state = (TYPEOF(le.Input_normaddress_state))'','',':normaddress_state')
    #END
 
+    #IF( #TEXT(Input_normaddress_zipcode)='' )
      '' 
    #ELSE
        IF( le.Input_normaddress_zipcode = (TYPEOF(le.Input_normaddress_zipcode))'','',':normaddress_zipcode')
    #END
 
+    #IF( #TEXT(Input_normaddress_updateddate)='' )
      '' 
    #ELSE
        IF( le.Input_normaddress_updateddate = (TYPEOF(le.Input_normaddress_updateddate))'','',':normaddress_updateddate')
    #END
 
+    #IF( #TEXT(Input_name)='' )
      '' 
    #ELSE
        IF( le.Input_name = (TYPEOF(le.Input_name))'','',':name')
    #END
 
+    #IF( #TEXT(Input_nametype)='' )
      '' 
    #ELSE
        IF( le.Input_nametype = (TYPEOF(le.Input_nametype))'','',':nametype')
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
 
+    #IF( #TEXT(Input_transferdate_unformatted)='' )
      '' 
    #ELSE
        IF( le.Input_transferdate_unformatted = (TYPEOF(le.Input_transferdate_unformatted))'','',':transferdate_unformatted')
    #END
 
+    #IF( #TEXT(Input_birthdate_unformatted)='' )
      '' 
    #ELSE
        IF( le.Input_birthdate_unformatted = (TYPEOF(le.Input_birthdate_unformatted))'','',':birthdate_unformatted')
    #END
 
+    #IF( #TEXT(Input_dob_no_conflict)='' )
      '' 
    #ELSE
        IF( le.Input_dob_no_conflict = (TYPEOF(le.Input_dob_no_conflict))'','',':dob_no_conflict')
    #END
 
+    #IF( #TEXT(Input_updatedate_unformatted)='' )
      '' 
    #ELSE
        IF( le.Input_updatedate_unformatted = (TYPEOF(le.Input_updatedate_unformatted))'','',':updatedate_unformatted')
    #END
 
+    #IF( #TEXT(Input_consumerupdatedate_unformatted)='' )
      '' 
    #ELSE
        IF( le.Input_consumerupdatedate_unformatted = (TYPEOF(le.Input_consumerupdatedate_unformatted))'','',':consumerupdatedate_unformatted')
    #END
 
+    #IF( #TEXT(Input_filesincedate_unformatted)='' )
      '' 
    #ELSE
        IF( le.Input_filesincedate_unformatted = (TYPEOF(le.Input_filesincedate_unformatted))'','',':filesincedate_unformatted')
    #END
 
+    #IF( #TEXT(Input_compilationdate_unformatted)='' )
      '' 
    #ELSE
        IF( le.Input_compilationdate_unformatted = (TYPEOF(le.Input_compilationdate_unformatted))'','',':compilationdate_unformatted')
    #END
 
+    #IF( #TEXT(Input_ssn_unformatted)='' )
      '' 
    #ELSE
        IF( le.Input_ssn_unformatted = (TYPEOF(le.Input_ssn_unformatted))'','',':ssn_unformatted')
    #END
 
+    #IF( #TEXT(Input_ssn_no_conflict)='' )
      '' 
    #ELSE
        IF( le.Input_ssn_no_conflict = (TYPEOF(le.Input_ssn_no_conflict))'','',':ssn_no_conflict')
    #END
 
+    #IF( #TEXT(Input_telephone_unformatted)='' )
      '' 
    #ELSE
        IF( le.Input_telephone_unformatted = (TYPEOF(le.Input_telephone_unformatted))'','',':telephone_unformatted')
    #END
 
+    #IF( #TEXT(Input_deceasedindicator)='' )
      '' 
    #ELSE
        IF( le.Input_deceasedindicator = (TYPEOF(le.Input_deceasedindicator))'','',':deceasedindicator')
    #END
 
+    #IF( #TEXT(Input_did)='' )
      '' 
    #ELSE
        IF( le.Input_did = (TYPEOF(le.Input_did))'','',':did')
    #END
 
+    #IF( #TEXT(Input_did_score_field)='' )
      '' 
    #ELSE
        IF( le.Input_did_score_field = (TYPEOF(le.Input_did_score_field))'','',':did_score_field')
    #END
 
+    #IF( #TEXT(Input_is_current)='' )
      '' 
    #ELSE
        IF( le.Input_is_current = (TYPEOF(le.Input_is_current))'','',':is_current')
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
