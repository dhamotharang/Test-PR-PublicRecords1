 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_corp_key = '',Input_corp_sos_charter_nbr = '',Input_event_revocation_comment1 = '',OutFile) := MACRO
  IMPORT SALT32,Scrubs_Corp2_Mapping_FL_Event;
  #uniquename(of)
  %of% := RECORD
    SALT32.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_corp_key)='' )
      '' 
    #ELSE
        IF( le.Input_corp_key = (TYPEOF(le.Input_corp_key))'','',':corp_key')
    #END
 
+    #IF( #TEXT(Input_corp_sos_charter_nbr)='' )
      '' 
    #ELSE
        IF( le.Input_corp_sos_charter_nbr = (TYPEOF(le.Input_corp_sos_charter_nbr))'','',':corp_sos_charter_nbr')
    #END
 
+    #IF( #TEXT(Input_event_revocation_comment1)='' )
      '' 
    #ELSE
        IF( le.Input_event_revocation_comment1 = (TYPEOF(le.Input_event_revocation_comment1))'','',':event_revocation_comment1')
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
