 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_event_filing_cd = '',OutFile) := MACRO
  IMPORT SALT32,Scrubs_Corp2_Mapping_AL_Event;
  #uniquename(of)
  %of% := RECORD
    SALT32.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_event_filing_cd)='' )
      '' 
    #ELSE
        IF( le.Input_event_filing_cd = (TYPEOF(le.Input_event_filing_cd))'','',':event_filing_cd')
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
