﻿IMPORT Prof_License_Mari, /*Scrubs_Prof_License_Mari,*/ ut, _Control;
// This attribute will add the dNewData, newly processed update, to dBasefile, superfile, if following criteria is met.
// Otherwise dNewData will be added to the layout change suspect superfile and will be examined and handled manually.
// 1.	Count the # of records in the input file
// 2.	Count the # of record in the latest file previous file
// 3.	Compare results 1 and 2 and if 2 > 1 or 1 > 2 by 10%, then your process will return true (indicating there may be an issue)
// 4.	Concatenate files used in 1 and 2, then dedup by all fields in the file (except the fields expected to change each build like dates) and count the number of records after the dedup
// 5.	Compare 1 to 4  and if 4 has 20% more records than 1, then your process will return true (indicating there may be an issue) 

EXPORT fAddNewUpdate(DATASET(RECORDOF(Prof_License_Mari.layout_base_in)) dNewData) := FUNCTION 

	//name of the super file that contains all updates that are suspect of layout changes
	layout_change_suspect_file_name := 'layout_change_suspect';
	accepted_record_cnt_change_1 := 0.1;
	accepted_record_cnt_change_2 := 0.2;
	
	new_date					:=	TRIM(dNewData[1].last_upd_dte);
	src_cd						:=	ut.CleanSpacesAndUpper(dNewData[1].std_source_upd);
	mari_dest					:= '~thor_data400::in::proflic_mari::';
  layout_in         := Prof_License_Mari.layout_base_in;
	
	// super file
	superfile_name		:=  mari_dest + src_cd;
	dBasefile					:=	DATASET(mari_dest+src_cd,layout_in,thor);
	latest_date				:=	MAX(dBasefile,date_vendor_last_reported);
	dLatestUpdate			:=	dBasefile(date_vendor_last_reported=latest_date);


//layout excluding fields we expect to change
 Layout_Slim := RECORD
	layout_in - [CREATE_DTE, LAST_UPD_DTE, STAMP_DTE, DATE_FIRST_SEEN, DATE_LAST_SEEN, 
							 DATE_VENDOR_FIRST_REPORTED, DATE_VENDOR_LAST_REPORTED, PROCESS_DATE,
							 PROVNOTE_1,PROVNOTE_2,PROVNOTE_3,CMC_SLPK, PCMC_SLPK];
	string UNIQUE_ID;
end;

 Layout_Joined := RECORD
  string DIFF_FIELDS;
	string UNIQUE_ID;
  Layout_Slim PRIOR_VALUE;
  Layout_Slim CURRENT_VALUE;	
END;

 Layout_Joined xform_1(Layout_Slim L, Layout_Slim R) := TRANSFORM
	SELF.UNIQUE_ID := L.UNIQUE_ID;
  SELF.DIFF_FIELDS := ROWDIFF(L,R);
	SELF.PRIOR_VALUE := L;
	SELF.CURRENT_VALUE := R;
END;

	// count of new and the latest update in the super file
	cNewData					:=	COUNT(dNewData);
	cLatestUpdate			:=	COUNT(dLatestUpdate);
	cntDiff						:=	cNewData - cLatestUpdate;
	cntChangePercent	:=  cntDiff / cLatestUpdate;

  // sort new and latest update records
	dLatestSort 	 := SORT(DISTRIBUTE(dLatestUpdate, HASH(LICENSE_NBR)),LICENSE_NBR, OFF_LICENSE_NBR,STORE_NBR, NAME_DBA, LOCAL);
	dNewSort       := SORT(DISTRIBUTE(dNewData, HASH(LICENSE_NBR)),LICENSE_NBR, OFF_LICENSE_NBR, STORE_NBR, NAME_DBA, LOCAL);

	ut.CleanFields(dLatestSort, ClnLatest);
	ut.CleanFields(dNewSort, ClnNew);
	 
	SlimLatest 	:= PROJECT(ClnLatest, TRANSFORM(Layout_Slim, SELF.UNIQUE_ID:=TRIM(LEFT.LICENSE_NBR) + '_' + TRIM(LEFT.STORE_NBR) + '_' + TRIM(LEFT.AGENCY_ID) + '_' + TRIM(LEFT.NAME_ORG); SELF := LEFT;)); 
	SlimNew     := PROJECT(ClnNew, TRANSFORM(Layout_Slim, SELF.UNIQUE_ID:=TRIM(LEFT.LICENSE_NBR) + '_' + TRIM(LEFT.STORE_NBR) + '_' + TRIM(LEFT.AGENCY_ID) + '_' + TRIM(LEFT.NAME_ORG); SELF := LEFT;));


	// Combine new and the latest update
	dCombined					:=	dNewData + dLatestUpdate;
	dCombinedDist			:=	DISTRIBUTE(dCombined, HASH(LICENSE_NBR,NAME_ORG, NAME_DBA_ORIG, NAME_OFFICE));
	dCombinedSort			:=	SORT(dCombinedDist, LICENSE_NBR,NAME_ORG, NAME_DBA_ORIG, NAME_OFFICE, ADDR_ADDR1_1,ADDR_CITY_1,ADDR_ZIP5_1,CMC_SLPK,PCMC_SLPK,LOCAL);
	dCombinedDedup		:=	DEDUP(dCombinedSort, EXCEPT CREATE_DTE, LAST_UPD_DTE, STAMP_DTE, DATE_FIRST_SEEN, DATE_LAST_SEEN,
																										DATE_VENDOR_FIRST_REPORTED, DATE_VENDOR_LAST_REPORTED, PROCESS_DATE, 
																									  PROVNOTE_1, PROVNOTE_2, PROVNOTE_3, 
																										CURR_ISSUE_DTE, EXPIRE_DTE,RENEWAL_DTE,
																										LOCAL);
	cCombinedDedup		:=	COUNT(dCombinedDedup);
	cntMergeDiff			:=	cCombinedDedup - cLatestUpdate;
	cntMergeDiffPercent := cntMergeDiff / cLatestUpdate;
	
	// Display not dup'ed records
	dNotDedupedLicNbr	:= TABLE(dCombinedDedup,{LICENSE_NBR,cnt:=COUNT(GROUP)},LICENSE_NBR);
	sampleOutput			:= JOIN(SORT(dCombinedDedup,LICENSE_NBR),
	                          SORT(dNotDedupedLicNbr(cnt>1),LICENSE_NBR),
														LEFT.LICENSE_NBR=RIGHT.LICENSE_NBR,
														TRANSFORM({dCombinedDedup},SELF:=LEFT;),
														INNER);
	
 //Display different records 
 dJoined := JOIN(SlimLatest, SlimNew, 
												LEFT.UNIQUE_ID = RIGHT.UNIQUE_ID, xform_1(LEFT,RIGHT));
 dJoinedDiff := dJoined(TRIM(DIFF_FIELDS) <> '');

 layout_crosstab := RECORD
	num_recs := COUNT(GROUP);
	dJoinedDiff.DIFF_FIELDS;
END;

 pctJoinDiff := (count(dJoinedDiff)/count(dJoined))*100;

 dCrosstabDiff     := TABLE(dJoinedDiff, layout_crosstab, DIFF_FIELDS);
 dCrosstabDiff_srt := SORT(dCrosstabDiff, -num_recs); //get most differences at the top

//pick a sample of the top 10 differences
 dSampleDiff := CHOOSEN(dJoinedDiff(DIFF_FIELDS = dCrosstabDiff_srt[1].DIFF_FIELDS), 10)
												+ CHOOSEN(dJoinedDiff(DIFF_FIELDS = dCrosstabDiff_srt[2].DIFF_FIELDS), 10)
												+ CHOOSEN(dJoinedDiff(DIFF_FIELDS = dCrosstabDiff_srt[3].DIFF_FIELDS), 10)
												+ CHOOSEN(dJoinedDiff(DIFF_FIELDS = dCrosstabDiff_srt[4].DIFF_FIELDS), 10)
												+ CHOOSEN(dJoinedDiff(DIFF_FIELDS = dCrosstabDiff_srt[5].DIFF_FIELDS), 10)												
												+ CHOOSEN(dJoinedDiff(DIFF_FIELDS = dCrosstabDiff_srt[6].DIFF_FIELDS), 10)
												+ CHOOSEN(dJoinedDiff(DIFF_FIELDS = dCrosstabDiff_srt[7].DIFF_FIELDS), 10)
												+ CHOOSEN(dJoinedDiff(DIFF_FIELDS = dCrosstabDiff_srt[8].DIFF_FIELDS), 10)
												+ CHOOSEN(dJoinedDiff(DIFF_FIELDS = dCrosstabDiff_srt[9].DIFF_FIELDS), 10)
												+ CHOOSEN(dJoinedDiff(DIFF_FIELDS = dCrosstabDiff_srt[10].DIFF_FIELDS),10);
												
 layout_plus_diff := RECORD
  string DIFF_FIELDS;
	integer SRT;
  Layout_Slim;	
END;

 layout_plus_diff xform_2(Layout_Joined L, integer fileNum) := TRANSFORM
	SELF.SRT := fileNum;
	SELF.DIFF_FIELDS := L.DIFF_FIELDS;
	vRecordValues := IF(fileNum=1,L.PRIOR_VALUE,L.CURRENT_VALUE);
	SELF := vRecordValues;
END;

 dSampleDiffNorm := PROJECT(dSampleDiff, xform_2(left,1)) +  PROJECT(dSampleDiff, xform_2(left,2));

	msg 							:= 'MARI - vendor file(s) to MARI base file conversion\n\n' +
	                     'Source Code:\t\t' + src_cd + '\n' +
	                     'New update:\t\t' + new_date + '\n' +
	                     'Last update:\t\t' + latest_date + '\n' +
											 'Work Unit:\t\t' + thorlib.wuid() + '\n' +
											 'File Name:\t\t' + mari_dest+new_date+'::'+src_cd + '\n' +
                       '\t\t\tNew update(' +  new_date + ') has ' + cNewData + ' records and last update (' + latest_date + ') has ' + cLatestUpdate +' records.\n\r' +
											 '\t\t\t# of records added to update '+new_date+' is '+cntDiff+' ('+(DECIMAL5_2)(cntChangePercent*100)+'%).\n\r' + 
											 '\t\t\t# of records in these 2 updates after merge and dedup is ' + cCombinedDedup+'.\n\r' +
											 '\t\t\t# of different records between new and latest updates is '+cntMergeDiff+' ('+(DECIMAL5_2)(cntMergeDiffPercent*100)+'%)';
	warning_subj 			:= 'WARNING: MARI update '+mari_dest+new_date+'::'+src_cd+' is a suspect of layout change.';
	warning_msg  			:= 'Warning Type:\t\t# of changed records in the new update exceeds expectation\n' +
	                     '\t\t\tThis update is a suspect of layout change and has been added to ' +mari_dest+layout_change_suspect_file_name +'.\n\r' +
	                     '\n\nPLEASE EXAMINE AND TAKE APPROPRIATE ACTION.';
	
  layout_change_flag := IF(ABS(cntChangePercent) > accepted_record_cnt_change_1 OR
													 ABS(cntMergeDiffPercent) > accepted_record_cnt_change_2,True,False);
	
	msg2 							:= IF(layout_change_flag,'Update '+new_date+' has been added to the layout change suspect superfile.',
	                        'Update '+new_date+' has been added to its superfile successfully.');
	
	RETURN SEQUENTIAL(IF(FileServices.FileExists(superfile_name) AND FileServices.GetSuperFileSubCount(superfile_name) > 0,
										SEQUENTIAL(OUTPUT(SORT(dCombinedDedup, LICENSE_NBR,NAME_ORG, NAME_DBA_ORIG, NAME_OFFICE, ADDR_ADDR1_1,ADDR_CITY_1,ADDR_ZIP5_1,LAST_UPD_DTE,LOCAL),NAMED('Merged_and_Dedupd_2Updates'));
										           OUTPUT((DECIMAL5_2) pctJoinDiff+'%', NAMED('pctJoinDiff'));
															 OUTPUT(dCrosstabDiff_srt, NAMED('crosstab_Diff'));
															 OUTPUT(sampleOutput,NAMED('Sample_Diff1'));
															 OUTPUT(SORT(dSampleDiffNorm, DIFF_FIELDS, UNIQUE_ID, SRT), NAMED('Sample_diff2'));	
															 OUTPUT(msg,NAMED('Message'));
															 FileServices.StartSuperFileTransaction();
															 IF(NOT FileServices.SuperFileExists(layout_change_suspect_file_name), FileServices.CreateSuperFile(layout_change_suspect_file_name));
															 IF(layout_change_flag,
																  PARALLEL(FileServices.AddSuperFile(mari_dest+layout_change_suspect_file_name, mari_dest+new_date+'::'+src_cd),
																	 				fileservices.sendemail(Prof_License_Mari.Email_Notification_Lists.BaseFileConversion,
																																 warning_subj, msg+'\n\r'+warning_msg),
																					),
																  PARALLEL(FileServices.AddSuperFile(mari_dest+src_cd, mari_dest+new_date+'::'+src_cd)
																	));
																OUTPUT(msg2,NAMED('UpdateStatus'));
															 FileServices.FinishSuperFileTransaction();
															),
										SEQUENTIAL(FileServices.StartSuperFileTransaction();
										           IF(NOT FileServices.FileExists(superfile_name),FileServices.CreateSuperFile(superfile_name));
															 FileServices.AddSuperFile(superfile_name, mari_dest+new_date+'::'+src_cd);
															 FileServices.FinishSuperFileTransaction();
															)));
END;
