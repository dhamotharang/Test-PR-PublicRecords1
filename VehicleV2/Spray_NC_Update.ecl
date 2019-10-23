//----------------------------------------------------------------------
//NC Vehicles source file: fixed length
//----------------------------------------------------------------------
IMPORT _control,Address;

export Spray_NC_Update(string	process_date) :=
function
	srcIP											:=	_control.IPAddress.bctlpedata11;
	targetGrp									:=	'thor400_36';
	superfile_raw							:=	'~thor_data400::in::vehiclev2::di::nc_raw';
	superfile									:=	'~thor_data400::in::vehiclev2::di::nc';
	superfile_archive					:=	'~thor_data400::in::vehiclev2::di::nc_father';
	superfile_delete					:=	'~thor_data400::in::vehiclev2::di::nc_delete';
	superfile_bldg						:=	'~thor_data400::in::vehiclev2::di::nc_building';
	RemoteLoc									:=	'/data/hds_2/vehreg/in/nc/';
	RemoteFile								:=	'*.LEXISNEXIS.vn*';

	// check if file exists in UNIX
	checkFileExists	:=	if(	count(FileServices.remotedirectory(srcIP,RemoteLoc,RemoteFile,false)(size	<>	0))	=	1,
													true,
													false
												)	:	independent;

	// obtain the file date from the file name
	file_date				:=	if(checkFileExists,FileServices.remotedirectory(srcIP,RemoteLoc,RemoteFile,false)[1].name[1..8],'')	:	independent;
	filename				:=	superfile_raw	+	'_'	+	file_date;
	preppedFilename	:=	superfile	+	'_'	+	File_Date;

	// check if file exists in superfile
	remove_existing_file	:=	if(			FileServices.FileExists(filename)
																AND	FileServices.GetSuperFileSubCount(superfile_raw)	<>	0,
																FileServices.RemoveSuperFile(superfile_raw,filename),
																output('Removing File that already exist in superfile')
															);

	// check if file exists in UNIX and then spray
	spray_nc_vehicle	:=	FileServices.sprayfixed(	srcIP
																								 ,RemoteLoc + RemoteFile
																								 ,602
																								 ,targetGrp
																								 ,filename
																								 ,,,,true,true,true
																								);

	// Add to superfile
	add_nc_superfile	:=	sequential(	FileServices.StartSuperFileTransaction(),
																			FileServices.AddSuperFile(superfile_raw,filename),
																			FileServices.FinishSuperFileTransaction()
																		);

	spray_add_files	:=	sequential(	remove_existing_file,
																		spray_nc_vehicle,
																		add_nc_superfile
																	);

	// Create NC VIN's only file
	removeNCVinCandidates	:=	if(	fileservices.findsuperfilesubname('~thor_data400::in::vehiclev2::vina_candidates','~thor_data400::in::vehiclev2::nc::vina_candidates')	!=	0,
																	sequential(	fileservices.startsuperfiletransaction(),
																								fileservices.removesuperfile('~thor_data400::in::vehiclev2::vina_candidates','~thor_data400::in::vehiclev2::nc::vina_candidates'),
																								fileservices.finishsuperfiletransaction()
																							)
																);

	rVinCandidates_layout	:=
	record
		string22	vin;
		string1		lf;
	end;

	rVinCandidates_layout	tVinCandidates(VehicleV2.Files.In.NC.Raw	pInput)	:=
	transform
		self.vin	:=	pInput.VEHICLE_IDENTIFICATION;
		self.lf		:=	'\n';
	end;
	
	dNCVinCandidates		:=	project(VehicleV2.Files.In.NC.Raw,tVinCandidates(left));
	
	outNCVinCandidates	:=	output(dNCVinCandidates,,'~thor_data400::in::vehiclev2::nc::vina_candidates',overwrite,__compressed__);

	addNCVinCandidates	:=	sequential(	fileservices.startsuperfiletransaction(),
																				fileservices.addsuperfile('~thor_data400::in::vehiclev2::vina_candidates','~thor_data400::in::vehiclev2::nc::vina_candidates'),
																				fileservices.finishsuperfiletransaction()
																			);

	// Append name indicators and process date to the sprayed file
	VehicleV2.Layout_NC.Prepped_Layout	tAppendProcessDate(VehicleV2.Files.In.NC.Raw	pInput)	:=
	transform
		self.Process_Date	:=	process_date;
		self.state_origin	:=	'NC';
		self.source_code	:=	'DI';
		self							:=	pInput;
		self							:=	[];
	end;

	dNCPrepped	:=	project(VehicleV2.Files.In.NC.Raw,tAppendProcessDate(left));

	// Append name type indicators depending on the names
	Address.Mac_Is_Business_Parsed(	dNCPrepped,
																	dNCOwner1NameInd,
																	OWNER1_FIRST_NAME,
																	OWNER1_MIDDLE_NAME,
																	OWNER1_LAST_NAME,
																	OWNER1_NAME_SUFFIX,
																	,
																	Append_Owner1NameTypeInd
																);
	Address.Mac_Is_Business_Parsed(	dNCOwner1NameInd,
																	dNCOwner2NameInd,
																	OWNER2_FIRST_NAME,
																	OWNER2_MIDDLE_NAME,
																	OWNER2_LAST_NAME,
																	OWNER2_NAME_SUFFIX,
																	,
																	Append_Owner2NameTypeInd
																);
	
	outputPrep	:=	output(project(dNCOwner2NameInd,Vehiclev2.Layout_NC.Prepped_Layout),,'~thor_data400::in::vehiclev2::di::nc_'	+	File_Date,overwrite,__compressed__);

	BuildPrep	:=	SEQUENTIAL(	outputPrep,
															FileServices.StartSuperFileTransaction(),
															FileServices.AddSuperFile(superfile_delete,superfile_archive,,true),
															FileServices.ClearSuperFile(superfile_archive),
															FileServices.AddSuperFile(superfile_archive,superfile,,true),
															FileServices.ClearSuperFile(superfile),
															FileServices.AddSuperFile(superfile,preppedFilename),
															FileServices.FinishSuperFileTransaction(),
															FileServices.ClearSuperFile(superfile_delete,true),
															FileServices.ClearSuperFile(superfile_raw,true)
														);

	addNCToBldg	:=	if(	fileservices.getsuperfilesubcount(superfile_bldg)	>	0,
											output('Nothing added to NC building superfile'),
											fileservices.addsuperfile(superfile_bldg,preppedFilename)
										);

	return	if(	checkfileexists	and	fileservices.findsuperfilesubname(superfile,preppedFilename)	=	0,
							sequential(	spray_add_files,
														removeNCVinCandidates,
														outNCVinCandidates,
														addNCVinCandidates,
														BuildPrep,
														addNCToBldg
													),
							output('No new NC direct file available for spray')
						);
end;