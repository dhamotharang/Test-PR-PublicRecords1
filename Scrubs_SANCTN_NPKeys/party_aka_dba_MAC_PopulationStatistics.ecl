 
EXPORT party_aka_dba_MAC_PopulationStatistics(infile,Ref='',dbcode='',Input_batch = '',Input_dbcode = '',Input_incident_num = '',Input_party_num = '',Input_name_type = '',Input_first_name = '',Input_middle_name = '',Input_last_name = '',Input_aka_dba_text = '',Input_party_key = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_SANCTN_NPKeys;
  #uniquename(of)
  %of% := RECORD
    #IF (#TEXT(dbcode)<>'')
    SALT311.StrType source;
    #END
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_batch)='' )
      '' 
    #ELSE
        IF( le.Input_batch = (TYPEOF(le.Input_batch))'','',':batch')
    #END
 
+    #IF( #TEXT(Input_dbcode)='' )
      '' 
    #ELSE
        IF( le.Input_dbcode = (TYPEOF(le.Input_dbcode))'','',':dbcode')
    #END
 
+    #IF( #TEXT(Input_incident_num)='' )
      '' 
    #ELSE
        IF( le.Input_incident_num = (TYPEOF(le.Input_incident_num))'','',':incident_num')
    #END
 
+    #IF( #TEXT(Input_party_num)='' )
      '' 
    #ELSE
        IF( le.Input_party_num = (TYPEOF(le.Input_party_num))'','',':party_num')
    #END
 
+    #IF( #TEXT(Input_name_type)='' )
      '' 
    #ELSE
        IF( le.Input_name_type = (TYPEOF(le.Input_name_type))'','',':name_type')
    #END
 
+    #IF( #TEXT(Input_first_name)='' )
      '' 
    #ELSE
        IF( le.Input_first_name = (TYPEOF(le.Input_first_name))'','',':first_name')
    #END
 
+    #IF( #TEXT(Input_middle_name)='' )
      '' 
    #ELSE
        IF( le.Input_middle_name = (TYPEOF(le.Input_middle_name))'','',':middle_name')
    #END
 
+    #IF( #TEXT(Input_last_name)='' )
      '' 
    #ELSE
        IF( le.Input_last_name = (TYPEOF(le.Input_last_name))'','',':last_name')
    #END
 
+    #IF( #TEXT(Input_aka_dba_text)='' )
      '' 
    #ELSE
        IF( le.Input_aka_dba_text = (TYPEOF(le.Input_aka_dba_text))'','',':aka_dba_text')
    #END
 
+    #IF( #TEXT(Input_party_key)='' )
      '' 
    #ELSE
        IF( le.Input_party_key = (TYPEOF(le.Input_party_key))'','',':party_key')
    #END
;
    #IF (#TEXT(dbcode)<>'')
    SELF.source := le.dbcode;
    #END
  END;
  #uniquename(op)
  %op% := PROJECT(infile,%ot%(LEFT));
  #uniquename(ort)
  %ort% := RECORD
    #IF (#TEXT(dbcode)<>'')
    %op%.source;
    #END
    %op%.fields;
    UNSIGNED cnt := COUNT(GROUP);
  END;
  outfile := TOPN( TABLE( %op%, %ort%,#IF( #TEXT(dbcode)<>'' ) source, #END fields, FEW ), 1000,#IF( #TEXT(dbcode)<>'' ) source, #END -cnt );
ENDMACRO;
