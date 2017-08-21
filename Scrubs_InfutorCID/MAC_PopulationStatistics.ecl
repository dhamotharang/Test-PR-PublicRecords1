EXPORT MAC_PopulationStatistics(infile,Ref='',Input_orig_phone = '',Input_orig_phonetype = '',Input_orig_directindial = '',Input_orig_recordtype = '',Input_orig_firstdate = '',Input_orig_lastdate = '',Input_orig_telconame = '',Input_orig_businessname = '',Input_orig_firstname = '',Input_orig_mi = '',Input_orig_lastname = '',Input_orig_primaryhousenumber = '',Input_orig_primarypredirabbrev = '',Input_orig_primarystreetname = '',Input_orig_primarystreettype = '',Input_orig_primarypostdirabbrev = '',Input_orig_secondaryapttype = '',Input_orig_secondaryaptnbr = '',Input_orig_city = '',Input_orig_state = '',Input_orig_zip = '',Input_orig_zip4 = '',Input_orig_dpbc = '',Input_orig_crte = '',Input_orig_cnty = '',Input_orig_z4type = '',Input_orig_dpv = '',Input_orig_maildeliverabilitycode = '',Input_orig_addressvalidationdate = '',Input_orig_filler1 = '',Input_orig_directoryassistanceflag = '',Input_orig_telephoneconfidencescore = '',OutFile) := MACRO
  IMPORT SALT30,Scrubs_InfutorCID;
  #uniquename(of)
  %of% := RECORD
    SALT30.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_orig_phone)='' )
      '' 
    #ELSE
        IF( le.Input_orig_phone = (TYPEOF(le.Input_orig_phone))'','',':orig_phone')
    #END
+    #IF( #TEXT(Input_orig_phonetype)='' )
      '' 
    #ELSE
        IF( le.Input_orig_phonetype = (TYPEOF(le.Input_orig_phonetype))'','',':orig_phonetype')
    #END
+    #IF( #TEXT(Input_orig_directindial)='' )
      '' 
    #ELSE
        IF( le.Input_orig_directindial = (TYPEOF(le.Input_orig_directindial))'','',':orig_directindial')
    #END
+    #IF( #TEXT(Input_orig_recordtype)='' )
      '' 
    #ELSE
        IF( le.Input_orig_recordtype = (TYPEOF(le.Input_orig_recordtype))'','',':orig_recordtype')
    #END
+    #IF( #TEXT(Input_orig_firstdate)='' )
      '' 
    #ELSE
        IF( le.Input_orig_firstdate = (TYPEOF(le.Input_orig_firstdate))'','',':orig_firstdate')
    #END
+    #IF( #TEXT(Input_orig_lastdate)='' )
      '' 
    #ELSE
        IF( le.Input_orig_lastdate = (TYPEOF(le.Input_orig_lastdate))'','',':orig_lastdate')
    #END
+    #IF( #TEXT(Input_orig_telconame)='' )
      '' 
    #ELSE
        IF( le.Input_orig_telconame = (TYPEOF(le.Input_orig_telconame))'','',':orig_telconame')
    #END
+    #IF( #TEXT(Input_orig_businessname)='' )
      '' 
    #ELSE
        IF( le.Input_orig_businessname = (TYPEOF(le.Input_orig_businessname))'','',':orig_businessname')
    #END
+    #IF( #TEXT(Input_orig_firstname)='' )
      '' 
    #ELSE
        IF( le.Input_orig_firstname = (TYPEOF(le.Input_orig_firstname))'','',':orig_firstname')
    #END
+    #IF( #TEXT(Input_orig_mi)='' )
      '' 
    #ELSE
        IF( le.Input_orig_mi = (TYPEOF(le.Input_orig_mi))'','',':orig_mi')
    #END
+    #IF( #TEXT(Input_orig_lastname)='' )
      '' 
    #ELSE
        IF( le.Input_orig_lastname = (TYPEOF(le.Input_orig_lastname))'','',':orig_lastname')
    #END
+    #IF( #TEXT(Input_orig_primaryhousenumber)='' )
      '' 
    #ELSE
        IF( le.Input_orig_primaryhousenumber = (TYPEOF(le.Input_orig_primaryhousenumber))'','',':orig_primaryhousenumber')
    #END
+    #IF( #TEXT(Input_orig_primarypredirabbrev)='' )
      '' 
    #ELSE
        IF( le.Input_orig_primarypredirabbrev = (TYPEOF(le.Input_orig_primarypredirabbrev))'','',':orig_primarypredirabbrev')
    #END
+    #IF( #TEXT(Input_orig_primarystreetname)='' )
      '' 
    #ELSE
        IF( le.Input_orig_primarystreetname = (TYPEOF(le.Input_orig_primarystreetname))'','',':orig_primarystreetname')
    #END
+    #IF( #TEXT(Input_orig_primarystreettype)='' )
      '' 
    #ELSE
        IF( le.Input_orig_primarystreettype = (TYPEOF(le.Input_orig_primarystreettype))'','',':orig_primarystreettype')
    #END
+    #IF( #TEXT(Input_orig_primarypostdirabbrev)='' )
      '' 
    #ELSE
        IF( le.Input_orig_primarypostdirabbrev = (TYPEOF(le.Input_orig_primarypostdirabbrev))'','',':orig_primarypostdirabbrev')
    #END
+    #IF( #TEXT(Input_orig_secondaryapttype)='' )
      '' 
    #ELSE
        IF( le.Input_orig_secondaryapttype = (TYPEOF(le.Input_orig_secondaryapttype))'','',':orig_secondaryapttype')
    #END
+    #IF( #TEXT(Input_orig_secondaryaptnbr)='' )
      '' 
    #ELSE
        IF( le.Input_orig_secondaryaptnbr = (TYPEOF(le.Input_orig_secondaryaptnbr))'','',':orig_secondaryaptnbr')
    #END
+    #IF( #TEXT(Input_orig_city)='' )
      '' 
    #ELSE
        IF( le.Input_orig_city = (TYPEOF(le.Input_orig_city))'','',':orig_city')
    #END
+    #IF( #TEXT(Input_orig_state)='' )
      '' 
    #ELSE
        IF( le.Input_orig_state = (TYPEOF(le.Input_orig_state))'','',':orig_state')
    #END
+    #IF( #TEXT(Input_orig_zip)='' )
      '' 
    #ELSE
        IF( le.Input_orig_zip = (TYPEOF(le.Input_orig_zip))'','',':orig_zip')
    #END
+    #IF( #TEXT(Input_orig_zip4)='' )
      '' 
    #ELSE
        IF( le.Input_orig_zip4 = (TYPEOF(le.Input_orig_zip4))'','',':orig_zip4')
    #END
+    #IF( #TEXT(Input_orig_dpbc)='' )
      '' 
    #ELSE
        IF( le.Input_orig_dpbc = (TYPEOF(le.Input_orig_dpbc))'','',':orig_dpbc')
    #END
+    #IF( #TEXT(Input_orig_crte)='' )
      '' 
    #ELSE
        IF( le.Input_orig_crte = (TYPEOF(le.Input_orig_crte))'','',':orig_crte')
    #END
+    #IF( #TEXT(Input_orig_cnty)='' )
      '' 
    #ELSE
        IF( le.Input_orig_cnty = (TYPEOF(le.Input_orig_cnty))'','',':orig_cnty')
    #END
+    #IF( #TEXT(Input_orig_z4type)='' )
      '' 
    #ELSE
        IF( le.Input_orig_z4type = (TYPEOF(le.Input_orig_z4type))'','',':orig_z4type')
    #END
+    #IF( #TEXT(Input_orig_dpv)='' )
      '' 
    #ELSE
        IF( le.Input_orig_dpv = (TYPEOF(le.Input_orig_dpv))'','',':orig_dpv')
    #END
+    #IF( #TEXT(Input_orig_maildeliverabilitycode)='' )
      '' 
    #ELSE
        IF( le.Input_orig_maildeliverabilitycode = (TYPEOF(le.Input_orig_maildeliverabilitycode))'','',':orig_maildeliverabilitycode')
    #END
+    #IF( #TEXT(Input_orig_addressvalidationdate)='' )
      '' 
    #ELSE
        IF( le.Input_orig_addressvalidationdate = (TYPEOF(le.Input_orig_addressvalidationdate))'','',':orig_addressvalidationdate')
    #END
+    #IF( #TEXT(Input_orig_filler1)='' )
      '' 
    #ELSE
        IF( le.Input_orig_filler1 = (TYPEOF(le.Input_orig_filler1))'','',':orig_filler1')
    #END
+    #IF( #TEXT(Input_orig_directoryassistanceflag)='' )
      '' 
    #ELSE
        IF( le.Input_orig_directoryassistanceflag = (TYPEOF(le.Input_orig_directoryassistanceflag))'','',':orig_directoryassistanceflag')
    #END
+    #IF( #TEXT(Input_orig_telephoneconfidencescore)='' )
      '' 
    #ELSE
        IF( le.Input_orig_telephoneconfidencescore = (TYPEOF(le.Input_orig_telephoneconfidencescore))'','',':orig_telephoneconfidencescore')
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
