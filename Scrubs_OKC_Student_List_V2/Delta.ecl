IMPORT SALT311,STD;
EXPORT Delta(DATASET(Layout_OKC_Student_List)old_s, DATASET(Layout_OKC_Student_List) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['cleanaddr1','cleanaddr2','cleanattendancedte','cleancity','cleanstate','cleandob','cleanupdatedte','cleanemail','append_email_username','append_domain','append_domain_type','append_domain_root','append_domain_ext','append_is_tld_state','append_is_tld_generic','append_is_tld_country','append_is_valid_domain_ext','cleancollegeId','cleantitle','cleanfirstname','cleanmidname','cleanlastname','cleansuffixname','cleanzip','cleanzip4','cleanmajor','cleanphone','rcid','did','process_date','date_first_seen','date_last_seen','vendor_first_reported','vendor_last_reported','dateupdated','studentid','dartid','collegeid','projectsource','collegestate','college','semester','year','firstname','middlename','lastname','suffix','major','COLLEGE_MAJOR','NEW_COLLEGE_MAJOR','grade','email','dateofbirth','dob_formatted','attendancedate','enrollmentstatus','addresstype','address1','address2','city','state','zip','zip4','phonetyp','phonenumber','tier','school_size_code','competitive_code','tuition_code','title','fname','mname','lname','name_suffix','name_score','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','z5','z4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','county','fips_state','fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','telephone','tier2','source'];
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
