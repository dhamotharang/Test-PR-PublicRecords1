 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_corp_key = '',Input_event_filing_desc = '',OutFile) := MACRO
  IMPORT SALT34,Scrubs_Corp2_Mapping_MS_Event;
  #uniquename(of)
  %of% := RECORD
    SALT34.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_corp_key)='' )
      '' 
    #ELSE
        IF( le.Input_corp_key = (TYPEOF(le.Input_corp_key))'','',':corp_key')
    #END
 
+    #IF( #TEXT(Input_event_filing_desc)='' )
      '' 
    #ELSE
        IF( le.Input_event_filing_desc = (TYPEOF(le.Input_event_filing_desc))'','',':event_filing_desc')
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
