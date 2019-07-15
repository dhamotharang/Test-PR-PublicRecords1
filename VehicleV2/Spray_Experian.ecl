import	_control,lib_fileservices;

export Spray_Experian(	string	pFileDate,
												string	pProcessDate,
												string	pGroupName	=	'thor400_36',
												boolean	pOverwrite	=	false
											)	:=
function

	string		vSourceIP		:=	_control.IPAddress.bctlpedata11;
	string		vDirectory	:=	'/data/hds_2/vehreg/in/experian/'	+	pFileDate	+	'/';
	string		vfileMask		:=	'*MVR';
	unsigned	vRecLength	:=	1151;

	dRemoteFileList	:=	lib_fileservices.FileServices.RemoteDirectory(vSourceIP,vDirectory,vfileMask);

	vRawLogicalFileName		:=	'~thor_data400::in::vehiclev2::experian::raw::'	+	pFileDate	+	'::@state@';
	vRawSuperFileName			:=	'~thor_data400::in::vehiclev2::experian::raw';
	vPrepLogicalFileName	:=	'~thor_data400::in::vehiclev2::experian_'	+	pFileDate;
	vPrepSuperFileName		:=	'~thor_data400::in::vehiclev2::experian';
	vPrepSuperFileDelete	:=	'~thor_data400::in::vehiclev2::experian_delete';
	vPrepSuperFileFather	:=	'~thor_data400::in::vehiclev2::experian_father';
	vPrepSuperFileBldg		:=	'~thor_data400::in::vehiclev2::experian_building';

	rSprayInfo_layout	:=
	record, maxlength(10000)
		string		sourceIP;
		string		sourceDir;
		string		SourceState;
		string		FileDate;
		string		ProcessDate;
		unsigned	RecordLength;
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
		self.SourceState					:=	stringlib.stringtolowercase(pInput.name)[1..2];
		self.FileDate							:=	pFileDate;
		self.ProcessDate					:=	pProcessDate;
		self.RecordLength					:=	vRecLength;
		self.GroupName						:=	pGroupName;
		self.Overwrite						:=	pOverwrite;
		self.RemoteFileName				:=	pInput.name;
		self.RawLogicalFileName		:=	regexreplace(	'@state@',
																								vRawLogicalFileName,
																								self.SourceState
																							);
		self.RawSuperFileName			:=	vRawSuperFileName;
		self.PrepLogicalFileName	:=	vPrepLogicalFileName;
		self.PrepSuperFileName		:=	vPrepSuperFileName;
	end;

	dRemoteFiles_SprayInfo	:=	project(dRemoteFileList,tSprayInfo(left));

	// output(dRemoteFiles_SprayInfo);

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

	// Add to superfile
	addSuperFile(string	pSuperFileName,string	pLogicalFileName)	:=
		sequential(	fileservices.startsuperfiletransaction(),
									fileservices.addsuperfile(pSuperFileName,pLogicalFileName),
									fileservices.finishsuperfiletransaction()
								);
	
	// Remove from superfile
	removeSubFile(string	pSuperFileName,string	pLogicalFileName)	:=
		if(	fileservices.findsuperfilesubname(pSuperFileName,pLogicalFileName)	!=	0,
				sequential(	fileservices.startsuperfiletransaction(),
											fileservices.removesuperfile(pSuperFileName,pLogicalFileName),
											fileservices.finishsuperfiletransaction()
										),
				output(pLogicalFileName	+	' file does not exist, no action taken')
			);

	sprayFiles	:=	nothor(apply(	dRemoteFiles_SprayInfo,
																	sequential(	if(	pOverwrite	=	true,
																										sequential(	removeSubFile(RawSuperFileName,RawLogicalFileName),
																																	removeSubFile(PrepSuperFileName,PrepLogicalFileName)
																																)
																									),
																								sprayFixed(	SourceIP,
																														SourceDir,
																														RecordLength,
																														GroupName,
																														RawLogicalFileName,
																														pOverwrite
																													),
																								addSuperFile(RawSuperFileName,RawLogicalFileName)
																							)
																)
												);

	rExperianRaw_layout	:=
	record
		VehicleV2.Layout_Experian.Layout_Experian_Raw;
		string	LogicalFileName	{virtual(LogicalFileName)};
	end;
	
	dExperianRaw	:=	dataset(vRawSuperFileName,rExperianRaw_layout,thor);
	
	// Create Experian VIN's only file
	removeExpVinCandidates	:=	if(	fileservices.findsuperfilesubname('~thor_data400::in::vehiclev2::vina_candidates','~thor_data400::in::vehiclev2::experian::vina_candidates')	!=	0,
																	sequential(	fileservices.startsuperfiletransaction(),
																								fileservices.removesuperfile('~thor_data400::in::vehiclev2::vina_candidates','~thor_data400::in::vehiclev2::experian::vina_candidates'),
																								fileservices.finishsuperfiletransaction()
																							)
																);

	rVinCandidates_layout	:=
	record
		string22	VIN;
		string1		lf;
	end;

	rVinCandidates_layout	tVinCandidates(dExperianRaw	pInput)	:=
	transform
		self.lf	:=	pInput.crlf;
		self		:=	pInput;
	end;
	
	dExpVinCandidates		:=	project(dExperianRaw,tVinCandidates(left));
	
	outExpVinCandidates	:=	output(dExpVinCandidates,,'~thor_data400::in::vehiclev2::experian::vina_candidates',overwrite,__compressed__);

	addExpVinCandidates	:=	sequential(	fileservices.startsuperfiletransaction(),
																				fileservices.addsuperfile('~thor_data400::in::vehiclev2::vina_candidates','~thor_data400::in::vehiclev2::experian::vina_candidates'),
																				fileservices.finishsuperfiletransaction()
																			);

	// Add process date and state origin - prep the raw sprayed file and add it to the superfile
	VehicleV2.Layout_Experian.Layout_Experian_Prepped	tPrepExperianRaw(dExperianRaw	pInput)	:=
	transform
		string2	vState						:=	regexfind('[A-Za-z]{2}$',pInput.LogicalFileName,0);
		self.Append_Process_Date	:=	pProcessDate;
		self.Append_State_Origin	:=	stringlib.stringtouppercase(vState);
		self											:=	pInput;
	end;
	
	dPrepExperianRaw					:=	project(dExperianRaw,tPrepExperianRaw(left));
	
	outExperianPrepped				:=	output(dPrepExperianRaw,,vPrepLogicalFileName,overwrite,__compressed__);
	
	addExperianPreppedToSuper	:=	sequential(	fileservices.startsuperfiletransaction(),
																							fileservices.clearsuperfile(vPrepSuperFileDelete),
																							fileservices.addsuperfile(vPrepSuperFileDelete,vPrepSuperFileFather,,true),
																							fileservices.clearsuperfile(vPrepSuperFileFather),
																							fileservices.addsuperfile(vPrepSuperFileFather,vPrepSuperFileName,,true),
																							fileservices.clearsuperfile(vPrepSuperFileName),
																							fileservices.addsuperfile(vPrepSuperFileName,vPrepLogicalFileName),
																							fileservices.finishsuperfiletransaction(),
																							fileservices.clearsuperfile(vPrepSuperFileDelete,true),
																							fileservices.clearsuperfile(vRawSuperFileName,true)
																						);

	addExperianToBldg	:=	if(	fileservices.getsuperfilesubcount(vPrepSuperFileBldg)	>	0,
														output('Nothing added to Experian Building superfile'),
														fileservices.addsuperfile(vPrepSuperFileBldg,vPrepLogicalFileName)
													 );
	
	return	sequential(	sprayFiles,
												removeExpVinCandidates,
												outExpVinCandidates,
												addExpVinCandidates,
												outExperianPrepped,
												addExperianPreppedToSuper,
												addExperianToBldg
											);
end;