import lib_fileservices, lib_WorkunitServices, lib_StringLib, lib_ThorLib, Std;

lEmailTarget									:=	'tony.kirk@lexisnexis.com';
lWUDatasetName								:=	'dLogicalNotInSupers';

// boolean	fIsOnValidCluster			:=	_control.ThisCluster.GroupName = 'hthor';

string		lLogicalFileMask				:=	regexreplace('::raw::',Common.eFileName.fConstruct(Common.eAddressType.Raw,	Common.eFileName.ActivityType.New,'w*'),'::*::');
string		lProdRawFileName				:=	Common.eFileName.fConstruct(Common.eAddressType.Raw,	Common.eFileName.ActivityType.Cache, Common.eFileName.SuperGeneration.Prod);
string		lProdStdFileName				:=	Common.eFileName.fConstruct(Common.eAddressType.Std,	Common.eFileName.ActivityType.Cache, Common.eFileName.SuperGeneration.Prod);
string		lProdACEFileName				:=	Common.eFileName.fConstruct(Common.eAddressType.ACE,	Common.eFileName.ActivityType.Cache, Common.eFileName.SuperGeneration.Prod);
string		lFatherRawFileName			:=	Common.eFileName.fConstruct(Common.eAddressType.Raw,	Common.eFileName.ActivityType.Cache, Common.eFileName.SuperGeneration.Father);
string		lFatherStdFileName			:=	Common.eFileName.fConstruct(Common.eAddressType.Std,	Common.eFileName.ActivityType.Cache, Common.eFileName.SuperGeneration.Father);
string		lFatherACEFileName			:=	Common.eFileName.fConstruct(Common.eAddressType.ACE,	Common.eFileName.ActivityType.Cache, Common.eFileName.SuperGeneration.Father);
string		lGrandfatherRawFileName	:=	Common.eFileName.fConstruct(Common.eAddressType.Raw,	Common.eFileName.ActivityType.Cache, Common.eFileName.SuperGeneration.Grandfather);
string		lGrandfatherStdFileName	:=	Common.eFileName.fConstruct(Common.eAddressType.Std,	Common.eFileName.ActivityType.Cache, Common.eFileName.SuperGeneration.Grandfather);
string		lGrandfatherACEFileName	:=	Common.eFileName.fConstruct(Common.eAddressType.ACE,	Common.eFileName.ActivityType.Cache, Common.eFileName.SuperGeneration.Grandfather);
string		lExceptRawFileName			:=	Common.eFileName.fConstruct(Common.eAddressType.Raw,	Common.eFileName.ActivityType.New, Common.eFileName.SuperGeneration.Exception);
string		lExceptStdFileName			:=	Common.eFileName.fConstruct(Common.eAddressType.Std,	Common.eFileName.ActivityType.New, Common.eFileName.SuperGeneration.Exception);
string		lExceptACEFileName			:=	Common.eFileName.fConstruct(Common.eAddressType.ACE,	Common.eFileName.ActivityType.New, Common.eFileName.SuperGeneration.Exception);

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

fAddToSuper(string pSubName)
 :=
  function
		lSuperName	:=	if(lib_stringlib.StringLib.StringFind(pSubName,'::raw::',1) <> 0,
											 lProdRawFileName,
											 if(lib_stringlib.StringLib.StringFind(pSubName,'::std::',1) <> 0,
													lProdStdFileName,
													lProdACEFileName
												 )
											);
		return	nothor(lib_FileServices.FileServices.AddSuperFile('~' + lSuperName, '~' + pSubName));
  end
 ;

zOutputDatasetsToUse	:=	output(dLogicalNotInSupers,all,named(lWUDatasetName));

dLogicalsToAdd				:=	dataset(workunit(lWUDatasetName),recordof(dLogicalNotInSupers));

zAddCandidates				:=	if(exists(dLogicalsToAdd),
													   sequential(lib_FileServices.FileServices.StartSuperFileTransaction(),
																			   nothor(apply(dLogicalsToAdd,fAddToSuper(name))),
																			   lib_FileServices.FileServices.FinishSuperFileTransaction()
																			  ),
														 output('No files to add - ' + Std.Date.SecondsToString(Std.Date.CurrentSeconds(TRUE), '%F%H%M%S%u'))
														);

zSendFailureEmail			:=	lib_FileServices.FileServices.SendEmail(lEmailTarget,'FAILED: ProcAddNewCacheFiles ' + workunit,'FAILED: ProcAddNewCacheFiles ' + workunit);

export ProcAddNewCacheFiles
 :=	if(lib_ThorLib.thorlib.nodes() <> 1,
			 fail('Abort:  This job must be run on hthor.'),
			 sequential(zOutputDatasetsToUse,
									 zAddCandidates
									)
			)
 : failure(zSendFailureEmail)
 ;
