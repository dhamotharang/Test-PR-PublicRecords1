 
EXPORT addresshistory_counties_MAC_PopulationStatistics(infile,Ref='',vendor='',Input_recordid = '',Input_statecode = '',Input_street = '',Input_unit = '',Input_city = '',Input_orig_state = '',Input_orig_zip = '',Input_addresstype = '',Input_sourcename = '',Input_sourceid = '',Input_vendor = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_Crim;
  #uniquename(of)
  %of% := RECORD
    #IF (#TEXT(vendor)<>'')
    SALT311.StrType source;
    #END
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_recordid)='' )
      '' 
    #ELSE
        IF( le.Input_recordid = (TYPEOF(le.Input_recordid))'','',':recordid')
    #END
 
+    #IF( #TEXT(Input_statecode)='' )
      '' 
    #ELSE
        IF( le.Input_statecode = (TYPEOF(le.Input_statecode))'','',':statecode')
    #END
 
+    #IF( #TEXT(Input_street)='' )
      '' 
    #ELSE
        IF( le.Input_street = (TYPEOF(le.Input_street))'','',':street')
    #END
 
+    #IF( #TEXT(Input_unit)='' )
      '' 
    #ELSE
        IF( le.Input_unit = (TYPEOF(le.Input_unit))'','',':unit')
    #END
 
+    #IF( #TEXT(Input_city)='' )
      '' 
    #ELSE
        IF( le.Input_city = (TYPEOF(le.Input_city))'','',':city')
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
 
+    #IF( #TEXT(Input_addresstype)='' )
      '' 
    #ELSE
        IF( le.Input_addresstype = (TYPEOF(le.Input_addresstype))'','',':addresstype')
    #END
 
+    #IF( #TEXT(Input_sourcename)='' )
      '' 
    #ELSE
        IF( le.Input_sourcename = (TYPEOF(le.Input_sourcename))'','',':sourcename')
    #END
 
+    #IF( #TEXT(Input_sourceid)='' )
      '' 
    #ELSE
        IF( le.Input_sourceid = (TYPEOF(le.Input_sourceid))'','',':sourceid')
    #END
 
+    #IF( #TEXT(Input_vendor)='' )
      '' 
    #ELSE
        IF( le.Input_vendor = (TYPEOF(le.Input_vendor))'','',':vendor')
    #END
;
    #IF (#TEXT(vendor)<>'')
    SELF.source := le.vendor;
    #END
  END;
  #uniquename(op)
  %op% := PROJECT(infile,%ot%(LEFT));
  #uniquename(ort)
  %ort% := RECORD
    #IF (#TEXT(vendor)<>'')
    %op%.source;
    #END
    %op%.fields;
    UNSIGNED cnt := COUNT(GROUP);
  END;
  outfile := TOPN( TABLE( %op%, %ort%,#IF( #TEXT(vendor)<>'' ) source, #END fields, FEW ), 1000,#IF( #TEXT(vendor)<>'' ) source, #END -cnt );
ENDMACRO;
