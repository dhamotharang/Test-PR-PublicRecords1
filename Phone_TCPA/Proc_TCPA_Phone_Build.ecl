IMPORT _control, dx_Phonesplus, Phone_TCPA, PromoteSupers, Scrubs_Phone_TCPA, Std, Ut;

EXPORT Proc_TCPA_Phone_Build(string pVersion, const varstring pEclSourceIp, string pDirectory, string pContact, string pThor):= FUNCTION
	
	/////////////////////////////////////////////////////////////////////////
	//Spray Daily TCPA Raw Files/////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////
	
	sprayDaily 						:= SEQUENTIAL(Phone_TCPA.Spray_TCPA_Daily(pVersion, pEclSourceIp, pDirectory, 'WIRELESS-TO-WIRELINE', pThor),
																			Phone_TCPA.Spray_TCPA_Daily(pVersion, pEclSourceIp, pDirectory, 'WIRELESS-TO-WIRELINE-NORANGE', pThor),
																			Phone_TCPA.Spray_TCPA_Daily(pVersion, pEclSourceIp, pDirectory, 'WIRELINE-TO-WIRELESS', pThor),
																			Phone_TCPA.Spray_TCPA_Daily(pVersion, pEclSourceIp, pDirectory, 'WIRELINE-TO-WIRELESS-NORANGE', pThor)
																			);
	
	/////////////////////////////////////////////////////////////////////////
	//Build & Move Base File/////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////
	
	PromoteSupers.MAC_SF_BuildProcess(Phone_TCPA.Map_TCPA_Phone_History, '~thor_data400::base::phones::tcpa_main', buildBase, 2, , true, pVersion);	
	
	/////////////////////////////////////////////////////////////////////////
	//Process History Files//////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////
	
	//Distribute TCPA Raw Files
	dsDailyLC 						:= project(distribute(Phone_TCPA.File_TCPA_Phone.In_Wireless_to_Wireline), 					Phone_TCPA.Layout_TCPA.History);
	dsDailyLC_NR 					:= project(distribute(Phone_TCPA.File_TCPA_Phone.In_Wireless_to_Wireline_NoRange), 	Phone_TCPA.Layout_TCPA.History_NoRange);
	dsDailyCL 						:= project(distribute(Phone_TCPA.File_TCPA_Phone.In_Wireline_to_Wireless), 					Phone_TCPA.Layout_TCPA.History);
	dsDailyCL_NR 					:= project(distribute(Phone_TCPA.File_TCPA_Phone.In_Wireline_to_Wireless_NoRange), 	Phone_TCPA.Layout_TCPA.History_NoRange);
		
	//Create TCPA History Files
	dsHistoryLC						:= dedup(sort(distribute(dsDailyLC 		+ Phone_TCPA.File_TCPA_Phone.Wireless_to_Wireline_History, 					hash(cellphone)), record, local), record, local);
	dsHistoryLC_NR				:= dedup(sort(distribute(dsDailyLC_NR + Phone_TCPA.File_TCPA_Phone.Wireless_to_Wireline_NoRange_History, 	hash(cellphone)), record, local), record, local);
	dsHistoryCL						:= dedup(sort(distribute(dsDailyCL 		+ Phone_TCPA.File_TCPA_Phone.Wireline_to_Wireless_History, 					hash(cellphone)), record, local), record, local);
	dsHistoryCL_NR				:= dedup(sort(distribute(dsDailyCL_NR + Phone_TCPA.File_TCPA_Phone.Wireline_to_Wireless_NoRange_History, 	hash(cellphone)), record, local), record, local);
	
	//Build History and Move to Superfiles
	PromoteSupers.MAC_SF_BuildProcess(dsHistoryLC, 		'~thor_data400::in::phones::tcpa_wireless-to-wireline_history', 				bldHistLC, 		2, , true, pVersion);
	PromoteSupers.MAC_SF_BuildProcess(dsHistoryLC_NR, '~thor_data400::in::phones::tcpa_wireless-to-wireline-norange_history', bldHistLC_NR, 2, , true, pVersion);
	PromoteSupers.MAC_SF_BuildProcess(dsHistoryCL, 		'~thor_data400::in::phones::tcpa_wireline-to-wireless_history', 				bldHistCL, 		2, , true, pVersion);
	PromoteSupers.MAC_SF_BuildProcess(dsHistoryCL_NR, '~thor_data400::in::phones::tcpa_wireline-to-wireless-norange_history', bldHistCL_NR, 2, , true, pVersion);
	
	buildHistory					:= SEQUENTIAL(bldHistLC,
																			bldHistLC_NR,
																			bldHistCL,
																			bldHistCL_NR
																			);
	
	//Run Scrub Reports
	runScrubs							:= Scrubs_Phone_TCPA.fn_RunScrubs(pVersion, pContact);
		
	/////////////////////////////////////////////////////////////////////////
	//Run Build Process//////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////

	sendEmail := SEQUENTIAL(sprayDaily, 
													buildBase,
													buildHistory,
													runScrubs):Success(FileServices.SendEmail(pContact, 'Phone TCPA Key Build Succeeded', workunit + ': Build complete.')),
																		 Failure(FileServices.SendEmail(pContact, 'Phone TCPA Key Build Failed', workunit + '\n' + FAILMESSAGE));

	RETURN sendEmail;

END;