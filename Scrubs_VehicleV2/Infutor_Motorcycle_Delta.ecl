IMPORT SALT311,STD;
EXPORT Infutor_Motorcycle_Delta(DATASET(Infutor_Motorcycle_Layout_VehicleV2)old_s, DATASET(Infutor_Motorcycle_Layout_VehicleV2) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['iid','pid','vin','make','model','year','class_code','fuel_type_code','mfg_code','style_code','mileagecd','nbr_vehicles','idate','odate','fname','mi','lname','suffix','gender','house','predir','street','strtype','postdir','apttype','aptnbr','city','state','zip','z4','dpc','crte','cnty','z4type','dpv','vacant','phone','dnc','internal1','internal2','internal3','county','msa','cbsa','ehi','child','homeowner','pctw','pctb','pcta','pcth','pctspe','pctsps','pctspa','mhv','mor','pctoccw','pctoccb','pctocco','lor','sfdu','mfdu','processdate','source_code','state_origin','append_ownernametypeind','fullname'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary(BOOLEAN Glob = TRUE) := Infutor_Motorcycle_hygiene(old_s).Summary('Old',Glob) + Infutor_Motorcycle_hygiene(new_s).Summary('New',Glob) + Infutor_Motorcycle_hygiene(PROJECT(Differences(deleted), TRANSFORM(Infutor_Motorcycle_Layout_VehicleV2, SELF := LEFT.old_rec))).Summary('Deletions',Glob) + Infutor_Motorcycle_hygiene(PROJECT(Differences(added), TRANSFORM(Infutor_Motorcycle_Layout_VehicleV2, SELF := LEFT.new_rec))).Summary('Additions',Glob);
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE, BOOLEAN doHygieneSummaryPerSrc = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary(TRUE);
    hygieneDiffPerSrc := DifferenceSummary(FALSE);
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_VehicleV2, Infutor_Motorcycle_Fields, 'RECORDOF(hygieneDiffOverall)', TRUE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
    hygieneDiffPerSrc_Standard := IF(doHygieneSummaryPerSrc, NORMALIZE(hygieneDiffPerSrc, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_src', LEFT.txt + '_src')));


    RETURN hygieneDiffOverall_Standard & hygieneDiffPerSrc_Standard;
  END;
END;
