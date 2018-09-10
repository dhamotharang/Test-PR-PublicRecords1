 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_phonenumber = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_DoNotCall;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_phonenumber)='' )
      '' 
    #ELSE
        IF( le.Input_phonenumber = (TYPEOF(le.Input_phonenumber))'','',':phonenumber')
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
