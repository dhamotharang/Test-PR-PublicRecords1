 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_corp_key = '',Input_stock_class = '',OutFile) := MACRO
  IMPORT SALT34,Scrubs_Corp2_Mapping_MS_Stock;
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
 
+    #IF( #TEXT(Input_stock_class)='' )
      '' 
    #ELSE
        IF( le.Input_stock_class = (TYPEOF(le.Input_stock_class))'','',':stock_class')
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
