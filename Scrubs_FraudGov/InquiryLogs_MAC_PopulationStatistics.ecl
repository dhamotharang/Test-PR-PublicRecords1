 
EXPORT InquiryLogs_MAC_PopulationStatistics(infile,Ref='',Input_Customer_Account_Number = '',Input_Customer_County = '',Input_Customer_State = '',Input_Customer_Agency_Vertical_Type = '',Input_Customer_Program = '',Input_LexID = '',Input_raw_Full_Name = '',Input_raw_First_name = '',Input_raw_Last_Name = '',Input_SSN = '',Input_Drivers_License_State = '',Input_Drivers_License_Number = '',Input_Street_1 = '',Input_City = '',Input_State = '',Input_Zip = '',Input_did = '',OutFile) := MACRO
  IMPORT SALT39,Scrubs_FraudGov;
  #uniquename(of)
  %of% := RECORD
    SALT39.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_Customer_Account_Number)='' )
      '' 
    #ELSE
        IF( le.Input_Customer_Account_Number = (TYPEOF(le.Input_Customer_Account_Number))'','',':Customer_Account_Number')
    #END
 
+    #IF( #TEXT(Input_Customer_County)='' )
      '' 
    #ELSE
        IF( le.Input_Customer_County = (TYPEOF(le.Input_Customer_County))'','',':Customer_County')
    #END
 
+    #IF( #TEXT(Input_Customer_State)='' )
      '' 
    #ELSE
        IF( le.Input_Customer_State = (TYPEOF(le.Input_Customer_State))'','',':Customer_State')
    #END
 
+    #IF( #TEXT(Input_Customer_Agency_Vertical_Type)='' )
      '' 
    #ELSE
        IF( le.Input_Customer_Agency_Vertical_Type = (TYPEOF(le.Input_Customer_Agency_Vertical_Type))'','',':Customer_Agency_Vertical_Type')
    #END
 
+    #IF( #TEXT(Input_Customer_Program)='' )
      '' 
    #ELSE
        IF( le.Input_Customer_Program = (TYPEOF(le.Input_Customer_Program))'','',':Customer_Program')
    #END
 
+    #IF( #TEXT(Input_LexID)='' )
      '' 
    #ELSE
        IF( le.Input_LexID = (TYPEOF(le.Input_LexID))'','',':LexID')
    #END
 
+    #IF( #TEXT(Input_raw_Full_Name)='' )
      '' 
    #ELSE
        IF( le.Input_raw_Full_Name = (TYPEOF(le.Input_raw_Full_Name))'','',':raw_Full_Name')
    #END
 
+    #IF( #TEXT(Input_raw_First_name)='' )
      '' 
    #ELSE
        IF( le.Input_raw_First_name = (TYPEOF(le.Input_raw_First_name))'','',':raw_First_name')
    #END
 
+    #IF( #TEXT(Input_raw_Last_Name)='' )
      '' 
    #ELSE
        IF( le.Input_raw_Last_Name = (TYPEOF(le.Input_raw_Last_Name))'','',':raw_Last_Name')
    #END
 
+    #IF( #TEXT(Input_SSN)='' )
      '' 
    #ELSE
        IF( le.Input_SSN = (TYPEOF(le.Input_SSN))'','',':SSN')
    #END
 
+    #IF( #TEXT(Input_Drivers_License_State)='' )
      '' 
    #ELSE
        IF( le.Input_Drivers_License_State = (TYPEOF(le.Input_Drivers_License_State))'','',':Drivers_License_State')
    #END
 
+    #IF( #TEXT(Input_Drivers_License_Number)='' )
      '' 
    #ELSE
        IF( le.Input_Drivers_License_Number = (TYPEOF(le.Input_Drivers_License_Number))'','',':Drivers_License_Number')
    #END
 
+    #IF( #TEXT(Input_Street_1)='' )
      '' 
    #ELSE
        IF( le.Input_Street_1 = (TYPEOF(le.Input_Street_1))'','',':Street_1')
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
 
+    #IF( #TEXT(Input_Zip)='' )
      '' 
    #ELSE
        IF( le.Input_Zip = (TYPEOF(le.Input_Zip))'','',':Zip')
    #END
 
+    #IF( #TEXT(Input_did)='' )
      '' 
    #ELSE
        IF( le.Input_did = (TYPEOF(le.Input_did))'','',':did')
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
