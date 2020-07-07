 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_dart_id = '',Input_date_added = '',Input_date_updated = '',Input_website = '',Input_state = '',Input_casetype = '',Input_plan_ein = '',Input_plan_no = '',Input_plan_year = '',Input_plan_name = '',Input_plan_administrator = '',Input_admin_state = '',Input_admin_zip_code = '',Input_admin_zip_code4 = '',Input_closing_reason = '',Input_closing_date = '',Input_penalty_amount = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_LaborActions_EBSA;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_dart_id)='' )
      '' 
    #ELSE
        IF( le.Input_dart_id = (TYPEOF(le.Input_dart_id))'','',':dart_id')
    #END
 
+    #IF( #TEXT(Input_date_added)='' )
      '' 
    #ELSE
        IF( le.Input_date_added = (TYPEOF(le.Input_date_added))'','',':date_added')
    #END
 
+    #IF( #TEXT(Input_date_updated)='' )
      '' 
    #ELSE
        IF( le.Input_date_updated = (TYPEOF(le.Input_date_updated))'','',':date_updated')
    #END
 
+    #IF( #TEXT(Input_website)='' )
      '' 
    #ELSE
        IF( le.Input_website = (TYPEOF(le.Input_website))'','',':website')
    #END
 
+    #IF( #TEXT(Input_state)='' )
      '' 
    #ELSE
        IF( le.Input_state = (TYPEOF(le.Input_state))'','',':state')
    #END
 
+    #IF( #TEXT(Input_casetype)='' )
      '' 
    #ELSE
        IF( le.Input_casetype = (TYPEOF(le.Input_casetype))'','',':casetype')
    #END
 
+    #IF( #TEXT(Input_plan_ein)='' )
      '' 
    #ELSE
        IF( le.Input_plan_ein = (TYPEOF(le.Input_plan_ein))'','',':plan_ein')
    #END
 
+    #IF( #TEXT(Input_plan_no)='' )
      '' 
    #ELSE
        IF( le.Input_plan_no = (TYPEOF(le.Input_plan_no))'','',':plan_no')
    #END
 
+    #IF( #TEXT(Input_plan_year)='' )
      '' 
    #ELSE
        IF( le.Input_plan_year = (TYPEOF(le.Input_plan_year))'','',':plan_year')
    #END
 
+    #IF( #TEXT(Input_plan_name)='' )
      '' 
    #ELSE
        IF( le.Input_plan_name = (TYPEOF(le.Input_plan_name))'','',':plan_name')
    #END
 
+    #IF( #TEXT(Input_plan_administrator)='' )
      '' 
    #ELSE
        IF( le.Input_plan_administrator = (TYPEOF(le.Input_plan_administrator))'','',':plan_administrator')
    #END
 
+    #IF( #TEXT(Input_admin_state)='' )
      '' 
    #ELSE
        IF( le.Input_admin_state = (TYPEOF(le.Input_admin_state))'','',':admin_state')
    #END
 
+    #IF( #TEXT(Input_admin_zip_code)='' )
      '' 
    #ELSE
        IF( le.Input_admin_zip_code = (TYPEOF(le.Input_admin_zip_code))'','',':admin_zip_code')
    #END
 
+    #IF( #TEXT(Input_admin_zip_code4)='' )
      '' 
    #ELSE
        IF( le.Input_admin_zip_code4 = (TYPEOF(le.Input_admin_zip_code4))'','',':admin_zip_code4')
    #END
 
+    #IF( #TEXT(Input_closing_reason)='' )
      '' 
    #ELSE
        IF( le.Input_closing_reason = (TYPEOF(le.Input_closing_reason))'','',':closing_reason')
    #END
 
+    #IF( #TEXT(Input_closing_date)='' )
      '' 
    #ELSE
        IF( le.Input_closing_date = (TYPEOF(le.Input_closing_date))'','',':closing_date')
    #END
 
+    #IF( #TEXT(Input_penalty_amount)='' )
      '' 
    #ELSE
        IF( le.Input_penalty_amount = (TYPEOF(le.Input_penalty_amount))'','',':penalty_amount')
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
