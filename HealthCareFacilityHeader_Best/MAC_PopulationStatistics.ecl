EXPORT MAC_PopulationStatistics(infile,Ref='',SRC='',Input_PHONE = '',Input_FAX = '',Input_UPIN = '',Input_NPI_NUMBER = '',Input_DEA_NUMBER = '',Input_CLIA_NUMBER = '',Input_MEDICARE_FACILITY_NUMBER = '',Input_NCPDP_NUMBER = '',Input_TAX_ID = '',Input_FEIN = '',Input_C_LIC_NBR = '',Input_SRC = '',Input_CNAME = '',Input_CNP_NAME = '',Input_CNP_NUMBER = '',Input_CNP_STORE_NUMBER = '',Input_CNP_BTYPE = '',Input_CNP_LOWV = '',Input_CNP_TRANSLATED = '',Input_CNP_CLASSID = '',Input_ADDRESS_ID = '',Input_ADDRESS_CLASSIFICATION = '',Input_PRIM_RANGE = '',Input_PRIM_NAME = '',Input_SEC_RANGE = '',Input_ST = '',Input_V_CITY_NAME = '',Input_ZIP = '',Input_TAXONOMY = '',Input_TAXONOMY_CODE = '',Input_MEDICAID_NUMBER = '',Input_VENDOR_ID = '',Input_DT_FIRST_SEEN = '',Input_DT_LAST_SEEN = '',Input_DT_LIC_EXPIRATION = '',Input_DT_DEA_EXPIRATION = '',Input_FAC_NAME = '',Input_ADDR1 = '',Input_LOCALE = '',Input_ADDRESS = '',Input_LIC_STATE = '',OutFile) := MACRO
  IMPORT SALT30,HealthCareFacilityHeader_Best;
  #uniquename(of)
  %of% := RECORD
    #IF (#TEXT(SRC)<>'')
    SALT30.StrType source;
    #END
    SALT30.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_PHONE)='' )
      '' 
    #ELSE
        IF( le.Input_PHONE = (TYPEOF(le.Input_PHONE))'','',':PHONE')
    #END
+    #IF( #TEXT(Input_FAX)='' )
      '' 
    #ELSE
        IF( le.Input_FAX = (TYPEOF(le.Input_FAX))'','',':FAX')
    #END
+    #IF( #TEXT(Input_UPIN)='' )
      '' 
    #ELSE
        IF( le.Input_UPIN = (TYPEOF(le.Input_UPIN))'','',':UPIN')
    #END
+    #IF( #TEXT(Input_NPI_NUMBER)='' )
      '' 
    #ELSE
        IF( le.Input_NPI_NUMBER = (TYPEOF(le.Input_NPI_NUMBER))'','',':NPI_NUMBER')
    #END
+    #IF( #TEXT(Input_DEA_NUMBER)='' )
      '' 
    #ELSE
        IF( le.Input_DEA_NUMBER = (TYPEOF(le.Input_DEA_NUMBER))'','',':DEA_NUMBER')
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
+    #IF( #TEXT(Input_NCPDP_NUMBER)='' )
      '' 
    #ELSE
        IF( le.Input_NCPDP_NUMBER = (TYPEOF(le.Input_NCPDP_NUMBER))'','',':NCPDP_NUMBER')
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
+    #IF( #TEXT(Input_C_LIC_NBR)='' )
      '' 
    #ELSE
        IF( le.Input_C_LIC_NBR = (TYPEOF(le.Input_C_LIC_NBR))'','',':C_LIC_NBR')
    #END
+    #IF( #TEXT(Input_SRC)='' )
      '' 
    #ELSE
        IF( le.Input_SRC = (TYPEOF(le.Input_SRC))'','',':SRC')
    #END
+    #IF( #TEXT(Input_CNAME)='' )
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
+    #IF( #TEXT(Input_CNP_TRANSLATED)='' )
      '' 
    #ELSE
        IF( le.Input_CNP_TRANSLATED = (TYPEOF(le.Input_CNP_TRANSLATED))'','',':CNP_TRANSLATED')
    #END
+    #IF( #TEXT(Input_CNP_CLASSID)='' )
      '' 
    #ELSE
        IF( le.Input_CNP_CLASSID = (TYPEOF(le.Input_CNP_CLASSID))'','',':CNP_CLASSID')
    #END
+    #IF( #TEXT(Input_ADDRESS_ID)='' )
      '' 
    #ELSE
        IF( le.Input_ADDRESS_ID = (TYPEOF(le.Input_ADDRESS_ID))'','',':ADDRESS_ID')
    #END
+    #IF( #TEXT(Input_ADDRESS_CLASSIFICATION)='' )
      '' 
    #ELSE
        IF( le.Input_ADDRESS_CLASSIFICATION = (TYPEOF(le.Input_ADDRESS_CLASSIFICATION))'','',':ADDRESS_CLASSIFICATION')
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
+    #IF( #TEXT(Input_ST)='' )
      '' 
    #ELSE
        IF( le.Input_ST = (TYPEOF(le.Input_ST))'','',':ST')
    #END
+    #IF( #TEXT(Input_V_CITY_NAME)='' )
      '' 
    #ELSE
        IF( le.Input_V_CITY_NAME = (TYPEOF(le.Input_V_CITY_NAME))'','',':V_CITY_NAME')
    #END
+    #IF( #TEXT(Input_ZIP)='' )
      '' 
    #ELSE
        IF( le.Input_ZIP = (TYPEOF(le.Input_ZIP))'','',':ZIP')
    #END
+    #IF( #TEXT(Input_TAXONOMY)='' )
      '' 
    #ELSE
        IF( le.Input_TAXONOMY = (TYPEOF(le.Input_TAXONOMY))'','',':TAXONOMY')
    #END
+    #IF( #TEXT(Input_TAXONOMY_CODE)='' )
      '' 
    #ELSE
        IF( le.Input_TAXONOMY_CODE = (TYPEOF(le.Input_TAXONOMY_CODE))'','',':TAXONOMY_CODE')
    #END
+    #IF( #TEXT(Input_MEDICAID_NUMBER)='' )
      '' 
    #ELSE
        IF( le.Input_MEDICAID_NUMBER = (TYPEOF(le.Input_MEDICAID_NUMBER))'','',':MEDICAID_NUMBER')
    #END
+    #IF( #TEXT(Input_VENDOR_ID)='' )
      '' 
    #ELSE
        IF( le.Input_VENDOR_ID = (TYPEOF(le.Input_VENDOR_ID))'','',':VENDOR_ID')
    #END
+    #IF( #TEXT(Input_DT_FIRST_SEEN)='' )
      '' 
    #ELSE
        IF( le.Input_DT_FIRST_SEEN = (TYPEOF(le.Input_DT_FIRST_SEEN))'','',':DT_FIRST_SEEN')
    #END
+    #IF( #TEXT(Input_DT_LAST_SEEN)='' )
      '' 
    #ELSE
        IF( le.Input_DT_LAST_SEEN = (TYPEOF(le.Input_DT_LAST_SEEN))'','',':DT_LAST_SEEN')
    #END
+    #IF( #TEXT(Input_DT_LIC_EXPIRATION)='' )
      '' 
    #ELSE
        IF( le.Input_DT_LIC_EXPIRATION = (TYPEOF(le.Input_DT_LIC_EXPIRATION))'','',':DT_LIC_EXPIRATION')
    #END
+    #IF( #TEXT(Input_DT_DEA_EXPIRATION)='' )
      '' 
    #ELSE
        IF( le.Input_DT_DEA_EXPIRATION = (TYPEOF(le.Input_DT_DEA_EXPIRATION))'','',':DT_DEA_EXPIRATION')
    #END
+    #IF( #TEXT(Input_FAC_NAME)='' )
      '' 
    #ELSE
        IF( le.Input_FAC_NAME = (TYPEOF(le.Input_FAC_NAME))'','',':FAC_NAME')
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
+    #IF( #TEXT(Input_LIC_STATE)='' )
      '' 
    #ELSE
        IF( le.Input_LIC_STATE = (TYPEOF(le.Input_LIC_STATE))'','',':LIC_STATE')
    #END
;
    #IF (#TEXT(SRC)<>'')
    SELF.source := le.SRC;
    #END
  END;
  #uniquename(op)
  %op% := PROJECT(infile,%ot%(LEFT));
  #uniquename(ort)
  %ort% := RECORD
    #IF (#TEXT(SRC)<>'')
    %op%.source;
    #END
    %op%.fields;
    UNSIGNED cnt := COUNT(GROUP);
  END;
  outfile := TOPN( TABLE( %op%, %ort%,#IF( #TEXT(SRC)<>'' ) source, #END fields, FEW ), 1000,#IF( #TEXT(SRC)<>'' ) source, #END -cnt );
ENDMACRO;
