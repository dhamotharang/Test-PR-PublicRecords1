 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_item_id = '',Input_item_name = '',Input_item_description = '',Input_status_name = '',Input_item_source_code = '',Input_source_id = '',Input_source_name = '',Input_source_address1 = '',Input_source_address2 = '',Input_source_city = '',Input_source_state = '',Input_source_zip = '',Input_source_phone = '',Input_source_website = '',Input_unused_source_sourcecodes = '',Input_unused_fcra = '',Input_unused_fcra_comments = '',Input_market_restrict_flag = '',Input_unused_market_comments = '',Input_unused_contact_category_name = '',Input_unused_contact_name = '',Input_unused_contact_phone = '',Input_unused_contact_email = '',OutFile) := MACRO
  IMPORT SALT311,_Scrubs_VendorSrc_Orbit;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_item_id)='' )
      '' 
    #ELSE
        IF( le.Input_item_id = (TYPEOF(le.Input_item_id))'','',':item_id')
    #END
 
+    #IF( #TEXT(Input_item_name)='' )
      '' 
    #ELSE
        IF( le.Input_item_name = (TYPEOF(le.Input_item_name))'','',':item_name')
    #END
 
+    #IF( #TEXT(Input_item_description)='' )
      '' 
    #ELSE
        IF( le.Input_item_description = (TYPEOF(le.Input_item_description))'','',':item_description')
    #END
 
+    #IF( #TEXT(Input_status_name)='' )
      '' 
    #ELSE
        IF( le.Input_status_name = (TYPEOF(le.Input_status_name))'','',':status_name')
    #END
 
+    #IF( #TEXT(Input_item_source_code)='' )
      '' 
    #ELSE
        IF( le.Input_item_source_code = (TYPEOF(le.Input_item_source_code))'','',':item_source_code')
    #END
 
+    #IF( #TEXT(Input_source_id)='' )
      '' 
    #ELSE
        IF( le.Input_source_id = (TYPEOF(le.Input_source_id))'','',':source_id')
    #END
 
+    #IF( #TEXT(Input_source_name)='' )
      '' 
    #ELSE
        IF( le.Input_source_name = (TYPEOF(le.Input_source_name))'','',':source_name')
    #END
 
+    #IF( #TEXT(Input_source_address1)='' )
      '' 
    #ELSE
        IF( le.Input_source_address1 = (TYPEOF(le.Input_source_address1))'','',':source_address1')
    #END
 
+    #IF( #TEXT(Input_source_address2)='' )
      '' 
    #ELSE
        IF( le.Input_source_address2 = (TYPEOF(le.Input_source_address2))'','',':source_address2')
    #END
 
+    #IF( #TEXT(Input_source_city)='' )
      '' 
    #ELSE
        IF( le.Input_source_city = (TYPEOF(le.Input_source_city))'','',':source_city')
    #END
 
+    #IF( #TEXT(Input_source_state)='' )
      '' 
    #ELSE
        IF( le.Input_source_state = (TYPEOF(le.Input_source_state))'','',':source_state')
    #END
 
+    #IF( #TEXT(Input_source_zip)='' )
      '' 
    #ELSE
        IF( le.Input_source_zip = (TYPEOF(le.Input_source_zip))'','',':source_zip')
    #END
 
+    #IF( #TEXT(Input_source_phone)='' )
      '' 
    #ELSE
        IF( le.Input_source_phone = (TYPEOF(le.Input_source_phone))'','',':source_phone')
    #END
 
+    #IF( #TEXT(Input_source_website)='' )
      '' 
    #ELSE
        IF( le.Input_source_website = (TYPEOF(le.Input_source_website))'','',':source_website')
    #END
 
+    #IF( #TEXT(Input_unused_source_sourcecodes)='' )
      '' 
    #ELSE
        IF( le.Input_unused_source_sourcecodes = (TYPEOF(le.Input_unused_source_sourcecodes))'','',':unused_source_sourcecodes')
    #END
 
+    #IF( #TEXT(Input_unused_fcra)='' )
      '' 
    #ELSE
        IF( le.Input_unused_fcra = (TYPEOF(le.Input_unused_fcra))'','',':unused_fcra')
    #END
 
+    #IF( #TEXT(Input_unused_fcra_comments)='' )
      '' 
    #ELSE
        IF( le.Input_unused_fcra_comments = (TYPEOF(le.Input_unused_fcra_comments))'','',':unused_fcra_comments')
    #END
 
+    #IF( #TEXT(Input_market_restrict_flag)='' )
      '' 
    #ELSE
        IF( le.Input_market_restrict_flag = (TYPEOF(le.Input_market_restrict_flag))'','',':market_restrict_flag')
    #END
 
+    #IF( #TEXT(Input_unused_market_comments)='' )
      '' 
    #ELSE
        IF( le.Input_unused_market_comments = (TYPEOF(le.Input_unused_market_comments))'','',':unused_market_comments')
    #END
 
+    #IF( #TEXT(Input_unused_contact_category_name)='' )
      '' 
    #ELSE
        IF( le.Input_unused_contact_category_name = (TYPEOF(le.Input_unused_contact_category_name))'','',':unused_contact_category_name')
    #END
 
+    #IF( #TEXT(Input_unused_contact_name)='' )
      '' 
    #ELSE
        IF( le.Input_unused_contact_name = (TYPEOF(le.Input_unused_contact_name))'','',':unused_contact_name')
    #END
 
+    #IF( #TEXT(Input_unused_contact_phone)='' )
      '' 
    #ELSE
        IF( le.Input_unused_contact_phone = (TYPEOF(le.Input_unused_contact_phone))'','',':unused_contact_phone')
    #END
 
+    #IF( #TEXT(Input_unused_contact_email)='' )
      '' 
    #ELSE
        IF( le.Input_unused_contact_email = (TYPEOF(le.Input_unused_contact_email))'','',':unused_contact_email')
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
