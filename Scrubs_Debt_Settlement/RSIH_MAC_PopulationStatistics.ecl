 
EXPORT RSIH_MAC_PopulationStatistics(infile,Ref='',Input_avdanumber = '',Input_attorneyname = '',Input_businessname = '',Input_address1 = '',Input_address2 = '',Input_phone = '',Input_email = '',Input_primary_range_cln = '',Input_primary_name_cln = '',Input_sec_range_cln = '',Input_zip_cln = '',Input_did_header_addr_count = '',Input_did_header_phone_count = '',Input_did_phoneplus_gongphone_count = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_Debt_Settlement;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_avdanumber)='' )
      '' 
    #ELSE
        IF( le.Input_avdanumber = (TYPEOF(le.Input_avdanumber))'','',':avdanumber')
    #END
 
+    #IF( #TEXT(Input_attorneyname)='' )
      '' 
    #ELSE
        IF( le.Input_attorneyname = (TYPEOF(le.Input_attorneyname))'','',':attorneyname')
    #END
 
+    #IF( #TEXT(Input_businessname)='' )
      '' 
    #ELSE
        IF( le.Input_businessname = (TYPEOF(le.Input_businessname))'','',':businessname')
    #END
 
+    #IF( #TEXT(Input_address1)='' )
      '' 
    #ELSE
        IF( le.Input_address1 = (TYPEOF(le.Input_address1))'','',':address1')
    #END
 
+    #IF( #TEXT(Input_address2)='' )
      '' 
    #ELSE
        IF( le.Input_address2 = (TYPEOF(le.Input_address2))'','',':address2')
    #END
 
+    #IF( #TEXT(Input_phone)='' )
      '' 
    #ELSE
        IF( le.Input_phone = (TYPEOF(le.Input_phone))'','',':phone')
    #END
 
+    #IF( #TEXT(Input_email)='' )
      '' 
    #ELSE
        IF( le.Input_email = (TYPEOF(le.Input_email))'','',':email')
    #END
 
+    #IF( #TEXT(Input_primary_range_cln)='' )
      '' 
    #ELSE
        IF( le.Input_primary_range_cln = (TYPEOF(le.Input_primary_range_cln))'','',':primary_range_cln')
    #END
 
+    #IF( #TEXT(Input_primary_name_cln)='' )
      '' 
    #ELSE
        IF( le.Input_primary_name_cln = (TYPEOF(le.Input_primary_name_cln))'','',':primary_name_cln')
    #END
 
+    #IF( #TEXT(Input_sec_range_cln)='' )
      '' 
    #ELSE
        IF( le.Input_sec_range_cln = (TYPEOF(le.Input_sec_range_cln))'','',':sec_range_cln')
    #END
 
+    #IF( #TEXT(Input_zip_cln)='' )
      '' 
    #ELSE
        IF( le.Input_zip_cln = (TYPEOF(le.Input_zip_cln))'','',':zip_cln')
    #END
 
+    #IF( #TEXT(Input_did_header_addr_count)='' )
      '' 
    #ELSE
        IF( le.Input_did_header_addr_count = (TYPEOF(le.Input_did_header_addr_count))'','',':did_header_addr_count')
    #END
 
+    #IF( #TEXT(Input_did_header_phone_count)='' )
      '' 
    #ELSE
        IF( le.Input_did_header_phone_count = (TYPEOF(le.Input_did_header_phone_count))'','',':did_header_phone_count')
    #END
 
+    #IF( #TEXT(Input_did_phoneplus_gongphone_count)='' )
      '' 
    #ELSE
        IF( le.Input_did_phoneplus_gongphone_count = (TYPEOF(le.Input_did_phoneplus_gongphone_count))'','',':did_phoneplus_gongphone_count')
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
