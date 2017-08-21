import address,business_header,business_header_ss,did_add,didville,faa,header_slimsort,ut;

// Assets search file from FDS
dAssetsIn	:=	dataset	(	ut.foreign_prod+'~thor_data400::in::fds_test::20091130::assets::search',
												Layout_assets.Input.rAssetsIn_layout,
												CSV(HEADING(1),SEPARATOR(['|']), TERMINATOR(['\r\n', '\n']))
											);

// Aicraft base file
dAircraftReg	:=	faa.file_aircraft_registration_out;
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

// Clean name and address for assets vendor file
rAssetsClean_layout	:=
record
	dAssetsIn;
	address.Layout_Clean182_fips;
	address.Layout_Clean_Name;
	integer8	did					:=	0;
	unsigned3	did_score		:=	0;
	integer8	bdid				:=	0;
	unsigned3	bdid_score	:=	0;
end;

rAssetsClean_layout	tAssetsCleanNameAddr(dAssetsIn pInput)	:=
transform
	clean_address			:=	address.CleanAddressParsed(	trim(pInput.address,left,right)						+
																										' '																				+
																										trim(pInput.secondary_address,left,right)	,
																										trim(pInput.city,left,right) 							+
																										' '																				+
																										trim(pInput.state,left,right)							+
																										' '																				+
																										trim(pInput.zip_code,left,right)
																									);

	clean_name				:=	address.CleanPersonLFM73_fields(trim(pInput.Name,left,right));
	
	self.title				:=	clean_name.title;
	self.fname				:=	clean_name.fname;
	self.mname				:=	clean_name.mname;
	self.lname				:=	clean_name.lname;
	self.name_suffix	:=	clean_name.name_suffix;
	self.name_score		:=	clean_name.name_score;
	self							:=	clean_address.addressrecord;
	self							:=	pInput;
end;

dAssetsCleanNameAddr	:=	project(dAssetsIn,tAssetsCleanNameAddr(left));

boolean	pSSNSearch						:=			dAssetsCleanNameAddr.SSN						!=	''
																	and	length(dAssetsCleanNameAddr.SSN)		=		9
																	and	dAssetsCleanNameAddr.SSN						not in ['111111111','999999999'];

boolean	pNameAddrSearch				:=			dAssetsCleanNameAddr.Name						!=	''
																	and	dAssetsCleanNameAddr.Address				!=	'';

boolean	pNamePartialSSNSearch	:=			dAssetsCleanNameAddr.Name						!=	''
																	and	dAssetsCleanNameAddr.SSN						!=	''
																	and	length(dAssetsCleanNameAddr.SSN)		!=	9;

boolean	pBusNameAddrSearch		:=			dAssetsCleanNameAddr.Business_Name 	!=	''
																	and	dAssetsCleanNameAddr.Address				!=	'';

boolean	pNameStSearch					:=			dAssetsCleanNameAddr.Name						!=	''
																	and	dAssetsCleanNameAddr.State					!=	''
																	and	dAssetsCleanNameAddr.Address				=		''
																	and	dAssetsCleanNameAddr.City						=		''
																	and	dAssetsCleanNameAddr.Zip_code				=		'';

boolean	pAddrSearch						:=			dAssetsCleanNameAddr.Address				!=	''
																	and	dAssetsCleanNameAddr.Name						=		''
																	and	dAssetsCleanNameAddr.Business_Name	=		'';
																	
boolean	pNameZipSearch				:=			dAssetsCleanNameAddr.Name						!=	''
																	and	dAssetsCleanNameAddr.Address				=		''
																	and	dAssetsCleanNameAddr.City						=		''
																	and	dAssetsCleanNameAddr.State					=		''
																	and	dAssetsCleanNameAddr.Zip_Code				!=	'';

boolean	pBusNameCityStSearch	:=			dAssetsCleanNameAddr.Business_Name	!=	''
																	and	dAssetsCleanNameAddr.Address				=		''
																	and	dAssetsCleanNameAddr.City						!=	''
																	and	dAssetsCleanNameAddr.State					!=	'';

boolean	pAircraftIdSearch			:=	dAssetsCleanNameAddr.Craft_ID						!=	'';


// Get all the records where the search conditions are not met
dAssetsNoSearch	:=	dAssetsCleanNameAddr(	~(			pSSNSearch
																							or	pNamePartialSSNSearch
																							or	pNameAddrSearch
																							or	pBusNameAddrSearch
																							or	pNameStSearch
																							or	pAddrSearch
																							or	pNameZipSearch
																							or	pBusNameCityStSearch
																							or	pAircraftIdSearch
																						)
																				);

output(count(dAssetsNoSearch),named('Cnt_Records_not_being_used_in_searches'));
// output(dAssetsNoSearch,named('Records_not_being_used_in_searches'));

// Declare common layouts and transforms being used for the searches
rAssetsSearchMatch_layout	:=
record
	recordof(dAssetsCleanNameAddr)	assets_search;
	recordof(dAircraft)							search_result;
end;

rAssetsSearchMatch_layout	tMatchFDS(dAircraft le, dAssetsCleanNameAddr ri)	:=
transform
	self.assets_search	:=	ri;
	self.search_result	:=	le;
end;

// Search1 - Match on SSN
// Append DID by SSN
SSN_Matchset	:=	['S'];
DID_Add.MAC_Match_Flex(	dAssetsCleanNameAddr(pSSNSearch),
												SSN_Matchset,
												SSN,
												'',
												fname,mname,lname,name_suffix, 
												prim_range,prim_name,sec_range,zip,st,
												'',
												did,   			
												rAssetsClean_layout, 
												true,
												did_score,
												75,
												dAssets_DIDBySSN,
											);

// output(dAssets_DIDBySSN,named('Assets_DID_by_SSN'));

dAssetsSSNDIDMatch	:=	join(	dAircraft((integer)did_out != 0),
															dAssets_DIDBySSN,
															(integer8)left.did_out	=	right.did,
															tMatchFDS(left,right),
															lookup
														);

// output(dAssetsSSNMatch,named('SSN_Match'));

dAssetsSSNDIDNoMatch	:=	join(	dAircraft((integer)did_out != 0),
																dAssets_DIDBySSN,
																(integer8)left.did_out	=	right.did,
																tMatchFDS(left,right),
																right only,
																hash
															);

// setSSNNoMatchDID	:=	set(dAssetsSSNNoMatch,assets_search.did);

// output(dAssetsSSNNoMatch,named('SSN_NoMatch'));

// Match on SSN directly
dAssetsSSNDirectMatch		:=	join(	dAircraft(best_ssn	!=	''),
																	dAssetsSSNDIDNoMatch,
																	left.best_ssn	=	right.assets_search.ssn,
																	transform(	rAssetsSearchMatch_layout,
																							self.assets_search	:=	right.assets_search;
																							self.search_result	:=	left;
																						),
																	lookup
																);

dAssetsSSNDirectNoMatch	:=	join(	dAircraft(best_ssn	!=	''),
																	dAssetsSSNDIDNoMatch,
																	left.best_ssn	=	right.assets_search.ssn,
																	transform(	rAssetsSearchMatch_layout,
																							self.assets_search	:=	right.assets_search;
																							self.search_result	:=	left;
																						),
																	right only,
																	hash
																);

dAssetsSSNMatch		:=	dAssetsSSNDIDMatch	+	dAssetsSSNDirectMatch;
dAssetsSSNNoMatch	:=	dAssetsSSNDirectNoMatch;
// Search2 - Match on Name and Partial SSN

dAssetsNamePartialSSNMatch	:=	join(	dAircraft(best_ssn != ''),
																			dAssetsCleanNameAddr(pNamePartialSSNSearch),
																			left.fname					=	right.fname	and
																			left.mname					=	right.mname	and
																			left.lname					=	right.lname	and
																			left.best_ssn[6..9]	=	right.ssn,
																			tMatchFDS(left,right),
																			lookup
																		);

// output(dAssetsNamePartialSSNMatch,named('NamePartialSSN_Match'));

dAssetsNamePartialSSNNoMatch	:=	join(	dAircraft(best_ssn != ''),
																				dAssetsCleanNameAddr(pNamePartialSSNSearch),
																				left.fname					=	right.fname	and
																				left.mname					=	right.mname	and
																				left.lname					=	right.lname	and
																				left.best_ssn[6..9]	=	right.ssn,
																				tMatchFDS(left,right),
																				right only,
																				hash
																			);

// output(dAssetsNamePartialSSNNoMatch,named('NamePartialSSN_NoMatch'));

// Search3 - Match on Name and Address
// Append DID by address
NameAddress_Matchset	:=	['A'];
DID_Add.MAC_Match_Flex(	dAssetsCleanNameAddr(pNameAddrSearch),
												NameAddress_Matchset,
												SSN,
												'',
												fname,mname,lname,name_suffix, 
												prim_range,prim_name,sec_range,zip,st,
												'',
												did,   			
												rAssetsClean_layout, 
												true,
												did_score,
												80,
												dAssets_DIDByNameAddr,
											);

// output(dAssets_DIDByNameAddr,named('Assets_DID_by_NameAddr'));

dAssetsNameAddrMatch	:=	join(	dAircraft((integer)did_out != 0),
																dAssets_DIDByNameAddr,
																(integer8)left.did_out	=	right.did,
																tMatchFDS(left,right),
																lookup
															);

// output(dAssetsNameAddrMatch,named('NameAddr_Match'));

dAssetsNameAddrNoMatch	:=	join(	dAircraft((integer)did_out != 0),
																	dAssets_DIDByNameAddr,
																	(integer8)left.did_out	=	right.did,
																	tMatchFDS(left,right),
																	right only,
																	hash
																);

setNameAddrNoMatchDID	:=	set(dAssetsNameAddrNoMatch,assets_search.did);

// output(dAssetsNameAddrNoMatch,named('NameAddr_NoMatch'));

// Search4 - Match on Business Name and Address
// Append BDID by address
BusNameAddress_Matchset	:=	['A'];
preBDID	:=	dAssetsCleanNameAddr(pBusNameAddrSearch);

Business_header_ss.MAC_Match_Flex(	preBDID,
																		BusNameAddress_Matchset,
																		Business_Name,
																		prim_range,prim_name,zip,sec_range,st,
																		Phone_Number,
																		tax_id_number,
																		bdid,   			
																		rAssetsClean_layout, 
																		true,
																		bdid_score,
																		dAssets_BDIDByBusNameAddr
																	);

// output(dAssets_BDIDByBusNameAddr,named('Assets_BDID_by_BusNameAddr'));

dAssetsBusNameAddrMatch	:=	join(	dAircraft((integer)bdid_out != 0),
																	dAssets_BDIDByBusNameAddr,
																	(integer8)left.bdid_out	=	right.bdid,
																	tMatchFDS(left,right),
																	lookup
																);

// output(dAssetsBusNameAddrMatch,named('BusNameAddr_Match'));

dAssetsBusNameAddrNoMatch	:=	join(	dAircraft((integer)bdid_out != 0),
																		dAssets_BDIDByBusNameAddr,
																		(integer8)left.bdid_out	=	right.bdid,
																		tMatchFDS(left,right),
																		right only,
																		hash
																	);

// output(dAssetsBusNameAddrNoMatch,named('BusNameAddr_NoMatch'));

// Search5 - Address only
dAssetsAddrMatch	:=	join(	dAircraft,
														dAssetsCleanNameAddr(pAddrSearch),
														left.prim_range		=	right.prim_range	and
														left.predir				=	right.predir			and
														left.prim_name		=	right.prim_name		and
														left.sec_range		=	right.sec_range		and
														left.postdir			=	right.postdir			and
														left.p_city_name	=	right.p_city_name	and
														left.st						=	right.st					and
														left.zip					=	right.zip,
														tMatchFDS(left,right),
														hash
													);

// output(dAssetsAddrMatch,named('Addr_Match'));

dAssetsAddrNoMatch	:=	join(	dAircraft,
															dAssetsCleanNameAddr(pAddrSearch),
															left.prim_range		=	right.prim_range	and
															left.predir				=	right.predir			and
															left.prim_name		=	right.prim_name		and
															left.sec_range		=	right.sec_range		and
															left.postdir			=	right.postdir			and
															left.p_city_name	=	right.p_city_name	and
															left.st						=	right.st					and
															left.zip					=	right.zip,
															tMatchFDS(left,right),
															right only,
															hash
														);

// output(dAssetsAddrNoMatch,named('Addr_NoMatch'));

// Search6 - Name and State only
dAssetsNameStMatch	:=	join(	dAircraft,
															dAssetsCleanNameAddr(pNameStSearch),
															left.fname	=	right.fname	and
															left.mname	=	right.mname	and
															left.lname	=	right.lname	and
															left.st			=	right.st,
															tMatchFDS(left,right),
															hash
														);

// output(dAssetsNameStMatch,named('NameState_Match'));

dAssetsNameStNoMatch	:=	join(	dAircraft,
																dAssetsCleanNameAddr(pNameStSearch),
																left.fname	=	right.fname	and
																left.mname	=	right.mname	and
																left.lname	=	right.lname	and
																left.st			=	right.st,
																tMatchFDS(left,right),
																right only,
																hash
															);

// output(dAssetsNameStNoMatch,named('NameState_NoMatch'));

// Search7 - Business Name, City and State only
dAssetsBusNameCityStMatch	:=	join(	dAircraft,
																		dAssetsCleanNameAddr(pBusNameCityStSearch),
																		business_header.CompanyCleanFields(left.compname,true).indicative	=	business_header.CompanyCleanFields(right.Business_Name,true).indicative	and
																		business_header.CompanyCleanFields(left.compname,true).secondary	=	business_header.CompanyCleanFields(right.Business_Name,true).secondary	and
																		left.p_city_name																									=	right.p_city_name	and
																		left.st																														=	right.st,
																		tMatchFDS(left,right),
																		hash
																	);

// output(dAssetsBusNameCityStMatch,named('BusNameCityState_Match'));

dAssetsBusNameCityStNoMatch	:=	join(	dAircraft,
																			dAssetsCleanNameAddr(pBusNameCityStSearch),
																			business_header.CompanyCleanFields(left.compname,true).indicative	=	business_header.CompanyCleanFields(right.Business_Name,true).indicative	and
																			business_header.CompanyCleanFields(left.compname,true).secondary	=	business_header.CompanyCleanFields(right.Business_Name,true).secondary	and
																			left.p_city_name																									=	right.p_city_name	and
																			left.st																														=	right.st,
																			tMatchFDS(left,right),
																			right only,
																			hash
																		);

// output(dAssetsBusNameCityStNoMatch,named('BusNameCityState_NoMatch'));

// Search8 - Name and Zip only
dAssetsNameZipMatch	:=	join(	dAircraft,
															dAssetsCleanNameAddr(pNameZipSearch),
															left.fname	=	right.fname	and
															left.mname	=	right.mname	and
															left.lname	=	right.lname	and
															left.zip		=	right.zip,
															tMatchFDS(left,right),
															hash
														);

// output(dAssetsNameZipMatch,named('NameZip_Match'));

dAssetsNameZipNoMatch	:=	join(	dAircraft,
																dAssetsCleanNameAddr(pNameZipSearch),
																left.fname	=	right.fname	and
																left.mname	=	right.mname	and
																left.lname	=	right.lname	and
																left.zip		=	right.zip,
																tMatchFDS(left,right),
																right only,
																hash
															);

// output(dAssetsNameZipNoMatch,named('NameZip_NoMatch'));

// Search9 - Aircraft ID only
dAssetsAircraftIDMatch	:=	join(	dAircraft,
																	dAssetsCleanNameAddr(pAircraftIdSearch),
																	left.n_number	=	right.craft_id,
																	tMatchFDS(left,right),
																	hash
																);

// output(dAssetsAircraftIDMatch,named('AircraftID_Match'));

dAssetsAircraftIDNoMatch	:=	join(	dAircraft,
																		dAssetsCleanNameAddr(pAircraftIdSearch),
																		left.n_number	=	right.craft_id,
																		tMatchFDS(left,right),
																		right only,
																		hash
																	);

// output(dAssetsAircraftIDNoMatch,named('AircraftID_NoMatch'));

dAssetsNoMatch	:=		dAssetsSSNNoMatch
										+	dAssetsNamePartialSSNMatch
										+	dAssetsNameAddrNoMatch
										+	dAssetsBusNameAddrNoMatch
										+	dAssetsAddrNoMatch
										+	dAssetsNameStNoMatch
										+	dAssetsNameZipNoMatch
										+	dAssetsBusNameCityStNoMatch
										+	dAssetsAircraftIDNoMatch;

dAssetsMatch		:=		dAssetsSSNMatch
										+	dAssetsNamePartialSSNNoMatch
										+	dAssetsNameAddrMatch
										+	dAssetsBusNameAddrMatch
										+	dAssetsAddrMatch
										+	dAssetsNameStMatch
										+	dAssetsNameZipMatch
										+	dAssetsBusNameCityStMatch
										+	dAssetsAircraftIDMatch;

layout_assets.response.rFDSAircraft_layout	tAircraftConvert2Out(dAssetsMatch pInput)	:=
transform
	self.Record_ID					:=	pInput.assets_search.record_id;
	self.First_Name					:=	pInput.search_result.fname;
	self.Middle_Name				:=	pInput.search_result.mname;
	self.Last_Name					:=	pInput.search_result.lname;
	self.Company_name				:=	pInput.search_result.compname;
	self.Address_Line1			:=	trim(	if(trim(pInput.search_result.prim_range)	!=	'',trim(pInput.search_result.prim_range)	+	' ','')	+
																		if(trim(pInput.search_result.predir)			!=	'',trim(pInput.search_result.predir)			+	' ','')	+
																		if(trim(pInput.search_result.prim_name)		!=	'',trim(pInput.search_result.prim_name)		+	' ','')	+
																		trim(pInput.search_result.addr_suffix)
																	);
	self.Address_Line2			:=	trim(	if(trim(pInput.search_result.unit_desig)	!=	'',trim(pInput.search_result.unit_desig)	+	' ','')	+
																		trim(pInput.search_result.sec_range)
																	);
	self.City								:=	pInput.search_result.p_city_name;
	self.State							:=	pInput.search_result.st;
	self.Zip								:=	pInput.search_result.zip;
	self.Aircraft_Number		:=	pInput.search_result.n_number;
	self.Model_Name					:=	pInput.search_result.model_name;
	self.Manufacture_Year		:=	pInput.search_result.year_mfr;
	self.Engine_Model				:=	if(	pInput.search_result.engine_model_name	!=	'',
																	pInput.search_result.engine_model_name,
																	pInput.search_result.eng_mfr_mdl
																);
	self.History_Flag				:=	case(	trim(pInput.search_result.current_flag,left,right),
																		'A'	=>	'ACTIVE',
																		'I'	=>	'INACTIVE',
																		'H'	=>	'HISTORICAL',
																		''
																	);
	self.Registration_Type	:=	case(	trim(pInput.search_result.type_registrant,left,right),
																		'1'	=>	'Individual',
																		'2'	=>	'Partnership',
																		'3'	=>	'Corporation',
																		'4'	=>	'Co-Owned',
																		'5'	=>	'Government',
																		'8'	=>	'Non Citizen Corporation',
																		'9'	=>	'Non Citizen Co-Owned',
																		''
																	);
	self.Record_Type				:=	case(	trim(pInput.search_result.status_code,left,right),
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
	self.Serial_Number			:=	pInput.search_result.serial_number;
	self.Model_Code					:=	pInput.search_result.mfr_mdl_code;
	self.Manufacturer_Name	:=	pInput.search_result.aircraft_mfr_name;
	self.Aircraft_Type			:=	case(	trim(pInput.search_result.type_aircraft,left,right),
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
	self.Year_First_Seen		:=	pInput.search_result.date_first_seen[1..4];
	self.Year_Last_Seen			:=	pInput.search_result.date_last_seen[1..4];
end;

dAircraftMatchInfo				:=	project	(dAssetsMatch,tAircraftConvert2Out(left));

output(dAircraftMatchInfo,named('Aircraft_match_before_dedup'));

// Remove duplicate records
dAircraftMatchInfo_dist		:=	distribute(	dAircraftMatchInfo(first_name not in ['PENDING','REPORTED']),
																					hash(record_id)
																				);
dAircraftMatchInfo_sort		:=	sort(	dAircraftMatchInfo_dist,
																		record_id,
																		aircraft_number,
																		serial_number,
																		model_name,
																		manufacture_year,
																		engine_model,
																		history_flag,
																		record_type,
																		-year_last_seen,
																		local
																	);
/*
dAircraftMatchInfo_dedup	:=	dedup	(	dAircraftMatchInfo_sort,
																			record_id,
																			aircraft_number,
																			serial_number,
																			model_name,
																			manufacture_year,
																			engine_model,
																			history_flag,
																			record_type,
																			local
																		);

output(dAircraftMatchInfo_dedup,named('Aircraft_match_after_first_dedup'));
*/
// Restrict matched records to just 5
dAircraftMatch		:=	dedup	(	dAircraftMatchInfo_sort,
															record_id,
															keep 5,
															local
														);

// combine no match search records and records which were not used as searches
dAircraftNoMatch	:=	project	(	dAssetsNoMatch,
																transform(	layout_assets.response.rFDSAircraft_layout,
																						self.record_id	:=	left.assets_search.record_id;
																						self						:=	[];
																					)
															);

dAircraftNoSearch	:=	project	(	dAssetsNoSearch,
																transform(	layout_assets.response.rFDSAircraft_layout,
																						self.record_id	:=	left.record_id;
																						self						:=	[];
																					)
															);

output(dAircraftNoSearch,named('No_Search_Matches'));

// Combine all the file and write to out file
dAll	:=	sort(		dAircraftMatch
								+	dAircraftNoMatch
								+	dAircraftNoSearch
								,	(integer)record_id
							);

output(dAll,named('FullFile'));

outFDSAircraftAppend_fixed	:=	output	(	dAll,,
																					'~thor_data400::out::fds_test::assets::aircraft_append2_fixed',
																					overwrite,
																					__compressed__
																				);

outFDSAircraftAppend				:=	output	(	dAll,,
																					'~thor_data400::out::fds_test::assets::aircraft_append2',
																					csv(heading(single),separator('|'),terminator('\n')),
																					overwrite,
																					__compressed__
																				);


// field population stats
rStats_layout	:=
record
	string3	statGroup									:=	'ALL';
	cntTotal													:=	count(group);
	cntRecordID_CountNonBlank					:=	sum(group,if(dAll.record_id					!=	'',1,0));
	cntFirstName_CountNonBlank				:=	sum(group,if(dAll.First_Name				!=	'',1,0));
	cntMiddleName_CountNonBlank				:=	sum(group,if(dAll.Middle_Name				!=	'',1,0));
	cntLastName_CountNonBlank					:=	sum(group,if(dAll.Last_Name					!=	'',1,0));
	cntCompanyName_CountNonBlank			:=	sum(group,if(dAll.Company_Name			!=	'',1,0));
	cntAddress1_CountNonBlank					:=	sum(group,if(dAll.Address_Line1			!=	'',1,0));
	cntAddress2_CountNonBlank					:=	sum(group,if(dAll.Address_Line2			!=	'',1,0));
	cntCity_CountNonBlank							:=	sum(group,if(dAll.City							!=	'',1,0));
	cntState_CountNonBlank						:=	sum(group,if(dAll.State							!=	'',1,0));
	cntZip_CountNonBlank							:=	sum(group,if(dAll.Zip								!=	'',1,0));
	cntAircraftNumber_CountNonBlank		:=	sum(group,if(dAll.Aircraft_Number		!=	'',1,0));
	cntModelName_CountNonBlank				:=	sum(group,if(dAll.Model_Name				!=	'',1,0));
	cntManufactureYear_CountNonBlank	:=	sum(group,if(dAll.Manufacture_Year	!=	'',1,0));
	cntHistoryFlag_CountNonBlank			:=	sum(group,if(dAll.History_Flag			!=	'',1,0));
	cntEngine_Model_CountNonBlank			:=	sum(group,if(dAll.Engine_Model			!=	'',1,0));
	cntRegistrationType_CountNonBlank	:=	sum(group,if(dAll.Registration_Type	!=	'',1,0));
	cntRecordType_CountNonBlank				:=	sum(group,if(dAll.Record_Type				!=	'',1,0));
	cntSerialNumber_CountNonBlank			:=	sum(group,if(dAll.Serial_Number			!=	'',1,0));
	cntModelCode_CountNonBlank				:=	sum(group,if(dAll.Model_Code				!=	'',1,0));
	cntManufacturerName_CountNonBlank	:=	sum(group,if(dAll.Manufacturer_Name	!=	'',1,0));
	cntAircraftType_CountNonBlank			:=	sum(group,if(dAll.Aircraft_Type			!=	'',1,0));
	cntYearFirstSeen_CountNonBlank		:=	sum(group,if(dAll.Year_First_Seen		!=	'',1,0));
	cntYearLastSeen_CountNonBlank			:=	sum(group,if(dAll.Year_Last_Seen		!=	'',1,0));
end;

dPopulationStats	:=	table(dAll,rStats_layout,few);

outStats	:=	output(dPopulationStats,all,named('PopulationStats'));

// counts total number of unique record id's in the outfile
cntUniqueRecIds	:=	count(dedup(dAll,record_id,all));

// get total counts for all searches
cntTotalSSNSearch							:=	count(dAssetsCleanNameAddr(pSSNSearch));
cntTotalNamePartialSSNSearch	:=	count(dAssetsCleanNameAddr(pNamePartialSSNSearch));
cntTotalNameAddrSearch				:=	count(dAssetsCleanNameAddr(pNameAddrSearch));
cntTotalBusNameAddrSearch			:=	count(dAssetsCleanNameAddr(pBusNameAddrSearch));
cntTotalAddrSearch						:=	count(dAssetsCleanNameAddr(pAddrSearch));
cntTotalNameStSearch					:=	count(dAssetsCleanNameAddr(pNameStSearch));
cntTotalNameZipSearch					:=	count(dAssetsCleanNameAddr(pNameZipSearch));
cntTotalBusNameCityStSearch		:=	count(dAssetsCleanNameAddr(pBusNameCityStSearch));
cntTotalAircraftIDSearch			:=	count(dAssetsCleanNameAddr(pAircraftIdSearch));

cntTotalSearch								:=		cntTotalSSNSearch
																	+	cntTotalNamePartialSSNSearch
																	+	cntTotalNameAddrSearch
																	+	cntTotalBusNameAddrSearch
																	+	cntTotalAddrSearch
																	+	cntTotalNameStSearch
																	+	cntTotalNameZipSearch
																	+	cntTotalBusNameCityStSearch
																	+	cntTotalAircraftIDSearch;

// counts for searches with no matches
cntSSNNoMatch							:=	count(dAssetsSSNNoMatch);
cntNamePartialSSNNoMatch	:=	count(dAssetsNamePartialSSNNoMatch);
cntNameAddrNoMatch				:=	count(dAssetsNameAddrNoMatch);
cntBusNameAddrNoMatch			:=	count(dAssetsBusNameAddrNoMatch);
cntAddrNoMatch						:=	count(dAssetsAddrNoMatch);
cntNameStNoMatch					:=	count(dAssetsNameStNoMatch);
cntNameZipNoMatch					:=	count(dAssetsNameZipNoMatch);
cntBusNameCityStNoMatch		:=	count(dAssetsBusNameCityStNoMatch);
cntAircraftIDNoMatch			:=	count(dAssetsAircraftIDNoMatch);

cntTotalNoMatch						:=		cntSSNNoMatch
															+	cntNamePartialSSNNoMatch
															+	cntNameAddrNoMatch
															+	cntBusNameAddrNoMatch
															+	cntAddrNoMatch
															+	cntNameStNoMatch
															+	cntNameZipNoMatch
															+	cntBusNameCityStNoMatch
															+	cntAircraftIDNoMatch;

// match rates for searches
matchRateTotal								:=	(real8)((cntTotalSearch - cntTotalNoMatch)/cntTotalSearch)*100;
matchRateSSNSearch						:=	(real8)((cntTotalSSNSearch - CntSSNNoMatch)/cntTotalSSNSearch)*100;
matchRateNamePartialSSNSearch	:=	(real8)((cntTotalNamePartialSSNSearch - cntNamePartialSSNNoMatch)/cntTotalNamePartialSSNSearch)*100;
matchRateNameAddrSearch				:=	(real8)((cntTotalNameAddrSearch - cntNameAddrNoMatch)/cntTotalNameAddrSearch)*100;
matchRateBusNameAddrSearch		:=	(real8)((cntTotalBusNameAddrSearch - cntBusNameAddrNoMatch)/cntTotalBusNameAddrSearch)*100;
matchRateAddrSearch						:=	(real8)((cntTotalAddrSearch - cntAddrNoMatch)/cntTotalAddrSearch)*100;
matchRateNameStSearch					:=	(real8)((cntTotalNameStSearch - cntNameStNoMatch)/cntTotalNameStSearch)*100;
matchRateNameZipSearch				:=	(real8)((cntTotalNameZipSearch - cntNameZipNoMatch)/cntTotalNameZipSearch)*100;
matchRateBusNameCityStSearch	:=	(real8)((cntTotalBusNameCityStSearch - cntBusNameCityStNoMatch)/cntTotalBusNameCityStSearch)*100;
matchRateAircraftIDSearch			:=	(real8)((cntTotalAircraftIDSearch - cntAircraftIDNoMatch)/cntTotalAircraftIDSearch)*100;

export Aircraft_Append := sequential	(	outFDSAircraftAppend,
																				outFDSAircraftAppend_fixed,
																				output(dAircraftMatchInfo,							named('QA_Sample_Records')),
																				output(cntUniqueRecIds,								named('Cnt_Unique_RecID')),
																				output(cntSSNNoMatch,									named('Cnt_SSN_NoMatch')),
																				output(cntNamePartialSSNNoMatch,				named('Cnt_NamePartialSSN_NoMatch')),
																				output(cntNameAddrNoMatch,							named('Cnt_NameAddr_NoMatch')),
																				output(cntBusNameAddrNoMatch,					named('Cnt_BusNameAddr_NoMatch')),
																				output(cntAddrNoMatch,									named('Cnt_Addr_NoMatch')),
																				output(cntNameStNoMatch,								named('Cnt_NameState_NoMatch')),
																				output(cntNameZipNoMatch,							named('Cnt_NameZip_NoMatch')),
																				output(cntBusNameCityStNoMatch,				named('Cnt_BusNameCityState_NoMatch')),
																				output(cntAircraftIDNoMatch,						named('Cnt_AircraftID_NoMatch')),
																				output(matchRateTotal,									named('MatchRate_Total'));
																				output(matchRateSSNSearch,							named('MatchRate_SSN')),
																				output(matchRateNamePartialSSNSearch,	named('MatchRate_NamePartialSSN')),
																				output(matchRateNameAddrSearch,				named('MatchRate_NameAddr')),
																				output(matchRateBusNameAddrSearch,			named('MatchRate_BusNameAddr')),
																				output(matchRateAddrSearch,						named('MatchRate_Addr')),
																				output(matchRateNameStSearch,					named('MatchRate_NameState')),
																				output(matchRateNameZipSearch,					named('MatchRate_NameZip')),
																				output(matchRateBusNameCityStSearch,		named('MatchRate_BusNameCityState')),
																				output(matchRateAircraftIDSearch,			named('MatchRate_AircraftID')),
																				outStats
																			);