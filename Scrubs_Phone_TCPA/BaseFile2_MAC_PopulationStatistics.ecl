 
EXPORT BaseFile2_MAC_PopulationStatistics(infile,Ref='',Input_num = '',Input_phone = '',Input_end_range = '',Input_expand_end_range = '',Input_expand_range_max_count = '',Input_expand_phone = '',Input_is_current = '',Input_dt_first_seen = '',Input_dt_last_seen = '',Input_phone_type = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_Phone_TCPA;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_num)='' )
      '' 
    #ELSE
        IF( le.Input_num = (TYPEOF(le.Input_num))'','',':num')
    #END
 
+    #IF( #TEXT(Input_phone)='' )
      '' 
    #ELSE
        IF( le.Input_phone = (TYPEOF(le.Input_phone))'','',':phone')
    #END
 
+    #IF( #TEXT(Input_end_range)='' )
      '' 
    #ELSE
        IF( le.Input_end_range = (TYPEOF(le.Input_end_range))'','',':end_range')
    #END
 
+    #IF( #TEXT(Input_expand_end_range)='' )
      '' 
    #ELSE
        IF( le.Input_expand_end_range = (TYPEOF(le.Input_expand_end_range))'','',':expand_end_range')
    #END
 
+    #IF( #TEXT(Input_expand_range_max_count)='' )
      '' 
    #ELSE
        IF( le.Input_expand_range_max_count = (TYPEOF(le.Input_expand_range_max_count))'','',':expand_range_max_count')
    #END
 
+    #IF( #TEXT(Input_expand_phone)='' )
      '' 
    #ELSE
        IF( le.Input_expand_phone = (TYPEOF(le.Input_expand_phone))'','',':expand_phone')
    #END
 
+    #IF( #TEXT(Input_is_current)='' )
      '' 
    #ELSE
        IF( le.Input_is_current = (TYPEOF(le.Input_is_current))'','',':is_current')
    #END
 
+    #IF( #TEXT(Input_dt_first_seen)='' )
      '' 
    #ELSE
        IF( le.Input_dt_first_seen = (TYPEOF(le.Input_dt_first_seen))'','',':dt_first_seen')
    #END
 
+    #IF( #TEXT(Input_dt_last_seen)='' )
      '' 
    #ELSE
        IF( le.Input_dt_last_seen = (TYPEOF(le.Input_dt_last_seen))'','',':dt_last_seen')
    #END
 
+    #IF( #TEXT(Input_phone_type)='' )
      '' 
    #ELSE
        IF( le.Input_phone_type = (TYPEOF(le.Input_phone_type))'','',':phone_type')
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
