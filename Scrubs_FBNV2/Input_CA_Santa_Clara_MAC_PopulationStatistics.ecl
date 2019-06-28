 
EXPORT Input_CA_Santa_Clara_MAC_PopulationStatistics(infile,Ref='',Input_status = '',Input_process_date = '',Input_FIlED_DATE = '',Input_FBN_TYPE = '',Input_FILING_TYPE = '',Input_BUSINESS_NAME = '',Input_BUSINESS_TYPE = '',Input_ORIG_FILED_DATE = '',Input_ORIG_FBN_NUM = '',Input_RECORD_CODE1 = '',Input_FBN_NUM = '',Input_BUSINESS_ADDR1 = '',Input_RECORD_CODE2 = '',Input_BUSINESS_ADDR2 = '',Input_RECORD_CODE3 = '',Input_BUS_CITY = '',Input_BUS_ST = '',Input_BUS_ZIP = '',Input_RECORD_CODE4 = '',Input_ADDTL_BUSINESS = '',Input_RECORD_CODE5 = '',Input_owner_name = '',Input_OWNER_TYPE = '',Input_RECORD_CODE6 = '',Input_OWNER_ADDR1 = '',Input_OWNER_CITY = '',Input_OWNER_ST = '',Input_OWNER_ZIP = '',Input_Owner_title = '',Input_Owner_fname = '',Input_Owner_mname = '',Input_Owner_lname = '',Input_Owner_name_suffix = '',Input_Owner_name_score = '',Input_prep_addr_line1 = '',Input_prep_addr_line_last = '',Input_prep_owner_addr_line1 = '',Input_prep_owner_addr_line_last = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_FBNV2;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_status)='' )
      '' 
    #ELSE
        IF( le.Input_status = (TYPEOF(le.Input_status))'','',':status')
    #END
 
+    #IF( #TEXT(Input_process_date)='' )
      '' 
    #ELSE
        IF( le.Input_process_date = (TYPEOF(le.Input_process_date))'','',':process_date')
    #END
 
+    #IF( #TEXT(Input_FIlED_DATE)='' )
      '' 
    #ELSE
        IF( le.Input_FIlED_DATE = (TYPEOF(le.Input_FIlED_DATE))'','',':FIlED_DATE')
    #END
 
+    #IF( #TEXT(Input_FBN_TYPE)='' )
      '' 
    #ELSE
        IF( le.Input_FBN_TYPE = (TYPEOF(le.Input_FBN_TYPE))'','',':FBN_TYPE')
    #END
 
+    #IF( #TEXT(Input_FILING_TYPE)='' )
      '' 
    #ELSE
        IF( le.Input_FILING_TYPE = (TYPEOF(le.Input_FILING_TYPE))'','',':FILING_TYPE')
    #END
 
+    #IF( #TEXT(Input_BUSINESS_NAME)='' )
      '' 
    #ELSE
        IF( le.Input_BUSINESS_NAME = (TYPEOF(le.Input_BUSINESS_NAME))'','',':BUSINESS_NAME')
    #END
 
+    #IF( #TEXT(Input_BUSINESS_TYPE)='' )
      '' 
    #ELSE
        IF( le.Input_BUSINESS_TYPE = (TYPEOF(le.Input_BUSINESS_TYPE))'','',':BUSINESS_TYPE')
    #END
 
+    #IF( #TEXT(Input_ORIG_FILED_DATE)='' )
      '' 
    #ELSE
        IF( le.Input_ORIG_FILED_DATE = (TYPEOF(le.Input_ORIG_FILED_DATE))'','',':ORIG_FILED_DATE')
    #END
 
+    #IF( #TEXT(Input_ORIG_FBN_NUM)='' )
      '' 
    #ELSE
        IF( le.Input_ORIG_FBN_NUM = (TYPEOF(le.Input_ORIG_FBN_NUM))'','',':ORIG_FBN_NUM')
    #END
 
+    #IF( #TEXT(Input_RECORD_CODE1)='' )
      '' 
    #ELSE
        IF( le.Input_RECORD_CODE1 = (TYPEOF(le.Input_RECORD_CODE1))'','',':RECORD_CODE1')
    #END
 
+    #IF( #TEXT(Input_FBN_NUM)='' )
      '' 
    #ELSE
        IF( le.Input_FBN_NUM = (TYPEOF(le.Input_FBN_NUM))'','',':FBN_NUM')
    #END
 
+    #IF( #TEXT(Input_BUSINESS_ADDR1)='' )
      '' 
    #ELSE
        IF( le.Input_BUSINESS_ADDR1 = (TYPEOF(le.Input_BUSINESS_ADDR1))'','',':BUSINESS_ADDR1')
    #END
 
+    #IF( #TEXT(Input_RECORD_CODE2)='' )
      '' 
    #ELSE
        IF( le.Input_RECORD_CODE2 = (TYPEOF(le.Input_RECORD_CODE2))'','',':RECORD_CODE2')
    #END
 
+    #IF( #TEXT(Input_BUSINESS_ADDR2)='' )
      '' 
    #ELSE
        IF( le.Input_BUSINESS_ADDR2 = (TYPEOF(le.Input_BUSINESS_ADDR2))'','',':BUSINESS_ADDR2')
    #END
 
+    #IF( #TEXT(Input_RECORD_CODE3)='' )
      '' 
    #ELSE
        IF( le.Input_RECORD_CODE3 = (TYPEOF(le.Input_RECORD_CODE3))'','',':RECORD_CODE3')
    #END
 
+    #IF( #TEXT(Input_BUS_CITY)='' )
      '' 
    #ELSE
        IF( le.Input_BUS_CITY = (TYPEOF(le.Input_BUS_CITY))'','',':BUS_CITY')
    #END
 
+    #IF( #TEXT(Input_BUS_ST)='' )
      '' 
    #ELSE
        IF( le.Input_BUS_ST = (TYPEOF(le.Input_BUS_ST))'','',':BUS_ST')
    #END
 
+    #IF( #TEXT(Input_BUS_ZIP)='' )
      '' 
    #ELSE
        IF( le.Input_BUS_ZIP = (TYPEOF(le.Input_BUS_ZIP))'','',':BUS_ZIP')
    #END
 
+    #IF( #TEXT(Input_RECORD_CODE4)='' )
      '' 
    #ELSE
        IF( le.Input_RECORD_CODE4 = (TYPEOF(le.Input_RECORD_CODE4))'','',':RECORD_CODE4')
    #END
 
+    #IF( #TEXT(Input_ADDTL_BUSINESS)='' )
      '' 
    #ELSE
        IF( le.Input_ADDTL_BUSINESS = (TYPEOF(le.Input_ADDTL_BUSINESS))'','',':ADDTL_BUSINESS')
    #END
 
+    #IF( #TEXT(Input_RECORD_CODE5)='' )
      '' 
    #ELSE
        IF( le.Input_RECORD_CODE5 = (TYPEOF(le.Input_RECORD_CODE5))'','',':RECORD_CODE5')
    #END
 
+    #IF( #TEXT(Input_owner_name)='' )
      '' 
    #ELSE
        IF( le.Input_owner_name = (TYPEOF(le.Input_owner_name))'','',':owner_name')
    #END
 
+    #IF( #TEXT(Input_OWNER_TYPE)='' )
      '' 
    #ELSE
        IF( le.Input_OWNER_TYPE = (TYPEOF(le.Input_OWNER_TYPE))'','',':OWNER_TYPE')
    #END
 
+    #IF( #TEXT(Input_RECORD_CODE6)='' )
      '' 
    #ELSE
        IF( le.Input_RECORD_CODE6 = (TYPEOF(le.Input_RECORD_CODE6))'','',':RECORD_CODE6')
    #END
 
+    #IF( #TEXT(Input_OWNER_ADDR1)='' )
      '' 
    #ELSE
        IF( le.Input_OWNER_ADDR1 = (TYPEOF(le.Input_OWNER_ADDR1))'','',':OWNER_ADDR1')
    #END
 
+    #IF( #TEXT(Input_OWNER_CITY)='' )
      '' 
    #ELSE
        IF( le.Input_OWNER_CITY = (TYPEOF(le.Input_OWNER_CITY))'','',':OWNER_CITY')
    #END
 
+    #IF( #TEXT(Input_OWNER_ST)='' )
      '' 
    #ELSE
        IF( le.Input_OWNER_ST = (TYPEOF(le.Input_OWNER_ST))'','',':OWNER_ST')
    #END
 
+    #IF( #TEXT(Input_OWNER_ZIP)='' )
      '' 
    #ELSE
        IF( le.Input_OWNER_ZIP = (TYPEOF(le.Input_OWNER_ZIP))'','',':OWNER_ZIP')
    #END
 
+    #IF( #TEXT(Input_Owner_title)='' )
      '' 
    #ELSE
        IF( le.Input_Owner_title = (TYPEOF(le.Input_Owner_title))'','',':Owner_title')
    #END
 
+    #IF( #TEXT(Input_Owner_fname)='' )
      '' 
    #ELSE
        IF( le.Input_Owner_fname = (TYPEOF(le.Input_Owner_fname))'','',':Owner_fname')
    #END
 
+    #IF( #TEXT(Input_Owner_mname)='' )
      '' 
    #ELSE
        IF( le.Input_Owner_mname = (TYPEOF(le.Input_Owner_mname))'','',':Owner_mname')
    #END
 
+    #IF( #TEXT(Input_Owner_lname)='' )
      '' 
    #ELSE
        IF( le.Input_Owner_lname = (TYPEOF(le.Input_Owner_lname))'','',':Owner_lname')
    #END
 
+    #IF( #TEXT(Input_Owner_name_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_Owner_name_suffix = (TYPEOF(le.Input_Owner_name_suffix))'','',':Owner_name_suffix')
    #END
 
+    #IF( #TEXT(Input_Owner_name_score)='' )
      '' 
    #ELSE
        IF( le.Input_Owner_name_score = (TYPEOF(le.Input_Owner_name_score))'','',':Owner_name_score')
    #END
 
+    #IF( #TEXT(Input_prep_addr_line1)='' )
      '' 
    #ELSE
        IF( le.Input_prep_addr_line1 = (TYPEOF(le.Input_prep_addr_line1))'','',':prep_addr_line1')
    #END
 
+    #IF( #TEXT(Input_prep_addr_line_last)='' )
      '' 
    #ELSE
        IF( le.Input_prep_addr_line_last = (TYPEOF(le.Input_prep_addr_line_last))'','',':prep_addr_line_last')
    #END
 
+    #IF( #TEXT(Input_prep_owner_addr_line1)='' )
      '' 
    #ELSE
        IF( le.Input_prep_owner_addr_line1 = (TYPEOF(le.Input_prep_owner_addr_line1))'','',':prep_owner_addr_line1')
    #END
 
+    #IF( #TEXT(Input_prep_owner_addr_line_last)='' )
      '' 
    #ELSE
        IF( le.Input_prep_owner_addr_line_last = (TYPEOF(le.Input_prep_owner_addr_line_last))'','',':prep_owner_addr_line_last')
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
