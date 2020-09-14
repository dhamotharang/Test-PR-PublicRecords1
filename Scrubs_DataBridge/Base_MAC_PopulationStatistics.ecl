 
EXPORT Base_MAC_PopulationStatistics(infile,Ref='',Input_dt_first_seen = '',Input_dt_last_seen = '',Input_dt_vendor_first_reported = '',Input_dt_vendor_last_reported = '',Input_process_date = '',Input_record_type = '',Input_clean_company_name = '',Input_clean_telephone_num = '',Input_state = '',Input_zip_code5 = '',Input_mail_score = '',Input_name_gender = '',Input_web_address = '',Input_sic8_1 = '',Input_sic8_2 = '',Input_sic8_3 = '',Input_sic8_4 = '',Input_sic6_1 = '',Input_sic6_2 = '',Input_sic6_3 = '',Input_sic6_4 = '',Input_sic6_5 = '',Input_transaction_date = '',Input_database_site_id = '',Input_database_individual_id = '',Input_email = '',Input_email_present_flag = '',Input_site_source1 = '',Input_site_source2 = '',Input_site_source3 = '',Input_site_source4 = '',Input_site_source5 = '',Input_site_source6 = '',Input_site_source7 = '',Input_site_source8 = '',Input_site_source9 = '',Input_site_source10 = '',Input_individual_source1 = '',Input_individual_source2 = '',Input_individual_source3 = '',Input_individual_source4 = '',Input_individual_source5 = '',Input_individual_source6 = '',Input_individual_source7 = '',Input_individual_source8 = '',Input_individual_source9 = '',Input_individual_source10 = '',Input_email_status = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_DataBridge;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
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
 
+    #IF( #TEXT(Input_process_date)='' )
      '' 
    #ELSE
        IF( le.Input_process_date = (TYPEOF(le.Input_process_date))'','',':process_date')
    #END
 
+    #IF( #TEXT(Input_record_type)='' )
      '' 
    #ELSE
        IF( le.Input_record_type = (TYPEOF(le.Input_record_type))'','',':record_type')
    #END
 
+    #IF( #TEXT(Input_clean_company_name)='' )
      '' 
    #ELSE
        IF( le.Input_clean_company_name = (TYPEOF(le.Input_clean_company_name))'','',':clean_company_name')
    #END
 
+    #IF( #TEXT(Input_clean_telephone_num)='' )
      '' 
    #ELSE
        IF( le.Input_clean_telephone_num = (TYPEOF(le.Input_clean_telephone_num))'','',':clean_telephone_num')
    #END
 
+    #IF( #TEXT(Input_state)='' )
      '' 
    #ELSE
        IF( le.Input_state = (TYPEOF(le.Input_state))'','',':state')
    #END
 
+    #IF( #TEXT(Input_zip_code5)='' )
      '' 
    #ELSE
        IF( le.Input_zip_code5 = (TYPEOF(le.Input_zip_code5))'','',':zip_code5')
    #END
 
+    #IF( #TEXT(Input_mail_score)='' )
      '' 
    #ELSE
        IF( le.Input_mail_score = (TYPEOF(le.Input_mail_score))'','',':mail_score')
    #END
 
+    #IF( #TEXT(Input_name_gender)='' )
      '' 
    #ELSE
        IF( le.Input_name_gender = (TYPEOF(le.Input_name_gender))'','',':name_gender')
    #END
 
+    #IF( #TEXT(Input_web_address)='' )
      '' 
    #ELSE
        IF( le.Input_web_address = (TYPEOF(le.Input_web_address))'','',':web_address')
    #END
 
+    #IF( #TEXT(Input_sic8_1)='' )
      '' 
    #ELSE
        IF( le.Input_sic8_1 = (TYPEOF(le.Input_sic8_1))'','',':sic8_1')
    #END
 
+    #IF( #TEXT(Input_sic8_2)='' )
      '' 
    #ELSE
        IF( le.Input_sic8_2 = (TYPEOF(le.Input_sic8_2))'','',':sic8_2')
    #END
 
+    #IF( #TEXT(Input_sic8_3)='' )
      '' 
    #ELSE
        IF( le.Input_sic8_3 = (TYPEOF(le.Input_sic8_3))'','',':sic8_3')
    #END
 
+    #IF( #TEXT(Input_sic8_4)='' )
      '' 
    #ELSE
        IF( le.Input_sic8_4 = (TYPEOF(le.Input_sic8_4))'','',':sic8_4')
    #END
 
+    #IF( #TEXT(Input_sic6_1)='' )
      '' 
    #ELSE
        IF( le.Input_sic6_1 = (TYPEOF(le.Input_sic6_1))'','',':sic6_1')
    #END
 
+    #IF( #TEXT(Input_sic6_2)='' )
      '' 
    #ELSE
        IF( le.Input_sic6_2 = (TYPEOF(le.Input_sic6_2))'','',':sic6_2')
    #END
 
+    #IF( #TEXT(Input_sic6_3)='' )
      '' 
    #ELSE
        IF( le.Input_sic6_3 = (TYPEOF(le.Input_sic6_3))'','',':sic6_3')
    #END
 
+    #IF( #TEXT(Input_sic6_4)='' )
      '' 
    #ELSE
        IF( le.Input_sic6_4 = (TYPEOF(le.Input_sic6_4))'','',':sic6_4')
    #END
 
+    #IF( #TEXT(Input_sic6_5)='' )
      '' 
    #ELSE
        IF( le.Input_sic6_5 = (TYPEOF(le.Input_sic6_5))'','',':sic6_5')
    #END
 
+    #IF( #TEXT(Input_transaction_date)='' )
      '' 
    #ELSE
        IF( le.Input_transaction_date = (TYPEOF(le.Input_transaction_date))'','',':transaction_date')
    #END
 
+    #IF( #TEXT(Input_database_site_id)='' )
      '' 
    #ELSE
        IF( le.Input_database_site_id = (TYPEOF(le.Input_database_site_id))'','',':database_site_id')
    #END
 
+    #IF( #TEXT(Input_database_individual_id)='' )
      '' 
    #ELSE
        IF( le.Input_database_individual_id = (TYPEOF(le.Input_database_individual_id))'','',':database_individual_id')
    #END
 
+    #IF( #TEXT(Input_email)='' )
      '' 
    #ELSE
        IF( le.Input_email = (TYPEOF(le.Input_email))'','',':email')
    #END
 
+    #IF( #TEXT(Input_email_present_flag)='' )
      '' 
    #ELSE
        IF( le.Input_email_present_flag = (TYPEOF(le.Input_email_present_flag))'','',':email_present_flag')
    #END
 
+    #IF( #TEXT(Input_site_source1)='' )
      '' 
    #ELSE
        IF( le.Input_site_source1 = (TYPEOF(le.Input_site_source1))'','',':site_source1')
    #END
 
+    #IF( #TEXT(Input_site_source2)='' )
      '' 
    #ELSE
        IF( le.Input_site_source2 = (TYPEOF(le.Input_site_source2))'','',':site_source2')
    #END
 
+    #IF( #TEXT(Input_site_source3)='' )
      '' 
    #ELSE
        IF( le.Input_site_source3 = (TYPEOF(le.Input_site_source3))'','',':site_source3')
    #END
 
+    #IF( #TEXT(Input_site_source4)='' )
      '' 
    #ELSE
        IF( le.Input_site_source4 = (TYPEOF(le.Input_site_source4))'','',':site_source4')
    #END
 
+    #IF( #TEXT(Input_site_source5)='' )
      '' 
    #ELSE
        IF( le.Input_site_source5 = (TYPEOF(le.Input_site_source5))'','',':site_source5')
    #END
 
+    #IF( #TEXT(Input_site_source6)='' )
      '' 
    #ELSE
        IF( le.Input_site_source6 = (TYPEOF(le.Input_site_source6))'','',':site_source6')
    #END
 
+    #IF( #TEXT(Input_site_source7)='' )
      '' 
    #ELSE
        IF( le.Input_site_source7 = (TYPEOF(le.Input_site_source7))'','',':site_source7')
    #END
 
+    #IF( #TEXT(Input_site_source8)='' )
      '' 
    #ELSE
        IF( le.Input_site_source8 = (TYPEOF(le.Input_site_source8))'','',':site_source8')
    #END
 
+    #IF( #TEXT(Input_site_source9)='' )
      '' 
    #ELSE
        IF( le.Input_site_source9 = (TYPEOF(le.Input_site_source9))'','',':site_source9')
    #END
 
+    #IF( #TEXT(Input_site_source10)='' )
      '' 
    #ELSE
        IF( le.Input_site_source10 = (TYPEOF(le.Input_site_source10))'','',':site_source10')
    #END
 
+    #IF( #TEXT(Input_individual_source1)='' )
      '' 
    #ELSE
        IF( le.Input_individual_source1 = (TYPEOF(le.Input_individual_source1))'','',':individual_source1')
    #END
 
+    #IF( #TEXT(Input_individual_source2)='' )
      '' 
    #ELSE
        IF( le.Input_individual_source2 = (TYPEOF(le.Input_individual_source2))'','',':individual_source2')
    #END
 
+    #IF( #TEXT(Input_individual_source3)='' )
      '' 
    #ELSE
        IF( le.Input_individual_source3 = (TYPEOF(le.Input_individual_source3))'','',':individual_source3')
    #END
 
+    #IF( #TEXT(Input_individual_source4)='' )
      '' 
    #ELSE
        IF( le.Input_individual_source4 = (TYPEOF(le.Input_individual_source4))'','',':individual_source4')
    #END
 
+    #IF( #TEXT(Input_individual_source5)='' )
      '' 
    #ELSE
        IF( le.Input_individual_source5 = (TYPEOF(le.Input_individual_source5))'','',':individual_source5')
    #END
 
+    #IF( #TEXT(Input_individual_source6)='' )
      '' 
    #ELSE
        IF( le.Input_individual_source6 = (TYPEOF(le.Input_individual_source6))'','',':individual_source6')
    #END
 
+    #IF( #TEXT(Input_individual_source7)='' )
      '' 
    #ELSE
        IF( le.Input_individual_source7 = (TYPEOF(le.Input_individual_source7))'','',':individual_source7')
    #END
 
+    #IF( #TEXT(Input_individual_source8)='' )
      '' 
    #ELSE
        IF( le.Input_individual_source8 = (TYPEOF(le.Input_individual_source8))'','',':individual_source8')
    #END
 
+    #IF( #TEXT(Input_individual_source9)='' )
      '' 
    #ELSE
        IF( le.Input_individual_source9 = (TYPEOF(le.Input_individual_source9))'','',':individual_source9')
    #END
 
+    #IF( #TEXT(Input_individual_source10)='' )
      '' 
    #ELSE
        IF( le.Input_individual_source10 = (TYPEOF(le.Input_individual_source10))'','',':individual_source10')
    #END
 
+    #IF( #TEXT(Input_email_status)='' )
      '' 
    #ELSE
        IF( le.Input_email_status = (TYPEOF(le.Input_email_status))'','',':email_status')
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
