 
EXPORT Base_History_MAC_PopulationStatistics(infile,Ref='',Input_vtid = '',Input_voted_year = '',Input_primary = '',Input_special_1 = '',Input_other = '',Input_special_2 = '',Input_general = '',Input_pres = '',Input_vote_date = '',OutFile) := MACRO
  IMPORT SALT39,Scrubs_Voters;
  #uniquename(of)
  %of% := RECORD
    SALT39.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_vtid)='' )
      '' 
    #ELSE
        IF( le.Input_vtid = (TYPEOF(le.Input_vtid))'','',':vtid')
    #END
 
+    #IF( #TEXT(Input_voted_year)='' )
      '' 
    #ELSE
        IF( le.Input_voted_year = (TYPEOF(le.Input_voted_year))'','',':voted_year')
    #END
 
+    #IF( #TEXT(Input_primary)='' )
      '' 
    #ELSE
        IF( le.Input_primary = (TYPEOF(le.Input_primary))'','',':primary')
    #END
 
+    #IF( #TEXT(Input_special_1)='' )
      '' 
    #ELSE
        IF( le.Input_special_1 = (TYPEOF(le.Input_special_1))'','',':special_1')
    #END
 
+    #IF( #TEXT(Input_other)='' )
      '' 
    #ELSE
        IF( le.Input_other = (TYPEOF(le.Input_other))'','',':other')
    #END
 
+    #IF( #TEXT(Input_special_2)='' )
      '' 
    #ELSE
        IF( le.Input_special_2 = (TYPEOF(le.Input_special_2))'','',':special_2')
    #END
 
+    #IF( #TEXT(Input_general)='' )
      '' 
    #ELSE
        IF( le.Input_general = (TYPEOF(le.Input_general))'','',':general')
    #END
 
+    #IF( #TEXT(Input_pres)='' )
      '' 
    #ELSE
        IF( le.Input_pres = (TYPEOF(le.Input_pres))'','',':pres')
    #END
 
+    #IF( #TEXT(Input_vote_date)='' )
      '' 
    #ELSE
        IF( le.Input_vote_date = (TYPEOF(le.Input_vote_date))'','',':vote_date')
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
