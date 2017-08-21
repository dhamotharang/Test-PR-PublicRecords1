export MAC_GET_CDL_Population_Statistics(infile,Ref='',Input_LNAME = '',Input_FNAME = '',Input_MNAME = '',Input_NAME_SUFFIX = '',Input_TITLE = '',Input_P_CITY_NAME = '',Input_STATE = '',Input_PRIM_RANGE = '',Input_PRIM_NAME = '',Input_SEC_RANGE = '',Input_STATE_ORIGIN = '',Input_DID = '',Input_OFFENDER_KEY = '',Input_ORIG_SSN = '',Input_DOB = '',Input_INS_NUM = '',Input_CASE_NUMBER = '',Input_DLE_NUM = '',Input_FBI_NUM = '',Input_DOC_NUM = '',Input_ID_NUM = '',Input_SOR_NUMBER = '',Input_NCIC_NUMBER = '',Input_VEH_TAG = '',Input_DL_NUM = '',Input_VENDOR = '',Input_VEH_STATE = '',Input_DL_STATE = '',OutFile) := MACRO
  #uniquename(of)
  %of% := record
    string512 fields;
  end;
  #uniquename(ot)
  %of% %ot%(infile le) := transform
    self.fields :=
    #IF( #TEXT(Input_LNAME)='' )
      '' 
    #ELSE
        IF( le.Input_LNAME = '','',':LNAME')
    #END
+
    #IF( #TEXT(Input_FNAME)='' )
      '' 
    #ELSE
        IF( le.Input_FNAME = '','',':FNAME')
    #END
+
    #IF( #TEXT(Input_MNAME)='' )
      '' 
    #ELSE
        IF( le.Input_MNAME = '','',':MNAME')
    #END
+
    #IF( #TEXT(Input_NAME_SUFFIX)='' )
      '' 
    #ELSE
        IF( le.Input_NAME_SUFFIX = '','',':NAME_SUFFIX')
    #END
+
    #IF( #TEXT(Input_TITLE)='' )
      '' 
    #ELSE
        IF( le.Input_TITLE = '','',':TITLE')
    #END
+
    #IF( #TEXT(Input_P_CITY_NAME)='' )
      '' 
    #ELSE
        IF( le.Input_P_CITY_NAME = '','',':P_CITY_NAME')
    #END
+
    #IF( #TEXT(Input_STATE)='' )
      '' 
    #ELSE
        IF( le.Input_STATE = '','',':STATE')
    #END
+
    #IF( #TEXT(Input_PRIM_RANGE)='' )
      '' 
    #ELSE
        IF( le.Input_PRIM_RANGE = '','',':PRIM_RANGE')
    #END
+
    #IF( #TEXT(Input_PRIM_NAME)='' )
      '' 
    #ELSE
        IF( le.Input_PRIM_NAME = '','',':PRIM_NAME')
    #END
+
    #IF( #TEXT(Input_SEC_RANGE)='' )
      '' 
    #ELSE
        IF( le.Input_SEC_RANGE = '','',':SEC_RANGE')
    #END
+
    #IF( #TEXT(Input_STATE_ORIGIN)='' )
      '' 
    #ELSE
        IF( le.Input_STATE_ORIGIN = '','',':STATE_ORIGIN')
    #END
+
    #IF( #TEXT(Input_DID)='' )
      '' 
    #ELSE
        IF( le.Input_DID = '','',':DID')
    #END
+
    #IF( #TEXT(Input_OFFENDER_KEY)='' )
      '' 
    #ELSE
        IF( le.Input_OFFENDER_KEY = '','',':OFFENDER_KEY')
    #END
+
    #IF( #TEXT(Input_ORIG_SSN)='' )
      '' 
    #ELSE
        IF( le.Input_ORIG_SSN = '','',':ORIG_SSN')
    #END
+
    #IF( #TEXT(Input_DOB)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_DOB = 0,'', ':DOB(' + ngadl.fn_date_valid_as_text((unsigned)le.Input_DOB) + ')' )
    #END
+
    #IF( #TEXT(Input_INS_NUM)='' )
      '' 
    #ELSE
        IF( le.Input_INS_NUM = '','',':INS_NUM')
    #END
+
    #IF( #TEXT(Input_CASE_NUMBER)='' )
      '' 
    #ELSE
        IF( le.Input_CASE_NUMBER = '','',':CASE_NUMBER')
    #END
+
    #IF( #TEXT(Input_DLE_NUM)='' )
      '' 
    #ELSE
        IF( le.Input_DLE_NUM = '','',':DLE_NUM')
    #END
+
    #IF( #TEXT(Input_FBI_NUM)='' )
      '' 
    #ELSE
        IF( le.Input_FBI_NUM = '','',':FBI_NUM')
    #END
+
    #IF( #TEXT(Input_DOC_NUM)='' )
      '' 
    #ELSE
        IF( le.Input_DOC_NUM = '','',':DOC_NUM')
    #END
+
    #IF( #TEXT(Input_ID_NUM)='' )
      '' 
    #ELSE
        IF( le.Input_ID_NUM = '','',':ID_NUM')
    #END
+
    #IF( #TEXT(Input_SOR_NUMBER)='' )
      '' 
    #ELSE
        IF( le.Input_SOR_NUMBER = '','',':SOR_NUMBER')
    #END
+
    #IF( #TEXT(Input_NCIC_NUMBER)='' )
      '' 
    #ELSE
        IF( le.Input_NCIC_NUMBER = '','',':NCIC_NUMBER')
    #END
+
    #IF( #TEXT(Input_VEH_TAG)='' )
      '' 
    #ELSE
        IF( le.Input_VEH_TAG = '','',':VEH_TAG')
    #END
+
    #IF( #TEXT(Input_DL_NUM)='' )
      '' 
    #ELSE
        IF( le.Input_DL_NUM = '','',':DL_NUM')
    #END
+
    #IF( #TEXT(Input_VENDOR)='' )
      '' 
    #ELSE
        IF( le.Input_VENDOR = '','',':VENDOR')
    #END
+
    #IF( #TEXT(Input_VEH_STATE)='' )
      '' 
    #ELSE
        IF( le.Input_VEH_STATE = '','',':VEH_STATE')
    #END
+
    #IF( #TEXT(Input_DL_STATE)='' )
      '' 
    #ELSE
        IF( le.Input_DL_STATE = '','',':DL_STATE')
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
