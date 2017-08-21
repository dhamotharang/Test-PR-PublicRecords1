import Lib_FileServices, Lib_WorkunitServices, Lib_ThorLib, _Control, Lib_StringLib;

export	ProcDesprayXMLToServer(string pLandingZone = strata.settings.SQL_LandingZone)
 :=
	function
		string	lJobName								:=	'STRATA XML/CSV Despray';
		#workunit('name',lJobName);

		string	lPendingExtension				:=	'.pending';
		string	lDesprayingExtension		:=	'.despraying';

		fRenameToDespraying(string pFilename)
		 :=
			function
			string	lFilenameNoTempExtension	:=	regexreplace('\\' + lPendingExtension + '$',pFileName,'');
			string	lFilenamePendingOnThor		:=	'~' + pFilename;
			string	lFilenameDesprayingOnThor	:=	'~' + lFilenameNoTempExtension + lDesprayingExtension;
			
			return	Lib_Fileservices.FileServices.RenameLogicalFile(lFilenamePendingOnThor,lFilenameDesprayingOnThor);
			end
		 ;

		fDesprayAndFinish(string pFilename)
		 :=
			function
			string	lFilenameNoTempExtension	:=	regexreplace('\\' + lDesprayingExtension + '$',pFileName,'');
			string	lFilenameNoClusterAndPrefix	:=	regexreplace('^thor.*\\:\\:base\\:\\:stats\\:\\:',lFilenameNoTempExtension,'');
			string	lWindowsBaseFilename		:=	strata.settings.landingZonePath + regexreplace('\\:\\:',lFilenameNoClusterAndPrefix,'-');
			string	lFilenameDesprayingOnThor	:=	'~' + lFilenameNoTempExtension + lDesprayingExtension;
			string	lFilenameFinishedOnThor		:=	'~' + lFilenameNoTempExtension;
			
			zDespray			:=	Lib_FileServices.FileServices.Despray(lFilenameDesprayingOnThor,pLandingZone,lWindowsBaseFilename,,,,true);
			zRenameToFinished	:=	Lib_FileServices.FileServices.RenameLogicalFile(lFilenameDesprayingOnThor,lFilenameFinishedOnThor);

			return	sequential(zDespray,zRenameToFinished);
			end
		 ;

		dPendingList	:=	Lib_FileServices.FileServices.LogicalFileList('*base::stats::*.xml.pending')
						+	Lib_FileServices.FileServices.LogicalFileList('*base::stats::*.csv.pending')
						;

		dDesprayingList	:=	Lib_FileServices.FileServices.LogicalFileList('*base::stats::*.xml.despraying')
						+	Lib_FileServices.FileServices.LogicalFileList('*base::stats::*.csv.despraying')
						;

		dActiveStrataWorkunits	:=	lib_WorkunitServices.WorkunitServices.WorkunitList('', '', '', '', lJobName, 'running');

		zRenameToDespraying	:=	nothor(apply(dPendingList,fRenameToDespraying(name)));

		zDesprayAndFinish	:=	nothor(apply(dDesprayingList,fDesprayAndFinish(name)));

		return	if(lib_Thorlib.ThorLib.Nodes() = 1,
							 if(count(dActiveStrataWorkunits(lib_StringLib.StringLib.StringToUppercase(wuid) <> lib_StringLib.StringLib.StringToUppercase(workunit))) = 0,
									sequential(zRenameToDespraying,zDesprayAndFinish),
									sequential(Lib_FileServices.FileServices.SendEmail('strata@seisint.com',
																																			'ProcDesprayXMLToServer job failed: ' + workunit,
																																			'ProcDesprayXMLToServer job failed: ' + workunit
																																		 ),
															fail('Despray job is already active.')
														 )
								 ),
							 fail('Should be run on hthor')
							);
	end
 ;