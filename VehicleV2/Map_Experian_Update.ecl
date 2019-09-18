import Address,AID,codes,Lib_StringLib,standard,ut,vehlic,vehicleCodes;

string1	lNameType_Owner				:=	'1';
string1	lNameType_Lessor			:=	'2';
string1	lNameType_Registrant	:=	'4';
string1	lNameType_Lessee			:=	'5';
string1	lNameType_Lienholder	:=	'7';

string1	lOwnerType_Person			:=	'1';
string1	lOwnerType_Business		:=	'2';

sValidExperianUpdatingExceptions	:=	['ME','WI'];

dExperianRaw		:=	VehicleV2.Files.In.Experian.Prepped;

dExperianUpdate	:=	dExperianRaw(append_STATE_ORIGIN	not in	sValidExperianUpdatingExceptions);

dExperianME			:=  dExperianRaw(			append_STATE_ORIGIN	='ME'
																	and	(			(MAX((integer)ORG_REG_DT,MAX((integer)TITLE_TRANS_DT,(integer)ORG_TITLE_DT))	>	20030421)
																				or	(MAX((integer)TITLE_TRANS_DT,(integer)ORG_TITLE_DT)	<	19970430)
																			)
																);
dExperianWI			:=  dExperianRaw(			append_STATE_ORIGIN	='WI'
																	and	((integer)REG_RENEW_DT	>	20041203	or	(integer)TITLE_TRANS_DT	>	20041203)
																);

dExperianAll		:=		dExperianUpdate
										+	dExperianME
										+	dExperianWI;

string8	fFixDate(string8 pDateIn)	:=	if(	(integer8)pDateIn=0,
																					'',
																					Lib_StringLib.StringLib.StringFindReplace(pDateIn,' ','0')
																				);

string	fFixOrigName(string1	pOwnerType,string	pFName,string	pMName,string	pLName,string	pSuffix,string	pSuffix2)
	:=	if(	pOwnerType = '1',
					trim(pFName)	+	trim(' ' + pMName)	+	trim(' ' + pLName)	+	trim(' ' + pSuffix)	+	trim(' ' + pSuffix2),
					pFName	+	pMName	+	pLName	+	pSuffix	+	pSuffix2
				);

string10	fFixZip(string5	pZip5,string4	pZip4)	:=	if(length(trim(pZip5))=5, pZip5 + if((integer4)pZip4 <> 0,'-'	+	pZip4,''),'');
 
string	fFixbody1(string	pString)	:=	lib_stringlib.stringlib.stringfindreplace(pString,'|',' ');

string	fFixbody2(string	pString)	:=	stringlib.stringcleanspaces(lib_stringlib.stringlib.stringfindreplace(pString,'~',' '));

unsigned4	fBestSeenDate(string8	pRegDate,string8	pTitleDate,string8	pProcessDate)	:=
function
	unsigned4	lRegDate			:=	(unsigned8)pRegDate;
	unsigned4	lTitleDate		:=	(unsigned8)pTitleDate;
	unsigned4	lProcessDate	:=	(unsigned8)pProcessDate;
	unsigned4	lReturnValue	:=	if(	lRegDate	<=	lProcessDate	and	lRegDate	<>	0,
																	lRegDate,
																	if(lTitleDate	<=	lProcessDate	and	lTitleDate <> 0,
																			lTitleDate,
																			0
																		)
																);
	return	lReturnValue;
end;

// Convert abinitio code to ECL
rTempCleanName_layout	:=
record
	VehicleV2.Layout_Experian.Layout_Experian_Updating_as_VehicleV2;
	string73	CleanName
end;

rTempCleanName_layout	tExperianAsVehicleV2(dExperianAll pInput)	:=
transform	
	string25	tmpMailPOBox							:=	if(pInput.m_pob			!=	'','PO BOX '					+	trim(pInput.m_pob,left,right),'');
	string25	tmpMailRRNbr							:=	if(pInput.m_rr_nbr	!=	'','RURAL ROUTE # '		+	trim(pInput.m_rr_nbr,left,right),'');
	string25	tmpMailRRBox							:=	if(pInput.m_rr_box	!=	'','BOX '							+	trim(pInput.m_rr_box,left,right),'');

	string150	tmpMailPrepAddr1					:=	stringlib.stringcleanspaces(pInput.mail_range
																					+	' '
																					+	pInput.m_pre_dir
																					+	' '
																					+	pInput.m_street
																					+	' '
																					+	pInput.m_suffix
																					+	' '
																					+	pInput.m_post_dir
																					+	' '
																					+	pInput.m_scndry_des
																					+	' '
																					+	pInput.m_scndry_rng
																					+	' '
																					+	tmpMailPOBox
																					+	' '
																					+	tmpMailRRNbr
																					+	' '
																					+	tmpMailRRBox);

	string100	tmpMailPrepAddr2					:=	regexreplace(	'[,]$',
																												stringlib.stringcleanspaces(		if(pInput.m_city	!=	'',trim(pInput.m_city,left,right)	+	', ','')
																																											+	pInput.m_state
																																											+	' '
																																											+	pInput.m_zip5
																																										),
																												''
																											);

	string25	tmpPhysicalPOBox					:=	if(pInput.p_pob			!=	'','PO BOX '					+	trim(pInput.p_pob,left,right),'');
	string25	tmpPhysicalRRNbr					:=	if(pInput.p_rr_nbr	!=	'','RURAL ROUTE # '		+	trim(pInput.p_rr_nbr,left,right),'');
	string25	tmpPhysicalRRBox					:=	if(pInput.p_rr_box	!=	'','BOX '							+	trim(pInput.p_rr_box,left,right),'');

	string150	tmpPhysicalPrepAddr1			:=	stringlib.stringcleanspaces(pInput.phys_range
																					+	' '
																					+	pInput.p_pre_dir
																					+	' '
																					+	pInput.p_street
																					+	' '
																					+	pInput.p_suffix
																					+	' '
																					+	pInput.p_post_dir
																					+	' '
																					+	pInput.p_scndry_des
																					+	' '
																					+	pInput.p_scndry_rng
																					+	' '
																					+	tmpPhysicalPOBox
																					+	' '
																					+	tmpPhysicalRRNbr
																					+	' '
																					+	tmpPhysicalRRBox);

	string100	tmpPhysicalPrepAddr2			:=	regexreplace(	'[,]$',
																												stringlib.stringcleanspaces(		if(pInput.p_city	!=	'',trim(pInput.p_city,left,right)	+	', ','')
																																											+	pInput.p_state
																																											+	' '
																																											+	pInput.p_zip5
																																										),
																												''
																											);

	boolean	lMCityBlank									:=	pInput.m_city = '';

	
	string100	tmpName1									:=	stringlib.stringcleanspaces(pInput.first_nm	+	' '	+	pInput.middle_nm	+	' '	+	pInput.last_nm	+	' '	+	pInput.name_suffix);
	string100	tmpName2									:=	pInput.first_nm	+	pInput.middle_nm	+	pInput.last_nm	+	pInput.name_suffix;

	self.CleanName											:=	if(			regexfind('(FARM)[S]?',pInput.first_nm,nocase)
																							or	regexfind('(FARM)[S]?',pInput.middle_nm,nocase)
																							or	stringlib.stringfind(tmpName2,'&',1)						!=	0
																							or	stringlib.stringfind(pInput.first_nm,'BANK',1)	!=	0
																							or	stringlib.stringfind(pInput.middle_nm,'BANK',1)	!=	0,
																							'',
																							Address.CleanPersonFML73(tmpName1)
																						);
	self.state_origin										:=	StringLib.StringCleanSpaces(stringlib.stringtouppercase(pInput.append_state_origin));	
	self.source_code										:=	'AE';
	self.raw_marketing_ind							:=	stringlib.stringcleanspaces(pInput.opt_out_cd);
	self.dt_first_seen									:=	fBestSeenDate(fFixDate(pInput.reg_renew_dt),fFixDate(if(pInput.title_trans_dt<>'',pInput.title_trans_dt,pInput.org_title_dt)),pInput.append_process_date);
  self.dt_last_seen										:=	fBestSeenDate(fFixDate(pInput.reg_renew_dt),fFixDate(if(pInput.title_trans_dt<>'',pInput.title_trans_dt,pInput.org_title_dt)),pInput.append_process_date);
	self.dt_vendor_first_reported				:=	(unsigned8)pInput.append_process_date;
	self.dt_vendor_last_reported				:=	(unsigned8)pInput.append_process_date;
	self.raw_vin												:=	StringLib.StringCleanSpaces(pInput.vin);
	self.orig_vin												:=	StringLib.StringCleanSpaces(pInput.vin);
	self.raw_model_year									:=	stringlib.stringcleanspaces(pInput.model_yr);
	self.raw_model_year_ind							:=	stringlib.stringcleanspaces(pInput.model_yr_ind);
	self.year_make											:=	if((integer2)pInput.model_yr = 0,
																						 '',
																						 if(	pInput.model_yr > '2020',
																									'19' + pInput.model_yr[3..4],
																									Lib_StringLib.StringLib.stringfindreplace(pInput.model_yr,' ','0')
																							 )
																						);																				
	self.raw_assigned_weight						:=	stringlib.stringcleanspaces(pInput.asg_wgt);
	self.raw_assigned_weight_uom				:=	stringlib.stringcleanspaces(pInput.asg_wgt_uom);
	self.raw_net_weight								 	:= 	StringLib.StringCleanSpaces(pInput.weight);
	self.net_weight											:=	if((integer2)pInput.weight	=	0,
																						 '',
																						 trim((string)(integer4)pInput.weight,all)
																						);
	self.raw_axle_count								 	:=  StringLib.StringCleanSpaces(pInput.axle_cnt);	
	self.number_of_axles								:=	if((integer2)pInput.axle_cnt	=	0,
																						 '',
																						 trim((string)(integer4)pInput.AXLE_CNT,all)
																						);
	self.raw_make												:=	stringlib.stringcleanspaces(pInput.make);
	self.raw_make_ind										:=	stringlib.stringcleanspaces(pInput.make_ind);
	self.make_code											:=	if(length(stringlib.stringcleanspaces(pInput.make)) < 6,stringlib.stringcleanspaces(pInput.make),'');
	self.orig_make_desc     						:=  if(length(stringlib.stringcleanspaces(pInput.make)) > 5,stringlib.stringcleanspaces(pInput.make),'');
	self.raw_model											:=	stringlib.stringcleanspaces(pInput.model);
	self.raw_model_ind									:=	stringlib.stringcleanspaces(pInput.model_ind);
	self.model													:=	stringlib.stringcleanspaces(pInput.model);
	self.series                     		:=	stringlib.stringcleanspaces(pInput.series);
	self.raw_series_ind									:=	stringlib.stringcleanspaces(pInput.series_ind);
	self.raw_major_color_code						:=	stringlib.stringcleanspaces(pInput.prime_color);
	self.major_color_code								:=	stringlib.stringcleanspaces(pInput.prime_color);
	self.raw_minor_color_code						:=	stringlib.stringcleanspaces(pInput.second_color);
	self.minor_color_code								:=	stringlib.stringcleanspaces(pInput.second_color);
	self.raw_body_code									:=	stringlib.stringcleanspaces(pInput.body_style);
	self.raw_body_code_ind							:=	stringlib.stringcleanspaces(pInput.body_style_ind);
	self.body_code											:=  if(length(fFixbody2(fFixbody1(pInput.body_style)))	<	6,fFixbody2(fFixbody1(pInput.body_style)),'');
	self.orig_body_desc									:=	if(length(fFixbody2(fFixbody1(pInput.body_style)))	>	5,fFixbody2(fFixbody1(pInput.body_style)),'');
	self.vehicle_type										:=  stringlib.stringcleanspaces(pInput.vehicle_typ);
	self.raw_length											:=	stringlib.stringcleanspaces(pInput.lengt);
	self.license_plate_numberxbg4				:=  stringlib.stringcleanspaces(pInput.plate_nbr);
	self.true_license_plste_number			:=  stringlib.stringcleanspaces(pInput.plate_nbr);
	self.license_state									:=  stringlib.stringcleanspaces(pInput.plate_state);
	self.previous_license_state					:=  stringlib.stringcleanspaces(pInput.prev_plate_state);
	self.previous_license_plate_number	:=	stringlib.stringcleanspaces(pInput.prev_plate_nbr);
	self.registration_expiration_date		:=	if((unsigned8)fFixDate(pInput.reg_exp_dt)	>	(unsigned8)fFixDate(pInput.reg_renew_dt),fFixDate(pInput.reg_exp_dt),'');
	self.license_plate_code							:=	stringlib.stringcleanspaces(pInput.plate_typ_cd);
	self.decal_number										:=	stringlib.stringcleanspaces(pInput.reg_decal_nbr);
	self.raw_registration_first_date		:=	stringlib.stringcleanspaces(pInput.org_reg_dt);
	self.first_registration_date				:=	fFixDate(pInput.org_reg_dt);
	self.raw_registration_renew_date		:=	stringlib.stringcleanspaces(pInput.reg_renew_dt);
	self.raw_registration_exp_date			:=	stringlib.stringcleanspaces(pInput.reg_exp_dt);
	self.registration_effective_date		:=	if((unsigned8)fFixDate(pInput.reg_exp_dt)	>	(unsigned8)fFixDate(pInput.reg_renew_dt),fFixDate(pInput.reg_renew_dt),'');
	self.title_numberxbg9								:=	stringlib.stringcleanspaces(pInput.title_nbr);
	self.raw_title_first_date						:=	stringlib.stringcleanspaces(pInput.org_title_dt);
	self.raw_title_transfer_date				:=	stringlib.stringcleanspaces(pInput.title_trans_dt);
	self.title_issue_date								:=	fFixDate(if(pInput.title_trans_dt	<>	'',pInput.title_trans_dt,pInput.org_title_dt));
	self.previous_title_issue_date			:=	fFixDate(if(pInput.org_title_dt	<>	''	and pInput.org_title_dt <> pInput.title_trans_dt,pInput.org_title_dt,''));
	
  self.orig_name_type             		:=  stringlib.stringcleanspaces(pInput.name_typ_cd);
	self.orig_party_type            		:=  if(pInput.owner_typ_cd	=	lOwnerType_Person,'I','B');
	self.raw_party_type									:=	stringlib.stringcleanspaces(pInput.owner_typ_cd);
	self.raw_first_name									:=	stringlib.stringcleanspaces(pInput.first_nm);
	self.raw_middle_name								:=	stringlib.stringcleanspaces(pInput.middle_nm);
	self.raw_last_name									:=	stringlib.stringcleanspaces(pInput.last_nm);
	self.raw_name_suffix								:=	stringlib.stringcleanspaces(pInput.name_suffix);
	self.raw_prof_suffix								:=	stringlib.stringcleanspaces(pInput.prof_suffix);
	self.raw_name												:=	stringlib.stringcleanspaces(pInput.raw_name);
	self.orig_name                  		:=  stringlib.stringcleanspaces(fFixOrigName(pInput.owner_typ_cd,pInput.first_nm,pInput.middle_nm,pInput.last_nm,pInput.name_suffix,pInput.prof_suffix));

	self.raw_mail_street_address				:=	tmpMailPrepAddr1;
	self.raw_mail_city									:=	stringlib.stringcleanspaces(pInput.m_city);
	self.raw_mail_state									:=	stringlib.stringcleanspaces(pInput.m_state);
	self.raw_mail_zip5									:=	stringlib.stringcleanspaces(pInput.m_zip5);
	self.raw_mail_zip4									:=	stringlib.stringcleanspaces(pInput.m_zip4);
	self.raw_mail_country_cd						:=	stringlib.stringcleanspaces(pInput.m_cntry_cd);
	self.raw_mail_cc_filler							:=	stringlib.stringcleanspaces(pInput.m_cc_filler);
	self.raw_mail_cc										:=	stringlib.stringcleanspaces(pInput.m_cc);
	self.raw_mail_county								:=	stringlib.stringcleanspaces(pInput.m_county);

	self.raw_physical_street_address		:=	tmpPhysicalPrepAddr1;
	self.raw_physical_city							:=	stringlib.stringcleanspaces(pInput.p_city);
	self.raw_physical_state							:=	stringlib.stringcleanspaces(pInput.p_state);
	self.raw_physical_zip5							:=	stringlib.stringcleanspaces(pInput.p_zip5);
	self.raw_physical_zip4							:=	stringlib.stringcleanspaces(pInput.p_zip4);
	self.raw_physical_country_cd				:=	stringlib.stringcleanspaces(pInput.p_cntry_cd);
	self.raw_physical_cc_filler					:=	stringlib.stringcleanspaces(pInput.p_cc_filler);
	self.raw_physical_cc								:=	stringlib.stringcleanspaces(pInput.p_cc);
	self.raw_physical_county						:=	stringlib.stringcleanspaces(pInput.p_county);
	
	self.orig_address			    					:=	if(	lMCityBlank,
																							 tmpPhysicalPrepAddr1,
																							 tmpMailPrepAddr1
																						);
  self.orig_city											:=	if(	lMCityBlank,
																							 stringlib.stringcleanspaces(pInput.p_city),
																							 stringlib.stringcleanspaces(pInput.m_city)
																						);
	self.orig_state											:=	if(	lMCityBlank,
																							stringlib.stringcleanspaces(pInput.p_state),
																							stringlib.stringcleanspaces(pInput.m_state)
																						);
	self.orig_zip	                			:=	if(	lMCityBlank,
																							fFixZip(pInput.p_zip5,pInput.p_zip4),
																							fFixZip(pInput.m_zip5,pInput.m_zip4)
																						);
	self.orig_ssn                       :=	if(pInput.owner_typ_cd = '1',stringlib.stringcleanspaces(pInput.ind_ssn),''); 
	self.orig_FEIN                      := 	if(pInput.owner_typ_cd = '2',stringlib.stringcleanspaces(pInput.ind_ssn),''); 
	self.orig_DOB                       := 	if(pInput.owner_typ_cd = '1',fFixDate(pInput.ind_dob),'');
	self.orig_sex                       := 	'';
	self.orig_lien_date                 := 	'';
	self.history												:=	'';
		
	self.Append_MailPrepAddr1						:=	stringlib.stringtouppercase(tmpMailPrepAddr1);
	self.Append_MailPrepAddr2						:=	stringlib.stringtouppercase(tmpMailPrepAddr2);
	self.Append_PhysicalPrepAddr1				:=	stringlib.stringtouppercase(tmpPhysicalPrepAddr1);
	self.Append_PhysicalPrepAddr2				:=	stringlib.stringtouppercase(tmpPhysicalPrepAddr2);
	
	self																:=	pInput;
	self																:=	[];
end;

dExpUpdateAsVehicleV2	:=	project(dExperianAll,tExperianAsVehicleV2(left));

// Distinguish between business names and person names
Address.Mac_Is_Business_Parsed(	dExpUpdateAsVehicleV2,
																dExpUpdateNameType,
																raw_first_name,
																raw_middle_name,
																raw_last_name,
																raw_name_suffix
															);

// Parse clean names
VehicleV2.Layout_Experian.Layout_Experian_Updating_as_VehicleV2	tParseCleanName(dExpUpdateNameType	pInput)	:=
transform
	boolean	isBusiness			:=	pInput.raw_party_type	=	lOwnerType_Business	or	pInput.orig_party_type	=		'B';

	self.orig_party_type		:=	map(	pInput.nameType	in	['P','D']														=>	'I',
																		pInput.orig_party_type	=	'I'	and	pInput.nameType	=	'U'	=>	'I',
																		pInput.orig_party_type	=	'B'	and	pInput.nameType	=	'U'	=>	'B',
																		pInput.nameType					=	'I'														=>	'W',
																		pInput.nameType
																	);
	self.title							:=	if(	self.orig_party_type	=	'I'	or	(self.orig_party_type	=	'W'	and	pInput.raw_party_type	=	lOwnerType_Person),
																	stringlib.stringcleanspaces(pInput.CleanName[01..05]),
																	''
																);
	self.fname							:=	if(	self.orig_party_type	=	'I'	or	(self.orig_party_type	=	'W'	and	pInput.raw_party_type	=	lOwnerType_Person),
																	stringlib.stringcleanspaces(pInput.CleanName[06..25]),
																	''
																);
	self.mname							:=	if(	self.orig_party_type	=	'I'	or	(self.orig_party_type	=	'W'	and	pInput.raw_party_type	=	lOwnerType_Person),
																	stringlib.stringcleanspaces(pInput.CleanName[26..45]),
																	''
																);
	self.lname							:=	if(	self.orig_party_type	=	'I'	or	(self.orig_party_type	=	'W'	and	pInput.raw_party_type	=	lOwnerType_Person),
																	stringlib.stringcleanspaces(pInput.CleanName[46..65]),
																	''
																);
	self.name_suffix				:=	if(	self.orig_party_type	=	'I'	or	(self.orig_party_type	=	'W'	and	pInput.raw_party_type	=	lOwnerType_Person),
																	stringlib.stringcleanspaces(pInput.CleanName[66..70]),
																	''
																);
	self.name_score					:=	if(	self.orig_party_type	=	'I'	or	(self.orig_party_type	=	'W'	and	pInput.raw_party_type	=	lOwnerType_Person),
																	stringlib.stringcleanspaces(pInput.CleanName[71..73]),
																	''
																);
	self.Append_Clean_cname	:=	if(	self.orig_party_type	=	'B'	or	(self.orig_party_type	=	'W'	and	pInput.raw_party_type	=	lOwnerType_Business),
																	pInput.orig_name,
																	''
																);
	self										:=	pInput;
end;

dExpUpdateParseCleanName	:=	project(dExpUpdateNameType,tParseCleanName(left));

// Fix lessee, lessor issue
VehicleV2.Mac_fix_lessee_lessor_only(dExpUpdateParseCleanName,dExperianFixLesseeLessor);

// Modify pname and cname issues when orig_party_type = 'B' and 'I'
VehicleV2.Layout_Experian.Layout_Experian_Updating_as_VehicleV2 tFixName(dExperianFixLesseeLessor	pInput)	:=
transform
	boolean isPName					:=	if(	pInput.title	<>	''	and	~regexfind('SHERIFF| CU |FCU| PO | BO ',pInput.orig_name),
																	true,
																	false
																);

	boolean isCName					:=	if(pInput.lname	in	['LT','INFINITI LT'],true,false);																						 
	
	self.title 		 					:=  if(isCName,'',if(pInput.orig_party_type	=	'B',if(isPName,pInput.title,''),pInput.title));                                                                                                                      
	self.fname 		 					:=  if(isCName,'',if(pInput.orig_party_type	=	'B',if(isPName,pInput.fname,''),pInput.fname));                                                                                                                                                                                              
	self.mname 		 					:=  if(isCName,'',if(pInput.orig_party_type	=	'B',if(isPName,pInput.mname,''),pInput.mname));                                                                                                                                                                                           
	self.lname							:=  if(isCName,'',if(pInput.orig_party_type	=	'B',if(isPName,pInput.lname,''),pInput.lname));                                                                                                                                                                                           
	self.name_suffix				:=  if(isCName,'',if(pInput.orig_party_type	=	'B',if(isPName,pInput.name_suffix,''),pInput.name_suffix));                                                                                                                                                                                           
	self.name_score					:=  if(isCName,'',if(pInput.orig_party_type	=	'B',if(isPName,pInput.name_score,''),pInput.name_score));                                                                       
	
	self.Append_Clean_cname	:=	if(isCName,pInput.orig_name,pInput.Append_Clean_cname);                            
	self.body_code					:=	vehiclev2.simplify_experian_body_codes(pInput.body_code);
	self.orig_Make_Desc			:=	if(	pInput.make_code	<>	'',
																	stringlib.StringToUpperCase(VehicleCodes.getMake(pInput.state_origin,pInput.Make_code)),
																	pInput.orig_make_desc
																);
	self.orig_Series_Desc		:=	pInput.series;
	self.orig_Model_Desc		:=	pInput.model;
	self.orig_Body_Desc			:=	if(	pInput.body_code	<>	'',
																	stringlib.StringToUpperCase(vehiclev2.translate_experian_body_codes(self.body_code)),
																	pInput.orig_body_desc
																);
	self										:=	pInput;
end;

dExperianFixName	:=	project(dExperianFixLesseeLessor,tFixName(left));

// Append sequence number so as to normalize records by address
rAppendAIDSeqNum_layout	:=
record
	unsigned6	Append_SeqNum				:=	0;
	string1		AddrInd							:=	'';
	string100	Append_PrepAddr1		:=	'';
	string50	Append_PrepAddr2		:=	'';
	AID.Common.xAID	Append_RawAID	:=	0;
	VehicleV2.Layout_Experian.Layout_Experian_Updating_as_VehicleV2;
end;

ut.MAC_Sequence_Records_NewRec(dExperianFixName,rAppendAIDSeqNum_layout,Append_SeqNum,dExpAppendSeqNum);

dExpAppendSeqNumDist	:=	distribute(dExpAppendSeqNum,hash(Append_SeqNum));

// Normalize records by address so as to pass to AddressID macro
rAppendAIDSeqNum_layout	tVehiclesNormAddr(dExpAppendSeqNumDist	pInput,integer	cnt)	:=
transform
	self.AddrInd					:=	choose(cnt,'P','M');
	self.Append_PrepAddr1	:=	choose(cnt,pInput.Append_PhysicalPrepAddr1,pInput.Append_MailPrepAddr1);
	self.Append_PrepAddr2	:=	choose(cnt,pInput.Append_PhysicalPrepAddr2,pInput.Append_MailPrepAddr2);
	self.Append_RawAID		:=	choose(cnt,pInput.Append_PhysicalAddrRawAID,pInput.Append_MailRawAID);
	self									:=	pInput;
end;

dExpNormalizeAddr	:=	normalize(dExpAppendSeqNumDist,2,tVehiclesNormAddr(left,counter),local);

// Pass to the AddressID macro and get back the raw addressID
dExpAddrLastPopulated			:=	dExpNormalizeAddr(Append_PrepAddr2	!=	'');
dExpAddrLastNotPopulated	:=	dExpNormalizeAddr(Append_PrepAddr2	=		'');

AID.MacAppendFromRaw_2Line(	dExpAddrLastPopulated,
														Append_PrepAddr1,
														Append_PrepAddr2,
														Append_RawAID,
														dExpAppendAID,
														AID.Common.eReturnValues.RawAID
													);

rAppendAIDSeqNum_layout	tAppendAID(dExpAppendAID	pInput)	:=
transform
	self.Append_RawAID	:=	pInput.AIDWork_RawAID;
	self								:=	pInput;
end;

dExperianAID	:=	project(dExpAppendAID,tAppendAID(left));

dExpAIDCombined			:=	dExperianAID	+	dExpAddrLastNotPopulated;
dExpAIDCombinedDist	:=	distribute(dExpAIDCombined,hash(Append_SeqNum));

// Denormalize records by address
rAppendAIDSeqNum_layout	tDenormAddr(dExpAppendSeqNumDist	le,dExpAIDCombinedDist	ri)	:=
transform
	self.Append_MailPrepAddr1				:=	if(ri.AddrInd	=	'M',ri.Append_PrepAddr1,le.Append_MailPrepAddr1);
	self.Append_MailPrepAddr2				:=	if(ri.AddrInd	=	'M',ri.Append_PrepAddr2,le.Append_MailPrepAddr2);
	self.Append_MailRawAID					:=	if(ri.AddrInd	=	'M',ri.Append_RawAID,le.Append_MailRawAID);
	self.Append_PhysicalPrepAddr1		:=	if(ri.AddrInd	=	'P',ri.Append_PrepAddr1,le.Append_PhysicalPrepAddr1);
	self.Append_PhysicalPrepAddr2		:=	if(ri.AddrInd	=	'P',ri.Append_PrepAddr2,le.Append_PhysicalPrepAddr2);
	self.Append_PhysicalAddrRawAID	:=	if(ri.AddrInd	=	'P',ri.Append_RawAID,le.Append_PhysicalAddrRawAID);
	
	self														:=	le;
end;

dExpDenormAddr	:=	denormalize(	dExpAppendSeqNumDist,
																	dExpAIDCombinedDist,
																	left.Append_SeqNum	=	right.Append_SeqNum,
																	tDenormAddr(left,right),
																	local
																);

dExperianAsVehicleV2	:=	project(dExpDenormAddr,VehicleV2.Layout_Experian.Layout_Experian_Updating_as_VehicleV2);

export	Map_Experian_Update	:=	dExperianAsVehicleV2;