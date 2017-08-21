 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_ofc1_name = '',Input_ofc1_title = '',Input_ofc1_gender = '',Input_ofc1_add = '',Input_ofc1_suite = '',Input_ofc1_city = '',Input_ofc1_state = '',Input_ofc1_zip = '',Input_ofc1_ac = '',Input_ofc1_phone = '',Input_ofc1_fein = '',Input_ofc1_ssn = '',Input_ofc1_type = '',Input_company = '',Input_mail_add = '',Input_mail_suite = '',Input_mail_city = '',Input_mail_state = '',Input_mail_zip = '',Input_mail_zip4 = '',Input_mail_key = '',Input_county = '',Input_country = '',Input_district = '',Input_biz_ac = '',Input_biz_phone = '',Input_sic = '',Input_naics = '',Input_descript = '',Input_emp_size = '',Input_own_size = '',Input_corpcode = '',Input_sos_code = '',Input_filing_cod = '',Input_state_code = '',Input_status = '',Input_filing_num = '',Input_ctrl_num = '',Input_start_date = '',Input_file_date = '',Input_form_date = '',Input_exp_date = '',Input_disol_date = '',Input_rpt_date = '',Input_chang_date = '',Input_loc_add = '',Input_loc_suite = '',Input_loc_city = '',Input_loc_state = '',Input_loc_zip = '',Input_loc_zip4 = '',Input_ofc2_name = '',Input_ofc2_title = '',Input_ofc2_add = '',Input_ofc2_csz = '',Input_ofc2_fein = '',Input_ofc2_ssn = '',Input_ofc3_name = '',Input_ofc3_title = '',Input_ofc3_add = '',Input_ofc3_csz = '',Input_ofc3_fein = '',Input_ofc3_ssn = '',Input_ofc4_name = '',Input_ofc4_title = '',Input_ofc4_add = '',Input_ofc4_csz = '',Input_ofc4_fein = '',Input_ofc4_ssn = '',Input_ofc5_name = '',Input_ofc5_title = '',Input_ofc5_add = '',Input_ofc5_csz = '',Input_ofc5_fein = '',Input_ofc5_ssn = '',Input_ofc6_name = '',Input_ofc6_title = '',Input_ofc6_add = '',Input_ofc6_csz = '',Input_ofc6_fein = '',Input_ofc6_ssn = '',Input_fee = '',Input_fee_2 = '',Input_tax_cl = '',Input_perm_type = '',Input_page = '',Input_volume = '',Input_comments = '',Input_jurisdiction = '',Input_adcrecordno = '',Input_crlf = '',OutFile) := MACRO
  IMPORT SALT36,Scrubs_BusReg;
  #uniquename(of)
  %of% := RECORD
    SALT36.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_ofc1_name)='' )
      '' 
    #ELSE
        IF( le.Input_ofc1_name = (TYPEOF(le.Input_ofc1_name))'','',':ofc1_name')
    #END
 
+    #IF( #TEXT(Input_ofc1_title)='' )
      '' 
    #ELSE
        IF( le.Input_ofc1_title = (TYPEOF(le.Input_ofc1_title))'','',':ofc1_title')
    #END
 
+    #IF( #TEXT(Input_ofc1_gender)='' )
      '' 
    #ELSE
        IF( le.Input_ofc1_gender = (TYPEOF(le.Input_ofc1_gender))'','',':ofc1_gender')
    #END
 
+    #IF( #TEXT(Input_ofc1_add)='' )
      '' 
    #ELSE
        IF( le.Input_ofc1_add = (TYPEOF(le.Input_ofc1_add))'','',':ofc1_add')
    #END
 
+    #IF( #TEXT(Input_ofc1_suite)='' )
      '' 
    #ELSE
        IF( le.Input_ofc1_suite = (TYPEOF(le.Input_ofc1_suite))'','',':ofc1_suite')
    #END
 
+    #IF( #TEXT(Input_ofc1_city)='' )
      '' 
    #ELSE
        IF( le.Input_ofc1_city = (TYPEOF(le.Input_ofc1_city))'','',':ofc1_city')
    #END
 
+    #IF( #TEXT(Input_ofc1_state)='' )
      '' 
    #ELSE
        IF( le.Input_ofc1_state = (TYPEOF(le.Input_ofc1_state))'','',':ofc1_state')
    #END
 
+    #IF( #TEXT(Input_ofc1_zip)='' )
      '' 
    #ELSE
        IF( le.Input_ofc1_zip = (TYPEOF(le.Input_ofc1_zip))'','',':ofc1_zip')
    #END
 
+    #IF( #TEXT(Input_ofc1_ac)='' )
      '' 
    #ELSE
        IF( le.Input_ofc1_ac = (TYPEOF(le.Input_ofc1_ac))'','',':ofc1_ac')
    #END
 
+    #IF( #TEXT(Input_ofc1_phone)='' )
      '' 
    #ELSE
        IF( le.Input_ofc1_phone = (TYPEOF(le.Input_ofc1_phone))'','',':ofc1_phone')
    #END
 
+    #IF( #TEXT(Input_ofc1_fein)='' )
      '' 
    #ELSE
        IF( le.Input_ofc1_fein = (TYPEOF(le.Input_ofc1_fein))'','',':ofc1_fein')
    #END
 
+    #IF( #TEXT(Input_ofc1_ssn)='' )
      '' 
    #ELSE
        IF( le.Input_ofc1_ssn = (TYPEOF(le.Input_ofc1_ssn))'','',':ofc1_ssn')
    #END
 
+    #IF( #TEXT(Input_ofc1_type)='' )
      '' 
    #ELSE
        IF( le.Input_ofc1_type = (TYPEOF(le.Input_ofc1_type))'','',':ofc1_type')
    #END
 
+    #IF( #TEXT(Input_company)='' )
      '' 
    #ELSE
        IF( le.Input_company = (TYPEOF(le.Input_company))'','',':company')
    #END
 
+    #IF( #TEXT(Input_mail_add)='' )
      '' 
    #ELSE
        IF( le.Input_mail_add = (TYPEOF(le.Input_mail_add))'','',':mail_add')
    #END
 
+    #IF( #TEXT(Input_mail_suite)='' )
      '' 
    #ELSE
        IF( le.Input_mail_suite = (TYPEOF(le.Input_mail_suite))'','',':mail_suite')
    #END
 
+    #IF( #TEXT(Input_mail_city)='' )
      '' 
    #ELSE
        IF( le.Input_mail_city = (TYPEOF(le.Input_mail_city))'','',':mail_city')
    #END
 
+    #IF( #TEXT(Input_mail_state)='' )
      '' 
    #ELSE
        IF( le.Input_mail_state = (TYPEOF(le.Input_mail_state))'','',':mail_state')
    #END
 
+    #IF( #TEXT(Input_mail_zip)='' )
      '' 
    #ELSE
        IF( le.Input_mail_zip = (TYPEOF(le.Input_mail_zip))'','',':mail_zip')
    #END
 
+    #IF( #TEXT(Input_mail_zip4)='' )
      '' 
    #ELSE
        IF( le.Input_mail_zip4 = (TYPEOF(le.Input_mail_zip4))'','',':mail_zip4')
    #END
 
+    #IF( #TEXT(Input_mail_key)='' )
      '' 
    #ELSE
        IF( le.Input_mail_key = (TYPEOF(le.Input_mail_key))'','',':mail_key')
    #END
 
+    #IF( #TEXT(Input_county)='' )
      '' 
    #ELSE
        IF( le.Input_county = (TYPEOF(le.Input_county))'','',':county')
    #END
 
+    #IF( #TEXT(Input_country)='' )
      '' 
    #ELSE
        IF( le.Input_country = (TYPEOF(le.Input_country))'','',':country')
    #END
 
+    #IF( #TEXT(Input_district)='' )
      '' 
    #ELSE
        IF( le.Input_district = (TYPEOF(le.Input_district))'','',':district')
    #END
 
+    #IF( #TEXT(Input_biz_ac)='' )
      '' 
    #ELSE
        IF( le.Input_biz_ac = (TYPEOF(le.Input_biz_ac))'','',':biz_ac')
    #END
 
+    #IF( #TEXT(Input_biz_phone)='' )
      '' 
    #ELSE
        IF( le.Input_biz_phone = (TYPEOF(le.Input_biz_phone))'','',':biz_phone')
    #END
 
+    #IF( #TEXT(Input_sic)='' )
      '' 
    #ELSE
        IF( le.Input_sic = (TYPEOF(le.Input_sic))'','',':sic')
    #END
 
+    #IF( #TEXT(Input_naics)='' )
      '' 
    #ELSE
        IF( le.Input_naics = (TYPEOF(le.Input_naics))'','',':naics')
    #END
 
+    #IF( #TEXT(Input_descript)='' )
      '' 
    #ELSE
        IF( le.Input_descript = (TYPEOF(le.Input_descript))'','',':descript')
    #END
 
+    #IF( #TEXT(Input_emp_size)='' )
      '' 
    #ELSE
        IF( le.Input_emp_size = (TYPEOF(le.Input_emp_size))'','',':emp_size')
    #END
 
+    #IF( #TEXT(Input_own_size)='' )
      '' 
    #ELSE
        IF( le.Input_own_size = (TYPEOF(le.Input_own_size))'','',':own_size')
    #END
 
+    #IF( #TEXT(Input_corpcode)='' )
      '' 
    #ELSE
        IF( le.Input_corpcode = (TYPEOF(le.Input_corpcode))'','',':corpcode')
    #END
 
+    #IF( #TEXT(Input_sos_code)='' )
      '' 
    #ELSE
        IF( le.Input_sos_code = (TYPEOF(le.Input_sos_code))'','',':sos_code')
    #END
 
+    #IF( #TEXT(Input_filing_cod)='' )
      '' 
    #ELSE
        IF( le.Input_filing_cod = (TYPEOF(le.Input_filing_cod))'','',':filing_cod')
    #END
 
+    #IF( #TEXT(Input_state_code)='' )
      '' 
    #ELSE
        IF( le.Input_state_code = (TYPEOF(le.Input_state_code))'','',':state_code')
    #END
 
+    #IF( #TEXT(Input_status)='' )
      '' 
    #ELSE
        IF( le.Input_status = (TYPEOF(le.Input_status))'','',':status')
    #END
 
+    #IF( #TEXT(Input_filing_num)='' )
      '' 
    #ELSE
        IF( le.Input_filing_num = (TYPEOF(le.Input_filing_num))'','',':filing_num')
    #END
 
+    #IF( #TEXT(Input_ctrl_num)='' )
      '' 
    #ELSE
        IF( le.Input_ctrl_num = (TYPEOF(le.Input_ctrl_num))'','',':ctrl_num')
    #END
 
+    #IF( #TEXT(Input_start_date)='' )
      '' 
    #ELSE
        IF( le.Input_start_date = (TYPEOF(le.Input_start_date))'','',':start_date')
    #END
 
+    #IF( #TEXT(Input_file_date)='' )
      '' 
    #ELSE
        IF( le.Input_file_date = (TYPEOF(le.Input_file_date))'','',':file_date')
    #END
 
+    #IF( #TEXT(Input_form_date)='' )
      '' 
    #ELSE
        IF( le.Input_form_date = (TYPEOF(le.Input_form_date))'','',':form_date')
    #END
 
+    #IF( #TEXT(Input_exp_date)='' )
      '' 
    #ELSE
        IF( le.Input_exp_date = (TYPEOF(le.Input_exp_date))'','',':exp_date')
    #END
 
+    #IF( #TEXT(Input_disol_date)='' )
      '' 
    #ELSE
        IF( le.Input_disol_date = (TYPEOF(le.Input_disol_date))'','',':disol_date')
    #END
 
+    #IF( #TEXT(Input_rpt_date)='' )
      '' 
    #ELSE
        IF( le.Input_rpt_date = (TYPEOF(le.Input_rpt_date))'','',':rpt_date')
    #END
 
+    #IF( #TEXT(Input_chang_date)='' )
      '' 
    #ELSE
        IF( le.Input_chang_date = (TYPEOF(le.Input_chang_date))'','',':chang_date')
    #END
 
+    #IF( #TEXT(Input_loc_add)='' )
      '' 
    #ELSE
        IF( le.Input_loc_add = (TYPEOF(le.Input_loc_add))'','',':loc_add')
    #END
 
+    #IF( #TEXT(Input_loc_suite)='' )
      '' 
    #ELSE
        IF( le.Input_loc_suite = (TYPEOF(le.Input_loc_suite))'','',':loc_suite')
    #END
 
+    #IF( #TEXT(Input_loc_city)='' )
      '' 
    #ELSE
        IF( le.Input_loc_city = (TYPEOF(le.Input_loc_city))'','',':loc_city')
    #END
 
+    #IF( #TEXT(Input_loc_state)='' )
      '' 
    #ELSE
        IF( le.Input_loc_state = (TYPEOF(le.Input_loc_state))'','',':loc_state')
    #END
 
+    #IF( #TEXT(Input_loc_zip)='' )
      '' 
    #ELSE
        IF( le.Input_loc_zip = (TYPEOF(le.Input_loc_zip))'','',':loc_zip')
    #END
 
+    #IF( #TEXT(Input_loc_zip4)='' )
      '' 
    #ELSE
        IF( le.Input_loc_zip4 = (TYPEOF(le.Input_loc_zip4))'','',':loc_zip4')
    #END
 
+    #IF( #TEXT(Input_ofc2_name)='' )
      '' 
    #ELSE
        IF( le.Input_ofc2_name = (TYPEOF(le.Input_ofc2_name))'','',':ofc2_name')
    #END
 
+    #IF( #TEXT(Input_ofc2_title)='' )
      '' 
    #ELSE
        IF( le.Input_ofc2_title = (TYPEOF(le.Input_ofc2_title))'','',':ofc2_title')
    #END
 
+    #IF( #TEXT(Input_ofc2_add)='' )
      '' 
    #ELSE
        IF( le.Input_ofc2_add = (TYPEOF(le.Input_ofc2_add))'','',':ofc2_add')
    #END
 
+    #IF( #TEXT(Input_ofc2_csz)='' )
      '' 
    #ELSE
        IF( le.Input_ofc2_csz = (TYPEOF(le.Input_ofc2_csz))'','',':ofc2_csz')
    #END
 
+    #IF( #TEXT(Input_ofc2_fein)='' )
      '' 
    #ELSE
        IF( le.Input_ofc2_fein = (TYPEOF(le.Input_ofc2_fein))'','',':ofc2_fein')
    #END
 
+    #IF( #TEXT(Input_ofc2_ssn)='' )
      '' 
    #ELSE
        IF( le.Input_ofc2_ssn = (TYPEOF(le.Input_ofc2_ssn))'','',':ofc2_ssn')
    #END
 
+    #IF( #TEXT(Input_ofc3_name)='' )
      '' 
    #ELSE
        IF( le.Input_ofc3_name = (TYPEOF(le.Input_ofc3_name))'','',':ofc3_name')
    #END
 
+    #IF( #TEXT(Input_ofc3_title)='' )
      '' 
    #ELSE
        IF( le.Input_ofc3_title = (TYPEOF(le.Input_ofc3_title))'','',':ofc3_title')
    #END
 
+    #IF( #TEXT(Input_ofc3_add)='' )
      '' 
    #ELSE
        IF( le.Input_ofc3_add = (TYPEOF(le.Input_ofc3_add))'','',':ofc3_add')
    #END
 
+    #IF( #TEXT(Input_ofc3_csz)='' )
      '' 
    #ELSE
        IF( le.Input_ofc3_csz = (TYPEOF(le.Input_ofc3_csz))'','',':ofc3_csz')
    #END
 
+    #IF( #TEXT(Input_ofc3_fein)='' )
      '' 
    #ELSE
        IF( le.Input_ofc3_fein = (TYPEOF(le.Input_ofc3_fein))'','',':ofc3_fein')
    #END
 
+    #IF( #TEXT(Input_ofc3_ssn)='' )
      '' 
    #ELSE
        IF( le.Input_ofc3_ssn = (TYPEOF(le.Input_ofc3_ssn))'','',':ofc3_ssn')
    #END
 
+    #IF( #TEXT(Input_ofc4_name)='' )
      '' 
    #ELSE
        IF( le.Input_ofc4_name = (TYPEOF(le.Input_ofc4_name))'','',':ofc4_name')
    #END
 
+    #IF( #TEXT(Input_ofc4_title)='' )
      '' 
    #ELSE
        IF( le.Input_ofc4_title = (TYPEOF(le.Input_ofc4_title))'','',':ofc4_title')
    #END
 
+    #IF( #TEXT(Input_ofc4_add)='' )
      '' 
    #ELSE
        IF( le.Input_ofc4_add = (TYPEOF(le.Input_ofc4_add))'','',':ofc4_add')
    #END
 
+    #IF( #TEXT(Input_ofc4_csz)='' )
      '' 
    #ELSE
        IF( le.Input_ofc4_csz = (TYPEOF(le.Input_ofc4_csz))'','',':ofc4_csz')
    #END
 
+    #IF( #TEXT(Input_ofc4_fein)='' )
      '' 
    #ELSE
        IF( le.Input_ofc4_fein = (TYPEOF(le.Input_ofc4_fein))'','',':ofc4_fein')
    #END
 
+    #IF( #TEXT(Input_ofc4_ssn)='' )
      '' 
    #ELSE
        IF( le.Input_ofc4_ssn = (TYPEOF(le.Input_ofc4_ssn))'','',':ofc4_ssn')
    #END
 
+    #IF( #TEXT(Input_ofc5_name)='' )
      '' 
    #ELSE
        IF( le.Input_ofc5_name = (TYPEOF(le.Input_ofc5_name))'','',':ofc5_name')
    #END
 
+    #IF( #TEXT(Input_ofc5_title)='' )
      '' 
    #ELSE
        IF( le.Input_ofc5_title = (TYPEOF(le.Input_ofc5_title))'','',':ofc5_title')
    #END
 
+    #IF( #TEXT(Input_ofc5_add)='' )
      '' 
    #ELSE
        IF( le.Input_ofc5_add = (TYPEOF(le.Input_ofc5_add))'','',':ofc5_add')
    #END
 
+    #IF( #TEXT(Input_ofc5_csz)='' )
      '' 
    #ELSE
        IF( le.Input_ofc5_csz = (TYPEOF(le.Input_ofc5_csz))'','',':ofc5_csz')
    #END
 
+    #IF( #TEXT(Input_ofc5_fein)='' )
      '' 
    #ELSE
        IF( le.Input_ofc5_fein = (TYPEOF(le.Input_ofc5_fein))'','',':ofc5_fein')
    #END
 
+    #IF( #TEXT(Input_ofc5_ssn)='' )
      '' 
    #ELSE
        IF( le.Input_ofc5_ssn = (TYPEOF(le.Input_ofc5_ssn))'','',':ofc5_ssn')
    #END
 
+    #IF( #TEXT(Input_ofc6_name)='' )
      '' 
    #ELSE
        IF( le.Input_ofc6_name = (TYPEOF(le.Input_ofc6_name))'','',':ofc6_name')
    #END
 
+    #IF( #TEXT(Input_ofc6_title)='' )
      '' 
    #ELSE
        IF( le.Input_ofc6_title = (TYPEOF(le.Input_ofc6_title))'','',':ofc6_title')
    #END
 
+    #IF( #TEXT(Input_ofc6_add)='' )
      '' 
    #ELSE
        IF( le.Input_ofc6_add = (TYPEOF(le.Input_ofc6_add))'','',':ofc6_add')
    #END
 
+    #IF( #TEXT(Input_ofc6_csz)='' )
      '' 
    #ELSE
        IF( le.Input_ofc6_csz = (TYPEOF(le.Input_ofc6_csz))'','',':ofc6_csz')
    #END
 
+    #IF( #TEXT(Input_ofc6_fein)='' )
      '' 
    #ELSE
        IF( le.Input_ofc6_fein = (TYPEOF(le.Input_ofc6_fein))'','',':ofc6_fein')
    #END
 
+    #IF( #TEXT(Input_ofc6_ssn)='' )
      '' 
    #ELSE
        IF( le.Input_ofc6_ssn = (TYPEOF(le.Input_ofc6_ssn))'','',':ofc6_ssn')
    #END
 
+    #IF( #TEXT(Input_fee)='' )
      '' 
    #ELSE
        IF( le.Input_fee = (TYPEOF(le.Input_fee))'','',':fee')
    #END
 
+    #IF( #TEXT(Input_fee_2)='' )
      '' 
    #ELSE
        IF( le.Input_fee_2 = (TYPEOF(le.Input_fee_2))'','',':fee_2')
    #END
 
+    #IF( #TEXT(Input_tax_cl)='' )
      '' 
    #ELSE
        IF( le.Input_tax_cl = (TYPEOF(le.Input_tax_cl))'','',':tax_cl')
    #END
 
+    #IF( #TEXT(Input_perm_type)='' )
      '' 
    #ELSE
        IF( le.Input_perm_type = (TYPEOF(le.Input_perm_type))'','',':perm_type')
    #END
 
+    #IF( #TEXT(Input_page)='' )
      '' 
    #ELSE
        IF( le.Input_page = (TYPEOF(le.Input_page))'','',':page')
    #END
 
+    #IF( #TEXT(Input_volume)='' )
      '' 
    #ELSE
        IF( le.Input_volume = (TYPEOF(le.Input_volume))'','',':volume')
    #END
 
+    #IF( #TEXT(Input_comments)='' )
      '' 
    #ELSE
        IF( le.Input_comments = (TYPEOF(le.Input_comments))'','',':comments')
    #END
 
+    #IF( #TEXT(Input_jurisdiction)='' )
      '' 
    #ELSE
        IF( le.Input_jurisdiction = (TYPEOF(le.Input_jurisdiction))'','',':jurisdiction')
    #END
 
+    #IF( #TEXT(Input_adcrecordno)='' )
      '' 
    #ELSE
        IF( le.Input_adcrecordno = (TYPEOF(le.Input_adcrecordno))'','',':adcrecordno')
    #END
 
+    #IF( #TEXT(Input_crlf)='' )
      '' 
    #ELSE
        IF( le.Input_crlf = (TYPEOF(le.Input_crlf))'','',':crlf')
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
