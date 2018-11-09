 
EXPORT Matter_MAC_PopulationStatistics(infile,Ref='',Input_dt_first_reported = '',Input_dt_last_reported = '',Input_process_date = '',Input_vendor = '',Input_state_origin = '',Input_source_file = '',Input_case_key = '',Input_parent_case_key = '',Input_court_code = '',Input_court = '',Input_case_number = '',Input_case_type_code = '',Input_case_type = '',Input_case_title = '',Input_case_cause_code = '',Input_case_cause = '',Input_manner_of_filing_code = '',Input_manner_of_filing = '',Input_filing_date = '',Input_manner_of_judgmt_code = '',Input_manner_of_judgmt = '',Input_judgmt_date = '',Input_ruled_for_against_code = '',Input_ruled_for_against = '',Input_judgmt_type_code = '',Input_judgmt_type = '',Input_judgmt_disposition_date = '',Input_judgmt_disposition_code = '',Input_judgmt_disposition = '',Input_disposition_code = '',Input_disposition_description = '',Input_disposition_date = '',Input_suit_amount = '',Input_award_amount = '',OutFile) := MACRO
  IMPORT SALT39,Scrubs_Civil_Court;
  #uniquename(of)
  %of% := RECORD
    SALT39.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_dt_first_reported)='' )
      '' 
    #ELSE
        IF( le.Input_dt_first_reported = (TYPEOF(le.Input_dt_first_reported))'','',':dt_first_reported')
    #END
 
+    #IF( #TEXT(Input_dt_last_reported)='' )
      '' 
    #ELSE
        IF( le.Input_dt_last_reported = (TYPEOF(le.Input_dt_last_reported))'','',':dt_last_reported')
    #END
 
+    #IF( #TEXT(Input_process_date)='' )
      '' 
    #ELSE
        IF( le.Input_process_date = (TYPEOF(le.Input_process_date))'','',':process_date')
    #END
 
+    #IF( #TEXT(Input_vendor)='' )
      '' 
    #ELSE
        IF( le.Input_vendor = (TYPEOF(le.Input_vendor))'','',':vendor')
    #END
 
+    #IF( #TEXT(Input_state_origin)='' )
      '' 
    #ELSE
        IF( le.Input_state_origin = (TYPEOF(le.Input_state_origin))'','',':state_origin')
    #END
 
+    #IF( #TEXT(Input_source_file)='' )
      '' 
    #ELSE
        IF( le.Input_source_file = (TYPEOF(le.Input_source_file))'','',':source_file')
    #END
 
+    #IF( #TEXT(Input_case_key)='' )
      '' 
    #ELSE
        IF( le.Input_case_key = (TYPEOF(le.Input_case_key))'','',':case_key')
    #END
 
+    #IF( #TEXT(Input_parent_case_key)='' )
      '' 
    #ELSE
        IF( le.Input_parent_case_key = (TYPEOF(le.Input_parent_case_key))'','',':parent_case_key')
    #END
 
+    #IF( #TEXT(Input_court_code)='' )
      '' 
    #ELSE
        IF( le.Input_court_code = (TYPEOF(le.Input_court_code))'','',':court_code')
    #END
 
+    #IF( #TEXT(Input_court)='' )
      '' 
    #ELSE
        IF( le.Input_court = (TYPEOF(le.Input_court))'','',':court')
    #END
 
+    #IF( #TEXT(Input_case_number)='' )
      '' 
    #ELSE
        IF( le.Input_case_number = (TYPEOF(le.Input_case_number))'','',':case_number')
    #END
 
+    #IF( #TEXT(Input_case_type_code)='' )
      '' 
    #ELSE
        IF( le.Input_case_type_code = (TYPEOF(le.Input_case_type_code))'','',':case_type_code')
    #END
 
+    #IF( #TEXT(Input_case_type)='' )
      '' 
    #ELSE
        IF( le.Input_case_type = (TYPEOF(le.Input_case_type))'','',':case_type')
    #END
 
+    #IF( #TEXT(Input_case_title)='' )
      '' 
    #ELSE
        IF( le.Input_case_title = (TYPEOF(le.Input_case_title))'','',':case_title')
    #END
 
+    #IF( #TEXT(Input_case_cause_code)='' )
      '' 
    #ELSE
        IF( le.Input_case_cause_code = (TYPEOF(le.Input_case_cause_code))'','',':case_cause_code')
    #END
 
+    #IF( #TEXT(Input_case_cause)='' )
      '' 
    #ELSE
        IF( le.Input_case_cause = (TYPEOF(le.Input_case_cause))'','',':case_cause')
    #END
 
+    #IF( #TEXT(Input_manner_of_filing_code)='' )
      '' 
    #ELSE
        IF( le.Input_manner_of_filing_code = (TYPEOF(le.Input_manner_of_filing_code))'','',':manner_of_filing_code')
    #END
 
+    #IF( #TEXT(Input_manner_of_filing)='' )
      '' 
    #ELSE
        IF( le.Input_manner_of_filing = (TYPEOF(le.Input_manner_of_filing))'','',':manner_of_filing')
    #END
 
+    #IF( #TEXT(Input_filing_date)='' )
      '' 
    #ELSE
        IF( le.Input_filing_date = (TYPEOF(le.Input_filing_date))'','',':filing_date')
    #END
 
+    #IF( #TEXT(Input_manner_of_judgmt_code)='' )
      '' 
    #ELSE
        IF( le.Input_manner_of_judgmt_code = (TYPEOF(le.Input_manner_of_judgmt_code))'','',':manner_of_judgmt_code')
    #END
 
+    #IF( #TEXT(Input_manner_of_judgmt)='' )
      '' 
    #ELSE
        IF( le.Input_manner_of_judgmt = (TYPEOF(le.Input_manner_of_judgmt))'','',':manner_of_judgmt')
    #END
 
+    #IF( #TEXT(Input_judgmt_date)='' )
      '' 
    #ELSE
        IF( le.Input_judgmt_date = (TYPEOF(le.Input_judgmt_date))'','',':judgmt_date')
    #END
 
+    #IF( #TEXT(Input_ruled_for_against_code)='' )
      '' 
    #ELSE
        IF( le.Input_ruled_for_against_code = (TYPEOF(le.Input_ruled_for_against_code))'','',':ruled_for_against_code')
    #END
 
+    #IF( #TEXT(Input_ruled_for_against)='' )
      '' 
    #ELSE
        IF( le.Input_ruled_for_against = (TYPEOF(le.Input_ruled_for_against))'','',':ruled_for_against')
    #END
 
+    #IF( #TEXT(Input_judgmt_type_code)='' )
      '' 
    #ELSE
        IF( le.Input_judgmt_type_code = (TYPEOF(le.Input_judgmt_type_code))'','',':judgmt_type_code')
    #END
 
+    #IF( #TEXT(Input_judgmt_type)='' )
      '' 
    #ELSE
        IF( le.Input_judgmt_type = (TYPEOF(le.Input_judgmt_type))'','',':judgmt_type')
    #END
 
+    #IF( #TEXT(Input_judgmt_disposition_date)='' )
      '' 
    #ELSE
        IF( le.Input_judgmt_disposition_date = (TYPEOF(le.Input_judgmt_disposition_date))'','',':judgmt_disposition_date')
    #END
 
+    #IF( #TEXT(Input_judgmt_disposition_code)='' )
      '' 
    #ELSE
        IF( le.Input_judgmt_disposition_code = (TYPEOF(le.Input_judgmt_disposition_code))'','',':judgmt_disposition_code')
    #END
 
+    #IF( #TEXT(Input_judgmt_disposition)='' )
      '' 
    #ELSE
        IF( le.Input_judgmt_disposition = (TYPEOF(le.Input_judgmt_disposition))'','',':judgmt_disposition')
    #END
 
+    #IF( #TEXT(Input_disposition_code)='' )
      '' 
    #ELSE
        IF( le.Input_disposition_code = (TYPEOF(le.Input_disposition_code))'','',':disposition_code')
    #END
 
+    #IF( #TEXT(Input_disposition_description)='' )
      '' 
    #ELSE
        IF( le.Input_disposition_description = (TYPEOF(le.Input_disposition_description))'','',':disposition_description')
    #END
 
+    #IF( #TEXT(Input_disposition_date)='' )
      '' 
    #ELSE
        IF( le.Input_disposition_date = (TYPEOF(le.Input_disposition_date))'','',':disposition_date')
    #END
 
+    #IF( #TEXT(Input_suit_amount)='' )
      '' 
    #ELSE
        IF( le.Input_suit_amount = (TYPEOF(le.Input_suit_amount))'','',':suit_amount')
    #END
 
+    #IF( #TEXT(Input_award_amount)='' )
      '' 
    #ELSE
        IF( le.Input_award_amount = (TYPEOF(le.Input_award_amount))'','',':award_amount')
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
