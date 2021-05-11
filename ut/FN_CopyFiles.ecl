IMPORT _control, did_add;

/////////RUN ON HTHOR OR COMPAREFILES WILL NOT WORK!!!!!!!////////////////////////////////////////////////////////////////////////////////////////
/////////RUN ON HTHOR OR COMPAREFILES WILL NOT WORK!!!!!!!////////////////////////////////////////////////////////////////////////////////////////
/////////RUN ON HTHOR OR COMPAREFILES WILL NOT WORK!!!!!!!////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////// This attribute will manage superfiles across environments. The QA version and filename will be the exact 
//////// same as what is currently in the QA superfile you are copying. This includes any file moves necessary.
//////// To see what was previously in the destination QA, look in the FATHER super (to help for rollback purposes).
//////// 
//////// USES superfiles on foreign thor and local thor to find out if logical files (or keys) need to be copied over,
//////// moved to father, or removed. 
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

EXPORT FN_CopyFiles(STRING psname, // superfile name to copy
								STRING destinationGroup = 'thor400_198_a', //cluster to drop file
								STRING pDaliIP = _control.IPAddress.prod_thor_dali, // Dali IP for where data currently resides
								STRING pEnvironmentVariable = '', // if you want to check prod roxie for new version (ex: iheader_build_version)
								STRING pRoxieIP = 'http://' + _Control.RoxieEnv.boca_prodvip, // if you want to check prod roxie for new version (ex: http://Iroxievip.sc.seisint.com:9876 - alpha prod)
								STRING emails = 'kevin.l.logemann@lexisnexis.com, DataFab-ALP@lexisnexis.com') := FUNCTION 

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/* 		// New File Tracking */
		
		ProdRoxieVersion := did_add.get_EnvVariable(pEnvironmentVariable, pRoxieIP) : INDEPENDENT;
		
		sname := stringlib.stringfilterout(psname, '~ ');

		MetadataDS_Layout := RECORD
			STRING superfile;
			STRING EnvironmentVariable;
			STRING version;
			STRING lastUpdate;
		END;
		
		MetadataDS := DATASET('~thor_data400::flag::filecopies::prodversion', MetadataDS_Layout, THOR, OPT);
		
		DDMetadataDS := SORT(MetadataDS(EnvironmentVariable = pEnvironmentVariable AND superfile = sname), -lastUpdate);
											
		isNewProdRoxieVersion := (pEnvironmentVariable <> '' AND ProdRoxieVersion > DDMetadataDS[1].version);
		
		VersionUpdateDS := DEDUP(SORT(DATASET([{sname, pEnvironmentVariable, ProdRoxieVersion, ut.GetDate}], MetadataDS_Layout) + MetadataDS, RECORD), RECORD); // why not deduping?
		
		DTSuffix := stringlib.stringfilter(ut.GetTimeDate(), '0123456789') : INDEPENDENT;
		
		VersionUpdate := IF(pEnvironmentVariable <> '',
													SEQUENTIAL(
																OUTPUT(VersionUpdateDS,,'~thor_data400::flag::filecopies::prodversion::'+DTSuffix, __COMPRESSED__, OVERWRITE, NAMED('UpdatedVersionFile')),
																fileservices.startsuperfiletransaction(),
																NOTHOR(fileservices.clearsuperfile('~thor_data400::flag::filecopies::prodversion', TRUE));
																NOTHOR(fileservices.addsuperfile('~thor_data400::flag::filecopies::prodversion','~thor_data400::flag::filecopies::prodversion::'+DTSuffix)),
																fileservices.finishsuperfiletransaction())
																);
																
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/* 		// Generate superfile names for father and grandfather, and Create supers if needed */
		
				version := MAP(
									 REGEXFIND('(_qa$)', sname) => '_qa', //3
									 REGEXFIND('(::qa$)', sname) => '::qa', //4
									 REGEXFIND('(::qa::)', sname) => '::qa::', //6
									 REGEXFIND('(_prod$)', sname) => '_prod', //5
									 REGEXFIND('(::prod$)', sname) => '::prod', //6
									 REGEXFIND('(::prod::)', sname) => '::prod::', //8
									 REGEXFIND('(_built$)', sname) => '_built', //6
									 REGEXFIND('(::built$)', sname) => '::built', //7
									 REGEXFIND('(::built::)', sname) => '::built::', //9
									 REGEXFIND('(::in::)', sname) => '::in::', //6
									 REGEXFIND('(::out::)', sname) => '::out::', //7
									 REGEXFIND('(::spray::)', sname) => '::spray::', //9
									 REGEXFIND('(^spray::)', sname) => 'spray::', //7
									 FAIL(STRING, 'Superfile version must be qa, prod, built, or supplied to function, and cannot be father or grandfather for this process to work.'));

				FindStart(STRING pSname, STRING pVersion) := STRINGLIB.STRINGFIND(TRIM(pSname, ALL), TRIM(pVersion, ALL), 1);
				
				FindEnd := MAP(version IN ['_qa'] => 3,
												version IN ['::qa'] => 4,
												version IN ['_prod'] => 5,
												version IN ['::in::','::qa::','::prod','_built'] => 6,
												version IN ['::built','::out::'] => 7,
												version IN ['::prod::'] => 8,
												version IN ['::built::','::spray::'] => 9,
												version IN ['spray::'] => 7,
												FAIL(STRING, 'Cannot find superfile version in superfile name - spray, in, out, qa, prod, built.'));

				sname_prefix := sname[..FindStart(sname, version)-1];
				sname_suffix := sname[FindStart(sname, version)+FindEnd..];
		
		sname_delete := MAP(version IN ['::in::','::qa::','::prod::','::built::','::out::','::spray::'] => sname_prefix + '::delete::' + sname_suffix,
												version IN ['::qa','::prod','::built'] => sname_prefix + '::delete',
												version IN ['spray::'] => sname + '::delete',
												sname_prefix + '_delete');
		
		sname_father := MAP(version IN ['::in::','::qa::','::prod::','::built::','::out::','::spray::'] => sname_prefix + '::father::' + sname_suffix,
												version IN ['::qa','::prod','::built'] => sname_prefix + '::father',
												version IN ['spray::'] => sname + '::father',
												sname_prefix + '_father');

		CreateNewSupers := SEQUENTIAL( // create a "perfect" father fallback that reflect what was in the alpha qa, whether or not the files are still in qa. need to change clear-father so it will intelligently pick which file to delete (use delete super)
													fileservices.startsuperfiletransaction(),
													NOTHOR(IF(~fileservices.superfileexists('~thor_data400::flag::filecopies::prodversion'), fileservices.createsuperfile('~thor_data400::flag::filecopies::prodversion'))), 
													NOTHOR(IF(~fileservices.superfileexists('~'+sname), fileservices.createsuperfile('~'+sname))),
													NOTHOR(IF(~fileservices.superfileexists('~'+sname_father), fileservices.createsuperfile('~'+sname_father))),
													NOTHOR(IF(~fileservices.superfileexists('~'+sname_delete), fileservices.createsuperfile('~'+sname_delete))),
													fileservices.finishsuperfiletransaction()
													) : INDEPENDENT;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/* 		// Find new logical files for copying */

		Local_Super_Exist := NOTHOR(fileservices.superfileexists('~'+sname));
			TempName := IF(Local_Super_Exist, '~'+sname, '~foreign::' + pDaliIP + '::' + sname); //during map or if statements, it will try to validate all options. to stop the error, this code was added.
		Local_Logical_FileNameDS := NOTHOR(fileservices.superfilecontents(TempName));

		Foreign_Logical_FileNameDS1 := NOTHOR(fileservices.superfilecontents('~foreign::' + pDaliIP + '::' + sname));
		Foreign_Logical_FileNameDS := PROJECT(Foreign_Logical_FileNameDS1, 
																			TRANSFORM({RECORDOF(Foreign_Logical_FileNameDS1)},
																								SELF.name := LEFT.name[stringlib.stringfind(LEFT.name, '::', 2) + 2..];
																								SELF := LEFT));

		SuperFileStatus := JOIN(Foreign_Logical_FileNameDS, Local_Logical_FileNameDS, 
																LEFT.name = RIGHT.name, 
																TRANSFORM({STRING name, BOOLEAN ForeignOnly, BOOLEAN LocalOnly, STRING8 DateChecked},
																					SELF.name := TRIM(MAX(LEFT.name, RIGHT.name), ALL);
																					SELF.ForeignOnly := RIGHT.name = '', 
																					SELF.LocalOnly := LEFT.name = '',
																					SELF.DateChecked := ut.GetDate),
																FULL OUTER) : INDEPENDENT;
																
		LocalOnly 	:= Foreign_Logical_FileNameDS(name IN SET(Local_Logical_FileNameDS, name) AND name NOT IN SET(Foreign_Logical_FileNameDS, name));												
		ForeignOnly := Foreign_Logical_FileNameDS(name NOT IN SET(Local_Logical_FileNameDS, name) AND name IN SET(Foreign_Logical_FileNameDS, name));												
		Both := Foreign_Logical_FileNameDS(name IN SET(Local_Logical_FileNameDS, name) AND name IN SET(Foreign_Logical_FileNameDS, name));												

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/* 		// Perform file/key copies */

		Del_Super_Exist := NOTHOR(fileservices.superfileexists('~'+sname_delete));
			DelTempName := IF(Del_Super_Exist, '~'+sname_delete, '~foreign::' + pDaliIP + '::' + sname_delete); //during map or if statements, it will try to validate all options. to stop the error, this code was added.
		Del_Logical_FileNameDS := NOTHOR(fileservices.superfilecontents(DelTempName));

		FileUpdatesNeeded := (isNewProdRoxieVersion OR pEnvironmentVariable = '') AND COUNT(SuperFileStatus(ForeignOnly OR LocalOnly)) > 0 : INDEPENDENT;
	
		CopyNewFile(STRING pCopyNew) := IF(~fileservices.fileexists('~'+pCopyNew), 
																						SEQUENTIAL(
																							fileservices.Copy('~'+pCopyNew, destinationGroup, '~'+pCopyNew, pDaliIP, , , , TRUE, TRUE, FALSE, TRUE, FALSE, );
																							fileservices.addsuperfile('~'+sname,'~'+pCopyNew),
																							),
																						SEQUENTIAL(
																							fileservices.addsuperfile('~'+sname,'~'+pCopyNew),
																						));
	
		DeleteFile(STRING pDelNew) := FUNCTION
			SuperOwners := SET(fileservices.LogicalFileSuperOwners('~'+pDelNew),name);
									
		RETURN IF(COUNT(SuperOwners) > 1, 
							 fileservices.removesuperfile('~'+sname_delete,'~'+pDelNew),
							 SEQUENTIAL(fileservices.removesuperfile('~'+sname_delete,'~'+pDelNew), fileservices.deletelogicalfile('~'+pDelNew)));
		END;
		
		Step1_Copy := NOTHOR(APPLY(Del_Logical_FileNameDS, DeleteFile(name))); // clear delete
		Step2_Copy := NOTHOR(fileservices.addsuperfile('~'+sname_delete,'~'+sname_father,,TRUE)); // add father to delete
		Step3_Copy := NOTHOR(fileservices.clearsuperfile('~'+sname_father)); // clear  father
		Step4_Copy := NOTHOR(fileservices.addsuperfile('~'+sname_father,'~'+sname,,TRUE)); // add qa/sname to father (this is to maintain history for rollback)
		Step5_Copy := NOTHOR(fileservices.clearsuperfile('~'+sname)); // clear qa/sname
		Step6_Copy := NOTHOR(APPLY(ForeignOnly, CopyNewFile(name))); // copy new logical files and add to super
		Step7_Copy := NOTHOR(APPLY(Both, fileservices.addsuperfile('~'+Sname,'~'+name))); // put back any files to qa/sname that are not new
		Step8_Copy := NOTHOR(APPLY(Del_Logical_FileNameDS, DeleteFile(name))); // put back any files to qa/sname that are not new
		Step9_Copy := NOTHOR(fileservices.clearsuperfile('~'+Sname_delete)); // put back any files to qa/sname that are not new

		PerformCopy := IF(FileUpdatesNeeded,
															SEQUENTIAL(fileservices.startsuperfiletransaction();
															Step1_Copy;
															Step2_Copy;
															Step3_Copy;
															Step4_Copy;
															Step5_Copy;
															Step6_Copy;
															Step7_Copy;
															Step8_Copy;
															Step9_Copy;
															fileservices.finishsuperfiletransaction()));

		LetsDoIt_ExclamationPoint := SEQUENTIAL(CreateNewSupers,
																						OUTPUT(SuperFileStatus, NAMED('SuperfileContentsWithDates'), EXTEND),
																						PerformCopy);
																						
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/* 		// Generate messages for logging and emails */
		
		// NoNewDummyName := IF(FileUpdatesNeeded, '~foreign::10.241.20.205::' + name, '~' + name);
		
		FileCheckList1 := TABLE(SuperFileStatus(ForeignOnly), {STRING name := name + ' - File Check Value ' + (STRING)(fileservices.CompareFiles('~foreign::'+pDaliIP+'::' + name, IF(FileUpdatesNeeded, '~' + name, '~foreign::'+pDaliIP+'::' + name)))}); 
		FileCheckList := ROLLUP(FileCheckList1, TRANSFORM(RECORDOF(FileCheckList1), SELF.name := LEFT.name + '\n' + RIGHT.name, SELF := LEFT), 'ALL');
		FileCheckListQA := ROLLUP(Local_Logical_FileNameDS, TRANSFORM(RECORDOF(Local_Logical_FileNameDS), SELF.name := LEFT.name + '\n' + RIGHT.name, SELF := LEFT), 'ALL');

		FileCheck_Message_Lead := 'SuperFile\\Key Monitored: ' + sname + 
															'\n\nNew LogicalFile(s)\\Key(s) for Copy:\n' + FileCheckList[1].name + 
															'\n\nNew QA Superfile Contents:\n' + FileCheckListQA[1].name +
															'\n\nEnvironment Variable Parameters Set (if used)**\n\nEnvironment Variable:' + IF(pEnvironmentVariable = '', 'Not Used', pEnvironmentVariable) + 
															'\n\nEnvironment Variable Value: ' + stringlib.stringfindreplace(ProdRoxieVersion, 'Default', '') + 
															'\n\nRoxie IP Used: ' + pRoxieIP + 
															'\n\n';
		FileCheck_Message1 := FileCheck_Message_Lead + 
															IF(COUNT(SuperFileStatus(ForeignOnly)) > 0,
															'Value 0 - New file copied locally and the original foreign file match exactly.\n'+
															'Value 1 - New file copied locally and the original foreign file contents match, but the new file copied locally is newer than the original foreign file.\n'+
															'Value -1 - New file copied locally and the original foreign file contents match, but the original foreign file is newer than the new file copied locally.\n'+
															'Value 2 - New file copied locally and the original foreign file contents do not match, and the new file copied locally is newer than the original foreign file.\n'+
															'Value -2 - New file copied locally and the original foreign file contents do not match, and the original foreign file is newer than the new file copied locally.'
															, '');
													
		FileCheck_Message2 := FileCheck_Message_Lead + sname + 'contents already exist(s) or no new environment variable update on prod roxie. Copy not needed.\n' + FileCheckList[1].name;

		FileCheck_Message := IF(FileUpdatesNeeded, FileCheck_Message1, FileCheck_Message2);
		
		FileCheck_Subject := IF(FileUpdatesNeeded, 'Thor Copy ' + sname + ' to ' + _control.ThisEnvironment.name + ' Completed', 'Thor Copy ' + sname + ' to ' + _control.ThisEnvironment.name + ' Not Completed - File Up To Date');

		LogStatus := DATASET([{sname, FileCheck_Message, FileCheck_Subject, ut.GetDate}], 
													{STRING supername, STRING FileCheckMessageR, STRING status, STRING rundate});

	RETURN SEQUENTIAL(LetsDoIt_ExclamationPoint,
										VersionUpdate,
										OUTPUT(logstatus, EXTEND, NAMED('LogStatus')),
										fileservices.sendemail(emails, FileCheck_Subject, WORKUNIT + ' - ' + _control.ThisEnvironment.name + '\n\n' + FileCheck_Message)
										);

END;


// FN_CopyFiles('thor_data400::key::acclogs_scoring::qa::xml_intermediat', 
								// 'thor11',
								// _control.IPAddress.prod_thor_dali, // dali for where data currently resides
								// '', // if you want to check prod roxie for new version (ex: iheader_build_version)
								// 'http://roxiebatch.br.seisint.com:9856',
								// 'cecelie.reid@lexisnexis.com')
								
// Alpharetta Dev W20151221-085251								
// W20151218-122332, W20151210-230440, W20151210-230007, W20151210-225847, W20151210-225825 Alpharetta Dev
