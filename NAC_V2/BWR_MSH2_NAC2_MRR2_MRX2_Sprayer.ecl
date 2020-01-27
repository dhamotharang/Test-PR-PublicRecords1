import	NAC_V2, Std, Ut;

#workunit('name', 'NAC2 MRR2/MRX2 Sprayer');
#workunit('protect', true);
// ------------------------------------------------------------------------------------------------
#warning('this needs polish because PPA has same directory for the pair, and NAC2 has different directory for each file type');
string		gLandingZoneServer		:=	'uspr-edata11.risk.regn.net';
string		gLandingZonePathBase	:=	'/data/hds_180/nac2';
string		gMRR2WildcardName			:=	'mrr2_????_????????_??????.dat';
string		gMRX2WildcardName			:=	'mrx2_????_????????_??????.dat';
string		gLogBaseName					:=	'log_nac2_transaction_log_';
string		gThorFilenameBase			:=	'nac::nac2::for_msh2::';
string		gMRR2SuperName				:=	gThorFilenameBase	+ 'mrr2'; 
string		gMRX2SuperName				:=	gThorFilenameBase	+ 'mrx2';
string		gLandingZoneInclude		:=	'^([a-z]{2}[0-9]{2})/mrr?/mr.2_\\1_';		// Back-reference \\1 to ensure that filename contains same GroupID token as directory containing it.
string		gTargetThor						:=	'thor400_44';
string		gWorkingDirBase				:=	'/data/hds_180/nac2';
string		gMRR2DirSpraying			:=	gWorkingDirBase + '/mrr2/spraying';
string		gMRR2DirectoryDone		:=	gWorkingDirBase + '/mrr2/done';
string		gMRX2DirSpraying			:=	gWorkingDirBase + '/mrx2/spraying';
string		gMRX2DirectoryDone		:=	gWorkingDirBase + '/mrx2/done';

// ------------------------------------------------------------------------------------------------
					dMRR2List							:=	Std.File.RemoteDirectory(gLandingZoneServer, gLandingZonePathBase, gMRR2WildcardName, true)(regexfind(gLandingZoneInclude, Name));
					dMRX2List							:=	Std.File.RemoteDirectory(gLandingZoneServer, gLandingZonePathBase, gMRX2WildcardName, true)(regexfind(gLandingZoneInclude, Name));
					dSortedMRR2List				:=	sort(dMRR2List,	Modified);
					dSortedMRX2List				:=	sort(dMRX2List,	Modified);
boolean		fIsAnMRR2Ready				:=	count(dSortedMRR2List) <> 0;
boolean		fIsAnMRX2Ready				:=	count(dSortedMRX2List) <> 0;

rFileListPlus	:=
record
	recordof(dSortedMRR2List);
	string4	GroupID;
	string	FullSourcePath;
	string	FullTargetSprayingPath;
	string	BaseFilenameForSpray;
end;
rFileListPlus	tFileListPlus(dSortedMRR2List pInput)	:=
transform
	string	lBaseFilename				:=	regexfind('([^/]+)$', pInput.Name, 1);
	string	lWhichFileType			:=	case(lBaseFileName[1..4],
																 'mrr2'	=>	gMRR2DirSpraying,
																 'mrx2'	=>	gMRX2DirSpraying,
																 fail(string, 'Which file type?')
																);
	self.GroupID								:=	pInput.Name[1..4];
	self.FullSourcePath					:=	gLandingZonePathBase + '/' + pInput.Name;
	self.FullTargetSprayingPath	:=	lWhichFileType + '/' + lBaseFilename;
	self.BaseFilenameForSpray		:=	lBaseFilename;
	self												:=	pInput;
end;	
dMRR2ListPlusCandidates	:=	project(dSortedMRR2List, tFileListPlus(left));
dMRX2ListPlusCandidates	:=	project(dSortedMRX2List, tFileListPlus(left));

dMRR2ListPlus	:=	join(dMRR2ListPlusCandidates, $.dNAC2Config(ProductCode = 'p' and IsProd = '1'),
											 left.GroupID = right.GroupID,
											 transform(left)
											);
dMRX2ListPlus	:=	join(dMRX2ListPlusCandidates, $.dNAC2Config(ProductCode = 'p' and IsProd = '1'),
											 left.GroupID = right.GroupID,
											 transform(left)
											);

// ------------------------------------------------------------------------------------------------
					fMoveFileToSpraying(string pPPAPath, string pSprayingPath)	:=	Std.File.MoveExternalFile(gLandingZoneServer, pPPAPath, pSprayingPath);
					fMoveFileToDone(string pSprayingPath)												:=	Std.File.MoveExternalFile(gLandingZoneServer, pSprayingPath, Std.Str.FindReplace(pSprayingPath, '/spraying/', '/done/'));

					fSprayFile(string pSprayingPath, string pBaseFilenameForSpray)	:=
					function
						return	Std.File.SprayVariable(	sourceIP								:=	gLandingZoneServer,
																						sourcePath							:=	pSprayingPath,
																						destinationGroup				:=	gTargetThor,
																						destinationLogicalName	:=	'~' + gThorFilenameBase + pBaseFilenameForSpray,
																						sourceCSVSeparate				:=	'\t\t\t',
																						sourceCSVTerminate			:=	'\n',
																						sourceCSVQuote					:=	'[]',
																						compress								:=	true
																					);
					end;
				
					fAddToSuper(string pBaseFilenameForSpray)	:=
					function
						lWhichSuper		:=	case(pBaseFilenameForSpray[1..4],
																	 'mrr2'	=>	gMRR2SuperName,
																	 'mrx2'	=>	gMRX2SuperName,
																	 fail(string, 'Which file type?')
																	);
						return	Std.File.AddSuperFile(SuperName	:=	'~' + lWhichSuper,
																					SubName		:=	'~' + gThorFilenameBase + pBaseFilenameForSpray
																				 );
					end;

// ------------------------------------------------------------------------------------------------
fProcessFile(string pPPAPath, string pSprayingPath, string pBaseFilenameForSpray)	:=
	 ordered(
								fMoveFileToSpraying(pPPAPath, pSprayingPath),
								fSprayFile(pSprayingPath, pBaseFilenameForSpray),
								fAddToSuper(pBaseFilenameForSpray),
								fMoveFileToDone(pSprayingPath)
					);

zGo	:=	ordered(
								if(fIsAnMRR2Ready,
									 fProcessFile(dMRR2ListPlus[1].FullSourcePath, dMRR2ListPlus[1].FullTargetSprayingPath, dMRR2ListPlus[1].BaseFilenameForSpray),
									 output('No MRR2 Files')
									),
								if(fIsAnMRX2Ready,
									 fProcessFile(dMRX2ListPlus[1].FullSourcePath, dMRX2ListPlus[1].FullTargetSprayingPath, dMRX2ListPlus[1].BaseFilenameForSpray),
									 output('No MRX2 Files')
									)
							 );

/////////////////////////////////////////
zGo	: when(cron('7-59/15 * * * *')), failure(Std.System.Email.SendEmail('tony.kirk@lexisnexis.com', 'NAC2 MSH2 MRR2 MRX2 Sprayer Failed', 'NAC2 MSH2 MRR2 MRX2 Sprayer Failed'));
zGo	:	when(event('NAC2Event: NAC2 MRR2 MRX2 Sprayer Go Now', '*')), failure(STD.System.Email.SendEmail('tony.kirk@lexisnexisrisk.com', 'NAC2 MSH2 MRR2 MRX2 Sprayer Failed', 'NAC2 MSH2 MRR2 MRX2 Sprayer Failed'));
