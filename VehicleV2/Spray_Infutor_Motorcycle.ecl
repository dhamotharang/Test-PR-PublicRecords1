//Spray Infutor Motorcycle file. Use thor40_241 for dataland cluster
IMPORT _control,lib_fileservices,Address;

 EXPORT Spray_Infutor_Motorcycle(string	pProcessDate,
																 string	pGroupName	=	'thor400_36',
																 boolean	pOverwrite	=	true
																 )	:=
 FUNCTION

	STRING		vSourceIP		:=	_control.IPAddress.bctlpedata11;
	//STRING		vSourceIP		:=	_control.IPAddress.edata10;
	STRING		vDirectory	:=	'/data/hds_2/vehreg/in/infutor/motorcycle/';
	//STRING		vDirectory	:=	'/data_build_5_2/INFUTOR/MOTORCYCLE/';
	STRING		vfileName		:=	'NARVM*.txt';
	STRING		vDelim			:= 	'\\t';
	vMaxRecordSize				:=  8192;

	// check if file exists in UNIX
	checkFileExists				:=	if(	count(FileServices.remotedirectory(vSourceIP,vDirectory,vfileName,false)(size	<>	0))	=	1,
																true,
																false
															)	:	independent;

	// obtain the file date from the file name
	pFileDate							:=	if(checkFileExists,FileServices.remotedirectory(vSourceIP,vDirectory,vfileName,false)[1].name[6..13],'')	:	independent;

	vRawLogicalFileName		:=	'~thor_data400::in::vehiclev2::inf_nondppa::motorcycle_raw::'	+	pFileDate;
	vRawSuperFileName			:=	'~thor_data400::in::vehiclev2::inf_nondppa::motorcycle_raw';
	vPrepLogicalFileName	:=	'~thor_data400::in::vehiclev2::inf_nondppa::motorcycle_'	+	pFileDate;
	vPrepSuperFileName		:=	'~thor_data400::in::vehiclev2::inf_nondppa::motorcycle';
	vPrepSuperFileFather	:=	'~thor_data400::in::vehiclev2::inf_nondppa::motorcycle_father';
	vPrepSuperFileBldg		:=	'~thor_data400::in::vehiclev2::inf_nondppa::motorcycle_building';

	//createSuperFiles and remove logical file from superfile if it is an overwrite
	superFilePrePorcessing := sequential(	fileservices.startsuperfiletransaction(),
																				IF(NOT FileServices.SuperFileExists(vRawSuperFileName),
																					 FileServices.CreateSuperFile(vRawSuperFileName)),
																				IF(NOT FileServices.SuperFileExists(vPrepSuperFileName),
																					 FileServices.CreateSuperFile(vPrepSuperFileName)),
																				IF(NOT FileServices.SuperFileExists(vPrepSuperFileFather),
																					 FileServices.CreateSuperFile(vPrepSuperFileFather)),
																				IF(NOT FileServices.SuperFileExists(vPrepSuperFileBldg),
																					 FileServices.CreateSuperFile(vPrepSuperFileBldg)),
																				IF(pOverwrite AND fileservices.FindSuperFileSubName(vRawSuperFileName,vRawLogicalFileName)>0,
																					 fileservices.removesuperfile(vRawSuperFileName,vRawLogicalFileName)),
																				IF(pOverwrite AND fileservices.FindSuperFileSubName(vPrepSuperFileName,vPrepLogicalFileName)>0,
																					 fileservices.removesuperfile(vPrepSuperFileName,vPrepLogicalFileName)),
																				IF(pOverwrite AND fileservices.FindSuperFileSubName(vPrepSuperFileBldg,vPrepLogicalFileName)>0,
																					 fileservices.removesuperfile(vPrepSuperFileBldg,vPrepLogicalFileName)),
																				IF(pOverwrite AND fileservices.FindSuperFileSubName(vPrepSuperFileFather,vPrepLogicalFileName)>0,
																					 fileservices.removesuperfile(vPrepSuperFileFather,vPrepLogicalFileName)),
																				fileservices.finishsuperfiletransaction()
																			);
						
	sprayInfutorMotorcycle:=	lib_fileservices.fileservices.SprayVariable(vSourceIP,
																																				vDirectory+vfileName,
																																				vMaxRecordSize,
																																				vDelim,
																																				'\r\n',
																																				'',
																																				pGroupName,
																																				vRawLogicalFileName,
																																				,
																																				,
																																				,
																																				pOverwrite,
																																				,
																																				TRUE
																																				);
	
	addToRawSuper			:=	sequential(fileservices.startsuperfiletransaction(),
																   fileservices.addsuperfile(vRawSuperFileName,vRawLogicalFileName),
																	 fileservices.finishsuperfiletransaction()
																	 );							 


	dInfutorRaw := VehicleV2.Files.In.Infutor_Motorcycle.Raw;
	
	// Create Infutor_VIN VIN's only file
	removeInfutorVinCandidates	:=	if(	fileservices.findsuperfilesubname('~thor_data400::in::vehiclev2::vina_candidates','~thor_data400::in::vehiclev2::inf_nondppa_motorcycle::vina_candidates')	!=	0,
																			sequential(	fileservices.startsuperfiletransaction(),
																										fileservices.removesuperfile('~thor_data400::in::vehiclev2::vina_candidates','~thor_data400::in::vehiclev2::inf_nondppa_motorcycle::vina_candidates'),
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
		self			:=	[];
	end;
	
	dInfutorVinCandidates		:=	project(dInfutorRaw,tVinCandidates(left));
	
	outInfutorVinCandidates	:=	output(dInfutorVinCandidates,,'~thor_data400::in::vehiclev2::inf_nondppa_motorcycle::vina_candidates',overwrite,__compressed__);

	addInfutorVinCandidates	:=	sequential(	fileservices.startsuperfiletransaction(),
																				fileservices.addsuperfile('~thor_data400::in::vehiclev2::vina_candidates','~thor_data400::in::vehiclev2::inf_nondppa_motorcycle::vina_candidates'),
																				fileservices.finishsuperfiletransaction()
																			);
	
	// Add process date and state origin - prep the raw sprayed file and add it to the superfile
	VehicleV2.Layout_Infutor_Motorcycle.Prepped	tPrepInfutorRaw(dInfutorRaw	pInput)	:= TRANSFORM
		SELF.ProcessDate					:=	pProcessDate;
		SELF.source_code					:=	'2V';     //source code for INFUTOR VIN, defined in MDR.sourceTools
		//state_origin should be the state code of the state the vehicle is registered at. 
		//It is not available in Infutor. Instead we use the state code of owner's address.
		SELF.state_origin					:=	stringlib.stringtouppercase(pInput.STATE);
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
	
	outInfutorPrepped				:=	output(project(dInfutorOwner1NameInd,VehicleV2.Layout_Infutor_Motorcycle.PREPPED),,vPrepLogicalFileName,overwrite,__compressed__);
	
	addInfutorPreppedToSuper	:=	sequential(	fileservices.startsuperfiletransaction(),
																							fileservices.clearsuperfile(vPrepSuperFileFather,true),
																							fileservices.addsuperfile(vPrepSuperFileFather,vPrepSuperFileName,,true),
																							fileservices.clearsuperfile(vPrepSuperFileName),
																							fileservices.addsuperfile(vPrepSuperFileName,vPrepLogicalFileName),
																							fileservices.finishsuperfiletransaction(),
																							fileservices.clearsuperfile(vRawSuperFileName,true)
																						);

	addInfutorToBldg	:=	if(	fileservices.getsuperfilesubcount(vPrepSuperFileBldg)	>	0,
														output('Nothing added to Infutor Building superfile'),
														fileservices.addsuperfile(vPrepSuperFileBldg,vPrepLogicalFileName)
													 );

	SprayFile 				:= if(checkfileexists	AND	
	                        (NOT FileServices.SuperFileExists(vPrepSuperFileName) OR
	                        FileServices.FindSuperfileSubname(vPrepSuperFileName,vPrepLogicalFileName)=0),
	                        sequential(	superFilePrePorcessing,
																			sprayInfutorMotorcycle,
																			addToRawSuper,
																			removeInfutorVinCandidates,
																			outInfutorVinCandidates,
																			addInfutorVinCandidates,
																			removeInfutorPrepped,
																			outInfutorPrepped,
																			addInfutorPreppedToSuper,
																			addInfutorToBldg
																		),
													output('No New Infutor Motorcycle file available for spray'));

	RETURN SprayFile;

END;