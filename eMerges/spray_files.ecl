import _control, lib_fileservices, ut, versioncontrol;

export spray_files(	string		pSourceIP		=	_control.IPAddress.bctlpedata11,
										string		pDirectory	=	'/data/prod_data_build_13/production_data/emerges/hvc/data/20161104/',
										unsigned	pRecLength	=	1888,
										string		pVersion		=	ut.GetDate,
										string		pGroupName	=	_control.TargetGroup.Thor400_44,
										boolean		pOverwrite	=	false
									)
	:=
	function
		fileMask				:=	'emerges.' + '*' + '.d00';
		dRemoteFileList	:=	lib_fileservices.FileServices.RemoteDirectory(pSourceIP, pDirectory, fileMask);

		logicalFileName	:=	'~thor_data400::in::emerges::sprayed::@version@::@fileType@::@state@';
		superFileName		:=	'~thor_data400::in::emerges::sprayed::@fileType@';

		rSprayInfo_layout	:=
		record, maxlength(10000)
			string		sourceIP;
			string		sourceDir;
			string		SourceState;
			string		FileType;
			string		FileDate;
			unsigned	RecordLength;
			string		GroupName;
			boolean		fOverwrite;
			string		RemoteFileName;
			string		LogicalFileName;
			string		SuperFileName;
		end;

		rSprayInfo_layout	tSprayInfo(dRemoteFileList pInput)	:=
		transform
			self.SourceIP					:=	pSourceIP;
			self.SourceDir				:=	pDirectory + pInput.name;
			self.SourceState			:=	stringlib.stringtolowercase(regexfind('[.][A-Za-z]{2}[.]',pInput.name,0)[2..3]);
			self.FileDate					:=	if(	regexfind('[.][[:digit:]]{8}[.]', pInput.name),
																		regexfind('[.][[:digit:]]{8}[.]', pInput.name, 0)[2..9],
																		pVersion
																	);
			self.FileType					:=	stringlib.stringtolowercase(regexfind('hunt|ccw',pInput.name,0,nocase));
			self.RecordLength			:=	pRecLength;
			self.GroupName				:=	pGroupName;
			self.fOverwrite				:=	pOverwrite;
			self.RemoteFileName		:=	pInput.name;
			self.LogicalFileName	:=	regexreplace(	'@version@',
																							regexreplace(	'@fileType@',
																														regexreplace(	'@state@',
																																					logicalFileName,
																																					self.SourceState
																																				),
																														self.FileType
																													),
																							self.FileDate
																						);
			self.SuperFileName		:=	regexreplace('@fileType@',superFileName,self.FileType);
		end;

		dRemoteFiles_SprayInfo	:=	project(dRemoteFileList, tSprayInfo(left));

		sprayFixed(	string 		pSrcIP,
								string 		pSrcDir,
								unsigned 	pRecLen,
								string 		pGrpName,
								string 		pLogicalFileName,
								boolean 	pOverwrite
							)
			:=	lib_fileservices.fileservices.sprayfixed(	pSrcIP,
																										pSrcDir,
																										pRecLen,
																										pGrpName,
																										pLogicalFileName,
																										,
																										,
																										,
																										pOverwrite,
																										true,
																										true
																									);

		removeSubFile(string pSuperFile, string pLogicalFile)
			:=	if(fileservices.findsuperfilesubname(pSuperFile, pLogicalFile) != 0,
							sequential(	fileservices.startsuperfiletransaction(),
													fileservices.removesuperfile(pSuperFile, pLogicalFile),
													fileservices.finishsuperfiletransaction()
													)
						);

		addSuperFile(string pSuperFile, string pLogicalFile)
			:=	sequential(	fileservices.startsuperfiletransaction(),
											fileservices.addsuperfile(pSuperFile, pLogicalFile),
											fileservices.finishsuperfiletransaction()
										);

		sprayFiles	:=	nothor(apply(	dRemoteFiles_SprayInfo,
																	sequential(	if(	fileservices.findsuperfilesubname(SuperFileName,LogicalFileName) != 0,
																									removeSubFile(SuperFileName,LogicalFileName)
																								),
																							sprayFixed(	SourceIP,
																													SourceDir,
																													RecordLength,
																													GroupName,
																													LogicalFileName,
																													pOverwrite
																												),
																							addSuperFile(SuperFileName,LogicalFileName)
																						)
																	)
													);

		output(dRemoteFiles_SprayInfo);
		
		return	sprayFiles;
	end;