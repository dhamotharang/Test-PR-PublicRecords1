EXPORT mStats:=MODULE
  SHARED dRawIn01:=reunion.files.dRawIn01();
  SHARED dRawIn02:=reunion.files.dRawIn02();
  SHARED dRawIn03:=reunion.files.dRawIn03();
  SHARED dRawIn04:=reunion.files.dRawIn04();
  SHARED dRawIn05:=reunion.files.dRawIn05();
  SHARED dRawIn06:=reunion.files.dRawIn06();
  SHARED dCleaned:=reunion.reunion_clean;
	SHARED dCleanedWithDID:=DISTRIBUTE(dCleaned(did>0),HASH32(did));
	SHARED dMain:=DISTRIBUTE(reunion.files.dMain,HASH32((UNSIGNED6)adl));

  SHARED dRawIn01_Deduped:=DEDUP(SORT(TABLE(dRawIn01,{first_name;last_name;dob;}),RECORD));
  SHARED dRawIn02_Deduped:=DEDUP(SORT(TABLE(dRawIn02,{first_name;last_name;street;state;}),RECORD));
  SHARED dRawIn03_Deduped:=DEDUP(SORT(TABLE(dRawIn03,{first_name;last_name;street;state;}),RECORD));
  SHARED dRawIn04_Deduped:=DEDUP(SORT(TABLE(dRawIn04,{first_name;last_name;street;state;}),RECORD));
  SHARED dRawIn05_Deduped:=DEDUP(SORT(TABLE(dRawIn05,{first_name;last_name;street;state;}),RECORD));
  SHARED dRawIn06_Deduped:=DEDUP(SORT(TABLE(dRawIn06,{first_name;last_name;street;state;}),RECORD));

  SHARED dCleaned01:=dCleaned(vendor='1');
  SHARED dCleaned02:=dCleaned(vendor='2');
  SHARED dCleaned03:=dCleaned(vendor='3');
  SHARED dCleaned04:=dCleaned(vendor='4');
  SHARED dCleaned05:=dCleaned(vendor='5');
  SHARED dCleaned06:=dCleaned(vendor='6');

  SHARED dCleaned01WithDID:=dCleaned01(did>0);
  SHARED dCleaned02WithDID:=dCleaned02(did>0);
  SHARED dCleaned03WithDID:=dCleaned03(did>0);
  SHARED dCleaned04WithDID:=dCleaned04(did>0);
  SHARED dCleaned05WithDID:=dCleaned05(did>0);
  SHARED dCleaned06WithDID:=dCleaned06(did>0);

  SHARED dCleaned01UniqueDID:=DEDUP(SORT(dCleaned01WithDID,did),did);
  SHARED dCleaned02UniqueDID:=DEDUP(SORT(dCleaned02WithDID,did),did);
  SHARED dCleaned03UniqueDID:=DEDUP(SORT(dCleaned03WithDID,did),did);
  SHARED dCleaned04UniqueDID:=DEDUP(SORT(dCleaned04WithDID,did),did);
  SHARED dCleaned05UniqueDID:=DEDUP(SORT(dCleaned05WithDID,did),did);
  SHARED dCleaned06UniqueDID:=DEDUP(SORT(dCleaned06WithDID,did),did);

  SHARED dFileBreakdown:=DATASET([
    {'Total records in raw file',COUNT(dRawIn01),COUNT(dRawIn02),COUNT(dRawIn03),COUNT(dRawIn04),COUNT(dRawIn05),COUNT(dRawIn06)},
    {'Unique use-able records',COUNT(dRawIn01_Deduped),COUNT(dRawIn02_Deduped),COUNT(dRawIn03_Deduped),COUNT(dRawIn04_Deduped),COUNT(dRawIn05_Deduped),COUNT(dRawIn06_Deduped)},
    {'Total Records in clean file',COUNT(dCleaned01),COUNT(dCleaned02),COUNT(dCleaned03),COUNT(dCleaned04),COUNT(dCleaned05),COUNT(dCleaned06)},
    {'Cleaned Records with DID',COUNT(dCleaned01WithDID),COUNT(dCleaned02WithDID),COUNT(dCleaned03WithDID),COUNT(dCleaned04WithDID),COUNT(dCleaned05WithDID),COUNT(dCleaned06WithDID)},
    {'Unique cleaned with DID',COUNT(dCleaned01UniqueDID),COUNT(dCleaned02UniqueDID),COUNT(dCleaned03UniqueDID),COUNT(dCleaned04UniqueDID),COUNT(dCleaned05UniqueDID),COUNT(dCleaned06UniqueDID)}
  ],{STRING description;UNSIGNED mylife01;UNSIGNED mylife02;UNSIGNED mylife03;UNSIGNED mylife04;UNSIGNED mylife05;UNSIGNED mylife06;});

  SHARED dCleanedUniqueDID:=DEDUP(SORT(DISTRIBUTE(dCleaned,HASH32(did)),did,LOCAL),did,LOCAL);

  SHARED dScores:=TABLE(DISTRIBUTE(dCleaned,HASH32(did_score)),{did_score;UNSIGNED c:=COUNT(GROUP);},did_score,LOCAL);

  SHARED dRecordsInCleanNotMain:=JOIN(dCleanedWithDID,dMain,LEFT.did=(UNSIGNED6)RIGHT.adl,LEFT ONLY,LOCAL);
	
	SHARED dRecordsInMainNotClean:=JOIN(dMain,TABLE(dCleanedWithDID,{did},did,LOCAL),(UNSIGNED6)LEFT.adl=RIGHT.did,LOCAL);

//-----------------------------------------------------------------------------
  EXPORT actionShowFileBreakdown:=OUTPUT(dFileBreakdown,NAMED('Input_File_Breakdown'));
  EXPORT actionShowUniqueDIDCount:=OUTPUT(COUNT(dCleanedUniqueDID),NAMED('Unique_Cleaned_DIDs'));
  EXPORT actionShowDIDScoreBreakdown:=OUTPUT(SORT(dScores,-did_score),NAMED('DID_Score_Breakdown'));
  EXPORT actionShowCleanRecordsNotInMain:=PARALLEL(
		OUTPUT(COUNT(TABLE(dRecordsInCleanNotMain,{did;},did,LOCAL)),NAMED('Unique_Clean_DIDs_Not_in_Main_Count')),
		OUTPUT(COUNT(dRecordsInCleanNotMain),NAMED('Clean_Not_in_Main_Count')),
	  OUTPUT(dRecordsInCleanNotMain,NAMED('Clean_Not_in_Main'))
	);
  EXPORT actionShowMainRecordsNotInClean:=PARALLEL(
		OUTPUT(COUNT(dRecordsInMainNotClean),NAMED('Main_not_in_Clean_Count')),
	  OUTPUT(dRecordsInMainNotClean,NAMED('Main_not_in_Clean'))
	);
	
	EXPORT actionShowAll:=PARALLEL(
	  actionShowFileBreakdown,
		actionShowUniqueDIDCount,
		actionShowDIDScoreBreakdown,
		actionShowCleanRecordsNotInMain,
		actionShowMainRecordsNotInClean
	);

END;