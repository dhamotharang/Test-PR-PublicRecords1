import	NAC_V2, Std, Ut;

#workunit('name', 'NAC2 ESP Log Sprayer');
#workunit('protect', true);
// ------------------------------------------------------------------------------------------------
string		gLandingZoneServer		:=	'uspr-edata11.risk.regn.net';
string		gLandingZonePathBase	:=	'/data/hds_180/nac2/esp';
string		gLogOnlineBaseName		:=	'log_nac2_transaction_log_online_';
string		gLogBaseName					:=	'log_nac2_transaction_log_';
string		gThorFilenameBase			:=	'nac::nac2::for_msh2::';
string		gLogOnlineSuperName		:=	gThorFilenameBase	+ 'log_nac2_transaction_log_online';
string		gLogSuperName					:=	gThorFilenameBase	+ 'log_nac2_transaction_log';
string		gLandingZoneInclude		:=	'^([0-9]{8})';
string		gTargetThor						:=	'thor400_44';
string		gSubDirectorySpraying	:=	'spraying';
string		gSubDirectoryDone			:=	'done';

// ------------------------------------------------------------------------------------------------
dataset(Std.File.FsFilenameRecord)	dLogOnlineList	:=	Std.File.RemoteDirectory(gLandingZoneServer, gLandingZonePathBase, gLogOnlineBaseName	+ '*.txt', true)(regexfind(gLandingZoneInclude, Name));
dataset(Std.File.FsFilenameRecord)	dLogList				:=	Std.File.RemoteDirectory(gLandingZoneServer, gLandingZonePathBase, gLogBaseName 			+ '*.txt', true)(regexfind(gLandingZoneInclude, Name));
					dSortedLogOnlineDirectory									:=	sort(dLogOnlineList,	Modified);
					dSortedLogDirectory												:=	sort(dLogList,				Modified);
string8		fEarliestLogOnlineDirectory								:=	dSortedLogOnlineDirectory	[1].Name[1..8];
string8		fEarliestLogDirectory											:=	dSortedLogDirectory				[1].Name[1..8];
boolean		fIsAPairReady															:=	fEarliestLogOnlineDirectory <> '' and fEarliestLogOnlineDirectory = fEarliestLogDirectory;

// ------------------------------------------------------------------------------------------------
					fMoveDirToSpraying(string8 pDirectoryDate)	:=	Std.File.MoveExternalFile(gLandingZoneServer, gLandingZonePathBase + '/' + pDirectoryDate, gLandingZonePathBase + '/' + gSubDirectorySpraying + '/' + pDirectoryDate);
					fMoveDirToDone(string8 pDirectoryDate)			:=	Std.File.MoveExternalFile(gLandingZoneServer, gLandingZonePathBase + '/' + gSubDirectorySpraying + '/' + pDirectoryDate, gLandingZonePathBase + '/' + gSubDirectoryDone + '/' + pDirectoryDate);

					fSprayFiles(string8 pDirectoryDate)	:=
					function
						zSprayLog				:=	Std.File.SprayVariable(	sourceIP								:=	gLandingZoneServer,
																												sourcePath							:=	gLandingZonePathBase + '/' + gSubDirectorySpraying + '/' + pDirectoryDate + '/' + gLogBaseName + pDirectoryDate + '.txt',
																												destinationGroup				:=	gTargetThor,
																												destinationLogicalName	:=	'~' + gThorFilenameBase + gLogBaseName + pDirectoryDate + '.txt',
																												sourceCSVSeparate				:=	'|\t|',
																												sourceCSVTerminate			:=	'|\n',
																												sourceCSVQuote					:=	'[]',
																												compress								:=	true
																											);
						zSprayLogOnline	:=	Std.File.SprayVariable(	sourceIP								:=	gLandingZoneServer,
																												sourcePath							:=	gLandingZonePathBase + '/' + gSubDirectorySpraying + '/' + pDirectoryDate + '/' + gLogOnlineBaseName + pDirectoryDate + '.txt',
																												destinationGroup				:=	gTargetThor,
																												destinationLogicalName	:=	'~' + gThorFilenameBase + gLogOnlineBaseName + pDirectoryDate + '.txt',
																												sourceCSVSeparate				:=	'|\t|',
																												sourceCSVTerminate			:=	'|\n',
																												sourceCSVQuote					:=	'[]',
																												sourceMaxRecordSize			:=	500000,
																												compress								:=	true
																											);
						return	ordered(zSprayLog, zSprayLogOnline);
					end;
					
					fAddToSuper(string8 pDate)	:=
					function
						zAddLogToSuper				:=	Std.File.AddSuperFile(SuperName	:=	'~' + gLogSuperName,
																														SubName		:=	'~' + gThorFilenameBase + gLogBaseName 				+ pDate + '.txt'
																													 );
						zAddLogOnlineToSuper	:=	Std.File.AddSuperFile(SuperName	:=	'~' + gLogOnlineSuperName,
																														SubName		:=	'~' + gThorFilenameBase + gLogOnlineBaseName	+ pDate + '.txt'
																													 );
						return	ordered(Std.File.StartSuperFileTransaction(), zAddLogToSuper, zAddLogOnlineToSuper, Std.File.FinishSuperFileTransaction());
					end;

zGo	:=	if(fIsAPairReady,
					 ordered(
												fMoveDirToSpraying(fEarliestLogOnlineDirectory),
												fSprayFiles(fEarliestLogOnlineDirectory),
												fAddToSuper(fEarliestLogOnlineDirectory),
												fMoveDirToDone(fEarliestLogOnlineDirectory)
									),
					 output('No ESP Log Files')
					);
					
zGo	: when(cron('25,55 * * * *')), failure(STD.System.Email.SendEmail('tony.kirk@lexisnexis.com', 'NAC2 MSH2 ESP Log Sprayer Failed', 'NAC2 MSH2 ESP Log Sprayer Failed'));
zGo	:	when(event('NAC2Event: ESP Log Sprayer Go Now', '*')), failure(STD.System.Email.SendEmail('tony.kirk@lexisnexisrisk.com', 'NAC2 MSH2 ESP Log Sprayer Failed', 'NAC2 MSH2 ESP Log Sprayer Failed'));

/////////////////////////////////////////
