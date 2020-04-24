 
EXPORT Input_MAC_PopulationStatistics(infile,Ref='',Input_address1 = '',Input_address2 = '',Input_brand_name = '',Input_city = '',Input_company_name = '',Input_exec_full_name = '',Input_franchisee_id = '',Input_fruns = '',Input_industry = '',Input_industry_type = '',Input_phone = '',Input_phone_extension = '',Input_record_id = '',Input_relationship_code = '',Input_secondary_phone = '',Input_sector = '',Input_sic_code = '',Input_state = '',Input_unit_flag = '',Input_zip_code = '',Input_zip_code4 = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_Frandx;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_address1)='' )
      '' 
    #ELSE
        IF( le.Input_address1 = (TYPEOF(le.Input_address1))'','',':address1')
    #END
 
+    #IF( #TEXT(Input_address2)='' )
      '' 
    #ELSE
        IF( le.Input_address2 = (TYPEOF(le.Input_address2))'','',':address2')
    #END
 
+    #IF( #TEXT(Input_brand_name)='' )
      '' 
    #ELSE
        IF( le.Input_brand_name = (TYPEOF(le.Input_brand_name))'','',':brand_name')
    #END
 
+    #IF( #TEXT(Input_city)='' )
      '' 
    #ELSE
        IF( le.Input_city = (TYPEOF(le.Input_city))'','',':city')
    #END
 
+    #IF( #TEXT(Input_company_name)='' )
      '' 
    #ELSE
        IF( le.Input_company_name = (TYPEOF(le.Input_company_name))'','',':company_name')
    #END
 
+    #IF( #TEXT(Input_exec_full_name)='' )
      '' 
    #ELSE
        IF( le.Input_exec_full_name = (TYPEOF(le.Input_exec_full_name))'','',':exec_full_name')
    #END
 
+    #IF( #TEXT(Input_franchisee_id)='' )
      '' 
    #ELSE
        IF( le.Input_franchisee_id = (TYPEOF(le.Input_franchisee_id))'','',':franchisee_id')
    #END
 
+    #IF( #TEXT(Input_fruns)='' )
      '' 
    #ELSE
        IF( le.Input_fruns = (TYPEOF(le.Input_fruns))'','',':fruns')
    #END
 
+    #IF( #TEXT(Input_industry)='' )
      '' 
    #ELSE
        IF( le.Input_industry = (TYPEOF(le.Input_industry))'','',':industry')
    #END
 
+    #IF( #TEXT(Input_industry_type)='' )
      '' 
    #ELSE
        IF( le.Input_industry_type = (TYPEOF(le.Input_industry_type))'','',':industry_type')
    #END
 
+    #IF( #TEXT(Input_phone)='' )
      '' 
    #ELSE
        IF( le.Input_phone = (TYPEOF(le.Input_phone))'','',':phone')
    #END
 
+    #IF( #TEXT(Input_phone_extension)='' )
      '' 
    #ELSE
        IF( le.Input_phone_extension = (TYPEOF(le.Input_phone_extension))'','',':phone_extension')
    #END
 
+    #IF( #TEXT(Input_record_id)='' )
      '' 
    #ELSE
        IF( le.Input_record_id = (TYPEOF(le.Input_record_id))'','',':record_id')
    #END
 
+    #IF( #TEXT(Input_relationship_code)='' )
      '' 
    #ELSE
        IF( le.Input_relationship_code = (TYPEOF(le.Input_relationship_code))'','',':relationship_code')
    #END
 
+    #IF( #TEXT(Input_secondary_phone)='' )
      '' 
    #ELSE
        IF( le.Input_secondary_phone = (TYPEOF(le.Input_secondary_phone))'','',':secondary_phone')
    #END
 
+    #IF( #TEXT(Input_sector)='' )
      '' 
    #ELSE
        IF( le.Input_sector = (TYPEOF(le.Input_sector))'','',':sector')
    #END
 
+    #IF( #TEXT(Input_sic_code)='' )
      '' 
    #ELSE
        IF( le.Input_sic_code = (TYPEOF(le.Input_sic_code))'','',':sic_code')
    #END
 
+    #IF( #TEXT(Input_state)='' )
      '' 
    #ELSE
        IF( le.Input_state = (TYPEOF(le.Input_state))'','',':state')
    #END
 
+    #IF( #TEXT(Input_unit_flag)='' )
      '' 
    #ELSE
        IF( le.Input_unit_flag = (TYPEOF(le.Input_unit_flag))'','',':unit_flag')
    #END
 
+    #IF( #TEXT(Input_zip_code)='' )
      '' 
    #ELSE
        IF( le.Input_zip_code = (TYPEOF(le.Input_zip_code))'','',':zip_code')
    #END
 
+    #IF( #TEXT(Input_zip_code4)='' )
      '' 
    #ELSE
        IF( le.Input_zip_code4 = (TYPEOF(le.Input_zip_code4))'','',':zip_code4')
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
