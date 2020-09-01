 
EXPORT Contacts_MAC_PopulationStatistics(infile,Ref='',Input_EFX_id = '',Input_EFX_CONTCT = '',Input_EFX_TITLECD = '',Input_EFX_TITLEDESC = '',Input_EFX_LASTNAM = '',Input_EFX_FSTNAM = '',Input_EFX_EMAIL = '',Input_EFX_DATE = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_Equifax_Business_Data;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_EFX_id)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_id = (TYPEOF(le.Input_EFX_id))'','',':EFX_id')
    #END
 
+    #IF( #TEXT(Input_EFX_CONTCT)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_CONTCT = (TYPEOF(le.Input_EFX_CONTCT))'','',':EFX_CONTCT')
    #END
 
+    #IF( #TEXT(Input_EFX_TITLECD)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_TITLECD = (TYPEOF(le.Input_EFX_TITLECD))'','',':EFX_TITLECD')
    #END
 
+    #IF( #TEXT(Input_EFX_TITLEDESC)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_TITLEDESC = (TYPEOF(le.Input_EFX_TITLEDESC))'','',':EFX_TITLEDESC')
    #END
 
+    #IF( #TEXT(Input_EFX_LASTNAM)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_LASTNAM = (TYPEOF(le.Input_EFX_LASTNAM))'','',':EFX_LASTNAM')
    #END
 
+    #IF( #TEXT(Input_EFX_FSTNAM)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_FSTNAM = (TYPEOF(le.Input_EFX_FSTNAM))'','',':EFX_FSTNAM')
    #END
 
+    #IF( #TEXT(Input_EFX_EMAIL)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_EMAIL = (TYPEOF(le.Input_EFX_EMAIL))'','',':EFX_EMAIL')
    #END
 
+    #IF( #TEXT(Input_EFX_DATE)='' )
      '' 
    #ELSE
        IF( le.Input_EFX_DATE = (TYPEOF(le.Input_EFX_DATE))'','',':EFX_DATE')
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
