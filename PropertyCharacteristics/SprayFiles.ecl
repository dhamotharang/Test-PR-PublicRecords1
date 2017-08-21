import	_control;

export SprayFiles	(	string		pFileDate,
										string		pProcessDate,
										string		pCSVQuote		=	'',
										unsigned	pMaxRecLen	=	12294,
										string		pGroupName	=	_control.TargetGroup.Thor400_92,/*'thor400_88_dev',*/
										boolean		pOverwrite	=	false
									)	:=
function

	string	vSourceIP				:=	_control.IPAddress.edata10;
	string	vDirectory			:=	'/ucc_new_build2/property_blue_book/data/'	+	pFileDate	+	'/';
	string	vFileMask				:=	'*Extract.txt';
	string	vCSVTerminator	:=	'\\r\\n';
	
	dRemoteFileList	:=	FileServices.RemoteDirectory(vSourceIP,vDirectory,vfileMask);

	vRawLogicalFileName		:=	'~thor_data400::in::propertybluebook::@source@::raw::'		+	pFileDate;
	vRawSuperFileName			:=	'~thor_data400::in::propertybluebook::@source@::raw';
	vPrepLogicalFileName	:=	'~thor_data400::in::propertybluebook::@source@::prepped'	+	pFileDate;
	vPrepSuperFileName		:=	'~thor_data400::in::propertybluebook::@source@';

	rSprayInfo_layout	:=
	record, maxlength(4098)
		string		SourceIP;
		string		SourceDir;
		string		VendorSource;
		string		FileDate;
		string		ProcessDate;
		string		CSVSeparator;
		string		CSVTerminator;
		string		CSVQuote;
		unsigned	MaxRecordLength;
		string		GroupName;
		boolean		Overwrite;
		string		RemoteFileName;
		string		RawLogicalFileName;
		string		RawSuperFileName;
		string		PrepLogicalFileName;
		string		PrepSuperFileName;
	end;

	rSprayInfo_layout	tSprayInfo(dRemoteFileList pInput)	:=
	transform
		self.SourceIP							:=	vSourceIP;
		self.SourceDir						:=	vDirectory + pInput.name;
		self.VendorSource					:=	map(	regexfind('MLS1',pInput.name,nocase)							=>	'MLS1',
																				regexfind('MLS2',pInput.name,nocase)							=>	'MLS2',
																				regexfind('VISIENT|MLS|MLS3',pInput.name,nocase)	=>	'MLS3',
																				regexfind('MLS4',pInput.name,nocase)							=>	'MLS4',
																				regexfind('INSURANCE|^(IB)',pInput.name,nocase)		=>	'INS1',
																				/*
																				regexfind('INSURANCE2',pInput.name,nocase)				=>	'INS2',
																				*/
																				regexfind('APPRAISER|^(AB)',pInput.name,nocase)		=>	'APPR',
																				''
																			);
		self.FileDate							:=	pFileDate;
		self.ProcessDate					:=	pProcessDate;
		self.CSVSeparator					:=	map(	regexfind('MLS1',pInput.name,nocase)				=>	'\\t',
																				regexfind('MLS2',pInput.name,nocase)				=>	'\\t',
																				regexfind('MLS3',pInput.name,nocase)				=>	'\\t',
																				regexfind('MLS4',pInput.name,nocase)				=>	'\\t',
																				regexfind('INSURANCE',pInput.name,nocase)		=>	'\\t',
																				/*
																				regexfind('INSURANCE2',pInput.name,nocase)	=>	'\\t',
																				*/
																				regexfind('APPRAISER',pInput.name,nocase)		=>	'\\t',
																				''
																			);
		self.CSVTerminator				:=	vCSVTerminator;
		self.CSVQuote							:=	pCSVQuote;
		self.MaxRecordLength			:=	pMaxRecLen;
		self.GroupName						:=	pGroupName;
		self.Overwrite						:=	pOverwrite;
		self.RemoteFileName				:=	pInput.name;
		self.RawLogicalFileName		:=	regexreplace(	'@source@',
																								vRawLogicalFileName,
																								self.VendorSource
																							);
		self.RawSuperFileName			:=	regexreplace(	'@source@',
																								vRawSuperFileName,
																								self.VendorSource
																							);
		self.PrepLogicalFileName	:=	regexreplace(	'@source@',
																								vPrepLogicalFileName,
																								self.VendorSource
																							);
		self.PrepSuperFileName		:=	regexreplace(	'@source@',
																								vPrepSuperFileName,
																								self.VendorSource
																							);
	end;

	dRemoteFiles_SprayInfo	:=	project(dRemoteFileList,tSprayInfo(left));

	sprayVariable(	string 		pSrcIP,
									string 		pSrcDir,
									string	 	pCSVSeparator,
									string		pCSVTerminator,
									string		pCSVQuote,
									unsigned	pMaxRecordLength,
									string 		pGrpName,
									string 		pLogicalFileName,
									boolean 	pOverwrite
								)
		:=	FileServices.SprayVariable(	pSrcIP,
																		pSrcDir,
																		pMaxRecordLength,
																		pCSVSeparator,
																		pCSVTerminator,
																		pCSVQuote,
																		pGrpName,
																		pLogicalFileName,
																		,
																		,
																		,
																		pOverwrite,
																		true,
																		true
																	);

	// Add to superfile
	addSuperFile(string	pSuperFileName,string	pLogicalFileName)	:=
		sequential(	FileServices.StartSuperfileTransaction(),
								FileServices.AddSuperfile(pSuperFileName	+	'_delete',pSuperFileName	+	'_father',,true),
								FileServices.ClearSuperfile(pSuperFileName	+	'_father'),
								FileServices.AddSuperfile(pSuperFileName	+	'_father',pSuperFileName,,true),
								FileServices.ClearSuperfile(pSuperFileName),
								FileServices.AddSuperfile(pSuperFileName,pLogicalFileName),
								FileServices.FinishSuperfileTransaction(),
								FileServices.ClearSuperFile(pSuperFileName	+	'_delete',true)
							);
	
	// Remove from superfile
	removeSubFile(string	pSuperFileName,string	pLogicalFileName)	:=
		if(	FileServices.FindSuperfileSubname(pSuperFileName,pLogicalFileName)	!=	0,
				sequential(	FileServices.StartSuperfileTransaction(),
										FileServices.RemoveSuperfile(pSuperFileName,pLogicalFileName),
										FileServices.FinishSuperfileTransaction()
									),
				output(pLogicalFileName	+	' file does not exist, no action taken')
			);

	sprayFiles	:=	nothor(apply(	dRemoteFiles_SprayInfo,
																sequential(	if(	pOverwrite	=	true,
																								sequential(	removeSubFile(RawSuperFileName,RawLogicalFileName),
																														removeSubFile(PrepSuperFileName,PrepLogicalFileName)
																													)
																							),
																						sprayVariable(	SourceIP,
																														SourceDir,
																														CSVSeparator,
																														CSVTerminator,
																														CSVQuote,
																														pMaxRecLen,
																														GroupName,
																														RawLogicalFileName,
																														pOverwrite
																													),
																						addSuperFile(RawSuperFileName,RawLogicalFileName)
																					)
																)
												);

	// Add process date and vendor source code - prep the raw sprayed file and add it to the superfile
	doPrepMLS1	:=	if(	fileservices.getsuperfilesubcount('~thor_data400::in::propertybluebook::mls1::raw')	>	0,
											PropertyCharacteristics.PrepRaw(pFileDate,pProcessDate).MLS1_Prepped,
											output('No MLS1 file update available, hence no action taken')
										);
	doPrepMLS2	:=	if(	fileservices.getsuperfilesubcount('~thor_data400::in::propertybluebook::mls2::raw')	>	0,
											PropertyCharacteristics.PrepRaw(pFileDate,pProcessDate).MLS2_Prepped,
											output('No MLS2 file update available, hence no action taken')
										);
	doPrepMLS3	:=	if(	fileservices.getsuperfilesubcount('~thor_data400::in::propertybluebook::mls3::raw')	>	0,
											PropertyCharacteristics.PrepRaw(pFileDate,pProcessDate).MLS3_Prepped,
											output('No MLS3 file update available, hence no action taken')
										);
	doPrepMLS4	:=	if(	fileservices.getsuperfilesubcount('~thor_data400::in::propertybluebook::mls4::raw')	>	0,
											PropertyCharacteristics.PrepRaw(pFileDate,pProcessDate).MLS4_Prepped,
											output('No MLS4 file update available, hence no action taken')
										);
	doPrepIns1	:=	if(	fileservices.getsuperfilesubcount('~thor_data400::in::propertybluebook::ins1::raw')	>	0,
											PropertyCharacteristics.PrepRaw(pFileDate,pProcessDate).Ins1_Prepped,
											output('No Insurance1 file update available, hence no action taken')
										);
	/*
	doPrepIns2	:=	if(	fileservices.getsuperfilesubcount('~thor_data400::in::propertybluebook::ins2::raw')	>	0,
											PropertyCharacteristics.PrepRaw(pFileDate,pProcessDate).Ins2_Prepped,
											output('No Insurance2 file update available, hence no action taken')
										);
	*/
	doPrepAppr	:=	if(	fileservices.getsuperfilesubcount('~thor_data400::in::propertybluebook::appr::raw')	>	0,
											PropertyCharacteristics.PrepRaw(pFileDate,pProcessDate).Appr_Prepped,
											output('No Appraiser file update available, hence no action taken')
										);
	
	
	output(dRemoteFiles_SprayInfo);
	
	return	sequential(sprayFiles,parallel(/*doPrepMLS1,doPrepMLS2,doPrepMLS3,doPrepMLS4,*/doPrepIns1,doPrepAppr));

end;