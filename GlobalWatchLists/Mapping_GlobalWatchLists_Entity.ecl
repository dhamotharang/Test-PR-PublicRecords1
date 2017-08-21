import	address,ut;

dEntityCommon	:=	Globalwatchlists.Mapping_GlobalWatchLists_Entity_Common;

Globalwatchlists.Layout_denorm	tEntityReformat(dEntityCommon	pInput):=
transform
	self.entity_id									:=	pInput.referenceid;
	self.date_first_seen 						:=	Globalwatchlists.convMMDDYYYY(GlobalWatchLists.Functions.strClean(pInput.watchlistdate[1..StringLib.StringFind(pInput.watchlistdate,' ',1)-1]));
	self.date_last_seen 						:=	Globalwatchlists.convMMDDYYYY(GlobalWatchLists.Functions.strClean(pInput.watchlistdate[1..StringLib.StringFind(pInput.watchlistdate,' ',1)-1]));
	self.date_vendor_first_reported	:=	Globalwatchlists.convMMDDYYYY(GlobalWatchLists.Functions.strClean(pInput.watchlistdate[1..StringLib.StringFind(pInput.watchlistdate,' ',1)-1]));
	self.date_vendor_last_reported 	:=	Globalwatchlists.convMMDDYYYY(GlobalWatchLists.Functions.strClean(pInput.watchlistdate[1..StringLib.StringFind(pInput.watchlistdate,' ',1)-1]));
	self														:=	pInput;
	self														:=	[];
end;

dEntityReformat	:=	project(dEntityCommon,tEntityReformat(left));

// Join Vessel Information (Additional Info)
// Call Sign
dAddlInfoCallSign	:=	GlobalWatchLists.Normalize_AdditionalInfoList(GlobalWatchLists.Functions.ustrClean2Upper(AddlInfoType)	=	'VESSEL CALL SIGN'	and	AddlInfo	<>	'');

Globalwatchlists.Layout_denorm	tVesselCallSign(dEntityReformat	le,dAddlInfoCallSign	ri)	:=
transform
	self.call_sign	:=	if(ri.AddlInfo	<>	'',(string)ri.AddlInfo,'');
	self						:=	le;
end;

dVesselCallSign	:=	join(	dEntityReformat,
													dAddlInfoCallSign,
													left.pty_key	=	right.EntityID,
													tVesselCallSign(left,right),
													left outer,
													lookup
												);

// Vessel Type
dAddlInfoVesselType	:=	GlobalWatchLists.Normalize_AdditionalInfoList(GlobalWatchLists.Functions.ustrClean2Upper(AddlInfoType)	=	'VESSEL TYPE'	and	AddlInfo	<>	'');

Globalwatchlists.Layout_denorm	tVesselType(dVesselCallSign	le,dAddlInfoVesselType	ri)	:=
transform
	self.vessel_type 	:=	if(ri.AddlInfo	<>	'',(string)ri.AddlInfo,'');
	self							:=	le;
end;

dVesselType	:=	join(	dVesselCallSign,
											dAddlInfoVesselType,
											left.pty_key	=	right.EntityID,
											tVesselType(left,right),
											left outer,
											lookup
										);

// Tonnage
dAddlInfoVesselTonnage	:=	GlobalWatchLists.Normalize_AdditionalInfoList(GlobalWatchLists.Functions.ustrClean2Upper(AddlInfoType)	=	'VESSEL TONNAGE'	and	AddlInfo	<>	'');

Globalwatchlists.Layout_denorm	tVeselTonnage(dVesselType	le,dAddlInfoVesselTonnage	ri)	:=
transform
	self.tonnage 		:=	if(ri.AddlInfo	<>	'',(string)ri.AddlInfo,'');
	self 						:=	le;
end;

dVesselTonnage	:=	join(	dVesselType,
													dAddlInfoVesselTonnage,
													left.pty_key	=	right.EntityID,
													tVeselTonnage(left,right),
													left outer,
													lookup
												);

// Gross Registered Tonnage
dAddlInfoGrossRegTonnage	:=	GlobalWatchLists.Normalize_AdditionalInfoList(GlobalWatchLists.Functions.ustrClean2Upper(AddlInfoType)	=	'VESSEL GROSS REGISTERED TONNAGE'	and	AddlInfo	<>	'');
		
Globalwatchlists.Layout_denorm	tGrossRegTonnage(dVesselTonnage	le,dAddlInfoGrossRegTonnage	ri)	:=
transform
	self.gross_registered_tonnage 	:=	if(ri.AddlInfo	<>	'',(string)ri.AddlInfo,'');
	self 														:=	le;
end;

dGrossRegTonnage	:=	join(	dVesselTonnage,
														dAddlInfoGrossRegTonnage,
														left.pty_key	=	right.EntityID,
														tGrossRegTonnage(left,right),
														left outer,
														lookup
													);

// Vessel Flag
dAddlInfoVesselFlag	:=	GlobalWatchLists.Normalize_AdditionalInfoList(GlobalWatchLists.Functions.ustrClean2Upper(AddlInfoType)	=	'VESSEL FLAG'	and	AddlInfo	<>	'');
	
Globalwatchlists.Layout_denorm	tVesselFlag(dGrossRegTonnage	le,dAddlInfoVesselFlag	ri)	:=
transform
	self.vessel_flag 	:=	if(ri.AddlInfo	<>	'',(string)ri.AddlInfo,'');
	self							:=	le;
end;

dVesselFlag	:=	join(	dGrossRegTonnage,
											dAddlInfoVesselFlag,
											left.pty_key	=	right.EntityID,
											tVesselFlag(left,right),
											left outer,
											lookup
										);

// Vessel Owner
dAddlInfoVesselOwner	:=	GlobalWatchLists.Normalize_AdditionalInfoList(GlobalWatchLists.Functions.ustrClean2Upper(AddlInfoType)	=	'VESSEL OWNER'	and	AddlInfo	<>	'');

Globalwatchlists.Layout_denorm	tVesselOwner(dVesselFlag	le,dAddlInfoVesselOwner	ri)	:=
transform
	self.vessel_owner 	:=	if(ri.AddlInfo	<>	'',(string)ri.AddlInfo,'');
	self								:=	le;
end;

dVesselOwner	:=	join(	dVesselFlag,
												dAddlInfoVesselOwner,
												left.pty_key	=	right.EntityID,
												tVesselOwner(left,right),
												left outer,
												lookup
											);

// Denorm Identification
dIdentification	:=	GlobalWatchLists.Normalize_IdentificationList(IDType	<>	0);
	
Globalwatchlists.Layout_denorm	tDenormIds(dVesselOwner	le,dIdentification	ri,integer	cnt)	:=
transform
	self.NumRows								:=	cnt;
	self.id_id_1								:=	if(cnt	=	1,(string)ri.RecordID,le.id_id_1);
	self.id_id_2								:=	if(cnt	=	2,(string)ri.RecordID,le.id_id_2);
	self.id_id_3								:=	if(cnt	=	3,(string)ri.RecordID,le.id_id_3);
	self.id_id_4								:=	if(cnt	=	4,(string)ri.RecordID,le.id_id_4);
	self.id_id_5								:=	if(cnt	=	5,(string)ri.RecordID,le.id_id_5);
	self.id_id_6								:=	if(cnt	=	6,(string)ri.RecordID,le.id_id_6);
	self.id_id_7								:=	if(cnt	=	7,(string)ri.RecordID,le.id_id_7);
	self.id_id_8								:=	if(cnt	=	8,(string)ri.RecordID,le.id_id_8);
	self.id_id_9								:=	if(cnt	=	9,(string)ri.RecordID,le.id_id_9);
	self.id_id_10								:=	if(cnt	=	10,(string)ri.RecordID,le.id_id_10);
	self.id_type_1							:=	if(cnt	=	1,(string)ri.IDType,le.id_type_1);
	self.id_type_2							:=	if(cnt	=	2,(string)ri.IDType,le.id_type_2);
	self.id_type_3							:=	if(cnt	=	3,(string)ri.IDType,le.id_type_3);
	self.id_type_4							:=	if(cnt	=	4,(string)ri.IDType,le.id_type_4);
	self.id_type_5							:=	if(cnt	=	5,(string)ri.IDType,le.id_type_5);
	self.id_type_6							:=	if(cnt	=	6,(string)ri.IDType,le.id_type_6);
	self.id_type_7							:=	if(cnt	=	7,(string)ri.IDType,le.id_type_7);
	self.id_type_8							:=	if(cnt	=	8,(string)ri.IDType,le.id_type_8);
	self.id_type_9							:=	if(cnt	=	9,(string)ri.IDType,le.id_type_9);
	self.id_type_10							:=	if(cnt	=	10,(string)ri.IDType,le.id_type_10);
	self.id_number_1						:=	if(cnt	=	1,(string)ri.IDNumber,le.id_number_1); 
	self.id_number_2						:=	if(cnt	=	2,(string)ri.IDNumber,le.id_number_2); 
	self.id_number_3						:=	if(cnt	=	3,(string)ri.IDNumber,le.id_number_3); 
	self.id_number_4						:=	if(cnt	=	4,(string)ri.IDNumber,le.id_number_4); 
	self.id_number_5						:=	if(cnt	=	5,(string)ri.IDNumber,le.id_number_5); 
	self.id_number_6						:=	if(cnt	=	6,(string)ri.IDNumber,le.id_number_6); 
	self.id_number_7						:=	if(cnt	=	7,(string)ri.IDNumber,le.id_number_7); 
	self.id_number_8						:=	if(cnt	=	8,(string)ri.IDNumber,le.id_number_8); 
	self.id_number_9						:=	if(cnt	=	9,(string)ri.IDNumber,le.id_number_9); 
	self.id_number_10						:=	if(cnt	=	10,(string)ri.IDNumber,le.id_number_10); 
	self.id_country_1						:=	if(cnt	=	1,(string)ri.IssuedBy,le.id_country_1); 
	self.id_country_2						:=	if(cnt	=	2,(string)ri.IssuedBy,le.id_country_2); 
	self.id_country_3						:=	if(cnt	=	3,(string)ri.IssuedBy,le.id_country_3); 
	self.id_country_4						:=	if(cnt	=	4,(string)ri.IssuedBy,le.id_country_4); 
	self.id_country_5						:=	if(cnt	=	5,(string)ri.IssuedBy,le.id_country_5); 
	self.id_country_6						:=	if(cnt	=	6,(string)ri.IssuedBy,le.id_country_6); 
	self.id_country_7						:=	if(cnt	=	7,(string)ri.IssuedBy,le.id_country_7); 
	self.id_country_8						:=	if(cnt	=	8,(string)ri.IssuedBy,le.id_country_8); 
	self.id_country_9						:=	if(cnt	=	9,(string)ri.IssuedBy,le.id_country_9); 
	self.id_country_10					:=	if(cnt	=	10,(string)ri.IssuedBy,le.id_country_10); 
	self.id_issue_date_1				:=	if(cnt	=	1,ri.DateIssued,le.id_issue_date_1);
	self.id_issue_date_2				:=	if(cnt	=	2,ri.DateIssued,le.id_issue_date_2);
	self.id_issue_date_3				:=	if(cnt	=	3,ri.DateIssued,le.id_issue_date_3);
	self.id_issue_date_4				:=	if(cnt	=	4,ri.DateIssued,le.id_issue_date_4);
	self.id_issue_date_5				:=	if(cnt	=	5,ri.DateIssued,le.id_issue_date_5);
	self.id_issue_date_6				:=	if(cnt	=	6,ri.DateIssued,le.id_issue_date_6);
	self.id_issue_date_7				:=	if(cnt	=	7,ri.DateIssued,le.id_issue_date_7);
	self.id_issue_date_8				:=	if(cnt	=	8,ri.DateIssued,le.id_issue_date_8);
	self.id_issue_date_9				:=	if(cnt	=	9,ri.DateIssued,le.id_issue_date_9);
	self.id_issue_date_10				:=	if(cnt	=	10,ri.DateIssued,le.id_issue_date_10);
	self.id_expiration_date_1		:=	if(cnt	=	1,ri.DateExpires,le.id_expiration_date_1);
	self.id_expiration_date_2		:=	if(cnt	=	2,ri.DateExpires,le.id_expiration_date_2);
	self.id_expiration_date_3		:=	if(cnt	=	3,ri.DateExpires,le.id_expiration_date_3);
	self.id_expiration_date_4		:=	if(cnt	=	4,ri.DateExpires,le.id_expiration_date_4);
	self.id_expiration_date_5		:=	if(cnt	=	5,ri.DateExpires,le.id_expiration_date_5);
	self.id_expiration_date_6		:=	if(cnt	=	6,ri.DateExpires,le.id_expiration_date_6);
	self.id_expiration_date_7		:=	if(cnt	=	7,ri.DateExpires,le.id_expiration_date_7);
	self.id_expiration_date_8		:=	if(cnt	=	8,ri.DateExpires,le.id_expiration_date_8);
	self.id_expiration_date_9		:=	if(cnt	=	9,ri.DateExpires,le.id_expiration_date_9);
	self.id_expiration_date_10	:=	if(cnt	=	10,ri.DateExpires,le.id_expiration_date_10);
	self.passport_details 			:=	if(cnt	=	1,(string)ri.Comments,le.passport_details);
	self.passport_details_2			:=	if(cnt	=	2,(string)ri.Comments,le.passport_details_2);
	self.passport_details_3			:=	if(cnt	=	3,(string)ri.Comments,le.passport_details_3);
	self.passport_details_4			:=	if(cnt	=	4,(string)ri.Comments,le.passport_details_4);
	self.passport_details_5			:=	if(cnt	=	5,(string)ri.Comments,le.passport_details_5);
	self.passport_details_6			:=	if(cnt	=	6,(string)ri.Comments,le.passport_details_6);
	self.passport_details_7			:=	if(cnt	=	7,(string)ri.Comments,le.passport_details_7);
	self.passport_details_8			:=	if(cnt	=	8,(string)ri.Comments,le.passport_details_8);
	self.passport_details_9			:=	if(cnt	=	9,(string)ri.Comments,le.passport_details_9);
	self.passport_details_10		:=	if(cnt	=	10,(string)ri.Comments,le.passport_details_10);
	self												:=	le;
end;

dDenormIds	:=	denormalize(	dVesselOwner,
															dIdentification,
															left.pty_key	=	right.EntityID,
															tDenormIds(left,right,counter)
														);

Globalwatchlists.Layout_denorm	tIDReformat(dDenormIds	le)	:=
transform
	self.id_issue_date_1				:=	if(	le.pty_key[1..3]	in	['UNN'],
																			Globalwatchlists.convMMDDYYYY(regexreplace('[A-Z]',le.id_issue_date_1,'',nocase)),
																			le.id_issue_date_1
																		);
	self.id_issue_date_2				:=	if(	le.pty_key[1..3]	in	['UNN'],
																			Globalwatchlists.convMMDDYYYY(regexreplace('[A-Z]',le.id_issue_date_2,'',nocase)),
																			le.id_issue_date_2
																		);
	self.id_issue_date_3				:=	if(	le.pty_key[1..3]	in	['UNN'],
																			Globalwatchlists.convMMDDYYYY(regexreplace('[A-Z]',le.id_issue_date_3,'',nocase)),
																			le.id_issue_date_3
																		);
	self.id_issue_date_4				:=	if(	le.pty_key[1..3]	in	['UNN'],
																			Globalwatchlists.convMMDDYYYY(regexreplace('[A-Z]',le.id_issue_date_4,'',nocase)),
																			le.id_issue_date_4
																		);
	self.id_issue_date_5				:=	if(	le.pty_key[1..3]	in	['UNN'],
																			Globalwatchlists.convMMDDYYYY(regexreplace('[A-Z]',le.id_issue_date_5,'',nocase)),
																			le.id_issue_date_5
																		);
	self.id_issue_date_6				:=	if(	le.pty_key[1..3]	in	['UNN'],
																			Globalwatchlists.convMMDDYYYY(regexreplace('[A-Z]',le.id_issue_date_6,'',nocase)),
																			le.id_issue_date_6
																		);
	self.id_issue_date_7				:=	if(	le.pty_key[1..3]	in	['UNN'],
																			Globalwatchlists.convMMDDYYYY(regexreplace('[A-Z]',le.id_issue_date_7,'',nocase)),
																			le.id_issue_date_7
																		);
	self.id_issue_date_8				:=	if(	le.pty_key[1..3]	in	['UNN'],
																			Globalwatchlists.convMMDDYYYY(regexreplace('[A-Z]',le.id_issue_date_8,'',nocase)),
																			le.id_issue_date_8
																		);
	self.id_issue_date_9				:=	if(	le.pty_key[1..3]	in	['UNN'],
																			Globalwatchlists.convMMDDYYYY(regexreplace('[A-Z]',le.id_issue_date_9,'',nocase)),
																			le.id_issue_date_9
																		);
	self.id_issue_date_10				:=	if(	le.pty_key[1..3]	in	['UNN'],
																		Globalwatchlists.convMMDDYYYY(regexreplace('[A-Z]',le.id_issue_date_10,'',nocase)),
																		le.id_issue_date_10
																	);
	self.id_expiration_date_1		:=	if(	le.pty_key[1..3]	in	['UNN'],
																			Globalwatchlists.convMMDDYYYY(regexreplace('[A-Z]',le.id_expiration_date_1,'',nocase)),
																			le.id_expiration_date_1
																		);
	self.id_expiration_date_2		:=	if(	le.pty_key[1..3]	in	['UNN'],
																			Globalwatchlists.convMMDDYYYY(regexreplace('[A-Z]',le.id_expiration_date_2,'',nocase)), 
																			le.id_expiration_date_2
																		);
	self.id_expiration_date_3		:=	if(	le.pty_key[1..3]	in	['UNN'],
																			Globalwatchlists.convMMDDYYYY(regexreplace('[A-Z]',le.id_expiration_date_3,'',nocase)),
																			le.id_expiration_date_3
																		);
	self.id_expiration_date_4		:=	if(	le.pty_key[1..3]	in	['UNN'],
																			Globalwatchlists.convMMDDYYYY(regexreplace('[A-Z]',le.id_expiration_date_4,'',nocase)),
																			le.id_expiration_date_4
																		);
	self.id_expiration_date_5		:=	if(	le.pty_key[1..3]	in	['UNN'],
																			Globalwatchlists.convMMDDYYYY(regexreplace('[A-Z]',le.id_expiration_date_5,'',nocase)),
																			le.id_expiration_date_5
																		);
	self.id_expiration_date_6		:=	if(	le.pty_key[1..3]	in	['UNN'],
																			Globalwatchlists.convMMDDYYYY(regexreplace('[A-Z]',le.id_expiration_date_6,'',nocase)), 
																			le.id_expiration_date_6
																		);
	self.id_expiration_date_7		:=	if(	le.pty_key[1..3]	in	['UNN'],
																			Globalwatchlists.convMMDDYYYY(regexreplace('[A-Z]',le.id_expiration_date_7,'',nocase)),
																			le.id_expiration_date_7
																		);
	self.id_expiration_date_8		:=	if(	le.pty_key[1..3]	in	['UNN'],
																			Globalwatchlists.convMMDDYYYY(regexreplace('[A-Z]',le.id_expiration_date_8,'',nocase)),
																			le.id_expiration_date_8
																		);
	self.id_expiration_date_9		:=	if(	le.pty_key[1..3]	in	['UNN'],
																			Globalwatchlists.convMMDDYYYY(regexreplace('[A-Z]',le.id_expiration_date_9,'',nocase)), 
																			le.id_expiration_date_9
																		);
	self.id_expiration_date_10	:=	if(	le.pty_key[1..3]	in	['UNN'],
																			Globalwatchlists.convMMDDYYYY(regexreplace('[A-Z]',le.id_expiration_date_10,'',nocase)),
																			le.id_expiration_date_10
																		);
	self.passport_details 			:=	if(	regexfind('PASSPORT',le.id_type_1,nocase),
																			le.passport_details,
																			''
																		);
	self.passport_details_2			:=	if(	regexfind('PASSPORT',le.id_type_2,nocase),
																			le.passport_details_2,
																			''
																		);
	self.passport_details_3			:=	if(	regexfind('PASSPORT',le.id_type_3,nocase),
																			le.passport_details_3,
																			''
																		);
	self.passport_details_4			:=	if(	regexfind('PASSPORT',le.id_type_4,nocase),
																			le.passport_details_4,
																			''
																		);
	self.passport_details_5			:=	if(	regexfind('PASSPORT',le.id_type_5,nocase),
																			le.passport_details_5,
																			''
																		);
	self.passport_details_6			:=	if(	regexfind('PASSPORT',le.id_type_6,nocase),
																			le.passport_details_6,
																			''
																		);
	self.passport_details_7			:=	if(	regexfind('PASSPORT',le.id_type_7,nocase),
																			le.passport_details_7,
																			''
																		);
	self.passport_details_8			:=	if(	regexfind('PASSPORT',le.id_type_8,nocase),
																			le.passport_details_8,
																			''
																		);
	self.passport_details_9			:=	if(	regexfind('PASSPORT',le.id_type_9,nocase),
																			le.passport_details_9,
																			''
																		);
	self.passport_details_10		:=	if(	regexfind('PASSPORT',le.id_type_10,nocase),
																			le.passport_details_10,
																			''
																		);
	self.ni_number_details 			:=	if(	regexfind('NATIONAL ID',le.id_type_1,nocase),
																			le.passport_details,
																			''
																		);
	self.ni_number_details_2		:=	if(	regexfind('NATIONAL ID',le.id_type_2,nocase),
																			le.passport_details_2,
																			''
																		);
	self.ni_number_details_3		:=	if(	regexfind('NATIONAL ID',le.id_type_3,nocase),
																			le.passport_details_3,
																			''
																		);
	self.ni_number_details_4		:=	if(	regexfind('NATIONAL ID',le.id_type_4,nocase),
																			le.passport_details_4,
																			''
																		);
	self.ni_number_details_5		:=	if(	regexfind('NATIONAL ID',le.id_type_5,nocase),
																			le.passport_details_5,
																			''
																		);
	self.ni_number_details_6		:=	if(	regexfind('NATIONAL ID',le.id_type_6,nocase),
																			le.passport_details_6,
																			''
																		);
	self.ni_number_details_7		:=	if(	regexfind('NATIONAL ID',le.id_type_7,nocase),
																			le.passport_details_7,
																			''
																		);
	self.ni_number_details_8		:=	if(	regexfind('NATIONAL ID',le.id_type_8,nocase),
																			le.passport_details_8,
																			''
																		);
	self.ni_number_details_9		:=	if(	regexfind('NATIONAL ID',le.id_type_9,nocase),
																			le.passport_details_9,
																			''
																		);
	self.ni_number_details_10		:=	if(	regexfind('NATIONAL ID',le.id_type_10,nocase),
																			le.passport_details_10,
																			''
																		);
	self												:=	le;
end;

dIDRefomat 	:=	project (dDenormIds,tIDReformat(left));

// Denorm Citizenship (Additional Info)
dAddlInfoCitizenship	:=	GlobalWatchLists.Normalize_AdditionalInfoList(GlobalWatchLists.Functions.ustrClean2Upper(AddlInfoType)	=	'CITIZENSHIP'	and	AddlInfo	<>	'');

Globalwatchlists.Layout_denorm	tDenormCitizenship(dIDRefomat	le,dAddlInfoCitizenship	ri,integer	cnt)	:=
transform
	self.NumRows 					:=	cnt;
	self.citizenship_1 		:=	if(cnt	=	1,(string)ri.addlinfo,le.citizenship_1);
	self.citizenship_2 		:=	if(cnt	=	2,(string)ri.addlinfo,le.citizenship_2);
	self.citizenship_3 		:=	if(cnt	=	3,(string)ri.addlinfo,le.citizenship_3);
	self.citizenship_4 		:=	if(cnt	=	4,(string)ri.addlinfo,le.citizenship_4);
	self.citizenship_5 		:=	if(cnt	=	5,(string)ri.addlinfo,le.citizenship_5);
	self.citizenship_6 		:=	if(cnt	=	6,(string)ri.addlinfo,le.citizenship_6);
	self.citizenship_7 		:=	if(cnt	=	7,(string)ri.addlinfo,le.citizenship_7);
	self.citizenship_8 		:=	if(cnt	=	8,(string)ri.addlinfo,le.citizenship_8);
	self.citizenship_9 		:=	if(cnt	=	9,(string)ri.addlinfo,le.citizenship_9);
	self.citizenship_10 	:=	if(cnt	=	10,(string)ri.addlinfo,le.citizenship_10);
	self 									:=	le;
end;
	
dDenormCitizenship	:=	denormalize(	dIDRefomat,
																			dAddlInfoCitizenship,
																			left.pty_key	=	right.EntityID,
																			tDenormCitizenship(left,right,counter)
																		);

// Denorm Nationalities (Additional Info)
dAddlInfoNationalities	:=	GlobalWatchLists.Normalize_AdditionalInfoList(GlobalWatchLists.Functions.ustrClean2Upper(AddlInfoType)	=	'NATIONALITY'	and	AddlInfo	<>	'');
	
Globalwatchlists.Layout_denorm	tDenormNationalities(dDenormCitizenship	le,dAddlInfoNationalities	ri,integer cnt)	:=
transform
	self.NumRows 					:=	cnt;
	self.nationality_1 		:=	if(cnt	=	1,(string)ri.addlinfo,le.nationality_1);
	self.nationality_2 		:=	if(cnt	=	2,(string)ri.addlinfo,le.nationality_2);
	self.nationality_3 		:=	if(cnt	=	3,(string)ri.addlinfo,le.nationality_3);
	self.nationality_4 		:=	if(cnt	=	4,(string)ri.addlinfo,le.nationality_4);
	self.nationality_5 		:=	if(cnt	=	5,(string)ri.addlinfo,le.nationality_5);
	self.nationality_6 		:=	if(cnt	=	6,(string)ri.addlinfo,le.nationality_6);
	self.nationality_7 		:=	if(cnt	=	7,(string)ri.addlinfo,le.nationality_7);
	self.nationality_8 		:=	if(cnt	=	8,(string)ri.addlinfo,le.nationality_8);
	self.nationality_9 		:=	if(cnt	=	9,(string)ri.addlinfo,le.nationality_9);
	self.nationality_10 	:=	if(cnt	=	10,(string)ri.addlinfo,le.nationality_10);
	self 									:=	le;
end;
	
dDenormNationalities	:=	denormalize(	dDenormCitizenship,
																				dAddlInfoNationalities,
																				left.pty_key	=	right.EntityID,
																				tDenormNationalities(left,right,counter)
																			);

// Denorm DOB (Additional Info)
dAddlInfoDOB	:=	GlobalWatchLists.Normalize_AdditionalInfoList(GlobalWatchLists.Functions.ustrClean2Upper(AddlInfoType)	=	'DATE OF BIRTH'	and	AddlInfo	<>	'');

Globalwatchlists.Layout_denorm	tDenormDOB(dDenormNationalities	le,dAddlInfoDOB	ri,integer	cnt)	:=
transform
	self.NumRows 	:=	cnt;
	self.dob_1 		:=	if(cnt	=	1,(string)ri.addlinfo,le.dob_1);
	self.dob_2 		:=	if(cnt	=	2,(string)ri.addlinfo,le.dob_2);
	self.dob_3 		:=	if(cnt	=	3,(string)ri.addlinfo,le.dob_3);
	self.dob_4 		:=	if(cnt	=	4,(string)ri.addlinfo,le.dob_4);
	self.dob_5 		:=	if(cnt	=	5,(string)ri.addlinfo,le.dob_5);
	self.dob_6 		:=	if(cnt	=	6,(string)ri.addlinfo,le.dob_6);
	self.dob_7 		:=	if(cnt	=	7,(string)ri.addlinfo,le.dob_7);
	self.dob_8 		:=	if(cnt	=	8,(string)ri.addlinfo,le.dob_8);
	self.dob_9 		:=	if(cnt	=	9,(string)ri.addlinfo,le.dob_9);
	self.dob_10 	:=	if(cnt	=	10,(string)ri.addlinfo,le.dob_10);
	self 					:=	le;
end;
	
dDenormDOBs 	:=	denormalize(	dDenormNationalities,
																dAddlInfoDOB,
																left.pty_key	=	right.EntityID,
																tDenormDOB(left,right,counter)
															);

Globalwatchlists.Layout_denorm	tReformatDOBs(dDenormDOBs	le)	:=
transform
	self.dob_1	:=	map(	le.pty_key[1..3]	in	['ADF','BES','FBI','HKM','PEP','UNN']	and	~regexfind('[a-zA-Z]+',le.dob_1,nocase)				=>	Globalwatchlists.convDDMMYYYY(GlobalWatchLists.Functions.strClean(le.dob_1)),
												le.pty_key[1..3]	in	['ADF','FBI','HKM','IMW','MAS','RBA','UNN']	and	regexfind('[a-zA-Z]+',le.dob_1,nocase)	=>	Globalwatchlists.convWordDate(GlobalWatchLists.Functions.strClean(le.dob_1)),
												le.dob_1
											);
	self.dob_2	:=	map(	le.pty_key[1..3]	in	['ADF','BES','FBI','HKM','PEP','UNN']	and	~regexfind('[a-zA-Z]+',le.dob_2,nocase)				=>	Globalwatchlists.convDDMMYYYY(GlobalWatchLists.Functions.strClean(le.dob_2)),
												le.pty_key[1..3]	in	['ADF','FBI','HKM','IMW','MAS','RBA','UNN']	and	regexfind('[a-zA-Z]+',le.dob_2,nocase)	=>	Globalwatchlists.convWordDate(GlobalWatchLists.Functions.strClean(le.dob_2)),
												le.dob_2
											);
	self.dob_3	:=	map(	le.pty_key[1..3]	in	['ADF','BES','FBI','HKM','PEP','UNN']	and	~regexfind('[a-zA-Z]+',le.dob_3,nocase)				=>	Globalwatchlists.convDDMMYYYY(GlobalWatchLists.Functions.strClean(le.dob_3)),
												le.pty_key[1..3]	in	['ADF','FBI','HKM','IMW','MAS','RBA','UNN']	and	regexfind('[a-zA-Z]+',le.dob_3,nocase)	=>	Globalwatchlists.convWordDate(GlobalWatchLists.Functions.strClean(le.dob_3)),
												le.dob_3
											);
	self.dob_4	:=	map(	le.pty_key[1..3]	in	['ADF','BES','FBI','HKM','PEP','UNN']	and	~regexfind('[a-zA-Z]+',le.dob_4,nocase)				=>	Globalwatchlists.convDDMMYYYY(GlobalWatchLists.Functions.strClean(le.dob_4)),
												le.pty_key[1..3]	in	['ADF','FBI','HKM','IMW','MAS','RBA','UNN']	and	regexfind('[a-zA-Z]+',le.dob_4,nocase)	=>	Globalwatchlists.convWordDate(GlobalWatchLists.Functions.strClean(le.dob_4)),
												le.dob_4
											);
	self.dob_5	:=	map(	le.pty_key[1..3]	in	['ADF','BES','FBI','HKM','PEP','UNN']	and	~regexfind('[a-zA-Z]+',le.dob_5,nocase)				=>	Globalwatchlists.convDDMMYYYY(GlobalWatchLists.Functions.strClean(le.dob_5)),
												le.pty_key[1..3]	in	['ADF','FBI','HKM','IMW','MAS','RBA','UNN']	and	regexfind('[a-zA-Z]+',le.dob_5,nocase)	=>	Globalwatchlists.convWordDate(GlobalWatchLists.Functions.strClean(le.dob_5)),
												le.dob_5
											);
	self.dob_6 	:=	map(	le.pty_key[1..3]	in	['ADF','BES','FBI','HKM','PEP','UNN']	and	~regexfind('[a-zA-Z]+',le.dob_6,nocase)				=>	Globalwatchlists.convDDMMYYYY(GlobalWatchLists.Functions.strClean(le.dob_6)),
												le.pty_key[1..3]	in	['ADF','FBI','HKM','IMW','MAS','RBA','UNN']	and	regexfind('[a-zA-Z]+',le.dob_6,nocase)	=>	Globalwatchlists.convWordDate(GlobalWatchLists.Functions.strClean(le.dob_6)),
												le.dob_6
											);
	self.dob_7	:=	map(	le.pty_key[1..3]	in	['ADF','BES','FBI','HKM','PEP','UNN']	and	~regexfind('[a-zA-Z]+',le.dob_7,nocase)				=>	Globalwatchlists.convDDMMYYYY(GlobalWatchLists.Functions.strClean(le.dob_7)),
												le.pty_key[1..3]	in	['ADF','FBI','HKM','IMW','MAS','RBA','UNN']	and	regexfind('[a-zA-Z]+',le.dob_7,nocase)	=>	Globalwatchlists.convWordDate(GlobalWatchLists.Functions.strClean(le.dob_7)),
												le.dob_7
											);
	self.dob_8	:=	map(	le.pty_key[1..3]	in	['ADF','BES','FBI','HKM','PEP','UNN']	and	~regexfind('[a-zA-Z]+',le.dob_8,nocase)				=>	Globalwatchlists.convDDMMYYYY(GlobalWatchLists.Functions.strClean(le.dob_8)),
												le.pty_key[1..3]	in	['ADF','FBI','HKM','IMW','MAS','RBA','UNN']	and	regexfind('[a-zA-Z]+',le.dob_8,nocase)	=>	Globalwatchlists.convWordDate(GlobalWatchLists.Functions.strClean(le.dob_8)),
												le.dob_8
											);
	self.dob_9	:=	map(	le.pty_key[1..3]	in	['ADF','BES','FBI','HKM','PEP','UNN']	and	~regexfind('[a-zA-Z]+',le.dob_9,nocase)				=>	Globalwatchlists.convDDMMYYYY(GlobalWatchLists.Functions.strClean(le.dob_9)),
												le.pty_key[1..3]	in	['ADF','FBI','HKM','IMW','MAS','RBA','UNN']	and	regexfind('[a-zA-Z]+',le.dob_9,nocase)	=>	Globalwatchlists.convWordDate(GlobalWatchLists.Functions.strClean(le.dob_9)),
												le.dob_9
											);
	self.dob_10	:=	map(	le.pty_key[1..3]	in	['ADF','BES','FBI','HKM','PEP','UNN']	and	~regexfind('[a-zA-Z]+',le.dob_10,nocase)				=>	Globalwatchlists.convDDMMYYYY(GlobalWatchLists.Functions.strClean(le.dob_10)),
												le.pty_key[1..3]	in	['ADF','FBI','HKM','IMW','MAS','RBA','UNN']	and	regexfind('[a-zA-Z]+',le.dob_10,nocase)	=>	Globalwatchlists.convWordDate(GlobalWatchLists.Functions.strClean(le.dob_10)),
												le.dob_10
											);
	self				:=	le;
end;

dRefomatDOBs 	:=	project(dDenormDOBs,tReformatDOBs(left));

// Denorm POB (Additional Info)
dAddlInfoPOB	:=	GlobalWatchLists.Normalize_AdditionalInfoList(GlobalWatchLists.Functions.ustrClean2Upper(AddlInfoType)	=	'PLACE OF BIRTH'	and	AddlInfo	<>	'');
	
Globalwatchlists.Layout_denorm	tDenormPOB(dRefomatDOBs le,dAddlInfoPOB	ri,integer	cnt)	:=
transform
	self.NumRows 	:=	cnt;
	self.pob_1 		:=	if(cnt	=	1,(string)ri.addlinfo,le.pob_1);
	self.pob_2 		:=	if(cnt	=	2,(string)ri.addlinfo,le.pob_2);
	self.pob_3 		:=	if(cnt	=	3,(string)ri.addlinfo,le.pob_3);
	self.pob_4 		:=	if(cnt	=	4,(string)ri.addlinfo,le.pob_4);
	self.pob_5 		:=	if(cnt	=	5,(string)ri.addlinfo,le.pob_5);
	self.pob_6 		:=	if(cnt	=	6,(string)ri.addlinfo,le.pob_6);
	self.pob_7 		:=	if(cnt	=	7,(string)ri.addlinfo,le.pob_7);
	self.pob_8 		:=	if(cnt	=	8,(string)ri.addlinfo,le.pob_8);
	self.pob_9 		:=	if(cnt	=	9,(string)ri.addlinfo,le.pob_9);
	self.pob_10 	:=	if(cnt	=	10,(string)ri.addlinfo,le.pob_10);
	self 					:=	le;
end;
	
dDenormPOBs	:=	denormalize(	dRefomatDOBs,
															dAddlInfoPOB,
															left.pty_key	=	right.EntityID,
															tDenormPOB(left,right,counter)
														);

// Denorm Position (Additional Info)
dAddlInfoPosition	:=	GlobalWatchLists.Normalize_AdditionalInfoList(GlobalWatchLists.Functions.ustrClean2Upper(AddlInfoType)	=	'POSITION'	and	AddlInfo	<>	'');

Globalwatchlists.Layout_denorm tDenormPosition(dDenormPOBs	le,dAddlInfoPosition	ri,integer	cnt)	:=
transform
	self.NumRows 				:=	cnt;
	self.position_1 		:=	if(cnt	=	1,(string)ri.addlinfo,le.position_1);
	self.position_2 		:=	if(cnt	=	2,(string)ri.addlinfo,le.position_2);
	self.position_3 		:=	if(cnt	=	3,(string)ri.addlinfo,le.position_3);
	self.position_4 		:=	if(cnt	=	4,(string)ri.addlinfo,le.position_4);
	self.position_5 		:=	if(cnt	=	5,(string)ri.addlinfo,le.position_5);
	self.position_6 		:=	if(cnt	=	6,(string)ri.addlinfo,le.position_6);
	self.position_7 		:=	if(cnt	=	7,(string)ri.addlinfo,le.position_7);
	self.position_8 		:=	if(cnt	=	8,(string)ri.addlinfo,le.position_8);
	self.position_9 		:=	if(cnt	=	9,(string)ri.addlinfo,le.position_9);
	self.position_10 		:=	if(cnt	=	10,(string)ri.addlinfo,le.position_10);
	self 								:=	le;
end;

dDenormPosition	:=	denormalize(	dDenormPOBs,
																	dAddlInfoPosition,
																	left.pty_key	=	right.EntityID,
																	tDenormPosition(left,right,counter)
																);

// Other Membership
Globalwatchlists.Layout_denorm	tMembership(dDenormPosition	le)	:=
transform
	self.membership_1	:=	map(	le.pty_key[1..5]	=	'OSFIL'	and	regexfind('TALIBAN',le.position_1,nocase)	=>	'Taliban',
															le.pty_key[1..3]	=	'FAR'																									=>	'',
															le.membership_1
														);
	self 							:=	le;
end;

dOtherMembership	:=	project(dDenormPosition,tMembership(left));

// Denorm Occupation (Additional Info)
dAddlInfoOccupation	:=	GlobalWatchLists.Normalize_AdditionalInfoList(GlobalWatchLists.Functions.ustrClean2Upper(AddlInfoType)	=	'OCCUPATION'	and	AddlInfo	<>	'');

Globalwatchlists.Layout_denorm	tDenormOccupation(dOtherMembership	le,dAddlInfoOccupation	ri,integer	cnt)	:=
transform
	self.NumRows 					:=	cnt;
	self.occupation_1 		:=	if(cnt	=	1,(string)ri.addlinfo,le.occupation_1);
	self.occupation_2 		:=	if(cnt	=	2,(string)ri.addlinfo,le.occupation_2);
	self.occupation_3 		:=	if(cnt	=	3,(string)ri.addlinfo,le.occupation_3);
	self.occupation_4 		:=	if(cnt	=	4,(string)ri.addlinfo,le.occupation_4);
	self.occupation_5 		:=	if(cnt	=	5,(string)ri.addlinfo,le.occupation_5);
	self.occupation_6 		:=	if(cnt	=	6,(string)ri.addlinfo,le.occupation_6);
	self.occupation_7 		:=	if(cnt	=	7,(string)ri.addlinfo,le.occupation_7);
	self.occupation_8 		:=	if(cnt	=	8,(string)ri.addlinfo,le.occupation_8);
	self.occupation_9 		:=	if(cnt	=	9,(string)ri.addlinfo,le.occupation_9);
	self.occupation_10 		:=	if(cnt	=	10,(string)ri.addlinfo,le.occupation_10);
	self 									:=	le;
end;
	
dDenormOccupation	:=	denormalize(	dOtherMembership,
																		dAddlInfoOccupation,
																		left.pty_key	=	right.EntityID,
																		tDenormOccupation(left,right,counter)
																	);

// Append Physical Description (Additional Info)
// Height////////////////////////////////////////////////
dAddlInfoHeight 	:=	GlobalWatchLists.Normalize_AdditionalInfoList(GlobalWatchLists.Functions.ustrClean2Upper(AddlInfoType)	=	'HEIGHT'	and	AddlInfo	<>	'');
	
Globalwatchlists.Layout_denorm	tHeight(dDenormOccupation	le,dAddlInfoHeight	ri)	:=
transform
	self.height	:=	if(regexfind('[0-9]+',(string)ri.AddlInfo,nocase),(string)ri.AddlInfo,'');
	self				:=	le;	
end;

dHeight	:=	join(	dDenormOccupation,
									dAddlInfoHeight,
									left.pty_key	=	right.EntityID,
									tHeight(left,right),
									left outer,
									lookup
								);

// Weight
dAddlInfoWeight	:=	GlobalWatchLists.Normalize_AdditionalInfoList(GlobalWatchLists.Functions.ustrClean2Upper(AddlInfoType)	=	'WEIGHT'	and	AddlInfo	<>	'');
	
Globalwatchlists.Layout_denorm	tWeight(dHeight	le,dAddlInfoWeight	ri)	:=
transform
	self.weight	:=	if(ri.AddlInfo	<>	'',(string)ri.AddlInfo,'');
	self				:=	le;
end;

dWeight	:=	join(	dHeight,
									dAddlInfoWeight,
									left.pty_key	=	right.EntityID,
									tWeight(left,right),
									left outer,
									lookup
								);

// Physique
dAddlInfoPhysique	:=	GlobalWatchLists.Normalize_AdditionalInfoList(GlobalWatchLists.Functions.ustrClean2Upper(AddlInfoType)	=	'WEIGHT'	and	AddlInfo	<>	'');
		
Globalwatchlists.Layout_denorm 	tPhysique(dWeight	le,dAddlInfoPhysique	ri)	:=
transform
	self.physique  	:=	if(regexfind('BUILD:',(string)ri.Comments,nocase),(string)ri.Comments,'');
	self						:=	le;	
end;

dPhysique	:=	join(	dWeight,
										dAddlInfoPhysique,
										left.pty_key	=	right.EntityID,
										tPhysique(left,right),
										left outer,
										lookup
									);

// Hair Color
dAddlInfoHairColor	:=	GlobalWatchLists.Normalize_AdditionalInfoList(GlobalWatchLists.Functions.ustrClean2Upper(AddlInfoType)	=	'HAIR COLOR'	and	AddlInfo	<>	'');

Globalwatchlists.Layout_denorm	tHairColor(dPhysique	le,dAddlInfoHairColor	ri)	:=
transform
	self.hair_color	:=	if(ri.AddlInfo	<>	'',(string)ri.AddlInfo,'');
	self 						:=	le;	
end;

dHairColor	:=	join(	dPhysique,
											dAddlInfoHairColor,
											left.pty_key	=	right.EntityID,
											tHairColor(left,right),
											left outer,
											lookup
										);

// Eye Color
dAddlInfoEyeColor	:=	sort(GlobalWatchLists.Normalize_AdditionalInfoList(GlobalWatchLists.Functions.ustrClean2Upper(AddlInfoType)	=	'EYE COLOR'	and	AddlInfo	<>	''),EntityID,AddlInfo);
	
Globalwatchlists.Layout_denorm	tEyeColor(dHairColor	le,dAddlInfoEyeColor	ri)	:=
transform
	self.eyes	:=	if(ri.AddlInfo	<>	'',(string)ri.AddlInfo,'');
	self 			:=	le;	
end;

dEyeColor	:=	join(	dHairColor,
										dAddlInfoEyeColor,
										left.pty_key	=	right.EntityID,
										tEyeColor(left,right),
										left outer,
										lookup
									);

// Complexion
dAddlInfoComplexion	:=	GlobalWatchLists.Normalize_AdditionalInfoList(GlobalWatchLists.Functions.ustrClean2Upper(AddlInfoType)	=	'COMPLEXION'	and	AddlInfo	<>	'');
	
Globalwatchlists.Layout_denorm	tComplexion(dEyeColor	le,dAddlInfoComplexion	ri)	:=
transform
	self.complexion	:=	if(ri.AddlInfo	<>	'',(string)ri.AddlInfo,'');
	self 						:=	le;
end;

dComplexion	:=	join(	dEyeColor,
											dAddlInfoComplexion,
											left.pty_key	=	right.EntityID,
											tComplexion(left,right),
											left outer,
											lookup
										);

// Race
dAddlInfoRace	:=	GlobalWatchLists.Normalize_AdditionalInfoList(GlobalWatchLists.Functions.ustrClean2Upper(AddlInfoType)	=	'RACE'	and	AddlInfo	<>	'');
	
Globalwatchlists.Layout_denorm	tRace(dComplexion	le,dAddlInfoRace	ri)	:=
transform
	self.race	:=	if(ri.AddlInfo	<>	'',(string)ri.AddlInfo,'');
	self 			:=	le;
end;

dRace	:=	join(	dComplexion,
								dAddlInfoRace,
								left.pty_key	=	right.EntityID,
								tRace(left,right),
								left outer,
								lookup
							);

// Scars	and	Marks
dAddlInfoScars	:=	GlobalWatchLists.Normalize_AdditionalInfoList(GlobalWatchLists.Functions.ustrClean2Upper(AddlInfoType)	=	'DISTINGUISHING MARKS'	and	AddlInfo	<>	'');
	
Globalwatchlists.Layout_denorm	tScars(dRace	le,dAddlInfoScars	ri)	:=
transform
	self.scars_marks	:=	if(ri.AddlInfo	<>	'',(string)ri.AddlInfo,'');
	self							:=	le;
end;

dScars	:=	join(	dRace,
									dAddlInfoScars,
									left.pty_key	=	right.EntityID,
									tScars(left,right),
									left outer,
									lookup
								);

dScarsSort	:=	distribute(dScars,hash32(pty_key))	:	persist('~thor_200::persist::globalwatchlists::entity_temp');

// Append AKAs
dNormAka			:=	GlobalWatchLists.Normalize_AKAList;	
dNormAkaDist  :=	distribute(dNormAka,hash32(EntityID));
	
Globalwatchlists.Layout_denorm	tAka(dScarsSort	le,dNormAkaDist	ri)	:=
transform
	string	vCleanLName			:=	regexreplace('[^ -~]+',(string)ri.lastname,'');
	string	vCleanFName			:=	regexreplace('[^ -~]+',(string)ri.firstname,'');
	string	vCleanMName			:=	regexreplace('[^ -~]+',(string)ri.middlename,'');
	string	vCleanFullName	:=	regexreplace('[^ -~]+',(string)ri.fullname,'');
	
	string	vFixLName				:=	if(	regexfind('[(]SEGUNDO[)]',vCleanLName,nocase),
																	regexreplace('[(]',regexreplace('[)]',vCleanLName,''),''),
																	regexreplace('[(]OR PEZMAR[)]|[(]OR MARISCOS[)]',vCleanLName,'',nocase)
																); 
	
	string	vCleanPName			:=	if(	vFixLName	<>	''	and	ri.firstname	<>	'',
																	address.CleanPersonLFM73(vFixLName	+	' '	+	vCleanFName	+	' '	+	vCleanMName),
																	address.CleanPerson73(vCleanFullName)
																);
	
	self.orig_pty_name 			:=	if(	GlobalWatchLists.Functions.ustrClean2Upper(ri.EntityType)	<>	'V',
																	(string)ri.fullname,
																	''
																);
	self.orig_vessel_name		:=	if(	GlobalWatchLists.Functions.ustrClean2Upper(ri.EntityType)	=	'V',
																	(string)ri.fullname,
																	''
																);
	self.giv_designator			:=	case(	GlobalWatchLists.Functions.ustrClean2Upper(ri.EntityType),
																		'I'	=>	'I',
																		'B'	=>	'G',
																		'V'	=>	'V',
																		''
																	);
	self.cname							:=	if(	GlobalWatchLists.Functions.ustrClean2Upper(ri.EntityType)	=	'B',
																	(string)ri.fullname,
																	''
																);
	self.first_name					:=	vCleanFName;
	self.last_name					:=	vCleanLName;
	self.title_1						:=	(string)ri.title;
	self.name_type					:=	(string)ri.akatype;
	self.aka_id 						:=	(string)ri.RecordID;
	self.aka_type 					:=	(string)ri.akatype;
	self.aka_category 			:=	(string)ri.category;
	self.title      				:=	vCleanPName[1..5];
	self.fname       				:=	vCleanPName[6..25];
	self.mname       				:=	vCleanPName[26..45];
	self.lname       				:=	vCleanPName[46..65];
	self.suffix 						:=	vCleanPName[66..70];
	self.a_score  					:=	vCleanPName[71..73];
	self.pname_clean 				:=	vCleanPName;
	self										:=	le;
end;

dAka	:=	join(	dScarsSort,
								dNormAkaDist,
								left.pty_key	=	right.EntityID,
								tAka(left,right),
								left outer,
								local
							);

// Append Addresses
dNormAddress	:=	GlobalWatchLists.Normalize_AddressList;	

Globalwatchlists.Layout_denorm	tAddress(dAka	le,dNormAddress	ri)	:=
transform
	setUSStates							:=	[	'AL','AK','AZ','AR','CA','CO','CT','DE','DC','FL',
																'GA','HI','ID','IL','IN','IA','KS','KY','LA','ME',
																'MD','MA','MI','MN','MS','MO','MT','NE','NV','NH',
																'NJ','NM','NY','NC','ND','OH','OK','OR','PA','RI',
																'SC','SD','TN','TX','UT','VT','VA','WA','WV','WI',
																'WY'
															];
	
	string30	vAddress1			:=	if(	length(ri.streetaddress1)	>	0,
																	(string)ri.streetaddress1,
																	''
																);
	string30	vAddress2			:=	if(	length(ri.streetaddress2)	>	0,
																	(string)ri.streetaddress2,
																	''
																);
	string100	vCity					:=	GlobalWatchLists.Functions.ustrClean2Upper(ri.city);
	string100	vState				:=	GlobalWatchLists.Functions.ustrClean2Upper(ri.state);
	string10	vZip					:=	GlobalWatchLists.Functions.ustrClean2Upper(ri.zip);
	string100	vCountry			:=	if(	ri.EntityID[1..3]	=	'FAR',
																	(string)ri.comments,
																	(string)ri.country
																);
	string182	vCleanAddr182	:=	if(	GlobalWatchLists.Functions.ustrClean2Upper(vCountry)	=	'US'	or	regexfind(u'UNITED STATES',vCountry,nocase)	or	GlobalWatchLists.Functions.ustrClean2Upper(vState)	in	setUSStates,
																	Address.CleanAddress182(vAddress1	+	' '	+	vAddress2,vCity	+	' '	+	vState	+	' '	+	vZip),
																	''
																);
	
	self.prim_range				:=	vCleanAddr182[1..10];
	self.predir						:=	vCleanAddr182[11..12];
	self.prim_name				:=	vCleanAddr182[13..40];
	self.addr_suffix			:=	vCleanAddr182[41..44];
	self.postdir					:=	vCleanAddr182[45..46];
	self.unit_desig				:=	vCleanAddr182[47..56];
	self.sec_range				:=	vCleanAddr182[57..64];
	self.p_city_name			:=	vCleanAddr182[65..89];
	self.v_city_name			:=	vCleanAddr182[90..114];
	self.st								:=	vCleanAddr182[115..116];
	self.zip							:=	vCleanAddr182[117..121];
	self.zip4							:=	vCleanAddr182[122..125];
	self.cart							:=	vCleanAddr182[126..129];
	self.cr_sort_sz				:=	vCleanAddr182[130];
	self.lot							:=	vCleanAddr182[131..134];
	self.lot_order				:=	vCleanAddr182[135];
	self.dpbc							:=	vCleanAddr182[136..137];
	self.chk_digit				:=	vCleanAddr182[138];
	self.record_type			:=	vCleanAddr182[139..140];
	self.ace_fips_st			:=	vCleanAddr182[141..142];
	self.county						:=	vCleanAddr182[143..145];
	self.geo_lat					:=	vCleanAddr182[146..155];
	self.geo_long					:=	vCleanAddr182[156..166];
	self.msa							:=	vCleanAddr182[167..170];
	self.geo_blk					:=	vCleanAddr182[171..177];
	self.geo_match				:=	vCleanAddr182[178];
	self.err_stat					:=	vCleanAddr182[179..182];
	self.addr_clean				:=	vCleanAddr182;
	self.country					:=	if(	ri.EntityID[1..3]	=	'BIS',
																map(	GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'AD'	=>	'ANDORRA',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'AE'	=>	'UNITED ARAB EMIRATES',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'AF'	=>	'AFGHANISTAN',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'AG'	=>	'ANTIGUA	and	BARBUDA',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'AI'	=>	'ANGUILLA',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'AL'	=>	'ALBANIA',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'AM'	=>	'ARMENIA',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'AN'	=>	'NETHERLANDS ANTILLES',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'AO'	=>	'ANGOLA',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'AQ'	=>	'ANTARCTICA',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'AR'	=>	'ARGENTINA',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'AS'	=>	'AMERICAN SAMOA',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'AT'	=>	'AUSTRIA',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'AU'	=>	'AUSTRALIA',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'AW'	=>	'ARUBA',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'AX'	=>	'ALAND ISLANDS ',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'AZ'	=>	'AZERBAIJAN',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'BA'	=>	'BOSNIA	and	HERZEGOVINA',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'BB'	=>	'BARBADOS',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'BD'	=>	'BANGLADESH',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'BE'	=>	'BELGIUM',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'BF'	=>	'BURKINA FASO',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'BG'	=>	'BULGARIA',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'BH'	=>	'BAHRAIN',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'BI'	=>	'BURUNDI',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'BJ'	=>	'BENIN',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'BM'	=>	'BERMUDA',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'BN'	=>	'BRUNEI DARUSSALAM',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'BO'	=>	'BOLIVIA',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'BR'	=>	'BRAZIL',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'BS'	=>	'BAHAMAS',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'BT'	=>	'BHUTAN',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'BV'	=>	'BOUVET ISLAND',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'BW'	=>	'BOTSWANA',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'BY'	=>	'BELARUS',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'BZ'	=>	'BELIZE',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'CA'	=>	'CANADA',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'CC'	=>	'COCOS (KEELING) ISLANDS',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'CD'	=>	'CONGO,THE DEMOCRATIC REPUBLIC OF THE',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'CF'	=>	'CENTRAL AFRICAN REPUBLIC',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'CG'	=>	'CONGO,REPUBLIC OF THE',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'CH'	=>	'SWITZERLAND',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'CI'	=>	'COTE D\'IVOIRE',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'CK'	=>	'COOK ISLANDS',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'CL'	=>	'CHILE',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'CM'	=>	'CAMEROON',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'CN'	=>	'CHINA',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'CO'	=>	'COLOMBIA',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'CR'	=>	'COSTA RICA',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'CS'	=>	'SERBIA	and	MONTENEGRO',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'CU'	=>	'CUBA',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'CV'	=>	'CAPE VERDE',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'CX'	=>	'CHRISTMAS ISLAND',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'CY'	=>	'CYPRUS ',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'CZ'	=>	'CZECH REPUBLIC',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'DE'	=>	'GERMANY',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'DJ'	=>	'DJIBOUTI',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'DK'	=>	'DENMARK',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'DM'	=>	'DOMINICA',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'DO'	=>	'DOMINICAN REPUBLIC',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'DZ'	=>	'ALGERIA',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'EC'	=>	'ECUADOR',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'EE'	=>	'ESTONIA',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'EG'	=>	'EGYPT',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'EH'	=>	'WESTERN SAHARA',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'ER'	=>	'ERITREA',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'ES'	=>	'SPAIN',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'ET'	=>	'ETHIOPIA',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'FI'	=>	'FINLAND',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'FJ'	=>	'FIJI',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'FK'	=>	'FALKLAND ISLANDS',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'FM'	=>	'MICRONESIA,FEDERATED STATES OF',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'FO'	=>	'FAROE ISLANDS',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'FR'	=>	'FRANCE ',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'GA'	=>	'GABON',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'GB'	=>	'UNITED KINGDOM',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'GD'	=>	'GRENADA',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'GE'	=>	'GEORGIA',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'GF'	=>	'FRENCH GUIANA',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'GH'	=>	'GHANA',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'GI'	=>	'GIBRALTAR',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'GL'	=>	'GREENLAND',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'GM'	=>	'GAMBIA',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'GN'	=>	'GUINEA',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'GP'	=>	'GUADELOUPE',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'GQ'	=>	'EQUATORIAL GUINEA',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'GR'	=>	'GREECE',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'GS'	=>	'SOUTH GEORGIA	and	THE SOUTH SANDWICH ISLANDS',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'GT'	=>	'GUATEMALA ',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'GU'	=>	'GUAM',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'GW'	=>	'GUINEA-BISSAU',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'GY'	=>	'GUYANA',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'HK'	=>	'HONG KONG',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'HM'	=>	'HEARD ISLAND	and	MCDONALD ISLANDS',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'HN'	=>	'HONDURAS',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'HR'	=>	'CROATIA',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'HT'	=>	'HAITI',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'HU'	=>	'HUNGARY',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'ID'	=>	'INDONESIA',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'IE'	=>	'IRELAND,REPUBLIC OF',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'IL'	=>	'ISRAEL',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'IN'	=>	'INDIA',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'IO'	=>	'BRITISH INDIAN OCEAN TERRITORY',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'IQ'	=>	'IRAQ',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'IR'	=>	'IRAN,ISLAMIC REPUBLIC OF',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'IS'	=>	'ICELAND',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'IT'	=>	'ITALY',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'JM'	=>	'JAMAICA',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'JO'	=>	'JORDAN ',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'JP'	=>	'JAPAN',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'KE'	=>	'KENYA',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'KG'	=>	'KYRGYZSTAN',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'KH'	=>	'CAMBODIA',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'KI'	=>	'KIRIBATI',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'KM'	=>	'COMOROS',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'KN'	=>	'SAINT KITTS	and	NEVIS',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'KP'	=>	'KOREA,DEMOCRATIC PEOPLE\'S REPUBLIC OF',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'KR'	=>	'KOREA,REPUBLIC OF',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'KW'	=>	'KUWAIT ',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'KY'	=>	'CAYMAN ISLANDS',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'KZ'	=>	'KAZAKHSTAN',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'LA'	=>	'LAO PEOPLE\'S DEMOCRATIC REPUBLIC',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'LB'	=>	'LEBANON',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'LC'	=>	'SAINT LUCIA ',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'LI'	=>	'LIECHTENSTEIN ',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'LK'	=>	'SRI LANKA',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'LR'	=>	'LIBERIA',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'LS'	=>	'LESOTHO',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'LT'	=>	'LITHUANIA',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'LU'	=>	'LUXEMBOURG',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'LV'	=>	'LATVIA',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'LY'	=>	'LIBYAN ARAB JAMAHIRIYA',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'MA'	=>	'MOROCCO',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'MC'	=>	'MONACO',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'MD'	=>	'MOLDOVA,REPUBLIC OF',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'MG'	=>	'MADAGASCAR',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'MH'	=>	'MARSHALL ISLANDS',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'MK'	=>	'MACEDONIA,THE FORMER YUGOSLAV REPUBLIC OF',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'ML'	=>	'MALI',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'MM'	=>	'MYANMAR',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'MN'	=>	'MONGOLIA',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'MO'	=>	'MACAO',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'MP'	=>	'NORTHERN MARIANA ISLANDS',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'MQ'	=>	'MARTINIQUE',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'MR'	=>	'MAURITANIA',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'MS'	=>	'MONTSERRAT',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'MT'	=>	'MALTA',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'MU'	=>	'MAURITIUS',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'MV'	=>	'MALDIVES',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'MW'	=>	'MALAWI ',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'MX'	=>	'MEXICO',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'MY'	=>	'MALAYSIA',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'MZ'	=>	'MOZAMBIQUE',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'NA'	=>	'NAMIBIA',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'NC'	=>	'NEW CALEDONIA ',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'NE'	=>	'NIGER',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'NF'	=>	'NORFOLK ISLAND',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'NG'	=>	'NIGERIA',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'NI'	=>	'NICARAGUA',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'NL'	=>	'NETHERLANDS',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'NO'	=>	'NORWAY',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'NP'	=>	'NEPAL ',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'NR'	=>	'NAURU',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'NU'	=>	'NIUE',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'NZ'	=>	'NEW ZEALAND',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'OM'	=>	'OMAN',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'PA'	=>	'PANAMA',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'PE'	=>	'PERU',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'PF'	=>	'FRENCH POLYNESIA',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'PG'	=>	'PAPUA NEW GUINEA',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'PH'	=>	'PHILIPPINES',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'PK'	=>	'PAKISTAN',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'PL'	=>	'POLAND',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'PM'	=>	'SAINT PIERRE	and	MIQUELON',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'PN'	=>	'PITCAIRN',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'PR'	=>	'PUERTO RICO',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'PS'	=>	'PALESTINIAN TERRITORY,OCCUPIED',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'PT'	=>	'PORTUGAL',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'PW'	=>	'PALAU',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'PY'	=>	'PARAGUAY',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'QA'	=>	'QATAR',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'RE'	=>	'REUNION',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'RO'	=>	'ROMANIA',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'RU'	=>	'RUSSIAN FEDERATION',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'RW'	=>	'RWANDA',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'SA'	=>	'SAUDI ARABIA',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'SB'	=>	'SOLOMON ISLANDS',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'SC'	=>	'SEYCHELLES',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'SD'	=>	'SUDAN',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'SE'	=>	'SWEDEN',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'SG'	=>	'SINGAPORE',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'SH'	=>	'SAINT HELENA',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'SI'	=>	'SLOVENIA',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'SJ'	=>	'SVALBARD	and	JAN MAYEN',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'SK'	=>	'SLOVAKIA',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'SL'	=>	'SIERRA LEONE',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'SM'	=>	'SAN MARINO',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'SN'	=>	'SENEGAL',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'SO'	=>	'SOMALIA',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'SR'	=>	'SURINAME',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'ST'	=>	'SAO TOME	and	PRINCIPE',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'SV'	=>	'EL SALVADOR',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'SY'	=>	'SYRIAN ARAB REPUBLIC',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'SZ'	=>	'SWAZILAND',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'TC'	=>	'TURKS	and	CAICOS ISLANDS',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'TD'	=>	'CHAD',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'TF'	=>	'FRENCH SOUTHERN TERRITORIES',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'TG'	=>	'TOGO',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'TH'	=>	'THAILAND',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'TJ'	=>	'TAJIKISTAN',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'TK'	=>	'TOKELAU',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'TL'	=>	'TIMOR-LESTE',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'TM'	=>	'TURKMENISTAN',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'TN'	=>	'TUNISIA',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'TO'	=>	'TONGA',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'TR'	=>	'TURKEY',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'TT'	=>	'TRINIDAD	and	TOBAGO ',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'TV'	=>	'TUVALU',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'TW'	=>	'TAIWAN (REPUBLIC OF CHINA)  ',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'TZ'	=>	'TANZANIA,UNITED REPUBLIC OF',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'UA'	=>	'UKRAINE',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'UG'	=>	'UGANDA',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'UM'	=>	'UNITED STATES MINOR OUTLYING ISLANDS',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'US'	=>	'UNITED STATES ',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'UY'	=>	'URUGUAY',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'UZ'	=>	'UZBEKISTAN',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'VA'	=>	'VATICAN CITY STATE',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'VC'	=>	'SAINT VINCENT	and	THE GRENADINES',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'VE'	=>	'VENEZUELA',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'VG'	=>	'VIRGIN ISLANDS,BRITISH',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'VI'	=>	'VIRGIN ISLANDS,U.S.',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'VN'	=>	'VIET NAM',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'VU'	=>	'VANUATU',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'WF'	=>	'WALLIS	and	FUTUNA',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'WS'	=>	'SAMOA',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'YE'	=>	'YEMEN',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'YT'	=>	'MAYOTTE',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'ZA'	=>	'SOUTH AFRICA',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'ZM'	=>	'ZAMBIA',
																			GlobalWatchLists.Functions.strClean2Upper(vCountry)	=	'ZW'	=>	'ZIMBABWE',
																			(string)ri.country
																		),
																		(string)ri.country
																	);
	self.addr_1 								:=	vAddress1;
	self.addr_2 								:=	vAddress2;		
	self.addr_3									:=	map(	ri.city	<>	''	and	ri.state	<>	''	and	ri.zip	<>	''	=>	vCity	+	','	+	vState	+	' '	+	vZip,
																				ri.city	<>	''	and	ri.state	<>	''											=>	vCity	+	','	+	vState,
																				vState
																			);
	self.address_id 						:=	(string)ri.RecordID;
	self.address_line_1 				:=	if(	le.pty_key[1..3]	=	'IMW'	and	le.nationality_1	<>	'',
																			le.nationality_1,
																			(string)ri.streetaddress1
																		);
	self.address_line_2	 				:=	vAddress2;
	self.address_line_3 				:=	'';
	self.address_city 					:=	vCity;
	self.address_state_province	:=	vState;
	self.address_postal_code 		:=	le.zip;
	self.address_country				:=	if(	le.pty_key[1..3]	=	'IMW'	and	le.nationality_1	<>	'',
																			le.nationality_1,
																			(string)ri.country
																		);
	self.remarks								:=	if(	ri.Comments	<>	'',
																			(string)ri.Comments,
																			le.remarks
																		);
	self												:=	le;
end;

dAddress	:=	join(	dAka,
										dNormAddress,
										left.pty_key	=	right.EntityID,
										tAddress(left,right),
										left outer,
										local
									); 

Globalwatchlists.Layout_denorm	tCountry(dAddress	le)	:=
transform
	self.country 	:=	map(	le.pty_key[1..3]	=	'IMW'	and	le.nationality_1	<>	''	=>	le.nationality_1,
													le.pty_key[1..2]	=	'FB'	and	le.nationality_1	<>	''	=>	le.nationality_1,
													le.country
												);
	self					:=	le;
end;

dCountry	:=	project(dAddress,tCountry(left));

// Denorm Phone
dNormPhone	:=	GlobalWatchLists.Normalize_PhoneList(phonetype	<>	'');
	
Globalwatchlists.Layout_denorm	tDenormPhone(dCountry	le,dNormPhone	ri,integer	cnt)	:=
transform
	self.NumRows					:=	cnt;
	self.phoneid_1				:=	if(cnt	=	1,(string)ri.RecordID,le.phoneid_1);
	self.phoneid_2				:=	if(cnt	=	2,(string)ri.RecordID,le.phoneid_2);
	self.phoneid_3				:=	if(cnt	=	3,(string)ri.RecordID,le.phoneid_3);
	self.phoneid_4				:=	if(cnt	=	4,(string)ri.RecordID,le.phoneid_4);
	self.phoneid_5				:=	if(cnt	=	5,(string)ri.RecordID,le.phoneid_5);
	self.phoneid_6				:=	if(cnt	=	6,(string)ri.RecordID,le.phoneid_6);
	self.phoneid_7				:=	if(cnt	=	7,(string)ri.RecordID,le.phoneid_7);
	self.phoneid_8				:=	if(cnt	=	8,(string)ri.RecordID,le.phoneid_8);
	self.phoneid_9				:=	if(cnt	=	9,(string)ri.RecordID,le.phoneid_9);
	self.phoneid_10				:=	if(cnt	=	10,(string)ri.RecordID,le.phoneid_10);
	self.phonetype_1			:=	if(cnt	=	1,(string)ri.phonetype,le.phonetype_1);
	self.phonetype_2			:=	if(cnt	=	2,(string)ri.phonetype,le.phonetype_2);
	self.phonetype_3			:=	if(cnt	=	3,(string)ri.phonetype,le.phonetype_3);
	self.phonetype_4			:=	if(cnt	=	4,(string)ri.phonetype,le.phonetype_4);
	self.phonetype_5			:=	if(cnt	=	5,(string)ri.phonetype,le.phonetype_5);
	self.phonetype_6			:=	if(cnt	=	6,(string)ri.phonetype,le.phonetype_6);
	self.phonetype_7			:=	if(cnt	=	7,(string)ri.phonetype,le.phonetype_7);
	self.phonetype_8			:=	if(cnt	=	8,(string)ri.phonetype,le.phonetype_8);
	self.phonetype_9			:=	if(cnt	=	9,(string)ri.phonetype,le.phonetype_9);
	self.phonetype_10			:=	if(cnt	=	10,(string)ri.phonetype,le.phonetype_10);
	/*
	self.phoneaddress_1		:=	if(cnt	=	1,(string)ri.phoneaddress,le.phoneaddress_1); 
	self.phoneaddress_2		:=	if(cnt	=	2,(string)ri.phoneaddress,le.phoneaddress_2); 
	self.phoneaddress_3		:=	if(cnt	=	3,(string)ri.phoneaddress,le.phoneaddress_3); 
	self.phoneaddress_4		:=	if(cnt	=	4,(string)ri.phoneaddress,le.phoneaddress_4); 
	self.phoneaddress_5		:=	if(cnt	=	5,(string)ri.phoneaddress,le.phoneaddress_5); 
	self.phoneaddress_6		:=	if(cnt	=	6,(string)ri.phoneaddress,le.phoneaddress_6); 
	self.phoneaddress_7		:=	if(cnt	=	7,(string)ri.phoneaddress,le.phoneaddress_7); 
	self.phoneaddress_8		:=	if(cnt	=	8,(string)ri.phoneaddress,le.phoneaddress_8); 
	self.phoneaddress_9		:=	if(cnt	=	9,(string)ri.phoneaddress,le.phoneaddress_9); 
	self.phoneaddress_10	:=	if(cnt	=	10,(string)ri.phoneaddress,le.phoneaddress_10); 
	*/
	self.phonenumber_1		:=	if(cnt	=	1,(string)ri.phonenumber,le.phonenumber_1); 
	self.phonenumber_2		:=	if(cnt	=	2,(string)ri.phonenumber,le.phonenumber_2); 
	self.phonenumber_3		:=	if(cnt	=	3,(string)ri.phonenumber,le.phonenumber_3); 
	self.phonenumber_4		:=	if(cnt	=	4,(string)ri.phonenumber,le.phonenumber_4); 
	self.phonenumber_5		:=	if(cnt	=	5,(string)ri.phonenumber,le.phonenumber_5); 
	self.phonenumber_6		:=	if(cnt	=	6,(string)ri.phonenumber,le.phonenumber_6); 
	self.phonenumber_7		:=	if(cnt	=	7,(string)ri.phonenumber,le.phonenumber_7); 
	self.phonenumber_8		:=	if(cnt	=	8,(string)ri.phonenumber,le.phonenumber_8); 
	self.phonenumber_9		:=	if(cnt	=	9,(string)ri.phonenumber,le.phonenumber_9); 
	self.phonenumber_10		:=	if(cnt	=	10,(string)ri.phonenumber,le.phonenumber_10); 
	self									:=	le;
end;

dDenormPhoneIds	:=	denormalize(	dCountry,
																	dNormPhone,
																	left.pty_key	=	right.EntityID,
																	tDenormPhone(left,right,counter),
																	local
																);

// Fix Comments & Country Fields
Globalwatchlists.Layout_denorm	tCCFix(dDenormPhoneIds	le)	:=
transform
	self.remarks_1		:=	if(	le.pty_key[1..3]	=	'FAR',
														'',
														le.remarks_1
													);
	self.remarks 			:=	if(	le.pty_key[1..3]	=	'FAR',
														le.address_country,
														le.remarks_1
													);
	self.country			:=	if(	le.pty_key[1..3]	=	'FAR',
														map(	regexfind('AFGHANISTAN',le.address_country,nocase)													=>	'AFGHANISTAN',
																	regexfind('ALBANIA',le.address_country,nocase)															=>	'ALBANIA',
																	regexfind('ALGERIA',le.address_country,nocase)															=>	'ALGERIA',
																	regexfind('ANGOLA',le.address_country,nocase)																=>	'ANGOLA',
																	regexfind('ARUBA',le.address_country,nocase)																=>	'ARUBA',
																	regexfind('AUSTRALIA',le.address_country,nocase)														=>	'AUSTRALIA',
																	regexfind('AUSTRIA',le.address_country,nocase)															=>	'AUSTRIA',
																	regexfind('AZERBAIJAN',le.address_country,nocase)														=>	'AZERBAIJAN',
																	regexfind('BAHAMAS',le.address_country,nocase)															=>	'BAHAMAS',
																	regexfind('BAHRAIN',le.address_country,nocase)															=>	'BAHRAIN',
																	regexfind('BARBADOS',le.address_country,nocase)															=>	'BARBADOS',
																	regexfind('BELGIUM',le.address_country,nocase)															=>	'BELGIUM',
																	regexfind('BELIZE',le.address_country,nocase)																=>	'BELIZE',
																	regexfind('BERMUDA',le.address_country,nocase)															=>	'BERMUDA',
																	regexfind('BOLIVIA',le.address_country,nocase)															=>	'BOLIVIA',
																	regexfind('BOSNIA-HERZEGOVINA',le.address_country,nocase)										=>	'BOSNIA-HERZEGOVINA',
																	regexfind('BRAZIL',le.address_country,nocase)																=>	'BRAZIL',
																	regexfind('BRITISH VIRGIN ISLANDS',le.address_country,nocase)								=>	'BRITISH VIRGIN ISLANDS',
																	regexfind('CAMEROON',le.address_country,nocase)															=>	'CAMEROON',
																	regexfind('CANADA',le.address_country,nocase)																=>	'CANADA',
																	regexfind('CAYMAN ISLANDS',le.address_country,nocase)												=>	'CAYMAN ISLANDS',
																	regexfind('CHAD',le.address_country,nocase)																	=>	'CHAD',
																	regexfind('CHANNEL ISLANDS',le.address_country,nocase)											=>	'CHANNEL ISLANDS',
																	regexfind('CHILE',le.address_country,nocase)																=>	'CHILE',
																	regexfind('CHINA',le.address_country,nocase)																=>	'CHINA',
																	regexfind('COLOMBIA',le.address_country,nocase)															=>	'COLOMBIA',
																	regexfind('CONGO [(]BRAZZAVILLE[)]',le.address_country,nocase)							=>	'CONGO (BRAZZAVILLE)',
																	regexfind('COSTA RICA',le.address_country,nocase)														=>	'COSTA RICA',
																	regexfind('COTE D\'IVOIRE (IVORY COAST)',le.address_country,nocase)					=>	'COTE D\'IVOIRE (IVORY COAST)',
																	regexfind('CYPRUS',le.address_country,nocase)																=>	'CYPRUS',
																	regexfind('CZECH REPUBLIC',le.address_country,nocase)												=>	'CZECH REPUBLIC',
																	regexfind('DENMARK',le.address_country,nocase)															=>	'DENMARK',
																	regexfind('DJIBOUTI',le.address_country,nocase)															=>	'DJIBOUTI',
																	regexfind('DOMINICA',le.address_country,nocase)															=>	'DOMINICA',
																	regexfind('DOMINICAN REPUBLIC',le.address_country,nocase)										=>	'DOMINICAN REPUBLIC',
																	regexfind('ECUADOR',le.address_country,nocase)															=>	'ECUADOR',
																	regexfind('EGYPT',le.address_country,nocase)																=>	'EGYPT',
																	regexfind('EL SALVADOR',le.address_country,nocase)													=>	'EL SALVADOR',
																	regexfind('EQUATORIAL GUINEA',le.address_country,nocase)										=>	'EQUATORIAL GUINEA',
																	regexfind('ERITREA',le.address_country,nocase)															=>	'ERITREA',
																	regexfind('ESTONIA',le.address_country,nocase)															=>	'ESTONIA',
																	regexfind('ETHIOPIA',le.address_country,nocase)															=>	'ETHIOPIA',
																	regexfind('FRANCE',le.address_country,nocase)																=>	'FRANCE',
																	regexfind('GEORGIA',le.address_country,nocase)															=>	'GEORGIA',
																	regexfind('GERMANY',le.address_country,nocase)															=>	'GERMANY',
																	regexfind('GHANA',le.address_country,nocase)																=>	'GHANA',
																	regexfind('GREAT BRITAIN',le.address_country,nocase)												=>	'GREAT BRITAIN',
																	regexfind('GREECE',le.address_country,nocase)																=>	'GREECE',
																	regexfind('GRENADA',le.address_country,nocase)															=>	'GRENADA',
																	regexfind('GUATEMALA',le.address_country,nocase)														=>	'GUATEMALA',
																	regexfind('GUYANA',le.address_country,nocase)																=>	'GUYANA',
																	regexfind('HAITI',le.address_country,nocase)																=>	'HAITI',
																	regexfind('HONDURAS',le.address_country,nocase)															=>	'HONDURAS',
																	regexfind('HONG KONG',le.address_country,nocase)														=>	'HONG KONG',
																	regexfind('HUNGARY',le.address_country,nocase)															=>	'HUNGARY',
																	regexfind('ICELAND',le.address_country,nocase)															=>	'ICELAND',
																	regexfind('INDIA',le.address_country,nocase)																=>	'INDIA',
																	regexfind('INDONESIA',le.address_country,nocase)														=>	'INDONESIA',
																	regexfind('IRAN',le.address_country,nocase)																	=>	'IRAN',
																	regexfind('IRAQ',le.address_country,nocase)																	=>	'IRAQ',
																	regexfind('IRELAND',le.address_country,nocase)															=>	'IRELAND',
																	regexfind('ISLE OF MAN',le.address_country,nocase)													=>	'ISLE OF MAN',
																	regexfind('ISRAEL',le.address_country,nocase)																=>	'ISRAEL',
																	regexfind('ITALY',le.address_country,nocase)																=>	'ITALY',
																	regexfind('JAMAICA',le.address_country,nocase)															=>	'JAMAICA',
																	regexfind('JAPAN',le.address_country,nocase)																=>	'JAPAN',
																	regexfind('JORDAN',le.address_country,nocase)																=>	'JORDAN',
																	regexfind('KAZAKHSTAN',le.address_country,nocase)														=>	'KAZAKHSTAN',
																	regexfind('KOREA,DEMOCRATIC PEOPLES REPUBLIC OF',le.address_country,nocase)	=>	'KOREA,DEMOCRATIC PEOPLES REPUBLIC OF',
																	regexfind('KOREA,REPUBLIC OF',le.address_country,nocase)										=>	'KOREA,REPUBLIC OF',
																	regexfind('KOREA',le.address_country,nocase)																=>	'KOREA',
																	regexfind('KUWAIT',le.address_country,nocase)																=>	'KUWAIT',
																	regexfind('LAOS',le.address_country,nocase)																	=>	'LAOS',
																	regexfind('LESOTHO',le.address_country,nocase)															=>	'LESOTHO',
																	regexfind('LIBERIA',le.address_country,nocase)															=>	'LIBERIA',
																	regexfind('LIBYA',le.address_country,nocase)																=>	'LIBYA',
																	regexfind('LIECHTENSTEIN',le.address_country,nocase)												=>	'LIECHTENSTEIN',
																	regexfind('LUXEMBOURG',le.address_country,nocase)														=>	'LUXEMBOURG',
																	regexfind('MACEDONIA',le.address_country,nocase)														=>	'MACEDONIA',
																	regexfind('MALAYSIA',le.address_country,nocase)															=>	'MALAYSIA',
																	regexfind('MARSHALL ISLANDS',le.address_country,nocase)											=>	'MARSHALL ISLANDS',
																	regexfind('MAURITIUS',le.address_country,nocase)														=>	'MAURITIUS',
																	regexfind('MEXICO',le.address_country,nocase)																=>	'MEXICO',
																	regexfind('MICRONESIA',le.address_country,nocase)														=>	'MICRONESIA',
																	regexfind('MONACO',le.address_country,nocase)																=>	'MONACO',
																	regexfind('MONTENEGRO',le.address_country,nocase)														=>	'MONTENEGRO',
																	regexfind('MOROCCO',le.address_country,nocase)															=>	'MOROCCO',
																	regexfind('MYANMAR [(]BURMA[)]',le.address_country,nocase)									=>	'MYANMAR (BURMA)',
																	regexfind('NAGORNO KARABAGH',le.address_country,nocase)											=>	'NAGORNO KARABAGH',
																	regexfind('NAURU',le.address_country,nocase)																=>	'NAURU',
																	regexfind('NETHERLANDS',le.address_country,nocase)													=>	'NETHERLANDS',
																	regexfind('NETHERLANDS ANTILLES',le.address_country,nocase)									=>	'NETHERLANDS ANTILLES',
																	regexfind('NEW ZEALAND',le.address_country,nocase)													=>	'NEW ZEALAND',
																	regexfind('NICARAGUA',le.address_country,nocase)														=>	'NICARAGUA',
																	regexfind('NIGERIA',le.address_country,nocase)															=>	'NIGERIA',
																	regexfind('NORTHERN IRELAND',le.address_country,nocase)											=>	'NORTHERN IRELAND',
																	regexfind('NORWAY',le.address_country,nocase)																=>	'NORWAY',
																	regexfind('PAKISTAN',le.address_country,nocase)															=>	'PAKISTAN',
																	regexfind('PALAU',le.address_country,nocase)																=>	'PALAU',
																	regexfind('PALESTINE',le.address_country,nocase)														=>	'PALESTINE',
																	regexfind('PANAMA',le.address_country,nocase)																=>	'PANAMA',
																	regexfind('PERU',le.address_country,nocase)																	=>	'PERU',
																	regexfind('PHILIPPINES',le.address_country,nocase)													=>	'PHILIPPINES',
																	regexfind('POLAND',le.address_country,nocase)																=>	'POLAND',
																	regexfind('QATAR',le.address_country,nocase)																=>	'QATAR',
																	regexfind('ROMANIA',le.address_country,nocase)															=>	'ROMANIA',
																	regexfind('RUSSIA',le.address_country,nocase)																=>	'RUSSIA',
																	regexfind('RWANDA',le.address_country,nocase)																=>	'RWANDA',
																	regexfind('SAHARAWI ARAB DEMOCRATIC REPUBLIC',le.address_country,nocase)		=>	'SAHARAWI ARAB DEMOCRATIC REPUBLIC',
																	regexfind('SAUDI ARABIA',le.address_country,nocase)													=>	'SAUDI ARABIA',
																	regexfind('SCOTLAND',le.address_country,nocase)															=>	'SCOTLAND',
																	regexfind('SENEGAL',le.address_country,nocase)															=>	'SENEGAL',
																	regexfind('SERBIA',le.address_country,nocase)																=>	'SERBIA',
																	regexfind('SINGAPORE',le.address_country,nocase)														=>	'SINGAPORE',
																	regexfind('SOMALI DEMOCRATIC REPUBLIC',le.address_country,nocase)						=>	'SOMALI DEMOCRATIC REPUBLIC',
																	regexfind('SOUTH AFRICA',le.address_country,nocase)													=>	'SOUTH AFRICA',
																	regexfind('SPAIN',le.address_country,nocase)																=>	'SPAIN',
																	regexfind('SRI LANKA',le.address_country,nocase)														=>	'SRI LANKA',
																	regexfind('ST. LUCIA',le.address_country,nocase)														=>	'ST. LUCIA',
																	regexfind('ST. MARTIN',le.address_country,nocase)														=>	'ST. MARTIN',
																	regexfind('ST. VINCENT	and	THE GRENADINES',le.address_country,nocase)			=>	'ST. VINCENT	and	THE GRENADINES',
																	regexfind('SUDAN',le.address_country,nocase)																=>	'SUDAN',
																	regexfind('SWEDEN',le.address_country,nocase)																=>	'SWEDEN',
																	regexfind('SWITZERLAND',le.address_country,nocase)													=>	'SWITZERLAND',
																	regexfind('TAIWAN',le.address_country,nocase)																=>	'TAIWAN',
																	regexfind('TANZANIA',le.address_country,nocase)															=>	'TANZANIA',
																	regexfind('THAILAND',le.address_country,nocase)															=>	'THAILAND',
																	regexfind('TIBET',le.address_country,nocase)																=>	'TIBET',
																	regexfind('TRINIDAD & TOBAGO',le.address_country,nocase)										=>	'TRINIDAD & TOBAGO',
																	regexfind('TURKEY',le.address_country,nocase)																=>	'TURKEY',
																	regexfind('UGANDA',le.address_country,nocase)																=>	'UGANDA',
																	regexfind('UKRAINE',le.address_country,nocase)															=>	'UKRAINE',
																	regexfind('UNITED ARAB EMIRATES',le.address_country,nocase)									=>	'UNITED ARAB EMIRATES',
																	regexfind('UNITED KINGDOM',le.address_country,nocase)												=>	'UNITED KINGDOM',
																	regexfind('UZBEKISTAN',le.address_country,nocase)														=>	'UZBEKISTAN',
																	regexfind('VANUATU',le.address_country,nocase)															=>	'VANUATU',
																	regexfind('VENEZUELA',le.address_country,nocase)														=>	'VENEZUELA',
																	regexfind('VIETNAM',le.address_country,nocase)															=>	'VIETNAM',
																	regexfind('YUGOSLAVIA',le.address_country,nocase)														=>	'YUGOSLAVIA',
																	regexfind('ZIMBABWE',le.address_country,nocase)															=>	'ZIMBABWE',
																	''
																),
															le.country
														); 
	self.address_country	:=	if(	le.pty_key[1..3]	=	'FAR',
																'',
																le.address_country
															);
	self									:=	le;
end;

dFixCountryComments	:=	project(dDenormPhoneIds,tCCFix(left));

// Append Remarks to Match Original File
Globalwatchlists.Layout_denorm	tRemarkComments(dFixCountryComments	le)	:=
transform
	// concat individual fields
	string	vConcatRemarks						:=	GlobalWatchLists.Functions.strClean(	le.remarks_1	+
																																							le.remarks_2	+
																																							le.remarks_3	+
																																							le.remarks_4	+
																																							le.remarks_5	+
																																							le.remarks_6	+
																																							le.remarks_7	+
																																							le.remarks_8	+
																																							le.remarks_9	+
																																							le.remarks_10	+
																																							le.remarks_11	+
																																							le.remarks_12	+
																																							le.remarks_13	+
																																							le.remarks_14	+
																																							le.remarks_15	+
																																							le.remarks_16	+
																																							le.remarks_17	+
																																							le.remarks_18	+
																																							le.remarks_19	+
																																							le.remarks_20	+
																																							le.remarks_21	+
																																							le.remarks_22	+
																																							le.remarks_23	+
																																							le.remarks_24	+
																																							le.remarks_25	+
																																							le.remarks_26	+
																																							le.remarks_27	+
																																							le.remarks_28	+
																																							le.remarks_29	+
																																							le.remarks_30
																																						);
		
	string	vAddlInfoRemarks					:=	if(vConcatRemarks	<>	'',' '	+	vConcatRemarks,'');
	
	string	vCountryRemarks						:=	if(le.country	<>	'',' Country: '	+	GlobalWatchLists.Functions.strClean(le.country)	+	';','');
	string	vPassportRemarks					:=	if(le.passport_details	<>	'',' Passport: '	+	GlobalWatchLists.Functions.strClean(le.passport_details)	+	';','');
	string	vNiNumberRemarks					:=	if(le.ni_number_details	<>	'',' NI Number: '	+	GlobalWatchLists.Functions.strClean(le.ni_number_details)	+	';','');
	string	vIDTypeRemarks						:=	GlobalWatchLists.Functions.strClean(	if(le.id_type_1		<>	''	and	le.id_number_1	<>	'',' '	+	le.id_type_1	+	': '	+	le.id_number_1	+	';','')	+
																																							if(le.id_type_2		<>	''	and	le.id_number_2	<>	'',','	+	le.id_type_2	+	': '	+	le.id_number_2	+	';','')	+
																																							if(le.id_type_3		<>	''	and	le.id_number_3	<>	'',','	+	le.id_type_3	+	': '	+	le.id_number_3	+	';','')	+
																																							if(le.id_type_4		<>	''	and	le.id_number_4	<>	'',','	+	le.id_type_4	+	': '	+	le.id_number_4	+	';','')	+
																																							if(le.id_type_5		<>	''	and	le.id_number_5	<>	'',','	+	le.id_type_5	+	': '	+	le.id_number_5	+	';','')	+
																																							if(le.id_type_6		<>	''	and	le.id_number_6	<>	'',','	+	le.id_type_6	+	': '	+	le.id_number_6	+	';','')	+
																																							if(le.id_type_7		<>	''	and	le.id_number_7	<>	'',','	+	le.id_type_7	+	': '	+	le.id_number_7	+	';','')	+
																																							if(le.id_type_8		<>	''	and	le.id_number_8	<>	'',','	+	le.id_type_8	+	': '	+	le.id_number_8	+	';','')	+
																																							if(le.id_type_9		<>	''	and	le.id_number_9	<>	'',','	+	le.id_type_9	+	': '	+	le.id_number_9	+	';','')	+
																																							if(le.id_type_10	<>	''	and	le.id_number_10	<>	'',','	+	le.id_type_10	+	': '	+	le.id_number_10	+	';','')
																																						);
	string	vIDCountryRemarks					:=	GlobalWatchLists.Functions.strClean(	if(le.id_country_1	<>	'',' ID Country: '	+	le.id_country_1,'')	+
																																							if(le.id_country_2	<>	'',','	+	le.id_country_2,'')							+
																																							if(le.id_country_3	<>	'',','	+	le.id_country_3,'')							+
																																							if(le.id_country_4	<>	'',','	+	le.id_country_4,'')							+
																																							if(le.id_country_5	<>	'',','	+	le.id_country_5,'')							+
																																							if(le.id_country_6	<>	'',','	+	le.id_country_6,'')							+
																																							if(le.id_country_7	<>	'',','	+	le.id_country_7,'')							+
																																							if(le.id_country_8	<>	'',','	+	le.id_country_8,'')							+
																																							if(le.id_country_9	<>	'',','	+	le.id_country_9,'')							+
																																							if(le.id_country_10	<>	'',','	+	le.id_country_10,'')
																																						);
	string	vIDIssueDtRemarks					:=	GlobalWatchLists.Functions.strClean(	if(le.id_issue_date_1		<>	'',' ID Issue Date: '	+	le.id_issue_date_1,'')	+
																																							if(le.id_issue_date_2		<>	'',','	+	le.id_issue_date_2,'')								+
																																							if(le.id_issue_date_3		<>	'',','	+	le.id_issue_date_3,'')								+
																																							if(le.id_issue_date_4		<>	'',','	+	le.id_issue_date_4,'')								+
																																							if(le.id_issue_date_5		<>	'',','	+	le.id_issue_date_5,'')								+
																																							if(le.id_issue_date_6		<>	'',','	+	le.id_issue_date_6,'')								+
																																							if(le.id_issue_date_7		<>	'',','	+	le.id_issue_date_7,'')								+
																																							if(le.id_issue_date_8		<>	'',','	+	le.id_issue_date_8,'')								+
																																							if(le.id_issue_date_9		<>	'',','	+	le.id_issue_date_9,'')								+
																																							if(le.id_issue_date_10	<>	'',','	+	le.id_issue_date_10,'')
																																						);
	string	vIDExpiryDtRemarks				:=	GlobalWatchLists.Functions.strClean(	if(le.id_expiration_date_1	<>	'',' ID Expiration Date: '	+	le.id_expiration_date_1,'')	+
																																							if(le.id_expiration_date_2	<>	'',','	+	le.id_expiration_date_2,'')											+
																																							if(le.id_expiration_date_3	<>	'',','	+	le.id_expiration_date_3,'')											+
																																							if(le.id_expiration_date_4	<>	'',','	+	le.id_expiration_date_4,'')											+
																																							if(le.id_expiration_date_5	<>	'',','	+	le.id_expiration_date_5,'')											+
																																							if(le.id_expiration_date_6	<>	'',','	+	le.id_expiration_date_6,'')											+
																																							if(le.id_expiration_date_7	<>	'',','	+	le.id_expiration_date_7,'')											+
																																							if(le.id_expiration_date_8	<>	'',','	+	le.id_expiration_date_8,'')											+
																																							if(le.id_expiration_date_9	<>	'',','	+	le.id_expiration_date_9,'')											+
																																							if(le.id_expiration_date_10	<>	'',','	+	le.id_expiration_date_10,'')
																																						);
	string	vNationalityRemarks				:=	GlobalWatchLists.Functions.strClean(	if(le.nationality_1		<>	'',' Nationality: '	+	le.nationality_1,'')	+
																																							if(le.nationality_2		<>	'',','	+	le.nationality_2,'')							+
																																							if(le.nationality_3		<>	'',','	+	le.nationality_3,'')							+
																																							if(le.nationality_4		<>	'',','	+	le.nationality_4,'')							+
																																							if(le.nationality_5		<>	'',','	+	le.nationality_5,'')							+
																																							if(le.nationality_6		<>	'',','	+	le.nationality_6,'')							+
																																							if(le.nationality_7		<>	'',','	+	le.nationality_7,'')							+
																																							if(le.nationality_8		<>	'',','	+	le.nationality_8,'')							+
																																							if(le.nationality_9		<>	'',','	+	le.nationality_9,'')							+
																																							if(le.nationality_10	<>	'',','	+	le.nationality_10,'')
																																						);
	string	vCitizenshipRemarks				:=	GlobalWatchLists.Functions.strClean(	if(le.citizenship_1		<>	'',' Citizenship: '	+	le.citizenship_1,'')	+
																																							if(le.citizenship_2		<>	'',','	+	le.citizenship_2,'')							+
																																							if(le.citizenship_3		<>	'',','	+	le.citizenship_3,'')							+
																																							if(le.citizenship_4		<>	'',','	+	le.citizenship_4,'')							+
																																							if(le.citizenship_5		<>	'',','	+	le.citizenship_5,'')							+
																																							if(le.citizenship_6		<>	'',','	+	le.citizenship_6,'')							+
																																							if(le.citizenship_7		<>	'',','	+	le.citizenship_7,'')							+
																																							if(le.citizenship_8		<>	'',','	+	le.citizenship_8,'')							+
																																							if(le.citizenship_9		<>	'',','	+	le.citizenship_9,'')							+
																																							if(le.citizenship_10	<>	'',','	+	le.citizenship_10,'')
																																						);
	string	vDOBRemarks								:=	GlobalWatchLists.Functions.strClean(	if(le.dob_1		<>	'',' Date of Birth: '	+	le.dob_1,'')	+
																																							if(le.dob_2		<>	'',','	+	le.dob_2,'')								+
																																							if(le.dob_3		<>	'',','	+	le.dob_3,'')								+
																																							if(le.dob_4		<>	'',','	+	le.dob_4,'')								+
																																							if(le.dob_5		<>	'',','	+	le.dob_5,'')								+
																																							if(le.dob_6		<>	'',','	+	le.dob_6,'')								+
																																							if(le.dob_7		<>	'',','	+	le.dob_7,'')								+
																																							if(le.dob_8		<>	'',','	+	le.dob_8,'')								+
																																							if(le.dob_9		<>	'',','	+	le.dob_9,'')								+
																																							if(le.dob_10	<>	'',','	+	le.dob_10,'')
																																						);
	string	vPOBRemarks								:=	GlobalWatchLists.Functions.strClean(	if(le.pob_1		<>	'',' Place of Birth: '	+	le.pob_1,'')	+
																																							if(le.pob_2		<>	'',','	+	le.pob_2,'')									+
																																							if(le.pob_3		<>	'',','	+	le.pob_3,'')									+
																																							if(le.pob_4		<>	'',','	+	le.pob_4,'')									+
																																							if(le.pob_5		<>	'',','	+	le.pob_5,'')									+
																																							if(le.pob_6		<>	'',','	+	le.pob_6,'')									+
																																							if(le.pob_7		<>	'',','	+	le.pob_7,'')									+
																																							if(le.pob_8		<>	'',','	+	le.pob_8,'')									+
																																							if(le.pob_9		<>	'',','	+	le.pob_9,'')									+
																																							if(le.pob_10	<>	'',','	+	le.pob_10,'')
																																						);
	string	vCOBRemarks								:=	GlobalWatchLists.Functions.strClean(	if(le.country_of_birth_1	<>	'',' Country of Birth: '	+	le.country_of_birth_1,'')	+
																																							if(le.country_of_birth_2	<>	'',','	+	le.country_of_birth_2,'')										+
																																							if(le.country_of_birth_3	<>	'',','	+	le.country_of_birth_3,'')										+
																																							if(le.country_of_birth_4	<>	'',','	+	le.country_of_birth_4,'')										+
																																							if(le.country_of_birth_5	<>	'',','	+	le.country_of_birth_5,'')										+
																																							if(le.country_of_birth_6	<>	'',','	+	le.country_of_birth_6,'')										+
																																							if(le.country_of_birth_7	<>	'',','	+	le.country_of_birth_7,'')										+
																																							if(le.country_of_birth_8	<>	'',','	+	le.country_of_birth_8,'')										+
																																							if(le.country_of_birth_9	<>	'',','	+	le.country_of_birth_9,'')										+
																																							if(le.country_of_birth_10	<>	'',','	+	le.country_of_birth_10,'')
																																						);
	string	vLanguageRemarks					:=	GlobalWatchLists.Functions.strClean(	if(le.language_1	<>	'',' Language: '	+	le.language_1,'')	+
																																							if(le.language_2	<>	'',','	+	le.language_2,'')						+
																																							if(le.language_3	<>	'',','	+	le.language_3,'')						+
																																							if(le.language_4	<>	'',','	+	le.language_4,'')						+
																																							if(le.language_5	<>	'',','	+	le.language_5,'')						+
																																							if(le.language_6	<>	'',','	+	le.language_6,'')						+
																																							if(le.language_7	<>	'',','	+	le.language_7,'')						+
																																							if(le.language_8	<>	'',','	+	le.language_8,'')						+
																																							if(le.language_9	<>	'',','	+	le.language_9,'')						+
																																							if(le.language_10	<>	'',','	+	le.language_10,'')
																																						);
	string	vMembershipRemarks				:=	GlobalWatchLists.Functions.strClean(	if(le.membership_1	<>	'',' Membership: '	+	le.membership_1,'')	+
																																							if(le.membership_2	<>	'',','	+	le.membership_2,'')							+
																																							if(le.membership_3	<>	'',','	+	le.membership_3,'')							+
																																							if(le.membership_4	<>	'',','	+	le.membership_4,'')							+
																																							if(le.membership_5	<>	'',','	+	le.membership_5,'')							+
																																							if(le.membership_6	<>	'',','	+	le.membership_6,'')							+
																																							if(le.membership_7	<>	'',','	+	le.membership_7,'')							+
																																							if(le.membership_8	<>	'',','	+	le.membership_8,'')							+
																																							if(le.membership_9	<>	'',','	+	le.membership_9,'')							+
																																							if(le.membership_10	<>	'',','	+	le.membership_10,'')
																																						);
	string	vPositionRemarks					:=	GlobalWatchLists.Functions.strClean(	if(le.position_1	<>	'',' Position: '	+	le.position_1,'')	+
																																							if(le.position_2	<>	'',','	+	le.position_2,'')						+
																																							if(le.position_3	<>	'',','	+	le.position_3,'')						+
																																							if(le.position_4	<>	'',','	+	le.position_4,'')						+
																																							if(le.position_5	<>	'',','	+	le.position_5,'')						+
																																							if(le.position_6	<>	'',','	+	le.position_6,'')						+
																																							if(le.position_7	<>	'',','	+	le.position_7,'')						+
																																							if(le.position_8	<>	'',','	+	le.position_8,'')						+
																																							if(le.position_9	<>	'',','	+	le.position_9,'')						+
																																							if(le.position_10	<>	'',','	+	le.position_10,'')
																																						);
	string	vOccupationRemarks				:=	GlobalWatchLists.Functions.strClean(	if(le.occupation_1	<>	'',' Occupation: '	+	le.occupation_1,'')	+
																																							if(le.occupation_2	<>	'',','	+	le.occupation_2,'')							+
																																							if(le.occupation_3	<>	'',','	+	le.occupation_3,'')							+
																																							if(le.occupation_4	<>	'',','	+	le.occupation_4,'')							+
																																							if(le.occupation_5	<>	'',','	+	le.occupation_5,'')							+
																																							if(le.occupation_6	<>	'',','	+	le.occupation_6,'')							+
																																							if(le.occupation_7	<>	'',','	+	le.occupation_7,'')							+
																																							if(le.occupation_8	<>	'',','	+	le.occupation_8,'')							+
																																							if(le.occupation_9	<>	'',','	+	le.occupation_9,'')							+
																																							if(le.occupation_10	<>	'',','	+	le.occupation_10,'')
																																						);
	string	vEffectiveDtRemarks				:=	if(le.effective_date	<>	'',' Effective Date: '	+	GlobalWatchLists.Functions.strClean(le.effective_date)	+	';','');
	string	vExpirationDtRemarks			:=	if(le.expiration_date	<>	'',' Expiration Date: '	+	GlobalWatchLists.Functions.strClean(le.expiration_date)	+	';','');
	string	vGenderRemarks						:=	if(le.gender	<>	'',' Gender: '	+	GlobalWatchLists.Functions.strClean(le.gender)	+	';','');
	string	vGroundsRemarks						:=	if(le.grounds	<>	'',' Grounds for Addition: '	+	GlobalWatchLists.Functions.strClean(le.grounds)	+	';','');
	string	vFedRegCitationRemarks		:=	GlobalWatchLists.Functions.strClean(	if(le.federal_register_citation_1		<>	'',' Federal Register Citation: '	+	le.federal_register_citation_1,'')	+
																																							if(le.federal_register_citation_2		<>	'',','	+	le.federal_register_citation_2,'')														+
																																							if(le.federal_register_citation_3		<>	'',','	+	le.federal_register_citation_3,'')														+
																																							if(le.federal_register_citation_4		<>	'',','	+	le.federal_register_citation_4,'')														+
																																							if(le.federal_register_citation_5		<>	'',','	+	le.federal_register_citation_5,'')														+
																																							if(le.federal_register_citation_6		<>	'',','	+	le.federal_register_citation_6,'')														+
																																							if(le.federal_register_citation_7		<>	'',','	+	le.federal_register_citation_7,'')														+
																																							if(le.federal_register_citation_8		<>	'',','	+	le.federal_register_citation_8,'')														+
																																							if(le.federal_register_citation_9		<>	'',','	+	le.federal_register_citation_9,'')														+
																																							if(le.federal_register_citation_10	<>	'',','	+	le.federal_register_citation_10,'')
																																						);
	string	vLicReqRemarks						:=	if(le.license_requirement	<>	'',' License Requirement: '	+	GlobalWatchLists.Functions.strClean(le.license_requirement)	+	';','');
	string	vLicRevPolicyRemarks			:=	if(le.license_review_policy	<>	'',' License Review Policy: '	+	GlobalWatchLists.Functions.strClean(le.license_review_policy)	+	';','');
	string	vSubStatusRemarks					:=	if(le.subordinate_status	<>	'',' Subordinate Status: '	+	GlobalWatchLists.Functions.strClean(le.subordinate_status)	+	';','');
	string	vHeightRemarks						:=	if(le.height	<>	'',' Height: '	+	GlobalWatchLists.Functions.strClean(le.height)	+	';','');
	string	vWeightRemarks						:=	if(le.weight	<>	'',' Weight: '	+	GlobalWatchLists.Functions.strClean(le.weight)	+	';','');
	string	vPhysiqueRemarks					:=	if(le.physique	<>	'',' Physique: '	+	GlobalWatchLists.Functions.strClean(le.physique)	+	';','');
	string	vHairColorRemarks					:=	if(le.hair_color	<>	'',' Hair Color: '	+	GlobalWatchLists.Functions.strClean(le.hair_color)	+	';','');
	string	vEyesRemarks							:=	if(le.eyes	<>	'',' Eyes: '	+	GlobalWatchLists.Functions.strClean(le.eyes)	+	';','');
	string	vComplexionRemarks				:=	if(le.complexion	<>	'',' Complexion: '	+	GlobalWatchLists.Functions.strClean(le.complexion)	+	';','');
	string	vRaceRemarks							:=	if(le.race	<>	'',' Race: '	+	GlobalWatchLists.Functions.strClean(le.race)	+	';','');
	string	vScarMarksRemarks					:=	if(le.scars_marks	<>	'',' Scars	and	Marks: '	+	GlobalWatchLists.Functions.strClean(le.scars_marks)	+	';','');
	string	vNCICRemarks							:=	if(le.ncic	<>	'',' NCIC: '	+	GlobalWatchLists.Functions.strClean(le.ncic)	+	';','');
	string	vWarrantRemarks						:=	if(le.warrant_by	<>	'',' Warrant: '	+	GlobalWatchLists.Functions.strClean(le.warrant_by)	+	';','');
	string	vCautionRemarks						:=	if(le.caution	<>	'',' Caution: '	+	GlobalWatchLists.Functions.strClean(le.caution)	+	';','');
	string	vRewardRemarks						:=	if(le.reward	<>	'',' Reward: '	+	GlobalWatchLists.Functions.strClean(le.reward)	+	';','');
	string	vDenialTypeRemarks				:=	if(le.type_of_denial	<>	'',' Denial Type: '	+	GlobalWatchLists.Functions.strClean(le.type_of_denial)	+	';','');
	string	vDateAddRemarks						:=	if(le.date_added_to_list	<>	'',' Date Added To List: '	+	GlobalWatchLists.Functions.strClean(le.date_added_to_list)	+	';','');
	string	vLinkedWithRemarks				:=	GlobalWatchLists.Functions.strClean(	if(le.linked_with_1		<>	'','Linked With: '	+	le.linked_with_1,'')	+
																																							if(le.linked_with_2		<>	'',','	+	le.linked_with_2,'')							+
																																							if(le.linked_with_3		<>	'',','	+	le.linked_with_3,'')							+
																																							if(le.linked_with_4		<>	'',','	+	le.linked_with_4,'')							+
																																							if(le.linked_with_5		<>	'',','	+	le.linked_with_5,'')							+
																																							if(le.linked_with_6		<>	'',','	+	le.linked_with_6,'')							+
																																							if(le.linked_with_7		<>	'',','	+	le.linked_with_7,'')							+
																																							if(le.linked_with_8		<>	'',','	+	le.linked_with_8,'')							+
																																							if(le.linked_with_9		<>	'',','	+	le.linked_with_9,'')							+
																																							if(le.linked_with_10	<>	'',','	+	le.linked_with_10,'')
																																						);
	string	vListingInfoRemarks				:=	if(le.listing_information	<>	'',' Listing Info: '	+	GlobalWatchLists.Functions.strClean(le.listing_information)	+	';','');
	string	vForeignPrincipalRemarks	:=	if(le.foreign_principal	<>	'',' Foreign Principal: '	+	GlobalWatchLists.Functions.strClean(le.foreign_principal)	+	';','');
	string	vNatureOfServiceRemarks		:=	if(le.nature_of_service	<>	'',' Nature of Service: '	+	GlobalWatchLists.Functions.strClean(le.nature_of_service)	+	';','');
	string	vActivitiesRemarks				:=	if(le.activities	<>	'',' Activities: '	+	GlobalWatchLists.Functions.strClean(le.activities)	+	';','');
	string	vFinancesRemarks					:=	if(le.finances	<>	'',' Finances: '	+	GlobalWatchLists.Functions.strClean(le.finances)	+	';','');
	string	vTitleRemarks							:=	if(le.title	<>	'',' Title: '	+	GlobalWatchLists.Functions.strClean(le.title),'');
	
	// split remarks
	string	vConcatRemarksField 			:=	GlobalWatchLists.Functions.strClean(	vCountryRemarks					+
																																							vPassportRemarks				+
																																							vNiNumberRemarks				+
																																							vIDTypeRemarks					+
																																							vIDCountryRemarks				+
																																							vIDIssueDtRemarks				+
																																							vIDExpiryDtRemarks			+
																																							vNationalityRemarks			+
																																							vCitizenshipRemarks			+
																																							vDOBRemarks							+
																																							vPOBRemarks							+
																																							vCOBRemarks							+
																																							vLanguageRemarks				+
																																							vMembershipRemarks			+
																																							vPositionRemarks				+
																																							vOccupationRemarks			+
																																							vEffectiveDtRemarks			+
																																							vExpirationDtRemarks		+
																																							vGenderRemarks					+
																																							vGroundsRemarks					+
																																							vFedRegCitationRemarks	+
																																							vLicReqRemarks					+
																																							vLicRevPolicyRemarks		+
																																							vSubStatusRemarks				+
																																							vHeightRemarks					+
																																							vWeightRemarks					+
																																							vPhysiqueRemarks				+
																																							vHairColorRemarks				+
																																							vEyesRemarks						+
																																							vComplexionRemarks			+
																																							vRaceRemarks						+
																																							vScarMarksRemarks				+
																																							vNCICRemarks						+
																																							vWarrantRemarks					+
																																							vCautionRemarks					+
																																							vRewardRemarks					+
																																							vDenialTypeRemarks			+
																																							vDateAddRemarks					+
																																							vLinkedWithRemarks			+
																																							vListingInfoRemarks			+
																																							vForeignPrincipalRemarks+
																																							vNatureOfServiceRemarks	+
																																							vActivitiesRemarks			+
																																							vFinancesRemarks				+
																																							vAddlInforemarks
																																						);
	
	self.remarks_1	:=	vConcatRemarksField[1..51];
	self.remarks_2	:=	vConcatRemarksField[52..102];
	self.remarks_3	:=	vConcatRemarksField[103..153];
	self.remarks_4	:=	vConcatRemarksField[154..204];
	self.remarks_5	:=	vConcatRemarksField[205..255];
	self.remarks_6	:=	vConcatRemarksField[256..306];
	self.remarks_7	:=	vConcatRemarksField[307..357];
	self.remarks_8	:=	vConcatRemarksField[358..408];
	self.remarks_9	:=	vConcatRemarksField[409..459];
	self.remarks_10	:=	vConcatRemarksField[460..510];
	self.remarks_11	:=	vConcatRemarksField[511..561];
	self.remarks_12	:=	vConcatRemarksField[562..612];
	self.remarks_13	:=	vConcatRemarksField[613..663];
	self.remarks_14	:=	vConcatRemarksField[664..714];
	self.remarks_15	:=	vConcatRemarksField[715..765];
	self.remarks_16	:=	vConcatRemarksField[766..816];
	self.remarks_17	:=	vConcatRemarksField[817..867];
	self.remarks_18	:=	vConcatRemarksField[868..918];
	self.remarks_19	:=	vConcatRemarksField[919..969];
	self.remarks_20	:=	vConcatRemarksField[970..1020];
	self.remarks_21	:=	vConcatRemarksField[1021..1071];
	self.remarks_22	:=	vConcatRemarksField[1072..1122];
	self.remarks_23	:=	vConcatRemarksField[1123..1173];
	self.remarks_24	:=	vConcatRemarksField[1174..1224];
	self.remarks_25	:=	vConcatRemarksField[1225..1275];
	self.remarks_26	:=	vConcatRemarksField[1276..1326];
	self.remarks_27	:=	vConcatRemarksField[1327..1377];
	self.remarks_28	:=	vConcatRemarksField[1378..1428];
	self.remarks_29	:=	vConcatRemarksField[1429..1479];
	self.remarks_30	:=	vConcatRemarksField[1480..1530];

	self						:=	le;
end;

dRemarkComments	:=	project(dFixCountryComments,tRemarkComments(left));

dRemarkCommentsDedup 	:=	dedup(sort(dRemarkComments,record),record)	:	persist('~thor_200::persist::globalwatchlists::entity');

export	Mapping_GlobalWatchLists_Entity	:=	dRemarkCommentsDedup;
// export	Mapping_GlobalWatchLists_Entity	:=	dataset('~thor_200::persist::globalwatchlists::entity',GlobalWatchLists.Layout_denorm,thor);