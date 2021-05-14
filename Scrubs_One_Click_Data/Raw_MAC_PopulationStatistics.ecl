 
EXPORT Raw_MAC_PopulationStatistics(infile,Ref='',Input_ssn = '',Input_firstname = '',Input_lastname = '',Input_dob = '',Input_homeaddress = '',Input_homecity = '',Input_homestate = '',Input_homezip = '',Input_homephone = '',Input_mobilephone = '',Input_emailaddress = '',Input_workname = '',Input_workaddress = '',Input_workcity = '',Input_workstate = '',Input_workzip = '',Input_workphone = '',Input_ref1firstname = '',Input_ref1lastname = '',Input_ref1phone = '',Input_lastinquirydate = '',Input_ip = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_One_Click_Data;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_ssn)='' )
      '' 
    #ELSE
        IF( le.Input_ssn = (TYPEOF(le.Input_ssn))'','',':ssn')
    #END
 
+    #IF( #TEXT(Input_firstname)='' )
      '' 
    #ELSE
        IF( le.Input_firstname = (TYPEOF(le.Input_firstname))'','',':firstname')
    #END
 
+    #IF( #TEXT(Input_lastname)='' )
      '' 
    #ELSE
        IF( le.Input_lastname = (TYPEOF(le.Input_lastname))'','',':lastname')
    #END
 
+    #IF( #TEXT(Input_dob)='' )
      '' 
    #ELSE
        IF( le.Input_dob = (TYPEOF(le.Input_dob))'','',':dob')
    #END
 
+    #IF( #TEXT(Input_homeaddress)='' )
      '' 
    #ELSE
        IF( le.Input_homeaddress = (TYPEOF(le.Input_homeaddress))'','',':homeaddress')
    #END
 
+    #IF( #TEXT(Input_homecity)='' )
      '' 
    #ELSE
        IF( le.Input_homecity = (TYPEOF(le.Input_homecity))'','',':homecity')
    #END
 
+    #IF( #TEXT(Input_homestate)='' )
      '' 
    #ELSE
        IF( le.Input_homestate = (TYPEOF(le.Input_homestate))'','',':homestate')
    #END
 
+    #IF( #TEXT(Input_homezip)='' )
      '' 
    #ELSE
        IF( le.Input_homezip = (TYPEOF(le.Input_homezip))'','',':homezip')
    #END
 
+    #IF( #TEXT(Input_homephone)='' )
      '' 
    #ELSE
        IF( le.Input_homephone = (TYPEOF(le.Input_homephone))'','',':homephone')
    #END
 
+    #IF( #TEXT(Input_mobilephone)='' )
      '' 
    #ELSE
        IF( le.Input_mobilephone = (TYPEOF(le.Input_mobilephone))'','',':mobilephone')
    #END
 
+    #IF( #TEXT(Input_emailaddress)='' )
      '' 
    #ELSE
        IF( le.Input_emailaddress = (TYPEOF(le.Input_emailaddress))'','',':emailaddress')
    #END
 
+    #IF( #TEXT(Input_workname)='' )
      '' 
    #ELSE
        IF( le.Input_workname = (TYPEOF(le.Input_workname))'','',':workname')
    #END
 
+    #IF( #TEXT(Input_workaddress)='' )
      '' 
    #ELSE
        IF( le.Input_workaddress = (TYPEOF(le.Input_workaddress))'','',':workaddress')
    #END
 
+    #IF( #TEXT(Input_workcity)='' )
      '' 
    #ELSE
        IF( le.Input_workcity = (TYPEOF(le.Input_workcity))'','',':workcity')
    #END
 
+    #IF( #TEXT(Input_workstate)='' )
      '' 
    #ELSE
        IF( le.Input_workstate = (TYPEOF(le.Input_workstate))'','',':workstate')
    #END
 
+    #IF( #TEXT(Input_workzip)='' )
      '' 
    #ELSE
        IF( le.Input_workzip = (TYPEOF(le.Input_workzip))'','',':workzip')
    #END
 
+    #IF( #TEXT(Input_workphone)='' )
      '' 
    #ELSE
        IF( le.Input_workphone = (TYPEOF(le.Input_workphone))'','',':workphone')
    #END
 
+    #IF( #TEXT(Input_ref1firstname)='' )
      '' 
    #ELSE
        IF( le.Input_ref1firstname = (TYPEOF(le.Input_ref1firstname))'','',':ref1firstname')
    #END
 
+    #IF( #TEXT(Input_ref1lastname)='' )
      '' 
    #ELSE
        IF( le.Input_ref1lastname = (TYPEOF(le.Input_ref1lastname))'','',':ref1lastname')
    #END
 
+    #IF( #TEXT(Input_ref1phone)='' )
      '' 
    #ELSE
        IF( le.Input_ref1phone = (TYPEOF(le.Input_ref1phone))'','',':ref1phone')
    #END
 
+    #IF( #TEXT(Input_lastinquirydate)='' )
      '' 
    #ELSE
        IF( le.Input_lastinquirydate = (TYPEOF(le.Input_lastinquirydate))'','',':lastinquirydate')
    #END
 
+    #IF( #TEXT(Input_ip)='' )
      '' 
    #ELSE
        IF( le.Input_ip = (TYPEOF(le.Input_ip))'','',':ip')
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
