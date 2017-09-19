 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_NAME_SUFFIX = '',Input_FNAME = '',Input_MNAME = '',Input_LNAME = '',Input_PRIM_RANGE = '',Input_PRIM_NAME = '',Input_SEC_RANGE = '',Input_P_CITY_NAME = '',Input_ST = '',Input_ZIP = '',Input_DOB = '',Input_PHONE = '',Input_DL_ST = '',Input_DL = '',Input_LEXID = '',Input_POSSIBLE_SSN = '',Input_CRIME = '',Input_NAME_TYPE = '',Input_CLEAN_GENDER = '',Input_CLASS_CODE = '',Input_DT_FIRST_SEEN = '',Input_DT_LAST_SEEN = '',Input_DATA_PROVIDER_ORI = '',Input_VIN = '',Input_PLATE = '',Input_LATITUDE = '',Input_LONGITUDE = '',Input_SEARCH_ADDR1 = '',Input_SEARCH_ADDR2 = '',Input_MAINNAME = '',Input_FULLNAME = '',OutFile) := MACRO
  IMPORT SALT33,Bair_ExternalLinkKeys;
  #uniquename(of)
  %of% := RECORD
    SALT33.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_NAME_SUFFIX)='' )
      '' 
    #ELSE
        IF( le.Input_NAME_SUFFIX = (TYPEOF(le.Input_NAME_SUFFIX))'','',':NAME_SUFFIX')
    #END
 
+    #IF( #TEXT(Input_FNAME)='' )
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
 
+    #IF( #TEXT(Input_P_CITY_NAME)='' )
      '' 
    #ELSE
        IF( le.Input_P_CITY_NAME = (TYPEOF(le.Input_P_CITY_NAME))'','',':P_CITY_NAME')
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
 
+    #IF( #TEXT(Input_DOB)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_DOB = 0,'', ':DOB(' + SALT33.fn_date_valid_as_text((unsigned)le.Input_DOB) + ')' )
    #END
 
+    #IF( #TEXT(Input_PHONE)='' )
      '' 
    #ELSE
        IF( le.Input_PHONE = (TYPEOF(le.Input_PHONE))'','',':PHONE')
    #END
 
+    #IF( #TEXT(Input_DL_ST)='' )
      '' 
    #ELSE
        IF( le.Input_DL_ST = (TYPEOF(le.Input_DL_ST))'','',':DL_ST')
    #END
 
+    #IF( #TEXT(Input_DL)='' )
      '' 
    #ELSE
        IF( le.Input_DL = (TYPEOF(le.Input_DL))'','',':DL')
    #END
 
+    #IF( #TEXT(Input_LEXID)='' )
      '' 
    #ELSE
        IF( le.Input_LEXID = (TYPEOF(le.Input_LEXID))'','',':LEXID')
    #END
 
+    #IF( #TEXT(Input_POSSIBLE_SSN)='' )
      '' 
    #ELSE
        IF( le.Input_POSSIBLE_SSN = (TYPEOF(le.Input_POSSIBLE_SSN))'','',':POSSIBLE_SSN')
    #END
 
+    #IF( #TEXT(Input_CRIME)='' )
      '' 
    #ELSE
        IF( le.Input_CRIME = (TYPEOF(le.Input_CRIME))'','',':CRIME')
    #END
 
+    #IF( #TEXT(Input_NAME_TYPE)='' )
      '' 
    #ELSE
        IF( le.Input_NAME_TYPE = (TYPEOF(le.Input_NAME_TYPE))'','',':NAME_TYPE')
    #END
 
+    #IF( #TEXT(Input_CLEAN_GENDER)='' )
      '' 
    #ELSE
        IF( le.Input_CLEAN_GENDER = (TYPEOF(le.Input_CLEAN_GENDER))'','',':CLEAN_GENDER')
    #END
 
+    #IF( #TEXT(Input_CLASS_CODE)='' )
      '' 
    #ELSE
        IF( le.Input_CLASS_CODE = (TYPEOF(le.Input_CLASS_CODE))'','',':CLASS_CODE')
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
 
+    #IF( #TEXT(Input_DATA_PROVIDER_ORI)='' )
      '' 
    #ELSE
        IF( le.Input_DATA_PROVIDER_ORI = (TYPEOF(le.Input_DATA_PROVIDER_ORI))'','',':DATA_PROVIDER_ORI')
    #END
 
+    #IF( #TEXT(Input_VIN)='' )
      '' 
    #ELSE
        IF( le.Input_VIN = (TYPEOF(le.Input_VIN))'','',':VIN')
    #END
 
+    #IF( #TEXT(Input_PLATE)='' )
      '' 
    #ELSE
        IF( le.Input_PLATE = (TYPEOF(le.Input_PLATE))'','',':PLATE')
    #END
 
+    #IF( #TEXT(Input_LATITUDE)='' )
      '' 
    #ELSE
        IF( le.Input_LATITUDE = (TYPEOF(le.Input_LATITUDE))'','',':LATITUDE')
    #END
 
+    #IF( #TEXT(Input_LONGITUDE)='' )
      '' 
    #ELSE
        IF( le.Input_LONGITUDE = (TYPEOF(le.Input_LONGITUDE))'','',':LONGITUDE')
    #END
 
+    #IF( #TEXT(Input_SEARCH_ADDR1)='' )
      '' 
    #ELSE
        IF( le.Input_SEARCH_ADDR1 = (TYPEOF(le.Input_SEARCH_ADDR1))'','',':SEARCH_ADDR1')
    #END
 
+    #IF( #TEXT(Input_SEARCH_ADDR2)='' )
      '' 
    #ELSE
        IF( le.Input_SEARCH_ADDR2 = (TYPEOF(le.Input_SEARCH_ADDR2))'','',':SEARCH_ADDR2')
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
