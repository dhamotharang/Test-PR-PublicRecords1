EXPORT MAC_PopulationStatistics(infile,Ref='',Input_CNAME = '',Input_CNP_NAME = '',Input_CNP_NUMBER = '',Input_CNP_STORE_NUMBER = '',Input_CNP_BTYPE = '',Input_CNP_LOWV = '',Input_PRIM_RANGE = '',Input_PRIM_NAME = '',Input_SEC_RANGE = '',Input_V_CITY_NAME = '',Input_ST = '',Input_ZIP = '',Input_TAX_ID = '',Input_FEIN = '',Input_PHONE = '',Input_LIC_STATE = '',Input_C_LIC_NBR = '',Input_DEA_NUMBER = '',Input_VENDOR_ID = '',Input_NPI_NUMBER = '',Input_CLIA_NUMBER = '',Input_MEDICARE_FACILITY_NUMBER = '',Input_BDID = '',Input_SRC = '',Input_SOURCE_RID = '',Input_ADDR1 = '',Input_LOCALE = '',Input_ADDRESS = '',OutFile) := MACRO
  IMPORT SALT29,Health_Facility_Services;
  #uniquename(of)
  %of% := RECORD
    SALT29.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_CNAME)='' )
      '' 
    #ELSE
        IF( le.Input_CNAME = (TYPEOF(le.Input_CNAME))'','',':CNAME')
    #END
+    #IF( #TEXT(Input_CNP_NAME)='' )
      '' 
    #ELSE
        IF( le.Input_CNP_NAME = (TYPEOF(le.Input_CNP_NAME))'','',':CNP_NAME')
    #END
+    #IF( #TEXT(Input_CNP_NUMBER)='' )
      '' 
    #ELSE
        IF( le.Input_CNP_NUMBER = (TYPEOF(le.Input_CNP_NUMBER))'','',':CNP_NUMBER')
    #END
+    #IF( #TEXT(Input_CNP_STORE_NUMBER)='' )
      '' 
    #ELSE
        IF( le.Input_CNP_STORE_NUMBER = (TYPEOF(le.Input_CNP_STORE_NUMBER))'','',':CNP_STORE_NUMBER')
    #END
+    #IF( #TEXT(Input_CNP_BTYPE)='' )
      '' 
    #ELSE
        IF( le.Input_CNP_BTYPE = (TYPEOF(le.Input_CNP_BTYPE))'','',':CNP_BTYPE')
    #END
+    #IF( #TEXT(Input_CNP_LOWV)='' )
      '' 
    #ELSE
        IF( le.Input_CNP_LOWV = (TYPEOF(le.Input_CNP_LOWV))'','',':CNP_LOWV')
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
+    #IF( #TEXT(Input_TAX_ID)='' )
      '' 
    #ELSE
        IF( le.Input_TAX_ID = (TYPEOF(le.Input_TAX_ID))'','',':TAX_ID')
    #END
+    #IF( #TEXT(Input_FEIN)='' )
      '' 
    #ELSE
        IF( le.Input_FEIN = (TYPEOF(le.Input_FEIN))'','',':FEIN')
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
+    #IF( #TEXT(Input_CLIA_NUMBER)='' )
      '' 
    #ELSE
        IF( le.Input_CLIA_NUMBER = (TYPEOF(le.Input_CLIA_NUMBER))'','',':CLIA_NUMBER')
    #END
+    #IF( #TEXT(Input_MEDICARE_FACILITY_NUMBER)='' )
      '' 
    #ELSE
        IF( le.Input_MEDICARE_FACILITY_NUMBER = (TYPEOF(le.Input_MEDICARE_FACILITY_NUMBER))'','',':MEDICARE_FACILITY_NUMBER')
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
