export MAC_xADL2_Population_Statistics(infile,Ref='',Input_NAME_SUFFIX = '',Input_FNAME = '',Input_MNAME = '',Input_LNAME = '',Input_PRIM_RANGE = '',Input_PRIM_NAME = '',Input_SEC_RANGE = '',Input_CITY = '',Input_STATE = '',Input_ZIP = '',Input_ZIP4 = '',Input_COUNTY = '',Input_SSN5 = '',Input_SSN4 = '',Input_DOB = '',Input_PHONE = '',Input_MAINNAME = '',Input_FULLNAME = '',Input_ADDR1 = '',Input_LOCALE = '',Input_ADDRS = '',OutFile) := MACRO
  #uniquename(of)
  %of% := record
    string512 fields;
  end;
  #uniquename(ot)
  %of% %ot%(infile le) := transform
    self.fields :=
    #IF( #TEXT(Input_NAME_SUFFIX)='' )
      '' 
    #ELSE
        IF( le.Input_NAME_SUFFIX = (typeof(le.Input_NAME_SUFFIX))'','',':NAME_SUFFIX')
    #END
+
    #IF( #TEXT(Input_FNAME)='' )
      '' 
    #ELSE
        IF( le.Input_FNAME = (typeof(le.Input_FNAME))'','',':FNAME')
    #END
+
    #IF( #TEXT(Input_MNAME)='' )
      '' 
    #ELSE
        IF( le.Input_MNAME = (typeof(le.Input_MNAME))'','',':MNAME')
    #END
+
    #IF( #TEXT(Input_LNAME)='' )
      '' 
    #ELSE
        IF( le.Input_LNAME = (typeof(le.Input_LNAME))'','',':LNAME')
    #END
+
    #IF( #TEXT(Input_PRIM_RANGE)='' )
      '' 
    #ELSE
        IF( le.Input_PRIM_RANGE = (typeof(le.Input_PRIM_RANGE))'','',':PRIM_RANGE')
    #END
+
    #IF( #TEXT(Input_PRIM_NAME)='' )
      '' 
    #ELSE
        IF( le.Input_PRIM_NAME = (typeof(le.Input_PRIM_NAME))'','',':PRIM_NAME')
    #END
+
    #IF( #TEXT(Input_SEC_RANGE)='' )
      '' 
    #ELSE
        IF( le.Input_SEC_RANGE = (typeof(le.Input_SEC_RANGE))'','',':SEC_RANGE')
    #END
+
    #IF( #TEXT(Input_CITY)='' )
      '' 
    #ELSE
        IF( le.Input_CITY = (typeof(le.Input_CITY))'','',':CITY')
    #END
+
    #IF( #TEXT(Input_STATE)='' )
      '' 
    #ELSE
        IF( le.Input_STATE = (typeof(le.Input_STATE))'','',':STATE')
    #END
+
    #IF( #TEXT(Input_ZIP)='' )
      '' 
    #ELSE
        IF( le.Input_ZIP = (typeof(le.Input_ZIP))'','',':ZIP')
    #END
+
    #IF( #TEXT(Input_ZIP4)='' )
      '' 
    #ELSE
        IF( le.Input_ZIP4 = (typeof(le.Input_ZIP4))'','',':ZIP4')
    #END
+
    #IF( #TEXT(Input_COUNTY)='' )
      '' 
    #ELSE
        IF( le.Input_COUNTY = (typeof(le.Input_COUNTY))'','',':COUNTY')
    #END
+
    #IF( #TEXT(Input_SSN5)='' )
      '' 
    #ELSE
        IF( le.Input_SSN5 = (typeof(le.Input_SSN5))'','',':SSN5')
    #END
+
    #IF( #TEXT(Input_SSN4)='' )
      '' 
    #ELSE
        IF( le.Input_SSN4 = (typeof(le.Input_SSN4))'','',':SSN4')
    #END
+
    #IF( #TEXT(Input_DOB)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_DOB = 0,'', ':DOB(' + SALT20.fn_date_valid_as_text((unsigned)le.Input_DOB) + ')' )
    #END
+
    #IF( #TEXT(Input_PHONE)='' )
      '' 
    #ELSE
        IF( le.Input_PHONE = (typeof(le.Input_PHONE))'','',':PHONE')
    #END
+
    #IF( #TEXT(Input_MAINNAME)='' )
      '' 
    #ELSE
        IF( le.Input_MAINNAME = (typeof(le.Input_MAINNAME))'','',':MAINNAME')
    #END
+
    #IF( #TEXT(Input_FULLNAME)='' )
      '' 
    #ELSE
        IF( le.Input_FULLNAME = (typeof(le.Input_FULLNAME))'','',':FULLNAME')
    #END
+
    #IF( #TEXT(Input_ADDR1)='' )
      '' 
    #ELSE
        IF( le.Input_ADDR1 = (typeof(le.Input_ADDR1))'','',':ADDR1')
    #END
+
    #IF( #TEXT(Input_LOCALE)='' )
      '' 
    #ELSE
        IF( le.Input_LOCALE = (typeof(le.Input_LOCALE))'','',':LOCALE')
    #END
+
    #IF( #TEXT(Input_ADDRS)='' )
      '' 
    #ELSE
        IF( le.Input_ADDRS = (typeof(le.Input_ADDRS))'','',':ADDRS')
    #END
;
  end;
  #uniquename(op)
  %op% := project(infile,%ot%(left));
  #uniquename(ort)
  %ort% := record
    %op%.fields;
    unsigned cnt := count(group);
  end;
  outfile := topn( table( %op%, %ort%, fields, few ), 1000, -cnt );
ENDMACRO;
