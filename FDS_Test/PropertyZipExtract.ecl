#workunit('name', 'Property Zip Extract')

import address, codes, ln_propertyv2, ut;

dAsses	:=	ln_propertyv2.File_Assessment;

dDeeds	:=	ln_propertyv2.File_Deed;

dCodes	:=	codes.File_Codes_V3_In(	file_name		in	['FARES_2580','FARES_1080']	and
																		field_name2	in	['OKCTY','FAR_F']
																	);

dSearch	:=	distribute(	ln_propertyv2.File_Search_DID(source_code[1]	!= 'C'	and
																											(lname != '' or cname != '')
																										 ),
												hash(ln_fares_id)
											);
/*
// Get only the fields that are required in the out layout
rAssesSlim_layout	:=
record
	dAsses.ln_fares_id;
	dAsses.assessee_name;
	dAsses.second_assessee_name;
	dAsses.property_full_street_address;
  dAsses.property_unit_number;
  dAsses.property_city_state_zip;
	dAsses.mailing_full_street_address;
  dAsses.mailing_unit_number;
  dAsses.mailing_city_state_zip;
	dAsses.assessee_phone_number;
	dAsses.county_name;
	dAsses.fips_code;
	dAsses.apna_or_pin_number;
	dAsses.fares_unformatted_apn;
	dAsses.assessed_total_value;
	dAsses.homestead_homeowner_exemption;
	dAsses.tax_year;
	dAsses.assessed_value_year;
	dAsses.tax_amount;
	dAsses.assessed_improvement_value;
	dAsses.standardized_land_use_code;
	dAsses.year_built;
	dAsses.no_of_units;
	dAsses.fireplace_number;
	dAsses.garage_type_code;
	dAsses.parking_no_of_cars;
	dAsses.type_construction_code;
	dAsses.effective_year_built;
	dAsses.no_of_stories;
	dAsses.pool_code;
	dAsses.heating_code;
	dAsses.no_of_rooms;
	dAsses.no_of_baths;
	dAsses.no_of_bedrooms;
	dAsses.roof_type_code;
	dAsses.building_area;
  dAsses.building_area_indicator;
  dAsses.building_area1;
  dAsses.building_area1_indicator;
  dAsses.building_area2;
  dAsses.building_area2_indicator;
  dAsses.building_area3;
  dAsses.building_area3_indicator;
  dAsses.building_area4;
  dAsses.building_area4_indicator;
  dAsses.building_area5;
  dAsses.building_area5_indicator;
  dAsses.building_area6;
  dAsses.building_area6_indicator;
  dAsses.building_area7;
  dAsses.building_area7_indicator;
	dAsses.air_conditioning_code;
	dAsses.lot_size;
	dAsses.lot_size_depth_feet;
	dAsses.legal_tract_number;
	dAsses.legal_lot_number;
	dAsses.legal_city_municipality_township;
	dAsses.legal_subdivision_name;
	dAsses.lot_size_frontage_feet;
	dAsses.zoning;
	dAsses.legal_block;
	dAsses.legal_district;
	dAsses.legal_section;
	string5		vendor_source_flag;
	string330	standard_use_description	:=	'';
	string330	garage_description				:=	'';
	string330	construction_description	:=	'';
	string330	heating_description				:=	'';
	string330	cooling_description				:=	'';
	string330	roofing_description				:=	'';
end;

dAssesSlim	:=	project	(	ln_propertyv2.File_Assessment,
													transform	(	rAssesSlim_layout,
																			self.vendor_source_flag	:=	if(left.vendor_source_flag in ['O','D'],'OKCTY','FAR_F');
																			self										:=	left
																		)
												);

// Lookup join for Standardized Landuse Codes
rAssesSlim_layout	tLandUseCodesLkp(dAssesSlim le, dCodes ri)	:=
transform
	self.standard_use_description	:=	ri.long_desc;
	self													:=	le;
end;

dAssesLandUseCodeLkp	:=	join(	dAssesSlim,
																dCodes,
																right.file_name									=	'FARES_2580'			and
																right.field_name								=	'LAND_USE'				and
																left.vendor_source_flag					=	right.field_name2	and
																left.standardized_land_use_code	=	right.code,
																tLandUseCodesLkp(left,right),
																left outer,
																lookup
															);

output(dAssesLandUseCodeLkp(standardized_land_use_code != ''),named('Asses_Land_Use_Desc'));

// Lookup join for Garage codes
rAssesSlim_layout	tGarageCodesLkp(dAssesLandUseCodeLkp le, dCodes ri)	:=
transform
	self.garage_description	:=	ri.long_desc;
	self										:=	le;
end;

dAssesGarageCodeLkp	:=	join(	dAssesLandUseCodeLkp,
															dCodes,
															right.file_name					=	'FARES_2580'			and
															right.field_name				=	'GARAGE'					and
															left.vendor_source_flag	=	right.field_name2	and
															left.garage_type_code		=	right.code,
															tGarageCodesLkp(left,right),
															left outer,
															lookup
														);

output(dAssesGarageCodeLkp(garage_type_code != ''),named('Asses_Garage_Desc'));

// Lookup join for Construction Desc codes
rAssesSlim_layout	tConstTypeCodesLkp(dAssesGarageCodeLkp le, dCodes ri)	:=
transform
	self.construction_description	:=	ri.long_desc;
	self													:=	le;
end;

dAssesConstTypeCodeLkp	:=	join(	dAssesGarageCodeLkp,
																	dCodes,
																	right.file_name							=	'FARES_2580'				and
																	right.field_name						=	'CONSTRUCTION_TYPE'	and
																	left.vendor_source_flag			=	right.field_name2		and
																	left.type_construction_code	=	right.code,
																	tConstTypeCodesLkp(left,right),
																	left outer,
																	lookup
																);

output(dAssesConstTypeCodeLkp(type_construction_code != ''),named('Asses_ConstType_Desc'));

// Lookup join for Heating codes
rAssesSlim_layout	tHeatingCodesLkp(dAssesConstTypeCodeLkp le, dCodes ri)	:=
transform
	self.heating_description	:=	ri.long_desc;
	self											:=	le;
end;

dAssesHeatingCodeLkp	:=	join(	dAssesConstTypeCodeLkp,
																dCodes,
																right.file_name									=	'FARES_2580'			and
																right.field_name								=	'HEATING'					and
																left.vendor_source_flag					=	right.field_name2	and
																left.heating_code	=	right.code,
																tHeatingCodesLkp(left,right),
																left outer,
																lookup
															);

output(dAssesHeatingCodeLkp(heating_code != ''),named('Asses_Heating_Desc'));

// Lookup join for Cooling codes
rAssesSlim_layout	tCoolingCodesLkp(dAssesHeatingCodeLkp le, dCodes ri)	:=
transform
	self.cooling_description	:=	ri.long_desc;
	self											:=	le;
end;

dAssesCoolingCodeLkp	:=	join(	dAssesHeatingCodeLkp,
																dCodes,
																right.file_name							=	'FARES_2580'				and
																right.field_name						=	'AIR_CONDITIONING'	and
																left.vendor_source_flag			=	right.field_name2		and
																left.air_conditioning_code	=	right.code,
																tCoolingCodesLkp(left,right),
																left outer,
																lookup
															);

output(dAssesCoolingCodeLkp(air_conditioning_code != ''),named('Asses_Cooling_Desc'));

// Lookup join for Roof Type Codes
rAssesSlim_layout	tRoofTypeCodesLkp(dAssesCoolingCodeLkp le, dCodes ri)	:=
transform
	self.roofing_description	:=	ri.long_desc;
	self											:=	le;
end;

dAssesRoofTypeCodeLkp	:=	join(	dAssesCoolingCodeLkp,
																dCodes,
																right.file_name						=	'FARES_2580'			and
																right.field_name					=	'ROOF_TYPE'				and
																left.vendor_source_flag		=	right.field_name2	and
																left.roof_type_code				=	right.code,
																tRoofTypeCodesLkp(left,right),
																left outer,
																lookup
															);

output(dAssesRoofTypeCodeLkp(roof_type_code != ''),named('Asses_Roof_Type_Desc'));

// Slim down the deeds layout to bring only the required fields
rDeedsSlim_layout	:=
record
	dDeeds.ln_fares_id;
	dDeeds.buyer_or_borrower_ind;
	dDeeds.name1;
	dDeeds.name2;
	dDeeds.seller1;
	dDeeds.seller2;
	dDeeds.property_full_street_address;
	dDeeds.property_address_unit_number;
	dDeeds.property_address_citystatezip;
	dDeeds.mailing_street;
	dDeeds.mailing_unit_number;
	dDeeds.mailing_csz;
	dDeeds.phone_number;
	dDeeds.lender_name;
	dDeeds.title_company_name;
	dDeeds.county_name;
	dDeeds.fips_code;
	dDeeds.apnt_or_pin_number;
	dDeeds.fares_unformatted_apn;
	dDeeds.contract_date;
	dDeeds.recording_date;
	dDeeds.sales_price;
	dDeeds.first_td_loan_amount;
	dDeeds.first_td_loan_type_code;
	dDeeds.document_number;
	dDeeds.document_type_code;
	dDeeds.second_td_loan_amount;
	dDeeds.land_lot_size;
	dDeeds.legal_brief_description;
	dDeeds.first_td_due_date;
	dDeeds.legal_tract_number;
	dDeeds.legal_lot_number;
	dDeeds.legal_city_municipality_township;
	dDeeds.legal_subdivision_name;
	dDeeds.legal_block;
	dDeeds.legal_district;
	dDeeds.legal_section;
	string5		vendor_source_flag;
	string330	loan_type_description			:=	'';
	string330	document_type_description	:=	'';
end;

dDeedsSlim	:=	project	(	ln_propertyv2.File_Deed,
													transform	(	rDeedsSlim_layout,
																			self.vendor_source_flag	:=	if(left.vendor_source_flag in ['O','D'],'OKCTY','FAR_F');
																			self										:=	left
																		)
												);

// Lookup join for Mortgage Loan Type codes
rDeedsSlim_layout	tLoanTypeCodesLkp(dDeedsSlim le, dCodes ri)	:=
transform
	self.loan_type_description	:=	ri.long_desc;
	self												:=	le;
end;

dDeedsLoanTypeCodeLkp	:=	join(	dDeedsSlim,
																dCodes,
																right.file_name								=	'FARES_1080'							and
																right.field_name							=	'MORTGAGE_LOAN_TYPE_CODE'	and
																left.vendor_source_flag				=	right.field_name2					and
																left.first_td_loan_type_code	=	right.code,
																tLoanTypeCodesLkp(left,right),
																left outer,
																lookup
															);

output(dDeedsLoanTypeCodeLkp(first_td_loan_type_code != ''),named('Deeds_LoanType_Desc'));

// Lookup join for Document Type codes
rDeedsSlim_layout	tDocumentTypeCodesLkp(dDeedsLoanTypeCodeLkp le, dCodes ri)	:=
transform
	self.document_type_description	:=	ri.long_desc;
	self												:=	le;
end;

dDeedsDocumentTypeCodeLkp	:=	join(	dDeedsLoanTypeCodeLkp,
																		dCodes,
																		right.file_name					=	'FARES_1080'			and
																		right.field_name				=	'DOCUMENT_TYPE'		and
																		left.vendor_source_flag	=	right.field_name2	and
																		left.document_type_code	=	right.code,
																		tDocumentTypeCodesLkp(left,right),
																		left outer,
																		lookup
																	);

output(dDeedsDocumentTypeCodeLkp(document_type_code != ''),named('Deeds_DocumentType_Desc'));

rSrchAppendClnNameAddr_layout	:=
record
	string12	ln_fares_id;
	
	string20	owner1_fname;
	string20	owner1_lname;
	string20	owner1_mname;
	string80	owner1_cname;
	unsigned6	owner1_did;
	string9		owner1_ssn;
	
	string20	owner2_fname;
	string20	owner2_lname;
	string20	owner2_mname;
	string80	owner2_cname;
	unsigned6	owner2_did;
	string9		owner2_ssn;
	
	string20	owner3_fname;
	string20	owner3_lname;
	string20	owner3_mname;
	string80	owner3_cname;
	unsigned6	owner3_did;
	string9		owner3_ssn;
	
	string20	owner4_fname;
	string20	owner4_lname;
	string20	owner4_mname;
	string80	owner4_cname;
	unsigned6	owner4_did;
	string9		owner4_ssn;
	
	string20	seller1_fname;
	string20	seller1_lname;
	string20	seller1_mname;
	string80	seller1_cname;
	unsigned6	seller1_did;
	string9		seller1_ssn;
	
	string20	seller2_fname;
	string20	seller2_lname;
	string20	seller2_mname;
	string80	seller2_cname;
	unsigned6	seller2_did;
	string9		seller2_ssn;
	
	string20	seller3_fname;
	string20	seller3_lname;
	string20	seller3_mname;
	string80	seller3_cname;
	unsigned6	seller3_did;
	string9		seller3_ssn;
	
	string20	seller4_fname;
	string20	seller4_lname;
	string20	seller4_mname;
	string80	seller4_cname;
	unsigned6	seller4_did;
	string9		seller4_ssn;
	
	string10  property_prim_range;
	string2   property_predir;
	string28  property_prim_name;
	string4   property_addr_suffix;
	string2   property_postdir;
	string10  property_unit_desig;
	string8   property_sec_range;
	string25  property_city_name;
	string2   property_st;
	string5   property_zip;
	string4   property_zip4;
	
	string10  mail_prim_range;
	string2   mail_predir;
	string28  mail_prim_name;
	string4   mail_addr_suffix;
	string2   mail_postdir;
	string10  mail_unit_desig;
	string8   mail_sec_range;
	string25  mail_city_name;
	string2   mail_st;
	string5   mail_zip;
	string4   mail_zip4;
end;

rSrchAppendClnNameAddr_layout	tSearch_AppendClnNameAddr(dSearch pInput)	:=
transform
	self	:=	pInput;
	self	:=	[];
end;

dSearch_AppendCleanNameAddr				:=	project(dSearch, tSearch_AppendClnNameAddr(left));
dSearch_AppendCleanNameAddr_sort	:=	sort(dSearch_AppendCleanNameAddr, ln_fares_id, local);
dSearch_AppendCleanNameAddr_dedup	:=	dedup(dSearch_AppendCleanNameAddr_sort, ln_fares_id, local);

// Denormalize the search file
// Denormalize name
rSrchAppendClnNameAddr_layout	tSearch_DenormName(dSearch_AppendCleanNameAddr_dedup le, dSearch ri)	:=
transform
	boolean	isBlankOwner1				:=	le.owner1_lname = '' and le.owner1_cname = '';
	
	boolean	isNotBlankOwner1		:=	le.owner1_lname != '' or le.owner1_cname != '';
	boolean	isNotBlankOwner2		:=	le.owner2_lname != '' or le.owner2_cname != '';
	boolean	isNotBlankOwner3		:=	le.owner3_lname != '' or le.owner3_cname != '';
	
	boolean	isBlankSeller1			:=	le.seller1_lname = '' and le.seller1_cname = '';
	
	boolean	isNotBlankSeller1		:=	le.seller1_lname != '' or le.seller1_cname != '';
	boolean	isNotBlankSeller2		:=	le.seller2_lname != '' or le.seller2_cname != '';
	boolean	isNotBlankSeller3		:=	le.seller3_lname != '' or le.seller3_cname != '';
	
	self.owner1_fname					:=	if(	ri.source_code[1] in ['O', 'B'] and isBlankOwner1,
																		ri.fname,
																		le.owner1_fname
																	);
	self.owner1_lname					:=	if(	ri.source_code[1] in ['O', 'B'] and isBlankOwner1,
																		ri.lname,
																		le.owner1_lname
																	);
	self.owner1_mname					:=	if(	ri.source_code[1] in ['O', 'B'] and isBlankOwner1,
																		ri.mname,
																		le.owner1_mname
																	);
	self.owner1_cname					:=	if(	ri.source_code[1] in ['O', 'B'] and isBlankOwner1,
																		ri.cname,
																		le.owner1_cname
																	);
	self.owner1_did						:=	if(	ri.source_code[1] in ['O', 'B'] and isBlankOwner1,
																		ri.did,
																		le.owner1_did
																	);
	self.owner1_ssn						:=	if(	ri.source_code[1] in ['O', 'B'] and isBlankOwner1,
																		ri.app_ssn,
																		le.owner1_ssn
																	);
	
	self.owner2_fname					:=	if(	ri.source_code[1] in ['O', 'B'] and isNotBlankOwner1,
																		ri.fname,
																		le.owner2_fname
																	);
	self.owner2_lname					:=	if(	ri.source_code[1] in ['O', 'B'] and isNotBlankOwner1,
																		ri.lname,
																		le.owner2_lname
																	);
	self.owner2_mname					:=	if(	ri.source_code[1] in ['O', 'B'] and isNotBlankOwner1,
																		ri.mname,
																		le.owner2_mname
																	);
	self.owner2_cname					:=	if(	ri.source_code[1] in ['O', 'B'] and isNotBlankOwner1,
																		ri.cname,
																		le.owner2_cname
																	);
	self.owner2_did						:=	if(	ri.source_code[1] in ['O', 'B'] and isNotBlankOwner1,
																		ri.did,
																		le.owner2_did
																	);
	self.owner2_ssn						:=	if(	ri.source_code[1] in ['O', 'B'] and isNotBlankOwner1,
																		ri.app_ssn,
																		le.owner2_ssn
																	);
	
	self.owner3_fname					:=	if(	ri.source_code[1] in ['O', 'B'] and isNotBlankOwner2,
																		ri.fname, 
																		le.owner3_fname
																	);
	self.owner3_lname					:=	if(	ri.source_code[1] in ['O', 'B'] and isNotBlankOwner2,
																		ri.lname,
																		le.owner3_lname
																	);
	self.owner3_mname					:=	if(	ri.source_code[1] in ['O', 'B'] and isNotBlankOwner2,
																		ri.mname,
																		le.owner3_mname
																	);
	self.owner3_cname					:=	if(	ri.source_code[1] in ['O', 'B'] and isNotBlankOwner2,
																		ri.cname,
																		le.owner3_cname
																	);
	self.owner3_did						:=	if(	ri.source_code[1] in ['O', 'B'] and isNotBlankOwner2,
																		ri.did,
																		le.owner3_did
																	);
	self.owner3_ssn						:=	if(	ri.source_code[1] in ['O', 'B'] and isNotBlankOwner2,
																		ri.app_ssn,
																		le.owner3_ssn
																	);
	
	self.owner4_fname					:=	if(	ri.source_code[1] in ['O', 'B'] and isNotBlankOwner3,
																		ri.fname,
																		le.owner4_fname
																	);
	self.owner4_lname					:=	if(	ri.source_code[1] in ['O', 'B'] and isNotBlankOwner3,
																		ri.lname,
																		le.owner4_lname
																	);
	self.owner4_mname					:=	if(	ri.source_code[1] in ['O', 'B'] and isNotBlankOwner3,
																		ri.mname,
																		le.owner4_mname
																	);
	self.owner4_cname					:=	if(	ri.source_code[1] in ['O', 'B'] and isNotBlankOwner3,
																		ri.cname,
																		le.owner4_cname
																	);
	self.owner4_did						:=	if(	ri.source_code[1] in ['O', 'B'] and isNotBlankOwner3,
																		ri.did,
																		le.owner4_did
																	);
	self.owner4_ssn						:=	if(	ri.source_code[1] in ['O', 'B'] and isNotBlankOwner3,
																		ri.app_ssn,
																		le.owner4_ssn
																	);
	
	self.seller1_fname				:=	if(	ri.source_code[1] = 'S' and isBlankSeller1,
																		ri.fname,
																		le.seller1_fname
																	);
	self.seller1_lname				:=	if(	ri.source_code[1] = 'S' and isBlankSeller1,
																		ri.lname,
																		le.seller1_lname
																	);
	self.seller1_mname				:=	if(	ri.source_code[1] = 'S' and isBlankSeller1,
																		ri.mname,
																		le.seller1_mname
																	);
	self.seller1_cname				:=	if(	ri.source_code[1] = 'S' and isBlankSeller1,
																		ri.cname,
																		le.seller1_cname
																	);
	self.seller1_did					:=	if(	ri.source_code[1] = 'S' and isBlankSeller1,
																		ri.did,
																		le.seller1_did
																	);
	self.seller1_ssn					:=	if(	ri.source_code[1] = 'S' and isBlankSeller1,
																		ri.app_ssn,
																		le.seller1_ssn
																	);
	
	self.seller2_fname				:=	if(	ri.source_code[1] = 'S' and isNotBlankSeller1,
																		ri.fname,
																		le.seller2_fname
																	);
	self.seller2_lname				:=	if(	ri.source_code[1] = 'S' and isNotBlankSeller1,
																		ri.lname,
																		le.seller2_lname
																	);
	self.seller2_mname				:=	if(	ri.source_code[1] = 'S' and isNotBlankSeller1,
																		ri.mname,
																		le.seller2_mname
																	);
	self.seller2_cname				:=	if(	ri.source_code[1] = 'S' and isNotBlankSeller1,
																		ri.cname,
																		le.seller2_cname
																	);
	self.seller2_did					:=	if(	ri.source_code[1] = 'S' and isNotBlankSeller1,
																		ri.did,
																		le.seller2_did
																	);
	self.seller2_ssn					:=	if(	ri.source_code[1] = 'S' and isNotBlankSeller1,
																		ri.app_ssn,
																		le.seller2_ssn
																	);
	
	self.seller3_fname				:=	if(	ri.source_code[1] = 'S' and isNotBlankSeller2,
																		ri.fname,
																		le.seller3_fname
																	);
	self.seller3_lname				:=	if(	ri.source_code[1] = 'S' and isNotBlankSeller2,
																		ri.lname,
																		le.seller3_lname
																	);
	self.seller3_mname				:=	if(	ri.source_code[1] = 'S' and isNotBlankSeller2,
																		ri.mname,
																		le.seller3_mname
																	);
	self.seller3_cname				:=	if(	ri.source_code[1] = 'S' and isNotBlankSeller2,
																		ri.cname,
																		le.seller3_cname
																	);
	self.seller3_did					:=	if(	ri.source_code[1] = 'S' and isNotBlankSeller2,
																		ri.did,
																		le.seller3_did
																	);
	self.seller3_ssn					:=	if(	ri.source_code[1] = 'S' and isNotBlankSeller2,
																		ri.app_ssn,
																		le.seller3_ssn
																	);
	
	self.seller4_fname				:=	if(	ri.source_code[1] = 'S' and isNotBlankSeller3,
																		ri.fname,
																		le.seller4_fname
																	);
	self.seller4_lname				:=	if(	ri.source_code[1] = 'S' and isNotBlankSeller3,
																		ri.lname,
																		le.seller4_lname
																	);
	self.seller4_mname				:=	if(	ri.source_code[1] = 'S' and isNotBlankSeller3,
																		ri.mname,
																		le.seller4_mname
																	);
	self.seller4_cname				:=	if(	ri.source_code[1] = 'S' and isNotBlankSeller3,
																		ri.cname,
																		le.seller4_cname
																	);
	self.seller4_did					:=	if(	ri.source_code[1] = 'S' and isNotBlankSeller3,
																		ri.did,
																		le.seller4_did
																	);
	self.seller4_ssn					:=	if(	ri.source_code[1] = 'S' and isNotBlankSeller3,
																		ri.app_ssn,
																		le.seller4_ssn
																	);

	self											:=	le;
end;

dSearch_DenormName	:=	denormalize(dSearch_AppendCleanNameAddr_dedup,
																		dSearch(source_code[2] = 'P'),
																		left.ln_fares_id	=	right.ln_fares_id,
																		tSearch_DenormName(left, right),
																		local
																	 ) : persist('persist::property::search_denorm_name');

output(dSearch_DenormName,named('Search_denorm_name'));

// Denormalize address
rSrchAppendClnNameAddr_layout	tSearch_DenormNameAddr(dSearch_DenormName le, dSearch ri)	:=
transform
	boolean isBlank(string pStr)	:=	pStr = '';
	boolean	isBlankPropAddr				:=	isBlank(trim(le.property_prim_range, left, right)	+
																						trim(le.property_prim_name, left, right)	+
																						trim(le.property_predir, left, right)			+
																						trim(le.property_postdir, left, right)		+
																						trim(le.property_sec_range, left, right)	+
																						trim(le.property_city_name, left, right)	+
																						trim(le.property_zip, left, right)
																						);

	boolean	isBlankMailAddr				:=	isBlank(trim(le.mail_prim_range, left, right)	+
																						trim(le.mail_prim_name, left, right)	+
																						trim(le.mail_predir, left, right)			+
																						trim(le.mail_postdir, left, right)		+
																						trim(le.mail_sec_range, left, right)	+
																						trim(le.mail_city_name, left, right)	+
																						trim(le.mail_zip, left, right)
																						);
	
	self.property_prim_range	:=	if(	isBlankPropAddr and ri.source_code[1] in ['B', 'O'] and ri.source_code[2] = 'P',
																		ri.prim_range,
																		le.property_prim_range
																	);
	self.property_predir			:=	if(	isBlankPropAddr and ri.source_code[1] in ['B', 'O'] and ri.source_code[2] = 'P',
																		ri.predir,
																		le.property_predir
																	);
	self.property_prim_name		:=	if(	isBlankPropAddr and ri.source_code[1] in ['B', 'O'] and ri.source_code[2] = 'P',
																		ri.prim_name,
																		le.property_prim_name
																	);
	self.property_addr_suffix	:=	if(	isBlankPropAddr and ri.source_code[1] in ['B', 'O'] and ri.source_code[2] = 'P',
																		ri.suffix,
																		le.property_addr_suffix
																	);
	self.property_postdir			:=	if(	isBlankPropAddr and ri.source_code[1] in ['B', 'O'] and ri.source_code[2] = 'P',
																		ri.postdir,
																		le.property_postdir
																	);
	self.property_unit_desig	:=	if(	isBlankPropAddr and ri.source_code[1] in ['B', 'O'] and ri.source_code[2] = 'P',
																		ri.unit_desig,
																		le.property_unit_desig
																	);
	self.property_sec_range		:=	if(	isBlankPropAddr and ri.source_code[1] in ['B', 'O'] and ri.source_code[2] = 'P',
																		ri.sec_range,
																		le.property_sec_range
																	);
	self.property_city_name		:=	if(	isBlankPropAddr and ri.source_code[1] in ['B', 'O'] and ri.source_code[2] = 'P',
																		ri.p_city_name,
																		le.property_city_name
																	);
	self.property_st					:=	if(	isBlankPropAddr and ri.source_code[1] in ['B', 'O'] and ri.source_code[2] = 'P',
																		ri.st,
																		le.property_st
																	);
	self.property_zip					:=	if(	isBlankPropAddr and ri.source_code[1] in ['B', 'O'] and ri.source_code[2] = 'P',
																		ri.zip,
																		le.property_zip
																	);
	self.property_zip4				:=	if(	isBlankPropAddr and ri.source_code[1] in ['B', 'O'] and ri.source_code[2] = 'P',
																		ri.zip4,
																		le.property_zip4
																	);
	
	self.mail_prim_range			:=	if(	isBlankMailAddr and ri.source_code[1] in ['B', 'O'] and ri.source_code[2] in ['B', 'O'],
																		ri.prim_range,
																		le.mail_prim_range
																	);
	self.mail_predir					:=	if(	isBlankMailAddr and ri.source_code[1] in ['B', 'O'] and ri.source_code[2] in ['B', 'O'],
																		ri.predir,
																		le.mail_predir
																	);
	self.mail_prim_name				:=	if(	isBlankMailAddr and ri.source_code[1] in ['B', 'O'] and ri.source_code[2] in ['B', 'O'],
																		ri.prim_name,
																		le.mail_prim_name
																	);
	self.mail_addr_suffix			:=	if(	isBlankMailAddr and ri.source_code[1] in ['B', 'O'] and ri.source_code[2] in ['B', 'O'],
																		ri.suffix,
																		le.mail_addr_suffix
																	);
	self.mail_postdir					:=	if(	isBlankMailAddr and ri.source_code[1] in ['B', 'O'] and ri.source_code[2] in ['B', 'O'],
																		ri.postdir,
																		le.mail_postdir
																	);
	self.mail_unit_desig			:=	if(	isBlankMailAddr and ri.source_code[1] in ['B', 'O'] and ri.source_code[2] in ['B', 'O'],
																		ri.unit_desig,
																		le.mail_unit_desig
																	);
	self.mail_sec_range				:=	if(	isBlankMailAddr and ri.source_code[1] in ['B', 'O'] and ri.source_code[2] in ['B', 'O'],
																		ri.sec_range,
																		le.mail_sec_range
																	);
	self.mail_city_name				:=	if(	isBlankMailAddr and ri.source_code[1] in ['B', 'O'] and ri.source_code[2] in ['B', 'O'],
																		ri.p_city_name,
																		le.mail_city_name
																	);
	self.mail_st							:=	if(	isBlankMailAddr and ri.source_code[1] in ['B', 'O'] and ri.source_code[2] in ['B', 'O'],
																		ri.st,
																		le.mail_st
																	);
	self.mail_zip							:=	if(	isBlankMailAddr and ri.source_code[1] in ['B', 'O'] and ri.source_code[2] in ['B', 'O'],
																		ri.zip,
																		le.mail_zip
																	);
	self.mail_zip4						:=	if(	isBlankMailAddr and ri.source_code[1] in ['B', 'O'] and ri.source_code[2] in ['B', 'O'],
																		ri.zip4,
																		le.mail_zip4
																	);
	
	self											:=	le;
end;

dSearch_DenormNameAddr	:=	denormalize(dSearch_DenormName,
																				dSearch,
																				left.ln_fares_id	=	right.ln_fares_id,
																				tSearch_DenormNameAddr(left, right),
																				local
																			 ) : persist('persist::property::search_denorm_name_address');

output(dSearch_DenormNameAddr,named('Search_denorm_name_address'));

// Get assessment clean name and address by joining to the search file
dAssesCodesLkp	:=	distribute(dAssesRoofTypeCodeLkp,hash(ln_fares_id));

layout_assets.response.rAssesAppendClnNameAddr_layout	tAsses_CleanNameAddr(dAssesCodesLkp le, dSearch_DenormNameAddr ri)	:=
transform
	self	:=	ri;
	self	:=	le;
end;

dAsses_CleanNameAddr	:=	join(	dAssesCodesLkp,
																dSearch_DenormNameAddr,
																left.ln_fares_id	=	right.ln_fares_id,
																tAsses_CleanNameAddr(left, right),
																local
															) : persist('persist::property::assess_clean');

output(dAsses_CleanNameAddr,named('Asses_clean_name_address'));

// Get deed clean name and address by joining to the search file
dDeedsCodesLkp	:=	distribute(dDeedsDocumentTypeCodeLkp,hash(ln_fares_id));

layout_assets.response.rDeedsAppendClnNameAddr_layout	tDeeds_CleanNameAddr(dDeedsCodesLkp le, dSearch_DenormNameAddr ri)	:=
transform
	self	:=	ri;
	self	:=	le;
end;

dDeeds_CleanNameAddr	:=	join(	dDeedsCodesLkp,
																dSearch_DenormNameAddr,
																left.ln_fares_id	=	right.ln_fares_id,
																tDeeds_CleanNameAddr(left, right),
																local
															) : persist('persist::property::deeds_clean');

output(dDeeds_CleanNameAddr,named('Deeds_clean_name_address'));
*/


// Assessment and deeds file with appended clean name and addresses
dAsses_CleanNameAddr			:=	dataset	(	'~thor400_84::persist::property::assess_clean',
																				layout_assets.response.rAssesAppendClnNameAddr_layout,
																				thor
																			);

dDeeds_CleanNameAddr			:=	dataset	(	'~thor400_84::persist::property::deeds_clean',
																				layout_assets.response.rDeedsAppendClnNameAddr_layout,
																				thor
																			);

// get all zip code matches from the search file
dSearchFDSZips			:=	dSearch(zip	in	zipcodeset);

// Append priority indicator to each fares_id
rAppendPriorityInd	:=
record
	dSearch;
	unsigned2	zipSeq	:=	0;
	string1		propInd	:=	'';
end;

dFDSZipsAppendInd	:=	project(dSearchFDSZips,transform(rAppendPriorityInd,self	:=	left));

// dFDSZipsAppendInd_dist	:=	distribute(dFDSZipsAppendInd,hash(zip));
dFDSZipsAppendInd_sort	:=	sort(dFDSZipsAppendInd,zip);

rAppendPriorityInd	tAppendPriorityInd(dFDSZipsAppendInd_sort le, dFDSZipsAppendInd_sort ri)	:=
transform
	self.propInd	:=	if(	ri.source_code[2]	=	'P',
												'P',
												''
											);
	self.zipSeq		:=	if(	le.zip	!=	ri.zip,
												le.zipSeq	+	1,
												le.zipSeq
												);
	self					:=	ri;
end;

dSearchFDSZip_Iterate	:=	iterate(	dFDSZipsAppendInd_sort,
																		tAppendPriorityInd(left,right)
																	);

// output(choosen(dSearchFDSZip_Iterate,1000),named('zip_grp_ind'));

// remove duplicate fares_id
dSearchFDSZip_Iterate_dist	:=	distribute(	dSearchFDSZip_Iterate,
																						hash(ln_fares_id)
																					);

dSearchFDSZip_Iterate_sort	:=	sort(	dSearchFDSZip_Iterate_dist,
																			ln_fares_id,
																			zipSeq,
																			-propInd,
																			local
																		);

dSearchFDSZip_Iterate_dedup	:=	dedup(	dSearchFDSZip_Iterate_sort,
																				ln_fares_id,
																				local
																			);

// Join to assessment denormalized file
dAsses_CleanNameAddr_Dist	:=	distribute(	dAsses_CleanNameAddr(			(owner1_lname	!=	''					or	owner1_cname	!=	'')
																																and	(property_zip	in	zipcodeset	or	mail_zip	in	zipcodeset)
																															),
																					hash(ln_fares_id)
																				);

rAssesMatch_layout	:=
record
	dAsses_CleanNameAddr;
	string1		propInd;
	unsigned2	zipSeq;
end;

rAssesMatch_layout	tAssesMatch(dAsses_CleanNameAddr_Dist le,dSearchFDSZip_Iterate_dedup ri)	:=
transform
	self	:=	le;
	self	:=	ri;
end;

dAssesMatchZip	:=	join(dAsses_CleanNameAddr_Dist,
													dSearchFDSZip_Iterate_dedup,
													left.ln_fares_id	=	right.ln_fares_id,
													tAssesMatch(left,right),
													local
												);

// Join to deeds denormalized file
dDeeds_CleanNameAddr_Dist	:=	distribute(	dDeeds_CleanNameAddr(			(owner1_lname	!=	''					or	owner1_cname	!=	'')
																																and	(property_zip	in	zipcodeset	or	mail_zip	in	zipcodeset)
																															),
																					hash(ln_fares_id)
																				);
rDeedsMatch_layout	:=
record
	dDeeds_CleanNameAddr;
	string1		propInd;
	unsigned2	zipSeq;
end;

rDeedsMatch_layout	tDeedsMatch(dDeeds_CleanNameAddr_Dist le,dSearchFDSZip_Iterate_dedup ri)	:=
transform
	self	:=	le;
	self	:=	ri;
end;

dDeedsMatchZip	:=	join(dDeeds_CleanNameAddr_Dist,
													dSearchFDSZip_Iterate_dedup,
													left.ln_fares_id	=	right.ln_fares_id,
													tDeedsMatch(left,right),
													local
												);

// Create FDS property extract
dAssesMatchZip_Dist	:=	distribute(	dAssesMatchZip(			(owner1_lname	!=	''	or	owner1_cname	!=	'')
																										and	(property_zip	!=	'')
																									),
																		hash(	fips_code,
																					fares_unformatted_apn,
																					property_prim_range,
																					property_prim_name,
																					property_zip
																				)
																	);

dDeedsMatchZip_Dist	:=	distribute(	dDeedsMatchZip(			(owner1_lname	!=	''	or	owner1_cname	!=	'')
																										and	(property_zip	!=	'')
																									),
																		hash(	fips_code,
																					fares_unformatted_apn,
																					property_prim_range,
																					property_prim_name,
																					property_zip
																				)
																	);

rZipPropertyExtract_layout	:=
record,maxlength(8192)
	string	record_id;
	string	asses_fares_id;
	string	deeds_fares_id;
	string	priorityInd;
	string	propInd;
	integer	zipSeq;
	string	owner1_first_name;
	string	owner1_last_name;
	string	owner1_middle_name;
	string	owner1_company_name;
	string	owner2_first_name;
	string	owner2_last_name;
	string	owner2_middle_name;
	string	owner2_company_name;
	string	property_street_address;
	string	property_street_address2;
	string	property_city;
	string	property_state;
	string	property_zip;
	string	mailing_street_address;
	string	mailing_street_address2;
	string	mailing_city;
	string	mailing_state;
	string	mailing_zip;
	string	indicator_addresses_same;
	string	phone;
	string	business_indicator;
	string	tax_year;
	string	assessed_value_year;
	string	recording_date;
	string	contract_date;
	string	lender_name;
	string	title_company;
	string	county;
	string	parcel_number;
	string	assessed_value;
	string	homeowner_exempt;
	string	tax_amount;
	string	improvement_value;
	string	sale_date;
	string	sale_amount;
	string	first_loan_amount;
	string	loan_type;
	string	seller_first_name;
	string	seller_last_name;
	string	seller_middle_name;
	string	seller_company_name;
	string	sale_doc_number;
	string	transaction;
	string	second_loan_amount;
	string	deed_description;
	string	mortgage_due_date;
	string	standard_use_description;
	string	year_built;
	string	number_of_units;
	string	number_fireplaces;
	string	garage;
	string	number_of_garage_stalls;
	string	construction_desc;
	string	effective_year_built;
	string	number_of_stories;
	string	pool_indicator;
	string	number_of_bedrooms;
	string	roofing_description;
	string	garage_sq_feet;
	string	basement_sq_feet;
	string	total_sq_feet;
	string	heating_detail;
	string	number_of_rooms;
	string	number_of_baths;
	string	cooling_detail;
	string	lot_size;
	string	lot_depth;
	string	tract_number;
	string	lot_number;
	string	township;
	string	subdivision_name;
	string	lot_width;
	string	zoning;
	string	block_number;
	string	district;
	string	section;
end;

rZipPropertyExtract_layout	tPropertyExtract(dAssesMatchZip_Dist le, dDeedsMatchZip_Dist ri)	:=
transform
	self.record_id									:=	'';
	self.asses_fares_id						:=	le.ln_fares_id;
	self.deeds_fares_id						:=	ri.ln_fares_id;
	self.propInd										:=	if(	le.propInd	=	'P'	or	ri.propInd	=	'P',
																					'P',
																					''
																				);
	self.zipSeq											:=	if(	le.zipSeq	!=	0	and	ri.zipSeq	!=	0	and	le.zipSeq	<=	ri.zipSeq,
																					le.zipSeq,
																					if(	le.zipSeq	!=	0	and	ri.zipSeq	!=	0	and	le.zipSeq	>	ri.zipSeq,
																							ri.zipSeq,
																							if(le.zipSeq	!=	0,le.ZipSeq,ri.zipSeq)
																						)
																				);
	self.priorityInd								:=	if(			(self.asses_fares_id	!=	''	and	self.deeds_fares_id	!=	''	and	ri.propInd	!=	'')
																					or	(self.asses_fares_id	=		''	and	self.deeds_fares_id	!=	''	and	ri.propInd	!=	''),
																					'PD',
																					if(			(self.asses_fares_id	!=	''	and	self.deeds_fares_id	!=	''	and	le.propInd	!=	''	and ri.propInd	=	'')
																							or	(self.asses_fares_id	!=	''	and	self.deeds_fares_id	=		''	and	le.propInd	!=	''),
																							'PA',
																							if(			(self.asses_fares_id	!=	''	and	self.deeds_fares_id	!=	''	and	ri.propInd	=	''	and le.propInd	=	'')
																									or	(self.asses_fares_id	=		''	and	self.deeds_fares_id	!=	''	and	ri.propInd	=	''),
																									'D',
																									'A'
																								)
																						)
																				);
	self.owner1_first_name					:=	if(le.owner1_fname != '', le.owner1_fname, ri.owner1_fname);
	self.owner1_last_name						:=	if(le.owner1_lname != '', le.owner1_lname, ri.owner1_lname);
	self.owner1_middle_name					:=	if(le.owner1_mname != '', le.owner1_mname, ri.owner1_mname);
	self.owner1_company_name				:=	if(le.owner1_cname != '', le.owner1_cname, ri.owner1_cname);
	self.owner2_first_name					:=	if(le.owner2_fname != '', le.owner2_fname, ri.owner2_fname);
	self.owner2_last_name						:=	if(le.owner2_lname != '', le.owner2_lname, ri.owner2_lname);
	self.owner2_middle_name					:=	if(le.owner2_mname != '', le.owner2_mname, ri.owner2_mname);
	self.owner2_company_name				:=	if(le.owner2_cname != '', le.owner2_cname, ri.owner2_cname);
	self.property_street_address		:=	trim(Address.Addr1FromComponents(	le.property_prim_range,
																																				le.property_predir,
																																				le.property_prim_name,
																																				le.property_addr_suffix,
																																				le.property_postdir,
																																				'',
																																				''
																																			),
																						left,
																						right
																					);
	self.property_street_address2		:=	trim(Address.Addr1FromComponents(	le.property_unit_desig,
																																				le.property_sec_range,
																																				'',
																																				'',
																																				'',
																																				'',
																																				''
																																			),
																						left,
																						right
																					);
	self.property_city							:=	if(le.property_city_name != '', le.property_city_name, ri.property_city_name);
	self.property_state							:=	if(le.property_st != '', le.property_st, ri.property_st);
	self.property_zip								:=	if(le.property_zip != '', le.property_zip, ri.property_zip);
	self.mailing_street_address			:=	trim(Address.Addr1FromComponents(	le.mail_prim_range,
																																				le.mail_predir,
																																				le.mail_prim_name,
																																				le.mail_addr_suffix,
																																				le.mail_postdir,
																																				'',
																																				''
																																			),
																						left,
																						right
																					);
	self.mailing_street_address2		:=	trim(Address.Addr1FromComponents(	le.mail_unit_desig,
																																				le.mail_sec_range,
																																				'',
																																				'',
																																				'',
																																				'',
																																				''
																																			),
																						left,
																						right
																					);
	self.mailing_city								:=	if(le.mail_city_name != '', le.mail_city_name, ri.mail_city_name);
	self.mailing_state							:=	if(le.mail_st != '', le.mail_st, ri.mail_st);
	self.mailing_zip								:=	if(le.mail_zip != '', le.mail_zip, ri.mail_zip);
	self.indicator_addresses_same		:=	if(	trim(self.property_street_address)	+
																					trim(self.property_street_address2)	+
																					trim(self.property_city)						+
																					trim(self.property_state)						+
																					trim(self.property_zip)
																					=
																					trim(self.mailing_street_address)		+
																					trim(self.mailing_street_address2)	+
																					trim(self.mailing_city)							+
																					trim(self.mailing_state)						+
																					trim(self.mailing_zip),
																					'Y',
																					'N'
																				);
	self.phone											:=	if(le.assessee_phone_number != '', le.assessee_phone_number, ri.phone_number);
	self.business_indicator					:=	if(self.owner1_company_name != '' or self.owner2_company_name != '', 'Y', 'N');
	self.lender_name								:=	ri.lender_name;
	self.title_company							:=	ri.title_company_name;
	self.county											:=	if(le.county_name != '', le.county_name, ri.county_name);
	self.parcel_number							:=	if(le.apna_or_pin_number != '', le.apna_or_pin_number, ri.apnt_or_pin_number);
	self.assessed_value							:=	le.assessed_total_value;
	self.homeowner_exempt						:=	le.homestead_homeowner_exemption;
	self.tax_amount									:=	le.tax_amount;
	self.improvement_value					:=	le.assessed_improvement_value;
	self.sale_date									:=	ri.contract_date[5..8] + ri.contract_date[1..4];
	self.sale_amount								:=	ri.sales_price;
	self.first_loan_amount					:=	ri.first_td_loan_amount;
	self.loan_type									:=	ri.loan_type_description;
	self.seller_first_name					:=	ri.seller1_fname;
	self.seller_last_name						:=	ri.seller1_lname;
	self.seller_middle_name					:=	ri.seller1_mname;
	self.seller_company_name				:=	ri.seller1_cname;
	self.sale_doc_number						:=	ri.document_number;
	self.transaction								:=	ri.document_type_description;
	self.second_loan_amount					:=	ri.second_td_loan_amount;
	self.deed_description						:=	ri.legal_brief_description;
	self.mortgage_due_date					:=	ri.first_td_due_date[5..8] + ri.first_td_due_date[1..4];
	self.standard_use_description		:=	le.standard_use_description;
	self.year_built									:=	le.year_built;
	self.number_of_units						:=	le.no_of_units;
	self.number_fireplaces					:=	le.fireplace_number;
	self.garage											:=	le.garage_description;
	self.number_of_garage_stalls		:=	le.parking_no_of_cars;
	self.construction_desc					:=	le.construction_description;
	self.effective_year_built				:=	le.effective_year_built;
	self.number_of_stories					:=	le.no_of_stories;
	self.pool_indicator							:=	if(le.pool_code != '', 'Y', '');
	self.number_of_bedrooms					:=	le.no_of_bedrooms;
	self.roofing_description				:=	le.roofing_description;
	self.garage_sq_feet							:=	map(	le.vendor_source_flag	=	'OKCTY'	and	le.building_area_indicator[1]		=	'G'	=>	le.building_area,
																						le.vendor_source_flag	=	'OKCTY'	and	le.building_area1_indicator[1]	=	'G'	=>	le.building_area1,
																						le.vendor_source_flag	=	'OKCTY'	and	le.building_area2_indicator[1]	=	'G'	=>	le.building_area2,
																						le.vendor_source_flag	=	'OKCTY'	and	le.building_area3_indicator[1]	=	'G'	=>	le.building_area3,
																						le.vendor_source_flag	=	'OKCTY'	and	le.building_area4_indicator[1]	=	'G'	=>	le.building_area4,
																						le.vendor_source_flag	=	'OKCTY'	and	le.building_area5_indicator[1]	=	'G'	=>	le.building_area5,
																						le.vendor_source_flag	=	'OKCTY'	and	le.building_area6_indicator[1]	=	'G'	=>	le.building_area6,
																						le.vendor_source_flag	=	'OKCTY'	and	le.building_area7_indicator[1]	=	'G'	=>	le.building_area7,
																						''
																					);
	self.basement_sq_feet						:=	map(	le.vendor_source_flag	=	'OKCTY'	and	le.building_area_indicator[1]		=	'W'	=>	le.building_area,
																						le.vendor_source_flag	=	'OKCTY'	and	le.building_area1_indicator[1]	=	'W'	=>	le.building_area1,
																						le.vendor_source_flag	=	'OKCTY'	and	le.building_area2_indicator[1]	=	'W'	=>	le.building_area2,
																						le.vendor_source_flag	=	'OKCTY'	and	le.building_area3_indicator[1]	=	'W'	=>	le.building_area3,
																						le.vendor_source_flag	=	'OKCTY'	and	le.building_area4_indicator[1]	=	'W'	=>	le.building_area4,
																						le.vendor_source_flag	=	'OKCTY'	and	le.building_area5_indicator[1]	=	'W'	=>	le.building_area5,
																						le.vendor_source_flag	=	'OKCTY'	and	le.building_area6_indicator[1]	=	'W'	=>	le.building_area6,
																						le.vendor_source_flag	=	'OKCTY'	and	le.building_area7_indicator[1]	=	'W'	=>	le.building_area7,
																						le.vendor_source_flag	=	'FAR_F'	and	le.building_area_indicator[1]		=	'R'	=>	le.building_area,
																						le.vendor_source_flag	=	'FAR_F'	and	le.building_area1_indicator[1]	=	'R'	=>	le.building_area1,
																						le.vendor_source_flag	=	'FAR_F'	and	le.building_area2_indicator[1]	=	'R'	=>	le.building_area2,
																						le.vendor_source_flag	=	'FAR_F'	and	le.building_area3_indicator[1]	=	'R'	=>	le.building_area3,
																						le.vendor_source_flag	=	'FAR_F'	and	le.building_area4_indicator[1]	=	'R'	=>	le.building_area4,
																						le.vendor_source_flag	=	'FAR_F'	and	le.building_area5_indicator[1]	=	'R'	=>	le.building_area5,
																						le.vendor_source_flag	=	'FAR_F'	and	le.building_area6_indicator[1]	=	'R'	=>	le.building_area6,
																						le.vendor_source_flag	=	'FAR_F'	and	le.building_area7_indicator[1]	=	'R'	=>	le.building_area7,
																						''
																					);
	self.total_sq_feet							:=	map(	le.vendor_source_flag	=	'OKCTY'	and	le.building_area_indicator[1]		=	'T'	=>	le.building_area,
																						le.vendor_source_flag	=	'OKCTY'	and	le.building_area1_indicator[1]	=	'T'	=>	le.building_area1,
																						le.vendor_source_flag	=	'OKCTY'	and	le.building_area2_indicator[1]	=	'T'	=>	le.building_area2,
																						le.vendor_source_flag	=	'OKCTY'	and	le.building_area3_indicator[1]	=	'T'	=>	le.building_area3,
																						le.vendor_source_flag	=	'OKCTY'	and	le.building_area4_indicator[1]	=	'T'	=>	le.building_area4,
																						le.vendor_source_flag	=	'OKCTY'	and	le.building_area5_indicator[1]	=	'T'	=>	le.building_area5,
																						le.vendor_source_flag	=	'OKCTY'	and	le.building_area6_indicator[1]	=	'T'	=>	le.building_area6,
																						le.vendor_source_flag	=	'OKCTY'	and	le.building_area7_indicator[1]	=	'T'	=>	le.building_area7,
																						le.vendor_source_flag	=	'FAR_F'	and	le.building_area_indicator[1]		=	'B'	=>	le.building_area,
																						le.vendor_source_flag	=	'FAR_F'	and	le.building_area1_indicator[1]	=	'B'	=>	le.building_area1,
																						le.vendor_source_flag	=	'FAR_F'	and	le.building_area2_indicator[1]	=	'B'	=>	le.building_area2,
																						le.vendor_source_flag	=	'FAR_F'	and	le.building_area3_indicator[1]	=	'B'	=>	le.building_area3,
																						le.vendor_source_flag	=	'FAR_F'	and	le.building_area4_indicator[1]	=	'B'	=>	le.building_area4,
																						le.vendor_source_flag	=	'FAR_F'	and	le.building_area5_indicator[1]	=	'B'	=>	le.building_area5,
																						le.vendor_source_flag	=	'FAR_F'	and	le.building_area6_indicator[1]	=	'B'	=>	le.building_area6,
																						le.vendor_source_flag	=	'FAR_F'	and	le.building_area7_indicator[1]	=	'B'	=>	le.building_area7,
																						''
																					);
	self.heating_detail							:=	le.heating_description;
	self.number_of_rooms						:=	le.no_of_rooms;
	self.number_of_baths						:=	le.no_of_baths;
	self.cooling_detail							:=	le.cooling_description;
	self.lot_size										:=	if(le.lot_size != '', le.lot_size, ri.land_lot_size);
	self.lot_depth									:=	le.lot_size_depth_feet;
	self.tract_number								:=	if(le.legal_tract_number != '', le.legal_tract_number, ri.legal_tract_number);
	self.lot_number									:=	if(le.legal_lot_number != '', le.legal_lot_number, ri.legal_lot_number);
	self.township										:=	if(le.legal_city_municipality_township != '', le.legal_city_municipality_township, ri.legal_city_municipality_township);
	self.subdivision_name						:=	if(le.legal_subdivision_name != '', le.legal_subdivision_name, ri.legal_subdivision_name);
	self.lot_width									:=	le.lot_size_frontage_feet;
	self.zoning											:=	le.zoning;
	self.block_number								:=	if(le.legal_block != '', le.legal_block, ri.legal_block);
	self.district										:=	if(le.legal_district != '', le.legal_district, ri.legal_district);
	self.section										:=	if(le.legal_section != '', le.legal_section, ri.legal_section);
	self														:=	le;
	self														:=	ri;
end;

dPropertyExtract	:=	join(	dAssesMatchZip_Dist,
														dDeedsMatchZip_Dist,
														ut.NNEQ(left.fares_unformatted_apn, right.fares_unformatted_apn)	and
														left.fips_code						=	right.fips_code												and
														left.property_prim_name		=	right.property_prim_name							and
														left.property_prim_range	=	right.property_prim_range							and
														left.property_sec_range		=	right.property_sec_range							and
														left.property_zip					=	right.property_zip										and
														(
															(	trim(left.owner1_fname)		+ trim(left.owner1_lname)		+ trim(left.owner1_mname)
																=
																trim(right.owner1_fname)	+ trim(right.owner1_lname)	+ trim(right.owner1_mname)
															)
															or
															(	trim(left.owner1_fname)		+ trim(left.owner1_lname)		+ trim(left.owner1_mname)
																=
																trim(right.owner2_fname)	+ trim(right.owner2_lname)	+ trim(right.owner2_mname)
															)
															or
															(	trim(left.owner2_fname)		+ trim(left.owner2_lname)		+ trim(left.owner2_mname)
																=
																trim(right.owner1_fname)	+ trim(right.owner1_lname)	+ trim(right.owner1_mname)
															)
															or
															(	trim(left.owner2_fname)		+ trim(left.owner2_lname)		+ trim(left.owner2_mname)
																=
																trim(right.owner2_fname)	+ trim(right.owner2_lname)	+ trim(right.owner2_mname)
															)
														),
														tPropertyExtract(left, right),
														full outer,
														local
													) : persist('persist::property::zipextract1');

output(choosen(dPropertyExtract,1000),named('Property_Zip_Extract'));

// dPropertyExtract	:=	dZipPropertyExtract(property_zip in zipcodeSet or mailing_zip in zipcodeset);

dPropertyExtract_dist		:=	distribute(dPropertyExtract, hash(property_street_address,
																															property_street_address2,
																															property_city,
																															property_state,
																															property_zip
																															)
																			);

dPropertyExtract_sort		:=	sort(	dPropertyExtract_dist,
																	property_street_address,
																	property_street_address2,
																	property_city,
																	property_state,
																	property_zip,
																	-propInd,
																	-priorityInd,
																	-recording_date,
																	-contract_date,
																	-tax_year,
																	-assessed_value_year,
																	local
																);

dPropertyExtract_dedup	:=	dedup(dPropertyExtract_sort,
																	property_street_address,
																	property_street_address2,
																	property_city,
																	property_state,
																	property_zip,
																	keep 5,
																	local
																);

dPropertyExtract_ZipSort	:=	sort(distribute(dPropertyExtract_dedup,hash(zipSeq,property_zip)),zipSeq,property_zip,local);

// Assign record_id
layout_assets.response.rFDSProperty_layout	tAssignRecordID(dPropertyExtract_dedup pInput,integer cnt)	:=
transform
	self.record_id	:=	(string)cnt;
	self						:=	pInput;
end;

dFDSPropertyExtract			:=	project(dPropertyExtract_ZipSort,tAssignRecordID(left,counter));

output(choosen(dFDSPropertyExtract,1000),named('Property_FDS_Extract_QA'));

outFDSPropertyExtract_fixed		:=	output	(	dFDSPropertyExtract,,
																						'~thor_data400::out::fds_test::assets::property_extract_fixed1',
																						overwrite,
																						__compressed__
																					);

outFDSPropertyExtract				:=	output	(	dFDSPropertyExtract,,
																					'~thor_data400::out::fds_test::assets::property_extract1',
																					csv(heading(single),separator('|'),terminator('\n')),
																					overwrite,
																					__compressed__
																				);

// population counts for all fields
rStats_layout	:=
record
	string3	statGroup										:=	'ALL';
	cntTotal														:=	count(group);
	cntRecordID_CountNonBlank						:=	sum(group,if(dFDSPropertyExtract.Record_ID								!=	'',1,0));
	cntOwner1_FirstName_CountNonBlank		:=	sum(group,if(dFDSPropertyExtract.Owner1_First_Name				!=	'',1,0));
	cntOwner1_MiddleName_CountNonBlank	:=	sum(group,if(dFDSPropertyExtract.Owner1_Middle_Name				!=	'',1,0));
	cntOwner1_LastName_CountNonBlank		:=	sum(group,if(dFDSPropertyExtract.Owner1_Last_Name					!=	'',1,0));
	cntOwner1_CompanyName_CountNonBlank	:=	sum(group,if(dFDSPropertyExtract.Owner1_Company_Name			!=	'',1,0));
	cntOwner2_FirstName_CountNonBlank		:=	sum(group,if(dFDSPropertyExtract.Owner2_First_Name				!=	'',1,0));
	cntOwner2_MiddleName_CountNonBlank	:=	sum(group,if(dFDSPropertyExtract.Owner2_Middle_Name				!=	'',1,0));
	cntOwner2_LastName_CountNonBlank		:=	sum(group,if(dFDSPropertyExtract.Owner2_Last_Name					!=	'',1,0));
	cntOwner2_CompanyName_CountNonBlank	:=	sum(group,if(dFDSPropertyExtract.Owner2_Company_Name			!=	'',1,0));
	cntPropStAddr1_CountNonBlank				:=	sum(group,if(dFDSPropertyExtract.Property_Street_Address	!=	'',1,0));
	cntPropStAddr2_CountNonBlank				:=	sum(group,if(dFDSPropertyExtract.Property_Street_Address2	!=	'',1,0));
	cntPropCity_CountNonBlank						:=	sum(group,if(dFDSPropertyExtract.Property_City						!=	'',1,0));
	cntPropState_CountNonBlank					:=	sum(group,if(dFDSPropertyExtract.Property_State						!=	'',1,0));
	cntPropZip_CountNonBlank						:=	sum(group,if(dFDSPropertyExtract.Property_Zip							!=	'',1,0));
	cntMailStAddr1_CountNonBlank				:=	sum(group,if(dFDSPropertyExtract.Mailing_Street_Address		!=	'',1,0));
	cntMailStAddr2_CountNonBlank				:=	sum(group,if(dFDSPropertyExtract.Mailing_Street_Address2	!=	'',1,0));
	cntMailCity_CountNonBlank						:=	sum(group,if(dFDSPropertyExtract.Mailing_City							!=	'',1,0));
	cntMailState_CountNonBlank					:=	sum(group,if(dFDSPropertyExtract.Mailing_State						!=	'',1,0));
	cntMailZip_CountNonBlank						:=	sum(group,if(dFDSPropertyExtract.Mailing_Zip							!=	'',1,0));
	cntAddrSameInd_CountNonBlank				:=	sum(group,if(dFDSPropertyExtract.Indicator_Addresses_Same	!=	'',1,0));
	cntPhone_CountNonBlank							:=	sum(group,if(dFDSPropertyExtract.Phone										!=	'',1,0));
	cntBusInd_CountNonBlank							:=	sum(group,if(dFDSPropertyExtract.Business_Indicator				!=	'',1,0));
	cntLenderName_CountNonBlank					:=	sum(group,if(dFDSPropertyExtract.Lender_Name							!=	'',1,0));
	cntTitleCompany_CountNonBlank				:=	sum(group,if(dFDSPropertyExtract.Title_Company						!=	'',1,0));
	cntCounty_CountNonBlank							:=	sum(group,if(dFDSPropertyExtract.County										!=	'',1,0));
	cntParcelNumber_CountNonBlank				:=	sum(group,if(dFDSPropertyExtract.Parcel_Number						!=	'',1,0));
	cntAssesedVal_CountNonBlank					:=	sum(group,if(dFDSPropertyExtract.Assessed_Value						!=	'',1,0));
	cntHomeOwnerExempt_CountNonBlank		:=	sum(group,if(dFDSPropertyExtract.Homeowner_Exempt					!=	'',1,0));
	cntTaxAmt_CountNonBlank							:=	sum(group,if(dFDSPropertyExtract.Tax_Amount								!=	'',1,0));
	cntImprovementValue_CountNonBlank		:=	sum(group,if(dFDSPropertyExtract.Improvement_Value				!=	'',1,0));
	cntSaleDate_CountNonBlank						:=	sum(group,if(dFDSPropertyExtract.Sale_Date								!=	'',1,0));
	cntSaleAmt_CountNonBlank						:=	sum(group,if(dFDSPropertyExtract.Sale_Amount							!=	'',1,0));
	cntFirstLoanAmt_CountNonBlank				:=	sum(group,if(dFDSPropertyExtract.First_Loan_Amount				!=	'',1,0));
	cntLoanType_CountNonBlank						:=	sum(group,if(dFDSPropertyExtract.Loan_Type								!=	'',1,0));
	cntSellerFirstName_CountNonBlank		:=	sum(group,if(dFDSPropertyExtract.Seller_First_Name				!=	'',1,0));
	cntSellerMiddleName_CountNonBlank		:=	sum(group,if(dFDSPropertyExtract.Seller_Middle_Name				!=	'',1,0));
	cntSellerLastName_CountNonBlank			:=	sum(group,if(dFDSPropertyExtract.Seller_Last_Name					!=	'',1,0));
	cntSellerCompanyName_CountNonBlank	:=	sum(group,if(dFDSPropertyExtract.Seller_Company_Name			!=	'',1,0));
	cntSaleDocNum_CountNonBlank					:=	sum(group,if(dFDSPropertyExtract.Sale_Doc_Number					!=	'',1,0));
	cntTransaction_CountNonBlank				:=	sum(group,if(dFDSPropertyExtract.Transaction							!=	'',1,0));
	cntSecondLoanAmt_CountNonBlank			:=	sum(group,if(dFDSPropertyExtract.Second_Loan_Amount				!=	'',1,0));
	cntDeedDesc_CountNonBlank						:=	sum(group,if(dFDSPropertyExtract.Deed_Description					!=	'',1,0));
	cntMortDueDate_CountNonBlank				:=	sum(group,if(dFDSPropertyExtract.Mortgage_Due_Date				!=	'',1,0));
	cntStandarcUseDesc_CountNonBlank		:=	sum(group,if(dFDSPropertyExtract.Standard_Use_Description	!=	'',1,0));
	cntYearBuilt_CountNonBlank					:=	sum(group,if(dFDSPropertyExtract.Year_Built								!=	'',1,0));
	cntNumUnits_CountNonBlank						:=	sum(group,if(dFDSPropertyExtract.Number_of_Units					!=	'',1,0));
	cntNumFireplaces_CountNonBlank			:=	sum(group,if(dFDSPropertyExtract.Number_Fireplaces				!=	'',1,0));
	cntGarage_CountNonBlank							:=	sum(group,if(dFDSPropertyExtract.Garage										!=	'',1,0));
	cntNumGarages_CountNonBlank					:=	sum(group,if(dFDSPropertyExtract.Number_of_Garage_Stalls	!=	'',1,0));
	cntConstDesc_CountNonBlank					:=	sum(group,if(dFDSPropertyExtract.Construction_desc				!=	'',1,0));
	cntEffYearBuilt_CountNonBlank				:=	sum(group,if(dFDSPropertyExtract.Effective_Year_Built			!=	'',1,0));
	cntNumStories_CountNonBlank					:=	sum(group,if(dFDSPropertyExtract.Number_of_Stories				!=	'',1,0));
	cntPoolInd_CountNonBlank						:=	sum(group,if(dFDSPropertyExtract.Pool_Indicator						!=	'',1,0));
	cntNumBedrooms_CountNonBlank				:=	sum(group,if(dFDSPropertyExtract.Number_of_Bedrooms				!=	'',1,0));
	cntRoofingDesc_CountNonBlank				:=	sum(group,if(dFDSPropertyExtract.Roofing_Description			!=	'',1,0));
	cntGarageSqFeet_CountNonBlank				:=	sum(group,if(dFDSPropertyExtract.Garage_Sq_Feet						!=	'',1,0));
	cntBasementSqFeet_CountNonBlank			:=	sum(group,if(dFDSPropertyExtract.Basement_Sq_Feet					!=	'',1,0));
	cntTotalSqFeet_CountNonBlank				:=	sum(group,if(dFDSPropertyExtract.Total_Sq_Feet						!=	'',1,0));
	cntHeatingDeatail_CountNonBlank			:=	sum(group,if(dFDSPropertyExtract.Heating_Detail						!=	'',1,0));
	cntNumRooms_CountNonBlank						:=	sum(group,if(dFDSPropertyExtract.Number_of_Rooms					!=	'',1,0));
	cntNumBaths_CountNonBlank						:=	sum(group,if(dFDSPropertyExtract.Number_of_Baths					!=	'',1,0));
	cntCoolingDetail_CountNonBlank			:=	sum(group,if(dFDSPropertyExtract.Cooling_Detail						!=	'',1,0));
	cntLotSize_CountNonBlank						:=	sum(group,if(dFDSPropertyExtract.Lot_Size									!=	'',1,0));
	cntLotDepth_CountNonBlank						:=	sum(group,if(dFDSPropertyExtract.Lot_Depth								!=	'',1,0));
	cntTractNum_CountNonBlank						:=	sum(group,if(dFDSPropertyExtract.Tract_Number							!=	'',1,0));
	cntLotNum_CountNonBlank							:=	sum(group,if(dFDSPropertyExtract.Lot_Number								!=	'',1,0));
	cntTownship_CountNonBlank						:=	sum(group,if(dFDSPropertyExtract.Township									!=	'',1,0));
	cntSubdivName_CountNonBlank					:=	sum(group,if(dFDSPropertyExtract.Subdivision_Name					!=	'',1,0));
	cntLotWidth_CountNonBlank						:=	sum(group,if(dFDSPropertyExtract.Lot_Width								!=	'',1,0));
	cntZoning_CountNonBlank							:=	sum(group,if(dFDSPropertyExtract.Zoning										!=	'',1,0));
	cntBlockNumber_CountNonBlank				:=	sum(group,if(dFDSPropertyExtract.Block_Number							!=	'',1,0));
	cntDistrict_CountNonBlank						:=	sum(group,if(dFDSPropertyExtract.District									!=	'',1,0));
	cntSection_CountNonBlank						:=	sum(group,if(dFDSPropertyExtract.Section									!=	'',1,0));
end;

dPopulationStats		:=	table(dFDSPropertyExtract,rStats_layout,few);

outPopulationStats	:=	output(dPopulationStats,all,named('PropertyExtract_PopulationStats'));

export propertyzipextract	:=	sequential(outFDSPropertyExtract_fixed,outFDSPropertyExtract,outPopulationStats);