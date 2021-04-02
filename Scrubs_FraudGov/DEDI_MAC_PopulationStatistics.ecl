EXPORT DEDI_MAC_PopulationStatistics(infile,Ref='',Input_domain = '',Input_dispsblemail = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_FraudGov;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_domain)='' )
      '' 
    #ELSE
        IF( le.Input_domain = (TYPEOF(le.Input_domain))'','',':domain')
    #END
+    #IF( #TEXT(Input_dispsblemail)='' )
      '' 
    #ELSE
        IF( le.Input_dispsblemail = (TYPEOF(le.Input_dispsblemail))'','',':dispsblemail')
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
