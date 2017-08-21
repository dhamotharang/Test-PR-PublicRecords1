import	Address,AID,codes,ut,vehlic,vehiclecodes,STD;

NC_Update	:=	vehiclev2.files.In.NC.PreppedBldg;

// clean all fields to keep only the printable characters
ut.CleanFields(NC_Update,nc_update_clean);

// Get RawAID using the AID macro
rCleanAddress_layout	:=
record
	VehicleV2.Layout_NC.Prepped_Layout;
	string100				Append_PrepAddr1;
	string50				Append_PrepAddr2;
	AID.Common.xAID	Append_RawAID;
end;

rCleanAddress_layout	tAppendPrepAddr(nc_update_clean	pInput)	:=
transform
	self.Append_PrepAddr1	:=	stringlib.stringtouppercase(stringlib.stringcleanspaces(		pInput.OWNER_RESIDENCE_MAIL_ADDRESS_1
																																											+	' '
																																											+	pInput.OWNER_RESIDENCE_MAIL_ADDRESS_2
																																										)
																												);
	self.Append_PrepAddr2	:=	stringlib.stringtouppercase(regexreplace(	'[,]$',
																																			stringlib.stringcleanspaces(		if(pInput.OWNER_RESIDENCE_MAIL_CITY	!=	'',trim(pInput.OWNER_RESIDENCE_MAIL_CITY,left,right)	+	',','')
																																																		+	' '
																																																		+	pInput.OWNER_RESIDENCE_MAIL_STATE
																																																		+	' '
																																																		+	trim(pInput.OWNER_ZIP_CODE,left,right)[1..5]
																																																	),
																																			''
																																		)
																												);
	self.Append_RawAID		:=	0;
	self									:=	pInput;
end;

nc_append_prep_addr	:=	project(nc_update_clean,tAppendPrepAddr(left));

nc_prep_addr_populated			:=	nc_append_prep_addr(Append_PrepAddr2	!=	'');
nc_prep_addr_not_populated	:=	nc_append_prep_addr(Append_PrepAddr2	=		'');

// Pass the records to the AddressID macro to fetch the RawAID
AID.MacAppendFromRaw_2Line(	nc_prep_addr_populated,
														Append_PrepAddr1,
														Append_PrepAddr2,
														Append_RawAID,
														nc_clean_AppendAID,
														AID.Common.eReturnValues.RawAID
													);

// Combine the blank or invalid address records after passing to the AID macro
rCleanAddress_layout	tReformatAID(nc_clean_AppendAID	pInput)	:=
transform
	self.Append_RawAID	:=	pInput.AIDWork_RawAID;
	self								:=	pInput;
end;

addr_clean	:=	project(nc_clean_AppendAID,tReformatAID(left))	+	nc_prep_addr_not_populated;

// Convert to VehicleV2 layout
string8	fDateWithoutDashes(string	pDashedDate)	:=		pDashedDate[7..10]
																										+	pDashedDate[1..2]
																										+	pDashedDate[4..5];

VehicleV2.Layout_NC.NC_as_VehicleV2_Layout	NCToCommon(addr_clean	pInput)	:=
transform
	string73	Owner1_Clean_Name					:=	Address.CleanPersonFML73(stringlib.stringcleanspaces(	pInput.OWNER1_FIRST_NAME	+
																																																			' '												+
																																																			pInput.OWNER1_MIDDLE_NAME	+
																																																			' '												+
																																																			pInput.OWNER1_LAST_NAME		+
																																																			' '												+
																																																			pInput.OWNER1_NAME_SUFFIX
																																																		)
																																					);
	string73	Owner2_Clean_Name					:=	Address.CleanPersonFML73(stringlib.stringcleanspaces(	pInput.OWNER2_FIRST_NAME	+
																																																			' '												+
																																																			pInput.OWNER2_MIDDLE_NAME	+
																																																			' '												+
																																																			pInput.OWNER2_LAST_NAME		+
																																																			' '												+
																																																			pInput.OWNER2_NAME_SUFFIX
																																																		)
																																					);

	self.dt_first_seen									:=	(unsigned)pInput.process_date;
	self.dt_last_seen										:=	(unsigned)pInput.process_date;
	self.dt_vendor_first_reported				:=	(unsigned)pInput.process_date;
	self.dt_vendor_last_reported				:=	(unsigned)pInput.process_date;
	
	self.Orig_County										:=	pInput.COUNTY_ABBREVIATION;
	self.Raw_VIN												:=	pInput.VEHICLE_IDENTIFICATION;
	self.ORIG_VIN												:=	pInput.VEHICLE_IDENTIFICATION;
	self.ORIG_MAKE_YEAR									:=	pInput.MODEL_YEAR;
	self.YEAR_MAKE											:=	pInput.MODEL_YEAR;
	self.Orig_MAKE_CODE									:=	pInput.MAKE_CODE;
	self.MAKE_CODE											:=	pInput.MAKE_CODE;
	self.Orig_Body_Code									:=	pInput.BODY_STYLE;
	self.BODY_CODE											:=	pInput.BODY_STYLE;
	self.Orig_Series_Code								:=	pInput.SERIES;
	self.Orig_Net_Weight								:=	pInput.VEHICLE_LICENSED_WEIGHT;
	self.Orig_Reg_1_Customer_Name				:=	stringlib.stringcleanspaces(		pInput.OWNER1_LAST_NAME
																																				+	' '
																																				+	pInput.OWNER1_FIRST_NAME
																																				+	' '
																																				+	pInput.OWNER1_MIDDLE_NAME
																																				+	' '
																																				+	pInput.OWNER1_NAME_SUFFIX
																																			);
	self.Orig_Reg_2_Customer_Name				:=	stringlib.stringcleanspaces(		pInput.OWNER2_LAST_NAME
																																				+	' '
																																				+	pInput.OWNER2_FIRST_NAME
																																				+	' '
																																				+	pInput.OWNER2_MIDDLE_NAME
																																				+	' '
																																				+	pInput.OWNER2_NAME_SUFFIX
																																			);
	self.Orig_RegistrationExpDate				:=	pInput.REGISTRATION_EXPIRATION_DATE;
	self.Orig_RegistrationIssueDate			:=	pInput.REGISTRATION_ISSUE_DATE;
	self.Orig_TitleTypeCode							:=	pInput.TITLE_TYPE_CODE;
	self.Orig_TitleDate									:=	pInput.ORIGINAL_TITLE_DATE;
	self.Orig_TitleTransferDate					:=	pInput.TITLE_TRANSFER_DATE;
	self.LICENSE_PLATE_NUMBERxBG4				:=	pInput.PLATE_NUMBER;
	self.REGISTRATION_Effective_DATE		:=	if(	(unsigned4)fDateWithoutDashes(pInput.REGISTRATION_EXPIRATION_DATE)	>	(unsigned4)fDateWithoutDashes(pInput.REGISTRATION_ISSUE_DATE),
																							fDateWithoutDashes(pInput.REGISTRATION_ISSUE_DATE),
																							''
																						);
	self.REGISTRATION_EXPIRATION_DATE		:=	if(	(unsigned4)fDateWithoutDashes(pInput.REGISTRATION_EXPIRATION_DATE)	>	(unsigned4)fDateWithoutDashes(pInput.REGISTRATION_ISSUE_DATE),
																							fDateWithoutDashes(pInput.REGISTRATION_EXPIRATION_DATE),
																							''
																						);
	self.REGISTRATION_STATUS_CODE				:=	pInput.REGISTRATION_STATUS_CODE[1];
	self.TRUE_LICENSE_PLSTE_NUMBER			:=	pInput.PLATE_NUMBER;
	self.history												:=	if(self.REGISTRATION_EXPIRATION_DATE	<	(STRING8) STD.Date.Today() and	(unsigned4)(self.registration_expiration_date) <> 0,'E','');
	self.Orig_REGISTRANT1_CUSTOMER_TYPE	:=	pInput.OWNER1_NAME_INDICATOR;
	self.REGISTRANT_1_CUSTOMER_type			:=	map(	pInput.Append_Owner1NameTypeInd	in	['P','D']																		=> 'I',
																								pInput.OWNER1_NAME_INDICATOR		=	'I'	and	pInput.Append_Owner1NameTypeInd	=	'U'	=> 'I',
																								pInput.OWNER1_NAME_INDICATOR		=	'B'	and	pInput.Append_Owner1NameTypeInd	=	'U'	=> 'B',
																								pInput.Append_Owner1NameTypeInd	=	'I'																						=> 'W',
																								pInput.Append_Owner1NameTypeInd
																							);
	self.REG_1_CUSTOMER_NAME						:=	stringlib.stringcleanspaces(		pInput.OWNER1_LAST_NAME
																																				+	' '
																																				+	pInput.OWNER1_FIRST_NAME
																																				+	' '
																																				+	pInput.OWNER1_MIDDLE_NAME
																																				+	' '
																																				+	pInput.OWNER1_NAME_SUFFIX
																																			);
	self.REG_1_STREET_ADDRESS						:=	pInput.OWNER_RESIDENCE_MAIL_ADDRESS_1 + pInput.OWNER_RESIDENCE_MAIL_ADDRESS_2;
	self.REG_1_CITY											:=	pInput.OWNER_RESIDENCE_MAIL_CITY;
	self.REG_1_STATE										:=	pInput.OWNER_RESIDENCE_MAIL_STATE;
	self.REG_1_ZIP5_ZIP4_FOREIGN_POSTAL	:=	if(	pInput.OWNER_ZIP_CODE[6..9]	=	'0000',
																							pInput.OWNER_ZIP_CODE[1..5],
																							pInput.OWNER_ZIP_CODE[1..5]	+	'-'	+	pInput.OWNER_ZIP_CODE[6..9]
																						);
	self.REG_2_CUSTOMER_NAME						:=	stringlib.stringcleanspaces(		pInput.OWNER2_LAST_NAME
																																				+	' '
																																				+	pInput.OWNER2_FIRST_NAME
																																				+	' '
																																				+	pInput.OWNER2_MIDDLE_NAME
																																				+	' '
																																				+	pInput.OWNER2_NAME_SUFFIX
																																			);
	self.Orig_REGISTRANT2_CUSTOMER_TYPE	:=	pInput.OWNER2_NAME_INDICATOR;
	self.REGISTRANT_2_CUSTOMER_TYPE			:=	if(	trim(self.REG_2_CUSTOMER_NAME)	<>	'',
																							map(	pInput.Append_Owner2NameTypeInd	in	['P','D']																		=> 'I',
																										pInput.OWNER2_NAME_INDICATOR		=	'I'	and	pInput.Append_Owner2NameTypeInd	=	'U'	=> 'I',
																										pInput.OWNER2_NAME_INDICATOR		=	'B'	and	pInput.Append_Owner2NameTypeInd	=	'U'	=> 'B',
																										pInput.Append_Owner2NameTypeInd	=	'I'																						=> 'W',
																										pInput.Append_Owner2NameTypeInd
																									),
																							''
																						);
	self.REG_2_STREET_ADDRESS						:=	if(	trim(self.REG_2_CUSTOMER_NAME)	<>	'',
																							pInput.OWNER_RESIDENCE_MAIL_ADDRESS_1	+	pInput.OWNER_RESIDENCE_MAIL_ADDRESS_2,
																							''
																						);
	self.REG_2_CITY											:=	if(	trim(self.REG_2_CUSTOMER_NAME)	<>	'',
																							pInput.OWNER_RESIDENCE_MAIL_CITY,
																							''
																						);
	self.REG_2_STATE										:=	if(	trim(self.REG_2_CUSTOMER_NAME)	<>	'',
																							pInput.OWNER_RESIDENCE_MAIL_STATE,
																							''
																						);
	self.REG_2_ZIP5_ZIP4_FOREIGN_POSTAL	:=	if(	trim(self.REG_2_CUSTOMER_NAME)	<>	'',
																							if(	pInput.OWNER_ZIP_CODE[6..9]	=	'0000',
																									pInput.OWNER_ZIP_CODE[1..5],
																									pInput.OWNER_ZIP_CODE[1..5]	+	'-'	+	pInput.OWNER_ZIP_CODE[6..9]
																								),
																							''
																						);
	self.TITLE_NUMBERxBG9								:=	pInput.TITLE_NUMBER;
	self.TITLE_ISSUE_DATE								:=	fDateWithoutDashes(pInput.TITLE_TRANSFER_DATE);
	
	self.reg_1_title										:=	if(	self.REGISTRANT_1_CUSTOMER_TYPE	=	'I',
																							Owner1_Clean_Name[1..5],
																							''
																						);
	self.reg_1_fname										:=	if(	self.REGISTRANT_1_CUSTOMER_TYPE	=	'I',
																							Owner1_Clean_Name[6..25],
																							''
																						);
	self.reg_1_mname										:=	if(	self.REGISTRANT_1_CUSTOMER_TYPE	=	'I',
																							Owner1_Clean_Name[26..45],
																							''
																						);
	self.reg_1_lname										:=	if(	self.REGISTRANT_1_CUSTOMER_TYPE	=	'I',
																							Owner1_Clean_Name[46..65],
																							''
																						);
	self.reg_1_name_suffix							:=	if(	self.REGISTRANT_1_CUSTOMER_TYPE	=	'I',
																							Owner1_Clean_Name[66..70],
																							''
																						);
	self.reg_1_company_name							:=	if(	self.REGISTRANT_1_CUSTOMER_TYPE	!=	'I',
																							stringlib.stringcleanspaces(	pInput.OWNER1_LAST_NAME		+	
																																						pInput.OWNER1_FIRST_NAME	+	
																																						pInput.OWNER1_MIDDLE_NAME	+	
																																						pInput.OWNER1_NAME_SUFFIX
																																					),
																							''
																						);

	self.Append_Reg1_PrepAddr1					:=	pInput.Append_PrepAddr1;
	self.Append_Reg1_PrepAddr2					:=	pInput.Append_PrepAddr2;
	self.Append_Reg1_RawAID							:=	pInput.Append_RawAID;
	
	self.reg_2_title										:=	if(	self.REGISTRANT_2_CUSTOMER_TYPE	=	'I',
																							Owner2_Clean_Name[1..5],
																							''
																						);
	self.reg_2_fname										:=	if(	self.REGISTRANT_2_CUSTOMER_TYPE	=	'I',
																							Owner2_Clean_Name[6..25],
																							''
																						);
	self.reg_2_mname										:=	if(	self.REGISTRANT_2_CUSTOMER_TYPE	=	'I',
																							Owner2_Clean_Name[26..45],
																							''
																						);
	self.reg_2_lname										:=	if(	self.REGISTRANT_2_CUSTOMER_TYPE	=	'I',
																							Owner2_Clean_Name[46..65],
																							''
																						);
	self.reg_2_name_suffix							:=	if(	self.REGISTRANT_2_CUSTOMER_TYPE	=	'I',
																							Owner2_Clean_Name[66..70],
																							''
																						);
	self.reg_2_company_name							:=	if(	self.REGISTRANT_2_CUSTOMER_TYPE	!=	'I',
																							stringlib.stringcleanspaces(	pInput.OWNER2_LAST_NAME		+	
																																						pInput.OWNER2_FIRST_NAME	+	
																																						pInput.OWNER2_MIDDLE_NAME	+	
																																						pInput.OWNER2_NAME_SUFFIX
																																					),
																							''
																						);
	self.Append_Reg2_PrepAddr1					:=	if(	pInput.OWNER2_FIRST_NAME	+	pInput.OWNER2_LAST_NAME	!=	'',
																							pInput.Append_PrepAddr1,
																							''
																						);
	self.Append_Reg2_PrepAddr2					:=	if(	pInput.OWNER2_FIRST_NAME	+	pInput.OWNER2_LAST_NAME	!=	'',
																							pInput.Append_PrepAddr2,
																							''
																						);
	self.Append_Reg2_RawAID							:=	if(	pInput.OWNER2_FIRST_NAME	+	pInput.OWNER2_LAST_NAME	!=	'',
																							pInput.Append_RawAID,
																							0
																						);
	
	self																:=	pInput;
	self																:=	[];
end;

veh_NC	:=	project(addr_clean,NCToCommon(left));

export	Map_NC_Update	:=	veh_NC;