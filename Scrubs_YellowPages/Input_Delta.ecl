IMPORT SALT311,STD;
EXPORT Input_Delta(DATASET(Input_Layout_YellowPages)old_s, DATASET(Input_Layout_YellowPages) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['primary_key','chainid','filler1','pub_date','busshortname','business_name','busdeptname','house','predir','street','streettype','postdir','apttype','aptnbr','boxnbr','exppubcity','orig_city','orig_state','orig_zip','dpc','carrierroute','fips','countycode','z4type','ctract','cblockgroup','cblockid','msa','cbsa','mcdcode','filler2','addrsensitivity','maildeliverabilitycode','sic1_4','sic_code','sic2','sic3','sic4','indstryclass','naics_code','mlsc','filler3','orig_phone10','nosolicitcode','dso','timezone','validationflag','validationdate','secvalidationcode','singleaddrflag','filler4','gender','execname','exectitlecode','exectitle','condtitlecode','condtitle','contfunctioncode','contfunction','profession','emplsizecode','annualsalescode','yrsinbus','ethniccode','filler5','latlongmatchlevel','orig_latitude','orig_longitude','filler6','heading_string','ypheading2','ypheading3','ypheading4','ypheading5','ypheading6','maxypadsize','filler7','faxac','faxexchge','faxphone','altac','altexchge','altphone','mobileac','mobileexchge','mobilephone','tollfreeac','tollfreeexchge','tollfreephone','creditcards','brands','stdhrs','hrsopen','web_address','filler8','email_address','services','condheading','tagline','filler9','totaladspend','filler10','crlf'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := Input_hygiene(old_s).Summary('Old') + Input_hygiene(new_s).Summary('New') + Input_hygiene(PROJECT(Differences(deleted), TRANSFORM(Input_Layout_YellowPages, SELF := LEFT.old_rec))).Summary('Deletions') + Input_hygiene(PROJECT(Differences(added), TRANSFORM(Input_Layout_YellowPages, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_YellowPages, Input_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
