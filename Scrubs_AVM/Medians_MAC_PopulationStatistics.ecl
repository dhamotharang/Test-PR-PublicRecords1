 
EXPORT Medians_MAC_PopulationStatistics(infile,Ref='',Input_history_date = '',Input_fips_geo_12 = '',Input_median_valuation = '',Input_history_history_date = '',Input_history_median_valuation = '',OutFile) := MACRO
  IMPORT SALT38,Scrubs_AVM;
  #uniquename(of)
  %of% := RECORD
    SALT38.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_history_date)='' )
      '' 
    #ELSE
        IF( le.Input_history_date = (TYPEOF(le.Input_history_date))'','',':history_date')
    #END
 
+    #IF( #TEXT(Input_fips_geo_12)='' )
      '' 
    #ELSE
        IF( le.Input_fips_geo_12 = (TYPEOF(le.Input_fips_geo_12))'','',':fips_geo_12')
    #END
 
+    #IF( #TEXT(Input_median_valuation)='' )
      '' 
    #ELSE
        IF( le.Input_median_valuation = (TYPEOF(le.Input_median_valuation))'','',':median_valuation')
    #END
 
+    #IF( #TEXT(Input_history_history_date)='' )
      '' 
    #ELSE
        IF( le.Input_history_history_date = (TYPEOF(le.Input_history_history_date))'','',':history_history_date')
    #END
 
+    #IF( #TEXT(Input_history_median_valuation)='' )
      '' 
    #ELSE
        IF( le.Input_history_median_valuation = (TYPEOF(le.Input_history_median_valuation))'','',':history_median_valuation')
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
