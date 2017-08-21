export MAC__Population_Statistics(infile,Ref='',Input_SSN = '',Input_VENDOR_ID = '',Input_PHONE = '',Input_LNAME = '',Input_PRIM_NAME = '',Input_DOB = '',Input_PRIM_RANGE = '',Input_SEC_RANGE = '',Input_FNAME = '',Input_CITY_NAME = '',Input_MNAME = '',Input_NAME_SUFFIX = '',Input_ST = '',Input_GENDER = '',Input_SRC = '',OutFile) := MACRO
  #uniquename(of)
  %of% := record
    string512 fields;
  end;
  #uniquename(ot)
  %of% %ot%(infile le) := transform
    self.fields :=
    #IF( #TEXT(Input_SSN)='' )
      '' 
    #ELSE
        IF( le.Input_SSN = (typeof(le.Input_SSN))'','',':SSN')
    #END
+
    #IF( #TEXT(Input_VENDOR_ID)='' )
      '' 
    #ELSE
        IF( le.Input_VENDOR_ID = (typeof(le.Input_VENDOR_ID))'','',':VENDOR_ID')
    #END
+
    #IF( #TEXT(Input_PHONE)='' )
      '' 
    #ELSE
        IF( le.Input_PHONE = (typeof(le.Input_PHONE))'','',':PHONE')
    #END
+
    #IF( #TEXT(Input_LNAME)='' )
      '' 
    #ELSE
        IF( le.Input_LNAME = (typeof(le.Input_LNAME))'','',':LNAME')
    #END
+
    #IF( #TEXT(Input_PRIM_NAME)='' )
      '' 
    #ELSE
        IF( le.Input_PRIM_NAME = (typeof(le.Input_PRIM_NAME))'','',':PRIM_NAME')
    #END
+
    #IF( #TEXT(Input_DOB)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_DOB = 0,'', ':DOB(' + Gordon.fn_date_valid_as_text((unsigned)le.Input_DOB) + ')' )
    #END
+
    #IF( #TEXT(Input_PRIM_RANGE)='' )
      '' 
    #ELSE
        IF( le.Input_PRIM_RANGE = (typeof(le.Input_PRIM_RANGE))'','',':PRIM_RANGE')
    #END
+
    #IF( #TEXT(Input_SEC_RANGE)='' )
      '' 
    #ELSE
        IF( le.Input_SEC_RANGE = (typeof(le.Input_SEC_RANGE))'','',':SEC_RANGE')
    #END
+
    #IF( #TEXT(Input_FNAME)='' )
      '' 
    #ELSE
        IF( le.Input_FNAME = (typeof(le.Input_FNAME))'','',':FNAME')
    #END
+
    #IF( #TEXT(Input_CITY_NAME)='' )
      '' 
    #ELSE
        IF( le.Input_CITY_NAME = (typeof(le.Input_CITY_NAME))'','',':CITY_NAME')
    #END
+
    #IF( #TEXT(Input_MNAME)='' )
      '' 
    #ELSE
        IF( le.Input_MNAME = (typeof(le.Input_MNAME))'','',':MNAME')
    #END
+
    #IF( #TEXT(Input_NAME_SUFFIX)='' )
      '' 
    #ELSE
        IF( le.Input_NAME_SUFFIX = (typeof(le.Input_NAME_SUFFIX))'','',':NAME_SUFFIX')
    #END
+
    #IF( #TEXT(Input_ST)='' )
      '' 
    #ELSE
        IF( le.Input_ST = (typeof(le.Input_ST))'','',':ST')
    #END
+
    #IF( #TEXT(Input_GENDER)='' )
      '' 
    #ELSE
        IF( le.Input_GENDER = (typeof(le.Input_GENDER))'','',':GENDER')
    #END
+
    #IF( #TEXT(Input_SRC)='' )
      '' 
    #ELSE
        IF( le.Input_SRC = (typeof(le.Input_SRC))'','',':SRC')
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
