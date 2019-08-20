 
EXPORT raw_Member_MAC_PopulationStatistics(infile,Ref='',Input_bbb_id = '',Input_company_name = '',Input_address = '',Input_country = '',Input_phone = '',Input_phone_type = '',Input_listing_month = '',Input_listing_day = '',Input_listing_year = '',Input_http_link = '',Input_member_title = '',Input_member_attr_name1 = '',Input_member_attr1 = '',Input_member_attr_name2 = '',Input_member_attr2 = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_BBB2;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_bbb_id)='' )
      '' 
    #ELSE
        IF( le.Input_bbb_id = (TYPEOF(le.Input_bbb_id))'','',':bbb_id')
    #END
 
+    #IF( #TEXT(Input_company_name)='' )
      '' 
    #ELSE
        IF( le.Input_company_name = (TYPEOF(le.Input_company_name))'','',':company_name')
    #END
 
+    #IF( #TEXT(Input_address)='' )
      '' 
    #ELSE
        IF( le.Input_address = (TYPEOF(le.Input_address))'','',':address')
    #END
 
+    #IF( #TEXT(Input_country)='' )
      '' 
    #ELSE
        IF( le.Input_country = (TYPEOF(le.Input_country))'','',':country')
    #END
 
+    #IF( #TEXT(Input_phone)='' )
      '' 
    #ELSE
        IF( le.Input_phone = (TYPEOF(le.Input_phone))'','',':phone')
    #END
 
+    #IF( #TEXT(Input_phone_type)='' )
      '' 
    #ELSE
        IF( le.Input_phone_type = (TYPEOF(le.Input_phone_type))'','',':phone_type')
    #END
 
+    #IF( #TEXT(Input_listing_month)='' )
      '' 
    #ELSE
        IF( le.Input_listing_month = (TYPEOF(le.Input_listing_month))'','',':listing_month')
    #END
 
+    #IF( #TEXT(Input_listing_day)='' )
      '' 
    #ELSE
        IF( le.Input_listing_day = (TYPEOF(le.Input_listing_day))'','',':listing_day')
    #END
 
+    #IF( #TEXT(Input_listing_year)='' )
      '' 
    #ELSE
        IF( le.Input_listing_year = (TYPEOF(le.Input_listing_year))'','',':listing_year')
    #END
 
+    #IF( #TEXT(Input_http_link)='' )
      '' 
    #ELSE
        IF( le.Input_http_link = (TYPEOF(le.Input_http_link))'','',':http_link')
    #END
 
+    #IF( #TEXT(Input_member_title)='' )
      '' 
    #ELSE
        IF( le.Input_member_title = (TYPEOF(le.Input_member_title))'','',':member_title')
    #END
 
+    #IF( #TEXT(Input_member_attr_name1)='' )
      '' 
    #ELSE
        IF( le.Input_member_attr_name1 = (TYPEOF(le.Input_member_attr_name1))'','',':member_attr_name1')
    #END
 
+    #IF( #TEXT(Input_member_attr1)='' )
      '' 
    #ELSE
        IF( le.Input_member_attr1 = (TYPEOF(le.Input_member_attr1))'','',':member_attr1')
    #END
 
+    #IF( #TEXT(Input_member_attr_name2)='' )
      '' 
    #ELSE
        IF( le.Input_member_attr_name2 = (TYPEOF(le.Input_member_attr_name2))'','',':member_attr_name2')
    #END
 
+    #IF( #TEXT(Input_member_attr2)='' )
      '' 
    #ELSE
        IF( le.Input_member_attr2 = (TYPEOF(le.Input_member_attr2))'','',':member_attr2')
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
