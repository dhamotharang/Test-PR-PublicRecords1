
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_link_id = '',Input_account_key = '',Input_segment_id = '',Input_ar_date = '',Input_total_ar = '',Input_current_ar = '',Input_aging_1to30 = '',Input_aging_31to60 = '',Input_aging_61to90 = '',Input_aging_91plus = '',Input_credit_limit = '',Input_first_sale_date = '',Input_last_sale_date = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_Cortera_Tradeline;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_link_id)='' )
      '' 
    #ELSE
        IF( le.Input_link_id = (TYPEOF(le.Input_link_id))'','',':link_id')
    #END

+    #IF( #TEXT(Input_account_key)='' )
      '' 
    #ELSE
        IF( le.Input_account_key = (TYPEOF(le.Input_account_key))'','',':account_key')
    #END

+    #IF( #TEXT(Input_segment_id)='' )
      '' 
    #ELSE
        IF( le.Input_segment_id = (TYPEOF(le.Input_segment_id))'','',':segment_id')
    #END

+    #IF( #TEXT(Input_ar_date)='' )
      '' 
    #ELSE
        IF( le.Input_ar_date = (TYPEOF(le.Input_ar_date))'','',':ar_date')
    #END

+    #IF( #TEXT(Input_total_ar)='' )
      '' 
    #ELSE
        IF( le.Input_total_ar = (TYPEOF(le.Input_total_ar))'','',':total_ar')
    #END

+    #IF( #TEXT(Input_current_ar)='' )
      '' 
    #ELSE
        IF( le.Input_current_ar = (TYPEOF(le.Input_current_ar))'','',':current_ar')
    #END

+    #IF( #TEXT(Input_aging_1to30)='' )
      '' 
    #ELSE
        IF( le.Input_aging_1to30 = (TYPEOF(le.Input_aging_1to30))'','',':aging_1to30')
    #END

+    #IF( #TEXT(Input_aging_31to60)='' )
      '' 
    #ELSE
        IF( le.Input_aging_31to60 = (TYPEOF(le.Input_aging_31to60))'','',':aging_31to60')
    #END

+    #IF( #TEXT(Input_aging_61to90)='' )
      '' 
    #ELSE
        IF( le.Input_aging_61to90 = (TYPEOF(le.Input_aging_61to90))'','',':aging_61to90')
    #END

+    #IF( #TEXT(Input_aging_91plus)='' )
      '' 
    #ELSE
        IF( le.Input_aging_91plus = (TYPEOF(le.Input_aging_91plus))'','',':aging_91plus')
    #END

+    #IF( #TEXT(Input_credit_limit)='' )
      '' 
    #ELSE
        IF( le.Input_credit_limit = (TYPEOF(le.Input_credit_limit))'','',':credit_limit')
    #END

+    #IF( #TEXT(Input_first_sale_date)='' )
      '' 
    #ELSE
        IF( le.Input_first_sale_date = (TYPEOF(le.Input_first_sale_date))'','',':first_sale_date')
    #END

+    #IF( #TEXT(Input_last_sale_date)='' )
      '' 
    #ELSE
        IF( le.Input_last_sale_date = (TYPEOF(le.Input_last_sale_date))'','',':last_sale_date')
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
