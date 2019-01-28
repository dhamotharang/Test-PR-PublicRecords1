IMPORT SALT311,STD;
EXPORT hygiene(dataset(layout_OKC_Student_List) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt,BOOLEAN Glob=TRUE) := FUNCTION
  SummaryLayout := RECORD
    txt;
    Source := IF(Glob, (TYPEOF(h.cleancollegeid))'', MAX(GROUP,h.cleancollegeid));
    NumberOfRecords := COUNT(GROUP);
    populated_cleanaddr1_cnt := COUNT(GROUP,h.cleanaddr1 <> (TYPEOF(h.cleanaddr1))'');
    populated_cleanaddr1_pcnt := AVE(GROUP,IF(h.cleanaddr1 = (TYPEOF(h.cleanaddr1))'',0,100));
    maxlength_cleanaddr1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cleanaddr1)));
    avelength_cleanaddr1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cleanaddr1)),h.cleanaddr1<>(typeof(h.cleanaddr1))'');
    populated_cleanaddr2_cnt := COUNT(GROUP,h.cleanaddr2 <> (TYPEOF(h.cleanaddr2))'');
    populated_cleanaddr2_pcnt := AVE(GROUP,IF(h.cleanaddr2 = (TYPEOF(h.cleanaddr2))'',0,100));
    maxlength_cleanaddr2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cleanaddr2)));
    avelength_cleanaddr2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cleanaddr2)),h.cleanaddr2<>(typeof(h.cleanaddr2))'');
    populated_cleanattendancedte_cnt := COUNT(GROUP,h.cleanattendancedte <> (TYPEOF(h.cleanattendancedte))'');
    populated_cleanattendancedte_pcnt := AVE(GROUP,IF(h.cleanattendancedte = (TYPEOF(h.cleanattendancedte))'',0,100));
    maxlength_cleanattendancedte := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cleanattendancedte)));
    avelength_cleanattendancedte := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cleanattendancedte)),h.cleanattendancedte<>(typeof(h.cleanattendancedte))'');
    populated_cleancity_cnt := COUNT(GROUP,h.cleancity <> (TYPEOF(h.cleancity))'');
    populated_cleancity_pcnt := AVE(GROUP,IF(h.cleancity = (TYPEOF(h.cleancity))'',0,100));
    maxlength_cleancity := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cleancity)));
    avelength_cleancity := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cleancity)),h.cleancity<>(typeof(h.cleancity))'');
    populated_cleanstate_cnt := COUNT(GROUP,h.cleanstate <> (TYPEOF(h.cleanstate))'');
    populated_cleanstate_pcnt := AVE(GROUP,IF(h.cleanstate = (TYPEOF(h.cleanstate))'',0,100));
    maxlength_cleanstate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cleanstate)));
    avelength_cleanstate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cleanstate)),h.cleanstate<>(typeof(h.cleanstate))'');
    populated_cleandob_cnt := COUNT(GROUP,h.cleandob <> (TYPEOF(h.cleandob))'');
    populated_cleandob_pcnt := AVE(GROUP,IF(h.cleandob = (TYPEOF(h.cleandob))'',0,100));
    maxlength_cleandob := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cleandob)));
    avelength_cleandob := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cleandob)),h.cleandob<>(typeof(h.cleandob))'');
    populated_cleanupdatedte_cnt := COUNT(GROUP,h.cleanupdatedte <> (TYPEOF(h.cleanupdatedte))'');
    populated_cleanupdatedte_pcnt := AVE(GROUP,IF(h.cleanupdatedte = (TYPEOF(h.cleanupdatedte))'',0,100));
    maxlength_cleanupdatedte := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cleanupdatedte)));
    avelength_cleanupdatedte := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cleanupdatedte)),h.cleanupdatedte<>(typeof(h.cleanupdatedte))'');
    populated_cleanemail_cnt := COUNT(GROUP,h.cleanemail <> (TYPEOF(h.cleanemail))'');
    populated_cleanemail_pcnt := AVE(GROUP,IF(h.cleanemail = (TYPEOF(h.cleanemail))'',0,100));
    maxlength_cleanemail := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cleanemail)));
    avelength_cleanemail := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cleanemail)),h.cleanemail<>(typeof(h.cleanemail))'');
    populated_append_email_username_cnt := COUNT(GROUP,h.append_email_username <> (TYPEOF(h.append_email_username))'');
    populated_append_email_username_pcnt := AVE(GROUP,IF(h.append_email_username = (TYPEOF(h.append_email_username))'',0,100));
    maxlength_append_email_username := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_email_username)));
    avelength_append_email_username := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_email_username)),h.append_email_username<>(typeof(h.append_email_username))'');
    populated_append_domain_cnt := COUNT(GROUP,h.append_domain <> (TYPEOF(h.append_domain))'');
    populated_append_domain_pcnt := AVE(GROUP,IF(h.append_domain = (TYPEOF(h.append_domain))'',0,100));
    maxlength_append_domain := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_domain)));
    avelength_append_domain := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_domain)),h.append_domain<>(typeof(h.append_domain))'');
    populated_append_domain_type_cnt := COUNT(GROUP,h.append_domain_type <> (TYPEOF(h.append_domain_type))'');
    populated_append_domain_type_pcnt := AVE(GROUP,IF(h.append_domain_type = (TYPEOF(h.append_domain_type))'',0,100));
    maxlength_append_domain_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_domain_type)));
    avelength_append_domain_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_domain_type)),h.append_domain_type<>(typeof(h.append_domain_type))'');
    populated_append_domain_root_cnt := COUNT(GROUP,h.append_domain_root <> (TYPEOF(h.append_domain_root))'');
    populated_append_domain_root_pcnt := AVE(GROUP,IF(h.append_domain_root = (TYPEOF(h.append_domain_root))'',0,100));
    maxlength_append_domain_root := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_domain_root)));
    avelength_append_domain_root := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_domain_root)),h.append_domain_root<>(typeof(h.append_domain_root))'');
    populated_append_domain_ext_cnt := COUNT(GROUP,h.append_domain_ext <> (TYPEOF(h.append_domain_ext))'');
    populated_append_domain_ext_pcnt := AVE(GROUP,IF(h.append_domain_ext = (TYPEOF(h.append_domain_ext))'',0,100));
    maxlength_append_domain_ext := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_domain_ext)));
    avelength_append_domain_ext := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_domain_ext)),h.append_domain_ext<>(typeof(h.append_domain_ext))'');
    populated_append_is_tld_state_cnt := COUNT(GROUP,h.append_is_tld_state <> (TYPEOF(h.append_is_tld_state))'');
    populated_append_is_tld_state_pcnt := AVE(GROUP,IF(h.append_is_tld_state = (TYPEOF(h.append_is_tld_state))'',0,100));
    maxlength_append_is_tld_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_is_tld_state)));
    avelength_append_is_tld_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_is_tld_state)),h.append_is_tld_state<>(typeof(h.append_is_tld_state))'');
    populated_append_is_tld_generic_cnt := COUNT(GROUP,h.append_is_tld_generic <> (TYPEOF(h.append_is_tld_generic))'');
    populated_append_is_tld_generic_pcnt := AVE(GROUP,IF(h.append_is_tld_generic = (TYPEOF(h.append_is_tld_generic))'',0,100));
    maxlength_append_is_tld_generic := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_is_tld_generic)));
    avelength_append_is_tld_generic := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_is_tld_generic)),h.append_is_tld_generic<>(typeof(h.append_is_tld_generic))'');
    populated_append_is_tld_country_cnt := COUNT(GROUP,h.append_is_tld_country <> (TYPEOF(h.append_is_tld_country))'');
    populated_append_is_tld_country_pcnt := AVE(GROUP,IF(h.append_is_tld_country = (TYPEOF(h.append_is_tld_country))'',0,100));
    maxlength_append_is_tld_country := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_is_tld_country)));
    avelength_append_is_tld_country := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_is_tld_country)),h.append_is_tld_country<>(typeof(h.append_is_tld_country))'');
    populated_append_is_valid_domain_ext_cnt := COUNT(GROUP,h.append_is_valid_domain_ext <> (TYPEOF(h.append_is_valid_domain_ext))'');
    populated_append_is_valid_domain_ext_pcnt := AVE(GROUP,IF(h.append_is_valid_domain_ext = (TYPEOF(h.append_is_valid_domain_ext))'',0,100));
    maxlength_append_is_valid_domain_ext := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_is_valid_domain_ext)));
    avelength_append_is_valid_domain_ext := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_is_valid_domain_ext)),h.append_is_valid_domain_ext<>(typeof(h.append_is_valid_domain_ext))'');
    populated_cleancollegeId_cnt := COUNT(GROUP,h.cleancollegeId <> (TYPEOF(h.cleancollegeId))'');
    populated_cleancollegeId_pcnt := AVE(GROUP,IF(h.cleancollegeId = (TYPEOF(h.cleancollegeId))'',0,100));
    maxlength_cleancollegeId := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cleancollegeId)));
    avelength_cleancollegeId := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cleancollegeId)),h.cleancollegeId<>(typeof(h.cleancollegeId))'');
    populated_cleantitle_cnt := COUNT(GROUP,h.cleantitle <> (TYPEOF(h.cleantitle))'');
    populated_cleantitle_pcnt := AVE(GROUP,IF(h.cleantitle = (TYPEOF(h.cleantitle))'',0,100));
    maxlength_cleantitle := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cleantitle)));
    avelength_cleantitle := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cleantitle)),h.cleantitle<>(typeof(h.cleantitle))'');
    populated_cleanfirstname_cnt := COUNT(GROUP,h.cleanfirstname <> (TYPEOF(h.cleanfirstname))'');
    populated_cleanfirstname_pcnt := AVE(GROUP,IF(h.cleanfirstname = (TYPEOF(h.cleanfirstname))'',0,100));
    maxlength_cleanfirstname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cleanfirstname)));
    avelength_cleanfirstname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cleanfirstname)),h.cleanfirstname<>(typeof(h.cleanfirstname))'');
    populated_cleanmidname_cnt := COUNT(GROUP,h.cleanmidname <> (TYPEOF(h.cleanmidname))'');
    populated_cleanmidname_pcnt := AVE(GROUP,IF(h.cleanmidname = (TYPEOF(h.cleanmidname))'',0,100));
    maxlength_cleanmidname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cleanmidname)));
    avelength_cleanmidname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cleanmidname)),h.cleanmidname<>(typeof(h.cleanmidname))'');
    populated_cleanlastname_cnt := COUNT(GROUP,h.cleanlastname <> (TYPEOF(h.cleanlastname))'');
    populated_cleanlastname_pcnt := AVE(GROUP,IF(h.cleanlastname = (TYPEOF(h.cleanlastname))'',0,100));
    maxlength_cleanlastname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cleanlastname)));
    avelength_cleanlastname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cleanlastname)),h.cleanlastname<>(typeof(h.cleanlastname))'');
    populated_cleansuffixname_cnt := COUNT(GROUP,h.cleansuffixname <> (TYPEOF(h.cleansuffixname))'');
    populated_cleansuffixname_pcnt := AVE(GROUP,IF(h.cleansuffixname = (TYPEOF(h.cleansuffixname))'',0,100));
    maxlength_cleansuffixname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cleansuffixname)));
    avelength_cleansuffixname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cleansuffixname)),h.cleansuffixname<>(typeof(h.cleansuffixname))'');
    populated_cleanzip_cnt := COUNT(GROUP,h.cleanzip <> (TYPEOF(h.cleanzip))'');
    populated_cleanzip_pcnt := AVE(GROUP,IF(h.cleanzip = (TYPEOF(h.cleanzip))'',0,100));
    maxlength_cleanzip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cleanzip)));
    avelength_cleanzip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cleanzip)),h.cleanzip<>(typeof(h.cleanzip))'');
    populated_cleanzip4_cnt := COUNT(GROUP,h.cleanzip4 <> (TYPEOF(h.cleanzip4))'');
    populated_cleanzip4_pcnt := AVE(GROUP,IF(h.cleanzip4 = (TYPEOF(h.cleanzip4))'',0,100));
    maxlength_cleanzip4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cleanzip4)));
    avelength_cleanzip4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cleanzip4)),h.cleanzip4<>(typeof(h.cleanzip4))'');
    populated_cleanmajor_cnt := COUNT(GROUP,h.cleanmajor <> (TYPEOF(h.cleanmajor))'');
    populated_cleanmajor_pcnt := AVE(GROUP,IF(h.cleanmajor = (TYPEOF(h.cleanmajor))'',0,100));
    maxlength_cleanmajor := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cleanmajor)));
    avelength_cleanmajor := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cleanmajor)),h.cleanmajor<>(typeof(h.cleanmajor))'');
    populated_cleanphone_cnt := COUNT(GROUP,h.cleanphone <> (TYPEOF(h.cleanphone))'');
    populated_cleanphone_pcnt := AVE(GROUP,IF(h.cleanphone = (TYPEOF(h.cleanphone))'',0,100));
    maxlength_cleanphone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cleanphone)));
    avelength_cleanphone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cleanphone)),h.cleanphone<>(typeof(h.cleanphone))'');
    populated_rcid_cnt := COUNT(GROUP,h.rcid <> (TYPEOF(h.rcid))'');
    populated_rcid_pcnt := AVE(GROUP,IF(h.rcid = (TYPEOF(h.rcid))'',0,100));
    maxlength_rcid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rcid)));
    avelength_rcid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rcid)),h.rcid<>(typeof(h.rcid))'');
    populated_did_cnt := COUNT(GROUP,h.did <> (TYPEOF(h.did))'');
    populated_did_pcnt := AVE(GROUP,IF(h.did = (TYPEOF(h.did))'',0,100));
    maxlength_did := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.did)));
    avelength_did := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.did)),h.did<>(typeof(h.did))'');
    populated_process_date_cnt := COUNT(GROUP,h.process_date <> (TYPEOF(h.process_date))'');
    populated_process_date_pcnt := AVE(GROUP,IF(h.process_date = (TYPEOF(h.process_date))'',0,100));
    maxlength_process_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.process_date)));
    avelength_process_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.process_date)),h.process_date<>(typeof(h.process_date))'');
    populated_date_first_seen_cnt := COUNT(GROUP,h.date_first_seen <> (TYPEOF(h.date_first_seen))'');
    populated_date_first_seen_pcnt := AVE(GROUP,IF(h.date_first_seen = (TYPEOF(h.date_first_seen))'',0,100));
    maxlength_date_first_seen := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_first_seen)));
    avelength_date_first_seen := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_first_seen)),h.date_first_seen<>(typeof(h.date_first_seen))'');
    populated_date_last_seen_cnt := COUNT(GROUP,h.date_last_seen <> (TYPEOF(h.date_last_seen))'');
    populated_date_last_seen_pcnt := AVE(GROUP,IF(h.date_last_seen = (TYPEOF(h.date_last_seen))'',0,100));
    maxlength_date_last_seen := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_last_seen)));
    avelength_date_last_seen := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_last_seen)),h.date_last_seen<>(typeof(h.date_last_seen))'');
    populated_vendor_first_reported_cnt := COUNT(GROUP,h.vendor_first_reported <> (TYPEOF(h.vendor_first_reported))'');
    populated_vendor_first_reported_pcnt := AVE(GROUP,IF(h.vendor_first_reported = (TYPEOF(h.vendor_first_reported))'',0,100));
    maxlength_vendor_first_reported := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.vendor_first_reported)));
    avelength_vendor_first_reported := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.vendor_first_reported)),h.vendor_first_reported<>(typeof(h.vendor_first_reported))'');
    populated_vendor_last_reported_cnt := COUNT(GROUP,h.vendor_last_reported <> (TYPEOF(h.vendor_last_reported))'');
    populated_vendor_last_reported_pcnt := AVE(GROUP,IF(h.vendor_last_reported = (TYPEOF(h.vendor_last_reported))'',0,100));
    maxlength_vendor_last_reported := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.vendor_last_reported)));
    avelength_vendor_last_reported := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.vendor_last_reported)),h.vendor_last_reported<>(typeof(h.vendor_last_reported))'');
    populated_dateupdated_cnt := COUNT(GROUP,h.dateupdated <> (TYPEOF(h.dateupdated))'');
    populated_dateupdated_pcnt := AVE(GROUP,IF(h.dateupdated = (TYPEOF(h.dateupdated))'',0,100));
    maxlength_dateupdated := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dateupdated)));
    avelength_dateupdated := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dateupdated)),h.dateupdated<>(typeof(h.dateupdated))'');
    populated_studentid_cnt := COUNT(GROUP,h.studentid <> (TYPEOF(h.studentid))'');
    populated_studentid_pcnt := AVE(GROUP,IF(h.studentid = (TYPEOF(h.studentid))'',0,100));
    maxlength_studentid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.studentid)));
    avelength_studentid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.studentid)),h.studentid<>(typeof(h.studentid))'');
    populated_dartid_cnt := COUNT(GROUP,h.dartid <> (TYPEOF(h.dartid))'');
    populated_dartid_pcnt := AVE(GROUP,IF(h.dartid = (TYPEOF(h.dartid))'',0,100));
    maxlength_dartid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dartid)));
    avelength_dartid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dartid)),h.dartid<>(typeof(h.dartid))'');
    populated_collegeid_cnt := COUNT(GROUP,h.collegeid <> (TYPEOF(h.collegeid))'');
    populated_collegeid_pcnt := AVE(GROUP,IF(h.collegeid = (TYPEOF(h.collegeid))'',0,100));
    maxlength_collegeid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.collegeid)));
    avelength_collegeid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.collegeid)),h.collegeid<>(typeof(h.collegeid))'');
    populated_projectsource_cnt := COUNT(GROUP,h.projectsource <> (TYPEOF(h.projectsource))'');
    populated_projectsource_pcnt := AVE(GROUP,IF(h.projectsource = (TYPEOF(h.projectsource))'',0,100));
    maxlength_projectsource := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.projectsource)));
    avelength_projectsource := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.projectsource)),h.projectsource<>(typeof(h.projectsource))'');
    populated_collegestate_cnt := COUNT(GROUP,h.collegestate <> (TYPEOF(h.collegestate))'');
    populated_collegestate_pcnt := AVE(GROUP,IF(h.collegestate = (TYPEOF(h.collegestate))'',0,100));
    maxlength_collegestate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.collegestate)));
    avelength_collegestate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.collegestate)),h.collegestate<>(typeof(h.collegestate))'');
    populated_college_cnt := COUNT(GROUP,h.college <> (TYPEOF(h.college))'');
    populated_college_pcnt := AVE(GROUP,IF(h.college = (TYPEOF(h.college))'',0,100));
    maxlength_college := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.college)));
    avelength_college := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.college)),h.college<>(typeof(h.college))'');
    populated_semester_cnt := COUNT(GROUP,h.semester <> (TYPEOF(h.semester))'');
    populated_semester_pcnt := AVE(GROUP,IF(h.semester = (TYPEOF(h.semester))'',0,100));
    maxlength_semester := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.semester)));
    avelength_semester := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.semester)),h.semester<>(typeof(h.semester))'');
    populated_year_cnt := COUNT(GROUP,h.year <> (TYPEOF(h.year))'');
    populated_year_pcnt := AVE(GROUP,IF(h.year = (TYPEOF(h.year))'',0,100));
    maxlength_year := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.year)));
    avelength_year := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.year)),h.year<>(typeof(h.year))'');
    populated_firstname_cnt := COUNT(GROUP,h.firstname <> (TYPEOF(h.firstname))'');
    populated_firstname_pcnt := AVE(GROUP,IF(h.firstname = (TYPEOF(h.firstname))'',0,100));
    maxlength_firstname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.firstname)));
    avelength_firstname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.firstname)),h.firstname<>(typeof(h.firstname))'');
    populated_middlename_cnt := COUNT(GROUP,h.middlename <> (TYPEOF(h.middlename))'');
    populated_middlename_pcnt := AVE(GROUP,IF(h.middlename = (TYPEOF(h.middlename))'',0,100));
    maxlength_middlename := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.middlename)));
    avelength_middlename := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.middlename)),h.middlename<>(typeof(h.middlename))'');
    populated_lastname_cnt := COUNT(GROUP,h.lastname <> (TYPEOF(h.lastname))'');
    populated_lastname_pcnt := AVE(GROUP,IF(h.lastname = (TYPEOF(h.lastname))'',0,100));
    maxlength_lastname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lastname)));
    avelength_lastname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lastname)),h.lastname<>(typeof(h.lastname))'');
    populated_suffix_cnt := COUNT(GROUP,h.suffix <> (TYPEOF(h.suffix))'');
    populated_suffix_pcnt := AVE(GROUP,IF(h.suffix = (TYPEOF(h.suffix))'',0,100));
    maxlength_suffix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.suffix)));
    avelength_suffix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.suffix)),h.suffix<>(typeof(h.suffix))'');
    populated_major_cnt := COUNT(GROUP,h.major <> (TYPEOF(h.major))'');
    populated_major_pcnt := AVE(GROUP,IF(h.major = (TYPEOF(h.major))'',0,100));
    maxlength_major := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.major)));
    avelength_major := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.major)),h.major<>(typeof(h.major))'');
    populated_COLLEGE_MAJOR_cnt := COUNT(GROUP,h.COLLEGE_MAJOR <> (TYPEOF(h.COLLEGE_MAJOR))'');
    populated_COLLEGE_MAJOR_pcnt := AVE(GROUP,IF(h.COLLEGE_MAJOR = (TYPEOF(h.COLLEGE_MAJOR))'',0,100));
    maxlength_COLLEGE_MAJOR := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.COLLEGE_MAJOR)));
    avelength_COLLEGE_MAJOR := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.COLLEGE_MAJOR)),h.COLLEGE_MAJOR<>(typeof(h.COLLEGE_MAJOR))'');
    populated_NEW_COLLEGE_MAJOR_cnt := COUNT(GROUP,h.NEW_COLLEGE_MAJOR <> (TYPEOF(h.NEW_COLLEGE_MAJOR))'');
    populated_NEW_COLLEGE_MAJOR_pcnt := AVE(GROUP,IF(h.NEW_COLLEGE_MAJOR = (TYPEOF(h.NEW_COLLEGE_MAJOR))'',0,100));
    maxlength_NEW_COLLEGE_MAJOR := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.NEW_COLLEGE_MAJOR)));
    avelength_NEW_COLLEGE_MAJOR := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.NEW_COLLEGE_MAJOR)),h.NEW_COLLEGE_MAJOR<>(typeof(h.NEW_COLLEGE_MAJOR))'');
    populated_grade_cnt := COUNT(GROUP,h.grade <> (TYPEOF(h.grade))'');
    populated_grade_pcnt := AVE(GROUP,IF(h.grade = (TYPEOF(h.grade))'',0,100));
    maxlength_grade := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.grade)));
    avelength_grade := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.grade)),h.grade<>(typeof(h.grade))'');
    populated_email_cnt := COUNT(GROUP,h.email <> (TYPEOF(h.email))'');
    populated_email_pcnt := AVE(GROUP,IF(h.email = (TYPEOF(h.email))'',0,100));
    maxlength_email := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.email)));
    avelength_email := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.email)),h.email<>(typeof(h.email))'');
    populated_dateofbirth_cnt := COUNT(GROUP,h.dateofbirth <> (TYPEOF(h.dateofbirth))'');
    populated_dateofbirth_pcnt := AVE(GROUP,IF(h.dateofbirth = (TYPEOF(h.dateofbirth))'',0,100));
    maxlength_dateofbirth := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dateofbirth)));
    avelength_dateofbirth := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dateofbirth)),h.dateofbirth<>(typeof(h.dateofbirth))'');
    populated_dob_formatted_cnt := COUNT(GROUP,h.dob_formatted <> (TYPEOF(h.dob_formatted))'');
    populated_dob_formatted_pcnt := AVE(GROUP,IF(h.dob_formatted = (TYPEOF(h.dob_formatted))'',0,100));
    maxlength_dob_formatted := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dob_formatted)));
    avelength_dob_formatted := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dob_formatted)),h.dob_formatted<>(typeof(h.dob_formatted))'');
    populated_attendancedate_cnt := COUNT(GROUP,h.attendancedate <> (TYPEOF(h.attendancedate))'');
    populated_attendancedate_pcnt := AVE(GROUP,IF(h.attendancedate = (TYPEOF(h.attendancedate))'',0,100));
    maxlength_attendancedate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.attendancedate)));
    avelength_attendancedate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.attendancedate)),h.attendancedate<>(typeof(h.attendancedate))'');
    populated_enrollmentstatus_cnt := COUNT(GROUP,h.enrollmentstatus <> (TYPEOF(h.enrollmentstatus))'');
    populated_enrollmentstatus_pcnt := AVE(GROUP,IF(h.enrollmentstatus = (TYPEOF(h.enrollmentstatus))'',0,100));
    maxlength_enrollmentstatus := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.enrollmentstatus)));
    avelength_enrollmentstatus := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.enrollmentstatus)),h.enrollmentstatus<>(typeof(h.enrollmentstatus))'');
    populated_addresstype_cnt := COUNT(GROUP,h.addresstype <> (TYPEOF(h.addresstype))'');
    populated_addresstype_pcnt := AVE(GROUP,IF(h.addresstype = (TYPEOF(h.addresstype))'',0,100));
    maxlength_addresstype := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.addresstype)));
    avelength_addresstype := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.addresstype)),h.addresstype<>(typeof(h.addresstype))'');
    populated_address1_cnt := COUNT(GROUP,h.address1 <> (TYPEOF(h.address1))'');
    populated_address1_pcnt := AVE(GROUP,IF(h.address1 = (TYPEOF(h.address1))'',0,100));
    maxlength_address1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.address1)));
    avelength_address1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.address1)),h.address1<>(typeof(h.address1))'');
    populated_address2_cnt := COUNT(GROUP,h.address2 <> (TYPEOF(h.address2))'');
    populated_address2_pcnt := AVE(GROUP,IF(h.address2 = (TYPEOF(h.address2))'',0,100));
    maxlength_address2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.address2)));
    avelength_address2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.address2)),h.address2<>(typeof(h.address2))'');
    populated_city_cnt := COUNT(GROUP,h.city <> (TYPEOF(h.city))'');
    populated_city_pcnt := AVE(GROUP,IF(h.city = (TYPEOF(h.city))'',0,100));
    maxlength_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.city)));
    avelength_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.city)),h.city<>(typeof(h.city))'');
    populated_state_cnt := COUNT(GROUP,h.state <> (TYPEOF(h.state))'');
    populated_state_pcnt := AVE(GROUP,IF(h.state = (TYPEOF(h.state))'',0,100));
    maxlength_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.state)));
    avelength_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.state)),h.state<>(typeof(h.state))'');
    populated_zip_cnt := COUNT(GROUP,h.zip <> (TYPEOF(h.zip))'');
    populated_zip_pcnt := AVE(GROUP,IF(h.zip = (TYPEOF(h.zip))'',0,100));
    maxlength_zip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip)));
    avelength_zip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip)),h.zip<>(typeof(h.zip))'');
    populated_zip4_cnt := COUNT(GROUP,h.zip4 <> (TYPEOF(h.zip4))'');
    populated_zip4_pcnt := AVE(GROUP,IF(h.zip4 = (TYPEOF(h.zip4))'',0,100));
    maxlength_zip4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip4)));
    avelength_zip4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip4)),h.zip4<>(typeof(h.zip4))'');
    populated_phonetyp_cnt := COUNT(GROUP,h.phonetyp <> (TYPEOF(h.phonetyp))'');
    populated_phonetyp_pcnt := AVE(GROUP,IF(h.phonetyp = (TYPEOF(h.phonetyp))'',0,100));
    maxlength_phonetyp := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.phonetyp)));
    avelength_phonetyp := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.phonetyp)),h.phonetyp<>(typeof(h.phonetyp))'');
    populated_phonenumber_cnt := COUNT(GROUP,h.phonenumber <> (TYPEOF(h.phonenumber))'');
    populated_phonenumber_pcnt := AVE(GROUP,IF(h.phonenumber = (TYPEOF(h.phonenumber))'',0,100));
    maxlength_phonenumber := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.phonenumber)));
    avelength_phonenumber := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.phonenumber)),h.phonenumber<>(typeof(h.phonenumber))'');
    populated_tier_cnt := COUNT(GROUP,h.tier <> (TYPEOF(h.tier))'');
    populated_tier_pcnt := AVE(GROUP,IF(h.tier = (TYPEOF(h.tier))'',0,100));
    maxlength_tier := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tier)));
    avelength_tier := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tier)),h.tier<>(typeof(h.tier))'');
    populated_school_size_code_cnt := COUNT(GROUP,h.school_size_code <> (TYPEOF(h.school_size_code))'');
    populated_school_size_code_pcnt := AVE(GROUP,IF(h.school_size_code = (TYPEOF(h.school_size_code))'',0,100));
    maxlength_school_size_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.school_size_code)));
    avelength_school_size_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.school_size_code)),h.school_size_code<>(typeof(h.school_size_code))'');
    populated_competitive_code_cnt := COUNT(GROUP,h.competitive_code <> (TYPEOF(h.competitive_code))'');
    populated_competitive_code_pcnt := AVE(GROUP,IF(h.competitive_code = (TYPEOF(h.competitive_code))'',0,100));
    maxlength_competitive_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.competitive_code)));
    avelength_competitive_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.competitive_code)),h.competitive_code<>(typeof(h.competitive_code))'');
    populated_tuition_code_cnt := COUNT(GROUP,h.tuition_code <> (TYPEOF(h.tuition_code))'');
    populated_tuition_code_pcnt := AVE(GROUP,IF(h.tuition_code = (TYPEOF(h.tuition_code))'',0,100));
    maxlength_tuition_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tuition_code)));
    avelength_tuition_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tuition_code)),h.tuition_code<>(typeof(h.tuition_code))'');
    populated_title_cnt := COUNT(GROUP,h.title <> (TYPEOF(h.title))'');
    populated_title_pcnt := AVE(GROUP,IF(h.title = (TYPEOF(h.title))'',0,100));
    maxlength_title := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.title)));
    avelength_title := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.title)),h.title<>(typeof(h.title))'');
    populated_fname_cnt := COUNT(GROUP,h.fname <> (TYPEOF(h.fname))'');
    populated_fname_pcnt := AVE(GROUP,IF(h.fname = (TYPEOF(h.fname))'',0,100));
    maxlength_fname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fname)));
    avelength_fname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fname)),h.fname<>(typeof(h.fname))'');
    populated_mname_cnt := COUNT(GROUP,h.mname <> (TYPEOF(h.mname))'');
    populated_mname_pcnt := AVE(GROUP,IF(h.mname = (TYPEOF(h.mname))'',0,100));
    maxlength_mname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mname)));
    avelength_mname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mname)),h.mname<>(typeof(h.mname))'');
    populated_lname_cnt := COUNT(GROUP,h.lname <> (TYPEOF(h.lname))'');
    populated_lname_pcnt := AVE(GROUP,IF(h.lname = (TYPEOF(h.lname))'',0,100));
    maxlength_lname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lname)));
    avelength_lname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lname)),h.lname<>(typeof(h.lname))'');
    populated_name_suffix_cnt := COUNT(GROUP,h.name_suffix <> (TYPEOF(h.name_suffix))'');
    populated_name_suffix_pcnt := AVE(GROUP,IF(h.name_suffix = (TYPEOF(h.name_suffix))'',0,100));
    maxlength_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_suffix)));
    avelength_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_suffix)),h.name_suffix<>(typeof(h.name_suffix))'');
    populated_name_score_cnt := COUNT(GROUP,h.name_score <> (TYPEOF(h.name_score))'');
    populated_name_score_pcnt := AVE(GROUP,IF(h.name_score = (TYPEOF(h.name_score))'',0,100));
    maxlength_name_score := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_score)));
    avelength_name_score := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_score)),h.name_score<>(typeof(h.name_score))'');
    populated_prim_range_cnt := COUNT(GROUP,h.prim_range <> (TYPEOF(h.prim_range))'');
    populated_prim_range_pcnt := AVE(GROUP,IF(h.prim_range = (TYPEOF(h.prim_range))'',0,100));
    maxlength_prim_range := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_range)));
    avelength_prim_range := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_range)),h.prim_range<>(typeof(h.prim_range))'');
    populated_predir_cnt := COUNT(GROUP,h.predir <> (TYPEOF(h.predir))'');
    populated_predir_pcnt := AVE(GROUP,IF(h.predir = (TYPEOF(h.predir))'',0,100));
    maxlength_predir := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.predir)));
    avelength_predir := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.predir)),h.predir<>(typeof(h.predir))'');
    populated_prim_name_cnt := COUNT(GROUP,h.prim_name <> (TYPEOF(h.prim_name))'');
    populated_prim_name_pcnt := AVE(GROUP,IF(h.prim_name = (TYPEOF(h.prim_name))'',0,100));
    maxlength_prim_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_name)));
    avelength_prim_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_name)),h.prim_name<>(typeof(h.prim_name))'');
    populated_addr_suffix_cnt := COUNT(GROUP,h.addr_suffix <> (TYPEOF(h.addr_suffix))'');
    populated_addr_suffix_pcnt := AVE(GROUP,IF(h.addr_suffix = (TYPEOF(h.addr_suffix))'',0,100));
    maxlength_addr_suffix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.addr_suffix)));
    avelength_addr_suffix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.addr_suffix)),h.addr_suffix<>(typeof(h.addr_suffix))'');
    populated_postdir_cnt := COUNT(GROUP,h.postdir <> (TYPEOF(h.postdir))'');
    populated_postdir_pcnt := AVE(GROUP,IF(h.postdir = (TYPEOF(h.postdir))'',0,100));
    maxlength_postdir := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.postdir)));
    avelength_postdir := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.postdir)),h.postdir<>(typeof(h.postdir))'');
    populated_unit_desig_cnt := COUNT(GROUP,h.unit_desig <> (TYPEOF(h.unit_desig))'');
    populated_unit_desig_pcnt := AVE(GROUP,IF(h.unit_desig = (TYPEOF(h.unit_desig))'',0,100));
    maxlength_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.unit_desig)));
    avelength_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.unit_desig)),h.unit_desig<>(typeof(h.unit_desig))'');
    populated_sec_range_cnt := COUNT(GROUP,h.sec_range <> (TYPEOF(h.sec_range))'');
    populated_sec_range_pcnt := AVE(GROUP,IF(h.sec_range = (TYPEOF(h.sec_range))'',0,100));
    maxlength_sec_range := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sec_range)));
    avelength_sec_range := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sec_range)),h.sec_range<>(typeof(h.sec_range))'');
    populated_p_city_name_cnt := COUNT(GROUP,h.p_city_name <> (TYPEOF(h.p_city_name))'');
    populated_p_city_name_pcnt := AVE(GROUP,IF(h.p_city_name = (TYPEOF(h.p_city_name))'',0,100));
    maxlength_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.p_city_name)));
    avelength_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.p_city_name)),h.p_city_name<>(typeof(h.p_city_name))'');
    populated_v_city_name_cnt := COUNT(GROUP,h.v_city_name <> (TYPEOF(h.v_city_name))'');
    populated_v_city_name_pcnt := AVE(GROUP,IF(h.v_city_name = (TYPEOF(h.v_city_name))'',0,100));
    maxlength_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.v_city_name)));
    avelength_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.v_city_name)),h.v_city_name<>(typeof(h.v_city_name))'');
    populated_st_cnt := COUNT(GROUP,h.st <> (TYPEOF(h.st))'');
    populated_st_pcnt := AVE(GROUP,IF(h.st = (TYPEOF(h.st))'',0,100));
    maxlength_st := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.st)));
    avelength_st := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.st)),h.st<>(typeof(h.st))'');
    populated_z5_cnt := COUNT(GROUP,h.z5 <> (TYPEOF(h.z5))'');
    populated_z5_pcnt := AVE(GROUP,IF(h.z5 = (TYPEOF(h.z5))'',0,100));
    maxlength_z5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.z5)));
    avelength_z5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.z5)),h.z5<>(typeof(h.z5))'');
    populated_z4_cnt := COUNT(GROUP,h.z4 <> (TYPEOF(h.z4))'');
    populated_z4_pcnt := AVE(GROUP,IF(h.z4 = (TYPEOF(h.z4))'',0,100));
    maxlength_z4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.z4)));
    avelength_z4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.z4)),h.z4<>(typeof(h.z4))'');
    populated_cart_cnt := COUNT(GROUP,h.cart <> (TYPEOF(h.cart))'');
    populated_cart_pcnt := AVE(GROUP,IF(h.cart = (TYPEOF(h.cart))'',0,100));
    maxlength_cart := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cart)));
    avelength_cart := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cart)),h.cart<>(typeof(h.cart))'');
    populated_cr_sort_sz_cnt := COUNT(GROUP,h.cr_sort_sz <> (TYPEOF(h.cr_sort_sz))'');
    populated_cr_sort_sz_pcnt := AVE(GROUP,IF(h.cr_sort_sz = (TYPEOF(h.cr_sort_sz))'',0,100));
    maxlength_cr_sort_sz := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cr_sort_sz)));
    avelength_cr_sort_sz := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cr_sort_sz)),h.cr_sort_sz<>(typeof(h.cr_sort_sz))'');
    populated_lot_cnt := COUNT(GROUP,h.lot <> (TYPEOF(h.lot))'');
    populated_lot_pcnt := AVE(GROUP,IF(h.lot = (TYPEOF(h.lot))'',0,100));
    maxlength_lot := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lot)));
    avelength_lot := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lot)),h.lot<>(typeof(h.lot))'');
    populated_lot_order_cnt := COUNT(GROUP,h.lot_order <> (TYPEOF(h.lot_order))'');
    populated_lot_order_pcnt := AVE(GROUP,IF(h.lot_order = (TYPEOF(h.lot_order))'',0,100));
    maxlength_lot_order := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lot_order)));
    avelength_lot_order := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lot_order)),h.lot_order<>(typeof(h.lot_order))'');
    populated_dbpc_cnt := COUNT(GROUP,h.dbpc <> (TYPEOF(h.dbpc))'');
    populated_dbpc_pcnt := AVE(GROUP,IF(h.dbpc = (TYPEOF(h.dbpc))'',0,100));
    maxlength_dbpc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbpc)));
    avelength_dbpc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbpc)),h.dbpc<>(typeof(h.dbpc))'');
    populated_chk_digit_cnt := COUNT(GROUP,h.chk_digit <> (TYPEOF(h.chk_digit))'');
    populated_chk_digit_pcnt := AVE(GROUP,IF(h.chk_digit = (TYPEOF(h.chk_digit))'',0,100));
    maxlength_chk_digit := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.chk_digit)));
    avelength_chk_digit := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.chk_digit)),h.chk_digit<>(typeof(h.chk_digit))'');
    populated_rec_type_cnt := COUNT(GROUP,h.rec_type <> (TYPEOF(h.rec_type))'');
    populated_rec_type_pcnt := AVE(GROUP,IF(h.rec_type = (TYPEOF(h.rec_type))'',0,100));
    maxlength_rec_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rec_type)));
    avelength_rec_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rec_type)),h.rec_type<>(typeof(h.rec_type))'');
    populated_county_cnt := COUNT(GROUP,h.county <> (TYPEOF(h.county))'');
    populated_county_pcnt := AVE(GROUP,IF(h.county = (TYPEOF(h.county))'',0,100));
    maxlength_county := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.county)));
    avelength_county := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.county)),h.county<>(typeof(h.county))'');
    populated_fips_state_cnt := COUNT(GROUP,h.fips_state <> (TYPEOF(h.fips_state))'');
    populated_fips_state_pcnt := AVE(GROUP,IF(h.fips_state = (TYPEOF(h.fips_state))'',0,100));
    maxlength_fips_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fips_state)));
    avelength_fips_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fips_state)),h.fips_state<>(typeof(h.fips_state))'');
    populated_fips_county_cnt := COUNT(GROUP,h.fips_county <> (TYPEOF(h.fips_county))'');
    populated_fips_county_pcnt := AVE(GROUP,IF(h.fips_county = (TYPEOF(h.fips_county))'',0,100));
    maxlength_fips_county := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fips_county)));
    avelength_fips_county := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fips_county)),h.fips_county<>(typeof(h.fips_county))'');
    populated_geo_lat_cnt := COUNT(GROUP,h.geo_lat <> (TYPEOF(h.geo_lat))'');
    populated_geo_lat_pcnt := AVE(GROUP,IF(h.geo_lat = (TYPEOF(h.geo_lat))'',0,100));
    maxlength_geo_lat := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_lat)));
    avelength_geo_lat := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_lat)),h.geo_lat<>(typeof(h.geo_lat))'');
    populated_geo_long_cnt := COUNT(GROUP,h.geo_long <> (TYPEOF(h.geo_long))'');
    populated_geo_long_pcnt := AVE(GROUP,IF(h.geo_long = (TYPEOF(h.geo_long))'',0,100));
    maxlength_geo_long := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_long)));
    avelength_geo_long := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_long)),h.geo_long<>(typeof(h.geo_long))'');
    populated_msa_cnt := COUNT(GROUP,h.msa <> (TYPEOF(h.msa))'');
    populated_msa_pcnt := AVE(GROUP,IF(h.msa = (TYPEOF(h.msa))'',0,100));
    maxlength_msa := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.msa)));
    avelength_msa := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.msa)),h.msa<>(typeof(h.msa))'');
    populated_geo_blk_cnt := COUNT(GROUP,h.geo_blk <> (TYPEOF(h.geo_blk))'');
    populated_geo_blk_pcnt := AVE(GROUP,IF(h.geo_blk = (TYPEOF(h.geo_blk))'',0,100));
    maxlength_geo_blk := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_blk)));
    avelength_geo_blk := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_blk)),h.geo_blk<>(typeof(h.geo_blk))'');
    populated_geo_match_cnt := COUNT(GROUP,h.geo_match <> (TYPEOF(h.geo_match))'');
    populated_geo_match_pcnt := AVE(GROUP,IF(h.geo_match = (TYPEOF(h.geo_match))'',0,100));
    maxlength_geo_match := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_match)));
    avelength_geo_match := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_match)),h.geo_match<>(typeof(h.geo_match))'');
    populated_err_stat_cnt := COUNT(GROUP,h.err_stat <> (TYPEOF(h.err_stat))'');
    populated_err_stat_pcnt := AVE(GROUP,IF(h.err_stat = (TYPEOF(h.err_stat))'',0,100));
    maxlength_err_stat := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.err_stat)));
    avelength_err_stat := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.err_stat)),h.err_stat<>(typeof(h.err_stat))'');
    populated_telephone_cnt := COUNT(GROUP,h.telephone <> (TYPEOF(h.telephone))'');
    populated_telephone_pcnt := AVE(GROUP,IF(h.telephone = (TYPEOF(h.telephone))'',0,100));
    maxlength_telephone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.telephone)));
    avelength_telephone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.telephone)),h.telephone<>(typeof(h.telephone))'');
    populated_tier2_cnt := COUNT(GROUP,h.tier2 <> (TYPEOF(h.tier2))'');
    populated_tier2_pcnt := AVE(GROUP,IF(h.tier2 = (TYPEOF(h.tier2))'',0,100));
    maxlength_tier2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tier2)));
    avelength_tier2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tier2)),h.tier2<>(typeof(h.tier2))'');
    populated_source_cnt := COUNT(GROUP,h.source <> (TYPEOF(h.source))'');
    populated_source_pcnt := AVE(GROUP,IF(h.source = (TYPEOF(h.source))'',0,100));
    maxlength_source := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.source)));
    avelength_source := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.source)),h.source<>(typeof(h.source))'');
  END;
    T := IF(Glob,TABLE(h,SummaryLayout),TABLE(h,SummaryLayout,cleancollegeid,FEW));
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_cleanaddr1_pcnt *   0.00 / 100 + T.Populated_cleanaddr2_pcnt *   0.00 / 100 + T.Populated_cleanattendancedte_pcnt *   0.00 / 100 + T.Populated_cleancity_pcnt *   0.00 / 100 + T.Populated_cleanstate_pcnt *   0.00 / 100 + T.Populated_cleandob_pcnt *   0.00 / 100 + T.Populated_cleanupdatedte_pcnt *   0.00 / 100 + T.Populated_cleanemail_pcnt *   0.00 / 100 + T.Populated_append_email_username_pcnt *   0.00 / 100 + T.Populated_append_domain_pcnt *   0.00 / 100 + T.Populated_append_domain_type_pcnt *   0.00 / 100 + T.Populated_append_domain_root_pcnt *   0.00 / 100 + T.Populated_append_domain_ext_pcnt *   0.00 / 100 + T.Populated_append_is_tld_state_pcnt *   0.00 / 100 + T.Populated_append_is_tld_generic_pcnt *   0.00 / 100 + T.Populated_append_is_tld_country_pcnt *   0.00 / 100 + T.Populated_append_is_valid_domain_ext_pcnt *   0.00 / 100 + T.Populated_cleancollegeId_pcnt *   0.00 / 100 + T.Populated_cleantitle_pcnt *   0.00 / 100 + T.Populated_cleanfirstname_pcnt *   0.00 / 100 + T.Populated_cleanmidname_pcnt *   0.00 / 100 + T.Populated_cleanlastname_pcnt *   0.00 / 100 + T.Populated_cleansuffixname_pcnt *   0.00 / 100 + T.Populated_cleanzip_pcnt *   0.00 / 100 + T.Populated_cleanzip4_pcnt *   0.00 / 100 + T.Populated_cleanmajor_pcnt *   0.00 / 100 + T.Populated_cleanphone_pcnt *   0.00 / 100 + T.Populated_rcid_pcnt *   0.00 / 100 + T.Populated_did_pcnt *   0.00 / 100 + T.Populated_process_date_pcnt *   0.00 / 100 + T.Populated_date_first_seen_pcnt *   0.00 / 100 + T.Populated_date_last_seen_pcnt *   0.00 / 100 + T.Populated_vendor_first_reported_pcnt *   0.00 / 100 + T.Populated_vendor_last_reported_pcnt *   0.00 / 100 + T.Populated_dateupdated_pcnt *   0.00 / 100 + T.Populated_studentid_pcnt *   0.00 / 100 + T.Populated_dartid_pcnt *   0.00 / 100 + T.Populated_collegeid_pcnt *   0.00 / 100 + T.Populated_projectsource_pcnt *   0.00 / 100 + T.Populated_collegestate_pcnt *   0.00 / 100 + T.Populated_college_pcnt *   0.00 / 100 + T.Populated_semester_pcnt *   0.00 / 100 + T.Populated_year_pcnt *   0.00 / 100 + T.Populated_firstname_pcnt *   0.00 / 100 + T.Populated_middlename_pcnt *   0.00 / 100 + T.Populated_lastname_pcnt *   0.00 / 100 + T.Populated_suffix_pcnt *   0.00 / 100 + T.Populated_major_pcnt *   0.00 / 100 + T.Populated_COLLEGE_MAJOR_pcnt *   0.00 / 100 + T.Populated_NEW_COLLEGE_MAJOR_pcnt *   0.00 / 100 + T.Populated_grade_pcnt *   0.00 / 100 + T.Populated_email_pcnt *   0.00 / 100 + T.Populated_dateofbirth_pcnt *   0.00 / 100 + T.Populated_dob_formatted_pcnt *   0.00 / 100 + T.Populated_attendancedate_pcnt *   0.00 / 100 + T.Populated_enrollmentstatus_pcnt *   0.00 / 100 + T.Populated_addresstype_pcnt *   0.00 / 100 + T.Populated_address1_pcnt *   0.00 / 100 + T.Populated_address2_pcnt *   0.00 / 100 + T.Populated_city_pcnt *   0.00 / 100 + T.Populated_state_pcnt *   0.00 / 100 + T.Populated_zip_pcnt *   0.00 / 100 + T.Populated_zip4_pcnt *   0.00 / 100 + T.Populated_phonetyp_pcnt *   0.00 / 100 + T.Populated_phonenumber_pcnt *   0.00 / 100 + T.Populated_tier_pcnt *   0.00 / 100 + T.Populated_school_size_code_pcnt *   0.00 / 100 + T.Populated_competitive_code_pcnt *   0.00 / 100 + T.Populated_tuition_code_pcnt *   0.00 / 100 + T.Populated_title_pcnt *   0.00 / 100 + T.Populated_fname_pcnt *   0.00 / 100 + T.Populated_mname_pcnt *   0.00 / 100 + T.Populated_lname_pcnt *   0.00 / 100 + T.Populated_name_suffix_pcnt *   0.00 / 100 + T.Populated_name_score_pcnt *   0.00 / 100 + T.Populated_prim_range_pcnt *   0.00 / 100 + T.Populated_predir_pcnt *   0.00 / 100 + T.Populated_prim_name_pcnt *   0.00 / 100 + T.Populated_addr_suffix_pcnt *   0.00 / 100 + T.Populated_postdir_pcnt *   0.00 / 100 + T.Populated_unit_desig_pcnt *   0.00 / 100 + T.Populated_sec_range_pcnt *   0.00 / 100 + T.Populated_p_city_name_pcnt *   0.00 / 100 + T.Populated_v_city_name_pcnt *   0.00 / 100 + T.Populated_st_pcnt *   0.00 / 100 + T.Populated_z5_pcnt *   0.00 / 100 + T.Populated_z4_pcnt *   0.00 / 100 + T.Populated_cart_pcnt *   0.00 / 100 + T.Populated_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_lot_pcnt *   0.00 / 100 + T.Populated_lot_order_pcnt *   0.00 / 100 + T.Populated_dbpc_pcnt *   0.00 / 100 + T.Populated_chk_digit_pcnt *   0.00 / 100 + T.Populated_rec_type_pcnt *   0.00 / 100 + T.Populated_county_pcnt *   0.00 / 100 + T.Populated_fips_state_pcnt *   0.00 / 100 + T.Populated_fips_county_pcnt *   0.00 / 100 + T.Populated_geo_lat_pcnt *   0.00 / 100 + T.Populated_geo_long_pcnt *   0.00 / 100 + T.Populated_msa_pcnt *   0.00 / 100 + T.Populated_geo_blk_pcnt *   0.00 / 100 + T.Populated_geo_match_pcnt *   0.00 / 100 + T.Populated_err_stat_pcnt *   0.00 / 100 + T.Populated_telephone_pcnt *   0.00 / 100 + T.Populated_tier2_pcnt *   0.00 / 100 + T.Populated_source_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
EXPORT SourceCounts := Summary('SummaryBySource',FALSE);
  R := RECORD
    STRING cleancollegeid1;
    STRING cleancollegeid2;
    UNSIGNED LinkingPotential;
  END;
  R T(SourceCounts le, SourceCounts ri) := TRANSFORM
    SELF.cleancollegeid1 := le.Source;
    SELF.cleancollegeid2 := ri.Source;
    SELF.LinkingPotential := 0 + le.Populated_cleanaddr1_pcnt*ri.Populated_cleanaddr1_pcnt *   0.00 / 10000 + le.Populated_cleanaddr2_pcnt*ri.Populated_cleanaddr2_pcnt *   0.00 / 10000 + le.Populated_cleanattendancedte_pcnt*ri.Populated_cleanattendancedte_pcnt *   0.00 / 10000 + le.Populated_cleancity_pcnt*ri.Populated_cleancity_pcnt *   0.00 / 10000 + le.Populated_cleanstate_pcnt*ri.Populated_cleanstate_pcnt *   0.00 / 10000 + le.Populated_cleandob_pcnt*ri.Populated_cleandob_pcnt *   0.00 / 10000 + le.Populated_cleanupdatedte_pcnt*ri.Populated_cleanupdatedte_pcnt *   0.00 / 10000 + le.Populated_cleanemail_pcnt*ri.Populated_cleanemail_pcnt *   0.00 / 10000 + le.Populated_append_email_username_pcnt*ri.Populated_append_email_username_pcnt *   0.00 / 10000 + le.Populated_append_domain_pcnt*ri.Populated_append_domain_pcnt *   0.00 / 10000 + le.Populated_append_domain_type_pcnt*ri.Populated_append_domain_type_pcnt *   0.00 / 10000 + le.Populated_append_domain_root_pcnt*ri.Populated_append_domain_root_pcnt *   0.00 / 10000 + le.Populated_append_domain_ext_pcnt*ri.Populated_append_domain_ext_pcnt *   0.00 / 10000 + le.Populated_append_is_tld_state_pcnt*ri.Populated_append_is_tld_state_pcnt *   0.00 / 10000 + le.Populated_append_is_tld_generic_pcnt*ri.Populated_append_is_tld_generic_pcnt *   0.00 / 10000 + le.Populated_append_is_tld_country_pcnt*ri.Populated_append_is_tld_country_pcnt *   0.00 / 10000 + le.Populated_append_is_valid_domain_ext_pcnt*ri.Populated_append_is_valid_domain_ext_pcnt *   0.00 / 10000 + le.Populated_cleancollegeId_pcnt*ri.Populated_cleancollegeId_pcnt *   0.00 / 10000 + le.Populated_cleantitle_pcnt*ri.Populated_cleantitle_pcnt *   0.00 / 10000 + le.Populated_cleanfirstname_pcnt*ri.Populated_cleanfirstname_pcnt *   0.00 / 10000 + le.Populated_cleanmidname_pcnt*ri.Populated_cleanmidname_pcnt *   0.00 / 10000 + le.Populated_cleanlastname_pcnt*ri.Populated_cleanlastname_pcnt *   0.00 / 10000 + le.Populated_cleansuffixname_pcnt*ri.Populated_cleansuffixname_pcnt *   0.00 / 10000 + le.Populated_cleanzip_pcnt*ri.Populated_cleanzip_pcnt *   0.00 / 10000 + le.Populated_cleanzip4_pcnt*ri.Populated_cleanzip4_pcnt *   0.00 / 10000 + le.Populated_cleanmajor_pcnt*ri.Populated_cleanmajor_pcnt *   0.00 / 10000 + le.Populated_cleanphone_pcnt*ri.Populated_cleanphone_pcnt *   0.00 / 10000 + le.Populated_rcid_pcnt*ri.Populated_rcid_pcnt *   0.00 / 10000 + le.Populated_did_pcnt*ri.Populated_did_pcnt *   0.00 / 10000 + le.Populated_process_date_pcnt*ri.Populated_process_date_pcnt *   0.00 / 10000 + le.Populated_date_first_seen_pcnt*ri.Populated_date_first_seen_pcnt *   0.00 / 10000 + le.Populated_date_last_seen_pcnt*ri.Populated_date_last_seen_pcnt *   0.00 / 10000 + le.Populated_vendor_first_reported_pcnt*ri.Populated_vendor_first_reported_pcnt *   0.00 / 10000 + le.Populated_vendor_last_reported_pcnt*ri.Populated_vendor_last_reported_pcnt *   0.00 / 10000 + le.Populated_dateupdated_pcnt*ri.Populated_dateupdated_pcnt *   0.00 / 10000 + le.Populated_studentid_pcnt*ri.Populated_studentid_pcnt *   0.00 / 10000 + le.Populated_dartid_pcnt*ri.Populated_dartid_pcnt *   0.00 / 10000 + le.Populated_collegeid_pcnt*ri.Populated_collegeid_pcnt *   0.00 / 10000 + le.Populated_projectsource_pcnt*ri.Populated_projectsource_pcnt *   0.00 / 10000 + le.Populated_collegestate_pcnt*ri.Populated_collegestate_pcnt *   0.00 / 10000 + le.Populated_college_pcnt*ri.Populated_college_pcnt *   0.00 / 10000 + le.Populated_semester_pcnt*ri.Populated_semester_pcnt *   0.00 / 10000 + le.Populated_year_pcnt*ri.Populated_year_pcnt *   0.00 / 10000 + le.Populated_firstname_pcnt*ri.Populated_firstname_pcnt *   0.00 / 10000 + le.Populated_middlename_pcnt*ri.Populated_middlename_pcnt *   0.00 / 10000 + le.Populated_lastname_pcnt*ri.Populated_lastname_pcnt *   0.00 / 10000 + le.Populated_suffix_pcnt*ri.Populated_suffix_pcnt *   0.00 / 10000 + le.Populated_major_pcnt*ri.Populated_major_pcnt *   0.00 / 10000 + le.Populated_COLLEGE_MAJOR_pcnt*ri.Populated_COLLEGE_MAJOR_pcnt *   0.00 / 10000 + le.Populated_NEW_COLLEGE_MAJOR_pcnt*ri.Populated_NEW_COLLEGE_MAJOR_pcnt *   0.00 / 10000 + le.Populated_grade_pcnt*ri.Populated_grade_pcnt *   0.00 / 10000 + le.Populated_email_pcnt*ri.Populated_email_pcnt *   0.00 / 10000 + le.Populated_dateofbirth_pcnt*ri.Populated_dateofbirth_pcnt *   0.00 / 10000 + le.Populated_dob_formatted_pcnt*ri.Populated_dob_formatted_pcnt *   0.00 / 10000 + le.Populated_attendancedate_pcnt*ri.Populated_attendancedate_pcnt *   0.00 / 10000 + le.Populated_enrollmentstatus_pcnt*ri.Populated_enrollmentstatus_pcnt *   0.00 / 10000 + le.Populated_addresstype_pcnt*ri.Populated_addresstype_pcnt *   0.00 / 10000 + le.Populated_address1_pcnt*ri.Populated_address1_pcnt *   0.00 / 10000 + le.Populated_address2_pcnt*ri.Populated_address2_pcnt *   0.00 / 10000 + le.Populated_city_pcnt*ri.Populated_city_pcnt *   0.00 / 10000 + le.Populated_state_pcnt*ri.Populated_state_pcnt *   0.00 / 10000 + le.Populated_zip_pcnt*ri.Populated_zip_pcnt *   0.00 / 10000 + le.Populated_zip4_pcnt*ri.Populated_zip4_pcnt *   0.00 / 10000 + le.Populated_phonetyp_pcnt*ri.Populated_phonetyp_pcnt *   0.00 / 10000 + le.Populated_phonenumber_pcnt*ri.Populated_phonenumber_pcnt *   0.00 / 10000 + le.Populated_tier_pcnt*ri.Populated_tier_pcnt *   0.00 / 10000 + le.Populated_school_size_code_pcnt*ri.Populated_school_size_code_pcnt *   0.00 / 10000 + le.Populated_competitive_code_pcnt*ri.Populated_competitive_code_pcnt *   0.00 / 10000 + le.Populated_tuition_code_pcnt*ri.Populated_tuition_code_pcnt *   0.00 / 10000 + le.Populated_title_pcnt*ri.Populated_title_pcnt *   0.00 / 10000 + le.Populated_fname_pcnt*ri.Populated_fname_pcnt *   0.00 / 10000 + le.Populated_mname_pcnt*ri.Populated_mname_pcnt *   0.00 / 10000 + le.Populated_lname_pcnt*ri.Populated_lname_pcnt *   0.00 / 10000 + le.Populated_name_suffix_pcnt*ri.Populated_name_suffix_pcnt *   0.00 / 10000 + le.Populated_name_score_pcnt*ri.Populated_name_score_pcnt *   0.00 / 10000 + le.Populated_prim_range_pcnt*ri.Populated_prim_range_pcnt *   0.00 / 10000 + le.Populated_predir_pcnt*ri.Populated_predir_pcnt *   0.00 / 10000 + le.Populated_prim_name_pcnt*ri.Populated_prim_name_pcnt *   0.00 / 10000 + le.Populated_addr_suffix_pcnt*ri.Populated_addr_suffix_pcnt *   0.00 / 10000 + le.Populated_postdir_pcnt*ri.Populated_postdir_pcnt *   0.00 / 10000 + le.Populated_unit_desig_pcnt*ri.Populated_unit_desig_pcnt *   0.00 / 10000 + le.Populated_sec_range_pcnt*ri.Populated_sec_range_pcnt *   0.00 / 10000 + le.Populated_p_city_name_pcnt*ri.Populated_p_city_name_pcnt *   0.00 / 10000 + le.Populated_v_city_name_pcnt*ri.Populated_v_city_name_pcnt *   0.00 / 10000 + le.Populated_st_pcnt*ri.Populated_st_pcnt *   0.00 / 10000 + le.Populated_z5_pcnt*ri.Populated_z5_pcnt *   0.00 / 10000 + le.Populated_z4_pcnt*ri.Populated_z4_pcnt *   0.00 / 10000 + le.Populated_cart_pcnt*ri.Populated_cart_pcnt *   0.00 / 10000 + le.Populated_cr_sort_sz_pcnt*ri.Populated_cr_sort_sz_pcnt *   0.00 / 10000 + le.Populated_lot_pcnt*ri.Populated_lot_pcnt *   0.00 / 10000 + le.Populated_lot_order_pcnt*ri.Populated_lot_order_pcnt *   0.00 / 10000 + le.Populated_dbpc_pcnt*ri.Populated_dbpc_pcnt *   0.00 / 10000 + le.Populated_chk_digit_pcnt*ri.Populated_chk_digit_pcnt *   0.00 / 10000 + le.Populated_rec_type_pcnt*ri.Populated_rec_type_pcnt *   0.00 / 10000 + le.Populated_county_pcnt*ri.Populated_county_pcnt *   0.00 / 10000 + le.Populated_fips_state_pcnt*ri.Populated_fips_state_pcnt *   0.00 / 10000 + le.Populated_fips_county_pcnt*ri.Populated_fips_county_pcnt *   0.00 / 10000 + le.Populated_geo_lat_pcnt*ri.Populated_geo_lat_pcnt *   0.00 / 10000 + le.Populated_geo_long_pcnt*ri.Populated_geo_long_pcnt *   0.00 / 10000 + le.Populated_msa_pcnt*ri.Populated_msa_pcnt *   0.00 / 10000 + le.Populated_geo_blk_pcnt*ri.Populated_geo_blk_pcnt *   0.00 / 10000 + le.Populated_geo_match_pcnt*ri.Populated_geo_match_pcnt *   0.00 / 10000 + le.Populated_err_stat_pcnt*ri.Populated_err_stat_pcnt *   0.00 / 10000 + le.Populated_telephone_pcnt*ri.Populated_telephone_pcnt *   0.00 / 10000 + le.Populated_tier2_pcnt*ri.Populated_tier2_pcnt *   0.00 / 10000 + le.Populated_source_pcnt*ri.Populated_source_pcnt *   0.00 / 10000;
  END;
EXPORT CrossLinkingPotential := JOIN(SourceCounts,SourceCounts,LEFT.Source<>RIGHT.Source,T(LEFT,RIGHT),ALL);
summary0 := Summary('Summary');
  invRec := RECORD
  UNSIGNED  FldNo;
  SALT311.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'cleanaddr1','cleanaddr2','cleanattendancedte','cleancity','cleanstate','cleandob','cleanupdatedte','cleanemail','append_email_username','append_domain','append_domain_type','append_domain_root','append_domain_ext','append_is_tld_state','append_is_tld_generic','append_is_tld_country','append_is_valid_domain_ext','cleancollegeId','cleantitle','cleanfirstname','cleanmidname','cleanlastname','cleansuffixname','cleanzip','cleanzip4','cleanmajor','cleanphone','rcid','did','process_date','date_first_seen','date_last_seen','vendor_first_reported','vendor_last_reported','dateupdated','studentid','dartid','collegeid','projectsource','collegestate','college','semester','year','firstname','middlename','lastname','suffix','major','COLLEGE_MAJOR','NEW_COLLEGE_MAJOR','grade','email','dateofbirth','dob_formatted','attendancedate','enrollmentstatus','addresstype','address1','address2','city','state','zip','zip4','phonetyp','phonenumber','tier','school_size_code','competitive_code','tuition_code','title','fname','mname','lname','name_suffix','name_score','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','z5','z4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','county','fips_state','fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','telephone','tier2','source');
  SELF.populated_pcnt := CHOOSE(C,le.populated_cleanaddr1_pcnt,le.populated_cleanaddr2_pcnt,le.populated_cleanattendancedte_pcnt,le.populated_cleancity_pcnt,le.populated_cleanstate_pcnt,le.populated_cleandob_pcnt,le.populated_cleanupdatedte_pcnt,le.populated_cleanemail_pcnt,le.populated_append_email_username_pcnt,le.populated_append_domain_pcnt,le.populated_append_domain_type_pcnt,le.populated_append_domain_root_pcnt,le.populated_append_domain_ext_pcnt,le.populated_append_is_tld_state_pcnt,le.populated_append_is_tld_generic_pcnt,le.populated_append_is_tld_country_pcnt,le.populated_append_is_valid_domain_ext_pcnt,le.populated_cleancollegeId_pcnt,le.populated_cleantitle_pcnt,le.populated_cleanfirstname_pcnt,le.populated_cleanmidname_pcnt,le.populated_cleanlastname_pcnt,le.populated_cleansuffixname_pcnt,le.populated_cleanzip_pcnt,le.populated_cleanzip4_pcnt,le.populated_cleanmajor_pcnt,le.populated_cleanphone_pcnt,le.populated_rcid_pcnt,le.populated_did_pcnt,le.populated_process_date_pcnt,le.populated_date_first_seen_pcnt,le.populated_date_last_seen_pcnt,le.populated_vendor_first_reported_pcnt,le.populated_vendor_last_reported_pcnt,le.populated_dateupdated_pcnt,le.populated_studentid_pcnt,le.populated_dartid_pcnt,le.populated_collegeid_pcnt,le.populated_projectsource_pcnt,le.populated_collegestate_pcnt,le.populated_college_pcnt,le.populated_semester_pcnt,le.populated_year_pcnt,le.populated_firstname_pcnt,le.populated_middlename_pcnt,le.populated_lastname_pcnt,le.populated_suffix_pcnt,le.populated_major_pcnt,le.populated_COLLEGE_MAJOR_pcnt,le.populated_NEW_COLLEGE_MAJOR_pcnt,le.populated_grade_pcnt,le.populated_email_pcnt,le.populated_dateofbirth_pcnt,le.populated_dob_formatted_pcnt,le.populated_attendancedate_pcnt,le.populated_enrollmentstatus_pcnt,le.populated_addresstype_pcnt,le.populated_address1_pcnt,le.populated_address2_pcnt,le.populated_city_pcnt,le.populated_state_pcnt,le.populated_zip_pcnt,le.populated_zip4_pcnt,le.populated_phonetyp_pcnt,le.populated_phonenumber_pcnt,le.populated_tier_pcnt,le.populated_school_size_code_pcnt,le.populated_competitive_code_pcnt,le.populated_tuition_code_pcnt,le.populated_title_pcnt,le.populated_fname_pcnt,le.populated_mname_pcnt,le.populated_lname_pcnt,le.populated_name_suffix_pcnt,le.populated_name_score_pcnt,le.populated_prim_range_pcnt,le.populated_predir_pcnt,le.populated_prim_name_pcnt,le.populated_addr_suffix_pcnt,le.populated_postdir_pcnt,le.populated_unit_desig_pcnt,le.populated_sec_range_pcnt,le.populated_p_city_name_pcnt,le.populated_v_city_name_pcnt,le.populated_st_pcnt,le.populated_z5_pcnt,le.populated_z4_pcnt,le.populated_cart_pcnt,le.populated_cr_sort_sz_pcnt,le.populated_lot_pcnt,le.populated_lot_order_pcnt,le.populated_dbpc_pcnt,le.populated_chk_digit_pcnt,le.populated_rec_type_pcnt,le.populated_county_pcnt,le.populated_fips_state_pcnt,le.populated_fips_county_pcnt,le.populated_geo_lat_pcnt,le.populated_geo_long_pcnt,le.populated_msa_pcnt,le.populated_geo_blk_pcnt,le.populated_geo_match_pcnt,le.populated_err_stat_pcnt,le.populated_telephone_pcnt,le.populated_tier2_pcnt,le.populated_source_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_cleanaddr1,le.maxlength_cleanaddr2,le.maxlength_cleanattendancedte,le.maxlength_cleancity,le.maxlength_cleanstate,le.maxlength_cleandob,le.maxlength_cleanupdatedte,le.maxlength_cleanemail,le.maxlength_append_email_username,le.maxlength_append_domain,le.maxlength_append_domain_type,le.maxlength_append_domain_root,le.maxlength_append_domain_ext,le.maxlength_append_is_tld_state,le.maxlength_append_is_tld_generic,le.maxlength_append_is_tld_country,le.maxlength_append_is_valid_domain_ext,le.maxlength_cleancollegeId,le.maxlength_cleantitle,le.maxlength_cleanfirstname,le.maxlength_cleanmidname,le.maxlength_cleanlastname,le.maxlength_cleansuffixname,le.maxlength_cleanzip,le.maxlength_cleanzip4,le.maxlength_cleanmajor,le.maxlength_cleanphone,le.maxlength_rcid,le.maxlength_did,le.maxlength_process_date,le.maxlength_date_first_seen,le.maxlength_date_last_seen,le.maxlength_vendor_first_reported,le.maxlength_vendor_last_reported,le.maxlength_dateupdated,le.maxlength_studentid,le.maxlength_dartid,le.maxlength_collegeid,le.maxlength_projectsource,le.maxlength_collegestate,le.maxlength_college,le.maxlength_semester,le.maxlength_year,le.maxlength_firstname,le.maxlength_middlename,le.maxlength_lastname,le.maxlength_suffix,le.maxlength_major,le.maxlength_COLLEGE_MAJOR,le.maxlength_NEW_COLLEGE_MAJOR,le.maxlength_grade,le.maxlength_email,le.maxlength_dateofbirth,le.maxlength_dob_formatted,le.maxlength_attendancedate,le.maxlength_enrollmentstatus,le.maxlength_addresstype,le.maxlength_address1,le.maxlength_address2,le.maxlength_city,le.maxlength_state,le.maxlength_zip,le.maxlength_zip4,le.maxlength_phonetyp,le.maxlength_phonenumber,le.maxlength_tier,le.maxlength_school_size_code,le.maxlength_competitive_code,le.maxlength_tuition_code,le.maxlength_title,le.maxlength_fname,le.maxlength_mname,le.maxlength_lname,le.maxlength_name_suffix,le.maxlength_name_score,le.maxlength_prim_range,le.maxlength_predir,le.maxlength_prim_name,le.maxlength_addr_suffix,le.maxlength_postdir,le.maxlength_unit_desig,le.maxlength_sec_range,le.maxlength_p_city_name,le.maxlength_v_city_name,le.maxlength_st,le.maxlength_z5,le.maxlength_z4,le.maxlength_cart,le.maxlength_cr_sort_sz,le.maxlength_lot,le.maxlength_lot_order,le.maxlength_dbpc,le.maxlength_chk_digit,le.maxlength_rec_type,le.maxlength_county,le.maxlength_fips_state,le.maxlength_fips_county,le.maxlength_geo_lat,le.maxlength_geo_long,le.maxlength_msa,le.maxlength_geo_blk,le.maxlength_geo_match,le.maxlength_err_stat,le.maxlength_telephone,le.maxlength_tier2,le.maxlength_source);
  SELF.avelength := CHOOSE(C,le.avelength_cleanaddr1,le.avelength_cleanaddr2,le.avelength_cleanattendancedte,le.avelength_cleancity,le.avelength_cleanstate,le.avelength_cleandob,le.avelength_cleanupdatedte,le.avelength_cleanemail,le.avelength_append_email_username,le.avelength_append_domain,le.avelength_append_domain_type,le.avelength_append_domain_root,le.avelength_append_domain_ext,le.avelength_append_is_tld_state,le.avelength_append_is_tld_generic,le.avelength_append_is_tld_country,le.avelength_append_is_valid_domain_ext,le.avelength_cleancollegeId,le.avelength_cleantitle,le.avelength_cleanfirstname,le.avelength_cleanmidname,le.avelength_cleanlastname,le.avelength_cleansuffixname,le.avelength_cleanzip,le.avelength_cleanzip4,le.avelength_cleanmajor,le.avelength_cleanphone,le.avelength_rcid,le.avelength_did,le.avelength_process_date,le.avelength_date_first_seen,le.avelength_date_last_seen,le.avelength_vendor_first_reported,le.avelength_vendor_last_reported,le.avelength_dateupdated,le.avelength_studentid,le.avelength_dartid,le.avelength_collegeid,le.avelength_projectsource,le.avelength_collegestate,le.avelength_college,le.avelength_semester,le.avelength_year,le.avelength_firstname,le.avelength_middlename,le.avelength_lastname,le.avelength_suffix,le.avelength_major,le.avelength_COLLEGE_MAJOR,le.avelength_NEW_COLLEGE_MAJOR,le.avelength_grade,le.avelength_email,le.avelength_dateofbirth,le.avelength_dob_formatted,le.avelength_attendancedate,le.avelength_enrollmentstatus,le.avelength_addresstype,le.avelength_address1,le.avelength_address2,le.avelength_city,le.avelength_state,le.avelength_zip,le.avelength_zip4,le.avelength_phonetyp,le.avelength_phonenumber,le.avelength_tier,le.avelength_school_size_code,le.avelength_competitive_code,le.avelength_tuition_code,le.avelength_title,le.avelength_fname,le.avelength_mname,le.avelength_lname,le.avelength_name_suffix,le.avelength_name_score,le.avelength_prim_range,le.avelength_predir,le.avelength_prim_name,le.avelength_addr_suffix,le.avelength_postdir,le.avelength_unit_desig,le.avelength_sec_range,le.avelength_p_city_name,le.avelength_v_city_name,le.avelength_st,le.avelength_z5,le.avelength_z4,le.avelength_cart,le.avelength_cr_sort_sz,le.avelength_lot,le.avelength_lot_order,le.avelength_dbpc,le.avelength_chk_digit,le.avelength_rec_type,le.avelength_county,le.avelength_fips_state,le.avelength_fips_county,le.avelength_geo_lat,le.avelength_geo_long,le.avelength_msa,le.avelength_geo_blk,le.avelength_geo_match,le.avelength_err_stat,le.avelength_telephone,le.avelength_tier2,le.avelength_source);
END;
EXPORT invSummary := NORMALIZE(summary0, 106, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Src := le.cleancollegeid;
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.cleanaddr1),TRIM((SALT311.StrType)le.cleanaddr2),TRIM((SALT311.StrType)le.cleanattendancedte),TRIM((SALT311.StrType)le.cleancity),TRIM((SALT311.StrType)le.cleanstate),TRIM((SALT311.StrType)le.cleandob),TRIM((SALT311.StrType)le.cleanupdatedte),TRIM((SALT311.StrType)le.cleanemail),TRIM((SALT311.StrType)le.append_email_username),TRIM((SALT311.StrType)le.append_domain),TRIM((SALT311.StrType)le.append_domain_type),TRIM((SALT311.StrType)le.append_domain_root),TRIM((SALT311.StrType)le.append_domain_ext),TRIM((SALT311.StrType)le.append_is_tld_state),TRIM((SALT311.StrType)le.append_is_tld_generic),TRIM((SALT311.StrType)le.append_is_tld_country),TRIM((SALT311.StrType)le.append_is_valid_domain_ext),TRIM((SALT311.StrType)le.cleancollegeId),TRIM((SALT311.StrType)le.cleantitle),TRIM((SALT311.StrType)le.cleanfirstname),TRIM((SALT311.StrType)le.cleanmidname),TRIM((SALT311.StrType)le.cleanlastname),TRIM((SALT311.StrType)le.cleansuffixname),TRIM((SALT311.StrType)le.cleanzip),TRIM((SALT311.StrType)le.cleanzip4),TRIM((SALT311.StrType)le.cleanmajor),TRIM((SALT311.StrType)le.cleanphone),TRIM((SALT311.StrType)le.rcid),IF (le.did <> 0,TRIM((SALT311.StrType)le.did), ''),TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.date_first_seen),TRIM((SALT311.StrType)le.date_last_seen),TRIM((SALT311.StrType)le.vendor_first_reported),TRIM((SALT311.StrType)le.vendor_last_reported),TRIM((SALT311.StrType)le.dateupdated),TRIM((SALT311.StrType)le.studentid),TRIM((SALT311.StrType)le.dartid),TRIM((SALT311.StrType)le.collegeid),TRIM((SALT311.StrType)le.projectsource),TRIM((SALT311.StrType)le.collegestate),TRIM((SALT311.StrType)le.college),TRIM((SALT311.StrType)le.semester),TRIM((SALT311.StrType)le.year),TRIM((SALT311.StrType)le.firstname),TRIM((SALT311.StrType)le.middlename),TRIM((SALT311.StrType)le.lastname),TRIM((SALT311.StrType)le.suffix),TRIM((SALT311.StrType)le.major),TRIM((SALT311.StrType)le.COLLEGE_MAJOR),TRIM((SALT311.StrType)le.NEW_COLLEGE_MAJOR),TRIM((SALT311.StrType)le.grade),TRIM((SALT311.StrType)le.email),TRIM((SALT311.StrType)le.dateofbirth),TRIM((SALT311.StrType)le.dob_formatted),TRIM((SALT311.StrType)le.attendancedate),TRIM((SALT311.StrType)le.enrollmentstatus),TRIM((SALT311.StrType)le.addresstype),TRIM((SALT311.StrType)le.address1),TRIM((SALT311.StrType)le.address2),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.phonetyp),TRIM((SALT311.StrType)le.phonenumber),TRIM((SALT311.StrType)le.tier),TRIM((SALT311.StrType)le.school_size_code),TRIM((SALT311.StrType)le.competitive_code),TRIM((SALT311.StrType)le.tuition_code),TRIM((SALT311.StrType)le.title),TRIM((SALT311.StrType)le.fname),TRIM((SALT311.StrType)le.mname),TRIM((SALT311.StrType)le.lname),TRIM((SALT311.StrType)le.name_suffix),TRIM((SALT311.StrType)le.name_score),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.addr_suffix),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.unit_desig),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.p_city_name),TRIM((SALT311.StrType)le.v_city_name),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.z5),TRIM((SALT311.StrType)le.z4),TRIM((SALT311.StrType)le.cart),TRIM((SALT311.StrType)le.cr_sort_sz),TRIM((SALT311.StrType)le.lot),TRIM((SALT311.StrType)le.lot_order),TRIM((SALT311.StrType)le.dbpc),TRIM((SALT311.StrType)le.chk_digit),TRIM((SALT311.StrType)le.rec_type),TRIM((SALT311.StrType)le.county),TRIM((SALT311.StrType)le.fips_state),TRIM((SALT311.StrType)le.fips_county),TRIM((SALT311.StrType)le.geo_lat),TRIM((SALT311.StrType)le.geo_long),TRIM((SALT311.StrType)le.msa),TRIM((SALT311.StrType)le.geo_blk),TRIM((SALT311.StrType)le.geo_match),TRIM((SALT311.StrType)le.err_stat),TRIM((SALT311.StrType)le.telephone),TRIM((SALT311.StrType)le.tier2),TRIM((SALT311.StrType)le.source)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,106,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 106);
  SELF.FldNo2 := 1 + (C % 106);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.cleanaddr1),TRIM((SALT311.StrType)le.cleanaddr2),TRIM((SALT311.StrType)le.cleanattendancedte),TRIM((SALT311.StrType)le.cleancity),TRIM((SALT311.StrType)le.cleanstate),TRIM((SALT311.StrType)le.cleandob),TRIM((SALT311.StrType)le.cleanupdatedte),TRIM((SALT311.StrType)le.cleanemail),TRIM((SALT311.StrType)le.append_email_username),TRIM((SALT311.StrType)le.append_domain),TRIM((SALT311.StrType)le.append_domain_type),TRIM((SALT311.StrType)le.append_domain_root),TRIM((SALT311.StrType)le.append_domain_ext),TRIM((SALT311.StrType)le.append_is_tld_state),TRIM((SALT311.StrType)le.append_is_tld_generic),TRIM((SALT311.StrType)le.append_is_tld_country),TRIM((SALT311.StrType)le.append_is_valid_domain_ext),TRIM((SALT311.StrType)le.cleancollegeId),TRIM((SALT311.StrType)le.cleantitle),TRIM((SALT311.StrType)le.cleanfirstname),TRIM((SALT311.StrType)le.cleanmidname),TRIM((SALT311.StrType)le.cleanlastname),TRIM((SALT311.StrType)le.cleansuffixname),TRIM((SALT311.StrType)le.cleanzip),TRIM((SALT311.StrType)le.cleanzip4),TRIM((SALT311.StrType)le.cleanmajor),TRIM((SALT311.StrType)le.cleanphone),TRIM((SALT311.StrType)le.rcid),IF (le.did <> 0,TRIM((SALT311.StrType)le.did), ''),TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.date_first_seen),TRIM((SALT311.StrType)le.date_last_seen),TRIM((SALT311.StrType)le.vendor_first_reported),TRIM((SALT311.StrType)le.vendor_last_reported),TRIM((SALT311.StrType)le.dateupdated),TRIM((SALT311.StrType)le.studentid),TRIM((SALT311.StrType)le.dartid),TRIM((SALT311.StrType)le.collegeid),TRIM((SALT311.StrType)le.projectsource),TRIM((SALT311.StrType)le.collegestate),TRIM((SALT311.StrType)le.college),TRIM((SALT311.StrType)le.semester),TRIM((SALT311.StrType)le.year),TRIM((SALT311.StrType)le.firstname),TRIM((SALT311.StrType)le.middlename),TRIM((SALT311.StrType)le.lastname),TRIM((SALT311.StrType)le.suffix),TRIM((SALT311.StrType)le.major),TRIM((SALT311.StrType)le.COLLEGE_MAJOR),TRIM((SALT311.StrType)le.NEW_COLLEGE_MAJOR),TRIM((SALT311.StrType)le.grade),TRIM((SALT311.StrType)le.email),TRIM((SALT311.StrType)le.dateofbirth),TRIM((SALT311.StrType)le.dob_formatted),TRIM((SALT311.StrType)le.attendancedate),TRIM((SALT311.StrType)le.enrollmentstatus),TRIM((SALT311.StrType)le.addresstype),TRIM((SALT311.StrType)le.address1),TRIM((SALT311.StrType)le.address2),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.phonetyp),TRIM((SALT311.StrType)le.phonenumber),TRIM((SALT311.StrType)le.tier),TRIM((SALT311.StrType)le.school_size_code),TRIM((SALT311.StrType)le.competitive_code),TRIM((SALT311.StrType)le.tuition_code),TRIM((SALT311.StrType)le.title),TRIM((SALT311.StrType)le.fname),TRIM((SALT311.StrType)le.mname),TRIM((SALT311.StrType)le.lname),TRIM((SALT311.StrType)le.name_suffix),TRIM((SALT311.StrType)le.name_score),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.addr_suffix),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.unit_desig),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.p_city_name),TRIM((SALT311.StrType)le.v_city_name),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.z5),TRIM((SALT311.StrType)le.z4),TRIM((SALT311.StrType)le.cart),TRIM((SALT311.StrType)le.cr_sort_sz),TRIM((SALT311.StrType)le.lot),TRIM((SALT311.StrType)le.lot_order),TRIM((SALT311.StrType)le.dbpc),TRIM((SALT311.StrType)le.chk_digit),TRIM((SALT311.StrType)le.rec_type),TRIM((SALT311.StrType)le.county),TRIM((SALT311.StrType)le.fips_state),TRIM((SALT311.StrType)le.fips_county),TRIM((SALT311.StrType)le.geo_lat),TRIM((SALT311.StrType)le.geo_long),TRIM((SALT311.StrType)le.msa),TRIM((SALT311.StrType)le.geo_blk),TRIM((SALT311.StrType)le.geo_match),TRIM((SALT311.StrType)le.err_stat),TRIM((SALT311.StrType)le.telephone),TRIM((SALT311.StrType)le.tier2),TRIM((SALT311.StrType)le.source)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.cleanaddr1),TRIM((SALT311.StrType)le.cleanaddr2),TRIM((SALT311.StrType)le.cleanattendancedte),TRIM((SALT311.StrType)le.cleancity),TRIM((SALT311.StrType)le.cleanstate),TRIM((SALT311.StrType)le.cleandob),TRIM((SALT311.StrType)le.cleanupdatedte),TRIM((SALT311.StrType)le.cleanemail),TRIM((SALT311.StrType)le.append_email_username),TRIM((SALT311.StrType)le.append_domain),TRIM((SALT311.StrType)le.append_domain_type),TRIM((SALT311.StrType)le.append_domain_root),TRIM((SALT311.StrType)le.append_domain_ext),TRIM((SALT311.StrType)le.append_is_tld_state),TRIM((SALT311.StrType)le.append_is_tld_generic),TRIM((SALT311.StrType)le.append_is_tld_country),TRIM((SALT311.StrType)le.append_is_valid_domain_ext),TRIM((SALT311.StrType)le.cleancollegeId),TRIM((SALT311.StrType)le.cleantitle),TRIM((SALT311.StrType)le.cleanfirstname),TRIM((SALT311.StrType)le.cleanmidname),TRIM((SALT311.StrType)le.cleanlastname),TRIM((SALT311.StrType)le.cleansuffixname),TRIM((SALT311.StrType)le.cleanzip),TRIM((SALT311.StrType)le.cleanzip4),TRIM((SALT311.StrType)le.cleanmajor),TRIM((SALT311.StrType)le.cleanphone),TRIM((SALT311.StrType)le.rcid),IF (le.did <> 0,TRIM((SALT311.StrType)le.did), ''),TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.date_first_seen),TRIM((SALT311.StrType)le.date_last_seen),TRIM((SALT311.StrType)le.vendor_first_reported),TRIM((SALT311.StrType)le.vendor_last_reported),TRIM((SALT311.StrType)le.dateupdated),TRIM((SALT311.StrType)le.studentid),TRIM((SALT311.StrType)le.dartid),TRIM((SALT311.StrType)le.collegeid),TRIM((SALT311.StrType)le.projectsource),TRIM((SALT311.StrType)le.collegestate),TRIM((SALT311.StrType)le.college),TRIM((SALT311.StrType)le.semester),TRIM((SALT311.StrType)le.year),TRIM((SALT311.StrType)le.firstname),TRIM((SALT311.StrType)le.middlename),TRIM((SALT311.StrType)le.lastname),TRIM((SALT311.StrType)le.suffix),TRIM((SALT311.StrType)le.major),TRIM((SALT311.StrType)le.COLLEGE_MAJOR),TRIM((SALT311.StrType)le.NEW_COLLEGE_MAJOR),TRIM((SALT311.StrType)le.grade),TRIM((SALT311.StrType)le.email),TRIM((SALT311.StrType)le.dateofbirth),TRIM((SALT311.StrType)le.dob_formatted),TRIM((SALT311.StrType)le.attendancedate),TRIM((SALT311.StrType)le.enrollmentstatus),TRIM((SALT311.StrType)le.addresstype),TRIM((SALT311.StrType)le.address1),TRIM((SALT311.StrType)le.address2),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.phonetyp),TRIM((SALT311.StrType)le.phonenumber),TRIM((SALT311.StrType)le.tier),TRIM((SALT311.StrType)le.school_size_code),TRIM((SALT311.StrType)le.competitive_code),TRIM((SALT311.StrType)le.tuition_code),TRIM((SALT311.StrType)le.title),TRIM((SALT311.StrType)le.fname),TRIM((SALT311.StrType)le.mname),TRIM((SALT311.StrType)le.lname),TRIM((SALT311.StrType)le.name_suffix),TRIM((SALT311.StrType)le.name_score),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.addr_suffix),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.unit_desig),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.p_city_name),TRIM((SALT311.StrType)le.v_city_name),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.z5),TRIM((SALT311.StrType)le.z4),TRIM((SALT311.StrType)le.cart),TRIM((SALT311.StrType)le.cr_sort_sz),TRIM((SALT311.StrType)le.lot),TRIM((SALT311.StrType)le.lot_order),TRIM((SALT311.StrType)le.dbpc),TRIM((SALT311.StrType)le.chk_digit),TRIM((SALT311.StrType)le.rec_type),TRIM((SALT311.StrType)le.county),TRIM((SALT311.StrType)le.fips_state),TRIM((SALT311.StrType)le.fips_county),TRIM((SALT311.StrType)le.geo_lat),TRIM((SALT311.StrType)le.geo_long),TRIM((SALT311.StrType)le.msa),TRIM((SALT311.StrType)le.geo_blk),TRIM((SALT311.StrType)le.geo_match),TRIM((SALT311.StrType)le.err_stat),TRIM((SALT311.StrType)le.telephone),TRIM((SALT311.StrType)le.tier2),TRIM((SALT311.StrType)le.source)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),106*106,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'cleanaddr1'}
      ,{2,'cleanaddr2'}
      ,{3,'cleanattendancedte'}
      ,{4,'cleancity'}
      ,{5,'cleanstate'}
      ,{6,'cleandob'}
      ,{7,'cleanupdatedte'}
      ,{8,'cleanemail'}
      ,{9,'append_email_username'}
      ,{10,'append_domain'}
      ,{11,'append_domain_type'}
      ,{12,'append_domain_root'}
      ,{13,'append_domain_ext'}
      ,{14,'append_is_tld_state'}
      ,{15,'append_is_tld_generic'}
      ,{16,'append_is_tld_country'}
      ,{17,'append_is_valid_domain_ext'}
      ,{18,'cleancollegeId'}
      ,{19,'cleantitle'}
      ,{20,'cleanfirstname'}
      ,{21,'cleanmidname'}
      ,{22,'cleanlastname'}
      ,{23,'cleansuffixname'}
      ,{24,'cleanzip'}
      ,{25,'cleanzip4'}
      ,{26,'cleanmajor'}
      ,{27,'cleanphone'}
      ,{28,'rcid'}
      ,{29,'did'}
      ,{30,'process_date'}
      ,{31,'date_first_seen'}
      ,{32,'date_last_seen'}
      ,{33,'vendor_first_reported'}
      ,{34,'vendor_last_reported'}
      ,{35,'dateupdated'}
      ,{36,'studentid'}
      ,{37,'dartid'}
      ,{38,'collegeid'}
      ,{39,'projectsource'}
      ,{40,'collegestate'}
      ,{41,'college'}
      ,{42,'semester'}
      ,{43,'year'}
      ,{44,'firstname'}
      ,{45,'middlename'}
      ,{46,'lastname'}
      ,{47,'suffix'}
      ,{48,'major'}
      ,{49,'COLLEGE_MAJOR'}
      ,{50,'NEW_COLLEGE_MAJOR'}
      ,{51,'grade'}
      ,{52,'email'}
      ,{53,'dateofbirth'}
      ,{54,'dob_formatted'}
      ,{55,'attendancedate'}
      ,{56,'enrollmentstatus'}
      ,{57,'addresstype'}
      ,{58,'address1'}
      ,{59,'address2'}
      ,{60,'city'}
      ,{61,'state'}
      ,{62,'zip'}
      ,{63,'zip4'}
      ,{64,'phonetyp'}
      ,{65,'phonenumber'}
      ,{66,'tier'}
      ,{67,'school_size_code'}
      ,{68,'competitive_code'}
      ,{69,'tuition_code'}
      ,{70,'title'}
      ,{71,'fname'}
      ,{72,'mname'}
      ,{73,'lname'}
      ,{74,'name_suffix'}
      ,{75,'name_score'}
      ,{76,'prim_range'}
      ,{77,'predir'}
      ,{78,'prim_name'}
      ,{79,'addr_suffix'}
      ,{80,'postdir'}
      ,{81,'unit_desig'}
      ,{82,'sec_range'}
      ,{83,'p_city_name'}
      ,{84,'v_city_name'}
      ,{85,'st'}
      ,{86,'z5'}
      ,{87,'z4'}
      ,{88,'cart'}
      ,{89,'cr_sort_sz'}
      ,{90,'lot'}
      ,{91,'lot_order'}
      ,{92,'dbpc'}
      ,{93,'chk_digit'}
      ,{94,'rec_type'}
      ,{95,'county'}
      ,{96,'fips_state'}
      ,{97,'fips_county'}
      ,{98,'geo_lat'}
      ,{99,'geo_long'}
      ,{100,'msa'}
      ,{101,'geo_blk'}
      ,{102,'geo_match'}
      ,{103,'err_stat'}
      ,{104,'telephone'}
      ,{105,'tier2'}
      ,{106,'source'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
  TYPEOF(h.cleancollegeid) cleancollegeid; // Track errors by source
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_cleanaddr1((SALT311.StrType)le.cleanaddr1),
    Fields.InValid_cleanaddr2((SALT311.StrType)le.cleanaddr2),
    Fields.InValid_cleanattendancedte((SALT311.StrType)le.cleanattendancedte),
    Fields.InValid_cleancity((SALT311.StrType)le.cleancity),
    Fields.InValid_cleanstate((SALT311.StrType)le.cleanstate),
    Fields.InValid_cleandob((SALT311.StrType)le.cleandob),
    Fields.InValid_cleanupdatedte((SALT311.StrType)le.cleanupdatedte),
    Fields.InValid_cleanemail((SALT311.StrType)le.cleanemail),
    Fields.InValid_append_email_username((SALT311.StrType)le.append_email_username),
    Fields.InValid_append_domain((SALT311.StrType)le.append_domain),
    Fields.InValid_append_domain_type((SALT311.StrType)le.append_domain_type),
    Fields.InValid_append_domain_root((SALT311.StrType)le.append_domain_root),
    Fields.InValid_append_domain_ext((SALT311.StrType)le.append_domain_ext),
    Fields.InValid_append_is_tld_state((SALT311.StrType)le.append_is_tld_state),
    Fields.InValid_append_is_tld_generic((SALT311.StrType)le.append_is_tld_generic),
    Fields.InValid_append_is_tld_country((SALT311.StrType)le.append_is_tld_country),
    Fields.InValid_append_is_valid_domain_ext((SALT311.StrType)le.append_is_valid_domain_ext),
    Fields.InValid_cleancollegeId((SALT311.StrType)le.cleancollegeId),
    Fields.InValid_cleantitle((SALT311.StrType)le.cleantitle),
    Fields.InValid_cleanfirstname((SALT311.StrType)le.cleanfirstname),
    Fields.InValid_cleanmidname((SALT311.StrType)le.cleanmidname),
    Fields.InValid_cleanlastname((SALT311.StrType)le.cleanlastname),
    Fields.InValid_cleansuffixname((SALT311.StrType)le.cleansuffixname),
    Fields.InValid_cleanzip((SALT311.StrType)le.cleanzip),
    Fields.InValid_cleanzip4((SALT311.StrType)le.cleanzip4),
    Fields.InValid_cleanmajor((SALT311.StrType)le.cleanmajor),
    Fields.InValid_cleanphone((SALT311.StrType)le.cleanphone),
    Fields.InValid_rcid((SALT311.StrType)le.rcid),
    Fields.InValid_did((SALT311.StrType)le.did),
    Fields.InValid_process_date((SALT311.StrType)le.process_date),
    Fields.InValid_date_first_seen((SALT311.StrType)le.date_first_seen),
    Fields.InValid_date_last_seen((SALT311.StrType)le.date_last_seen),
    Fields.InValid_vendor_first_reported((SALT311.StrType)le.vendor_first_reported),
    Fields.InValid_vendor_last_reported((SALT311.StrType)le.vendor_last_reported),
    Fields.InValid_dateupdated((SALT311.StrType)le.dateupdated),
    Fields.InValid_studentid((SALT311.StrType)le.studentid),
    Fields.InValid_dartid((SALT311.StrType)le.dartid),
    Fields.InValid_collegeid((SALT311.StrType)le.collegeid),
    Fields.InValid_projectsource((SALT311.StrType)le.projectsource),
    Fields.InValid_collegestate((SALT311.StrType)le.collegestate),
    Fields.InValid_college((SALT311.StrType)le.college),
    Fields.InValid_semester((SALT311.StrType)le.semester),
    Fields.InValid_year((SALT311.StrType)le.year),
    Fields.InValid_firstname((SALT311.StrType)le.firstname),
    Fields.InValid_middlename((SALT311.StrType)le.middlename),
    Fields.InValid_lastname((SALT311.StrType)le.lastname),
    Fields.InValid_suffix((SALT311.StrType)le.suffix),
    Fields.InValid_major((SALT311.StrType)le.major),
    Fields.InValid_COLLEGE_MAJOR((SALT311.StrType)le.COLLEGE_MAJOR),
    Fields.InValid_NEW_COLLEGE_MAJOR((SALT311.StrType)le.NEW_COLLEGE_MAJOR),
    Fields.InValid_grade((SALT311.StrType)le.grade),
    Fields.InValid_email((SALT311.StrType)le.email),
    Fields.InValid_dateofbirth((SALT311.StrType)le.dateofbirth),
    Fields.InValid_dob_formatted((SALT311.StrType)le.dob_formatted),
    Fields.InValid_attendancedate((SALT311.StrType)le.attendancedate),
    Fields.InValid_enrollmentstatus((SALT311.StrType)le.enrollmentstatus),
    Fields.InValid_addresstype((SALT311.StrType)le.addresstype),
    Fields.InValid_address1((SALT311.StrType)le.address1),
    Fields.InValid_address2((SALT311.StrType)le.address2),
    Fields.InValid_city((SALT311.StrType)le.city),
    Fields.InValid_state((SALT311.StrType)le.state),
    Fields.InValid_zip((SALT311.StrType)le.zip),
    Fields.InValid_zip4((SALT311.StrType)le.zip4),
    Fields.InValid_phonetyp((SALT311.StrType)le.phonetyp),
    Fields.InValid_phonenumber((SALT311.StrType)le.phonenumber),
    Fields.InValid_tier((SALT311.StrType)le.tier),
    Fields.InValid_school_size_code((SALT311.StrType)le.school_size_code),
    Fields.InValid_competitive_code((SALT311.StrType)le.competitive_code),
    Fields.InValid_tuition_code((SALT311.StrType)le.tuition_code),
    Fields.InValid_title((SALT311.StrType)le.title),
    Fields.InValid_fname((SALT311.StrType)le.fname),
    Fields.InValid_mname((SALT311.StrType)le.mname),
    Fields.InValid_lname((SALT311.StrType)le.lname),
    Fields.InValid_name_suffix((SALT311.StrType)le.name_suffix),
    Fields.InValid_name_score((SALT311.StrType)le.name_score),
    Fields.InValid_prim_range((SALT311.StrType)le.prim_range),
    Fields.InValid_predir((SALT311.StrType)le.predir),
    Fields.InValid_prim_name((SALT311.StrType)le.prim_name),
    Fields.InValid_addr_suffix((SALT311.StrType)le.addr_suffix),
    Fields.InValid_postdir((SALT311.StrType)le.postdir),
    Fields.InValid_unit_desig((SALT311.StrType)le.unit_desig),
    Fields.InValid_sec_range((SALT311.StrType)le.sec_range),
    Fields.InValid_p_city_name((SALT311.StrType)le.p_city_name),
    Fields.InValid_v_city_name((SALT311.StrType)le.v_city_name),
    Fields.InValid_st((SALT311.StrType)le.st),
    Fields.InValid_z5((SALT311.StrType)le.z5),
    Fields.InValid_z4((SALT311.StrType)le.z4),
    Fields.InValid_cart((SALT311.StrType)le.cart),
    Fields.InValid_cr_sort_sz((SALT311.StrType)le.cr_sort_sz),
    Fields.InValid_lot((SALT311.StrType)le.lot),
    Fields.InValid_lot_order((SALT311.StrType)le.lot_order),
    Fields.InValid_dbpc((SALT311.StrType)le.dbpc),
    Fields.InValid_chk_digit((SALT311.StrType)le.chk_digit),
    Fields.InValid_rec_type((SALT311.StrType)le.rec_type),
    Fields.InValid_county((SALT311.StrType)le.county),
    Fields.InValid_fips_state((SALT311.StrType)le.fips_state),
    Fields.InValid_fips_county((SALT311.StrType)le.fips_county),
    Fields.InValid_geo_lat((SALT311.StrType)le.geo_lat),
    Fields.InValid_geo_long((SALT311.StrType)le.geo_long),
    Fields.InValid_msa((SALT311.StrType)le.msa),
    Fields.InValid_geo_blk((SALT311.StrType)le.geo_blk),
    Fields.InValid_geo_match((SALT311.StrType)le.geo_match),
    Fields.InValid_err_stat((SALT311.StrType)le.err_stat),
    Fields.InValid_telephone((SALT311.StrType)le.telephone),
    Fields.InValid_tier2((SALT311.StrType)le.tier2),
    Fields.InValid_source((SALT311.StrType)le.source),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
  SELF.cleancollegeid := le.cleancollegeid;
END;
Errors := NORMALIZE(h,106,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
  Errors.cleancollegeid;
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,cleancollegeid,FEW);
PrettyErrorTotals := RECORD
  TotalErrors.cleancollegeid;
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_address','invalid_address','Unknown','invalid_city','invalid_state','invalid_date','invalid_date','invalid_email','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_name','invalid_name','invalid_name','invalid_name','Unknown','Unknown','Unknown','invalid_phone','Unknown','Unknown','invalid_date','invalid_date','invalid_date','invalid_date','invalid_date','invalid_date','nums','nums','Unknown','Unknown','Unknown','invalid_college','invalid_semester','nums','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_MajorCode','invalid_NewMajorCode','Unknown','Unknown','invalid_date','invalid_date','Unknown','Unknown','invalid_addresstype','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_phonetyp','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_suffix','Unknown','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_city','invalid_city','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_phone','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_cleanaddr1(TotalErrors.ErrorNum),Fields.InValidMessage_cleanaddr2(TotalErrors.ErrorNum),Fields.InValidMessage_cleanattendancedte(TotalErrors.ErrorNum),Fields.InValidMessage_cleancity(TotalErrors.ErrorNum),Fields.InValidMessage_cleanstate(TotalErrors.ErrorNum),Fields.InValidMessage_cleandob(TotalErrors.ErrorNum),Fields.InValidMessage_cleanupdatedte(TotalErrors.ErrorNum),Fields.InValidMessage_cleanemail(TotalErrors.ErrorNum),Fields.InValidMessage_append_email_username(TotalErrors.ErrorNum),Fields.InValidMessage_append_domain(TotalErrors.ErrorNum),Fields.InValidMessage_append_domain_type(TotalErrors.ErrorNum),Fields.InValidMessage_append_domain_root(TotalErrors.ErrorNum),Fields.InValidMessage_append_domain_ext(TotalErrors.ErrorNum),Fields.InValidMessage_append_is_tld_state(TotalErrors.ErrorNum),Fields.InValidMessage_append_is_tld_generic(TotalErrors.ErrorNum),Fields.InValidMessage_append_is_tld_country(TotalErrors.ErrorNum),Fields.InValidMessage_append_is_valid_domain_ext(TotalErrors.ErrorNum),Fields.InValidMessage_cleancollegeId(TotalErrors.ErrorNum),Fields.InValidMessage_cleantitle(TotalErrors.ErrorNum),Fields.InValidMessage_cleanfirstname(TotalErrors.ErrorNum),Fields.InValidMessage_cleanmidname(TotalErrors.ErrorNum),Fields.InValidMessage_cleanlastname(TotalErrors.ErrorNum),Fields.InValidMessage_cleansuffixname(TotalErrors.ErrorNum),Fields.InValidMessage_cleanzip(TotalErrors.ErrorNum),Fields.InValidMessage_cleanzip4(TotalErrors.ErrorNum),Fields.InValidMessage_cleanmajor(TotalErrors.ErrorNum),Fields.InValidMessage_cleanphone(TotalErrors.ErrorNum),Fields.InValidMessage_rcid(TotalErrors.ErrorNum),Fields.InValidMessage_did(TotalErrors.ErrorNum),Fields.InValidMessage_process_date(TotalErrors.ErrorNum),Fields.InValidMessage_date_first_seen(TotalErrors.ErrorNum),Fields.InValidMessage_date_last_seen(TotalErrors.ErrorNum),Fields.InValidMessage_vendor_first_reported(TotalErrors.ErrorNum),Fields.InValidMessage_vendor_last_reported(TotalErrors.ErrorNum),Fields.InValidMessage_dateupdated(TotalErrors.ErrorNum),Fields.InValidMessage_studentid(TotalErrors.ErrorNum),Fields.InValidMessage_dartid(TotalErrors.ErrorNum),Fields.InValidMessage_collegeid(TotalErrors.ErrorNum),Fields.InValidMessage_projectsource(TotalErrors.ErrorNum),Fields.InValidMessage_collegestate(TotalErrors.ErrorNum),Fields.InValidMessage_college(TotalErrors.ErrorNum),Fields.InValidMessage_semester(TotalErrors.ErrorNum),Fields.InValidMessage_year(TotalErrors.ErrorNum),Fields.InValidMessage_firstname(TotalErrors.ErrorNum),Fields.InValidMessage_middlename(TotalErrors.ErrorNum),Fields.InValidMessage_lastname(TotalErrors.ErrorNum),Fields.InValidMessage_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_major(TotalErrors.ErrorNum),Fields.InValidMessage_COLLEGE_MAJOR(TotalErrors.ErrorNum),Fields.InValidMessage_NEW_COLLEGE_MAJOR(TotalErrors.ErrorNum),Fields.InValidMessage_grade(TotalErrors.ErrorNum),Fields.InValidMessage_email(TotalErrors.ErrorNum),Fields.InValidMessage_dateofbirth(TotalErrors.ErrorNum),Fields.InValidMessage_dob_formatted(TotalErrors.ErrorNum),Fields.InValidMessage_attendancedate(TotalErrors.ErrorNum),Fields.InValidMessage_enrollmentstatus(TotalErrors.ErrorNum),Fields.InValidMessage_addresstype(TotalErrors.ErrorNum),Fields.InValidMessage_address1(TotalErrors.ErrorNum),Fields.InValidMessage_address2(TotalErrors.ErrorNum),Fields.InValidMessage_city(TotalErrors.ErrorNum),Fields.InValidMessage_state(TotalErrors.ErrorNum),Fields.InValidMessage_zip(TotalErrors.ErrorNum),Fields.InValidMessage_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_phonetyp(TotalErrors.ErrorNum),Fields.InValidMessage_phonenumber(TotalErrors.ErrorNum),Fields.InValidMessage_tier(TotalErrors.ErrorNum),Fields.InValidMessage_school_size_code(TotalErrors.ErrorNum),Fields.InValidMessage_competitive_code(TotalErrors.ErrorNum),Fields.InValidMessage_tuition_code(TotalErrors.ErrorNum),Fields.InValidMessage_title(TotalErrors.ErrorNum),Fields.InValidMessage_fname(TotalErrors.ErrorNum),Fields.InValidMessage_mname(TotalErrors.ErrorNum),Fields.InValidMessage_lname(TotalErrors.ErrorNum),Fields.InValidMessage_name_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_name_score(TotalErrors.ErrorNum),Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_predir(TotalErrors.ErrorNum),Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_addr_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_postdir(TotalErrors.ErrorNum),Fields.InValidMessage_unit_desig(TotalErrors.ErrorNum),Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_p_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_v_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_st(TotalErrors.ErrorNum),Fields.InValidMessage_z5(TotalErrors.ErrorNum),Fields.InValidMessage_z4(TotalErrors.ErrorNum),Fields.InValidMessage_cart(TotalErrors.ErrorNum),Fields.InValidMessage_cr_sort_sz(TotalErrors.ErrorNum),Fields.InValidMessage_lot(TotalErrors.ErrorNum),Fields.InValidMessage_lot_order(TotalErrors.ErrorNum),Fields.InValidMessage_dbpc(TotalErrors.ErrorNum),Fields.InValidMessage_chk_digit(TotalErrors.ErrorNum),Fields.InValidMessage_rec_type(TotalErrors.ErrorNum),Fields.InValidMessage_county(TotalErrors.ErrorNum),Fields.InValidMessage_fips_state(TotalErrors.ErrorNum),Fields.InValidMessage_fips_county(TotalErrors.ErrorNum),Fields.InValidMessage_geo_lat(TotalErrors.ErrorNum),Fields.InValidMessage_geo_long(TotalErrors.ErrorNum),Fields.InValidMessage_msa(TotalErrors.ErrorNum),Fields.InValidMessage_geo_blk(TotalErrors.ErrorNum),Fields.InValidMessage_geo_match(TotalErrors.ErrorNum),Fields.InValidMessage_err_stat(TotalErrors.ErrorNum),Fields.InValidMessage_telephone(TotalErrors.ErrorNum),Fields.InValidMessage_tier2(TotalErrors.ErrorNum),Fields.InValidMessage_source(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := JOIN(ValErr,TABLE(SourceCounts,{Source,NumberOfRecords}),LEFT.cleancollegeid=RIGHT.Source,LOOKUP); // Add source group counts for STRATA compliance
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doSummaryPerSrc = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
  fieldPopulationPerSource := Summary('', FALSE);
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_OKC_Student_List_V2, Fields, 'RECORDOF(fieldPopulationOverall)', TRUE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationPerSource_Standard := IF(doSummaryPerSrc, NORMALIZE(fieldPopulationPerSource, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'src', 'src')));
 
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', TRUE, 'all'));
  fieldPopulationPerSource_TotalRecs_Standard := IF(doSummaryPerSrc, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationPerSource, myTimeStamp, 'src', TRUE, 'src'));
 
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & fieldPopulationPerSource_Standard & fieldPopulationPerSource_TotalRecs_Standard & allProfiles_Standard;
END;
END;
