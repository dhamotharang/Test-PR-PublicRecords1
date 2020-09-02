IMPORT SALT311,STD;
EXPORT Delta(DATASET(Layout_BKMortgage_Assignments)old_s, DATASET(Layout_BKMortgage_Assignments) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['ln_filedate','bk_infile_type','rectype','documenttype','fipscode','mersindicator','mainaddendum','assigrecdate','assigeffecdate','assigdoc','assigbk','assigpg','multiplepageimage','bkfsimageid','origdotrecdate','origdotcontractdate','origdotdoc','origdotbk','origdotpg','origlenderben','origloanamnt','assignorname','loannumber','assignee','mers','mersvalidation','assigneepool','mspsvcrloan','borrowername','apn','multiapncode','taxacctid','propertyfulladd','propertyunit','propertycity','propertystate','propertyzip','propertyzip4','dataentrydate','dataentryopercode','vendorsourcecode','hids_recordingflag','hids_docnumber','transfercertificateoftitle','hi_condo_cpr_hpr','hi_situs_unit_number','hids_previous_docnumber','prevtransfercertificateoftitle','pid','matchedororphan','deed_pid','sam_pid','assessorparcelnumber_matched','assessorpropertyfulladd','assessorpropertyunittype','assessorpropertyunit','assessorpropertycity','assessorpropertystate','assessorpropertyzip','assessorpropertyzip4','assessorpropertyaddrsource','raw_file_name'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := hygiene(old_s).Summary('Old') + hygiene(new_s).Summary('New') + hygiene(PROJECT(Differences(deleted), TRANSFORM(Layout_BKMortgage_Assignments, SELF := LEFT.old_rec))).Summary('Deletions') + hygiene(PROJECT(Differences(added), TRANSFORM(Layout_BKMortgage_Assignments, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_BKMortgage_Assignments, Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
