 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_corp_key = '',Input_corp_vendor = '',Input_corp_vendor_county = '',Input_corp_vendor_subcode = '',Input_corp_state_origin = '',Input_corp_process_date = '',Input_corp_sos_charter_nbr = '',Input_ar_year = '',Input_ar_mailed_dt = '',Input_ar_due_dt = '',Input_ar_filed_dt = '',Input_ar_report_dt = '',Input_ar_report_nbr = '',Input_ar_franchise_tax_paid_dt = '',Input_ar_delinquent_dt = '',Input_ar_tax_factor = '',Input_ar_tax_amount_paid = '',Input_ar_annual_report_cap = '',Input_ar_illinois_capital = '',Input_ar_roll = '',Input_ar_frame = '',Input_ar_extension = '',Input_ar_microfilm_nbr = '',Input_ar_comment = '',Input_ar_type = '',Input_ar_exempt = '',Input_ar_license_tax_amount = '',Input_ar_status = '',Input_ar_paid_date = '',Input_ar_prev_paid_date = '',Input_ar_prev_tax_factor = '',Input_ar_extension_date = '',Input_ar_report_mail_date = '',Input_ar_deliquent_report_mail_date = '',Input_ar_report_filed_date = '',Input_ar_year_and_month_due = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_Corp2_Mapping_MI_AR;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_corp_key)='' )
      '' 
    #ELSE
        IF( le.Input_corp_key = (TYPEOF(le.Input_corp_key))'','',':corp_key')
    #END
 
+    #IF( #TEXT(Input_corp_vendor)='' )
      '' 
    #ELSE
        IF( le.Input_corp_vendor = (TYPEOF(le.Input_corp_vendor))'','',':corp_vendor')
    #END
 
+    #IF( #TEXT(Input_corp_vendor_county)='' )
      '' 
    #ELSE
        IF( le.Input_corp_vendor_county = (TYPEOF(le.Input_corp_vendor_county))'','',':corp_vendor_county')
    #END
 
+    #IF( #TEXT(Input_corp_vendor_subcode)='' )
      '' 
    #ELSE
        IF( le.Input_corp_vendor_subcode = (TYPEOF(le.Input_corp_vendor_subcode))'','',':corp_vendor_subcode')
    #END
 
+    #IF( #TEXT(Input_corp_state_origin)='' )
      '' 
    #ELSE
        IF( le.Input_corp_state_origin = (TYPEOF(le.Input_corp_state_origin))'','',':corp_state_origin')
    #END
 
+    #IF( #TEXT(Input_corp_process_date)='' )
      '' 
    #ELSE
        IF( le.Input_corp_process_date = (TYPEOF(le.Input_corp_process_date))'','',':corp_process_date')
    #END
 
+    #IF( #TEXT(Input_corp_sos_charter_nbr)='' )
      '' 
    #ELSE
        IF( le.Input_corp_sos_charter_nbr = (TYPEOF(le.Input_corp_sos_charter_nbr))'','',':corp_sos_charter_nbr')
    #END
 
+    #IF( #TEXT(Input_ar_year)='' )
      '' 
    #ELSE
        IF( le.Input_ar_year = (TYPEOF(le.Input_ar_year))'','',':ar_year')
    #END
 
+    #IF( #TEXT(Input_ar_mailed_dt)='' )
      '' 
    #ELSE
        IF( le.Input_ar_mailed_dt = (TYPEOF(le.Input_ar_mailed_dt))'','',':ar_mailed_dt')
    #END
 
+    #IF( #TEXT(Input_ar_due_dt)='' )
      '' 
    #ELSE
        IF( le.Input_ar_due_dt = (TYPEOF(le.Input_ar_due_dt))'','',':ar_due_dt')
    #END
 
+    #IF( #TEXT(Input_ar_filed_dt)='' )
      '' 
    #ELSE
        IF( le.Input_ar_filed_dt = (TYPEOF(le.Input_ar_filed_dt))'','',':ar_filed_dt')
    #END
 
+    #IF( #TEXT(Input_ar_report_dt)='' )
      '' 
    #ELSE
        IF( le.Input_ar_report_dt = (TYPEOF(le.Input_ar_report_dt))'','',':ar_report_dt')
    #END
 
+    #IF( #TEXT(Input_ar_report_nbr)='' )
      '' 
    #ELSE
        IF( le.Input_ar_report_nbr = (TYPEOF(le.Input_ar_report_nbr))'','',':ar_report_nbr')
    #END
 
+    #IF( #TEXT(Input_ar_franchise_tax_paid_dt)='' )
      '' 
    #ELSE
        IF( le.Input_ar_franchise_tax_paid_dt = (TYPEOF(le.Input_ar_franchise_tax_paid_dt))'','',':ar_franchise_tax_paid_dt')
    #END
 
+    #IF( #TEXT(Input_ar_delinquent_dt)='' )
      '' 
    #ELSE
        IF( le.Input_ar_delinquent_dt = (TYPEOF(le.Input_ar_delinquent_dt))'','',':ar_delinquent_dt')
    #END
 
+    #IF( #TEXT(Input_ar_tax_factor)='' )
      '' 
    #ELSE
        IF( le.Input_ar_tax_factor = (TYPEOF(le.Input_ar_tax_factor))'','',':ar_tax_factor')
    #END
 
+    #IF( #TEXT(Input_ar_tax_amount_paid)='' )
      '' 
    #ELSE
        IF( le.Input_ar_tax_amount_paid = (TYPEOF(le.Input_ar_tax_amount_paid))'','',':ar_tax_amount_paid')
    #END
 
+    #IF( #TEXT(Input_ar_annual_report_cap)='' )
      '' 
    #ELSE
        IF( le.Input_ar_annual_report_cap = (TYPEOF(le.Input_ar_annual_report_cap))'','',':ar_annual_report_cap')
    #END
 
+    #IF( #TEXT(Input_ar_illinois_capital)='' )
      '' 
    #ELSE
        IF( le.Input_ar_illinois_capital = (TYPEOF(le.Input_ar_illinois_capital))'','',':ar_illinois_capital')
    #END
 
+    #IF( #TEXT(Input_ar_roll)='' )
      '' 
    #ELSE
        IF( le.Input_ar_roll = (TYPEOF(le.Input_ar_roll))'','',':ar_roll')
    #END
 
+    #IF( #TEXT(Input_ar_frame)='' )
      '' 
    #ELSE
        IF( le.Input_ar_frame = (TYPEOF(le.Input_ar_frame))'','',':ar_frame')
    #END
 
+    #IF( #TEXT(Input_ar_extension)='' )
      '' 
    #ELSE
        IF( le.Input_ar_extension = (TYPEOF(le.Input_ar_extension))'','',':ar_extension')
    #END
 
+    #IF( #TEXT(Input_ar_microfilm_nbr)='' )
      '' 
    #ELSE
        IF( le.Input_ar_microfilm_nbr = (TYPEOF(le.Input_ar_microfilm_nbr))'','',':ar_microfilm_nbr')
    #END
 
+    #IF( #TEXT(Input_ar_comment)='' )
      '' 
    #ELSE
        IF( le.Input_ar_comment = (TYPEOF(le.Input_ar_comment))'','',':ar_comment')
    #END
 
+    #IF( #TEXT(Input_ar_type)='' )
      '' 
    #ELSE
        IF( le.Input_ar_type = (TYPEOF(le.Input_ar_type))'','',':ar_type')
    #END
 
+    #IF( #TEXT(Input_ar_exempt)='' )
      '' 
    #ELSE
        IF( le.Input_ar_exempt = (TYPEOF(le.Input_ar_exempt))'','',':ar_exempt')
    #END
 
+    #IF( #TEXT(Input_ar_license_tax_amount)='' )
      '' 
    #ELSE
        IF( le.Input_ar_license_tax_amount = (TYPEOF(le.Input_ar_license_tax_amount))'','',':ar_license_tax_amount')
    #END
 
+    #IF( #TEXT(Input_ar_status)='' )
      '' 
    #ELSE
        IF( le.Input_ar_status = (TYPEOF(le.Input_ar_status))'','',':ar_status')
    #END
 
+    #IF( #TEXT(Input_ar_paid_date)='' )
      '' 
    #ELSE
        IF( le.Input_ar_paid_date = (TYPEOF(le.Input_ar_paid_date))'','',':ar_paid_date')
    #END
 
+    #IF( #TEXT(Input_ar_prev_paid_date)='' )
      '' 
    #ELSE
        IF( le.Input_ar_prev_paid_date = (TYPEOF(le.Input_ar_prev_paid_date))'','',':ar_prev_paid_date')
    #END
 
+    #IF( #TEXT(Input_ar_prev_tax_factor)='' )
      '' 
    #ELSE
        IF( le.Input_ar_prev_tax_factor = (TYPEOF(le.Input_ar_prev_tax_factor))'','',':ar_prev_tax_factor')
    #END
 
+    #IF( #TEXT(Input_ar_extension_date)='' )
      '' 
    #ELSE
        IF( le.Input_ar_extension_date = (TYPEOF(le.Input_ar_extension_date))'','',':ar_extension_date')
    #END
 
+    #IF( #TEXT(Input_ar_report_mail_date)='' )
      '' 
    #ELSE
        IF( le.Input_ar_report_mail_date = (TYPEOF(le.Input_ar_report_mail_date))'','',':ar_report_mail_date')
    #END
 
+    #IF( #TEXT(Input_ar_deliquent_report_mail_date)='' )
      '' 
    #ELSE
        IF( le.Input_ar_deliquent_report_mail_date = (TYPEOF(le.Input_ar_deliquent_report_mail_date))'','',':ar_deliquent_report_mail_date')
    #END
 
+    #IF( #TEXT(Input_ar_report_filed_date)='' )
      '' 
    #ELSE
        IF( le.Input_ar_report_filed_date = (TYPEOF(le.Input_ar_report_filed_date))'','',':ar_report_filed_date')
    #END
 
+    #IF( #TEXT(Input_ar_year_and_month_due)='' )
      '' 
    #ELSE
        IF( le.Input_ar_year_and_month_due = (TYPEOF(le.Input_ar_year_and_month_due))'','',':ar_year_and_month_due')
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
