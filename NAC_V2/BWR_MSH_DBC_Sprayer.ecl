import	NAC, lib_FileServices, lib_StringLib, lib_ThorLib, Ut;
 
// ------------------------------------------------------------------------------------------------
string		gLandingZoneServer		:=	'edata10.br.seisint.com';//'edata12.br.seisint.com'					:	stored('LandingZoneServer');
string		gLandingZonePathBase	:=	'/data_build_4/nac';//'/hds_180/nac'										:	stored('LandingZonePathBase');
string		gTargetThor						:=	'thor400_30';//'thor40_241_11'											:	stored('TargetThor');
string		gThorFilenameBase			:=	'nac::for_msh::';
string		gSubDirectorySpraying	:=	'spraying';
string		gSubDirectorySprayed	:=	'sprayed';
string		gSubDirectoryDone			:=	'done';

// ------------------------------------------------------------------------------------------------
string		fFullRemotePathFromTokens(string pPathBase, string pFileTypeBase, string pFileName = '') :=	pPathBase + '/' + pFileTypeBAse + if(pFileName <> '', '/', '') + pFileName;
string		fEarliestFileName(dataset(lib_FileServices.FsFilenameRecord) pRemoteDirectoryList)	:=	sort(pRemoteDirectoryList, Modified)[1].Name;

STRING ProcessRecipient := MOD_InternalEmailsList.fn_GetInternalRecipients('Preprocess Error','');


// ------------------------------------------------------------------------------------------------
					fMoveFileToSpraying(string pDirectorySource, string pDirectoryTarget, string pFileName)	:=	lib_FileServices.FileServices.MoveExternalFile(gLandingZoneServer, fFullRemotePathFromTokens(gLandingZonePathBase, pDirectorySource, pFileName), fFullRemotePathFromTokens(gLandingZonePathBase, pDirectoryTarget + '/' + gSubDirectorySpraying, pFileName));
					fMoveFileToSprayed(string pDirectory, string pFileName)	:=	lib_FileServices.FileServices.MoveExternalFile(gLandingZoneServer, fFullRemotePathFromTokens(gLandingZonePathBase, pDirectory + '/' + gSubDirectorySpraying, pFileName), fFullRemotePathFromTokens(gLandingZonePathBase, pDirectory + '/' + gSubDirectorySprayed, pFileName));
					fMoveFileToDone(string pDirectory, string pFileName)	:=	lib_FileServices.FileServices.MoveExternalFile(gLandingZoneServer, fFullRemotePathFromTokens(gLandingZonePathBase, pDirectory + '/' + gSubDirectorySprayed, pFileName), fFullRemotePathFromTokens(gLandingZonePathBase, pDirectory + '/' + gSubDirectoryDone, pFileName));
					fSprayFile(string pDirectory, string pFileName, unsigned2 pRecordLength)	:=
					function
						zSprayIt		:=	lib_FileServices.fileservices.SprayFixed(	sourceIP								:=	gLandingZoneServer,
																																			sourcePath							:=	fFullRemotePathFromTokens(gLandingZonePathBase, pDirectory + '/' + gSubDirectorySpraying, pFileName),
																																			recordSize							:=	pRecordLength,
																																			destinationGroup				:=	gTargetThor,
																																			destinationLogicalName	:=	'~' + gThorFilenameBase + pFileName,
																																			compress								:=	true
																																		);
						return	zSprayIt;
					end;
					fAddToSuper(string pSuperName, string pFileName)	:=
					function
						zAddToSuper	:=	lib_FileServices.fileservices.AddSuperFile(	lSuperFN							:=	'~' + pSuperName,
																																				lFN										:=	'~' + pFileName
																																			);
						return	zAddToSuper;
					end;

// ------------------------------------------------------------------------------------------------
gDBC	:=
module
	export	string		DirectorySource			:=	'drupal/done';
	export	string		DirectoryTarget			:=	'dbc';
	export	string		LandingZoneFileMask	:=	'XX_DBC_*_*.dat';
	export	unsigned2	RecordLength				:=	sizeof(NAC.Layouts.DBC);
	export	string		SuperName						:=	gThorFilenameBase + 'dbc';
	export						dSourceFileList			:=	global(nothor(lib_FileServices.fileservices.RemoteDirectory(gLandingZoneServer, fFullRemotePathFromTokens(gLandingZonePathBase, DirectorySource), LandingZoneFileMask)), few) : independent;
	export	string		EarliestFile				:=	fEarliestFileName(dSourceFileList);
	export						fClearSuperFile			:=	lib_FileServices.fileservices.ClearSuperFile('~' + SuperName);
	export						fMoveToSpraying			:=	fMoveFileToSpraying(DirectorySource, DirectoryTarget, EarliestFile);
	export						fSprayFile					:=	fSprayFile(DirectoryTarget, EarliestFile, RecordLength);
	export						fMoveToSprayed			:=	fMoveFileToSprayed(DirectoryTarget, EarliestFile);
	export						fMoveToDone					:=	fMoveFileToDone(DirectoryTarget, EarliestFile);
	export						fAddToSuper					:=	fAddToSuper(SuperName, gThorFilenameBase + EarliestFile);
end;

if(gDBC.EarliestFile <> '',
	 sequential(
								gDBC.fMoveToSpraying,
								gDBC.fSprayFile,
								gDBC.fMoveToSprayed,
								gDBC.fAddToSuper,
								gDBC.fMoveToDone
							),
	 output('No DBC Files')
	) : when(cron('0-59/15 * * * *')), failure(lib_FileServices.FileServices.SendEmail(ProcessRecipient, 'NAC_MSH_DBC_Sprayer Failed', 'NAC_MSH_DBC_Sprayer Failed'));
/////////////////////////////////////////
