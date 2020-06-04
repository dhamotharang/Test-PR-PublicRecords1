 
EXPORT RDP_MAC_PopulationStatistics(infile,Ref='',Input_Transaction_ID = '',Input_TransactionDate = '',Input_FirstName = '',Input_LastName = '',Input_MiddleName = '',Input_Suffix = '',Input_BirthDate = '',Input_SSN = '',Input_Lexid_Input = '',Input_Street1 = '',Input_Street2 = '',Input_Suite = '',Input_City = '',Input_State = '',Input_Zip5 = '',Input_Phone = '',Input_Lexid_Discovered = '',Input_RemoteIPAddress = '',Input_ConsumerIPAddress = '',Input_Email_Address = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_FraudGov;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_Transaction_ID)='' )
      '' 
    #ELSE
        IF( le.Input_Transaction_ID = (TYPEOF(le.Input_Transaction_ID))'','',':Transaction_ID')
    #END
 
+    #IF( #TEXT(Input_TransactionDate)='' )
      '' 
    #ELSE
        IF( le.Input_TransactionDate = (TYPEOF(le.Input_TransactionDate))'','',':TransactionDate')
    #END
 
+    #IF( #TEXT(Input_FirstName)='' )
      '' 
    #ELSE
        IF( le.Input_FirstName = (TYPEOF(le.Input_FirstName))'','',':FirstName')
    #END
 
+    #IF( #TEXT(Input_LastName)='' )
      '' 
    #ELSE
        IF( le.Input_LastName = (TYPEOF(le.Input_LastName))'','',':LastName')
    #END
 
+    #IF( #TEXT(Input_MiddleName)='' )
      '' 
    #ELSE
        IF( le.Input_MiddleName = (TYPEOF(le.Input_MiddleName))'','',':MiddleName')
    #END
 
+    #IF( #TEXT(Input_Suffix)='' )
      '' 
    #ELSE
        IF( le.Input_Suffix = (TYPEOF(le.Input_Suffix))'','',':Suffix')
    #END
 
+    #IF( #TEXT(Input_BirthDate)='' )
      '' 
    #ELSE
        IF( le.Input_BirthDate = (TYPEOF(le.Input_BirthDate))'','',':BirthDate')
    #END
 
+    #IF( #TEXT(Input_SSN)='' )
      '' 
    #ELSE
        IF( le.Input_SSN = (TYPEOF(le.Input_SSN))'','',':SSN')
    #END
 
+    #IF( #TEXT(Input_Lexid_Input)='' )
      '' 
    #ELSE
        IF( le.Input_Lexid_Input = (TYPEOF(le.Input_Lexid_Input))'','',':Lexid_Input')
    #END
 
+    #IF( #TEXT(Input_Street1)='' )
      '' 
    #ELSE
        IF( le.Input_Street1 = (TYPEOF(le.Input_Street1))'','',':Street1')
    #END
 
+    #IF( #TEXT(Input_Street2)='' )
      '' 
    #ELSE
        IF( le.Input_Street2 = (TYPEOF(le.Input_Street2))'','',':Street2')
    #END
 
+    #IF( #TEXT(Input_Suite)='' )
      '' 
    #ELSE
        IF( le.Input_Suite = (TYPEOF(le.Input_Suite))'','',':Suite')
    #END
 
+    #IF( #TEXT(Input_City)='' )
      '' 
    #ELSE
        IF( le.Input_City = (TYPEOF(le.Input_City))'','',':City')
    #END
 
+    #IF( #TEXT(Input_State)='' )
      '' 
    #ELSE
        IF( le.Input_State = (TYPEOF(le.Input_State))'','',':State')
    #END
 
+    #IF( #TEXT(Input_Zip5)='' )
      '' 
    #ELSE
        IF( le.Input_Zip5 = (TYPEOF(le.Input_Zip5))'','',':Zip5')
    #END
 
+    #IF( #TEXT(Input_Phone)='' )
      '' 
    #ELSE
        IF( le.Input_Phone = (TYPEOF(le.Input_Phone))'','',':Phone')
    #END
 
+    #IF( #TEXT(Input_Lexid_Discovered)='' )
      '' 
    #ELSE
        IF( le.Input_Lexid_Discovered = (TYPEOF(le.Input_Lexid_Discovered))'','',':Lexid_Discovered')
    #END
 
+    #IF( #TEXT(Input_RemoteIPAddress)='' )
      '' 
    #ELSE
        IF( le.Input_RemoteIPAddress = (TYPEOF(le.Input_RemoteIPAddress))'','',':RemoteIPAddress')
    #END
 
+    #IF( #TEXT(Input_ConsumerIPAddress)='' )
      '' 
    #ELSE
        IF( le.Input_ConsumerIPAddress = (TYPEOF(le.Input_ConsumerIPAddress))'','',':ConsumerIPAddress')
    #END
 
+    #IF( #TEXT(Input_Email_Address)='' )
      '' 
    #ELSE
        IF( le.Input_Email_Address = (TYPEOF(le.Input_Email_Address))'','',':Email_Address')
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
