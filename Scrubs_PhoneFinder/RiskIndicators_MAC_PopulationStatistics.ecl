 
EXPORT RiskIndicators_MAC_PopulationStatistics(infile,Ref='',Input_transaction_id = '',Input_phone_id = '',Input_sequence_number = '',Input_date_added = '',Input_risk_indicator_id = '',Input_risk_indicator_level = '',Input_risk_indicator_text = '',Input_risk_indicator_category = '',Input_filename = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_PhoneFinder;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_transaction_id)='' )
      '' 
    #ELSE
        IF( le.Input_transaction_id = (TYPEOF(le.Input_transaction_id))'','',':transaction_id')
    #END
 
+    #IF( #TEXT(Input_phone_id)='' )
      '' 
    #ELSE
        IF( le.Input_phone_id = (TYPEOF(le.Input_phone_id))'','',':phone_id')
    #END
 
+    #IF( #TEXT(Input_sequence_number)='' )
      '' 
    #ELSE
        IF( le.Input_sequence_number = (TYPEOF(le.Input_sequence_number))'','',':sequence_number')
    #END
 
+    #IF( #TEXT(Input_date_added)='' )
      '' 
    #ELSE
        IF( le.Input_date_added = (TYPEOF(le.Input_date_added))'','',':date_added')
    #END
 
+    #IF( #TEXT(Input_risk_indicator_id)='' )
      '' 
    #ELSE
        IF( le.Input_risk_indicator_id = (TYPEOF(le.Input_risk_indicator_id))'','',':risk_indicator_id')
    #END
 
+    #IF( #TEXT(Input_risk_indicator_level)='' )
      '' 
    #ELSE
        IF( le.Input_risk_indicator_level = (TYPEOF(le.Input_risk_indicator_level))'','',':risk_indicator_level')
    #END
 
+    #IF( #TEXT(Input_risk_indicator_text)='' )
      '' 
    #ELSE
        IF( le.Input_risk_indicator_text = (TYPEOF(le.Input_risk_indicator_text))'','',':risk_indicator_text')
    #END
 
+    #IF( #TEXT(Input_risk_indicator_category)='' )
      '' 
    #ELSE
        IF( le.Input_risk_indicator_category = (TYPEOF(le.Input_risk_indicator_category))'','',':risk_indicator_category')
    #END
 
+    #IF( #TEXT(Input_filename)='' )
      '' 
    #ELSE
        IF( le.Input_filename = (TYPEOF(le.Input_filename))'','',':filename')
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
