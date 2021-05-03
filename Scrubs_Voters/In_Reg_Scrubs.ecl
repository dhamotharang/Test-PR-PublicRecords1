IMPORT SALT311,STD;
IMPORT Scrubs_Voters; // Import modules for FieldTypes attribute definitions
EXPORT In_Reg_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 33;
  EXPORT NumRulesFromFieldType := 33;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 33;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(In_Reg_Layout_Voters)
    UNSIGNED1 active_status_Invalid;
    UNSIGNED1 agecat_Invalid;
    UNSIGNED1 changedate_Invalid;
    UNSIGNED1 countycode_Invalid;
    UNSIGNED1 distcode_Invalid;
    UNSIGNED1 dob_Invalid;
    UNSIGNED1 EMID_number_Invalid;
    UNSIGNED1 file_acquired_date_Invalid;
    UNSIGNED1 first_name_Invalid;
    UNSIGNED1 gender_Invalid;
    UNSIGNED1 gendersurnamguess_Invalid;
    UNSIGNED1 home_phone_Invalid;
    UNSIGNED1 idcode_Invalid;
    UNSIGNED1 lastdatevote_Invalid;
    UNSIGNED1 last_name_Invalid;
    UNSIGNED1 marriedappend_Invalid;
    UNSIGNED1 middle_name_Invalid;
    UNSIGNED1 political_party_Invalid;
    UNSIGNED1 race_Invalid;
    UNSIGNED1 regdate_Invalid;
    UNSIGNED1 res_addr1_Invalid;
    UNSIGNED1 res_city_Invalid;
    UNSIGNED1 res_state_Invalid;
    UNSIGNED1 res_zip_Invalid;
    UNSIGNED1 schoolcode_Invalid;
    UNSIGNED1 source_voterid_Invalid;
    UNSIGNED1 statehouse_Invalid;
    UNSIGNED1 statesenate_Invalid;
    UNSIGNED1 state_code_Invalid;
    UNSIGNED1 timezonetbl_Invalid;
    UNSIGNED1 ushouse_Invalid;
    UNSIGNED1 voter_status_Invalid;
    UNSIGNED1 work_phone_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(In_Reg_Layout_Voters)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(In_Reg_Layout_Voters) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.active_status_Invalid := In_Reg_Fields.InValid_active_status((SALT311.StrType)le.active_status);
    SELF.agecat_Invalid := In_Reg_Fields.InValid_agecat((SALT311.StrType)le.agecat);
    SELF.changedate_Invalid := In_Reg_Fields.InValid_changedate((SALT311.StrType)le.changedate);
    SELF.countycode_Invalid := In_Reg_Fields.InValid_countycode((SALT311.StrType)le.countycode);
    SELF.distcode_Invalid := In_Reg_Fields.InValid_distcode((SALT311.StrType)le.distcode);
    SELF.dob_Invalid := In_Reg_Fields.InValid_dob((SALT311.StrType)le.dob);
    SELF.EMID_number_Invalid := In_Reg_Fields.InValid_EMID_number((SALT311.StrType)le.EMID_number);
    SELF.file_acquired_date_Invalid := In_Reg_Fields.InValid_file_acquired_date((SALT311.StrType)le.file_acquired_date);
    SELF.first_name_Invalid := In_Reg_Fields.InValid_first_name((SALT311.StrType)le.first_name);
    SELF.gender_Invalid := In_Reg_Fields.InValid_gender((SALT311.StrType)le.gender);
    SELF.gendersurnamguess_Invalid := In_Reg_Fields.InValid_gendersurnamguess((SALT311.StrType)le.gendersurnamguess);
    SELF.home_phone_Invalid := In_Reg_Fields.InValid_home_phone((SALT311.StrType)le.home_phone);
    SELF.idcode_Invalid := In_Reg_Fields.InValid_idcode((SALT311.StrType)le.idcode);
    SELF.lastdatevote_Invalid := In_Reg_Fields.InValid_lastdatevote((SALT311.StrType)le.lastdatevote);
    SELF.last_name_Invalid := In_Reg_Fields.InValid_last_name((SALT311.StrType)le.last_name,(SALT311.StrType)le.first_name,(SALT311.StrType)le.middle_name);
    SELF.marriedappend_Invalid := In_Reg_Fields.InValid_marriedappend((SALT311.StrType)le.marriedappend);
    SELF.middle_name_Invalid := In_Reg_Fields.InValid_middle_name((SALT311.StrType)le.middle_name);
    SELF.political_party_Invalid := In_Reg_Fields.InValid_political_party((SALT311.StrType)le.political_party);
    SELF.race_Invalid := In_Reg_Fields.InValid_race((SALT311.StrType)le.race);
    SELF.regdate_Invalid := In_Reg_Fields.InValid_regdate((SALT311.StrType)le.regdate);
    SELF.res_addr1_Invalid := In_Reg_Fields.InValid_res_addr1((SALT311.StrType)le.res_addr1);
    SELF.res_city_Invalid := In_Reg_Fields.InValid_res_city((SALT311.StrType)le.res_city);
    SELF.res_state_Invalid := In_Reg_Fields.InValid_res_state((SALT311.StrType)le.res_state);
    SELF.res_zip_Invalid := In_Reg_Fields.InValid_res_zip((SALT311.StrType)le.res_zip);
    SELF.schoolcode_Invalid := In_Reg_Fields.InValid_schoolcode((SALT311.StrType)le.schoolcode);
    SELF.source_voterid_Invalid := In_Reg_Fields.InValid_source_voterid((SALT311.StrType)le.source_voterid);
    SELF.statehouse_Invalid := In_Reg_Fields.InValid_statehouse((SALT311.StrType)le.statehouse);
    SELF.statesenate_Invalid := In_Reg_Fields.InValid_statesenate((SALT311.StrType)le.statesenate);
    SELF.state_code_Invalid := In_Reg_Fields.InValid_state_code((SALT311.StrType)le.state_code);
    SELF.timezonetbl_Invalid := In_Reg_Fields.InValid_timezonetbl((SALT311.StrType)le.timezonetbl);
    SELF.ushouse_Invalid := In_Reg_Fields.InValid_ushouse((SALT311.StrType)le.ushouse);
    SELF.voter_status_Invalid := In_Reg_Fields.InValid_voter_status((SALT311.StrType)le.voter_status);
    SELF.work_phone_Invalid := In_Reg_Fields.InValid_work_phone((SALT311.StrType)le.work_phone);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),In_Reg_Layout_Voters);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.active_status_Invalid << 0 ) + ( le.agecat_Invalid << 1 ) + ( le.changedate_Invalid << 2 ) + ( le.countycode_Invalid << 3 ) + ( le.distcode_Invalid << 4 ) + ( le.dob_Invalid << 5 ) + ( le.EMID_number_Invalid << 6 ) + ( le.file_acquired_date_Invalid << 7 ) + ( le.first_name_Invalid << 8 ) + ( le.gender_Invalid << 9 ) + ( le.gendersurnamguess_Invalid << 10 ) + ( le.home_phone_Invalid << 11 ) + ( le.idcode_Invalid << 12 ) + ( le.lastdatevote_Invalid << 13 ) + ( le.last_name_Invalid << 14 ) + ( le.marriedappend_Invalid << 15 ) + ( le.middle_name_Invalid << 16 ) + ( le.political_party_Invalid << 17 ) + ( le.race_Invalid << 18 ) + ( le.regdate_Invalid << 19 ) + ( le.res_addr1_Invalid << 20 ) + ( le.res_city_Invalid << 21 ) + ( le.res_state_Invalid << 22 ) + ( le.res_zip_Invalid << 23 ) + ( le.schoolcode_Invalid << 24 ) + ( le.source_voterid_Invalid << 25 ) + ( le.statehouse_Invalid << 26 ) + ( le.statesenate_Invalid << 27 ) + ( le.state_code_Invalid << 28 ) + ( le.timezonetbl_Invalid << 29 ) + ( le.ushouse_Invalid << 30 ) + ( le.voter_status_Invalid << 31 ) + ( le.work_phone_Invalid << 32 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,In_Reg_Layout_Voters);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.active_status_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.agecat_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.changedate_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.countycode_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.distcode_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.dob_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.EMID_number_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.file_acquired_date_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.first_name_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.gender_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.gendersurnamguess_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.home_phone_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.idcode_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.lastdatevote_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.last_name_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.marriedappend_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.middle_name_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.political_party_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.race_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.regdate_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.res_addr1_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.res_city_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.res_state_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.res_zip_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.schoolcode_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.source_voterid_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.statehouse_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.statesenate_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.state_code_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.timezonetbl_Invalid := (le.ScrubsBits1 >> 29) & 1;
    SELF.ushouse_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.voter_status_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.work_phone_Invalid := (le.ScrubsBits1 >> 32) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    active_status_ALLOW_ErrorCount := COUNT(GROUP,h.active_status_Invalid=1);
    agecat_CUSTOM_ErrorCount := COUNT(GROUP,h.agecat_Invalid=1);
    changedate_CUSTOM_ErrorCount := COUNT(GROUP,h.changedate_Invalid=1);
    countycode_ALLOW_ErrorCount := COUNT(GROUP,h.countycode_Invalid=1);
    distcode_ALLOW_ErrorCount := COUNT(GROUP,h.distcode_Invalid=1);
    dob_CUSTOM_ErrorCount := COUNT(GROUP,h.dob_Invalid=1);
    EMID_number_CUSTOM_ErrorCount := COUNT(GROUP,h.EMID_number_Invalid=1);
    file_acquired_date_CUSTOM_ErrorCount := COUNT(GROUP,h.file_acquired_date_Invalid=1);
    first_name_CUSTOM_ErrorCount := COUNT(GROUP,h.first_name_Invalid=1);
    gender_ENUM_ErrorCount := COUNT(GROUP,h.gender_Invalid=1);
    gendersurnamguess_ALLOW_ErrorCount := COUNT(GROUP,h.gendersurnamguess_Invalid=1);
    home_phone_CUSTOM_ErrorCount := COUNT(GROUP,h.home_phone_Invalid=1);
    idcode_ALLOW_ErrorCount := COUNT(GROUP,h.idcode_Invalid=1);
    lastdatevote_CUSTOM_ErrorCount := COUNT(GROUP,h.lastdatevote_Invalid=1);
    last_name_CUSTOM_ErrorCount := COUNT(GROUP,h.last_name_Invalid=1);
    marriedappend_ENUM_ErrorCount := COUNT(GROUP,h.marriedappend_Invalid=1);
    middle_name_ALLOW_ErrorCount := COUNT(GROUP,h.middle_name_Invalid=1);
    political_party_ALLOW_ErrorCount := COUNT(GROUP,h.political_party_Invalid=1);
    race_CUSTOM_ErrorCount := COUNT(GROUP,h.race_Invalid=1);
    regdate_CUSTOM_ErrorCount := COUNT(GROUP,h.regdate_Invalid=1);
    res_addr1_CUSTOM_ErrorCount := COUNT(GROUP,h.res_addr1_Invalid=1);
    res_city_CUSTOM_ErrorCount := COUNT(GROUP,h.res_city_Invalid=1);
    res_state_CUSTOM_ErrorCount := COUNT(GROUP,h.res_state_Invalid=1);
    res_zip_CUSTOM_ErrorCount := COUNT(GROUP,h.res_zip_Invalid=1);
    schoolcode_ALLOW_ErrorCount := COUNT(GROUP,h.schoolcode_Invalid=1);
    source_voterid_CUSTOM_ErrorCount := COUNT(GROUP,h.source_voterid_Invalid=1);
    statehouse_ALLOW_ErrorCount := COUNT(GROUP,h.statehouse_Invalid=1);
    statesenate_ALLOW_ErrorCount := COUNT(GROUP,h.statesenate_Invalid=1);
    state_code_CUSTOM_ErrorCount := COUNT(GROUP,h.state_code_Invalid=1);
    timezonetbl_ALLOW_ErrorCount := COUNT(GROUP,h.timezonetbl_Invalid=1);
    ushouse_ALLOW_ErrorCount := COUNT(GROUP,h.ushouse_Invalid=1);
    voter_status_ALLOW_ErrorCount := COUNT(GROUP,h.voter_status_Invalid=1);
    work_phone_CUSTOM_ErrorCount := COUNT(GROUP,h.work_phone_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.active_status_Invalid > 0 OR h.agecat_Invalid > 0 OR h.changedate_Invalid > 0 OR h.countycode_Invalid > 0 OR h.distcode_Invalid > 0 OR h.dob_Invalid > 0 OR h.EMID_number_Invalid > 0 OR h.file_acquired_date_Invalid > 0 OR h.first_name_Invalid > 0 OR h.gender_Invalid > 0 OR h.gendersurnamguess_Invalid > 0 OR h.home_phone_Invalid > 0 OR h.idcode_Invalid > 0 OR h.lastdatevote_Invalid > 0 OR h.last_name_Invalid > 0 OR h.marriedappend_Invalid > 0 OR h.middle_name_Invalid > 0 OR h.political_party_Invalid > 0 OR h.race_Invalid > 0 OR h.regdate_Invalid > 0 OR h.res_addr1_Invalid > 0 OR h.res_city_Invalid > 0 OR h.res_state_Invalid > 0 OR h.res_zip_Invalid > 0 OR h.schoolcode_Invalid > 0 OR h.source_voterid_Invalid > 0 OR h.statehouse_Invalid > 0 OR h.statesenate_Invalid > 0 OR h.state_code_Invalid > 0 OR h.timezonetbl_Invalid > 0 OR h.ushouse_Invalid > 0 OR h.voter_status_Invalid > 0 OR h.work_phone_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.active_status_ALLOW_ErrorCount > 0, 1, 0) + IF(le.agecat_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.changedate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.countycode_ALLOW_ErrorCount > 0, 1, 0) + IF(le.distcode_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dob_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.EMID_number_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.file_acquired_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.first_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.gender_ENUM_ErrorCount > 0, 1, 0) + IF(le.gendersurnamguess_ALLOW_ErrorCount > 0, 1, 0) + IF(le.home_phone_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.idcode_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lastdatevote_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.last_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.marriedappend_ENUM_ErrorCount > 0, 1, 0) + IF(le.middle_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.political_party_ALLOW_ErrorCount > 0, 1, 0) + IF(le.race_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.regdate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.res_addr1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.res_city_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.res_state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.res_zip_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.schoolcode_ALLOW_ErrorCount > 0, 1, 0) + IF(le.source_voterid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.statehouse_ALLOW_ErrorCount > 0, 1, 0) + IF(le.statesenate_ALLOW_ErrorCount > 0, 1, 0) + IF(le.state_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.timezonetbl_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ushouse_ALLOW_ErrorCount > 0, 1, 0) + IF(le.voter_status_ALLOW_ErrorCount > 0, 1, 0) + IF(le.work_phone_CUSTOM_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.active_status_ALLOW_ErrorCount > 0, 1, 0) + IF(le.agecat_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.changedate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.countycode_ALLOW_ErrorCount > 0, 1, 0) + IF(le.distcode_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dob_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.EMID_number_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.file_acquired_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.first_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.gender_ENUM_ErrorCount > 0, 1, 0) + IF(le.gendersurnamguess_ALLOW_ErrorCount > 0, 1, 0) + IF(le.home_phone_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.idcode_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lastdatevote_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.last_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.marriedappend_ENUM_ErrorCount > 0, 1, 0) + IF(le.middle_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.political_party_ALLOW_ErrorCount > 0, 1, 0) + IF(le.race_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.regdate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.res_addr1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.res_city_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.res_state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.res_zip_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.schoolcode_ALLOW_ErrorCount > 0, 1, 0) + IF(le.source_voterid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.statehouse_ALLOW_ErrorCount > 0, 1, 0) + IF(le.statesenate_ALLOW_ErrorCount > 0, 1, 0) + IF(le.state_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.timezonetbl_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ushouse_ALLOW_ErrorCount > 0, 1, 0) + IF(le.voter_status_ALLOW_ErrorCount > 0, 1, 0) + IF(le.work_phone_CUSTOM_ErrorCount > 0, 1, 0);
    SELF.Rules_NoErrors := NumRules - SELF.Rules_WithErrors;
    SELF := le;
  END;
  EXPORT SummaryStats := PROJECT(SummaryStats0, xAddErrSummary(LEFT));
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT311.StrType ErrorMessage;
    SALT311.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.active_status_Invalid,le.agecat_Invalid,le.changedate_Invalid,le.countycode_Invalid,le.distcode_Invalid,le.dob_Invalid,le.EMID_number_Invalid,le.file_acquired_date_Invalid,le.first_name_Invalid,le.gender_Invalid,le.gendersurnamguess_Invalid,le.home_phone_Invalid,le.idcode_Invalid,le.lastdatevote_Invalid,le.last_name_Invalid,le.marriedappend_Invalid,le.middle_name_Invalid,le.political_party_Invalid,le.race_Invalid,le.regdate_Invalid,le.res_addr1_Invalid,le.res_city_Invalid,le.res_state_Invalid,le.res_zip_Invalid,le.schoolcode_Invalid,le.source_voterid_Invalid,le.statehouse_Invalid,le.statesenate_Invalid,le.state_code_Invalid,le.timezonetbl_Invalid,le.ushouse_Invalid,le.voter_status_Invalid,le.work_phone_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,In_Reg_Fields.InvalidMessage_active_status(le.active_status_Invalid),In_Reg_Fields.InvalidMessage_agecat(le.agecat_Invalid),In_Reg_Fields.InvalidMessage_changedate(le.changedate_Invalid),In_Reg_Fields.InvalidMessage_countycode(le.countycode_Invalid),In_Reg_Fields.InvalidMessage_distcode(le.distcode_Invalid),In_Reg_Fields.InvalidMessage_dob(le.dob_Invalid),In_Reg_Fields.InvalidMessage_EMID_number(le.EMID_number_Invalid),In_Reg_Fields.InvalidMessage_file_acquired_date(le.file_acquired_date_Invalid),In_Reg_Fields.InvalidMessage_first_name(le.first_name_Invalid),In_Reg_Fields.InvalidMessage_gender(le.gender_Invalid),In_Reg_Fields.InvalidMessage_gendersurnamguess(le.gendersurnamguess_Invalid),In_Reg_Fields.InvalidMessage_home_phone(le.home_phone_Invalid),In_Reg_Fields.InvalidMessage_idcode(le.idcode_Invalid),In_Reg_Fields.InvalidMessage_lastdatevote(le.lastdatevote_Invalid),In_Reg_Fields.InvalidMessage_last_name(le.last_name_Invalid),In_Reg_Fields.InvalidMessage_marriedappend(le.marriedappend_Invalid),In_Reg_Fields.InvalidMessage_middle_name(le.middle_name_Invalid),In_Reg_Fields.InvalidMessage_political_party(le.political_party_Invalid),In_Reg_Fields.InvalidMessage_race(le.race_Invalid),In_Reg_Fields.InvalidMessage_regdate(le.regdate_Invalid),In_Reg_Fields.InvalidMessage_res_addr1(le.res_addr1_Invalid),In_Reg_Fields.InvalidMessage_res_city(le.res_city_Invalid),In_Reg_Fields.InvalidMessage_res_state(le.res_state_Invalid),In_Reg_Fields.InvalidMessage_res_zip(le.res_zip_Invalid),In_Reg_Fields.InvalidMessage_schoolcode(le.schoolcode_Invalid),In_Reg_Fields.InvalidMessage_source_voterid(le.source_voterid_Invalid),In_Reg_Fields.InvalidMessage_statehouse(le.statehouse_Invalid),In_Reg_Fields.InvalidMessage_statesenate(le.statesenate_Invalid),In_Reg_Fields.InvalidMessage_state_code(le.state_code_Invalid),In_Reg_Fields.InvalidMessage_timezonetbl(le.timezonetbl_Invalid),In_Reg_Fields.InvalidMessage_ushouse(le.ushouse_Invalid),In_Reg_Fields.InvalidMessage_voter_status(le.voter_status_Invalid),In_Reg_Fields.InvalidMessage_work_phone(le.work_phone_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.active_status_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.agecat_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.changedate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.countycode_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.distcode_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dob_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.EMID_number_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.file_acquired_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.first_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.gender_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.gendersurnamguess_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.home_phone_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.idcode_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.lastdatevote_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.last_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.marriedappend_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.middle_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.political_party_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.race_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.regdate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.res_addr1_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.res_city_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.res_state_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.res_zip_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.schoolcode_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.source_voterid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.statehouse_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.statesenate_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.state_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.timezonetbl_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ushouse_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.voter_status_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.work_phone_Invalid,'CUSTOM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'active_status','agecat','changedate','countycode','distcode','dob','EMID_number','file_acquired_date','first_name','gender','gendersurnamguess','home_phone','idcode','lastdatevote','last_name','marriedappend','middle_name','political_party','race','regdate','res_addr1','res_city','res_state','res_zip','schoolcode','source_voterid','statehouse','statesenate','state_code','timezonetbl','ushouse','voter_status','work_phone','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_alphanum_empty','invalid_agecat','invalid_changedate','invalid_alphanum_empty','invalid_alphanum_empty','invalid_dob','invalid_alphanum','invalid_pastdate8','invalid_alphanum_specials','invalid_gender','invalid_alphanum_empty','invalid_phone','invalid_alphanum_empty','invalid_lastdatevote','invalid_last_name','invalid_boolean_yn_empty','invalid_alphanum_empty_specials','invalid_nums_empty','invalid_race','invalid_regdate','invalid_mandatory','invalid_mandatory','invalid_st','invalid_mandatory','invalid_alphanum_empty','invalid_alphanum','invalid_alphanum_empty','invalid_alphanumquot_empty','invalid_source_state','invalid_nums_empty','invalid_alphanum_empty','invalid_alphanum_empty','invalid_phone','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.active_status,(SALT311.StrType)le.agecat,(SALT311.StrType)le.changedate,(SALT311.StrType)le.countycode,(SALT311.StrType)le.distcode,(SALT311.StrType)le.dob,(SALT311.StrType)le.EMID_number,(SALT311.StrType)le.file_acquired_date,(SALT311.StrType)le.first_name,(SALT311.StrType)le.gender,(SALT311.StrType)le.gendersurnamguess,(SALT311.StrType)le.home_phone,(SALT311.StrType)le.idcode,(SALT311.StrType)le.lastdatevote,(SALT311.StrType)le.last_name,(SALT311.StrType)le.marriedappend,(SALT311.StrType)le.middle_name,(SALT311.StrType)le.political_party,(SALT311.StrType)le.race,(SALT311.StrType)le.regdate,(SALT311.StrType)le.res_addr1,(SALT311.StrType)le.res_city,(SALT311.StrType)le.res_state,(SALT311.StrType)le.res_zip,(SALT311.StrType)le.schoolcode,(SALT311.StrType)le.source_voterid,(SALT311.StrType)le.statehouse,(SALT311.StrType)le.statesenate,(SALT311.StrType)le.state_code,(SALT311.StrType)le.timezonetbl,(SALT311.StrType)le.ushouse,(SALT311.StrType)le.voter_status,(SALT311.StrType)le.work_phone,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,33,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(In_Reg_Layout_Voters) prevDS = DATASET([], In_Reg_Layout_Voters), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'active_status:invalid_alphanum_empty:ALLOW'
          ,'agecat:invalid_agecat:CUSTOM'
          ,'changedate:invalid_changedate:CUSTOM'
          ,'countycode:invalid_alphanum_empty:ALLOW'
          ,'distcode:invalid_alphanum_empty:ALLOW'
          ,'dob:invalid_dob:CUSTOM'
          ,'EMID_number:invalid_alphanum:CUSTOM'
          ,'file_acquired_date:invalid_pastdate8:CUSTOM'
          ,'first_name:invalid_alphanum_specials:CUSTOM'
          ,'gender:invalid_gender:ENUM'
          ,'gendersurnamguess:invalid_alphanum_empty:ALLOW'
          ,'home_phone:invalid_phone:CUSTOM'
          ,'idcode:invalid_alphanum_empty:ALLOW'
          ,'lastdatevote:invalid_lastdatevote:CUSTOM'
          ,'last_name:invalid_last_name:CUSTOM'
          ,'marriedappend:invalid_boolean_yn_empty:ENUM'
          ,'middle_name:invalid_alphanum_empty_specials:ALLOW'
          ,'political_party:invalid_nums_empty:ALLOW'
          ,'race:invalid_race:CUSTOM'
          ,'regdate:invalid_regdate:CUSTOM'
          ,'res_addr1:invalid_mandatory:CUSTOM'
          ,'res_city:invalid_mandatory:CUSTOM'
          ,'res_state:invalid_st:CUSTOM'
          ,'res_zip:invalid_mandatory:CUSTOM'
          ,'schoolcode:invalid_alphanum_empty:ALLOW'
          ,'source_voterid:invalid_alphanum:CUSTOM'
          ,'statehouse:invalid_alphanum_empty:ALLOW'
          ,'statesenate:invalid_alphanumquot_empty:ALLOW'
          ,'state_code:invalid_source_state:CUSTOM'
          ,'timezonetbl:invalid_nums_empty:ALLOW'
          ,'ushouse:invalid_alphanum_empty:ALLOW'
          ,'voter_status:invalid_alphanum_empty:ALLOW'
          ,'work_phone:invalid_phone:CUSTOM'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,In_Reg_Fields.InvalidMessage_active_status(1)
          ,In_Reg_Fields.InvalidMessage_agecat(1)
          ,In_Reg_Fields.InvalidMessage_changedate(1)
          ,In_Reg_Fields.InvalidMessage_countycode(1)
          ,In_Reg_Fields.InvalidMessage_distcode(1)
          ,In_Reg_Fields.InvalidMessage_dob(1)
          ,In_Reg_Fields.InvalidMessage_EMID_number(1)
          ,In_Reg_Fields.InvalidMessage_file_acquired_date(1)
          ,In_Reg_Fields.InvalidMessage_first_name(1)
          ,In_Reg_Fields.InvalidMessage_gender(1)
          ,In_Reg_Fields.InvalidMessage_gendersurnamguess(1)
          ,In_Reg_Fields.InvalidMessage_home_phone(1)
          ,In_Reg_Fields.InvalidMessage_idcode(1)
          ,In_Reg_Fields.InvalidMessage_lastdatevote(1)
          ,In_Reg_Fields.InvalidMessage_last_name(1)
          ,In_Reg_Fields.InvalidMessage_marriedappend(1)
          ,In_Reg_Fields.InvalidMessage_middle_name(1)
          ,In_Reg_Fields.InvalidMessage_political_party(1)
          ,In_Reg_Fields.InvalidMessage_race(1)
          ,In_Reg_Fields.InvalidMessage_regdate(1)
          ,In_Reg_Fields.InvalidMessage_res_addr1(1)
          ,In_Reg_Fields.InvalidMessage_res_city(1)
          ,In_Reg_Fields.InvalidMessage_res_state(1)
          ,In_Reg_Fields.InvalidMessage_res_zip(1)
          ,In_Reg_Fields.InvalidMessage_schoolcode(1)
          ,In_Reg_Fields.InvalidMessage_source_voterid(1)
          ,In_Reg_Fields.InvalidMessage_statehouse(1)
          ,In_Reg_Fields.InvalidMessage_statesenate(1)
          ,In_Reg_Fields.InvalidMessage_state_code(1)
          ,In_Reg_Fields.InvalidMessage_timezonetbl(1)
          ,In_Reg_Fields.InvalidMessage_ushouse(1)
          ,In_Reg_Fields.InvalidMessage_voter_status(1)
          ,In_Reg_Fields.InvalidMessage_work_phone(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.active_status_ALLOW_ErrorCount
          ,le.agecat_CUSTOM_ErrorCount
          ,le.changedate_CUSTOM_ErrorCount
          ,le.countycode_ALLOW_ErrorCount
          ,le.distcode_ALLOW_ErrorCount
          ,le.dob_CUSTOM_ErrorCount
          ,le.EMID_number_CUSTOM_ErrorCount
          ,le.file_acquired_date_CUSTOM_ErrorCount
          ,le.first_name_CUSTOM_ErrorCount
          ,le.gender_ENUM_ErrorCount
          ,le.gendersurnamguess_ALLOW_ErrorCount
          ,le.home_phone_CUSTOM_ErrorCount
          ,le.idcode_ALLOW_ErrorCount
          ,le.lastdatevote_CUSTOM_ErrorCount
          ,le.last_name_CUSTOM_ErrorCount
          ,le.marriedappend_ENUM_ErrorCount
          ,le.middle_name_ALLOW_ErrorCount
          ,le.political_party_ALLOW_ErrorCount
          ,le.race_CUSTOM_ErrorCount
          ,le.regdate_CUSTOM_ErrorCount
          ,le.res_addr1_CUSTOM_ErrorCount
          ,le.res_city_CUSTOM_ErrorCount
          ,le.res_state_CUSTOM_ErrorCount
          ,le.res_zip_CUSTOM_ErrorCount
          ,le.schoolcode_ALLOW_ErrorCount
          ,le.source_voterid_CUSTOM_ErrorCount
          ,le.statehouse_ALLOW_ErrorCount
          ,le.statesenate_ALLOW_ErrorCount
          ,le.state_code_CUSTOM_ErrorCount
          ,le.timezonetbl_ALLOW_ErrorCount
          ,le.ushouse_ALLOW_ErrorCount
          ,le.voter_status_ALLOW_ErrorCount
          ,le.work_phone_CUSTOM_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.active_status_ALLOW_ErrorCount
          ,le.agecat_CUSTOM_ErrorCount
          ,le.changedate_CUSTOM_ErrorCount
          ,le.countycode_ALLOW_ErrorCount
          ,le.distcode_ALLOW_ErrorCount
          ,le.dob_CUSTOM_ErrorCount
          ,le.EMID_number_CUSTOM_ErrorCount
          ,le.file_acquired_date_CUSTOM_ErrorCount
          ,le.first_name_CUSTOM_ErrorCount
          ,le.gender_ENUM_ErrorCount
          ,le.gendersurnamguess_ALLOW_ErrorCount
          ,le.home_phone_CUSTOM_ErrorCount
          ,le.idcode_ALLOW_ErrorCount
          ,le.lastdatevote_CUSTOM_ErrorCount
          ,le.last_name_CUSTOM_ErrorCount
          ,le.marriedappend_ENUM_ErrorCount
          ,le.middle_name_ALLOW_ErrorCount
          ,le.political_party_ALLOW_ErrorCount
          ,le.race_CUSTOM_ErrorCount
          ,le.regdate_CUSTOM_ErrorCount
          ,le.res_addr1_CUSTOM_ErrorCount
          ,le.res_city_CUSTOM_ErrorCount
          ,le.res_state_CUSTOM_ErrorCount
          ,le.res_zip_CUSTOM_ErrorCount
          ,le.schoolcode_ALLOW_ErrorCount
          ,le.source_voterid_CUSTOM_ErrorCount
          ,le.statehouse_ALLOW_ErrorCount
          ,le.statesenate_ALLOW_ErrorCount
          ,le.state_code_CUSTOM_ErrorCount
          ,le.timezonetbl_ALLOW_ErrorCount
          ,le.ushouse_ALLOW_ErrorCount
          ,le.voter_status_ALLOW_ErrorCount
          ,le.work_phone_CUSTOM_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
          ,IF(NumFieldsWithRules = 0, 0, le.FieldsChecked_WithErrors/NumFieldsWithRules * 100)
          ,IF(NumFieldsWithRules = 0, 0, le.FieldsChecked_NoErrors/NumFieldsWithRules * 100)
          ,IF(NumRules = 0, 0, le.Rules_WithErrors/NumRules * 100)
          ,IF(NumRules = 0, 0, le.Rules_NoErrors/NumRules * 100)
          ,0
          ,IF(SELF.recordstotal = 0, 0, le.AnyRule_WithErrorsCount/SELF.recordstotal * 100)
          ,IF(SELF.recordstotal = 0, 0, (SELF.recordstotal - le.AnyRule_WithErrorsCount)/SELF.recordstotal * 100),0));
    END;
    SummaryInfo := NORMALIZE(SummaryStats,NumRules + 7,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT311.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT311.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    FieldErrorStats := IF(examples>0,j,SummaryInfo);
 
    // field population stats
    mod_hygiene := In_Reg_hygiene(PROJECT(h, In_Reg_Layout_Voters));
    hygiene_summaryStats := mod_hygiene.Summary('');
    getFieldTypeText(infield) := FUNCTIONMACRO
      isNumField := (STRING)((TYPEOF(infield))'') = '0';
      RETURN IF(isNumField, 'nonzero', 'nonblank');
    ENDMACRO;
    SALT311.ScrubsOrbitLayout xNormHygieneStats(hygiene_summaryStats le, UNSIGNED c, STRING suffix) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'active_status:' + getFieldTypeText(h.active_status) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'agecat:' + getFieldTypeText(h.agecat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'changedate:' + getFieldTypeText(h.changedate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'countycode:' + getFieldTypeText(h.countycode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'distcode:' + getFieldTypeText(h.distcode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dob:' + getFieldTypeText(h.dob) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'EMID_number:' + getFieldTypeText(h.EMID_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'file_acquired_date:' + getFieldTypeText(h.file_acquired_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'first_name:' + getFieldTypeText(h.first_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'gender:' + getFieldTypeText(h.gender) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'gendersurnamguess:' + getFieldTypeText(h.gendersurnamguess) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'home_phone:' + getFieldTypeText(h.home_phone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'idcode:' + getFieldTypeText(h.idcode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lastdatevote:' + getFieldTypeText(h.lastdatevote) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'last_name:' + getFieldTypeText(h.last_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'marriedappend:' + getFieldTypeText(h.marriedappend) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'middle_name:' + getFieldTypeText(h.middle_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'political_party:' + getFieldTypeText(h.political_party) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'race:' + getFieldTypeText(h.race) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'regdate:' + getFieldTypeText(h.regdate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'res_addr1:' + getFieldTypeText(h.res_addr1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'res_city:' + getFieldTypeText(h.res_city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'res_state:' + getFieldTypeText(h.res_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'res_zip:' + getFieldTypeText(h.res_zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'schoolcode:' + getFieldTypeText(h.schoolcode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'source_voterid:' + getFieldTypeText(h.source_voterid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'statehouse:' + getFieldTypeText(h.statehouse) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'statesenate:' + getFieldTypeText(h.statesenate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'state_code:' + getFieldTypeText(h.state_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'timezonetbl:' + getFieldTypeText(h.timezonetbl) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ushouse:' + getFieldTypeText(h.ushouse) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'voter_status:' + getFieldTypeText(h.voter_status) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'work_phone:' + getFieldTypeText(h.work_phone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_active_status_cnt
          ,le.populated_agecat_cnt
          ,le.populated_changedate_cnt
          ,le.populated_countycode_cnt
          ,le.populated_distcode_cnt
          ,le.populated_dob_cnt
          ,le.populated_EMID_number_cnt
          ,le.populated_file_acquired_date_cnt
          ,le.populated_first_name_cnt
          ,le.populated_gender_cnt
          ,le.populated_gendersurnamguess_cnt
          ,le.populated_home_phone_cnt
          ,le.populated_idcode_cnt
          ,le.populated_lastdatevote_cnt
          ,le.populated_last_name_cnt
          ,le.populated_marriedappend_cnt
          ,le.populated_middle_name_cnt
          ,le.populated_political_party_cnt
          ,le.populated_race_cnt
          ,le.populated_regdate_cnt
          ,le.populated_res_addr1_cnt
          ,le.populated_res_city_cnt
          ,le.populated_res_state_cnt
          ,le.populated_res_zip_cnt
          ,le.populated_schoolcode_cnt
          ,le.populated_source_voterid_cnt
          ,le.populated_statehouse_cnt
          ,le.populated_statesenate_cnt
          ,le.populated_state_code_cnt
          ,le.populated_timezonetbl_cnt
          ,le.populated_ushouse_cnt
          ,le.populated_voter_status_cnt
          ,le.populated_work_phone_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_active_status_pcnt
          ,le.populated_agecat_pcnt
          ,le.populated_changedate_pcnt
          ,le.populated_countycode_pcnt
          ,le.populated_distcode_pcnt
          ,le.populated_dob_pcnt
          ,le.populated_EMID_number_pcnt
          ,le.populated_file_acquired_date_pcnt
          ,le.populated_first_name_pcnt
          ,le.populated_gender_pcnt
          ,le.populated_gendersurnamguess_pcnt
          ,le.populated_home_phone_pcnt
          ,le.populated_idcode_pcnt
          ,le.populated_lastdatevote_pcnt
          ,le.populated_last_name_pcnt
          ,le.populated_marriedappend_pcnt
          ,le.populated_middle_name_pcnt
          ,le.populated_political_party_pcnt
          ,le.populated_race_pcnt
          ,le.populated_regdate_pcnt
          ,le.populated_res_addr1_pcnt
          ,le.populated_res_city_pcnt
          ,le.populated_res_state_pcnt
          ,le.populated_res_zip_pcnt
          ,le.populated_schoolcode_pcnt
          ,le.populated_source_voterid_pcnt
          ,le.populated_statehouse_pcnt
          ,le.populated_statesenate_pcnt
          ,le.populated_state_code_pcnt
          ,le.populated_timezonetbl_pcnt
          ,le.populated_ushouse_pcnt
          ,le.populated_voter_status_pcnt
          ,le.populated_work_phone_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,33,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
  // record count stats
    SALT311.ScrubsOrbitLayout xTotalRecs(hygiene_summaryStats le, STRING inRuleDesc) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := inRuleDesc;
      SELF.ErrorMessage := '';
      SELF.rulecnt := le.NumberOfRecords;
      SELF.rulepcnt := 0;
    END;
    TotalRecsStats := PROJECT(hygiene_summaryStats, xTotalRecs(LEFT, 'records:total_records:POP'));
 
    mod_Delta := In_Reg_Delta(prevDS, PROJECT(h, In_Reg_Layout_Voters));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),33,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(In_Reg_Layout_Voters) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_Voters, In_Reg_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
  scrubsSummaryOverall_Standard := NORMALIZE(scrubsSummaryOverall, (NumRulesFromFieldType + NumFieldsWithRules) * 4, xSummaryStats(LEFT, COUNTER, myTimeStamp, 'all', 'all'));
 
  allErrsOverall := mod_fromexpandedOverall.AllErrors;
  tErrsOverall := TABLE(DISTRIBUTE(allErrsOverall, HASH(FieldName, ErrorType)), {FieldName, ErrorType, FieldContents, cntExamples := COUNT(GROUP)}, FieldName, ErrorType, FieldContents, LOCAL);
 
  scrubsSummaryOverall_Standard_addErr   := IF(doErrorOverall,
                                               DENORMALIZE(SORT(DISTRIBUTE(scrubsSummaryOverall_Standard, HASH(field, ruletype)), field, ruletype, LOCAL),
  	                                                       SORT(tErrsOverall, FieldName, ErrorType, -cntExamples, FieldContents, LOCAL),
  	                                                       LEFT.field = RIGHT.FieldName AND LEFT.ruletype = RIGHT.ErrorType AND LEFT.MeasureType = 'CntRecs',
  	                                                       TRANSFORM(RECORDOF(LEFT),
  	                                                       SELF.dsExamples := LEFT.dsExamples & DATASET([{RIGHT.FieldContents, RIGHT.cntExamples, IF(LEFT.StatValue > 0, RIGHT.cntExamples/LEFT.StatValue * 100, 0)}], SALT311.Layout_Stats_Standard.Examples);
  	                                                       SELF := LEFT),
  	                                                       KEEP(10), LEFT OUTER, LOCAL, NOSORT));
  scrubsSummaryOverall_Standard_GeneralErrs := IF(doErrorOverall, SALT311.mod_StandardStatsTransforms.scrubsSummaryStatsGeneral(scrubsSummaryOverall,, myTimeStamp, 'all', 'all'));
 
  RETURN scrubsSummaryOverall_Standard_addErr & scrubsSummaryOverall_Standard_GeneralErrs;
END;
END;
