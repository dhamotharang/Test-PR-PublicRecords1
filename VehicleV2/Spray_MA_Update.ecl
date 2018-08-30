IMPORT _control,lib_fileservices,Address;
//This file is copied from Spray_Infutor_Vin. It reads the input directory and sprays all files in the directory to the target
//location. The input files are with txt extention and delimited by tab.
EXPORT Spray_MA_Update(string	pProcessDate,
											 string	pGroupName	  =	'thor400_36',
											 boolean	pOverwrite	=	true
											)	:=
FUNCTION

	//STRING		vSourceIP		:=	_control.IPAddress.edata12;
	STRING		vSourceIP		:=	_control.IPAddress.bctlpedata11;
	STRING		vDirectory	:=	'/data/data_build_5_2/vehiclev2/MA/';
	STRING		vfileMask		:=	'MAREGFILE.LEXNEX.DATA-*';
	vRecordSize						:=  759;

	// check if file exists in UNIX
	checkFileExists				:=	if(	count(FileServices.remotedirectory(vSourceIP,vDirectory,vfileMask,false)(size	<>	0))	>	0,
																true,
																false
															)	:	independent;
	// obtain the file date from the file name
	pFileDate							:=	if(checkFileExists,FileServices.remotedirectory(vSourceIP,vDirectory,vfileMask,false)[1].name[23..30],'')	:	independent;

	vRawLogicalFileName		:=	'~thor_data400::in::vehiclev2::di::ma_raw::' + pFileDate;
	vRawSuperFileName			:=	'~thor_data400::in::vehiclev2::di::ma_raw';
	vPrepLogicalFileName	:=	'~thor_data400::in::vehiclev2::di::ma_'	+	pFileDate;
	vPrepSuperFileName		:=	'~thor_data400::in::vehiclev2::di::ma';
	vPrepSuperFileDelete	:=	'~thor_data400::in::vehiclev2::di::ma_delete';
	vPrepSuperFileFather	:=	'~thor_data400::in::vehiclev2::di::ma_father';
	vPrepSuperFileBldg		:=	'~thor_data400::in::vehiclev2::di::ma_building';

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
								
	sprayMA :=	lib_fileservices.fileservices.sprayFixed(vSourceIP,
																												vDirectory+vfileMask,
																												vRecordSize,
																												pGroupName,
																												vRawLogicalFileName,
																												,
																												,
																												,
																												pOverwrite,
																												TRUE,
																												TRUE
																												);

	addToRawSuper			:=	sequential(fileservices.startsuperfiletransaction(),
																   fileservices.addsuperfile(vRawSuperFileName,vRawLogicalFileName),
																	 fileservices.finishsuperfiletransaction()
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
			);

	addMAPreppedToSuper	:=	sequential(	fileservices.startsuperfiletransaction(),
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

	addToBldg						:=	if(	fileservices.getsuperfilesubcount(vPrepSuperFileBldg)	>	0,
														output('Nothing added to MA Building superfile'),
														fileservices.addsuperfile(vPrepSuperFileBldg,vPrepLogicalFileName)
														);
	
	rMA_layout	:=
	record
		VehicleV2.Layout_MA.RAW;
		string	LogicalFileName	{virtual(LogicalFileName)};
	end;
	
	dMARaw	:=	dataset(vRawSuperFileName,rMA_layout,THOR);
	
	// Create MA VIN's only file
	removeMACandidates	:=	if(	fileservices.findsuperfilesubname('~thor_data400::in::vehiclev2::vina_candidates','~thor_data400::in::vehiclev2::ma::vina_candidates')	!=	0,
																	sequential(	fileservices.startsuperfiletransaction(),
																								fileservices.removesuperfile('~thor_data400::in::vehiclev2::vina_candidates','~thor_data400::in::vehiclev2::ma::vina_candidates'),
																								fileservices.finishsuperfiletransaction()
																							)
																);

	rVinCandidates_layout	:=
	record
		string22	VIN;
		string1		lf;
	end;

	rVinCandidates_layout	tVinCandidates(dMARaw pInput)	:=
	transform
		self.vin	:=	pInput.VEH_VIN;
		self			:= 	[];
	end;
	
	dMACandidates		:=	project(dMARaw,tVinCandidates(left));
	
	outMACandidates	:=	output(dMACandidates,,'~thor_data400::in::vehiclev2::ma::vina_candidates',overwrite,__compressed__);

	addMACandidates	:=	sequential(	fileservices.startsuperfiletransaction(),
																				fileservices.addsuperfile('~thor_data400::in::vehiclev2::vina_candidates','~thor_data400::in::vehiclev2::ma::vina_candidates'),
																				fileservices.finishsuperfiletransaction()
																			);

	// Add process date and state origin - prep the raw sprayed file and add it to the superfile
	VehicleV2.Layout_MA.Prepped	tPrepInfutorRaw(dMARaw	pInput)	:= TRANSFORM
		SELF.Process_Date					:=	pProcessDate;
		SELF.source_code					:=	'3V';     
		SELF.state_origin					:=	'MA';
		SELF											:=	pInput;
		SELF											:=	[];		
		
	END;
	
	dPrepMARaw					:=	project(dMARaw,tPrepInfutorRaw(left));

	// Append name type indicators depending on the names
	 Address.Mac_Is_Business_Parsed(	dPrepMARaw,
																		dMAOwner1NameInd,
																		OWNER1_FIRST_NAME,
																		OWNER1_MIDDLE_NAME,
																		OWNER1_LAST_NAME,
																		OWNER1_SUFFIX_NAME,
																		,
																		Append_Owner1NameTypeInd
																);

	 Address.Mac_Is_Business_Parsed(	dMAOwner1NameInd,
																		dMAOwner2NameInd,
																		OWNER2_FIRST_NAME,
																		OWNER2_MIDDLE_NAME,
																		OWNER2_LAST_NAME,
																		OWNER2_SUFFIX_NAME,
																		,
																		Append_Owner2NameTypeInd
																);
	
	removeMAPrepped	:=	if(	fileservices.findsuperfilesubname(vPrepSuperFileBldg,vPrepLogicalFileName)	!=	0,
																	sequential(	fileservices.startsuperfiletransaction(),
																								fileservices.removesuperfile(vPrepSuperFileBldg,vPrepLogicalFileName),
																								fileservices.finishsuperfiletransaction()
																							)
																);
	outMAPrepped				:=	output(PROJECT(dMAOwner2NameInd,VehicleV2.Layout_MA.PREPPED),,vPrepLogicalFileName,overwrite,__compressed__);
	
	GoSpray 					:= SEQUENTIAL(superFilePrePorcessing,
																	IF (FileServices.FindSuperfileSubname(vPrepSuperFileName,vPrepLogicalFileName)=0,
																			sequential(	sprayMA,
																									addToRawSuper,
																									removeMACandidates,
																									outMACandidates,
																									addMACandidates,
																									removeMAPrepped,
																									outMAPrepped,
																									addMAPreppedToSuper,
																									addToBldg
																								),
																			output('No New MA update available for spray'))
																	);	

	 return GoSpray;
	 
END;
