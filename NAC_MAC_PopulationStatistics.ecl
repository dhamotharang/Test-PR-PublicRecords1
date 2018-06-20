 
EXPORT NAC_MAC_PopulationStatistics(infile,Ref='',Input_SearchAddress1StreetAddress1 = '',Input_SearchAddress1StreetAddress2 = '',Input_SearchAddress1City = '',Input_SearchAddress1State = '',Input_SearchAddress1Zip = '',Input_SearchAddress2StreetAddress1 = '',Input_SearchAddress2StreetAddress2 = '',Input_SearchAddress2City = '',Input_SearchAddress2State = '',Input_SearchAddress2Zip = '',Input_SearchCaseId = '',Input_enduserip = '',Input_CaseID = '',Input_ClientFirstName = '',Input_ClientMiddleName = '',Input_ClientLastName = '',Input_ClientPhone = '',Input_ClientEmail = '',OutFile) := MACRO
  IMPORT SALT39,Scrubs_FraudGov;
  #uniquename(of)
  %of% := RECORD
    SALT39.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_SearchAddress1StreetAddress1)='' )
      '' 
    #ELSE
        IF( le.Input_SearchAddress1StreetAddress1 = (TYPEOF(le.Input_SearchAddress1StreetAddress1))'','',':SearchAddress1StreetAddress1')
    #END
 
+    #IF( #TEXT(Input_SearchAddress1StreetAddress2)='' )
      '' 
    #ELSE
        IF( le.Input_SearchAddress1StreetAddress2 = (TYPEOF(le.Input_SearchAddress1StreetAddress2))'','',':SearchAddress1StreetAddress2')
    #END
 
+    #IF( #TEXT(Input_SearchAddress1City)='' )
      '' 
    #ELSE
        IF( le.Input_SearchAddress1City = (TYPEOF(le.Input_SearchAddress1City))'','',':SearchAddress1City')
    #END
 
+    #IF( #TEXT(Input_SearchAddress1State)='' )
      '' 
    #ELSE
        IF( le.Input_SearchAddress1State = (TYPEOF(le.Input_SearchAddress1State))'','',':SearchAddress1State')
    #END
 
+    #IF( #TEXT(Input_SearchAddress1Zip)='' )
      '' 
    #ELSE
        IF( le.Input_SearchAddress1Zip = (TYPEOF(le.Input_SearchAddress1Zip))'','',':SearchAddress1Zip')
    #END
 
+    #IF( #TEXT(Input_SearchAddress2StreetAddress1)='' )
      '' 
    #ELSE
        IF( le.Input_SearchAddress2StreetAddress1 = (TYPEOF(le.Input_SearchAddress2StreetAddress1))'','',':SearchAddress2StreetAddress1')
    #END
 
+    #IF( #TEXT(Input_SearchAddress2StreetAddress2)='' )
      '' 
    #ELSE
        IF( le.Input_SearchAddress2StreetAddress2 = (TYPEOF(le.Input_SearchAddress2StreetAddress2))'','',':SearchAddress2StreetAddress2')
    #END
 
+    #IF( #TEXT(Input_SearchAddress2City)='' )
      '' 
    #ELSE
        IF( le.Input_SearchAddress2City = (TYPEOF(le.Input_SearchAddress2City))'','',':SearchAddress2City')
    #END
 
+    #IF( #TEXT(Input_SearchAddress2State)='' )
      '' 
    #ELSE
        IF( le.Input_SearchAddress2State = (TYPEOF(le.Input_SearchAddress2State))'','',':SearchAddress2State')
    #END
 
+    #IF( #TEXT(Input_SearchAddress2Zip)='' )
      '' 
    #ELSE
        IF( le.Input_SearchAddress2Zip = (TYPEOF(le.Input_SearchAddress2Zip))'','',':SearchAddress2Zip')
    #END
 
+    #IF( #TEXT(Input_SearchCaseId)='' )
      '' 
    #ELSE
        IF( le.Input_SearchCaseId = (TYPEOF(le.Input_SearchCaseId))'','',':SearchCaseId')
    #END
 
+    #IF( #TEXT(Input_enduserip)='' )
      '' 
    #ELSE
        IF( le.Input_enduserip = (TYPEOF(le.Input_enduserip))'','',':enduserip')
    #END
 
+    #IF( #TEXT(Input_CaseID)='' )
      '' 
    #ELSE
        IF( le.Input_CaseID = (TYPEOF(le.Input_CaseID))'','',':CaseID')
    #END
 
+    #IF( #TEXT(Input_ClientFirstName)='' )
      '' 
    #ELSE
        IF( le.Input_ClientFirstName = (TYPEOF(le.Input_ClientFirstName))'','',':ClientFirstName')
    #END
 
+    #IF( #TEXT(Input_ClientMiddleName)='' )
      '' 
    #ELSE
        IF( le.Input_ClientMiddleName = (TYPEOF(le.Input_ClientMiddleName))'','',':ClientMiddleName')
    #END
 
+    #IF( #TEXT(Input_ClientLastName)='' )
      '' 
    #ELSE
        IF( le.Input_ClientLastName = (TYPEOF(le.Input_ClientLastName))'','',':ClientLastName')
    #END
 
+    #IF( #TEXT(Input_ClientPhone)='' )
      '' 
    #ELSE
        IF( le.Input_ClientPhone = (TYPEOF(le.Input_ClientPhone))'','',':ClientPhone')
    #END
 
+    #IF( #TEXT(Input_ClientEmail)='' )
      '' 
    #ELSE
        IF( le.Input_ClientEmail = (TYPEOF(le.Input_ClientEmail))'','',':ClientEmail')
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
