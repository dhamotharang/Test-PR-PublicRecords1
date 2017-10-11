 
EXPORT raw_file_MAC_PopulationStatistics(infile,Ref='',Input_dl_state = '',Input_dl_num = '',Input_ssn = '',Input_dl_issue_dte = '',Input_dl_expire_dte = '',Input_house_bldg_num = '',Input_street_suffix = '',Input_apt_num = '',Input_unit_desc = '',Input_street_post_dir = '',Input_street_pre_dir = '',Input_state = '',Input_zip = '',Input_zip4 = '',Input_dob = '',Input_deceased_dte = '',Input_home_tel_area = '',Input_home_tel_num = '',Input_work_tel_area = '',Input_work_tel_num = '',Input_work_tel_ext = '',Input_upd_dte_time = '',Input_first_name = '',Input_mid_name = '',Input_last_name = '',Input_gen_delivery = '',Input_street_name = '',Input_city = '',Input_foreign_cntry = '',OutFile) := MACRO
  IMPORT SALT38,Scrubs_Certegy;
  #uniquename(of)
  %of% := RECORD
    SALT38.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_dl_state)='' )
      '' 
    #ELSE
        IF( le.Input_dl_state = (TYPEOF(le.Input_dl_state))'','',':dl_state')
    #END
 
+    #IF( #TEXT(Input_dl_num)='' )
      '' 
    #ELSE
        IF( le.Input_dl_num = (TYPEOF(le.Input_dl_num))'','',':dl_num')
    #END
 
+    #IF( #TEXT(Input_ssn)='' )
      '' 
    #ELSE
        IF( le.Input_ssn = (TYPEOF(le.Input_ssn))'','',':ssn')
    #END
 
+    #IF( #TEXT(Input_dl_issue_dte)='' )
      '' 
    #ELSE
        IF( le.Input_dl_issue_dte = (TYPEOF(le.Input_dl_issue_dte))'','',':dl_issue_dte')
    #END
 
+    #IF( #TEXT(Input_dl_expire_dte)='' )
      '' 
    #ELSE
        IF( le.Input_dl_expire_dte = (TYPEOF(le.Input_dl_expire_dte))'','',':dl_expire_dte')
    #END
 
+    #IF( #TEXT(Input_house_bldg_num)='' )
      '' 
    #ELSE
        IF( le.Input_house_bldg_num = (TYPEOF(le.Input_house_bldg_num))'','',':house_bldg_num')
    #END
 
+    #IF( #TEXT(Input_street_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_street_suffix = (TYPEOF(le.Input_street_suffix))'','',':street_suffix')
    #END
 
+    #IF( #TEXT(Input_apt_num)='' )
      '' 
    #ELSE
        IF( le.Input_apt_num = (TYPEOF(le.Input_apt_num))'','',':apt_num')
    #END
 
+    #IF( #TEXT(Input_unit_desc)='' )
      '' 
    #ELSE
        IF( le.Input_unit_desc = (TYPEOF(le.Input_unit_desc))'','',':unit_desc')
    #END
 
+    #IF( #TEXT(Input_street_post_dir)='' )
      '' 
    #ELSE
        IF( le.Input_street_post_dir = (TYPEOF(le.Input_street_post_dir))'','',':street_post_dir')
    #END
 
+    #IF( #TEXT(Input_street_pre_dir)='' )
      '' 
    #ELSE
        IF( le.Input_street_pre_dir = (TYPEOF(le.Input_street_pre_dir))'','',':street_pre_dir')
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
 
+    #IF( #TEXT(Input_dob)='' )
      '' 
    #ELSE
        IF( le.Input_dob = (TYPEOF(le.Input_dob))'','',':dob')
    #END
 
+    #IF( #TEXT(Input_deceased_dte)='' )
      '' 
    #ELSE
        IF( le.Input_deceased_dte = (TYPEOF(le.Input_deceased_dte))'','',':deceased_dte')
    #END
 
+    #IF( #TEXT(Input_home_tel_area)='' )
      '' 
    #ELSE
        IF( le.Input_home_tel_area = (TYPEOF(le.Input_home_tel_area))'','',':home_tel_area')
    #END
 
+    #IF( #TEXT(Input_home_tel_num)='' )
      '' 
    #ELSE
        IF( le.Input_home_tel_num = (TYPEOF(le.Input_home_tel_num))'','',':home_tel_num')
    #END
 
+    #IF( #TEXT(Input_work_tel_area)='' )
      '' 
    #ELSE
        IF( le.Input_work_tel_area = (TYPEOF(le.Input_work_tel_area))'','',':work_tel_area')
    #END
 
+    #IF( #TEXT(Input_work_tel_num)='' )
      '' 
    #ELSE
        IF( le.Input_work_tel_num = (TYPEOF(le.Input_work_tel_num))'','',':work_tel_num')
    #END
 
+    #IF( #TEXT(Input_work_tel_ext)='' )
      '' 
    #ELSE
        IF( le.Input_work_tel_ext = (TYPEOF(le.Input_work_tel_ext))'','',':work_tel_ext')
    #END
 
+    #IF( #TEXT(Input_upd_dte_time)='' )
      '' 
    #ELSE
        IF( le.Input_upd_dte_time = (TYPEOF(le.Input_upd_dte_time))'','',':upd_dte_time')
    #END
 
+    #IF( #TEXT(Input_first_name)='' )
      '' 
    #ELSE
        IF( le.Input_first_name = (TYPEOF(le.Input_first_name))'','',':first_name')
    #END
 
+    #IF( #TEXT(Input_mid_name)='' )
      '' 
    #ELSE
        IF( le.Input_mid_name = (TYPEOF(le.Input_mid_name))'','',':mid_name')
    #END
 
+    #IF( #TEXT(Input_last_name)='' )
      '' 
    #ELSE
        IF( le.Input_last_name = (TYPEOF(le.Input_last_name))'','',':last_name')
    #END
 
+    #IF( #TEXT(Input_gen_delivery)='' )
      '' 
    #ELSE
        IF( le.Input_gen_delivery = (TYPEOF(le.Input_gen_delivery))'','',':gen_delivery')
    #END
 
+    #IF( #TEXT(Input_street_name)='' )
      '' 
    #ELSE
        IF( le.Input_street_name = (TYPEOF(le.Input_street_name))'','',':street_name')
    #END
 
+    #IF( #TEXT(Input_city)='' )
      '' 
    #ELSE
        IF( le.Input_city = (TYPEOF(le.Input_city))'','',':city')
    #END
 
+    #IF( #TEXT(Input_foreign_cntry)='' )
      '' 
    #ELSE
        IF( le.Input_foreign_cntry = (TYPEOF(le.Input_foreign_cntry))'','',':foreign_cntry')
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
