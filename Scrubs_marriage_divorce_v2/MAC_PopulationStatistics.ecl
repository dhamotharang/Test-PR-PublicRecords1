
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_dt_first_seen = '',Input_dt_last_seen = '',Input_dt_vendor_first_reported = '',Input_dt_vendor_last_reported = '',Input_record_id = '',Input_filing_type = '',Input_filing_subtype = '',Input_vendor = '',Input_source_file = '',Input_process_date = '',Input_state_origin = '',Input_party1_type = '',Input_party1_name_format = '',Input_party1_name = '',Input_party1_alias = '',Input_party1_dob = '',Input_party1_birth_state = '',Input_party1_age = '',Input_party1_race = '',Input_party1_addr1 = '',Input_party1_csz = '',Input_party1_county = '',Input_party1_previous_marital_status = '',Input_party1_how_marriage_ended = '',Input_party1_times_married = '',Input_party1_last_marriage_end_dt = '',Input_party2_type = '',Input_party2_name_format = '',Input_party2_name = '',Input_party2_alias = '',Input_party2_dob = '',Input_party2_birth_state = '',Input_party2_age = '',Input_party2_race = '',Input_party2_addr1 = '',Input_party2_csz = '',Input_party2_county = '',Input_party2_previous_marital_status = '',Input_party2_how_marriage_ended = '',Input_party2_times_married = '',Input_party2_last_marriage_end_dt = '',Input_number_of_children = '',Input_marriage_filing_dt = '',Input_marriage_dt = '',Input_marriage_city = '',Input_marriage_county = '',Input_place_of_marriage = '',Input_type_of_ceremony = '',Input_marriage_filing_number = '',Input_marriage_docket_volume = '',Input_divorce_filing_dt = '',Input_divorce_dt = '',Input_divorce_docket_volume = '',Input_divorce_filing_number = '',Input_divorce_city = '',Input_divorce_county = '',Input_grounds_for_divorce = '',Input_marriage_duration_cd = '',Input_marriage_duration = '',Input_persistent_record_id = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_Marriage_Divorce_V2;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_dt_first_seen)='' )
      '' 
    #ELSE
        IF( le.Input_dt_first_seen = (TYPEOF(le.Input_dt_first_seen))'','',':dt_first_seen')
    #END

+    #IF( #TEXT(Input_dt_last_seen)='' )
      '' 
    #ELSE
        IF( le.Input_dt_last_seen = (TYPEOF(le.Input_dt_last_seen))'','',':dt_last_seen')
    #END

+    #IF( #TEXT(Input_dt_vendor_first_reported)='' )
      '' 
    #ELSE
        IF( le.Input_dt_vendor_first_reported = (TYPEOF(le.Input_dt_vendor_first_reported))'','',':dt_vendor_first_reported')
    #END

+    #IF( #TEXT(Input_dt_vendor_last_reported)='' )
      '' 
    #ELSE
        IF( le.Input_dt_vendor_last_reported = (TYPEOF(le.Input_dt_vendor_last_reported))'','',':dt_vendor_last_reported')
    #END

+    #IF( #TEXT(Input_record_id)='' )
      '' 
    #ELSE
        IF( le.Input_record_id = (TYPEOF(le.Input_record_id))'','',':record_id')
    #END

+    #IF( #TEXT(Input_filing_type)='' )
      '' 
    #ELSE
        IF( le.Input_filing_type = (TYPEOF(le.Input_filing_type))'','',':filing_type')
    #END

+    #IF( #TEXT(Input_filing_subtype)='' )
      '' 
    #ELSE
        IF( le.Input_filing_subtype = (TYPEOF(le.Input_filing_subtype))'','',':filing_subtype')
    #END

+    #IF( #TEXT(Input_vendor)='' )
      '' 
    #ELSE
        IF( le.Input_vendor = (TYPEOF(le.Input_vendor))'','',':vendor')
    #END

+    #IF( #TEXT(Input_source_file)='' )
      '' 
    #ELSE
        IF( le.Input_source_file = (TYPEOF(le.Input_source_file))'','',':source_file')
    #END

+    #IF( #TEXT(Input_process_date)='' )
      '' 
    #ELSE
        IF( le.Input_process_date = (TYPEOF(le.Input_process_date))'','',':process_date')
    #END

+    #IF( #TEXT(Input_state_origin)='' )
      '' 
    #ELSE
        IF( le.Input_state_origin = (TYPEOF(le.Input_state_origin))'','',':state_origin')
    #END

+    #IF( #TEXT(Input_party1_type)='' )
      '' 
    #ELSE
        IF( le.Input_party1_type = (TYPEOF(le.Input_party1_type))'','',':party1_type')
    #END

+    #IF( #TEXT(Input_party1_name_format)='' )
      '' 
    #ELSE
        IF( le.Input_party1_name_format = (TYPEOF(le.Input_party1_name_format))'','',':party1_name_format')
    #END

+    #IF( #TEXT(Input_party1_name)='' )
      '' 
    #ELSE
        IF( le.Input_party1_name = (TYPEOF(le.Input_party1_name))'','',':party1_name')
    #END

+    #IF( #TEXT(Input_party1_alias)='' )
      '' 
    #ELSE
        IF( le.Input_party1_alias = (TYPEOF(le.Input_party1_alias))'','',':party1_alias')
    #END

+    #IF( #TEXT(Input_party1_dob)='' )
      '' 
    #ELSE
        IF( le.Input_party1_dob = (TYPEOF(le.Input_party1_dob))'','',':party1_dob')
    #END

+    #IF( #TEXT(Input_party1_birth_state)='' )
      '' 
    #ELSE
        IF( le.Input_party1_birth_state = (TYPEOF(le.Input_party1_birth_state))'','',':party1_birth_state')
    #END

+    #IF( #TEXT(Input_party1_age)='' )
      '' 
    #ELSE
        IF( le.Input_party1_age = (TYPEOF(le.Input_party1_age))'','',':party1_age')
    #END

+    #IF( #TEXT(Input_party1_race)='' )
      '' 
    #ELSE
        IF( le.Input_party1_race = (TYPEOF(le.Input_party1_race))'','',':party1_race')
    #END

+    #IF( #TEXT(Input_party1_addr1)='' )
      '' 
    #ELSE
        IF( le.Input_party1_addr1 = (TYPEOF(le.Input_party1_addr1))'','',':party1_addr1')
    #END

+    #IF( #TEXT(Input_party1_csz)='' )
      '' 
    #ELSE
        IF( le.Input_party1_csz = (TYPEOF(le.Input_party1_csz))'','',':party1_csz')
    #END

+    #IF( #TEXT(Input_party1_county)='' )
      '' 
    #ELSE
        IF( le.Input_party1_county = (TYPEOF(le.Input_party1_county))'','',':party1_county')
    #END

+    #IF( #TEXT(Input_party1_previous_marital_status)='' )
      '' 
    #ELSE
        IF( le.Input_party1_previous_marital_status = (TYPEOF(le.Input_party1_previous_marital_status))'','',':party1_previous_marital_status')
    #END

+    #IF( #TEXT(Input_party1_how_marriage_ended)='' )
      '' 
    #ELSE
        IF( le.Input_party1_how_marriage_ended = (TYPEOF(le.Input_party1_how_marriage_ended))'','',':party1_how_marriage_ended')
    #END

+    #IF( #TEXT(Input_party1_times_married)='' )
      '' 
    #ELSE
        IF( le.Input_party1_times_married = (TYPEOF(le.Input_party1_times_married))'','',':party1_times_married')
    #END

+    #IF( #TEXT(Input_party1_last_marriage_end_dt)='' )
      '' 
    #ELSE
        IF( le.Input_party1_last_marriage_end_dt = (TYPEOF(le.Input_party1_last_marriage_end_dt))'','',':party1_last_marriage_end_dt')
    #END

+    #IF( #TEXT(Input_party2_type)='' )
      '' 
    #ELSE
        IF( le.Input_party2_type = (TYPEOF(le.Input_party2_type))'','',':party2_type')
    #END

+    #IF( #TEXT(Input_party2_name_format)='' )
      '' 
    #ELSE
        IF( le.Input_party2_name_format = (TYPEOF(le.Input_party2_name_format))'','',':party2_name_format')
    #END

+    #IF( #TEXT(Input_party2_name)='' )
      '' 
    #ELSE
        IF( le.Input_party2_name = (TYPEOF(le.Input_party2_name))'','',':party2_name')
    #END

+    #IF( #TEXT(Input_party2_alias)='' )
      '' 
    #ELSE
        IF( le.Input_party2_alias = (TYPEOF(le.Input_party2_alias))'','',':party2_alias')
    #END

+    #IF( #TEXT(Input_party2_dob)='' )
      '' 
    #ELSE
        IF( le.Input_party2_dob = (TYPEOF(le.Input_party2_dob))'','',':party2_dob')
    #END

+    #IF( #TEXT(Input_party2_birth_state)='' )
      '' 
    #ELSE
        IF( le.Input_party2_birth_state = (TYPEOF(le.Input_party2_birth_state))'','',':party2_birth_state')
    #END

+    #IF( #TEXT(Input_party2_age)='' )
      '' 
    #ELSE
        IF( le.Input_party2_age = (TYPEOF(le.Input_party2_age))'','',':party2_age')
    #END

+    #IF( #TEXT(Input_party2_race)='' )
      '' 
    #ELSE
        IF( le.Input_party2_race = (TYPEOF(le.Input_party2_race))'','',':party2_race')
    #END

+    #IF( #TEXT(Input_party2_addr1)='' )
      '' 
    #ELSE
        IF( le.Input_party2_addr1 = (TYPEOF(le.Input_party2_addr1))'','',':party2_addr1')
    #END

+    #IF( #TEXT(Input_party2_csz)='' )
      '' 
    #ELSE
        IF( le.Input_party2_csz = (TYPEOF(le.Input_party2_csz))'','',':party2_csz')
    #END

+    #IF( #TEXT(Input_party2_county)='' )
      '' 
    #ELSE
        IF( le.Input_party2_county = (TYPEOF(le.Input_party2_county))'','',':party2_county')
    #END

+    #IF( #TEXT(Input_party2_previous_marital_status)='' )
      '' 
    #ELSE
        IF( le.Input_party2_previous_marital_status = (TYPEOF(le.Input_party2_previous_marital_status))'','',':party2_previous_marital_status')
    #END

+    #IF( #TEXT(Input_party2_how_marriage_ended)='' )
      '' 
    #ELSE
        IF( le.Input_party2_how_marriage_ended = (TYPEOF(le.Input_party2_how_marriage_ended))'','',':party2_how_marriage_ended')
    #END

+    #IF( #TEXT(Input_party2_times_married)='' )
      '' 
    #ELSE
        IF( le.Input_party2_times_married = (TYPEOF(le.Input_party2_times_married))'','',':party2_times_married')
    #END

+    #IF( #TEXT(Input_party2_last_marriage_end_dt)='' )
      '' 
    #ELSE
        IF( le.Input_party2_last_marriage_end_dt = (TYPEOF(le.Input_party2_last_marriage_end_dt))'','',':party2_last_marriage_end_dt')
    #END

+    #IF( #TEXT(Input_number_of_children)='' )
      '' 
    #ELSE
        IF( le.Input_number_of_children = (TYPEOF(le.Input_number_of_children))'','',':number_of_children')
    #END

+    #IF( #TEXT(Input_marriage_filing_dt)='' )
      '' 
    #ELSE
        IF( le.Input_marriage_filing_dt = (TYPEOF(le.Input_marriage_filing_dt))'','',':marriage_filing_dt')
    #END

+    #IF( #TEXT(Input_marriage_dt)='' )
      '' 
    #ELSE
        IF( le.Input_marriage_dt = (TYPEOF(le.Input_marriage_dt))'','',':marriage_dt')
    #END

+    #IF( #TEXT(Input_marriage_city)='' )
      '' 
    #ELSE
        IF( le.Input_marriage_city = (TYPEOF(le.Input_marriage_city))'','',':marriage_city')
    #END

+    #IF( #TEXT(Input_marriage_county)='' )
      '' 
    #ELSE
        IF( le.Input_marriage_county = (TYPEOF(le.Input_marriage_county))'','',':marriage_county')
    #END

+    #IF( #TEXT(Input_place_of_marriage)='' )
      '' 
    #ELSE
        IF( le.Input_place_of_marriage = (TYPEOF(le.Input_place_of_marriage))'','',':place_of_marriage')
    #END

+    #IF( #TEXT(Input_type_of_ceremony)='' )
      '' 
    #ELSE
        IF( le.Input_type_of_ceremony = (TYPEOF(le.Input_type_of_ceremony))'','',':type_of_ceremony')
    #END

+    #IF( #TEXT(Input_marriage_filing_number)='' )
      '' 
    #ELSE
        IF( le.Input_marriage_filing_number = (TYPEOF(le.Input_marriage_filing_number))'','',':marriage_filing_number')
    #END

+    #IF( #TEXT(Input_marriage_docket_volume)='' )
      '' 
    #ELSE
        IF( le.Input_marriage_docket_volume = (TYPEOF(le.Input_marriage_docket_volume))'','',':marriage_docket_volume')
    #END

+    #IF( #TEXT(Input_divorce_filing_dt)='' )
      '' 
    #ELSE
        IF( le.Input_divorce_filing_dt = (TYPEOF(le.Input_divorce_filing_dt))'','',':divorce_filing_dt')
    #END

+    #IF( #TEXT(Input_divorce_dt)='' )
      '' 
    #ELSE
        IF( le.Input_divorce_dt = (TYPEOF(le.Input_divorce_dt))'','',':divorce_dt')
    #END

+    #IF( #TEXT(Input_divorce_docket_volume)='' )
      '' 
    #ELSE
        IF( le.Input_divorce_docket_volume = (TYPEOF(le.Input_divorce_docket_volume))'','',':divorce_docket_volume')
    #END

+    #IF( #TEXT(Input_divorce_filing_number)='' )
      '' 
    #ELSE
        IF( le.Input_divorce_filing_number = (TYPEOF(le.Input_divorce_filing_number))'','',':divorce_filing_number')
    #END

+    #IF( #TEXT(Input_divorce_city)='' )
      '' 
    #ELSE
        IF( le.Input_divorce_city = (TYPEOF(le.Input_divorce_city))'','',':divorce_city')
    #END

+    #IF( #TEXT(Input_divorce_county)='' )
      '' 
    #ELSE
        IF( le.Input_divorce_county = (TYPEOF(le.Input_divorce_county))'','',':divorce_county')
    #END

+    #IF( #TEXT(Input_grounds_for_divorce)='' )
      '' 
    #ELSE
        IF( le.Input_grounds_for_divorce = (TYPEOF(le.Input_grounds_for_divorce))'','',':grounds_for_divorce')
    #END

+    #IF( #TEXT(Input_marriage_duration_cd)='' )
      '' 
    #ELSE
        IF( le.Input_marriage_duration_cd = (TYPEOF(le.Input_marriage_duration_cd))'','',':marriage_duration_cd')
    #END

+    #IF( #TEXT(Input_marriage_duration)='' )
      '' 
    #ELSE
        IF( le.Input_marriage_duration = (TYPEOF(le.Input_marriage_duration))'','',':marriage_duration')
    #END

+    #IF( #TEXT(Input_persistent_record_id)='' )
      '' 
    #ELSE
        IF( le.Input_persistent_record_id = (TYPEOF(le.Input_persistent_record_id))'','',':persistent_record_id')
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
