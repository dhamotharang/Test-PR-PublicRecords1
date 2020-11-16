IMPORT SALT311,STD;
EXPORT In_Reg_Delta(DATASET(In_Reg_Layout_Voters)old_s, DATASET(In_Reg_Layout_Voters) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['active_status','agecat','changedate','countycode','distcode','dob','EMID_number','file_acquired_date','first_name','gender','gendersurnamguess','home_phone','idcode','lastdatevote','last_name','marriedappend','middle_name','political_party','race','regdate','res_addr1','res_city','res_state','res_zip','schoolcode','source_voterid','statehouse','statesenate','state_code','timezonetbl','ushouse','voter_status','work_phone'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := In_Reg_hygiene(old_s).Summary('Old') + In_Reg_hygiene(new_s).Summary('New') + In_Reg_hygiene(PROJECT(Differences(deleted), TRANSFORM(In_Reg_Layout_Voters, SELF := LEFT.old_rec))).Summary('Deletions') + In_Reg_hygiene(PROJECT(Differences(added), TRANSFORM(In_Reg_Layout_Voters, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Voters, In_Reg_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
