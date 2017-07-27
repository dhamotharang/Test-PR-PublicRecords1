import AID_Support, lib_fileservices, lib_WorkunitServices, lib_StringLib, lib_ThorLib, ut;

lWUDatasetName								:=	'dLogicalNotInSupers';

boolean	fIsOnValidCluster()						:=	lib_ThorLib.ThorLib.Platform()	= 'hthor';
boolean	fIsCacheConsolidateRunning()	:=	Common.fIsJobRunning(AID_Support.Constants.JobName.CacheConsolidate);

string		lLogicalFileMask				:=	regexreplace('::raw::',Common.fConstructFilename(Constants.AddressType.Raw,	Constants.Filename.ActivityType.New,'w*'),'::*::');
string		lProdRawFileName				:=	Common.fConstructFilename(Constants.AddressType.Raw,	Constants.Filename.ActivityType.Cache, Constants.Filename.SuperGeneration.Prod);
string		lProdStdFileName				:=	Common.fConstructFilename(Constants.AddressType.Std,	Constants.Filename.ActivityType.Cache, Constants.Filename.SuperGeneration.Prod);
string		lProdACEFileName				:=	Common.fConstructFilename(Constants.AddressType.ACE,	Constants.Filename.ActivityType.Cache, Constants.Filename.SuperGeneration.Prod);
string		lFatherRawFileName			:=	Common.fConstructFilename(Constants.AddressType.Raw,	Constants.Filename.ActivityType.Cache, Constants.Filename.SuperGeneration.Father);
string		lFatherStdFileName			:=	Common.fConstructFilename(Constants.AddressType.Std,	Constants.Filename.ActivityType.Cache, Constants.Filename.SuperGeneration.Father);
string		lFatherACEFileName			:=	Common.fConstructFilename(Constants.AddressType.ACE,	Constants.Filename.ActivityType.Cache, Constants.Filename.SuperGeneration.Father);
string		lGrandfatherRawFileName	:=	Common.fConstructFilename(Constants.AddressType.Raw,	Constants.Filename.ActivityType.Cache, Constants.Filename.SuperGeneration.Grandfather);
string		lGrandfatherStdFileName	:=	Common.fConstructFilename(Constants.AddressType.Std,	Constants.Filename.ActivityType.Cache, Constants.Filename.SuperGeneration.Grandfather);
string		lGrandfatherACEFileName	:=	Common.fConstructFilename(Constants.AddressType.ACE,	Constants.Filename.ActivityType.Cache, Constants.Filename.SuperGeneration.Grandfather);
string		lExceptRawFileName			:=	Common.fConstructFilename(Constants.AddressType.Raw,	Constants.Filename.ActivityType.New, Constants.Filename.SuperGeneration.Exception);
string		lExceptStdFileName			:=	Common.fConstructFilename(Constants.AddressType.Std,	Constants.Filename.ActivityType.New, Constants.Filename.SuperGeneration.Exception);
string		lExceptACEFileName			:=	Common.fConstructFilename(Constants.AddressType.ACE,	Constants.Filename.ActivityType.New, Constants.Filename.SuperGeneration.Exception);

dLogicalFileList	:=	lib_fileservices.FileServices.LogicalFileList(lLogicalFileMask);

dSuperFileList		:=	lib_fileservices.FileServices.SuperFileContents('~' + lProdRawFileName)
									+		lib_fileservices.FileServices.SuperFileContents('~' + lProdStdFileName)
									+		lib_fileservices.FileServices.SuperFileContents('~' + lProdACEFileName);

dExceptFileList		:=	lib_fileservices.FileServices.SuperFileContents('~' + lExceptRawFileName)
									+		lib_fileservices.FileServices.SuperFileContents('~' + lExceptStdFileName)
									+		lib_fileservices.FileServices.SuperFileContents('~' + lExceptACEFileName)
									+		lib_fileservices.FileServices.SuperFileContents('~' + lFatherRawFileName)
									+		lib_fileservices.FileServices.SuperFileContents('~' + lFatherStdFileName)
									+		lib_fileservices.FileServices.SuperFileContents('~' + lFatherACEFileName)
									+		lib_fileservices.FileServices.SuperFileContents('~' + lGrandfatherRawFileName)
									+		lib_fileservices.FileServices.SuperFileContents('~' + lGrandfatherStdFileName)
									+		lib_fileservices.FileServices.SuperFileContents('~' + lGrandfatherACEFileName);

dLogicalNotInCache		:=	join(dLogicalFileList,dSuperFileList,
															 left.name = right.name,
															 left only
															);
dLogicalNotInSupers		:=	join(dLogicalNotInCache,dExceptFileList,
															 left.name = right.name,
								 							 left only
															);

fAddToSuper(string pSubName)	:=
function
	lSuperName	:=	if(lib_stringlib.StringLib.StringFind(pSubName,'::raw::',1) <> 0,
										 lProdRawFileName,
										 if(lib_stringlib.StringLib.StringFind(pSubName,'::std::',1) <> 0,
												lProdStdFileName,
												lProdACEFileName
											 )
										);
	return	nothor(lib_FileServices.FileServices.AddSuperFile('~' + lSuperName, '~' + pSubName));
end;

zOutputDatasetsToUse	:=	output(dLogicalNotInSupers, all, named(lWUDatasetName));

dLogicalsToAdd				:=	dataset(workunit(lWUDatasetName), recordof(dLogicalNotInSupers));

zAddCandidates				:=	if(exists(dLogicalsToAdd),
													   sequential(lib_FileServices.FileServices.StartSuperFileTransaction(),
																			   nothor(apply(dLogicalsToAdd, fAddToSuper(name))),
																			   lib_FileServices.FileServices.FinishSuperFileTransaction()
																			  ),
														 output('No files to add - ' + ut.GetTimeDate())
														);

zSendFailureEmail			:=	lib_FileServices.FileServices.SendEmail(Constants.EmailTargetErrors,'FAILED: ProcAddNewCacheFiles ' + workunit,'FAILED: ProcAddNewCacheFiles ' + workunit);

export ProcAddNewCacheFiles	:=	if(not fIsOnValidCluster(),
																	 fail('Abort:  This job must be run on hthor.'),
																	 if(fIsCacheConsolidateRunning(),
																			output('Cache Consolidate is running - ' + ut.GetTimeDate()),
																			sequential(zOutputDatasetsToUse,
																									zAddCandidates,
																									notify(AID_Support.Constants.EventTrigger.AddNewCacheFilesComplete, '*')
																								 )
																		 )
																	)
														: failure(zSendFailureEmail)
														;
