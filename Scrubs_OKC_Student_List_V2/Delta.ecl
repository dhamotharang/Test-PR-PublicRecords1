IMPORT SALT311,STD;
EXPORT Delta(DATASET(Layout_OKC_Student_List)old_s, DATASET(Layout_OKC_Student_List) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['cleanaddr1','cleanaddr2','cleanattendancedte','cleancity','cleanstate','cleanzip','cleanzip4','cleanfulladdr','cleandob','cleanupdatedte','cleanemail','append_email_username','append_domain','append_domain_type','append_domain_root','append_domain_ext','append_is_tld_state','append_is_tld_generic','append_is_tld_country','append_is_valid_domain_ext','cleantitle','cleanfirstname','cleanmidname','cleanlastname','cleansuffixname','cleanmajor','cleanphone','did','process_date','date_first_seen','date_last_seen','date_vendor_first_reported','date_vendor_last_reported','dateadded','dateupdated','studentid','dartid','collegeid','projectsource','collegestate','college','semester','year','firstname','middlename','lastname','suffix','major','grade','email','dateofbirth','dob_formatted','attendancedate','enrollmentstatus','addresstype','address_1','address_2','city','state','z5','z4','phonetyp','phonenumber','tier','school_size_code','competitive_code','tuition_code','title','fname','mname','lname','name_suffix','name_score','rawaid','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','rec_type','county','fips_state','fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','telephone','tier2','source','key','ssn','historical_flag','full_name','college_class','college_name','ln_college_name','college_major','new_college_major','college_code','college_code_exploded','college_type','college_type_exploded','file_type','collegeupdate'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary(BOOLEAN Glob = TRUE) := hygiene(old_s).Summary('Old',Glob) + hygiene(new_s).Summary('New',Glob) + hygiene(PROJECT(Differences(deleted), TRANSFORM(Layout_OKC_Student_List, SELF := LEFT.old_rec))).Summary('Deletions',Glob) + hygiene(PROJECT(Differences(added), TRANSFORM(Layout_OKC_Student_List, SELF := LEFT.new_rec))).Summary('Additions',Glob);
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE, BOOLEAN doHygieneSummaryPerSrc = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary(TRUE);
    hygieneDiffPerSrc := DifferenceSummary(FALSE);
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_OKC_Student_List_V2, Fields, 'RECORDOF(hygieneDiffOverall)', TRUE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
    hygieneDiffPerSrc_Standard := IF(doHygieneSummaryPerSrc, NORMALIZE(hygieneDiffPerSrc, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_src', LEFT.txt + '_src')));
 
    RETURN hygieneDiffOverall_Standard & hygieneDiffPerSrc_Standard;
  END;
END;
