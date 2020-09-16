 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_did = '',Input_did_score = '',Input_process_date = '',Input_date_first_seen = '',Input_date_last_seen = '',Input_date_vendor_first_reported = '',Input_date_vendor_last_reported = '',Input_clean_cname = '',Input_current_rec = '',Input_dotid = '',Input_dotscore = '',Input_dotweight = '',Input_empid = '',Input_empscore = '',Input_empweight = '',Input_powid = '',Input_powscore = '',Input_powweight = '',Input_proxid = '',Input_proxscore = '',Input_proxweight = '',Input_seleid = '',Input_selescore = '',Input_seleweight = '',Input_orgid = '',Input_orgscore = '',Input_orgweight = '',Input_ultid = '',Input_ultscore = '',Input_ultweight = '',Input_clean_title = '',Input_clean_fname = '',Input_clean_mname = '',Input_clean_lname = '',Input_clean_name_suffix = '',Input_clean_name_score = '',Input_rawaid = '',Input_append_prep_address_situs = '',Input_append_prep_address_last_situs = '',Input_prim_range = '',Input_predir = '',Input_prim_name = '',Input_addr_suffix = '',Input_postdir = '',Input_unit_desig = '',Input_sec_range = '',Input_p_city_name = '',Input_v_city_name = '',Input_st = '',Input_zip = '',Input_zip4 = '',Input_cart = '',Input_cr_sort_sz = '',Input_lot = '',Input_lot_order = '',Input_dbpc = '',Input_chk_digit = '',Input_rec_type = '',Input_county = '',Input_geo_lat = '',Input_geo_long = '',Input_msa = '',Input_geo_blk = '',Input_geo_match = '',Input_err_stat = '',Input_emailtype = '',Input_rawtext = '',Input_email = '',Input_name = '',Input_organization = '',Input_street1 = '',Input_street2 = '',Input_street3 = '',Input_street4 = '',Input_city = '',Input_state = '',Input_postalcode = '',Input_country = '',Input_fax = '',Input_faxext = '',Input_phone = '',Input_phoneext = '',Input_domainname = '',Input_registrarname = '',Input_contactemail = '',Input_whoisserver = '',Input_nameservers = '',Input_createddate = '',Input_updateddate = '',Input_expiresdate = '',Input_standardregcreateddate = '',Input_standardregupdateddate = '',Input_standardregexpiresdate = '',Input_status = '',Input_audit_auditupdateddate = '',Input_registrant_rawtext = '',Input_registrant_email = '',Input_registrant_name = '',Input_registrant_organization = '',Input_registrant_street1 = '',Input_registrant_street2 = '',Input_registrant_street3 = '',Input_registrant_street4 = '',Input_registrant_city = '',Input_registrant_state = '',Input_registrant_postalcode = '',Input_registrant_country = '',Input_registrant_fax = '',Input_registrant_faxext = '',Input_registrant_phone = '',Input_registrant_phoneext = '',Input_administrativecontact_rawtext = '',Input_administrativecontact_email = '',Input_administrativecontact_name = '',Input_administrativecontact_organization = '',Input_administrativecontact_street1 = '',Input_administrativecontact_street2 = '',Input_administrativecontact_street3 = '',Input_administrativecontact_street4 = '',Input_administrativecontact_city = '',Input_administrativecontact_state = '',Input_administrativecontact_postalcode = '',Input_administrativecontact_country = '',Input_administrativecontact_fax = '',Input_administrativecontact_faxext = '',Input_administrativecontact_phone = '',Input_administrativecontact_phoneext = '',Input_billingcontact_rawtext = '',Input_billingcontact_email = '',Input_billingcontact_name = '',Input_billingcontact_organization = '',Input_billingcontact_street1 = '',Input_billingcontact_street2 = '',Input_billingcontact_street3 = '',Input_billingcontact_street4 = '',Input_billingcontact_city = '',Input_billingcontact_state = '',Input_billingcontact_postalcode = '',Input_billingcontact_country = '',Input_billingcontact_fax = '',Input_billingcontact_faxext = '',Input_billingcontact_phone = '',Input_billingcontact_phoneext = '',Input_technicalcontact_rawtext = '',Input_technicalcontact_email = '',Input_technicalcontact_name = '',Input_technicalcontact_organization = '',Input_technicalcontact_street1 = '',Input_technicalcontact_street2 = '',Input_technicalcontact_street3 = '',Input_technicalcontact_street4 = '',Input_technicalcontact_city = '',Input_technicalcontact_state = '',Input_technicalcontact_postalcode = '',Input_technicalcontact_country = '',Input_technicalcontact_fax = '',Input_technicalcontact_faxext = '',Input_technicalcontact_phone = '',Input_technicalcontact_phoneext = '',Input_zonecontact_rawtext = '',Input_zonecontact_email = '',Input_zonecontact_name = '',Input_zonecontact_organization = '',Input_zonecontact_street1 = '',Input_zonecontact_street2 = '',Input_zonecontact_street3 = '',Input_zonecontact_street4 = '',Input_zonecontact_city = '',Input_zonecontact_state = '',Input_zonecontact_postalcode = '',Input_zonecontact_country = '',Input_zonecontact_fax = '',Input_zonecontact_faxext = '',Input_zonecontact_phone = '',Input_zonecontact_phoneext = '',OutFile) := MACRO
  IMPORT SALT311,WhoIs;
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
 
+    #IF( #TEXT(Input_clean_cname)='' )
      '' 
    #ELSE
        IF( le.Input_clean_cname = (TYPEOF(le.Input_clean_cname))'','',':clean_cname')
    #END
 
+    #IF( #TEXT(Input_current_rec)='' )
      '' 
    #ELSE
        IF( le.Input_current_rec = (TYPEOF(le.Input_current_rec))'','',':current_rec')
    #END
 
+    #IF( #TEXT(Input_dotid)='' )
      '' 
    #ELSE
        IF( le.Input_dotid = (TYPEOF(le.Input_dotid))'','',':dotid')
    #END
 
+    #IF( #TEXT(Input_dotscore)='' )
      '' 
    #ELSE
        IF( le.Input_dotscore = (TYPEOF(le.Input_dotscore))'','',':dotscore')
    #END
 
+    #IF( #TEXT(Input_dotweight)='' )
      '' 
    #ELSE
        IF( le.Input_dotweight = (TYPEOF(le.Input_dotweight))'','',':dotweight')
    #END
 
+    #IF( #TEXT(Input_empid)='' )
      '' 
    #ELSE
        IF( le.Input_empid = (TYPEOF(le.Input_empid))'','',':empid')
    #END
 
+    #IF( #TEXT(Input_empscore)='' )
      '' 
    #ELSE
        IF( le.Input_empscore = (TYPEOF(le.Input_empscore))'','',':empscore')
    #END
 
+    #IF( #TEXT(Input_empweight)='' )
      '' 
    #ELSE
        IF( le.Input_empweight = (TYPEOF(le.Input_empweight))'','',':empweight')
    #END
 
+    #IF( #TEXT(Input_powid)='' )
      '' 
    #ELSE
        IF( le.Input_powid = (TYPEOF(le.Input_powid))'','',':powid')
    #END
 
+    #IF( #TEXT(Input_powscore)='' )
      '' 
    #ELSE
        IF( le.Input_powscore = (TYPEOF(le.Input_powscore))'','',':powscore')
    #END
 
+    #IF( #TEXT(Input_powweight)='' )
      '' 
    #ELSE
        IF( le.Input_powweight = (TYPEOF(le.Input_powweight))'','',':powweight')
    #END
 
+    #IF( #TEXT(Input_proxid)='' )
      '' 
    #ELSE
        IF( le.Input_proxid = (TYPEOF(le.Input_proxid))'','',':proxid')
    #END
 
+    #IF( #TEXT(Input_proxscore)='' )
      '' 
    #ELSE
        IF( le.Input_proxscore = (TYPEOF(le.Input_proxscore))'','',':proxscore')
    #END
 
+    #IF( #TEXT(Input_proxweight)='' )
      '' 
    #ELSE
        IF( le.Input_proxweight = (TYPEOF(le.Input_proxweight))'','',':proxweight')
    #END
 
+    #IF( #TEXT(Input_seleid)='' )
      '' 
    #ELSE
        IF( le.Input_seleid = (TYPEOF(le.Input_seleid))'','',':seleid')
    #END
 
+    #IF( #TEXT(Input_selescore)='' )
      '' 
    #ELSE
        IF( le.Input_selescore = (TYPEOF(le.Input_selescore))'','',':selescore')
    #END
 
+    #IF( #TEXT(Input_seleweight)='' )
      '' 
    #ELSE
        IF( le.Input_seleweight = (TYPEOF(le.Input_seleweight))'','',':seleweight')
    #END
 
+    #IF( #TEXT(Input_orgid)='' )
      '' 
    #ELSE
        IF( le.Input_orgid = (TYPEOF(le.Input_orgid))'','',':orgid')
    #END
 
+    #IF( #TEXT(Input_orgscore)='' )
      '' 
    #ELSE
        IF( le.Input_orgscore = (TYPEOF(le.Input_orgscore))'','',':orgscore')
    #END
 
+    #IF( #TEXT(Input_orgweight)='' )
      '' 
    #ELSE
        IF( le.Input_orgweight = (TYPEOF(le.Input_orgweight))'','',':orgweight')
    #END
 
+    #IF( #TEXT(Input_ultid)='' )
      '' 
    #ELSE
        IF( le.Input_ultid = (TYPEOF(le.Input_ultid))'','',':ultid')
    #END
 
+    #IF( #TEXT(Input_ultscore)='' )
      '' 
    #ELSE
        IF( le.Input_ultscore = (TYPEOF(le.Input_ultscore))'','',':ultscore')
    #END
 
+    #IF( #TEXT(Input_ultweight)='' )
      '' 
    #ELSE
        IF( le.Input_ultweight = (TYPEOF(le.Input_ultweight))'','',':ultweight')
    #END
 
+    #IF( #TEXT(Input_clean_title)='' )
      '' 
    #ELSE
        IF( le.Input_clean_title = (TYPEOF(le.Input_clean_title))'','',':clean_title')
    #END
 
+    #IF( #TEXT(Input_clean_fname)='' )
      '' 
    #ELSE
        IF( le.Input_clean_fname = (TYPEOF(le.Input_clean_fname))'','',':clean_fname')
    #END
 
+    #IF( #TEXT(Input_clean_mname)='' )
      '' 
    #ELSE
        IF( le.Input_clean_mname = (TYPEOF(le.Input_clean_mname))'','',':clean_mname')
    #END
 
+    #IF( #TEXT(Input_clean_lname)='' )
      '' 
    #ELSE
        IF( le.Input_clean_lname = (TYPEOF(le.Input_clean_lname))'','',':clean_lname')
    #END
 
+    #IF( #TEXT(Input_clean_name_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_clean_name_suffix = (TYPEOF(le.Input_clean_name_suffix))'','',':clean_name_suffix')
    #END
 
+    #IF( #TEXT(Input_clean_name_score)='' )
      '' 
    #ELSE
        IF( le.Input_clean_name_score = (TYPEOF(le.Input_clean_name_score))'','',':clean_name_score')
    #END
 
+    #IF( #TEXT(Input_rawaid)='' )
      '' 
    #ELSE
        IF( le.Input_rawaid = (TYPEOF(le.Input_rawaid))'','',':rawaid')
    #END
 
+    #IF( #TEXT(Input_append_prep_address_situs)='' )
      '' 
    #ELSE
        IF( le.Input_append_prep_address_situs = (TYPEOF(le.Input_append_prep_address_situs))'','',':append_prep_address_situs')
    #END
 
+    #IF( #TEXT(Input_append_prep_address_last_situs)='' )
      '' 
    #ELSE
        IF( le.Input_append_prep_address_last_situs = (TYPEOF(le.Input_append_prep_address_last_situs))'','',':append_prep_address_last_situs')
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
 
+    #IF( #TEXT(Input_emailtype)='' )
      '' 
    #ELSE
        IF( le.Input_emailtype = (TYPEOF(le.Input_emailtype))'','',':emailtype')
    #END
 
+    #IF( #TEXT(Input_rawtext)='' )
      '' 
    #ELSE
        IF( le.Input_rawtext = (TYPEOF(le.Input_rawtext))'','',':rawtext')
    #END
 
+    #IF( #TEXT(Input_email)='' )
      '' 
    #ELSE
        IF( le.Input_email = (TYPEOF(le.Input_email))'','',':email')
    #END
 
+    #IF( #TEXT(Input_name)='' )
      '' 
    #ELSE
        IF( le.Input_name = (TYPEOF(le.Input_name))'','',':name')
    #END
 
+    #IF( #TEXT(Input_organization)='' )
      '' 
    #ELSE
        IF( le.Input_organization = (TYPEOF(le.Input_organization))'','',':organization')
    #END
 
+    #IF( #TEXT(Input_street1)='' )
      '' 
    #ELSE
        IF( le.Input_street1 = (TYPEOF(le.Input_street1))'','',':street1')
    #END
 
+    #IF( #TEXT(Input_street2)='' )
      '' 
    #ELSE
        IF( le.Input_street2 = (TYPEOF(le.Input_street2))'','',':street2')
    #END
 
+    #IF( #TEXT(Input_street3)='' )
      '' 
    #ELSE
        IF( le.Input_street3 = (TYPEOF(le.Input_street3))'','',':street3')
    #END
 
+    #IF( #TEXT(Input_street4)='' )
      '' 
    #ELSE
        IF( le.Input_street4 = (TYPEOF(le.Input_street4))'','',':street4')
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
 
+    #IF( #TEXT(Input_postalcode)='' )
      '' 
    #ELSE
        IF( le.Input_postalcode = (TYPEOF(le.Input_postalcode))'','',':postalcode')
    #END
 
+    #IF( #TEXT(Input_country)='' )
      '' 
    #ELSE
        IF( le.Input_country = (TYPEOF(le.Input_country))'','',':country')
    #END
 
+    #IF( #TEXT(Input_fax)='' )
      '' 
    #ELSE
        IF( le.Input_fax = (TYPEOF(le.Input_fax))'','',':fax')
    #END
 
+    #IF( #TEXT(Input_faxext)='' )
      '' 
    #ELSE
        IF( le.Input_faxext = (TYPEOF(le.Input_faxext))'','',':faxext')
    #END
 
+    #IF( #TEXT(Input_phone)='' )
      '' 
    #ELSE
        IF( le.Input_phone = (TYPEOF(le.Input_phone))'','',':phone')
    #END
 
+    #IF( #TEXT(Input_phoneext)='' )
      '' 
    #ELSE
        IF( le.Input_phoneext = (TYPEOF(le.Input_phoneext))'','',':phoneext')
    #END
 
+    #IF( #TEXT(Input_domainname)='' )
      '' 
    #ELSE
        IF( le.Input_domainname = (TYPEOF(le.Input_domainname))'','',':domainname')
    #END
 
+    #IF( #TEXT(Input_registrarname)='' )
      '' 
    #ELSE
        IF( le.Input_registrarname = (TYPEOF(le.Input_registrarname))'','',':registrarname')
    #END
 
+    #IF( #TEXT(Input_contactemail)='' )
      '' 
    #ELSE
        IF( le.Input_contactemail = (TYPEOF(le.Input_contactemail))'','',':contactemail')
    #END
 
+    #IF( #TEXT(Input_whoisserver)='' )
      '' 
    #ELSE
        IF( le.Input_whoisserver = (TYPEOF(le.Input_whoisserver))'','',':whoisserver')
    #END
 
+    #IF( #TEXT(Input_nameservers)='' )
      '' 
    #ELSE
        IF( le.Input_nameservers = (TYPEOF(le.Input_nameservers))'','',':nameservers')
    #END
 
+    #IF( #TEXT(Input_createddate)='' )
      '' 
    #ELSE
        IF( le.Input_createddate = (TYPEOF(le.Input_createddate))'','',':createddate')
    #END
 
+    #IF( #TEXT(Input_updateddate)='' )
      '' 
    #ELSE
        IF( le.Input_updateddate = (TYPEOF(le.Input_updateddate))'','',':updateddate')
    #END
 
+    #IF( #TEXT(Input_expiresdate)='' )
      '' 
    #ELSE
        IF( le.Input_expiresdate = (TYPEOF(le.Input_expiresdate))'','',':expiresdate')
    #END
 
+    #IF( #TEXT(Input_standardregcreateddate)='' )
      '' 
    #ELSE
        IF( le.Input_standardregcreateddate = (TYPEOF(le.Input_standardregcreateddate))'','',':standardregcreateddate')
    #END
 
+    #IF( #TEXT(Input_standardregupdateddate)='' )
      '' 
    #ELSE
        IF( le.Input_standardregupdateddate = (TYPEOF(le.Input_standardregupdateddate))'','',':standardregupdateddate')
    #END
 
+    #IF( #TEXT(Input_standardregexpiresdate)='' )
      '' 
    #ELSE
        IF( le.Input_standardregexpiresdate = (TYPEOF(le.Input_standardregexpiresdate))'','',':standardregexpiresdate')
    #END
 
+    #IF( #TEXT(Input_status)='' )
      '' 
    #ELSE
        IF( le.Input_status = (TYPEOF(le.Input_status))'','',':status')
    #END
 
+    #IF( #TEXT(Input_audit_auditupdateddate)='' )
      '' 
    #ELSE
        IF( le.Input_audit_auditupdateddate = (TYPEOF(le.Input_audit_auditupdateddate))'','',':audit_auditupdateddate')
    #END
 
+    #IF( #TEXT(Input_registrant_rawtext)='' )
      '' 
    #ELSE
        IF( le.Input_registrant_rawtext = (TYPEOF(le.Input_registrant_rawtext))'','',':registrant_rawtext')
    #END
 
+    #IF( #TEXT(Input_registrant_email)='' )
      '' 
    #ELSE
        IF( le.Input_registrant_email = (TYPEOF(le.Input_registrant_email))'','',':registrant_email')
    #END
 
+    #IF( #TEXT(Input_registrant_name)='' )
      '' 
    #ELSE
        IF( le.Input_registrant_name = (TYPEOF(le.Input_registrant_name))'','',':registrant_name')
    #END
 
+    #IF( #TEXT(Input_registrant_organization)='' )
      '' 
    #ELSE
        IF( le.Input_registrant_organization = (TYPEOF(le.Input_registrant_organization))'','',':registrant_organization')
    #END
 
+    #IF( #TEXT(Input_registrant_street1)='' )
      '' 
    #ELSE
        IF( le.Input_registrant_street1 = (TYPEOF(le.Input_registrant_street1))'','',':registrant_street1')
    #END
 
+    #IF( #TEXT(Input_registrant_street2)='' )
      '' 
    #ELSE
        IF( le.Input_registrant_street2 = (TYPEOF(le.Input_registrant_street2))'','',':registrant_street2')
    #END
 
+    #IF( #TEXT(Input_registrant_street3)='' )
      '' 
    #ELSE
        IF( le.Input_registrant_street3 = (TYPEOF(le.Input_registrant_street3))'','',':registrant_street3')
    #END
 
+    #IF( #TEXT(Input_registrant_street4)='' )
      '' 
    #ELSE
        IF( le.Input_registrant_street4 = (TYPEOF(le.Input_registrant_street4))'','',':registrant_street4')
    #END
 
+    #IF( #TEXT(Input_registrant_city)='' )
      '' 
    #ELSE
        IF( le.Input_registrant_city = (TYPEOF(le.Input_registrant_city))'','',':registrant_city')
    #END
 
+    #IF( #TEXT(Input_registrant_state)='' )
      '' 
    #ELSE
        IF( le.Input_registrant_state = (TYPEOF(le.Input_registrant_state))'','',':registrant_state')
    #END
 
+    #IF( #TEXT(Input_registrant_postalcode)='' )
      '' 
    #ELSE
        IF( le.Input_registrant_postalcode = (TYPEOF(le.Input_registrant_postalcode))'','',':registrant_postalcode')
    #END
 
+    #IF( #TEXT(Input_registrant_country)='' )
      '' 
    #ELSE
        IF( le.Input_registrant_country = (TYPEOF(le.Input_registrant_country))'','',':registrant_country')
    #END
 
+    #IF( #TEXT(Input_registrant_fax)='' )
      '' 
    #ELSE
        IF( le.Input_registrant_fax = (TYPEOF(le.Input_registrant_fax))'','',':registrant_fax')
    #END
 
+    #IF( #TEXT(Input_registrant_faxext)='' )
      '' 
    #ELSE
        IF( le.Input_registrant_faxext = (TYPEOF(le.Input_registrant_faxext))'','',':registrant_faxext')
    #END
 
+    #IF( #TEXT(Input_registrant_phone)='' )
      '' 
    #ELSE
        IF( le.Input_registrant_phone = (TYPEOF(le.Input_registrant_phone))'','',':registrant_phone')
    #END
 
+    #IF( #TEXT(Input_registrant_phoneext)='' )
      '' 
    #ELSE
        IF( le.Input_registrant_phoneext = (TYPEOF(le.Input_registrant_phoneext))'','',':registrant_phoneext')
    #END
 
+    #IF( #TEXT(Input_administrativecontact_rawtext)='' )
      '' 
    #ELSE
        IF( le.Input_administrativecontact_rawtext = (TYPEOF(le.Input_administrativecontact_rawtext))'','',':administrativecontact_rawtext')
    #END
 
+    #IF( #TEXT(Input_administrativecontact_email)='' )
      '' 
    #ELSE
        IF( le.Input_administrativecontact_email = (TYPEOF(le.Input_administrativecontact_email))'','',':administrativecontact_email')
    #END
 
+    #IF( #TEXT(Input_administrativecontact_name)='' )
      '' 
    #ELSE
        IF( le.Input_administrativecontact_name = (TYPEOF(le.Input_administrativecontact_name))'','',':administrativecontact_name')
    #END
 
+    #IF( #TEXT(Input_administrativecontact_organization)='' )
      '' 
    #ELSE
        IF( le.Input_administrativecontact_organization = (TYPEOF(le.Input_administrativecontact_organization))'','',':administrativecontact_organization')
    #END
 
+    #IF( #TEXT(Input_administrativecontact_street1)='' )
      '' 
    #ELSE
        IF( le.Input_administrativecontact_street1 = (TYPEOF(le.Input_administrativecontact_street1))'','',':administrativecontact_street1')
    #END
 
+    #IF( #TEXT(Input_administrativecontact_street2)='' )
      '' 
    #ELSE
        IF( le.Input_administrativecontact_street2 = (TYPEOF(le.Input_administrativecontact_street2))'','',':administrativecontact_street2')
    #END
 
+    #IF( #TEXT(Input_administrativecontact_street3)='' )
      '' 
    #ELSE
        IF( le.Input_administrativecontact_street3 = (TYPEOF(le.Input_administrativecontact_street3))'','',':administrativecontact_street3')
    #END
 
+    #IF( #TEXT(Input_administrativecontact_street4)='' )
      '' 
    #ELSE
        IF( le.Input_administrativecontact_street4 = (TYPEOF(le.Input_administrativecontact_street4))'','',':administrativecontact_street4')
    #END
 
+    #IF( #TEXT(Input_administrativecontact_city)='' )
      '' 
    #ELSE
        IF( le.Input_administrativecontact_city = (TYPEOF(le.Input_administrativecontact_city))'','',':administrativecontact_city')
    #END
 
+    #IF( #TEXT(Input_administrativecontact_state)='' )
      '' 
    #ELSE
        IF( le.Input_administrativecontact_state = (TYPEOF(le.Input_administrativecontact_state))'','',':administrativecontact_state')
    #END
 
+    #IF( #TEXT(Input_administrativecontact_postalcode)='' )
      '' 
    #ELSE
        IF( le.Input_administrativecontact_postalcode = (TYPEOF(le.Input_administrativecontact_postalcode))'','',':administrativecontact_postalcode')
    #END
 
+    #IF( #TEXT(Input_administrativecontact_country)='' )
      '' 
    #ELSE
        IF( le.Input_administrativecontact_country = (TYPEOF(le.Input_administrativecontact_country))'','',':administrativecontact_country')
    #END
 
+    #IF( #TEXT(Input_administrativecontact_fax)='' )
      '' 
    #ELSE
        IF( le.Input_administrativecontact_fax = (TYPEOF(le.Input_administrativecontact_fax))'','',':administrativecontact_fax')
    #END
 
+    #IF( #TEXT(Input_administrativecontact_faxext)='' )
      '' 
    #ELSE
        IF( le.Input_administrativecontact_faxext = (TYPEOF(le.Input_administrativecontact_faxext))'','',':administrativecontact_faxext')
    #END
 
+    #IF( #TEXT(Input_administrativecontact_phone)='' )
      '' 
    #ELSE
        IF( le.Input_administrativecontact_phone = (TYPEOF(le.Input_administrativecontact_phone))'','',':administrativecontact_phone')
    #END
 
+    #IF( #TEXT(Input_administrativecontact_phoneext)='' )
      '' 
    #ELSE
        IF( le.Input_administrativecontact_phoneext = (TYPEOF(le.Input_administrativecontact_phoneext))'','',':administrativecontact_phoneext')
    #END
 
+    #IF( #TEXT(Input_billingcontact_rawtext)='' )
      '' 
    #ELSE
        IF( le.Input_billingcontact_rawtext = (TYPEOF(le.Input_billingcontact_rawtext))'','',':billingcontact_rawtext')
    #END
 
+    #IF( #TEXT(Input_billingcontact_email)='' )
      '' 
    #ELSE
        IF( le.Input_billingcontact_email = (TYPEOF(le.Input_billingcontact_email))'','',':billingcontact_email')
    #END
 
+    #IF( #TEXT(Input_billingcontact_name)='' )
      '' 
    #ELSE
        IF( le.Input_billingcontact_name = (TYPEOF(le.Input_billingcontact_name))'','',':billingcontact_name')
    #END
 
+    #IF( #TEXT(Input_billingcontact_organization)='' )
      '' 
    #ELSE
        IF( le.Input_billingcontact_organization = (TYPEOF(le.Input_billingcontact_organization))'','',':billingcontact_organization')
    #END
 
+    #IF( #TEXT(Input_billingcontact_street1)='' )
      '' 
    #ELSE
        IF( le.Input_billingcontact_street1 = (TYPEOF(le.Input_billingcontact_street1))'','',':billingcontact_street1')
    #END
 
+    #IF( #TEXT(Input_billingcontact_street2)='' )
      '' 
    #ELSE
        IF( le.Input_billingcontact_street2 = (TYPEOF(le.Input_billingcontact_street2))'','',':billingcontact_street2')
    #END
 
+    #IF( #TEXT(Input_billingcontact_street3)='' )
      '' 
    #ELSE
        IF( le.Input_billingcontact_street3 = (TYPEOF(le.Input_billingcontact_street3))'','',':billingcontact_street3')
    #END
 
+    #IF( #TEXT(Input_billingcontact_street4)='' )
      '' 
    #ELSE
        IF( le.Input_billingcontact_street4 = (TYPEOF(le.Input_billingcontact_street4))'','',':billingcontact_street4')
    #END
 
+    #IF( #TEXT(Input_billingcontact_city)='' )
      '' 
    #ELSE
        IF( le.Input_billingcontact_city = (TYPEOF(le.Input_billingcontact_city))'','',':billingcontact_city')
    #END
 
+    #IF( #TEXT(Input_billingcontact_state)='' )
      '' 
    #ELSE
        IF( le.Input_billingcontact_state = (TYPEOF(le.Input_billingcontact_state))'','',':billingcontact_state')
    #END
 
+    #IF( #TEXT(Input_billingcontact_postalcode)='' )
      '' 
    #ELSE
        IF( le.Input_billingcontact_postalcode = (TYPEOF(le.Input_billingcontact_postalcode))'','',':billingcontact_postalcode')
    #END
 
+    #IF( #TEXT(Input_billingcontact_country)='' )
      '' 
    #ELSE
        IF( le.Input_billingcontact_country = (TYPEOF(le.Input_billingcontact_country))'','',':billingcontact_country')
    #END
 
+    #IF( #TEXT(Input_billingcontact_fax)='' )
      '' 
    #ELSE
        IF( le.Input_billingcontact_fax = (TYPEOF(le.Input_billingcontact_fax))'','',':billingcontact_fax')
    #END
 
+    #IF( #TEXT(Input_billingcontact_faxext)='' )
      '' 
    #ELSE
        IF( le.Input_billingcontact_faxext = (TYPEOF(le.Input_billingcontact_faxext))'','',':billingcontact_faxext')
    #END
 
+    #IF( #TEXT(Input_billingcontact_phone)='' )
      '' 
    #ELSE
        IF( le.Input_billingcontact_phone = (TYPEOF(le.Input_billingcontact_phone))'','',':billingcontact_phone')
    #END
 
+    #IF( #TEXT(Input_billingcontact_phoneext)='' )
      '' 
    #ELSE
        IF( le.Input_billingcontact_phoneext = (TYPEOF(le.Input_billingcontact_phoneext))'','',':billingcontact_phoneext')
    #END
 
+    #IF( #TEXT(Input_technicalcontact_rawtext)='' )
      '' 
    #ELSE
        IF( le.Input_technicalcontact_rawtext = (TYPEOF(le.Input_technicalcontact_rawtext))'','',':technicalcontact_rawtext')
    #END
 
+    #IF( #TEXT(Input_technicalcontact_email)='' )
      '' 
    #ELSE
        IF( le.Input_technicalcontact_email = (TYPEOF(le.Input_technicalcontact_email))'','',':technicalcontact_email')
    #END
 
+    #IF( #TEXT(Input_technicalcontact_name)='' )
      '' 
    #ELSE
        IF( le.Input_technicalcontact_name = (TYPEOF(le.Input_technicalcontact_name))'','',':technicalcontact_name')
    #END
 
+    #IF( #TEXT(Input_technicalcontact_organization)='' )
      '' 
    #ELSE
        IF( le.Input_technicalcontact_organization = (TYPEOF(le.Input_technicalcontact_organization))'','',':technicalcontact_organization')
    #END
 
+    #IF( #TEXT(Input_technicalcontact_street1)='' )
      '' 
    #ELSE
        IF( le.Input_technicalcontact_street1 = (TYPEOF(le.Input_technicalcontact_street1))'','',':technicalcontact_street1')
    #END
 
+    #IF( #TEXT(Input_technicalcontact_street2)='' )
      '' 
    #ELSE
        IF( le.Input_technicalcontact_street2 = (TYPEOF(le.Input_technicalcontact_street2))'','',':technicalcontact_street2')
    #END
 
+    #IF( #TEXT(Input_technicalcontact_street3)='' )
      '' 
    #ELSE
        IF( le.Input_technicalcontact_street3 = (TYPEOF(le.Input_technicalcontact_street3))'','',':technicalcontact_street3')
    #END
 
+    #IF( #TEXT(Input_technicalcontact_street4)='' )
      '' 
    #ELSE
        IF( le.Input_technicalcontact_street4 = (TYPEOF(le.Input_technicalcontact_street4))'','',':technicalcontact_street4')
    #END
 
+    #IF( #TEXT(Input_technicalcontact_city)='' )
      '' 
    #ELSE
        IF( le.Input_technicalcontact_city = (TYPEOF(le.Input_technicalcontact_city))'','',':technicalcontact_city')
    #END
 
+    #IF( #TEXT(Input_technicalcontact_state)='' )
      '' 
    #ELSE
        IF( le.Input_technicalcontact_state = (TYPEOF(le.Input_technicalcontact_state))'','',':technicalcontact_state')
    #END
 
+    #IF( #TEXT(Input_technicalcontact_postalcode)='' )
      '' 
    #ELSE
        IF( le.Input_technicalcontact_postalcode = (TYPEOF(le.Input_technicalcontact_postalcode))'','',':technicalcontact_postalcode')
    #END
 
+    #IF( #TEXT(Input_technicalcontact_country)='' )
      '' 
    #ELSE
        IF( le.Input_technicalcontact_country = (TYPEOF(le.Input_technicalcontact_country))'','',':technicalcontact_country')
    #END
 
+    #IF( #TEXT(Input_technicalcontact_fax)='' )
      '' 
    #ELSE
        IF( le.Input_technicalcontact_fax = (TYPEOF(le.Input_technicalcontact_fax))'','',':technicalcontact_fax')
    #END
 
+    #IF( #TEXT(Input_technicalcontact_faxext)='' )
      '' 
    #ELSE
        IF( le.Input_technicalcontact_faxext = (TYPEOF(le.Input_technicalcontact_faxext))'','',':technicalcontact_faxext')
    #END
 
+    #IF( #TEXT(Input_technicalcontact_phone)='' )
      '' 
    #ELSE
        IF( le.Input_technicalcontact_phone = (TYPEOF(le.Input_technicalcontact_phone))'','',':technicalcontact_phone')
    #END
 
+    #IF( #TEXT(Input_technicalcontact_phoneext)='' )
      '' 
    #ELSE
        IF( le.Input_technicalcontact_phoneext = (TYPEOF(le.Input_technicalcontact_phoneext))'','',':technicalcontact_phoneext')
    #END
 
+    #IF( #TEXT(Input_zonecontact_rawtext)='' )
      '' 
    #ELSE
        IF( le.Input_zonecontact_rawtext = (TYPEOF(le.Input_zonecontact_rawtext))'','',':zonecontact_rawtext')
    #END
 
+    #IF( #TEXT(Input_zonecontact_email)='' )
      '' 
    #ELSE
        IF( le.Input_zonecontact_email = (TYPEOF(le.Input_zonecontact_email))'','',':zonecontact_email')
    #END
 
+    #IF( #TEXT(Input_zonecontact_name)='' )
      '' 
    #ELSE
        IF( le.Input_zonecontact_name = (TYPEOF(le.Input_zonecontact_name))'','',':zonecontact_name')
    #END
 
+    #IF( #TEXT(Input_zonecontact_organization)='' )
      '' 
    #ELSE
        IF( le.Input_zonecontact_organization = (TYPEOF(le.Input_zonecontact_organization))'','',':zonecontact_organization')
    #END
 
+    #IF( #TEXT(Input_zonecontact_street1)='' )
      '' 
    #ELSE
        IF( le.Input_zonecontact_street1 = (TYPEOF(le.Input_zonecontact_street1))'','',':zonecontact_street1')
    #END
 
+    #IF( #TEXT(Input_zonecontact_street2)='' )
      '' 
    #ELSE
        IF( le.Input_zonecontact_street2 = (TYPEOF(le.Input_zonecontact_street2))'','',':zonecontact_street2')
    #END
 
+    #IF( #TEXT(Input_zonecontact_street3)='' )
      '' 
    #ELSE
        IF( le.Input_zonecontact_street3 = (TYPEOF(le.Input_zonecontact_street3))'','',':zonecontact_street3')
    #END
 
+    #IF( #TEXT(Input_zonecontact_street4)='' )
      '' 
    #ELSE
        IF( le.Input_zonecontact_street4 = (TYPEOF(le.Input_zonecontact_street4))'','',':zonecontact_street4')
    #END
 
+    #IF( #TEXT(Input_zonecontact_city)='' )
      '' 
    #ELSE
        IF( le.Input_zonecontact_city = (TYPEOF(le.Input_zonecontact_city))'','',':zonecontact_city')
    #END
 
+    #IF( #TEXT(Input_zonecontact_state)='' )
      '' 
    #ELSE
        IF( le.Input_zonecontact_state = (TYPEOF(le.Input_zonecontact_state))'','',':zonecontact_state')
    #END
 
+    #IF( #TEXT(Input_zonecontact_postalcode)='' )
      '' 
    #ELSE
        IF( le.Input_zonecontact_postalcode = (TYPEOF(le.Input_zonecontact_postalcode))'','',':zonecontact_postalcode')
    #END
 
+    #IF( #TEXT(Input_zonecontact_country)='' )
      '' 
    #ELSE
        IF( le.Input_zonecontact_country = (TYPEOF(le.Input_zonecontact_country))'','',':zonecontact_country')
    #END
 
+    #IF( #TEXT(Input_zonecontact_fax)='' )
      '' 
    #ELSE
        IF( le.Input_zonecontact_fax = (TYPEOF(le.Input_zonecontact_fax))'','',':zonecontact_fax')
    #END
 
+    #IF( #TEXT(Input_zonecontact_faxext)='' )
      '' 
    #ELSE
        IF( le.Input_zonecontact_faxext = (TYPEOF(le.Input_zonecontact_faxext))'','',':zonecontact_faxext')
    #END
 
+    #IF( #TEXT(Input_zonecontact_phone)='' )
      '' 
    #ELSE
        IF( le.Input_zonecontact_phone = (TYPEOF(le.Input_zonecontact_phone))'','',':zonecontact_phone')
    #END
 
+    #IF( #TEXT(Input_zonecontact_phoneext)='' )
      '' 
    #ELSE
        IF( le.Input_zonecontact_phoneext = (TYPEOF(le.Input_zonecontact_phoneext))'','',':zonecontact_phoneext')
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
