 
EXPORT MarketAppend_MAC_PopulationStatistics(infile,Ref='',Input_company_id = '',Input_app_type = '',Input_market = '',Input_sub_market = '',Input_vertical = '',Input_main_country_code = '',Input_bill_country_code = '',OutFile) := MACRO
  IMPORT SALT39,Scrubs_MBS;
  #uniquename(of)
  %of% := RECORD
    SALT39.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_company_id)='' )
      '' 
    #ELSE
        IF( le.Input_company_id = (TYPEOF(le.Input_company_id))'','',':company_id')
    #END
 
+    #IF( #TEXT(Input_app_type)='' )
      '' 
    #ELSE
        IF( le.Input_app_type = (TYPEOF(le.Input_app_type))'','',':app_type')
    #END
 
+    #IF( #TEXT(Input_market)='' )
      '' 
    #ELSE
        IF( le.Input_market = (TYPEOF(le.Input_market))'','',':market')
    #END
 
+    #IF( #TEXT(Input_sub_market)='' )
      '' 
    #ELSE
        IF( le.Input_sub_market = (TYPEOF(le.Input_sub_market))'','',':sub_market')
    #END
 
+    #IF( #TEXT(Input_vertical)='' )
      '' 
    #ELSE
        IF( le.Input_vertical = (TYPEOF(le.Input_vertical))'','',':vertical')
    #END
 
+    #IF( #TEXT(Input_main_country_code)='' )
      '' 
    #ELSE
        IF( le.Input_main_country_code = (TYPEOF(le.Input_main_country_code))'','',':main_country_code')
    #END
 
+    #IF( #TEXT(Input_bill_country_code)='' )
      '' 
    #ELSE
        IF( le.Input_bill_country_code = (TYPEOF(le.Input_bill_country_code))'','',':bill_country_code')
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
