 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_src_rid = '',Input_rid = '',Input_bdid = '',Input_powid = '',Input_proxid = '',Input_seleid = '',Input_orgid = '',Input_ultid = '',Input_date_first_seen = '',Input_date_last_seen = '',Input_date_vendor_first_reported = '',Input_date_vendor_last_reported = '',Input_physical_rawaid = '',Input_physical_aceaid = '',Input_mailing_rawaid = '',Input_mailing_aceaid = '',Input_record_type = '',Input_file_type = '',Input_lncagid = '',Input_lncaghid = '',Input_lncaiid = '',Input_rawfields_enterprise_num = '',Input_rawfields_parent_enterprise_number = '',Input_rawfields_ultimate_enterprise_number = '',Input_rawfields_company_type = '',Input_rawfields_name = '',Input_rawfields_e_mail = '',Input_rawfields_url = '',Input_rawfields_incorp = '',Input_rawfields_sic1 = '',Input_rawfields_sic2 = '',Input_rawfields_sic3 = '',Input_rawfields_sic4 = '',Input_rawfields_sic5 = '',Input_rawfields_sic6 = '',Input_rawfields_sic7 = '',Input_rawfields_sic8 = '',Input_rawfields_sic9 = '',Input_rawfields_sic10 = '',Input_rawfields_naics1 = '',Input_rawfields_naics2 = '',Input_rawfields_naics3 = '',Input_rawfields_naics4 = '',Input_rawfields_naics5 = '',Input_rawfields_naics6 = '',Input_rawfields_naics7 = '',Input_rawfields_naics8 = '',Input_rawfields_naics9 = '',Input_rawfields_naics10 = '',Input_physical_address_prim_name = '',Input_physical_address_p_city_name = '',Input_physical_address_v_city_name = '',Input_physical_address_st = '',Input_physical_address_zip = '',Input_mailing_address_prim_name = '',Input_mailing_address_p_city_name = '',Input_mailing_address_v_city_name = '',Input_mailing_address_st = '',Input_mailing_address_zip = '',Input_clean_phones_phone = '',Input_clean_phones_fax = '',Input_clean_phones_telex = '',Input_clean_dates_update_date = '',OutFile) := MACRO
  IMPORT SALT34,Scrubs_DCA;
  #uniquename(of)
  %of% := RECORD
    SALT34.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_src_rid)='' )
      '' 
    #ELSE
        IF( le.Input_src_rid = (TYPEOF(le.Input_src_rid))'','',':src_rid')
    #END
 
+    #IF( #TEXT(Input_rid)='' )
      '' 
    #ELSE
        IF( le.Input_rid = (TYPEOF(le.Input_rid))'','',':rid')
    #END
 
+    #IF( #TEXT(Input_bdid)='' )
      '' 
    #ELSE
        IF( le.Input_bdid = (TYPEOF(le.Input_bdid))'','',':bdid')
    #END
 
+    #IF( #TEXT(Input_powid)='' )
      '' 
    #ELSE
        IF( le.Input_powid = (TYPEOF(le.Input_powid))'','',':powid')
    #END
 
+    #IF( #TEXT(Input_proxid)='' )
      '' 
    #ELSE
        IF( le.Input_proxid = (TYPEOF(le.Input_proxid))'','',':proxid')
    #END
 
+    #IF( #TEXT(Input_seleid)='' )
      '' 
    #ELSE
        IF( le.Input_seleid = (TYPEOF(le.Input_seleid))'','',':seleid')
    #END
 
+    #IF( #TEXT(Input_orgid)='' )
      '' 
    #ELSE
        IF( le.Input_orgid = (TYPEOF(le.Input_orgid))'','',':orgid')
    #END
 
+    #IF( #TEXT(Input_ultid)='' )
      '' 
    #ELSE
        IF( le.Input_ultid = (TYPEOF(le.Input_ultid))'','',':ultid')
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
 
+    #IF( #TEXT(Input_physical_rawaid)='' )
      '' 
    #ELSE
        IF( le.Input_physical_rawaid = (TYPEOF(le.Input_physical_rawaid))'','',':physical_rawaid')
    #END
 
+    #IF( #TEXT(Input_physical_aceaid)='' )
      '' 
    #ELSE
        IF( le.Input_physical_aceaid = (TYPEOF(le.Input_physical_aceaid))'','',':physical_aceaid')
    #END
 
+    #IF( #TEXT(Input_mailing_rawaid)='' )
      '' 
    #ELSE
        IF( le.Input_mailing_rawaid = (TYPEOF(le.Input_mailing_rawaid))'','',':mailing_rawaid')
    #END
 
+    #IF( #TEXT(Input_mailing_aceaid)='' )
      '' 
    #ELSE
        IF( le.Input_mailing_aceaid = (TYPEOF(le.Input_mailing_aceaid))'','',':mailing_aceaid')
    #END
 
+    #IF( #TEXT(Input_record_type)='' )
      '' 
    #ELSE
        IF( le.Input_record_type = (TYPEOF(le.Input_record_type))'','',':record_type')
    #END
 
+    #IF( #TEXT(Input_file_type)='' )
      '' 
    #ELSE
        IF( le.Input_file_type = (TYPEOF(le.Input_file_type))'','',':file_type')
    #END
 
+    #IF( #TEXT(Input_lncagid)='' )
      '' 
    #ELSE
        IF( le.Input_lncagid = (TYPEOF(le.Input_lncagid))'','',':lncagid')
    #END
 
+    #IF( #TEXT(Input_lncaghid)='' )
      '' 
    #ELSE
        IF( le.Input_lncaghid = (TYPEOF(le.Input_lncaghid))'','',':lncaghid')
    #END
 
+    #IF( #TEXT(Input_lncaiid)='' )
      '' 
    #ELSE
        IF( le.Input_lncaiid = (TYPEOF(le.Input_lncaiid))'','',':lncaiid')
    #END
 
+    #IF( #TEXT(Input_rawfields_enterprise_num)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_enterprise_num = (TYPEOF(le.Input_rawfields_enterprise_num))'','',':rawfields_enterprise_num')
    #END
 
+    #IF( #TEXT(Input_rawfields_parent_enterprise_number)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_parent_enterprise_number = (TYPEOF(le.Input_rawfields_parent_enterprise_number))'','',':rawfields_parent_enterprise_number')
    #END
 
+    #IF( #TEXT(Input_rawfields_ultimate_enterprise_number)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_ultimate_enterprise_number = (TYPEOF(le.Input_rawfields_ultimate_enterprise_number))'','',':rawfields_ultimate_enterprise_number')
    #END
 
+    #IF( #TEXT(Input_rawfields_company_type)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_company_type = (TYPEOF(le.Input_rawfields_company_type))'','',':rawfields_company_type')
    #END
 
+    #IF( #TEXT(Input_rawfields_name)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_name = (TYPEOF(le.Input_rawfields_name))'','',':rawfields_name')
    #END
 
+    #IF( #TEXT(Input_rawfields_e_mail)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_e_mail = (TYPEOF(le.Input_rawfields_e_mail))'','',':rawfields_e_mail')
    #END
 
+    #IF( #TEXT(Input_rawfields_url)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_url = (TYPEOF(le.Input_rawfields_url))'','',':rawfields_url')
    #END
 
+    #IF( #TEXT(Input_rawfields_incorp)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_incorp = (TYPEOF(le.Input_rawfields_incorp))'','',':rawfields_incorp')
    #END
 
+    #IF( #TEXT(Input_rawfields_sic1)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_sic1 = (TYPEOF(le.Input_rawfields_sic1))'','',':rawfields_sic1')
    #END
 
+    #IF( #TEXT(Input_rawfields_sic2)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_sic2 = (TYPEOF(le.Input_rawfields_sic2))'','',':rawfields_sic2')
    #END
 
+    #IF( #TEXT(Input_rawfields_sic3)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_sic3 = (TYPEOF(le.Input_rawfields_sic3))'','',':rawfields_sic3')
    #END
 
+    #IF( #TEXT(Input_rawfields_sic4)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_sic4 = (TYPEOF(le.Input_rawfields_sic4))'','',':rawfields_sic4')
    #END
 
+    #IF( #TEXT(Input_rawfields_sic5)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_sic5 = (TYPEOF(le.Input_rawfields_sic5))'','',':rawfields_sic5')
    #END
 
+    #IF( #TEXT(Input_rawfields_sic6)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_sic6 = (TYPEOF(le.Input_rawfields_sic6))'','',':rawfields_sic6')
    #END
 
+    #IF( #TEXT(Input_rawfields_sic7)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_sic7 = (TYPEOF(le.Input_rawfields_sic7))'','',':rawfields_sic7')
    #END
 
+    #IF( #TEXT(Input_rawfields_sic8)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_sic8 = (TYPEOF(le.Input_rawfields_sic8))'','',':rawfields_sic8')
    #END
 
+    #IF( #TEXT(Input_rawfields_sic9)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_sic9 = (TYPEOF(le.Input_rawfields_sic9))'','',':rawfields_sic9')
    #END
 
+    #IF( #TEXT(Input_rawfields_sic10)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_sic10 = (TYPEOF(le.Input_rawfields_sic10))'','',':rawfields_sic10')
    #END
 
+    #IF( #TEXT(Input_rawfields_naics1)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_naics1 = (TYPEOF(le.Input_rawfields_naics1))'','',':rawfields_naics1')
    #END
 
+    #IF( #TEXT(Input_rawfields_naics2)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_naics2 = (TYPEOF(le.Input_rawfields_naics2))'','',':rawfields_naics2')
    #END
 
+    #IF( #TEXT(Input_rawfields_naics3)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_naics3 = (TYPEOF(le.Input_rawfields_naics3))'','',':rawfields_naics3')
    #END
 
+    #IF( #TEXT(Input_rawfields_naics4)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_naics4 = (TYPEOF(le.Input_rawfields_naics4))'','',':rawfields_naics4')
    #END
 
+    #IF( #TEXT(Input_rawfields_naics5)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_naics5 = (TYPEOF(le.Input_rawfields_naics5))'','',':rawfields_naics5')
    #END
 
+    #IF( #TEXT(Input_rawfields_naics6)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_naics6 = (TYPEOF(le.Input_rawfields_naics6))'','',':rawfields_naics6')
    #END
 
+    #IF( #TEXT(Input_rawfields_naics7)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_naics7 = (TYPEOF(le.Input_rawfields_naics7))'','',':rawfields_naics7')
    #END
 
+    #IF( #TEXT(Input_rawfields_naics8)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_naics8 = (TYPEOF(le.Input_rawfields_naics8))'','',':rawfields_naics8')
    #END
 
+    #IF( #TEXT(Input_rawfields_naics9)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_naics9 = (TYPEOF(le.Input_rawfields_naics9))'','',':rawfields_naics9')
    #END
 
+    #IF( #TEXT(Input_rawfields_naics10)='' )
      '' 
    #ELSE
        IF( le.Input_rawfields_naics10 = (TYPEOF(le.Input_rawfields_naics10))'','',':rawfields_naics10')
    #END
 
+    #IF( #TEXT(Input_physical_address_prim_name)='' )
      '' 
    #ELSE
        IF( le.Input_physical_address_prim_name = (TYPEOF(le.Input_physical_address_prim_name))'','',':physical_address_prim_name')
    #END
 
+    #IF( #TEXT(Input_physical_address_p_city_name)='' )
      '' 
    #ELSE
        IF( le.Input_physical_address_p_city_name = (TYPEOF(le.Input_physical_address_p_city_name))'','',':physical_address_p_city_name')
    #END
 
+    #IF( #TEXT(Input_physical_address_v_city_name)='' )
      '' 
    #ELSE
        IF( le.Input_physical_address_v_city_name = (TYPEOF(le.Input_physical_address_v_city_name))'','',':physical_address_v_city_name')
    #END
 
+    #IF( #TEXT(Input_physical_address_st)='' )
      '' 
    #ELSE
        IF( le.Input_physical_address_st = (TYPEOF(le.Input_physical_address_st))'','',':physical_address_st')
    #END
 
+    #IF( #TEXT(Input_physical_address_zip)='' )
      '' 
    #ELSE
        IF( le.Input_physical_address_zip = (TYPEOF(le.Input_physical_address_zip))'','',':physical_address_zip')
    #END
 
+    #IF( #TEXT(Input_mailing_address_prim_name)='' )
      '' 
    #ELSE
        IF( le.Input_mailing_address_prim_name = (TYPEOF(le.Input_mailing_address_prim_name))'','',':mailing_address_prim_name')
    #END
 
+    #IF( #TEXT(Input_mailing_address_p_city_name)='' )
      '' 
    #ELSE
        IF( le.Input_mailing_address_p_city_name = (TYPEOF(le.Input_mailing_address_p_city_name))'','',':mailing_address_p_city_name')
    #END
 
+    #IF( #TEXT(Input_mailing_address_v_city_name)='' )
      '' 
    #ELSE
        IF( le.Input_mailing_address_v_city_name = (TYPEOF(le.Input_mailing_address_v_city_name))'','',':mailing_address_v_city_name')
    #END
 
+    #IF( #TEXT(Input_mailing_address_st)='' )
      '' 
    #ELSE
        IF( le.Input_mailing_address_st = (TYPEOF(le.Input_mailing_address_st))'','',':mailing_address_st')
    #END
 
+    #IF( #TEXT(Input_mailing_address_zip)='' )
      '' 
    #ELSE
        IF( le.Input_mailing_address_zip = (TYPEOF(le.Input_mailing_address_zip))'','',':mailing_address_zip')
    #END
 
+    #IF( #TEXT(Input_clean_phones_phone)='' )
      '' 
    #ELSE
        IF( le.Input_clean_phones_phone = (TYPEOF(le.Input_clean_phones_phone))'','',':clean_phones_phone')
    #END
 
+    #IF( #TEXT(Input_clean_phones_fax)='' )
      '' 
    #ELSE
        IF( le.Input_clean_phones_fax = (TYPEOF(le.Input_clean_phones_fax))'','',':clean_phones_fax')
    #END
 
+    #IF( #TEXT(Input_clean_phones_telex)='' )
      '' 
    #ELSE
        IF( le.Input_clean_phones_telex = (TYPEOF(le.Input_clean_phones_telex))'','',':clean_phones_telex')
    #END
 
+    #IF( #TEXT(Input_clean_dates_update_date)='' )
      '' 
    #ELSE
        IF( le.Input_clean_dates_update_date = (TYPEOF(le.Input_clean_dates_update_date))'','',':clean_dates_update_date')
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
