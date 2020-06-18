 
EXPORT InfutorWP_MAC_PopulationStatistics(infile,Ref='',Input_can_phone = '',Input_can_title = '',Input_can_fname = '',Input_can_lname = '',Input_can_suffix = '',Input_can_address1 = '',Input_can_house = '',Input_can_predir = '',Input_can_street = '',Input_can_strtype = '',Input_can_postdir = '',Input_can_apttype = '',Input_can_aptnbr = '',Input_can_city = '',Input_can_province = '',Input_can_postalcd = '',Input_can_lang = '',Input_can_rectype = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_CanadianPhones;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_can_phone)='' )
      '' 
    #ELSE
        IF( le.Input_can_phone = (TYPEOF(le.Input_can_phone))'','',':can_phone')
    #END
 
+    #IF( #TEXT(Input_can_title)='' )
      '' 
    #ELSE
        IF( le.Input_can_title = (TYPEOF(le.Input_can_title))'','',':can_title')
    #END
 
+    #IF( #TEXT(Input_can_fname)='' )
      '' 
    #ELSE
        IF( le.Input_can_fname = (TYPEOF(le.Input_can_fname))'','',':can_fname')
    #END
 
+    #IF( #TEXT(Input_can_lname)='' )
      '' 
    #ELSE
        IF( le.Input_can_lname = (TYPEOF(le.Input_can_lname))'','',':can_lname')
    #END
 
+    #IF( #TEXT(Input_can_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_can_suffix = (TYPEOF(le.Input_can_suffix))'','',':can_suffix')
    #END
 
+    #IF( #TEXT(Input_can_address1)='' )
      '' 
    #ELSE
        IF( le.Input_can_address1 = (TYPEOF(le.Input_can_address1))'','',':can_address1')
    #END
 
+    #IF( #TEXT(Input_can_house)='' )
      '' 
    #ELSE
        IF( le.Input_can_house = (TYPEOF(le.Input_can_house))'','',':can_house')
    #END
 
+    #IF( #TEXT(Input_can_predir)='' )
      '' 
    #ELSE
        IF( le.Input_can_predir = (TYPEOF(le.Input_can_predir))'','',':can_predir')
    #END
 
+    #IF( #TEXT(Input_can_street)='' )
      '' 
    #ELSE
        IF( le.Input_can_street = (TYPEOF(le.Input_can_street))'','',':can_street')
    #END
 
+    #IF( #TEXT(Input_can_strtype)='' )
      '' 
    #ELSE
        IF( le.Input_can_strtype = (TYPEOF(le.Input_can_strtype))'','',':can_strtype')
    #END
 
+    #IF( #TEXT(Input_can_postdir)='' )
      '' 
    #ELSE
        IF( le.Input_can_postdir = (TYPEOF(le.Input_can_postdir))'','',':can_postdir')
    #END
 
+    #IF( #TEXT(Input_can_apttype)='' )
      '' 
    #ELSE
        IF( le.Input_can_apttype = (TYPEOF(le.Input_can_apttype))'','',':can_apttype')
    #END
 
+    #IF( #TEXT(Input_can_aptnbr)='' )
      '' 
    #ELSE
        IF( le.Input_can_aptnbr = (TYPEOF(le.Input_can_aptnbr))'','',':can_aptnbr')
    #END
 
+    #IF( #TEXT(Input_can_city)='' )
      '' 
    #ELSE
        IF( le.Input_can_city = (TYPEOF(le.Input_can_city))'','',':can_city')
    #END
 
+    #IF( #TEXT(Input_can_province)='' )
      '' 
    #ELSE
        IF( le.Input_can_province = (TYPEOF(le.Input_can_province))'','',':can_province')
    #END
 
+    #IF( #TEXT(Input_can_postalcd)='' )
      '' 
    #ELSE
        IF( le.Input_can_postalcd = (TYPEOF(le.Input_can_postalcd))'','',':can_postalcd')
    #END
 
+    #IF( #TEXT(Input_can_lang)='' )
      '' 
    #ELSE
        IF( le.Input_can_lang = (TYPEOF(le.Input_can_lang))'','',':can_lang')
    #END
 
+    #IF( #TEXT(Input_can_rectype)='' )
      '' 
    #ELSE
        IF( le.Input_can_rectype = (TYPEOF(le.Input_can_rectype))'','',':can_rectype')
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
