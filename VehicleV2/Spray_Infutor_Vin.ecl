IMPORT _control,lib_fileservices,Address;
//This file is copied from Spray_Experian. It reads the input directory and sprays all files in the directory to the target
//location. The input files are with txt extention and delimited by tab.
EXPORT Spray_Infutor_Vin(string	pProcessDate,
	                       string	pFileDate     ='',
												 string	pGroupName	  =	'thor400_36',
												 boolean	pOverwrite	=	true
											)	:=
FUNCTION

	STRING		vSourceIP		:=	_control.IPAddress.bctlpedata11;
	//STRING		vSourceIP		:=	_control.IPAddress.edata10;
	STRING		vDirectory	:=	'/data/hds_2/vehreg/in/infutor/vin/'	+	pFileDate	+	'/';
	//STRING		vDirectory	:=	'/data_build_5_2/INFUTOR/VIN/'	+	pFileDate	+	'/';
	STRING		vfileMask		:=	'NARV3*.txt';
	STRING		vDelim			:= 	'\\t';
	vMaxRecordSize				:=  8192;

	dRemoteFileList				:=	lib_fileservices.FileServices.RemoteDirectory(vSourceIP,vDirectory,vfileMask);


	vRawLogicalFileName		:=	'~thor_data400::in::vehiclev2::inf_nondppa::vin_raw::'	+	pFileDate	+	'::@state@';
	vRawSuperFileName			:=	'~thor_data400::in::vehiclev2::inf_nondppa::vin_raw';
	vPrepLogicalFileName	:=	'~thor_data400::in::vehiclev2::inf_nondppa::vin_'	+	pFileDate;
	vPrepSuperFileName		:=	'~thor_data400::in::vehiclev2::inf_nondppa::vin';
	vPrepSuperFileDelete	:=	'~thor_data400::in::vehiclev2::inf_nondppa::vin_delete';
	vPrepSuperFileFather	:=	'~thor_data400::in::vehiclev2::inf_nondppa::vin_father';
	vPrepSuperFileBldg		:=	'~thor_data400::in::vehiclev2::inf_nondppa::vin_building';

	rSprayInfo_layout	:=
	record, maxlength(10000)
		string		sourceIP;
		string		sourceDir;
		string		SourceState;
		string		FileDate;
		string		ProcessDate;
		//unsigned	RecordLength;
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
		self.SourceState					:=	REGEXFIND('^NARV3_([A-Z]{2}).txt$', TRIM(pInput.name),1);
		self.FileDate							:=	pFileDate;
		self.ProcessDate					:=	pProcessDate;
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

	oRemoteFiles_SprayInfo := output(dRemoteFiles_SprayInfo);

	sprayVariable(string 		pSrcIP,
								string 		pSrcDir,
								string 		pGrpName,
								string 		pLogicalFileName,
								boolean 	pOverwrite
								)
		:=	lib_fileservices.fileservices.SprayVariable(pSrcIP,
																										pSrcDir,
																										vMaxRecordSize,
																										vDelim,
																										'\r\n',
																										'',
																										pGrpName,
																										pLogicalFileName,
																										,
																										,
																										,
																										pOverwrite,
																										,
																										TRUE
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
										)
				//output(pLogicalFileName	+	' file does not exist, no action taken')
			);

  createSuperFiles:= 
			sequential(	fileservices.startsuperfiletransaction(),
									IF(NOT FileServices.SuperFileExists(vRawSuperFileName),
									   FileServices.CreateSuperFile(vRawSuperFileName),
										 FileServices.ClearSuperFile(vRawSuperFileName)),
									IF(NOT FileServices.SuperFileExists(vPrepSuperFileName),
									   FileServices.CreateSuperFile(vPrepSuperFileName),
										 FileServices.ClearSuperFile(vPrepSuperFileName)),
									IF(NOT FileServices.SuperFileExists(vPrepSuperFileDelete),
									   FileServices.CreateSuperFile(vPrepSuperFileDelete)),
									IF(NOT FileServices.SuperFileExists(vPrepSuperFileFather),
									   FileServices.CreateSuperFile(vPrepSuperFileFather)),
									IF(NOT FileServices.SuperFileExists(vPrepSuperFileBldg),
									   FileServices.CreateSuperFile(vPrepSuperFileBldg)),
									fileservices.finishsuperfiletransaction()
								);
	sprayFiles	:=	nothor(apply(	dRemoteFiles_SprayInfo,
																	sequential(	if(	pOverwrite	=	true,
																										sequential(	removeSubFile(RawSuperFileName,RawLogicalFileName),
																																	removeSubFile(PrepSuperFileName,PrepLogicalFileName)
																																)
																									),
																								sprayVariable(SourceIP,
																															SourceDir,
																															GroupName,
																															RawLogicalFileName,
																															pOverwrite
																													),
																								addSuperFile(RawSuperFileName,RawLogicalFileName)
																							)
																)
												);

	rInfutor_layout	:=
	record
		VehicleV2.Layout_Infutor_VIN.Raw_Main;
		string	LogicalFileName	{virtual(LogicalFileName)};
	end;
	
	dInfutorRaw	:=	dataset(vRawSuperFileName,rInfutor_layout,CSV(SEPARATOR('\t'),heading(0),quote('"'),TERMINATOR(['\r\n','\n\r'])));
	odInfutorRaw := output(dInfutorRaw);
	
	// Create Infutor_VIN VIN's only file
	removeInfutorVinCandidates	:=	if(	fileservices.findsuperfilesubname('~thor_data400::in::vehiclev2::vina_candidates','~thor_data400::in::vehiclev2::inf_nondppa_vin::vina_candidates')	!=	0,
																	sequential(	fileservices.startsuperfiletransaction(),
																								fileservices.removesuperfile('~thor_data400::in::vehiclev2::vina_candidates','~thor_data400::in::vehiclev2::inf_nondppa_vin::vina_candidates'),
																								fileservices.finishsuperfiletransaction()
																							)
																);

	rVinCandidates_layout	:=
	record
		string22	VIN;
		string1		lf;
	end;

	rVinCandidates_layout	tVinCandidates(dInfutorRaw pInput)	:=
	transform
		self.vin	:=	pInput.internal1;
		self.lf		:=	pInput.crlf;		
	end;
	
	dInfutorVinCandidates		:=	project(dInfutorRaw,tVinCandidates(left));
	
	outInfutorVinCandidates	:=	output(dInfutorVinCandidates,,'~thor_data400::in::vehiclev2::inf_nondppa_vin::vina_candidates',overwrite,__compressed__);

	addInfutorVinCandidates	:=	sequential(	fileservices.startsuperfiletransaction(),
																				fileservices.addsuperfile('~thor_data400::in::vehiclev2::vina_candidates','~thor_data400::in::vehiclev2::inf_nondppa_vin::vina_candidates'),
																				fileservices.finishsuperfiletransaction()
																			);

	// Add process date and state origin - prep the raw sprayed file and add it to the superfile
	VehicleV2.Layout_Infutor_VIN.Prepped	tPrepInfutorRaw(dInfutorRaw	pInput)	:= TRANSFORM
		string2	vState						:=	REGEXFIND('[A-Za-z]{2}$',pInput.LogicalFileName,0);
		SELF											:=	pInput;
		SELF.ProcessDate					:=	pProcessDate;
		SELF.source_code					:=	'1V';     //source code for INFUTOR VIN, defined in MDR.sourceTools
		//state_origin should be the state code of the state the vehicle is registered at. However it is not available in Infutor
		//data, and we do need this field for iteration key and other. Instead we use the state code of owner's address.
		SELF.state_origin					:=	stringlib.stringtouppercase(vState);
		SELF											:=	pInput;
		SELF											:=	[];		
		
	END;
	
	dPrepInfutorRaw					:=	project(dInfutorRaw,tPrepInfutorRaw(left));

	// Append name type indicators depending on the names
	Address.Mac_Is_Business_Parsed(	dPrepInfutorRaw,
																	dInfutorOwner1NameInd,
																	fname,
																	mi,
																	lname,
																	suffix,
																	,
																	Append_OwnerNameTypeInd
																);

	removeInfutorPrepped	:=	if(	fileservices.findsuperfilesubname(vPrepSuperFileBldg,vPrepLogicalFileName)	!=	0,
																	sequential(	fileservices.startsuperfiletransaction(),
																								fileservices.removesuperfile(vPrepSuperFileBldg,vPrepLogicalFileName),
																								fileservices.finishsuperfiletransaction()
																							)
																);
	
	outInfutorPrepped				:=	output(dInfutorOwner1NameInd,,vPrepLogicalFileName,overwrite,__compressed__);
	
	addInfutorPreppedToSuper	:=	sequential(	fileservices.startsuperfiletransaction(),
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

	addInfutorToBldg	:=	if(	fileservices.getsuperfilesubcount(vPrepSuperFileBldg)	>	0,
														output('Nothing added to Infutor Building superfile'),
														fileservices.addsuperfile(vPrepSuperFileBldg,vPrepLogicalFileName)
													 );
	
	GoSpray 					:= SEQUENTIAL(createSuperFiles,
																	IF (pFileDate <> ''	AND	
																			FileServices.FindSuperfileSubname(vPrepSuperFileName,vPrepLogicalFileName)=0,
																			sequential(	oRemoteFiles_SprayInfo, 
																									sprayFiles,
																									odInfutorRaw,
																									removeInfutorVinCandidates,
																									outInfutorVinCandidates,
																									addInfutorVinCandidates,
																									removeInfutorPrepped,
																									outInfutorPrepped,
																									addInfutorPreppedToSuper,
																									addInfutorToBldg
																								),
																			output('No New Infutor VIN file available for spray')));
					
	 return GoSpray;
	 
end;