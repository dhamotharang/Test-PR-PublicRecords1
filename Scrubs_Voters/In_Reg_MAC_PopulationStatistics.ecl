 
EXPORT In_Reg_MAC_PopulationStatistics(infile,Ref='',Input_active_status = '',Input_agecat = '',Input_changedate = '',Input_countycode = '',Input_distcode = '',Input_dob = '',Input_EMID_number = '',Input_file_acquired_date = '',Input_first_name = '',Input_gender = '',Input_gendersurnamguess = '',Input_home_phone = '',Input_idcode = '',Input_lastdatevote = '',Input_last_name = '',Input_marriedappend = '',Input_middle_name = '',Input_political_party = '',Input_race = '',Input_regdate = '',Input_res_addr1 = '',Input_res_city = '',Input_res_state = '',Input_res_zip = '',Input_schoolcode = '',Input_source_voterid = '',Input_statehouse = '',Input_statesenate = '',Input_state_code = '',Input_timezonetbl = '',Input_ushouse = '',Input_voter_status = '',Input_work_phone = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_Voters;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_active_status)='' )
      '' 
    #ELSE
        IF( le.Input_active_status = (TYPEOF(le.Input_active_status))'','',':active_status')
    #END
 
+    #IF( #TEXT(Input_agecat)='' )
      '' 
    #ELSE
        IF( le.Input_agecat = (TYPEOF(le.Input_agecat))'','',':agecat')
    #END
 
+    #IF( #TEXT(Input_changedate)='' )
      '' 
    #ELSE
        IF( le.Input_changedate = (TYPEOF(le.Input_changedate))'','',':changedate')
    #END
 
+    #IF( #TEXT(Input_countycode)='' )
      '' 
    #ELSE
        IF( le.Input_countycode = (TYPEOF(le.Input_countycode))'','',':countycode')
    #END
 
+    #IF( #TEXT(Input_distcode)='' )
      '' 
    #ELSE
        IF( le.Input_distcode = (TYPEOF(le.Input_distcode))'','',':distcode')
    #END
 
+    #IF( #TEXT(Input_dob)='' )
      '' 
    #ELSE
        IF( le.Input_dob = (TYPEOF(le.Input_dob))'','',':dob')
    #END
 
+    #IF( #TEXT(Input_EMID_number)='' )
      '' 
    #ELSE
        IF( le.Input_EMID_number = (TYPEOF(le.Input_EMID_number))'','',':EMID_number')
    #END
 
+    #IF( #TEXT(Input_file_acquired_date)='' )
      '' 
    #ELSE
        IF( le.Input_file_acquired_date = (TYPEOF(le.Input_file_acquired_date))'','',':file_acquired_date')
    #END
 
+    #IF( #TEXT(Input_first_name)='' )
      '' 
    #ELSE
        IF( le.Input_first_name = (TYPEOF(le.Input_first_name))'','',':first_name')
    #END
 
+    #IF( #TEXT(Input_gender)='' )
      '' 
    #ELSE
        IF( le.Input_gender = (TYPEOF(le.Input_gender))'','',':gender')
    #END
 
+    #IF( #TEXT(Input_gendersurnamguess)='' )
      '' 
    #ELSE
        IF( le.Input_gendersurnamguess = (TYPEOF(le.Input_gendersurnamguess))'','',':gendersurnamguess')
    #END
 
+    #IF( #TEXT(Input_home_phone)='' )
      '' 
    #ELSE
        IF( le.Input_home_phone = (TYPEOF(le.Input_home_phone))'','',':home_phone')
    #END
 
+    #IF( #TEXT(Input_idcode)='' )
      '' 
    #ELSE
        IF( le.Input_idcode = (TYPEOF(le.Input_idcode))'','',':idcode')
    #END
 
+    #IF( #TEXT(Input_lastdatevote)='' )
      '' 
    #ELSE
        IF( le.Input_lastdatevote = (TYPEOF(le.Input_lastdatevote))'','',':lastdatevote')
    #END
 
+    #IF( #TEXT(Input_last_name)='' )
      '' 
    #ELSE
        IF( le.Input_last_name = (TYPEOF(le.Input_last_name))'','',':last_name')
    #END
 
+    #IF( #TEXT(Input_marriedappend)='' )
      '' 
    #ELSE
        IF( le.Input_marriedappend = (TYPEOF(le.Input_marriedappend))'','',':marriedappend')
    #END
 
+    #IF( #TEXT(Input_middle_name)='' )
      '' 
    #ELSE
        IF( le.Input_middle_name = (TYPEOF(le.Input_middle_name))'','',':middle_name')
    #END
 
+    #IF( #TEXT(Input_political_party)='' )
      '' 
    #ELSE
        IF( le.Input_political_party = (TYPEOF(le.Input_political_party))'','',':political_party')
    #END
 
+    #IF( #TEXT(Input_race)='' )
      '' 
    #ELSE
        IF( le.Input_race = (TYPEOF(le.Input_race))'','',':race')
    #END
 
+    #IF( #TEXT(Input_regdate)='' )
      '' 
    #ELSE
        IF( le.Input_regdate = (TYPEOF(le.Input_regdate))'','',':regdate')
    #END
 
+    #IF( #TEXT(Input_res_addr1)='' )
      '' 
    #ELSE
        IF( le.Input_res_addr1 = (TYPEOF(le.Input_res_addr1))'','',':res_addr1')
    #END
 
+    #IF( #TEXT(Input_res_city)='' )
      '' 
    #ELSE
        IF( le.Input_res_city = (TYPEOF(le.Input_res_city))'','',':res_city')
    #END
 
+    #IF( #TEXT(Input_res_state)='' )
      '' 
    #ELSE
        IF( le.Input_res_state = (TYPEOF(le.Input_res_state))'','',':res_state')
    #END
 
+    #IF( #TEXT(Input_res_zip)='' )
      '' 
    #ELSE
        IF( le.Input_res_zip = (TYPEOF(le.Input_res_zip))'','',':res_zip')
    #END
 
+    #IF( #TEXT(Input_schoolcode)='' )
      '' 
    #ELSE
        IF( le.Input_schoolcode = (TYPEOF(le.Input_schoolcode))'','',':schoolcode')
    #END
 
+    #IF( #TEXT(Input_source_voterid)='' )
      '' 
    #ELSE
        IF( le.Input_source_voterid = (TYPEOF(le.Input_source_voterid))'','',':source_voterid')
    #END
 
+    #IF( #TEXT(Input_statehouse)='' )
      '' 
    #ELSE
        IF( le.Input_statehouse = (TYPEOF(le.Input_statehouse))'','',':statehouse')
    #END
 
+    #IF( #TEXT(Input_statesenate)='' )
      '' 
    #ELSE
        IF( le.Input_statesenate = (TYPEOF(le.Input_statesenate))'','',':statesenate')
    #END
 
+    #IF( #TEXT(Input_state_code)='' )
      '' 
    #ELSE
        IF( le.Input_state_code = (TYPEOF(le.Input_state_code))'','',':state_code')
    #END
 
+    #IF( #TEXT(Input_timezonetbl)='' )
      '' 
    #ELSE
        IF( le.Input_timezonetbl = (TYPEOF(le.Input_timezonetbl))'','',':timezonetbl')
    #END
 
+    #IF( #TEXT(Input_ushouse)='' )
      '' 
    #ELSE
        IF( le.Input_ushouse = (TYPEOF(le.Input_ushouse))'','',':ushouse')
    #END
 
+    #IF( #TEXT(Input_voter_status)='' )
      '' 
    #ELSE
        IF( le.Input_voter_status = (TYPEOF(le.Input_voter_status))'','',':voter_status')
    #END
 
+    #IF( #TEXT(Input_work_phone)='' )
      '' 
    #ELSE
        IF( le.Input_work_phone = (TYPEOF(le.Input_work_phone))'','',':work_phone')
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
