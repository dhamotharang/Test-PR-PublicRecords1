 
EXPORT alias_counties_MAC_PopulationStatistics(infile,Ref='',vendor='',Input_recordid = '',Input_statecode = '',Input_akaname = '',Input_akalastname = '',Input_akafirstname = '',Input_akamiddlename = '',Input_akasuffix = '',Input_akadob = '',Input_sourcename = '',Input_vendor = '',OutFile) := MACRO
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
 
+    #IF( #TEXT(Input_akaname)='' )
      '' 
    #ELSE
        IF( le.Input_akaname = (TYPEOF(le.Input_akaname))'','',':akaname')
    #END
 
+    #IF( #TEXT(Input_akalastname)='' )
      '' 
    #ELSE
        IF( le.Input_akalastname = (TYPEOF(le.Input_akalastname))'','',':akalastname')
    #END
 
+    #IF( #TEXT(Input_akafirstname)='' )
      '' 
    #ELSE
        IF( le.Input_akafirstname = (TYPEOF(le.Input_akafirstname))'','',':akafirstname')
    #END
 
+    #IF( #TEXT(Input_akamiddlename)='' )
      '' 
    #ELSE
        IF( le.Input_akamiddlename = (TYPEOF(le.Input_akamiddlename))'','',':akamiddlename')
    #END
 
+    #IF( #TEXT(Input_akasuffix)='' )
      '' 
    #ELSE
        IF( le.Input_akasuffix = (TYPEOF(le.Input_akasuffix))'','',':akasuffix')
    #END
 
+    #IF( #TEXT(Input_akadob)='' )
      '' 
    #ELSE
        IF( le.Input_akadob = (TYPEOF(le.Input_akadob))'','',':akadob')
    #END
 
+    #IF( #TEXT(Input_sourcename)='' )
      '' 
    #ELSE
        IF( le.Input_sourcename = (TYPEOF(le.Input_sourcename))'','',':sourcename')
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
