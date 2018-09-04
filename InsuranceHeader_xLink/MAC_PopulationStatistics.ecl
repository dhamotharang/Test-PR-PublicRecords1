 
EXPORT MAC_PopulationStatistics(infile,Ref='',SRC='',Input_SNAME = '',Input_FNAME = '',Input_MNAME = '',Input_LNAME = '',Input_DERIVED_GENDER = '',Input_PRIM_RANGE = '',Input_PRIM_NAME = '',Input_SEC_RANGE = '',Input_CITY = '',Input_ST = '',Input_ZIP = '',Input_SSN5 = '',Input_SSN4 = '',Input_DOB = '',Input_PHONE = '',Input_DL_STATE = '',Input_DL_NBR = '',Input_SRC = '',Input_SOURCE_RID = '',Input_DT_FIRST_SEEN = '',Input_DT_LAST_SEEN = '',Input_DT_EFFECTIVE_FIRST = '',Input_DT_EFFECTIVE_LAST = '',Input_MAINNAME = '',Input_FULLNAME = '',Input_ADDR1 = '',Input_LOCALE = '',Input_ADDRESS = '',Input_fname2 = '',Input_lname2 = '',OutFile) := MACRO
  IMPORT SALT37,InsuranceHeader_xLink;
  #uniquename(of)
  %of% := RECORD
    #IF (#TEXT(SRC)<>'')
    SALT37.StrType source;
    #END
    SALT37.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_SNAME)='' )
      '' 
    #ELSE
        IF( le.Input_SNAME = (TYPEOF(le.Input_SNAME))'','',':SNAME')
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
 
+    #IF( #TEXT(Input_DERIVED_GENDER)='' )
      '' 
    #ELSE
        IF( le.Input_DERIVED_GENDER = (TYPEOF(le.Input_DERIVED_GENDER))'','',':DERIVED_GENDER')
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
 
+    #IF( #TEXT(Input_CITY)='' )
      '' 
    #ELSE
        IF( le.Input_CITY = (TYPEOF(le.Input_CITY))'','',':CITY')
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
 
+    #IF( #TEXT(Input_SSN5)='' )
      '' 
    #ELSE
        IF( le.Input_SSN5 = (TYPEOF(le.Input_SSN5))'','',':SSN5')
    #END
 
+    #IF( #TEXT(Input_SSN4)='' )
      '' 
    #ELSE
        IF( le.Input_SSN4 = (TYPEOF(le.Input_SSN4))'','',':SSN4')
    #END
 
+    #IF( #TEXT(Input_DOB)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_DOB = 0,'', ':DOB(' + SALT37.fn_date_valid_as_text((unsigned)le.Input_DOB) + ')' )
    #END
 
+    #IF( #TEXT(Input_PHONE)='' )
      '' 
    #ELSE
        IF( le.Input_PHONE = (TYPEOF(le.Input_PHONE))'','',':PHONE')
    #END
 
+    #IF( #TEXT(Input_DL_STATE)='' )
      '' 
    #ELSE
        IF( le.Input_DL_STATE = (TYPEOF(le.Input_DL_STATE))'','',':DL_STATE')
    #END
 
+    #IF( #TEXT(Input_DL_NBR)='' )
      '' 
    #ELSE
        IF( le.Input_DL_NBR = (TYPEOF(le.Input_DL_NBR))'','',':DL_NBR')
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
 
+    #IF( #TEXT(Input_DT_EFFECTIVE_FIRST)='' )
      '' 
    #ELSE
        IF( le.Input_DT_EFFECTIVE_FIRST = (TYPEOF(le.Input_DT_EFFECTIVE_FIRST))'','',':DT_EFFECTIVE_FIRST')
    #END
 
+    #IF( #TEXT(Input_DT_EFFECTIVE_LAST)='' )
      '' 
    #ELSE
        IF( le.Input_DT_EFFECTIVE_LAST = (TYPEOF(le.Input_DT_EFFECTIVE_LAST))'','',':DT_EFFECTIVE_LAST')
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
 
+    #IF( #TEXT(Input_fname2)='' )
      '' 
    #ELSE
        IF( le.Input_fname2 = (TYPEOF(le.Input_fname2))'','',':fname2')
    #END
 
+    #IF( #TEXT(Input_lname2)='' )
      '' 
    #ELSE
        IF( le.Input_lname2 = (TYPEOF(le.Input_lname2))'','',':lname2')
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
