IMPORT _control, PromoteSupers, RoxieKeyBuild, Scrubs_PhonesInfo, Std, dx_PhonesInfo;

//DF-28036: Convert 6-Digit Spids to 4-Character Spids

EXPORT Proc_Build_Carrier_Reference(string version, string inclCheck, string emailTarget):= function																																										
																																																																																							
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	//Check Category Change - Send Notification Email////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////	
		
		//////////////////////////////////////////////////////////////////////////
		//Send Alert Email If Current Lerg1 Category Changed From Existing Build//
		//////////////////////////////////////////////////////////////////////////
		
		checkFile					:= PhonesInfo.fn_email_lerg1_category_change;
		
		mailCheckAttach 	:= FileServices.SendEmailAttachData(emailTarget
																													,'Phones Metadata - Carrier Reference: Lerg1 Category Change Detected - ' + version		//subject
																													,'Lerg1 Category Change Detected: Review ' + WORKUNIT  	//body
																													,(data)checkFile
																													,'text/csv'
																													,'Lerg1_Category_'+version+'.csv'
																													,
																													,
																													,emailTarget);

		pullCheck					:= if(checkFile='no lerg1 category changes',
														output('no lerg1 category changes'),
														mailCheckAttach);
	
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	//Create Carrier Reference Base File/////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		//Process Input Files
		cleanLergAddr			:= output(PhonesInfo.Clean_Lerg_Addresses);
			
		//Build Carrier Reference Base
		buildCRBase				:= PhonesInfo.Map_Carrier_Reference(version);	
												 		
		clearCRDelete 		:= nothor(fileservices.clearsuperfile('~thor_data400::base::phones::source_reference_main_delete', true));														
		
		moveCRBase				:= Std.File.PromoteSuperFileList(['~thor_data400::base::phones::source_reference_main',
																												'~thor_data400::base::phones::source_reference_main_father',
																												'~thor_data400::base::phones::source_reference_main_grandfather',
																												'~thor_data400::base::phones::source_reference_main_delete'], '~thor_data400::base::phones::source_reference_main_'+ version, true);
		
		runBuild					:= sequential(cleanLergAddr,
																		buildCRBase, clearCRDelete, moveCRBase);			
		
	//////////////////////////////////////////////////////////////////////////////////////////////	
	//Generate Incomplete Records For Review Email////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////////////////////////
		
		revIncompFile			:= PhonesInfo.fn_email_incomplete_carrier_reference_records(version);
		
		mailRevIncomp 		:= FileServices.SendEmailAttachData(PhonesInfo.emailNotification.Dev
																													,'Phones Metadata - Carrier Reference: Incomplete Lerg Records for Review - ' + version		//subject
																													,'Phones Metadata - Carrier Reference: Incomplete Lerg Records for Review: ' + WORKUNIT  	//body
																													,(data)revIncompFile
																													,'text/csv'
																													,'Lerg_Incomplete_Review_'+version+'.csv'
																													,
																													,
																													,emailTarget);
													
		clrRevIncomp			:= nothor(fileservices.clearsuperfile('~thor_data400::base::phones::source_reference_main_review_delete', true));		
		
		moveRevIncomp			:= Std.File.PromoteSuperFileList(['~thor_data400::base::phones::source_reference_main_review',
																												'~thor_data400::base::phones::source_reference_main_review_father',
																												'~thor_data400::base::phones::source_reference_main_review_delete'], '~thor_data400::base::phones::source_reference_main_review_'+ version, true);
		
		pullRevIncomp			:= if(revIncompFile='no incomplete carrier reference records available',
														output('no incomplete carrier reference records available'),
														sequential(mailRevIncomp, clrRevIncomp, moveRevIncomp));		
		
	//////////////////////////////////////////////////////////////////////////////////////////////	
	//Generate Carrier Reference Differences from Update Email////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////////////////////////

		revDiffFile				:= PhonesInfo.fn_email_before_after_carrier_record_differences;
		
		mailRevDiff				:= FileServices.SendEmailAttachData(PhonesInfo.emailNotification.Dev
																													,'Phones Metadata - Carrier Reference: Different Ocn/Carrier_Name/Spid/Serv/Line Type for Review - ' + version		//subject
																													,'Phones Metadata - Carrier Reference: Different Ocn/Carrier_Name/Spid/Serv/Line Type for Review: ' + WORKUNIT  	//body
																													,(data)revDiffFile
																													,'text/csv'
																													,'Lerg_Review_Diff_Rec_Types_'+version+'.csv'
																													,
																													,
																													,emailTarget);
														
		pullRevDiff				:= if(revDiffFile='no carrier reference records ocn/carrier_name/serv/line/spid differences available',
														output('no carrier reference records ocn/carrier_name/serv/line/spid differences available'),
														mailRevDiff);	
														
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	//Run Scrub Reports//////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	
		scrubsRuns				:= sequential(Scrubs_PhonesInfo.RawLergFileScrubs(version, emailTarget),
																		Scrubs_PhonesInfo.MainCarrierRefScrubs(version, emailTarget)
																		);
																		
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	//Build Carrier Reference Key////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////
	RoxieKeyBuild.Mac_SK_BuildProcess_v3_local(dx_PhonesInfo.Key_Source_Reference.ocn_name
																							,PhonesInfo.File_Source_Reference.Main
																							,'~thor_data400::key::phonesmetadata::carrier_reference'
																							,'~thor_data400::key::'+version+'::phonesmetadata::carrier_reference'
																							,bkPhonesMetadataCarrierName
																							);	

	//Move Metadata Carrier Name Key to Built Superfile	
	Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::phonesmetadata::carrier_reference'
																							,'~thor_data400::key::'+version+'::phonesmetadata::carrier_reference'
																							,mvBltPhonesMetadataCarrierName
																							);
	
	//Move Metadata Carrier Name Key to QA Superfile
	PromoteSupers.Mac_SK_Move_v2('~thor_data400::key::phonesmetadata::carrier_reference','Q',mvQAPhonesMetadataCarrierName,'3');
	
	keyBuild 						:= sequential(bkPhonesMetadataCarrierName, mvBltPhonesMetadataCarrierName, mvBltPhonesMetadataCarrierName);

/////////////////////////////////////////////////////////////////////////////////////////////////////////////	
//Run Strata Stats///////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
	PhonesInfo.Out_STRATA_Population_Stats_Monthly(
																			 PhonesInfo.File_Source_Reference.Main		
																			,version      
																			,buildStrata);        
	//////////////////////////////////////////////////////////////////////////////////////////////
	//Run Check/Output Files/Generate Emails//////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////////////////////////
		
		//Do Pre-Build Check
		doCheck 					:= pullCheck;																																	//Run Lerg1 Category Change Check
		prodBuild					:= sequential(runBuild, pullRevIncomp, pullRevDiff, scrubsRuns, keyBuild, buildStrata);		//Run Build / Generate Review Files / Build Key
		checkBuild				:= if(checkFile='no lerg1 category changes',
														prodBuild,
														output('check lerg1 for changes'));
		
	//////////////////////////////////////////////////////////////////////////////////////////////
	//BUILD BEGINS HERE///////////////////////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////////////////////////
		
		runAll						:= if(inclCheck='Y',													//If a pre-build check is selected, run the Lerg1 category change check
														sequential(doCheck, checkBuild),				//If there is no change in the Lerg1 category field, proceed with the build.  Otherwise, stop the build
														prodBuild);															//If a pre-build check was not selected, skip the check and proceed with the build (used for rebuilds)
		
		outFiles					:= runAll:
														Success(if((inclCheck='Y' and checkFile='no lerg1 category changes') or inclCheck<>'Y',
																			FileServices.SendEmail(emailTarget, 'PhonesInfo: Carrier Reference Build Completed', workunit + ': Build completed.'),
																			FileServices.SendEmail(emailTarget, 'PhonesInfo: Carrier Reference Build Aborted', workunit + ': Review Lerg1 category change.'))),
														Failure(FileServices.SendEmail(emailTarget, 'PhonesInfo: Carrier Reference Build Failed', workunit + '\n' + FAILMESSAGE));
																										
	return outFiles;

end;