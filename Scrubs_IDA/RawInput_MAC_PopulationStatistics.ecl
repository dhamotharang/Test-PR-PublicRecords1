
EXPORT RawInput_MAC_PopulationStatistics(infile,Ref='',Input_firstname = '',Input_middlename = '',Input_lastname = '',Input_suffix = '',Input_addressline1 = '',Input_addressline2 = '',Input_city = '',Input_state = '',Input_zip = '',Input_dob = '',Input_ssn = '',Input_dl = '',Input_dlstate = '',Input_phone = '',Input_clientassigneduniquerecordid = '',Input_emailaddress = '',Input_ipaddress = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_IDA;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_firstname)='' )
      '' 
    #ELSE
        IF( le.Input_firstname = (TYPEOF(le.Input_firstname))'','',':firstname')
    #END

+    #IF( #TEXT(Input_middlename)='' )
      '' 
    #ELSE
        IF( le.Input_middlename = (TYPEOF(le.Input_middlename))'','',':middlename')
    #END

+    #IF( #TEXT(Input_lastname)='' )
      '' 
    #ELSE
        IF( le.Input_lastname = (TYPEOF(le.Input_lastname))'','',':lastname')
    #END

+    #IF( #TEXT(Input_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_suffix = (TYPEOF(le.Input_suffix))'','',':suffix')
    #END

+    #IF( #TEXT(Input_addressline1)='' )
      '' 
    #ELSE
        IF( le.Input_addressline1 = (TYPEOF(le.Input_addressline1))'','',':addressline1')
    #END

+    #IF( #TEXT(Input_addressline2)='' )
      '' 
    #ELSE
        IF( le.Input_addressline2 = (TYPEOF(le.Input_addressline2))'','',':addressline2')
    #END

+    #IF( #TEXT(Input_city)='' )
      '' 
    #ELSE
        IF( le.Input_city = (TYPEOF(le.Input_city))'','',':city')
    #END

+    #IF( #TEXT(Input_state)='' )
      '' 
    #ELSE
        IF( le.Input_state = (TYPEOF(le.Input_state))'','',':state')
    #END

+    #IF( #TEXT(Input_zip)='' )
      '' 
    #ELSE
        IF( le.Input_zip = (TYPEOF(le.Input_zip))'','',':zip')
    #END

+    #IF( #TEXT(Input_dob)='' )
      '' 
    #ELSE
        IF( le.Input_dob = (TYPEOF(le.Input_dob))'','',':dob')
    #END

+    #IF( #TEXT(Input_ssn)='' )
      '' 
    #ELSE
        IF( le.Input_ssn = (TYPEOF(le.Input_ssn))'','',':ssn')
    #END

+    #IF( #TEXT(Input_dl)='' )
      '' 
    #ELSE
        IF( le.Input_dl = (TYPEOF(le.Input_dl))'','',':dl')
    #END

+    #IF( #TEXT(Input_dlstate)='' )
      '' 
    #ELSE
        IF( le.Input_dlstate = (TYPEOF(le.Input_dlstate))'','',':dlstate')
    #END

+    #IF( #TEXT(Input_phone)='' )
      '' 
    #ELSE
        IF( le.Input_phone = (TYPEOF(le.Input_phone))'','',':phone')
    #END

+    #IF( #TEXT(Input_clientassigneduniquerecordid)='' )
      '' 
    #ELSE
        IF( le.Input_clientassigneduniquerecordid = (TYPEOF(le.Input_clientassigneduniquerecordid))'','',':clientassigneduniquerecordid')
    #END

+    #IF( #TEXT(Input_emailaddress)='' )
      '' 
    #ELSE
        IF( le.Input_emailaddress = (TYPEOF(le.Input_emailaddress))'','',':emailaddress')
    #END

+    #IF( #TEXT(Input_ipaddress)='' )
      '' 
    #ELSE
        IF( le.Input_ipaddress = (TYPEOF(le.Input_ipaddress))'','',':ipaddress')
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
