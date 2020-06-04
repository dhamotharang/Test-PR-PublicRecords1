 
EXPORT MAC_PopulationStatistics(infile,Ref='',SRC='',Input_SRC = '',Input_SSN = '',Input_DOB = '',Input_LEXID = '',Input_SUFFIX = '',Input_FNAME = '',Input_MNAME = '',Input_LNAME = '',Input_GENDER = '',Input_PRIM_NAME = '',Input_PRIM_RANGE = '',Input_SEC_RANGE = '',Input_CITY_NAME = '',Input_ST = '',Input_ZIP = '',Input_DT_FIRST_SEEN = '',Input_DT_LAST_SEEN = '',Input_MAINNAME = '',Input_ADDR1 = '',Input_LOCALE = '',Input_ADDRESS = '',Input_FULLNAME = '',OutFile) := MACRO
  IMPORT SALT311,HealthcareNoMatchHeader_ExternalLinking;
  #uniquename(of)
  %of% := RECORD
    #IF (#TEXT(SRC)<>'')
    SALT311.StrType source;
    #END
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_SRC)='' )
      '' 
    #ELSE
        IF( le.Input_SRC = (TYPEOF(le.Input_SRC))'','',':SRC')
    #END
 
+    #IF( #TEXT(Input_SSN)='' )
      '' 
    #ELSE
        IF( le.Input_SSN = (TYPEOF(le.Input_SSN))'','',':SSN')
    #END
 
+    #IF( #TEXT(Input_DOB)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_DOB = 0,'', ':DOB(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_DOB) + ')' )
    #END
 
+    #IF( #TEXT(Input_LEXID)='' )
      '' 
    #ELSE
        IF( le.Input_LEXID = (TYPEOF(le.Input_LEXID))'','',':LEXID')
    #END
 
+    #IF( #TEXT(Input_SUFFIX)='' )
      '' 
    #ELSE
        IF( le.Input_SUFFIX = (TYPEOF(le.Input_SUFFIX))'','',':SUFFIX')
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
 
+    #IF( #TEXT(Input_GENDER)='' )
      '' 
    #ELSE
        IF( le.Input_GENDER = (TYPEOF(le.Input_GENDER))'','',':GENDER')
    #END
 
+    #IF( #TEXT(Input_PRIM_NAME)='' )
      '' 
    #ELSE
        IF( le.Input_PRIM_NAME = (TYPEOF(le.Input_PRIM_NAME))'','',':PRIM_NAME')
    #END
 
+    #IF( #TEXT(Input_PRIM_RANGE)='' )
      '' 
    #ELSE
        IF( le.Input_PRIM_RANGE = (TYPEOF(le.Input_PRIM_RANGE))'','',':PRIM_RANGE')
    #END
 
+    #IF( #TEXT(Input_SEC_RANGE)='' )
      '' 
    #ELSE
        IF( le.Input_SEC_RANGE = (TYPEOF(le.Input_SEC_RANGE))'','',':SEC_RANGE')
    #END
 
+    #IF( #TEXT(Input_CITY_NAME)='' )
      '' 
    #ELSE
        IF( le.Input_CITY_NAME = (TYPEOF(le.Input_CITY_NAME))'','',':CITY_NAME')
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
 
+    #IF( #TEXT(Input_MAINNAME)='' )
      '' 
    #ELSE
        IF( le.Input_MAINNAME = (TYPEOF(le.Input_MAINNAME))'','',':MAINNAME')
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
 
+    #IF( #TEXT(Input_FULLNAME)='' )
      '' 
    #ELSE
        IF( le.Input_FULLNAME = (TYPEOF(le.Input_FULLNAME))'','',':FULLNAME')
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
