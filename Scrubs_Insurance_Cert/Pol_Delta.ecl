IMPORT SALT311,STD;
EXPORT Pol_Delta(DATASET(Pol_Layout_Insurance_Cert)old_s, DATASET(Pol_Layout_Insurance_Cert) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['date_firstseen','date_lastseen','bdid','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight','lninscertrecordid','dartid','insuranceprovider','policynumber','coveragestartdate','coverageexpirationdate','coveragewrapup','policystatus','insuranceprovideraddressline','insuranceprovideraddressline2','insuranceprovidercity','insuranceproviderstate','insuranceproviderzip','insuranceproviderzip4','insuranceproviderphone','insuranceproviderfax','coveragereinstatedate','coveragecancellationdate','coveragewrapupdate','businessnameduringcoverage','addresslineduringcoverage','addressline2duringcoverage','cityduringcoverage','stateduringcoverage','zipduringcoverage','zip4duringcoverage','numberofemployeesduringcoverage','insuranceprovidercontactdept','insurancetype','coverageposteddate','coverageamountfrom','coverageamountto','unique_id','append_mailaddress1','append_mailaddresslast','append_mailrawaid','append_mailaceaid'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := Pol_hygiene(old_s).Summary('Old') + Pol_hygiene(new_s).Summary('New') + Pol_hygiene(PROJECT(Differences(deleted), TRANSFORM(Pol_Layout_Insurance_Cert, SELF := LEFT.old_rec))).Summary('Deletions') + Pol_hygiene(PROJECT(Differences(added), TRANSFORM(Pol_Layout_Insurance_Cert, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Insurance_Cert, Pol_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
