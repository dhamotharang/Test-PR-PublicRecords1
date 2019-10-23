 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_name1 = '',Input_name2 = '',Input_date_filed = '',Input_file_number = '',Input_prep_addr1_line1 = '',Input_prep_addr1_line_last = '',Input_prep_addr2_line1 = '',Input_prep_addr2_line_last = '',Input_RECORD_TYPE = '',Input_STREET_ADD1 = '',Input_CITY1 = '',Input_STATE1 = '',Input_ZIP1 = '',Input_TERM = '',Input_STREET_ADD2 = '',Input_CITY2 = '',Input_STATE2 = '',Input_ZIP2 = '',Input_FILM_CODE = '',Input_BUS_TYPE = '',Input_ANNEX_CODE = '',Input_NUM_PAGES = '',Input_EXPIRED_TERM = '',Input_INCORPORATED = '',Input_ASSUMED_NAME = '',Input_name1_title = '',Input_name1_fname = '',Input_name1_mname = '',Input_name1_lname = '',Input_name1_name_suffix = '',Input_name1_name_score = '',Input_name2_title = '',Input_name2_fname = '',Input_name2_mname = '',Input_name2_lname = '',Input_name2_name_suffix = '',Input_name2_name_score = '',OutFile) := MACRO
  IMPORT SALT37,Scrubs_FBNV2;
  #uniquename(of)
  %of% := RECORD
    SALT37.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_name1)='' )
      '' 
    #ELSE
        IF( le.Input_name1 = (TYPEOF(le.Input_name1))'','',':name1')
    #END
 
+    #IF( #TEXT(Input_name2)='' )
      '' 
    #ELSE
        IF( le.Input_name2 = (TYPEOF(le.Input_name2))'','',':name2')
    #END
 
+    #IF( #TEXT(Input_date_filed)='' )
      '' 
    #ELSE
        IF( le.Input_date_filed = (TYPEOF(le.Input_date_filed))'','',':date_filed')
    #END
 
+    #IF( #TEXT(Input_file_number)='' )
      '' 
    #ELSE
        IF( le.Input_file_number = (TYPEOF(le.Input_file_number))'','',':file_number')
    #END
 
+    #IF( #TEXT(Input_prep_addr1_line1)='' )
      '' 
    #ELSE
        IF( le.Input_prep_addr1_line1 = (TYPEOF(le.Input_prep_addr1_line1))'','',':prep_addr1_line1')
    #END
 
+    #IF( #TEXT(Input_prep_addr1_line_last)='' )
      '' 
    #ELSE
        IF( le.Input_prep_addr1_line_last = (TYPEOF(le.Input_prep_addr1_line_last))'','',':prep_addr1_line_last')
    #END
 
+    #IF( #TEXT(Input_prep_addr2_line1)='' )
      '' 
    #ELSE
        IF( le.Input_prep_addr2_line1 = (TYPEOF(le.Input_prep_addr2_line1))'','',':prep_addr2_line1')
    #END
 
+    #IF( #TEXT(Input_prep_addr2_line_last)='' )
      '' 
    #ELSE
        IF( le.Input_prep_addr2_line_last = (TYPEOF(le.Input_prep_addr2_line_last))'','',':prep_addr2_line_last')
    #END
 
+    #IF( #TEXT(Input_RECORD_TYPE)='' )
      '' 
    #ELSE
        IF( le.Input_RECORD_TYPE = (TYPEOF(le.Input_RECORD_TYPE))'','',':RECORD_TYPE')
    #END
 
+    #IF( #TEXT(Input_STREET_ADD1)='' )
      '' 
    #ELSE
        IF( le.Input_STREET_ADD1 = (TYPEOF(le.Input_STREET_ADD1))'','',':STREET_ADD1')
    #END
 
+    #IF( #TEXT(Input_CITY1)='' )
      '' 
    #ELSE
        IF( le.Input_CITY1 = (TYPEOF(le.Input_CITY1))'','',':CITY1')
    #END
 
+    #IF( #TEXT(Input_STATE1)='' )
      '' 
    #ELSE
        IF( le.Input_STATE1 = (TYPEOF(le.Input_STATE1))'','',':STATE1')
    #END
 
+    #IF( #TEXT(Input_ZIP1)='' )
      '' 
    #ELSE
        IF( le.Input_ZIP1 = (TYPEOF(le.Input_ZIP1))'','',':ZIP1')
    #END
 
+    #IF( #TEXT(Input_TERM)='' )
      '' 
    #ELSE
        IF( le.Input_TERM = (TYPEOF(le.Input_TERM))'','',':TERM')
    #END
 
+    #IF( #TEXT(Input_STREET_ADD2)='' )
      '' 
    #ELSE
        IF( le.Input_STREET_ADD2 = (TYPEOF(le.Input_STREET_ADD2))'','',':STREET_ADD2')
    #END
 
+    #IF( #TEXT(Input_CITY2)='' )
      '' 
    #ELSE
        IF( le.Input_CITY2 = (TYPEOF(le.Input_CITY2))'','',':CITY2')
    #END
 
+    #IF( #TEXT(Input_STATE2)='' )
      '' 
    #ELSE
        IF( le.Input_STATE2 = (TYPEOF(le.Input_STATE2))'','',':STATE2')
    #END
 
+    #IF( #TEXT(Input_ZIP2)='' )
      '' 
    #ELSE
        IF( le.Input_ZIP2 = (TYPEOF(le.Input_ZIP2))'','',':ZIP2')
    #END
 
+    #IF( #TEXT(Input_FILM_CODE)='' )
      '' 
    #ELSE
        IF( le.Input_FILM_CODE = (TYPEOF(le.Input_FILM_CODE))'','',':FILM_CODE')
    #END
 
+    #IF( #TEXT(Input_BUS_TYPE)='' )
      '' 
    #ELSE
        IF( le.Input_BUS_TYPE = (TYPEOF(le.Input_BUS_TYPE))'','',':BUS_TYPE')
    #END
 
+    #IF( #TEXT(Input_ANNEX_CODE)='' )
      '' 
    #ELSE
        IF( le.Input_ANNEX_CODE = (TYPEOF(le.Input_ANNEX_CODE))'','',':ANNEX_CODE')
    #END
 
+    #IF( #TEXT(Input_NUM_PAGES)='' )
      '' 
    #ELSE
        IF( le.Input_NUM_PAGES = (TYPEOF(le.Input_NUM_PAGES))'','',':NUM_PAGES')
    #END
 
+    #IF( #TEXT(Input_EXPIRED_TERM)='' )
      '' 
    #ELSE
        IF( le.Input_EXPIRED_TERM = (TYPEOF(le.Input_EXPIRED_TERM))'','',':EXPIRED_TERM')
    #END
 
+    #IF( #TEXT(Input_INCORPORATED)='' )
      '' 
    #ELSE
        IF( le.Input_INCORPORATED = (TYPEOF(le.Input_INCORPORATED))'','',':INCORPORATED')
    #END
 
+    #IF( #TEXT(Input_ASSUMED_NAME)='' )
      '' 
    #ELSE
        IF( le.Input_ASSUMED_NAME = (TYPEOF(le.Input_ASSUMED_NAME))'','',':ASSUMED_NAME')
    #END
 
+    #IF( #TEXT(Input_name1_title)='' )
      '' 
    #ELSE
        IF( le.Input_name1_title = (TYPEOF(le.Input_name1_title))'','',':name1_title')
    #END
 
+    #IF( #TEXT(Input_name1_fname)='' )
      '' 
    #ELSE
        IF( le.Input_name1_fname = (TYPEOF(le.Input_name1_fname))'','',':name1_fname')
    #END
 
+    #IF( #TEXT(Input_name1_mname)='' )
      '' 
    #ELSE
        IF( le.Input_name1_mname = (TYPEOF(le.Input_name1_mname))'','',':name1_mname')
    #END
 
+    #IF( #TEXT(Input_name1_lname)='' )
      '' 
    #ELSE
        IF( le.Input_name1_lname = (TYPEOF(le.Input_name1_lname))'','',':name1_lname')
    #END
 
+    #IF( #TEXT(Input_name1_name_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_name1_name_suffix = (TYPEOF(le.Input_name1_name_suffix))'','',':name1_name_suffix')
    #END
 
+    #IF( #TEXT(Input_name1_name_score)='' )
      '' 
    #ELSE
        IF( le.Input_name1_name_score = (TYPEOF(le.Input_name1_name_score))'','',':name1_name_score')
    #END
 
+    #IF( #TEXT(Input_name2_title)='' )
      '' 
    #ELSE
        IF( le.Input_name2_title = (TYPEOF(le.Input_name2_title))'','',':name2_title')
    #END
 
+    #IF( #TEXT(Input_name2_fname)='' )
      '' 
    #ELSE
        IF( le.Input_name2_fname = (TYPEOF(le.Input_name2_fname))'','',':name2_fname')
    #END
 
+    #IF( #TEXT(Input_name2_mname)='' )
      '' 
    #ELSE
        IF( le.Input_name2_mname = (TYPEOF(le.Input_name2_mname))'','',':name2_mname')
    #END
 
+    #IF( #TEXT(Input_name2_lname)='' )
      '' 
    #ELSE
        IF( le.Input_name2_lname = (TYPEOF(le.Input_name2_lname))'','',':name2_lname')
    #END
 
+    #IF( #TEXT(Input_name2_name_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_name2_name_suffix = (TYPEOF(le.Input_name2_name_suffix))'','',':name2_name_suffix')
    #END
 
+    #IF( #TEXT(Input_name2_name_score)='' )
      '' 
    #ELSE
        IF( le.Input_name2_name_score = (TYPEOF(le.Input_name2_name_score))'','',':name2_name_score')
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
