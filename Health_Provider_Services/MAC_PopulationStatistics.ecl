EXPORT MAC_PopulationStatistics(infile,Ref='',Input_FNAME = '',Input_MNAME = '',Input_LNAME = '',Input_SNAME = '',Input_GENDER = '',Input_PRIM_RANGE = '',Input_PRIM_NAME = '',Input_SEC_RANGE = '',Input_V_CITY_NAME = '',Input_ST = '',Input_ZIP = '',Input_SSN = '',Input_DOB = '',Input_PHONE = '',Input_LIC_STATE = '',Input_C_LIC_NBR = '',Input_TAX_ID = '',Input_DEA_NUMBER = '',Input_VENDOR_ID = '',Input_NPI_NUMBER = '',Input_UPIN = '',Input_DID = '',Input_BDID = '',Input_SRC = '',Input_SOURCE_RID = '',Input_MAINNAME = '',Input_FULLNAME = '',Input_ADDR1 = '',Input_LOCALE = '',Input_ADDRESS = '',OutFile) := MACRO
  IMPORT SALT28,Health_Provider_Services;
  #uniquename(of)
  %of% := RECORD
    SALT28.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_FNAME)='' )
      '' 
    #ELSE
        IF( le.Input_FNAME = (TYPEOF(le.Input_FNAME))'','',':FNAME')
    #END
+    #IF( #TEXT(Input_MNAME)='' )
      '' 
    #ELSE
        IF( le.Input_MNAME = (TYPEOF(le.Input_MNAME))'','',':MNAME')
    #END
+    #IF( #TEXT(Input_LNAME)='' )
      '' 
    #ELSE
        IF( le.Input_LNAME = (TYPEOF(le.Input_LNAME))'','',':LNAME')
    #END
+    #IF( #TEXT(Input_SNAME)='' )
      '' 
    #ELSE
        IF( le.Input_SNAME = (TYPEOF(le.Input_SNAME))'','',':SNAME')
    #END
+    #IF( #TEXT(Input_GENDER)='' )
      '' 
    #ELSE
        IF( le.Input_GENDER = (TYPEOF(le.Input_GENDER))'','',':GENDER')
    #END
+    #IF( #TEXT(Input_PRIM_RANGE)='' )
      '' 
    #ELSE
        IF( le.Input_PRIM_RANGE = (TYPEOF(le.Input_PRIM_RANGE))'','',':PRIM_RANGE')
    #END
+    #IF( #TEXT(Input_PRIM_NAME)='' )
      '' 
    #ELSE
        IF( le.Input_PRIM_NAME = (TYPEOF(le.Input_PRIM_NAME))'','',':PRIM_NAME')
    #END
+    #IF( #TEXT(Input_SEC_RANGE)='' )
      '' 
    #ELSE
        IF( le.Input_SEC_RANGE = (TYPEOF(le.Input_SEC_RANGE))'','',':SEC_RANGE')
    #END
+    #IF( #TEXT(Input_V_CITY_NAME)='' )
      '' 
    #ELSE
        IF( le.Input_V_CITY_NAME = (TYPEOF(le.Input_V_CITY_NAME))'','',':V_CITY_NAME')
    #END
+    #IF( #TEXT(Input_ST)='' )
      '' 
    #ELSE
        IF( le.Input_ST = (TYPEOF(le.Input_ST))'','',':ST')
    #END
+    #IF( #TEXT(Input_ZIP)='' )
      '' 
    #ELSE
        IF( le.Input_ZIP = (TYPEOF(le.Input_ZIP))'','',':ZIP')
    #END
+    #IF( #TEXT(Input_SSN)='' )
      '' 
    #ELSE
        IF( le.Input_SSN = (TYPEOF(le.Input_SSN))'','',':SSN')
    #END
+    #IF( #TEXT(Input_DOB)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_DOB = 0,'', ':DOB(' + SALT28.fn_date_valid_as_text((unsigned)le.Input_DOB) + ')' )
    #END
+    #IF( #TEXT(Input_PHONE)='' )
      '' 
    #ELSE
        IF( le.Input_PHONE = (TYPEOF(le.Input_PHONE))'','',':PHONE')
    #END
+    #IF( #TEXT(Input_LIC_STATE)='' )
      '' 
    #ELSE
        IF( le.Input_LIC_STATE = (TYPEOF(le.Input_LIC_STATE))'','',':LIC_STATE')
    #END
+    #IF( #TEXT(Input_C_LIC_NBR)='' )
      '' 
    #ELSE
        IF( le.Input_C_LIC_NBR = (TYPEOF(le.Input_C_LIC_NBR))'','',':C_LIC_NBR')
    #END
+    #IF( #TEXT(Input_TAX_ID)='' )
      '' 
    #ELSE
        IF( le.Input_TAX_ID = (TYPEOF(le.Input_TAX_ID))'','',':TAX_ID')
    #END
+    #IF( #TEXT(Input_DEA_NUMBER)='' )
      '' 
    #ELSE
        IF( le.Input_DEA_NUMBER = (TYPEOF(le.Input_DEA_NUMBER))'','',':DEA_NUMBER')
    #END
+    #IF( #TEXT(Input_VENDOR_ID)='' )
      '' 
    #ELSE
        IF( le.Input_VENDOR_ID = (TYPEOF(le.Input_VENDOR_ID))'','',':VENDOR_ID')
    #END
+    #IF( #TEXT(Input_NPI_NUMBER)='' )
      '' 
    #ELSE
        IF( le.Input_NPI_NUMBER = (TYPEOF(le.Input_NPI_NUMBER))'','',':NPI_NUMBER')
    #END
+    #IF( #TEXT(Input_UPIN)='' )
      '' 
    #ELSE
        IF( le.Input_UPIN = (TYPEOF(le.Input_UPIN))'','',':UPIN')
    #END
+    #IF( #TEXT(Input_DID)='' )
      '' 
    #ELSE
        IF( le.Input_DID = (TYPEOF(le.Input_DID))'','',':DID')
    #END
+    #IF( #TEXT(Input_BDID)='' )
      '' 
    #ELSE
        IF( le.Input_BDID = (TYPEOF(le.Input_BDID))'','',':BDID')
    #END
+    #IF( #TEXT(Input_SRC)='' )
      '' 
    #ELSE
        IF( le.Input_SRC = (TYPEOF(le.Input_SRC))'','',':SRC')
    #END
+    #IF( #TEXT(Input_SOURCE_RID)='' )
      '' 
    #ELSE
        IF( le.Input_SOURCE_RID = (TYPEOF(le.Input_SOURCE_RID))'','',':SOURCE_RID')
    #END
+    #IF( #TEXT(Input_MAINNAME)='' )
      '' 
    #ELSE
        IF( le.Input_MAINNAME = (TYPEOF(le.Input_MAINNAME))'','',':MAINNAME')
    #END
+    #IF( #TEXT(Input_FULLNAME)='' )
      '' 
    #ELSE
        IF( le.Input_FULLNAME = (TYPEOF(le.Input_FULLNAME))'','',':FULLNAME')
    #END
+    #IF( #TEXT(Input_ADDR1)='' )
      '' 
    #ELSE
        IF( le.Input_ADDR1 = (TYPEOF(le.Input_ADDR1))'','',':ADDR1')
    #END
+    #IF( #TEXT(Input_LOCALE)='' )
      '' 
    #ELSE
        IF( le.Input_LOCALE = (TYPEOF(le.Input_LOCALE))'','',':LOCALE')
    #END
+    #IF( #TEXT(Input_ADDRESS)='' )
      '' 
    #ELSE
        IF( le.Input_ADDRESS = (TYPEOF(le.Input_ADDRESS))'','',':ADDRESS')
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
