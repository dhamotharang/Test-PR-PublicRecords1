IMPORT Prof_License_Mari, /*Scrubs_Prof_License_Mari,*/ ut, _Control;
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
	mari_dest						:= '~thor_data400::in::proflic_mari::';

	// super file
	superfile_name		:=  mari_dest + src_cd;
	dBasefile					:=	DATASET(mari_dest+src_cd,Prof_License_Mari.layout_base_in,thor);
	latest_date				:=	MAX(dBasefile,date_vendor_last_reported);
	dLatestUpdate			:=	dBasefile(date_vendor_last_reported=latest_date);

	// count of new and the latest update in the super file
	cNewData					:=	COUNT(dNewData);
	cLatestUpdate			:=	COUNT(dLatestUpdate);
	cntDiff						:=	cNewData - cLatestUpdate;
	cntChangePercent	:=  cntDiff / cLatestUpdate;

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
	dNotDedupedLicNbr	:= table(dCombinedDedup,{LICENSE_NBR,cnt:=COUNT(GROUP)},LICENSE_NBR);
	sampleOutput			:= JOIN(SORT(dCombinedDedup,LICENSE_NBR),
	                          SORT(dNotDedupedLicNbr(cnt>1),LICENSE_NBR),
														LEFT.LICENSE_NBR=RIGHT.LICENSE_NBR,
														TRANSFORM({dCombinedDedup},SELF:=LEFT;),
														INNER);
	
	msg 							:= 'MARI - vendor file(s) to MARI base file conversion\n\n' +
	                     'Warning Type:\t\t# of changed records in the new update exceeds expectation\n' +
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
	warning_msg  			:= '\t\t\tThis update is a suspect of layout change and has been added to ' +mari_dest+layout_change_suspect_file_name +'.\n\r' +
	                     '\n\nPLEASE EXAMINE AND TAKE APPROPRIATE ACTION.';
											 
	RETURN SEQUENTIAL(IF(FileServices.FileExists(superfile_name) AND FileServices.GetSuperFileSubCount(superfile_name) > 0,
										SEQUENTIAL(OUTPUT(SORT(dCombinedDedup, LICENSE_NBR,NAME_ORG, NAME_DBA_ORIG, NAME_OFFICE, ADDR_ADDR1_1,ADDR_CITY_1,ADDR_ZIP5_1,LAST_UPD_DTE,LOCAL)/*,NAMED('Merged_and_Dedupd_'+(string) new_date)*/);
										           OUTPUT(sampleOutput);
															 OUTPUT(msg);
															 FileServices.StartSuperFileTransaction();
															 IF(NOT FileServices.SuperFileExists(layout_change_suspect_file_name), FileServices.CreateSuperFile(layout_change_suspect_file_name));
															 IF(ABS(cntChangePercent) > accepted_record_cnt_change_1 OR
																  ABS(cntMergeDiffPercent) > accepted_record_cnt_change_2,
																  PARALLEL(FileServices.AddSuperFile(mari_dest+layout_change_suspect_file_name, mari_dest+new_date+'::'+src_cd),
																	 				fileservices.sendemail(Prof_License_Mari.Email_Notification_Lists.BaseFileConversion,
																																 warning_subj, msg+'\n\r'+warning_msg),
																					OUTPUT('Update '+new_date+' has been added to the layout change suspect superfile.'),
																					),
																  PARALLEL(FileServices.AddSuperFile(mari_dest+src_cd, mari_dest+new_date+'::'+src_cd),
																					OUTPUT('Update '+new_date+' has been added to its superfile successfully')));
															 FileServices.FinishSuperFileTransaction();
															),
										SEQUENTIAL(FileServices.StartSuperFileTransaction();
										           IF(NOT FileServices.FileExists(superfile_name),FileServices.CreateSuperFile(superfile_name));
															 FileServices.AddSuperFile(superfile_name, mari_dest+new_date+'::'+src_cd);
															 FileServices.FinishSuperFileTransaction();
															)));
END;
