import faa,ut;

dAircraftReg	:=	faa.file_aircraft_registration_out(zip in zipcodeset and fname not in ['PENDING','REPORTED']);
dEngineModel	:=	faa.file_engine_info_in;

rEngineModelLkp_layout	:=
record
	dAircraftReg;
	string13	engine_model_name	:=	'';
end;

dAircraft	:=	join(	dAircraftReg,
										dEngineModel,
										trim(left.eng_mfr_mdl,left,right)	=	trim(right.engine_mfr_model_code,left,right),
										transform(	rEngineModelLkp_layout,
																self.engine_model_name	:=	right.model_name;
																self										:=	left;
															),
										left outer,
										lookup
									);

output(dAircraft(engine_model_name	!=	''),named('Aircraft_Engine_Lookup'));

// dAircraft	:=	faa.file_aircraft_registration_out(zip in zipcodeset and fname not in ['PENDING','REPORTED']);

layout_assets.response.rFDSAircraft_layout	tAircraftZip(dAircraft pInput)	:=
transform
	self.Record_ID					:=	'';
	self.First_Name					:=	pInput.fname;
	self.Middle_Name				:=	pInput.mname;
	self.Last_Name					:=	pInput.lname;
	self.Company_Name				:=	pInput.CompName;
	self.Address_Line1			:=	trim(	if(trim(pInput.prim_range)	!=	'',trim(pInput.prim_range)	+	' ','')	+
																		if(trim(pInput.predir)			!=	'',trim(pInput.predir)			+	' ','')	+
																		if(trim(pInput.prim_name)		!=	'',trim(pInput.prim_name)		+	' ','')	+
																		trim(pInput.addr_suffix)
																	);
	self.Address_Line2			:=	trim(	if(trim(pInput.unit_desig)	!=	'',trim(pInput.unit_desig)	+	' ','')	+
																		trim(pInput.sec_range)
																	);
	self.City								:=	pInput.v_city_name;
	self.State							:=	pInput.st;
	self.Zip								:=	pInput.zip;
	self.Aircraft_Number		:=	pInput.n_number;
	self.Model_Name					:=	pInput.model_name;
	self.Manufacture_Year		:=	pInput.year_mfr;
	self.Engine_Model				:=	if(	pInput.engine_model_name	!=	'',
																	pInput.engine_model_name,
																	pInput.eng_mfr_mdl
																);
	self.History_Flag				:=	case(	trim(pInput.current_flag,left,right),
																		'A'	=>	'ACTIVE',
																		'I'	=>	'INACTIVE',
																		'H'	=>	'HISTORICAL',
																		''
																	);
	self.Registration_Type	:=	case(	trim(pInput.type_registrant,left,right),
																		'1'	=>	'Individual',
																		'2'	=>	'Partnership',
																		'3'	=>	'Corporation',
																		'4'	=>	'Co-Owned',
																		'5'	=>	'Government',
																		'8'	=>	'Non Citizen Corporation',
																		'9'	=>	'Non Citizen Co-Owned',
																		''
																	);
	self.Record_Type				:=	case(	trim(pInput.status_code,left,right),
																		'A'	=>	'The Triennial Aircraft Registration form was mailed and has not been returned by the Post Office',
																		'D'	=>	'Expired Dealer',
																		'E'	=>	'The Certificate of Aircraft Registration was revoked by enforcementaction',
																		'M'	=>	'Aircraft registered to the manufacturer under their Dealer Certificate',
																		'N'	=>	'Non-citizen Corporations which have not returned their flight hour reports',
																		'R'	=>	'Registration pending',
																		'S'	=>	'Second Triennial Aircraft Registration Form has been mailed and has not been returned by the Post Office',
																		'T'	=>	'N-Number Assigned and Registered',
																		'V'	=>	'N-Number Assigned and Registered',
																		'X'	=>	'Enforcement Letter',
																		'Z'	=>	'Permanent Reserved',
																		'1'	=>	'Triennial Aircraft Registration form was returned by the Post Office as undeliverable',
																		'2'	=>	'N-Number Assigned - but has not yet been registered',
																		'3'	=>	'N-Number assigned as a Non Type Certificated aircraft - but has not yet been registered',
																		'4'	=>	'N-Number assigned as import - but has not yet been registered',
																		'5'	=>	'Reserved N-Number',
																		'6'	=>	'Administratively canceled',
																		'7'	=>	'Sale reported',
																		'8'	=>	'A second attempt has been made at mailing a Triennial Aircraft Registration form to the owner with no response',
																		'9'	=>	'Certificate of Registration has been revoked',
																		''
																	);
	self.Serial_Number			:=	pInput.serial_number;
	self.Model_Code					:=	pInput.mfr_mdl_code;
	self.Manufacturer_Name	:=	pInput.aircraft_mfr_name;
	self.Aircraft_Type			:=	case(	trim(pInput.type_aircraft,left,right),
																		'1'	=>	'Glider',
																		'2'	=>	'Balloon',
																		'3'	=>	'Blimp/Dirigible',
																		'4'	=>	'Fixed wing single engine',
																		'5'	=>	'Fixed wing multi engine',
																		'6'	=>	'Rotorcraft',
																		'7'	=>	'Weight-shift-control',
																		'8'	=>	'Powered Parachute',
																		'9'	=>	'Gyroplane',
																		''
																	);
	self.Year_First_Seen		:=	pInput.date_first_seen[1..4];
	self.Year_Last_Seen			:=	pInput.date_last_seen[1..4];
end;

dAircraftZipExtract	:=	project(dAircraft,tAircraftZip(left));
/*
// remove duplicate records
dAircraftZipExtract_dist	:=	distribute(	dAircraftZipExtract,
																					hash(	last_name,
																								address_line1,
																								zip,
																								aircraft_number
																							)
																				);

dAircraftZipExtract_sort	:=	sort(	dAircraftZipExtract_dist,
																		first_name,
																		middle_name,
																		last_name,
																		address_line1,
																		address_line2,
																		city,
																		state,
																		zip,
																		aircraft_number,
																		serial_number,
																		model_code,
																		engine_model,
																		-year_last_seen,
																		local
																	);

dAircraftZipExtract_dedup	:=	dedup(dAircraftZipExtract_sort,
																		first_name,
																		middle_name,
																		last_name,
																		address_line1,
																		address_line2,
																		city,
																		state,
																		zip,
																		aircraft_number,
																		serial_number,
																		local
																	);

output(choosen(dAircraftZipExtract_dedup,1000),named('Aircraft_ZipExtractTest'));
*/

// Append sequence number
dAircraftZipExtract_sort	:=	sort(dAircraftZipExtract,zip,aircraft_number,-year_last_seen);

layout_assets.response.rFDSAircraft_layout	tConvert2Out(dAircraftZipExtract_sort pInput,integer cnt)	:=
transform
	self.Record_ID		:=	(string)cnt;
	self							:=	pInput;
end;

dAircraftExtract	:=	project(dAircraftZipExtract_sort,tConvert2Out(left,counter));

outAircraftExtract_Fixed	:=	output(	dAircraftExtract,,
																				'~thor_data400::out::fds_test::assets::Aircraft_Extract1_fixed',
																				overwrite,
																				__compressed__
																			);

outAircraftExtract				:=	output(	dAircraftExtract,,
																				'~thor_data400::out::fds_test::assets::Aircraft_Extract1',
																				csv(separator('|'),terminator('\n'),heading(single)),
																				overwrite,
																				__compressed__
																			);

// field population stats
rStats_layout	:=
record
	string3	statGroup									:=	'ALL';
	cntTotal													:=	count(group);
	cntRecordID_CountNonBlank					:=	sum(group,if(dAircraftExtract.record_id					!=	'',1,0));
	cntFirstName_CountNonBlank				:=	sum(group,if(dAircraftExtract.First_Name				!=	'',1,0));
	cntMiddleName_CountNonBlank				:=	sum(group,if(dAircraftExtract.Middle_Name				!=	'',1,0));
	cntLastName_CountNonBlank					:=	sum(group,if(dAircraftExtract.Last_Name					!=	'',1,0));
	cntCompanyName_CountNonBlank			:=	sum(group,if(dAircraftExtract.Company_Name			!=	'',1,0));
	cntAddress1_CountNonBlank					:=	sum(group,if(dAircraftExtract.Address_Line1			!=	'',1,0));
	cntAddress2_CountNonBlank					:=	sum(group,if(dAircraftExtract.Address_Line2			!=	'',1,0));
	cntCity_CountNonBlank							:=	sum(group,if(dAircraftExtract.City							!=	'',1,0));
	cntState_CountNonBlank						:=	sum(group,if(dAircraftExtract.State							!=	'',1,0));
	cntZip_CountNonBlank							:=	sum(group,if(dAircraftExtract.Zip								!=	'',1,0));
	cntAircraftNumber_CountNonBlank		:=	sum(group,if(dAircraftExtract.Aircraft_Number		!=	'',1,0));
	cntModelName_CountNonBlank				:=	sum(group,if(dAircraftExtract.Model_Name				!=	'',1,0));
	cntManufactureYear_CountNonBlank	:=	sum(group,if(dAircraftExtract.Manufacture_Year	!=	'',1,0));
	cntEngine_Model_CountNonBlank			:=	sum(group,if(dAircraftExtract.Engine_Model			!=	'',1,0));
	cntHistoryFlag_CountNonBlank			:=	sum(group,if(dAircraftExtract.History_Flag			!=	'',1,0));
	cntRegistrationType_CountNonBlank	:=	sum(group,if(dAircraftExtract.Registration_Type	!=	'',1,0));
	cntRecordType_CountNonBlank				:=	sum(group,if(dAircraftExtract.Record_Type				!=	'',1,0));
	cntSerialNumber_CountNonBlank			:=	sum(group,if(dAircraftExtract.Serial_Number			!=	'',1,0));
	cntModelCode_CountNonBlank				:=	sum(group,if(dAircraftExtract.Model_Code				!=	'',1,0));
	cntManufacturerName_CountNonBlank	:=	sum(group,if(dAircraftExtract.Manufacturer_Name	!=	'',1,0));
	cntAircraftType_CountNonBlank			:=	sum(group,if(dAircraftExtract.Aircraft_Type			!=	'',1,0));
	cntYearFirstSeen_CountNonBlank		:=	sum(group,if(dAircraftExtract.Year_First_Seen		!=	'',1,0));
	cntYearLastSeen_CountNonBlank			:=	sum(group,if(dAircraftExtract.Year_Last_Seen		!=	'',1,0));
end;

dPopulationStats	:=	table(dAircraftExtract,rStats_layout,few);

outStats	:=	output(dPopulationStats,all,named('PopulationStats'));

export Aircraft_Extract := sequential(outAircraftExtract_Fixed,outAircraftExtract,outStats);