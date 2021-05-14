 
EXPORT Input_MAC_PopulationStatistics(infile,Ref='',Input_classification = '',Input_name = '',Input_prefix = '',Input_firstname = '',Input_middlename = '',Input_lastname = '',Input_suffix = '',Input_address_1 = '',Input_address_2 = '',Input_address_3 = '',Input_address_4 = '',Input_city = '',Input_state = '',Input_country = '',Input_zipcode = '',Input_duns = '',Input_exclusionprogram = '',Input_excludingagency = '',Input_ctcode = '',Input_exclusiontype = '',Input_additionalcomments = '',Input_activedate = '',Input_terminationdate = '',Input_recordstatus = '',Input_crossreference = '',Input_samnumber = '',Input_cage = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_SAM;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_classification)='' )
      '' 
    #ELSE
        IF( le.Input_classification = (TYPEOF(le.Input_classification))'','',':classification')
    #END
 
+    #IF( #TEXT(Input_name)='' )
      '' 
    #ELSE
        IF( le.Input_name = (TYPEOF(le.Input_name))'','',':name')
    #END
 
+    #IF( #TEXT(Input_prefix)='' )
      '' 
    #ELSE
        IF( le.Input_prefix = (TYPEOF(le.Input_prefix))'','',':prefix')
    #END
 
+    #IF( #TEXT(Input_firstname)='' )
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
 
+    #IF( #TEXT(Input_address_1)='' )
      '' 
    #ELSE
        IF( le.Input_address_1 = (TYPEOF(le.Input_address_1))'','',':address_1')
    #END
 
+    #IF( #TEXT(Input_address_2)='' )
      '' 
    #ELSE
        IF( le.Input_address_2 = (TYPEOF(le.Input_address_2))'','',':address_2')
    #END
 
+    #IF( #TEXT(Input_address_3)='' )
      '' 
    #ELSE
        IF( le.Input_address_3 = (TYPEOF(le.Input_address_3))'','',':address_3')
    #END
 
+    #IF( #TEXT(Input_address_4)='' )
      '' 
    #ELSE
        IF( le.Input_address_4 = (TYPEOF(le.Input_address_4))'','',':address_4')
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
 
+    #IF( #TEXT(Input_country)='' )
      '' 
    #ELSE
        IF( le.Input_country = (TYPEOF(le.Input_country))'','',':country')
    #END
 
+    #IF( #TEXT(Input_zipcode)='' )
      '' 
    #ELSE
        IF( le.Input_zipcode = (TYPEOF(le.Input_zipcode))'','',':zipcode')
    #END
 
+    #IF( #TEXT(Input_duns)='' )
      '' 
    #ELSE
        IF( le.Input_duns = (TYPEOF(le.Input_duns))'','',':duns')
    #END
 
+    #IF( #TEXT(Input_exclusionprogram)='' )
      '' 
    #ELSE
        IF( le.Input_exclusionprogram = (TYPEOF(le.Input_exclusionprogram))'','',':exclusionprogram')
    #END
 
+    #IF( #TEXT(Input_excludingagency)='' )
      '' 
    #ELSE
        IF( le.Input_excludingagency = (TYPEOF(le.Input_excludingagency))'','',':excludingagency')
    #END
 
+    #IF( #TEXT(Input_ctcode)='' )
      '' 
    #ELSE
        IF( le.Input_ctcode = (TYPEOF(le.Input_ctcode))'','',':ctcode')
    #END
 
+    #IF( #TEXT(Input_exclusiontype)='' )
      '' 
    #ELSE
        IF( le.Input_exclusiontype = (TYPEOF(le.Input_exclusiontype))'','',':exclusiontype')
    #END
 
+    #IF( #TEXT(Input_additionalcomments)='' )
      '' 
    #ELSE
        IF( le.Input_additionalcomments = (TYPEOF(le.Input_additionalcomments))'','',':additionalcomments')
    #END
 
+    #IF( #TEXT(Input_activedate)='' )
      '' 
    #ELSE
        IF( le.Input_activedate = (TYPEOF(le.Input_activedate))'','',':activedate')
    #END
 
+    #IF( #TEXT(Input_terminationdate)='' )
      '' 
    #ELSE
        IF( le.Input_terminationdate = (TYPEOF(le.Input_terminationdate))'','',':terminationdate')
    #END
 
+    #IF( #TEXT(Input_recordstatus)='' )
      '' 
    #ELSE
        IF( le.Input_recordstatus = (TYPEOF(le.Input_recordstatus))'','',':recordstatus')
    #END
 
+    #IF( #TEXT(Input_crossreference)='' )
      '' 
    #ELSE
        IF( le.Input_crossreference = (TYPEOF(le.Input_crossreference))'','',':crossreference')
    #END
 
+    #IF( #TEXT(Input_samnumber)='' )
      '' 
    #ELSE
        IF( le.Input_samnumber = (TYPEOF(le.Input_samnumber))'','',':samnumber')
    #END
 
+    #IF( #TEXT(Input_cage)='' )
      '' 
    #ELSE
        IF( le.Input_cage = (TYPEOF(le.Input_cage))'','',':cage')
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
