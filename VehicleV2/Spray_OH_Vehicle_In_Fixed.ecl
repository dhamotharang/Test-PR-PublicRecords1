//----------------------------------------------------------------------
//OH Vehicles source file: fix length
//----------------------------------------------------------------------
IMPORT _control,address;

srcIP											:=	_control.IPAddress.bctlpedata11;
targetGrp									:=	'thor400_36';
superfile_raw							:=	'~thor_data400::in::vehiclev2::di::oh_raw';
superfile									:=	'~thor_data400::in::vehiclev2::di::oh';
superfile_archive					:=	'~thor_data400::in::vehiclev2::di::oh_father';
superfile_delete					:=	'~thor_data400::in::vehiclev2::di::oh_delete';
superfile_bldg						:=	'~thor_data400::in::vehiclev2::di::oh_building';
RemoteLoc									:=	'/data/hds_2/vehreg/in/oh/';
RemoteFile								:=	'*.OPCLEX.TXT';

// check if file exists in UNIX
checkFileExists	:=	if(	count(FileServices.remotedirectory(srcIP,RemoteLoc,RemoteFile,false)(size	<>	0))	=	1,
												true,
												false
											)	:	independent;

// obtain the file date from the file name
file_date				:=	if(checkFileExists,FileServices.remotedirectory(srcIP,RemoteLoc,RemoteFile,false)[1].name[1..8],'')	:	independent;
filename				:=	superfile_raw	+	'_'	+	file_date;
preppedFilename	:=	superfile	+	'_'	+	file_date;

// check if file exists in superfile
remove_existing_file	:=	if(			FileServices.FileExists(filename)
															AND	FileServices.GetSuperFileSubCount(superfile_raw)	<>	0,
															FileServices.RemoveSuperFile(superfile_raw,filename),
															output('Removing File that already exist in superfile')
														);

// check if file exists in UNIX and then spray
spray_oh_vehicle	:=	FileServices.sprayfixed(	srcIP
																							 ,RemoteLoc + RemoteFile
																							 ,242
																							 ,targetGrp
																							 ,filename
																							 ,,,,true,true,true
																							);

// Add to superfile
add_oh_superfile	:=	sequential(	FileServices.StartSuperFileTransaction(),
																		FileServices.AddSuperFile(superfile_raw,filename),
																		FileServices.FinishSuperFileTransaction()
																	);

spray_add_files	:=	sequential(	remove_existing_file,
																	spray_oh_vehicle,
																	add_oh_superfile
																);
// Create OH VIN's only file
removeOHVinCandidates	:=	if(	fileservices.findsuperfilesubname('~thor_data400::in::vehiclev2::vina_candidates','~thor_data400::in::vehiclev2::oh::vina_candidates')	!=	0,
															sequential(	fileservices.startsuperfiletransaction(),
																						fileservices.removesuperfile('~thor_data400::in::vehiclev2::vina_candidates','~thor_data400::in::vehiclev2::oh::vina_candidates'),
																						fileservices.finishsuperfiletransaction()
																					)
														);

rVinCandidates_layout	:=
record
	string22	vin;
	string1		lf;
end;

rVinCandidates_layout	tVinCandidates(VehicleV2.Files.In.OH.Raw	pInput)	:=
transform
	self.vin	:=	pInput.VIN;
	self.lf		:=	'\n';
end;

dOHVinCandidates		:=	project(VehicleV2.Files.In.OH.Raw,tVinCandidates(left));

outOHVinCandidates	:=	output(dOHVinCandidates,,'~thor_data400::in::vehiclev2::oh::vina_candidates',overwrite,__compressed__);

addOHVinCandidates	:=	sequential(	fileservices.startsuperfiletransaction(),
																			fileservices.addsuperfile('~thor_data400::in::vehiclev2::vina_candidates','~thor_data400::in::vehiclev2::oh::vina_candidates'),
																			fileservices.finishsuperfiletransaction()
																		);

// Append name indicators and process date to the sprayed file
VehicleV2.Layout_OH.Prepped	tAppendProcessDate(VehicleV2.Files.In.OH.Raw	pInput)	:=
transform
	self.ProcessDate	:=	file_date;
	self.source_code	:=	'DI';
	self.state_origin	:=	'OH';
	self							:=	pInput;
	self							:=	[];
end;

dOHPrepped	:=	project(VehicleV2.Files.In.OH.Raw,tAppendProcessDate(left));

// Set name indicators for individuals and businesses
Address.Mac_Is_Business(dOHPrepped,OwnerName,dOHPreppedOwnerType,Append_OwnerNameTypeInd);
Address.Mac_Is_Business(dOHPreppedOwnerType,AdditionalOwnerName,dOHPreppedAddlOwnerNameType,Append_AddlOwnerNameTypeInd);

outputPrep	:=	output(dOHPreppedAddlOwnerNameType,,'~thor_data400::in::vehiclev2::di::oh_'	+	File_Date,overwrite,__compressed__);

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

addOHtoBldg	:=	if(	fileservices.getsuperfilesubcount(superfile_bldg)	>	0,
										output('Nothing added to OH building superfile'),
										fileservices.addsuperfile(superfile_bldg,preppedFilename)
									);

EXPORT Spray_OH_Vehicle_In_Fixed	:=	if(	checkfileexists	and	FileServices.FindSuperfileSubname(superfile,preppedFilename)	=	0,
																					sequential(	spray_add_files,
																												removeOHVinCandidates,
																												outOHVinCandidates,
																												addOHVinCandidates,
																												BuildPrep,
																												addOHToBldg
																											),
																					output('No New OH direct file available for spray')
																				);