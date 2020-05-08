 
EXPORT CC_MAC_PopulationStatistics(infile,Ref='',Input_idnum = '',Input_businessname = '',Input_dba = '',Input_orgid = '',Input_address1 = '',Input_address2 = '',Input_city = '',Input_state = '',Input_zip = '',Input_zip4 = '',Input_phone = '',Input_fax = '',Input_email = '',Input_url = '',Input_status = '',Input_licensedatefrom = '',Input_licensedateto = '',Input_orgtype = '',Input_source = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_Debt_Settlement;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_idnum)='' )
      '' 
    #ELSE
        IF( le.Input_idnum = (TYPEOF(le.Input_idnum))'','',':idnum')
    #END
 
+    #IF( #TEXT(Input_businessname)='' )
      '' 
    #ELSE
        IF( le.Input_businessname = (TYPEOF(le.Input_businessname))'','',':businessname')
    #END
 
+    #IF( #TEXT(Input_dba)='' )
      '' 
    #ELSE
        IF( le.Input_dba = (TYPEOF(le.Input_dba))'','',':dba')
    #END
 
+    #IF( #TEXT(Input_orgid)='' )
      '' 
    #ELSE
        IF( le.Input_orgid = (TYPEOF(le.Input_orgid))'','',':orgid')
    #END
 
+    #IF( #TEXT(Input_address1)='' )
      '' 
    #ELSE
        IF( le.Input_address1 = (TYPEOF(le.Input_address1))'','',':address1')
    #END
 
+    #IF( #TEXT(Input_address2)='' )
      '' 
    #ELSE
        IF( le.Input_address2 = (TYPEOF(le.Input_address2))'','',':address2')
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
 
+    #IF( #TEXT(Input_zip4)='' )
      '' 
    #ELSE
        IF( le.Input_zip4 = (TYPEOF(le.Input_zip4))'','',':zip4')
    #END
 
+    #IF( #TEXT(Input_phone)='' )
      '' 
    #ELSE
        IF( le.Input_phone = (TYPEOF(le.Input_phone))'','',':phone')
    #END
 
+    #IF( #TEXT(Input_fax)='' )
      '' 
    #ELSE
        IF( le.Input_fax = (TYPEOF(le.Input_fax))'','',':fax')
    #END
 
+    #IF( #TEXT(Input_email)='' )
      '' 
    #ELSE
        IF( le.Input_email = (TYPEOF(le.Input_email))'','',':email')
    #END
 
+    #IF( #TEXT(Input_url)='' )
      '' 
    #ELSE
        IF( le.Input_url = (TYPEOF(le.Input_url))'','',':url')
    #END
 
+    #IF( #TEXT(Input_status)='' )
      '' 
    #ELSE
        IF( le.Input_status = (TYPEOF(le.Input_status))'','',':status')
    #END
 
+    #IF( #TEXT(Input_licensedatefrom)='' )
      '' 
    #ELSE
        IF( le.Input_licensedatefrom = (TYPEOF(le.Input_licensedatefrom))'','',':licensedatefrom')
    #END
 
+    #IF( #TEXT(Input_licensedateto)='' )
      '' 
    #ELSE
        IF( le.Input_licensedateto = (TYPEOF(le.Input_licensedateto))'','',':licensedateto')
    #END
 
+    #IF( #TEXT(Input_orgtype)='' )
      '' 
    #ELSE
        IF( le.Input_orgtype = (TYPEOF(le.Input_orgtype))'','',':orgtype')
    #END
 
+    #IF( #TEXT(Input_source)='' )
      '' 
    #ELSE
        IF( le.Input_source = (TYPEOF(le.Input_source))'','',':source')
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
