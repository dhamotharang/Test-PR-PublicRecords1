IMPORT SALT311,STD;
EXPORT In_Reg_hygiene(dataset(In_Reg_layout_Voters) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_active_status_cnt := COUNT(GROUP,h.active_status <> (TYPEOF(h.active_status))'');
    populated_active_status_pcnt := AVE(GROUP,IF(h.active_status = (TYPEOF(h.active_status))'',0,100));
    maxlength_active_status := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.active_status)));
    avelength_active_status := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.active_status)),h.active_status<>(typeof(h.active_status))'');
    populated_agecat_cnt := COUNT(GROUP,h.agecat <> (TYPEOF(h.agecat))'');
    populated_agecat_pcnt := AVE(GROUP,IF(h.agecat = (TYPEOF(h.agecat))'',0,100));
    maxlength_agecat := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.agecat)));
    avelength_agecat := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.agecat)),h.agecat<>(typeof(h.agecat))'');
    populated_changedate_cnt := COUNT(GROUP,h.changedate <> (TYPEOF(h.changedate))'');
    populated_changedate_pcnt := AVE(GROUP,IF(h.changedate = (TYPEOF(h.changedate))'',0,100));
    maxlength_changedate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.changedate)));
    avelength_changedate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.changedate)),h.changedate<>(typeof(h.changedate))'');
    populated_countycode_cnt := COUNT(GROUP,h.countycode <> (TYPEOF(h.countycode))'');
    populated_countycode_pcnt := AVE(GROUP,IF(h.countycode = (TYPEOF(h.countycode))'',0,100));
    maxlength_countycode := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.countycode)));
    avelength_countycode := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.countycode)),h.countycode<>(typeof(h.countycode))'');
    populated_distcode_cnt := COUNT(GROUP,h.distcode <> (TYPEOF(h.distcode))'');
    populated_distcode_pcnt := AVE(GROUP,IF(h.distcode = (TYPEOF(h.distcode))'',0,100));
    maxlength_distcode := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.distcode)));
    avelength_distcode := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.distcode)),h.distcode<>(typeof(h.distcode))'');
    populated_dob_cnt := COUNT(GROUP,h.dob <> (TYPEOF(h.dob))'');
    populated_dob_pcnt := AVE(GROUP,IF(h.dob = (TYPEOF(h.dob))'',0,100));
    maxlength_dob := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dob)));
    avelength_dob := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dob)),h.dob<>(typeof(h.dob))'');
    populated_EMID_number_cnt := COUNT(GROUP,h.EMID_number <> (TYPEOF(h.EMID_number))'');
    populated_EMID_number_pcnt := AVE(GROUP,IF(h.EMID_number = (TYPEOF(h.EMID_number))'',0,100));
    maxlength_EMID_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.EMID_number)));
    avelength_EMID_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.EMID_number)),h.EMID_number<>(typeof(h.EMID_number))'');
    populated_file_acquired_date_cnt := COUNT(GROUP,h.file_acquired_date <> (TYPEOF(h.file_acquired_date))'');
    populated_file_acquired_date_pcnt := AVE(GROUP,IF(h.file_acquired_date = (TYPEOF(h.file_acquired_date))'',0,100));
    maxlength_file_acquired_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.file_acquired_date)));
    avelength_file_acquired_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.file_acquired_date)),h.file_acquired_date<>(typeof(h.file_acquired_date))'');
    populated_first_name_cnt := COUNT(GROUP,h.first_name <> (TYPEOF(h.first_name))'');
    populated_first_name_pcnt := AVE(GROUP,IF(h.first_name = (TYPEOF(h.first_name))'',0,100));
    maxlength_first_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.first_name)));
    avelength_first_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.first_name)),h.first_name<>(typeof(h.first_name))'');
    populated_gender_cnt := COUNT(GROUP,h.gender <> (TYPEOF(h.gender))'');
    populated_gender_pcnt := AVE(GROUP,IF(h.gender = (TYPEOF(h.gender))'',0,100));
    maxlength_gender := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.gender)));
    avelength_gender := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.gender)),h.gender<>(typeof(h.gender))'');
    populated_gendersurnamguess_cnt := COUNT(GROUP,h.gendersurnamguess <> (TYPEOF(h.gendersurnamguess))'');
    populated_gendersurnamguess_pcnt := AVE(GROUP,IF(h.gendersurnamguess = (TYPEOF(h.gendersurnamguess))'',0,100));
    maxlength_gendersurnamguess := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.gendersurnamguess)));
    avelength_gendersurnamguess := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.gendersurnamguess)),h.gendersurnamguess<>(typeof(h.gendersurnamguess))'');
    populated_home_phone_cnt := COUNT(GROUP,h.home_phone <> (TYPEOF(h.home_phone))'');
    populated_home_phone_pcnt := AVE(GROUP,IF(h.home_phone = (TYPEOF(h.home_phone))'',0,100));
    maxlength_home_phone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.home_phone)));
    avelength_home_phone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.home_phone)),h.home_phone<>(typeof(h.home_phone))'');
    populated_idcode_cnt := COUNT(GROUP,h.idcode <> (TYPEOF(h.idcode))'');
    populated_idcode_pcnt := AVE(GROUP,IF(h.idcode = (TYPEOF(h.idcode))'',0,100));
    maxlength_idcode := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.idcode)));
    avelength_idcode := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.idcode)),h.idcode<>(typeof(h.idcode))'');
    populated_lastdatevote_cnt := COUNT(GROUP,h.lastdatevote <> (TYPEOF(h.lastdatevote))'');
    populated_lastdatevote_pcnt := AVE(GROUP,IF(h.lastdatevote = (TYPEOF(h.lastdatevote))'',0,100));
    maxlength_lastdatevote := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lastdatevote)));
    avelength_lastdatevote := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lastdatevote)),h.lastdatevote<>(typeof(h.lastdatevote))'');
    populated_last_name_cnt := COUNT(GROUP,h.last_name <> (TYPEOF(h.last_name))'');
    populated_last_name_pcnt := AVE(GROUP,IF(h.last_name = (TYPEOF(h.last_name))'',0,100));
    maxlength_last_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.last_name)));
    avelength_last_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.last_name)),h.last_name<>(typeof(h.last_name))'');
    populated_marriedappend_cnt := COUNT(GROUP,h.marriedappend <> (TYPEOF(h.marriedappend))'');
    populated_marriedappend_pcnt := AVE(GROUP,IF(h.marriedappend = (TYPEOF(h.marriedappend))'',0,100));
    maxlength_marriedappend := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.marriedappend)));
    avelength_marriedappend := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.marriedappend)),h.marriedappend<>(typeof(h.marriedappend))'');
    populated_middle_name_cnt := COUNT(GROUP,h.middle_name <> (TYPEOF(h.middle_name))'');
    populated_middle_name_pcnt := AVE(GROUP,IF(h.middle_name = (TYPEOF(h.middle_name))'',0,100));
    maxlength_middle_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.middle_name)));
    avelength_middle_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.middle_name)),h.middle_name<>(typeof(h.middle_name))'');
    populated_political_party_cnt := COUNT(GROUP,h.political_party <> (TYPEOF(h.political_party))'');
    populated_political_party_pcnt := AVE(GROUP,IF(h.political_party = (TYPEOF(h.political_party))'',0,100));
    maxlength_political_party := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.political_party)));
    avelength_political_party := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.political_party)),h.political_party<>(typeof(h.political_party))'');
    populated_race_cnt := COUNT(GROUP,h.race <> (TYPEOF(h.race))'');
    populated_race_pcnt := AVE(GROUP,IF(h.race = (TYPEOF(h.race))'',0,100));
    maxlength_race := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.race)));
    avelength_race := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.race)),h.race<>(typeof(h.race))'');
    populated_regdate_cnt := COUNT(GROUP,h.regdate <> (TYPEOF(h.regdate))'');
    populated_regdate_pcnt := AVE(GROUP,IF(h.regdate = (TYPEOF(h.regdate))'',0,100));
    maxlength_regdate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.regdate)));
    avelength_regdate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.regdate)),h.regdate<>(typeof(h.regdate))'');
    populated_res_addr1_cnt := COUNT(GROUP,h.res_addr1 <> (TYPEOF(h.res_addr1))'');
    populated_res_addr1_pcnt := AVE(GROUP,IF(h.res_addr1 = (TYPEOF(h.res_addr1))'',0,100));
    maxlength_res_addr1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.res_addr1)));
    avelength_res_addr1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.res_addr1)),h.res_addr1<>(typeof(h.res_addr1))'');
    populated_res_city_cnt := COUNT(GROUP,h.res_city <> (TYPEOF(h.res_city))'');
    populated_res_city_pcnt := AVE(GROUP,IF(h.res_city = (TYPEOF(h.res_city))'',0,100));
    maxlength_res_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.res_city)));
    avelength_res_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.res_city)),h.res_city<>(typeof(h.res_city))'');
    populated_res_state_cnt := COUNT(GROUP,h.res_state <> (TYPEOF(h.res_state))'');
    populated_res_state_pcnt := AVE(GROUP,IF(h.res_state = (TYPEOF(h.res_state))'',0,100));
    maxlength_res_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.res_state)));
    avelength_res_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.res_state)),h.res_state<>(typeof(h.res_state))'');
    populated_res_zip_cnt := COUNT(GROUP,h.res_zip <> (TYPEOF(h.res_zip))'');
    populated_res_zip_pcnt := AVE(GROUP,IF(h.res_zip = (TYPEOF(h.res_zip))'',0,100));
    maxlength_res_zip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.res_zip)));
    avelength_res_zip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.res_zip)),h.res_zip<>(typeof(h.res_zip))'');
    populated_schoolcode_cnt := COUNT(GROUP,h.schoolcode <> (TYPEOF(h.schoolcode))'');
    populated_schoolcode_pcnt := AVE(GROUP,IF(h.schoolcode = (TYPEOF(h.schoolcode))'',0,100));
    maxlength_schoolcode := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.schoolcode)));
    avelength_schoolcode := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.schoolcode)),h.schoolcode<>(typeof(h.schoolcode))'');
    populated_source_voterid_cnt := COUNT(GROUP,h.source_voterid <> (TYPEOF(h.source_voterid))'');
    populated_source_voterid_pcnt := AVE(GROUP,IF(h.source_voterid = (TYPEOF(h.source_voterid))'',0,100));
    maxlength_source_voterid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.source_voterid)));
    avelength_source_voterid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.source_voterid)),h.source_voterid<>(typeof(h.source_voterid))'');
    populated_statehouse_cnt := COUNT(GROUP,h.statehouse <> (TYPEOF(h.statehouse))'');
    populated_statehouse_pcnt := AVE(GROUP,IF(h.statehouse = (TYPEOF(h.statehouse))'',0,100));
    maxlength_statehouse := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.statehouse)));
    avelength_statehouse := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.statehouse)),h.statehouse<>(typeof(h.statehouse))'');
    populated_statesenate_cnt := COUNT(GROUP,h.statesenate <> (TYPEOF(h.statesenate))'');
    populated_statesenate_pcnt := AVE(GROUP,IF(h.statesenate = (TYPEOF(h.statesenate))'',0,100));
    maxlength_statesenate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.statesenate)));
    avelength_statesenate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.statesenate)),h.statesenate<>(typeof(h.statesenate))'');
    populated_state_code_cnt := COUNT(GROUP,h.state_code <> (TYPEOF(h.state_code))'');
    populated_state_code_pcnt := AVE(GROUP,IF(h.state_code = (TYPEOF(h.state_code))'',0,100));
    maxlength_state_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.state_code)));
    avelength_state_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.state_code)),h.state_code<>(typeof(h.state_code))'');
    populated_timezonetbl_cnt := COUNT(GROUP,h.timezonetbl <> (TYPEOF(h.timezonetbl))'');
    populated_timezonetbl_pcnt := AVE(GROUP,IF(h.timezonetbl = (TYPEOF(h.timezonetbl))'',0,100));
    maxlength_timezonetbl := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.timezonetbl)));
    avelength_timezonetbl := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.timezonetbl)),h.timezonetbl<>(typeof(h.timezonetbl))'');
    populated_ushouse_cnt := COUNT(GROUP,h.ushouse <> (TYPEOF(h.ushouse))'');
    populated_ushouse_pcnt := AVE(GROUP,IF(h.ushouse = (TYPEOF(h.ushouse))'',0,100));
    maxlength_ushouse := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ushouse)));
    avelength_ushouse := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ushouse)),h.ushouse<>(typeof(h.ushouse))'');
    populated_voter_status_cnt := COUNT(GROUP,h.voter_status <> (TYPEOF(h.voter_status))'');
    populated_voter_status_pcnt := AVE(GROUP,IF(h.voter_status = (TYPEOF(h.voter_status))'',0,100));
    maxlength_voter_status := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.voter_status)));
    avelength_voter_status := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.voter_status)),h.voter_status<>(typeof(h.voter_status))'');
    populated_work_phone_cnt := COUNT(GROUP,h.work_phone <> (TYPEOF(h.work_phone))'');
    populated_work_phone_pcnt := AVE(GROUP,IF(h.work_phone = (TYPEOF(h.work_phone))'',0,100));
    maxlength_work_phone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.work_phone)));
    avelength_work_phone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.work_phone)),h.work_phone<>(typeof(h.work_phone))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_active_status_pcnt *   0.00 / 100 + T.Populated_agecat_pcnt *   0.00 / 100 + T.Populated_changedate_pcnt *   0.00 / 100 + T.Populated_countycode_pcnt *   0.00 / 100 + T.Populated_distcode_pcnt *   0.00 / 100 + T.Populated_dob_pcnt *   0.00 / 100 + T.Populated_EMID_number_pcnt *   0.00 / 100 + T.Populated_file_acquired_date_pcnt *   0.00 / 100 + T.Populated_first_name_pcnt *   0.00 / 100 + T.Populated_gender_pcnt *   0.00 / 100 + T.Populated_gendersurnamguess_pcnt *   0.00 / 100 + T.Populated_home_phone_pcnt *   0.00 / 100 + T.Populated_idcode_pcnt *   0.00 / 100 + T.Populated_lastdatevote_pcnt *   0.00 / 100 + T.Populated_last_name_pcnt *   0.00 / 100 + T.Populated_marriedappend_pcnt *   0.00 / 100 + T.Populated_middle_name_pcnt *   0.00 / 100 + T.Populated_political_party_pcnt *   0.00 / 100 + T.Populated_race_pcnt *   0.00 / 100 + T.Populated_regdate_pcnt *   0.00 / 100 + T.Populated_res_addr1_pcnt *   0.00 / 100 + T.Populated_res_city_pcnt *   0.00 / 100 + T.Populated_res_state_pcnt *   0.00 / 100 + T.Populated_res_zip_pcnt *   0.00 / 100 + T.Populated_schoolcode_pcnt *   0.00 / 100 + T.Populated_source_voterid_pcnt *   0.00 / 100 + T.Populated_statehouse_pcnt *   0.00 / 100 + T.Populated_statesenate_pcnt *   0.00 / 100 + T.Populated_state_code_pcnt *   0.00 / 100 + T.Populated_timezonetbl_pcnt *   0.00 / 100 + T.Populated_ushouse_pcnt *   0.00 / 100 + T.Populated_voter_status_pcnt *   0.00 / 100 + T.Populated_work_phone_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
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
  SELF.FieldName := CHOOSE(C,'active_status','agecat','changedate','countycode','distcode','dob','EMID_number','file_acquired_date','first_name','gender','gendersurnamguess','home_phone','idcode','lastdatevote','last_name','marriedappend','middle_name','political_party','race','regdate','res_addr1','res_city','res_state','res_zip','schoolcode','source_voterid','statehouse','statesenate','state_code','timezonetbl','ushouse','voter_status','work_phone');
  SELF.populated_pcnt := CHOOSE(C,le.populated_active_status_pcnt,le.populated_agecat_pcnt,le.populated_changedate_pcnt,le.populated_countycode_pcnt,le.populated_distcode_pcnt,le.populated_dob_pcnt,le.populated_EMID_number_pcnt,le.populated_file_acquired_date_pcnt,le.populated_first_name_pcnt,le.populated_gender_pcnt,le.populated_gendersurnamguess_pcnt,le.populated_home_phone_pcnt,le.populated_idcode_pcnt,le.populated_lastdatevote_pcnt,le.populated_last_name_pcnt,le.populated_marriedappend_pcnt,le.populated_middle_name_pcnt,le.populated_political_party_pcnt,le.populated_race_pcnt,le.populated_regdate_pcnt,le.populated_res_addr1_pcnt,le.populated_res_city_pcnt,le.populated_res_state_pcnt,le.populated_res_zip_pcnt,le.populated_schoolcode_pcnt,le.populated_source_voterid_pcnt,le.populated_statehouse_pcnt,le.populated_statesenate_pcnt,le.populated_state_code_pcnt,le.populated_timezonetbl_pcnt,le.populated_ushouse_pcnt,le.populated_voter_status_pcnt,le.populated_work_phone_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_active_status,le.maxlength_agecat,le.maxlength_changedate,le.maxlength_countycode,le.maxlength_distcode,le.maxlength_dob,le.maxlength_EMID_number,le.maxlength_file_acquired_date,le.maxlength_first_name,le.maxlength_gender,le.maxlength_gendersurnamguess,le.maxlength_home_phone,le.maxlength_idcode,le.maxlength_lastdatevote,le.maxlength_last_name,le.maxlength_marriedappend,le.maxlength_middle_name,le.maxlength_political_party,le.maxlength_race,le.maxlength_regdate,le.maxlength_res_addr1,le.maxlength_res_city,le.maxlength_res_state,le.maxlength_res_zip,le.maxlength_schoolcode,le.maxlength_source_voterid,le.maxlength_statehouse,le.maxlength_statesenate,le.maxlength_state_code,le.maxlength_timezonetbl,le.maxlength_ushouse,le.maxlength_voter_status,le.maxlength_work_phone);
  SELF.avelength := CHOOSE(C,le.avelength_active_status,le.avelength_agecat,le.avelength_changedate,le.avelength_countycode,le.avelength_distcode,le.avelength_dob,le.avelength_EMID_number,le.avelength_file_acquired_date,le.avelength_first_name,le.avelength_gender,le.avelength_gendersurnamguess,le.avelength_home_phone,le.avelength_idcode,le.avelength_lastdatevote,le.avelength_last_name,le.avelength_marriedappend,le.avelength_middle_name,le.avelength_political_party,le.avelength_race,le.avelength_regdate,le.avelength_res_addr1,le.avelength_res_city,le.avelength_res_state,le.avelength_res_zip,le.avelength_schoolcode,le.avelength_source_voterid,le.avelength_statehouse,le.avelength_statesenate,le.avelength_state_code,le.avelength_timezonetbl,le.avelength_ushouse,le.avelength_voter_status,le.avelength_work_phone);
END;
EXPORT invSummary := NORMALIZE(summary0, 33, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.active_status),TRIM((SALT311.StrType)le.agecat),TRIM((SALT311.StrType)le.changedate),TRIM((SALT311.StrType)le.countycode),TRIM((SALT311.StrType)le.distcode),TRIM((SALT311.StrType)le.dob),TRIM((SALT311.StrType)le.EMID_number),TRIM((SALT311.StrType)le.file_acquired_date),TRIM((SALT311.StrType)le.first_name),TRIM((SALT311.StrType)le.gender),TRIM((SALT311.StrType)le.gendersurnamguess),TRIM((SALT311.StrType)le.home_phone),TRIM((SALT311.StrType)le.idcode),TRIM((SALT311.StrType)le.lastdatevote),TRIM((SALT311.StrType)le.last_name),TRIM((SALT311.StrType)le.marriedappend),TRIM((SALT311.StrType)le.middle_name),TRIM((SALT311.StrType)le.political_party),TRIM((SALT311.StrType)le.race),TRIM((SALT311.StrType)le.regdate),TRIM((SALT311.StrType)le.res_addr1),TRIM((SALT311.StrType)le.res_city),TRIM((SALT311.StrType)le.res_state),TRIM((SALT311.StrType)le.res_zip),TRIM((SALT311.StrType)le.schoolcode),TRIM((SALT311.StrType)le.source_voterid),TRIM((SALT311.StrType)le.statehouse),TRIM((SALT311.StrType)le.statesenate),TRIM((SALT311.StrType)le.state_code),TRIM((SALT311.StrType)le.timezonetbl),TRIM((SALT311.StrType)le.ushouse),TRIM((SALT311.StrType)le.voter_status),TRIM((SALT311.StrType)le.work_phone)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,33,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 33);
  SELF.FldNo2 := 1 + (C % 33);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.active_status),TRIM((SALT311.StrType)le.agecat),TRIM((SALT311.StrType)le.changedate),TRIM((SALT311.StrType)le.countycode),TRIM((SALT311.StrType)le.distcode),TRIM((SALT311.StrType)le.dob),TRIM((SALT311.StrType)le.EMID_number),TRIM((SALT311.StrType)le.file_acquired_date),TRIM((SALT311.StrType)le.first_name),TRIM((SALT311.StrType)le.gender),TRIM((SALT311.StrType)le.gendersurnamguess),TRIM((SALT311.StrType)le.home_phone),TRIM((SALT311.StrType)le.idcode),TRIM((SALT311.StrType)le.lastdatevote),TRIM((SALT311.StrType)le.last_name),TRIM((SALT311.StrType)le.marriedappend),TRIM((SALT311.StrType)le.middle_name),TRIM((SALT311.StrType)le.political_party),TRIM((SALT311.StrType)le.race),TRIM((SALT311.StrType)le.regdate),TRIM((SALT311.StrType)le.res_addr1),TRIM((SALT311.StrType)le.res_city),TRIM((SALT311.StrType)le.res_state),TRIM((SALT311.StrType)le.res_zip),TRIM((SALT311.StrType)le.schoolcode),TRIM((SALT311.StrType)le.source_voterid),TRIM((SALT311.StrType)le.statehouse),TRIM((SALT311.StrType)le.statesenate),TRIM((SALT311.StrType)le.state_code),TRIM((SALT311.StrType)le.timezonetbl),TRIM((SALT311.StrType)le.ushouse),TRIM((SALT311.StrType)le.voter_status),TRIM((SALT311.StrType)le.work_phone)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.active_status),TRIM((SALT311.StrType)le.agecat),TRIM((SALT311.StrType)le.changedate),TRIM((SALT311.StrType)le.countycode),TRIM((SALT311.StrType)le.distcode),TRIM((SALT311.StrType)le.dob),TRIM((SALT311.StrType)le.EMID_number),TRIM((SALT311.StrType)le.file_acquired_date),TRIM((SALT311.StrType)le.first_name),TRIM((SALT311.StrType)le.gender),TRIM((SALT311.StrType)le.gendersurnamguess),TRIM((SALT311.StrType)le.home_phone),TRIM((SALT311.StrType)le.idcode),TRIM((SALT311.StrType)le.lastdatevote),TRIM((SALT311.StrType)le.last_name),TRIM((SALT311.StrType)le.marriedappend),TRIM((SALT311.StrType)le.middle_name),TRIM((SALT311.StrType)le.political_party),TRIM((SALT311.StrType)le.race),TRIM((SALT311.StrType)le.regdate),TRIM((SALT311.StrType)le.res_addr1),TRIM((SALT311.StrType)le.res_city),TRIM((SALT311.StrType)le.res_state),TRIM((SALT311.StrType)le.res_zip),TRIM((SALT311.StrType)le.schoolcode),TRIM((SALT311.StrType)le.source_voterid),TRIM((SALT311.StrType)le.statehouse),TRIM((SALT311.StrType)le.statesenate),TRIM((SALT311.StrType)le.state_code),TRIM((SALT311.StrType)le.timezonetbl),TRIM((SALT311.StrType)le.ushouse),TRIM((SALT311.StrType)le.voter_status),TRIM((SALT311.StrType)le.work_phone)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),33*33,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'active_status'}
      ,{2,'agecat'}
      ,{3,'changedate'}
      ,{4,'countycode'}
      ,{5,'distcode'}
      ,{6,'dob'}
      ,{7,'EMID_number'}
      ,{8,'file_acquired_date'}
      ,{9,'first_name'}
      ,{10,'gender'}
      ,{11,'gendersurnamguess'}
      ,{12,'home_phone'}
      ,{13,'idcode'}
      ,{14,'lastdatevote'}
      ,{15,'last_name'}
      ,{16,'marriedappend'}
      ,{17,'middle_name'}
      ,{18,'political_party'}
      ,{19,'race'}
      ,{20,'regdate'}
      ,{21,'res_addr1'}
      ,{22,'res_city'}
      ,{23,'res_state'}
      ,{24,'res_zip'}
      ,{25,'schoolcode'}
      ,{26,'source_voterid'}
      ,{27,'statehouse'}
      ,{28,'statesenate'}
      ,{29,'state_code'}
      ,{30,'timezonetbl'}
      ,{31,'ushouse'}
      ,{32,'voter_status'}
      ,{33,'work_phone'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    In_Reg_Fields.InValid_active_status((SALT311.StrType)le.active_status),
    In_Reg_Fields.InValid_agecat((SALT311.StrType)le.agecat),
    In_Reg_Fields.InValid_changedate((SALT311.StrType)le.changedate),
    In_Reg_Fields.InValid_countycode((SALT311.StrType)le.countycode),
    In_Reg_Fields.InValid_distcode((SALT311.StrType)le.distcode),
    In_Reg_Fields.InValid_dob((SALT311.StrType)le.dob),
    In_Reg_Fields.InValid_EMID_number((SALT311.StrType)le.EMID_number),
    In_Reg_Fields.InValid_file_acquired_date((SALT311.StrType)le.file_acquired_date),
    In_Reg_Fields.InValid_first_name((SALT311.StrType)le.first_name),
    In_Reg_Fields.InValid_gender((SALT311.StrType)le.gender),
    In_Reg_Fields.InValid_gendersurnamguess((SALT311.StrType)le.gendersurnamguess),
    In_Reg_Fields.InValid_home_phone((SALT311.StrType)le.home_phone),
    In_Reg_Fields.InValid_idcode((SALT311.StrType)le.idcode),
    In_Reg_Fields.InValid_lastdatevote((SALT311.StrType)le.lastdatevote),
    In_Reg_Fields.InValid_last_name((SALT311.StrType)le.last_name,(SALT311.StrType)le.first_name,(SALT311.StrType)le.middle_name),
    In_Reg_Fields.InValid_marriedappend((SALT311.StrType)le.marriedappend),
    In_Reg_Fields.InValid_middle_name((SALT311.StrType)le.middle_name),
    In_Reg_Fields.InValid_political_party((SALT311.StrType)le.political_party),
    In_Reg_Fields.InValid_race((SALT311.StrType)le.race),
    In_Reg_Fields.InValid_regdate((SALT311.StrType)le.regdate),
    In_Reg_Fields.InValid_res_addr1((SALT311.StrType)le.res_addr1),
    In_Reg_Fields.InValid_res_city((SALT311.StrType)le.res_city),
    In_Reg_Fields.InValid_res_state((SALT311.StrType)le.res_state),
    In_Reg_Fields.InValid_res_zip((SALT311.StrType)le.res_zip),
    In_Reg_Fields.InValid_schoolcode((SALT311.StrType)le.schoolcode),
    In_Reg_Fields.InValid_source_voterid((SALT311.StrType)le.source_voterid),
    In_Reg_Fields.InValid_statehouse((SALT311.StrType)le.statehouse),
    In_Reg_Fields.InValid_statesenate((SALT311.StrType)le.statesenate),
    In_Reg_Fields.InValid_state_code((SALT311.StrType)le.state_code),
    In_Reg_Fields.InValid_timezonetbl((SALT311.StrType)le.timezonetbl),
    In_Reg_Fields.InValid_ushouse((SALT311.StrType)le.ushouse),
    In_Reg_Fields.InValid_voter_status((SALT311.StrType)le.voter_status),
    In_Reg_Fields.InValid_work_phone((SALT311.StrType)le.work_phone),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,33,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := In_Reg_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_alphanum_empty','invalid_agecat','invalid_changedate','invalid_alphanum_empty','invalid_alphanum_empty','invalid_dob','invalid_alphanum','invalid_pastdate8','invalid_alphanum_specials','invalid_gender','invalid_alphanum_empty','invalid_phone','invalid_alphanum_empty','invalid_lastdatevote','invalid_last_name','invalid_boolean_yn_empty','invalid_alphanum_empty_specials','invalid_nums_empty','invalid_race','invalid_regdate','invalid_mandatory','invalid_mandatory','invalid_st','invalid_mandatory','invalid_alphanum_empty','invalid_alphanum','invalid_alphanum_empty','invalid_alphanumquot_empty','invalid_source_state','invalid_nums_empty','invalid_alphanum_empty','invalid_alphanum_empty','invalid_phone');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,In_Reg_Fields.InValidMessage_active_status(TotalErrors.ErrorNum),In_Reg_Fields.InValidMessage_agecat(TotalErrors.ErrorNum),In_Reg_Fields.InValidMessage_changedate(TotalErrors.ErrorNum),In_Reg_Fields.InValidMessage_countycode(TotalErrors.ErrorNum),In_Reg_Fields.InValidMessage_distcode(TotalErrors.ErrorNum),In_Reg_Fields.InValidMessage_dob(TotalErrors.ErrorNum),In_Reg_Fields.InValidMessage_EMID_number(TotalErrors.ErrorNum),In_Reg_Fields.InValidMessage_file_acquired_date(TotalErrors.ErrorNum),In_Reg_Fields.InValidMessage_first_name(TotalErrors.ErrorNum),In_Reg_Fields.InValidMessage_gender(TotalErrors.ErrorNum),In_Reg_Fields.InValidMessage_gendersurnamguess(TotalErrors.ErrorNum),In_Reg_Fields.InValidMessage_home_phone(TotalErrors.ErrorNum),In_Reg_Fields.InValidMessage_idcode(TotalErrors.ErrorNum),In_Reg_Fields.InValidMessage_lastdatevote(TotalErrors.ErrorNum),In_Reg_Fields.InValidMessage_last_name(TotalErrors.ErrorNum),In_Reg_Fields.InValidMessage_marriedappend(TotalErrors.ErrorNum),In_Reg_Fields.InValidMessage_middle_name(TotalErrors.ErrorNum),In_Reg_Fields.InValidMessage_political_party(TotalErrors.ErrorNum),In_Reg_Fields.InValidMessage_race(TotalErrors.ErrorNum),In_Reg_Fields.InValidMessage_regdate(TotalErrors.ErrorNum),In_Reg_Fields.InValidMessage_res_addr1(TotalErrors.ErrorNum),In_Reg_Fields.InValidMessage_res_city(TotalErrors.ErrorNum),In_Reg_Fields.InValidMessage_res_state(TotalErrors.ErrorNum),In_Reg_Fields.InValidMessage_res_zip(TotalErrors.ErrorNum),In_Reg_Fields.InValidMessage_schoolcode(TotalErrors.ErrorNum),In_Reg_Fields.InValidMessage_source_voterid(TotalErrors.ErrorNum),In_Reg_Fields.InValidMessage_statehouse(TotalErrors.ErrorNum),In_Reg_Fields.InValidMessage_statesenate(TotalErrors.ErrorNum),In_Reg_Fields.InValidMessage_state_code(TotalErrors.ErrorNum),In_Reg_Fields.InValidMessage_timezonetbl(TotalErrors.ErrorNum),In_Reg_Fields.InValidMessage_ushouse(TotalErrors.ErrorNum),In_Reg_Fields.InValidMessage_voter_status(TotalErrors.ErrorNum),In_Reg_Fields.InValidMessage_work_phone(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Voters, In_Reg_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
