import	_control, PRTE_CSV,ut;

export  Proc_Build_MARI_Keys(string pIndexVersion)	:= function


rKeyMari__key__mari__autokey__address	:=
record
	PRTE_CSV.Proflic_Mari.rthor_data400__key__mari__autokey__address;
end;

rKeyMari__key__mari__autokey__addressb2	:=
record
PRTE_CSV.Proflic_Mari.rthor_data400__key__mari__autokey__addressb2;
end;

rKeyMari__key__mari__autokey__citystname	:=
record
	PRTE_CSV.Proflic_Mari.rthor_data400__key__mari__autokey__citystname;
end;

rKeyMari__key__mari__autokey__citystnameb2	:=
record
	PRTE_CSV.Proflic_Mari.rthor_data400__key__mari__autokey__citystnameb2;
end;

rKeyMari__key__mari__autokey__fein2	:=
record
	PRTE_CSV.Proflic_Mari.rthor_data400__key__mari__autokey__fein2;
end;


rKeyMari__key__mari__autokey__name	:=
record
	PRTE_CSV.Proflic_Mari.rthor_data400__key__mari__autokey__name;
end;

rKeyMari__key__mari__autokey__nameb2	:=
record
	PRTE_CSV.Proflic_Mari.rthor_data400__key__mari__autokey__nameb2;
end;

rKeyMari__key__mari__autokey__namewords2	:=
record
	PRTE_CSV.Proflic_Mari.rthor_data400__key__mari__autokey__namewords2;
end;


rKeyMari__key__mari__autokey__payload	:=
record
 PRTE_CSV.Proflic_Mari.rthor_data400__key__mari__autokey__payload;

end;

rKeyMari__key__mari__autokey__phone2	:=
record
	PRTE_CSV.Proflic_Mari.rthor_data400__key__mari__autokey__phone2;
end;


rKeyMari__key__mari__autokey__phoneb2	:=
record
	PRTE_CSV.Proflic_Mari.rthor_data400__key__mari__autokey__phoneb2;
end;

rKeyMari__key__mari__autokey__ssn2	:=
record
	PRTE_CSV.Proflic_Mari.rthor_data400__key__mari__autokey__ssn2;
end;

rKeyMari__key__mari__autokey__stname	:=
record
	PRTE_CSV.Proflic_Mari.rthor_data400__key__mari__autokey__stname;
end;

rKeyMari__key__mari__autokey__stnameb2	:=
record
	PRTE_CSV.Proflic_Mari.rthor_data400__key__mari__autokey__stnameb2;
end;

rKeyMari__key__mari__autokey__zip	:=
record
	PRTE_CSV.Proflic_Mari.rthor_data400__key__mari__autokey__zip;
end;

rKeyMari__key__mari__autokey__zipb2	:=
record
	PRTE_CSV.Proflic_Mari.rthor_data400__key__mari__autokey__zipb2;
end;

rKeyMari__key__mari__bdid	:=
record
	PRTE_CSV.Proflic_Mari.rthor_data400__key__mari__bdid;
end;

rKeyMari__key__mari__did	:=
record
	PRTE_CSV.Proflic_Mari.rthor_data400__key__mari__did;
end;

rKeyMari__key__mari__cmc_slpk	:=
record
	PRTE_CSV.Proflic_Mari.rthor_data400__key__mari__cmc_slpk;
end;

rKeyMari__key__mari__disciplinary_actions	:=
record
	PRTE_CSV.Proflic_Mari.rthor_data400__key__mari__disciplinary_actions;
end;

rKeyMari__key__mari__individual_detail	:=
record
	PRTE_CSV.Proflic_Mari.rthor_data400__key__mari__individual_detail;
end;

rKeyMari__key__mari__license_nbr	:=
record
	PRTE_CSV.Proflic_Mari.rthor_data400__key__mari__license_nbr;
end;

rKeyMari__key__mari__nmls_id	:=
record
	PRTE_CSV.Proflic_Mari.rthor_data400__key__mari__nmls_id;
end;

rKeyMari__key__mari__regulatory_actions	:=
record
	PRTE_CSV.Proflic_Mari.rthor_data400__key__mari__regulatory_actions;
end;

rKeyMari__key__mari__rid	:=
record
	PRTE_CSV.Proflic_Mari.rthor_data400__key__mari__rid;
end;

rKeyMari__key__mari__ssn_taxid	:=
record
	PRTE_CSV.Proflic_Mari.rthor_data400__key__mari__ssn_taxid;
end;

rKeyMari__key__mari__linkids	:=
record
	PRTE_CSV.Proflic_Mari.rthor_data400__key__mari__linkids;
end;

dKeyMari__key__mari__autokey__address 			:=project(PRTE_CSV.Proflic_Mari.dthor_data400__key__mari__autokey__address 	,rKeymari__key__mari__autokey__address	);
dKeyMari__key__mari__autokey__addressb2 		:=project(PRTE_CSV.Proflic_Mari.dthor_data400__key__mari__autokey__addressb2 	,rKeymari__key__mari__autokey__addressb2	);
dKeyMari__key__mari__autokey__citystname		:=project(PRTE_CSV.Proflic_Mari.dthor_data400__key__mari__autokey__citystname	,rKeymari__key__mari__autokey__citystname	);
dKeyMari__key__mari__autokey__citystnameb2 	:=project(PRTE_CSV.Proflic_Mari.dthor_data400__key__mari__autokey__citystnameb2 	,rKeymari__key__mari__autokey__citystnameb2	);
dKeyMari__key__mari__autokey__fein2 				:=project(PRTE_CSV.Proflic_Mari.dthor_data400__key__mari__autokey__fein2 	,rKeymari__key__mari__autokey__fein2	);
dKeyMari__key__mari__autokey__name 					:=project(PRTE_CSV.Proflic_Mari.dthor_data400__key__mari__autokey__name 	,rKeymari__key__mari__autokey__name	);
dKeyMari__key__mari__autokey__nameb2 				:=project(PRTE_CSV.Proflic_Mari.dthor_data400__key__mari__autokey__nameb2 	,rKeymari__key__mari__autokey__nameb2	);
dKeyMari__key__mari__autokey__namewords2 		:=project(PRTE_CSV.Proflic_Mari.dthor_data400__key__mari__autokey__namewords2 	,rKeymari__key__mari__autokey__namewords2	);
dKeyMari__key__mari__autokey__payload 			:=project(PRTE_CSV.Proflic_Mari.dthor_data400__key__mari__autokey__payload 	,rKeymari__key__mari__autokey__payload	);
dKeyMari__key__mari__autokey__phone2 				:=project(PRTE_CSV.Proflic_Mari.dthor_data400__key__mari__autokey__phone2 	,rKeymari__key__mari__autokey__phone2	);
dKeyMari__key__mari__autokey__phoneb2 			:=project(PRTE_CSV.Proflic_Mari.dthor_data400__key__mari__autokey__phoneb2 	,rKeymari__key__mari__autokey__phoneb2	);
dKeyMari__key__mari__autokey__ssn2 					:=project(PRTE_CSV.Proflic_Mari.dthor_data400__key__mari__autokey__ssn2 	,rKeymari__key__mari__autokey__ssn2	);
dKeyMari__key__mari__autokey__stname 				:=project(PRTE_CSV.Proflic_Mari.dthor_data400__key__mari__autokey__stname 	,rKeymari__key__mari__autokey__stname	);
dKeyMari__key__mari__autokey__stnameb2 			:=project(PRTE_CSV.Proflic_Mari.dthor_data400__key__mari__autokey__stnameb2 ,rKeymari__key__mari__autokey__stnameb2	);
dKeyMari__key__mari__autokey__zip 					:=project(PRTE_CSV.Proflic_Mari.dthor_data400__key__mari__autokey__zip 	,rKeymari__key__mari__autokey__zip	);
dKeyMari__key__mari__autokey__zipb2 				:=project(PRTE_CSV.Proflic_Mari.dthor_data400__key__mari__autokey__zipb2 	,rKeymari__key__mari__autokey__zipb2	);


dKeyMari__key__mari__bdid 									:=project(PRTE_CSV.Proflic_Mari.dthor_data400__key__mari__bdid(bdid != 0), TRANSFORM(rKeymari__key__mari__bdid,
																																																											self.PRIMARY_KEY			:= IF(trim(left.license_nbr)  <> '' and trim(left.license_nbr) <> 'NR', 
																																																																															HASH32(ut.fnTrim2Upper(left.license_nbr) + ','
																																																																																			+ ut.fnTrim2Upper(left.off_license_nbr) + ','
																																																																																			+ ut.fnTrim2Upper(left.license_state) + ','
																																																																																			+ ut.fnTrim2Upper(left.std_source_upd)),
																																																																																									0);
																																																												self.std_prof_desc		:= MAP(	left.std_prof_cd = 'MTG' => 'MORTGAGE LENDER',
																																																																											left.std_prof_cd = 'RLE' => 'REAL ESTATE',
																																																																																							'');
																																																												self.std_source_desc	:= MAP(	left.std_source_upd = 'S0021' => 'COMMONWEALTH OF MASSACHUSETTS',
																																																																											left.std_source_upd	= 'S0117' => 'HAWAII DEPARTMENT OF COMMERCE AND CONSUMER AFFAIRS',
																																																																											left.std_source_upd = 'S0280' => 'FLORIDA DEPARTMENT OF BUSINESS AND PROFESSIONAL REGULATION',
																																																																											left.std_source_upd = 'S0298' => 'MICHIGAN DEPT. OF LABOR & ECONOMIC GROWTH',
																																																																											left.std_source_upd = 'S0404' => 'VETERANS ADMINISTRATION',
																																																																											left.std_source_upd = 'S0513' => 'TN REGULATORY BOARDS AND COMMISSIONS/COMMERCE & INSURANCE',
																																																																											left.std_source_upd = 'S0611' => 'CALIFORNIA DEPARTMENT OF CORPORATIONS',
																																																																											left.std_source_upd = 'S0684' => 'WASHINGTON DEPARTMENT OF FINANCIAL INSTITUTIONS',
																																																																																						  '');
																																																																								self.name_office			:= left.company;
																																																																								self.name_company 		:= left.company;
																																																																								self.ssn_taxid_1 			:= left.ssn_taxid;
																																																																								self.tax_type_1				:= 'S';
																																																																								self.name_first				:= left.fname;
																																																																								self.name_mid					:= left.mname;
																																																																								self.name_last				:= left.lname;
																																																																								self.name_sufx				:= left.name_suffix;
																																																																								self.name_org					:= StringLib.StringCleanSpaces(left.lname+ ' '+left.fname);
																																																																								self.name_format			:= 'F';
																																																																								self.name_org_orig 		:= StringLib.StringCleanSpaces(left.fname + ' '+ left.mname + ' '+trim(left.lname,left,right)+ if(left.name_suffix != '',', '+left.name_suffix,''));
																																																																								self.name_mari_org		:= self.name_company;
																																																																								self.addr_addr1_1			:= StringLib.StringCleanSpaces(left.prim_range + ' '+left.predir + ' '+left.prim_name+' '+left.addr_suffix +' '+left.postdir);
																																																																								self.addr_addr2_1			:= StringLib.StringCleanSpaces(left.unit_desig+' '+left.sec_range);
																																																																								self.addr_city_1			:= left.city_name;
																																																																								self.addr_state_1			:= left.st;
																																																																								self.addr_zip5_1			:= left.zip5;
																																																																								self.addr_zip4_1			:= left.zip4;
																																																																								self.bus_prim_range		:= left.prim_range;
																																																																								self.bus_predir				:= left.predir;
																																																																								self.bus_prim_name		:= left.prim_name;
																																																																								self.bus_addr_suffix	:= left.addr_suffix;
																																																																								self.bus_postdir			:= left.postdir;
																																																																								self.bus_unit_desig		:= left.unit_desig;
																																																																								self.bus_sec_range		:= left.sec_range;
																																																																								self.bus_p_city_name	:= left.p_city_name;
																																																																								self.bus_v_city_name	:= left.city_name;
																																																																								self.bus_state				:= left.st;
																																																																								self.bus_zip5					:= left.zip5;
																																																																								self.bus_zip4					:= left.zip4;
																																																																								self.cmc_slpk					:= HASH64(left.std_source_upd + ','
																																																																																								+ left.license_nbr +','
																																																																																								+ left.license_state + ','
																																																																																								+ self.name_org_orig + ','
																																																																																								+ self.name_mari_org + ','
																																																																																								+ self.addr_addr1_1 + ','
																																																																																								+ self.addr_city_1 + ','
																																																																																								+ self.addr_state_1 + ','
																																																																																								+ self.addr_zip5_1);
																																																																																						
																																																																								self.affil_type_cd		:= map(left.type_cd = 'MD' => 'IN',
																																																																																						 left.type_cd = 'GR' => 'CO','');
																																																																								self.persistent_record_id		:= HASH64(left.COMPANY + ','
																																																																																											+	self.CMC_SLPK +','
																																																																																											+ left.PCMC_SLPK + ','
																																																																																											+ left.MLTRECKEY +','
																																																																																											+ self.AFFIL_TYPE_CD  +','
																																																																																											+ left.NMLS_ID	+ ','
																																																																																											+ left.FOREIGN_NMLS_ID + ','
																																																																																											+ left.LICENSE_ID + ','
																																																																																											+ left.REGULATOR + ','
																																																																																											+ left.FEDERAL_REGULATOR);		
																																																																								self := LEFT; 												
																																																																								self:= []));
dKeyMari__key__mari__did 										:=project(PRTE_CSV.Proflic_Mari.dthor_data400__key__mari__did(did != 0), TRANSFORM(rKeymari__key__mari__did,
																																																																							self.PRIMARY_KEY			:= IF(trim(left.license_nbr)  <> '' and trim(left.license_nbr) <> 'NR', 
																																																																																										HASH32(ut.fnTrim2Upper(left.license_nbr) + ','
																																																																																														+ ut.fnTrim2Upper(left.off_license_nbr) + ','
																																																																																														+ ut.fnTrim2Upper(left.license_state) + ','
																																																																																														+ ut.fnTrim2Upper(left.std_source_upd)),
																																																																																													0);
																																																																							self.std_prof_desc		:= MAP(	left.std_prof_cd = 'MTG' => 'MORTGAGE LENDER',
																																																																																						left.std_prof_cd = 'RLE' => 'REAL ESTATE',
																																																																																						 '');
																																																																							self.std_source_desc	:= MAP(	left.std_source_upd = 'S0021' => 'COMMONWEALTH OF MASSACHUSETTS',
																																																																																							left.std_source_upd	= 'S0117' => 'HAWAII DEPARTMENT OF COMMERCE AND CONSUMER AFFAIRS',
																																																																																							left.std_source_upd = 'S0280' => 'FLORIDA DEPARTMENT OF BUSINESS AND PROFESSIONAL REGULATION',
																																																																																							left.std_source_upd = 'S0298' => 'MICHIGAN DEPT. OF LABOR & ECONOMIC GROWTH',
																																																																																							left.std_source_upd = 'S0404' => 'VETERANS ADMINISTRATION',
																																																																																							left.std_source_upd = 'S0513' => 'TN REGULATORY BOARDS AND COMMISSIONS/COMMERCE & INSURANCE',
																																																																																							left.std_source_upd = 'S0611' => 'CALIFORNIA DEPARTMENT OF CORPORATIONS',
																																																																																							left.std_source_upd = 'S0684' => 'WASHINGTON DEPARTMENT OF FINANCIAL INSTITUTIONS',
																																																																																						  '');
																																																																							self.s_did				:= left.did;
																																																																							self.name_office	:= left.company;
																																																																							self.name_company := left.company;
																																																																							self.ssn_taxid_1 	:= left.ssn_taxid;
																																																																							self.tax_type_1		:= 'S';
																																																																							self.name_first		:= left.fname;
																																																																							self.name_mid			:= left.mname;
																																																																							self.name_last		:= left.lname;
																																																																							self.name_sufx		:= left.name_suffix;
																																																																							self.name_org			:= StringLib.StringCleanSpaces(left.lname+ ' '+left.fname);
																																																																							self.name_format	:= 'F';
																																																																							self.name_org_orig := StringLib.StringCleanSpaces(left.fname + ' '+ left.mname + ' '+trim(left.lname,left,right)+ if(left.name_suffix != '',', '+left.name_suffix,''));
																																																																							self.name_mari_org	:= self.name_company;
																																																																							self.addr_addr1_1	:= StringLib.StringCleanSpaces(left.prim_range + ' '+left.predir + ' '+left.prim_name+' '+left.addr_suffix +' '+left.postdir);
																																																																							self.addr_addr2_1	:= StringLib.StringCleanSpaces(left.unit_desig+' '+left.sec_range);
																																																																							self.addr_city_1	:= left.city_name;
																																																																							self.addr_state_1	:= left.st;
																																																																							self.addr_zip5_1	:= left.zip5;
																																																																							self.addr_zip4_1	:= left.zip4;
																																																																							self.bus_prim_range		:= left.prim_range;
																																																																							self.bus_predir				:= left.predir;
																																																																							self.bus_prim_name		:= left.prim_name;
																																																																							self.bus_addr_suffix	:= left.addr_suffix;
																																																																							self.bus_postdir			:= left.postdir;
																																																																							self.bus_unit_desig		:= left.unit_desig;
																																																																							self.bus_sec_range		:= left.sec_range;
																																																																							self.bus_p_city_name	:= left.p_city_name;
																																																																							self.bus_v_city_name	:= left.city_name;
																																																																							self.bus_state				:= left.st;
																																																																							self.bus_zip5					:= left.zip5;
																																																																							self.bus_zip4					:= left.zip4;
																																																																							self.cmc_slpk					:= HASH64(left.std_source_upd + ','
																																																																																								+ left.license_nbr +','
																																																																																								+ left.license_state + ','
																																																																																								+ self.name_org_orig + ','
																																																																																								+ self.name_mari_org + ','
																																																																																								+ self.addr_addr1_1 + ','
																																																																																								+ self.addr_city_1 + ','
																																																																																								+ self.addr_state_1 + ','
																																																																																								+ self.addr_zip5_1);
																																																																							self.affil_type_cd		:= map(left.type_cd = 'MD' => 'IN',
																																																																																					 left.type_cd = 'GR' => 'CO','');
																																																																							self.persistent_record_id		:= HASH64(left.COMPANY + ','
																																																																																											+	self.CMC_SLPK +','
																																																																																											+ left.PCMC_SLPK + ','
																																																																																											+ left.MLTRECKEY +','
																																																																																											+ self.AFFIL_TYPE_CD  +','
																																																																																											+ left.NMLS_ID	+ ','
																																																																																											+ left.FOREIGN_NMLS_ID + ','
																																																																																											+ left.LICENSE_ID + ','
																																																																																											+ left.REGULATOR + ','
																																																																																											+ left.FEDERAL_REGULATOR);
																																																																							self := LEFT;
																																																																							self:= []));
dKeyMari__key__mari__cmc_slpk								:=project(PRTE_CSV.Proflic_Mari.dthor_data400__key__mari__cmc_slpk, TRANSFORM(rKeymari__key__mari__cmc_slpk, 
																																																																												self.PRIMARY_KEY			:= IF(trim(left.license_nbr)  <> '' and trim(left.license_nbr) <> 'NR', 
																																																																																										HASH32(ut.fnTrim2Upper(left.license_nbr) + ','
																																																																																														+ ut.fnTrim2Upper(left.off_license_nbr) + ','
																																																																																														+ ut.fnTrim2Upper(left.license_state) + ','
																																																																																														+ ut.fnTrim2Upper(left.std_source_upd)),
																																																																																													0);	
																																																																												self.std_prof_desc		:= MAP(	left.std_prof_cd = 'MTG' => 'MORTGAGE LENDER',
																																																																																											left.std_prof_cd = 'RLE' => 'REAL ESTATE',
																																																																																											'');
																																																																												self.std_source_desc	:= MAP(	left.std_source_upd = 'S0021' => 'COMMONWEALTH OF MASSACHUSETTS',
																																																																																											left.std_source_upd	= 'S0117' => 'HAWAII DEPARTMENT OF COMMERCE AND CONSUMER AFFAIRS',
																																																																																											left.std_source_upd = 'S0280' => 'FLORIDA DEPARTMENT OF BUSINESS AND PROFESSIONAL REGULATION',
																																																																																											left.std_source_upd = 'S0298' => 'MICHIGAN DEPT. OF LABOR & ECONOMIC GROWTH',
																																																																																											left.std_source_upd = 'S0404' => 'VETERANS ADMINISTRATION',
																																																																																											left.std_source_upd = 'S0513' => 'TN REGULATORY BOARDS AND COMMISSIONS/COMMERCE & INSURANCE',
																																																																																											left.std_source_upd = 'S0611' => 'CALIFORNIA DEPARTMENT OF CORPORATIONS',
																																																																																											left.std_source_upd = 'S0684' => 'WASHINGTON DEPARTMENT OF FINANCIAL INSTITUTIONS',
																																																																																											'');
																																																																												self.name_office	:= left.company;
																																																																												self.name_company := left.company;
																																																																												self.ssn_taxid_1 	:= left.ssn_taxid;
																																																																												self.tax_type_1		:= 'S';
																																																																												self.name_first		:= left.fname;
																																																																												self.name_mid			:= left.mname;
																																																																												self.name_last		:= left.lname;
																																																																												self.name_sufx		:= left.name_suffix;
																																																																												self.name_org			:= StringLib.StringCleanSpaces(left.lname+ ' '+left.fname);
																																																																												self.name_org_orig := StringLib.StringCleanSpaces(left.fname + ' '+ left.mname + ' '+trim(left.lname,left,right)+ if(left.name_suffix != '',', '+left.name_suffix,''));
																																																																												self.name_format	:= 'F';
																																																																												self.name_mari_org	:= self.name_company;
																																																																												self.addr_addr1_1	:= StringLib.StringCleanSpaces(left.prim_range + ' '+left.predir + ' '+left.prim_name+' '+left.addr_suffix +' '+left.postdir);
																																																																												self.addr_addr2_1	:= StringLib.StringCleanSpaces(left.unit_desig+' '+left.sec_range);
																																																																												self.addr_city_1	:= left.city_name;
																																																																												self.addr_state_1	:= left.st;
																																																																												self.addr_zip5_1	:= left.zip5;
																																																																												self.addr_zip4_1	:= left.zip4;  
																																																																												self.bus_prim_range		:= left.prim_range;
																																																																												self.bus_predir				:= left.predir;
																																																																												self.bus_prim_name		:= left.prim_name;
																																																																												self.bus_addr_suffix	:= left.addr_suffix;
																																																																												self.bus_postdir			:= left.postdir;
																																																																												self.bus_unit_desig		:= left.unit_desig;
																																																																												self.bus_sec_range		:= left.sec_range;
																																																																												self.bus_p_city_name	:= left.p_city_name;
																																																																												self.bus_v_city_name	:= left.city_name;
																																																																												self.bus_state				:= left.st;
																																																																												self.bus_zip5					:= left.zip5;
																																																																												self.bus_zip4					:= left.zip4;
																																																																												self.cmc_slpk					:= HASH64(left.std_source_upd + ','
																																																																																								+ left.license_nbr +','
																																																																																								+ left.license_state + ','
																																																																																								+ self.name_org_orig + ','
																																																																																								+ self.name_mari_org + ','
																																																																																								+ self.addr_addr1_1 + ','
																																																																																								+ self.addr_city_1 + ','
																																																																																								+ self.addr_state_1 + ','
																																																																																								+ self.addr_zip5_1);
																																																																												self.affil_type_cd		:= map(left.type_cd = 'MD' => 'IN',
																																																																																										 left.type_cd = 'GR' => 'CO','');
																																																																												
																																																																												self.persistent_record_id		:= HASH64(left.COMPANY + ','
																																																																																											+	self.CMC_SLPK +','
																																																																																											+ left.PCMC_SLPK + ','
																																																																																											+ left.MLTRECKEY +','
																																																																																											+ self.AFFIL_TYPE_CD  +','
																																																																																											+ left.NMLS_ID	+ ','
																																																																																											+ left.FOREIGN_NMLS_ID + ','
																																																																																											+ left.LICENSE_ID + ','
																																																																																											+ left.REGULATOR + ','
																																																																																											+ left.FEDERAL_REGULATOR);
																																																																												self := LEFT;
																																																																												self:= []));
dKeyMari__key__mari__disciplinary_actions		:=project(PRTE_CSV.Proflic_Mari.dthor_data400__key__mari__disciplinary_actions,rKeymari__key__mari__disciplinary_actions	);
dKeyMari__key__mari__individual_detail			:=project(PRTE_CSV.Proflic_Mari.dthor_data400__key__mari__individual_detail,rKeymari__key__mari__individual_detail	);
dKeyMari__key__mari__license_nbr						:=project(PRTE_CSV.Proflic_Mari.dthor_data400__key__mari__license_nbr(cln_license_nbr != '' and cln_license_nbr != 'NR'), TRANSFORM(rKeymari__key__mari__license_nbr, 
																																																																															self.PRIMARY_KEY			:= IF(trim(left.license_nbr)  <> '' and trim(left.license_nbr) <> 'NR', 
																																																																																										HASH32(ut.fnTrim2Upper(left.license_nbr) + ','
																																																																																														+ ut.fnTrim2Upper(left.off_license_nbr) + ','
																																																																																														+ ut.fnTrim2Upper(left.license_state) + ','
																																																																																														+ ut.fnTrim2Upper(left.std_source_upd)),
																																																																																													0);
																																																																															self.std_prof_desc		:= MAP(	left.std_prof_cd = 'MTG' => 'MORTGAGE LENDER',
																																																																																														left.std_prof_cd = 'RLE' => 'REAL ESTATE',
																																																																																															'');
																																																																															self.std_source_desc	:= MAP(	left.std_source_upd = 'S0021' => 'COMMONWEALTH OF MASSACHUSETTS',
																																																																																														left.std_source_upd	= 'S0117' => 'HAWAII DEPARTMENT OF COMMERCE AND CONSUMER AFFAIRS',
																																																																																														left.std_source_upd = 'S0280' => 'FLORIDA DEPARTMENT OF BUSINESS AND PROFESSIONAL REGULATION',
																																																																																														left.std_source_upd = 'S0298' => 'MICHIGAN DEPT. OF LABOR & ECONOMIC GROWTH',
																																																																																														left.std_source_upd = 'S0404' => 'VETERANS ADMINISTRATION',
																																																																																														left.std_source_upd = 'S0513' => 'TN REGULATORY BOARDS AND COMMISSIONS/COMMERCE & INSURANCE',
																																																																																														left.std_source_upd = 'S0611' => 'CALIFORNIA DEPARTMENT OF CORPORATIONS',
																																																																																														left.std_source_upd = 'S0684' => 'WASHINGTON DEPARTMENT OF FINANCIAL INSTITUTIONS',
																																																																																														'');
																																																																															self.name_office	:= left.company;	
																																																																															self.name_company := left.company;
																																																																															self.ssn_taxid_1 	:= left.ssn_taxid;
																																																																															self.tax_type_1		:= 'S';	
																																																																															self.name_first		:= left.fname;
																																																																															self.name_mid			:= left.mname;
																																																																															self.name_last		:= left.lname;
																																																																															self.name_sufx		:= left.name_suffix;
																																																																															self.name_org			:= StringLib.StringCleanSpaces(left.lname+ ' '+left.fname);
																																																																															self.name_format	:= 'F';
																																																																															self.name_org_orig := StringLib.StringCleanSpaces(left.fname + ' '+ left.mname + ' '+trim(left.lname,left,right)+ if(left.name_suffix != '',', '+left.name_suffix,''));
																																																																															self.name_mari_org	:= self.name_company;
																																																																															self.addr_addr1_1	:= StringLib.StringCleanSpaces(left.prim_range + ' '+left.predir + ' '+left.prim_name+' '+left.addr_suffix +' '+left.postdir);
																																																																															self.addr_addr2_1	:= StringLib.StringCleanSpaces(left.unit_desig+' '+left.sec_range);
																																																																															self.addr_city_1	:= left.city_name;
																																																																															self.addr_state_1	:= left.st;
																																																																															self.addr_zip5_1	:= left.zip5;
																																																																															self.addr_zip4_1	:= left.zip4;
																																																																															self.bus_prim_range		:= left.prim_range;
																																																																															self.bus_predir				:= left.predir;
																																																																															self.bus_prim_name		:= left.prim_name;
																																																																															self.bus_addr_suffix	:= left.addr_suffix;
																																																																															self.bus_postdir			:= left.postdir;
																																																																															self.bus_unit_desig		:= left.unit_desig;
																																																																															self.bus_sec_range		:= left.sec_range;
																																																																															self.bus_p_city_name	:= left.p_city_name;
																																																																															self.bus_v_city_name	:= left.city_name;
																																																																															self.bus_state				:= left.st;
																																																																															self.bus_zip5					:= left.zip5;
																																																																															self.bus_zip4					:= left.zip4;
																																																																															self.cmc_slpk					:= HASH64(left.std_source_upd + ','
																																																																																															+ left.license_nbr +','
																																																																																															+ left.license_state + ','
																																																																																															+ self.name_org_orig + ','
																																																																																															+ self.name_mari_org + ','
																																																																																															+ self.addr_addr1_1 + ','
																																																																																															+ self.addr_city_1 + ','
																																																																																															+ self.addr_state_1 + ','
																																																																																															+ self.addr_zip5_1);
																																																																															self.affil_type_cd		:= map(left.type_cd = 'MD' => 'IN',
																																																																																													left.type_cd = 'GR' => 'CO','');
																																																																															self.persistent_record_id		:= HASH64(left.COMPANY + ','
																																																																																																		+	self.CMC_SLPK +','
																																																																																																		+ left.PCMC_SLPK + ','
																																																																																																		+ left.MLTRECKEY +','
																																																																																																		+ self.AFFIL_TYPE_CD  +','
																																																																																																		+ left.NMLS_ID	+ ','
																																																																																																		+ left.FOREIGN_NMLS_ID + ','
																																																																																																		+ left.LICENSE_ID + ','
																																																																																																		+ left.REGULATOR + ','
																																																																																																		+ left.FEDERAL_REGULATOR);																																																																															
																																																																															self := LEFT;
																																																																															self:= []));
dKeyMari__key__mari__nmls_id								:=project(PRTE_CSV.Proflic_Mari.dthor_data400__key__mari__nmls_id,rKeymari__key__mari__nmls_id	);
dKeyMari__key__mari__regulatory_actions			:=project(PRTE_CSV.Proflic_Mari.dthor_data400__key__mari__regulatory_actions,rKeymari__key__mari__regulatory_actions	);
dKeyMari__key__mari__rid										:=project(PRTE_CSV.Proflic_Mari.dthor_data400__key__mari__rid, TRANSFORM(rKeymari__key__mari__rid, 
																																																																							self.PRIMARY_KEY			:= IF(trim(left.license_nbr)  <> '' and trim(left.license_nbr) <> 'NR', 
																																																																																										HASH32(ut.fnTrim2Upper(left.license_nbr) + ','
																																																																																														+ ut.fnTrim2Upper(left.off_license_nbr) + ','
																																																																																														+ ut.fnTrim2Upper(left.license_state) + ','
																																																																																														+ ut.fnTrim2Upper(left.std_source_upd)),
																																																																																													0);
																																																																							self.std_prof_desc		:= MAP(	left.std_prof_cd = 'MTG' => 'MORTGAGE LENDER',
																																																																																						left.std_prof_cd = 'RLE' => 'REAL ESTATE',
																																																																																						 '');
																																																																							self.std_source_desc	:= MAP(	left.std_source_upd = 'S0021' => 'COMMONWEALTH OF MASSACHUSETTS',
																																																																																						left.std_source_upd	= 'S0117' => 'HAWAII DEPARTMENT OF COMMERCE AND CONSUMER AFFAIRS',
																																																																																						left.std_source_upd = 'S0280' => 'FLORIDA DEPARTMENT OF BUSINESS AND PROFESSIONAL REGULATION',
																																																																																						left.std_source_upd = 'S0298' => 'MICHIGAN DEPT. OF LABOR & ECONOMIC GROWTH',
																																																																																						left.std_source_upd = 'S0404' => 'VETERANS ADMINISTRATION',
																																																																																						left.std_source_upd = 'S0513' => 'TN REGULATORY BOARDS AND COMMISSIONS/COMMERCE & INSURANCE',
																																																																																						left.std_source_upd = 'S0611' => 'CALIFORNIA DEPARTMENT OF CORPORATIONS',
																																																																																						left.std_source_upd = 'S0684' => 'WASHINGTON DEPARTMENT OF FINANCIAL INSTITUTIONS',
																																																																																						  '');

																																																																							self.name_office	:= left.company;
																																																																							self.name_company := left.company;
																																																																							self.ssn_taxid_1 	:= left.ssn_taxid;
																																																																							self.tax_type_1		:= 'S';
																																																																							self.name_first		:= left.fname;
																																																																							self.name_mid			:= left.mname;
																																																																							self.name_last		:= left.lname;
																																																																							self.name_sufx		:= left.name_suffix;
																																																																							self.name_org			:= StringLib.StringCleanSpaces(left.lname+ ' '+left.fname);
																																																																							self.name_format	:= 'F';
																																																																							self.name_org_orig := StringLib.StringCleanSpaces(left.fname + ' '+ left.mname + ' '+trim(left.lname,left,right)+ if(left.name_suffix != '',', '+left.name_suffix,''));
																																																																							self.name_mari_org	:= self.name_company;
																																																																							self.addr_addr1_1	:= StringLib.StringCleanSpaces(left.prim_range + ' '+left.predir + ' '+left.prim_name+' '+left.addr_suffix +' '+left.postdir);
																																																																							self.addr_addr2_1	:= StringLib.StringCleanSpaces(left.unit_desig+' '+left.sec_range);
																																																																							self.addr_city_1	:= left.city_name;
																																																																							self.addr_state_1	:= left.st;
																																																																							self.addr_zip5_1	:= left.zip5;
																																																																							self.addr_zip4_1	:= left.zip4;	
																																																																							self.bus_prim_range		:= left.prim_range;
																																																																						  self.bus_predir				:= left.predir;
																																																																							self.bus_prim_name		:= left.prim_name;
																																																																							self.bus_addr_suffix	:= left.addr_suffix;
																																																																							self.bus_postdir			:= left.postdir;
																																																																							self.bus_unit_desig		:= left.unit_desig;
																																																																							self.bus_sec_range		:= left.sec_range;
																																																																							self.bus_p_city_name	:= left.p_city_name;
																																																																							self.bus_v_city_name	:= left.city_name;
																																																																							self.bus_state				:= left.st;
																																																																							self.bus_zip5					:= left.zip5;
																																																																							self.bus_zip4					:= left.zip4;
																																																																							self.cmc_slpk					:= HASH64(left.std_source_upd + ','
																																																																																							+ left.license_nbr +','
																																																																																							+ left.license_state + ','
																																																																																							+ self.name_org_orig + ','
																																																																																							+ self.name_mari_org + ','
																																																																																							+ self.addr_addr1_1 + ','
																																																																																							+ self.addr_city_1 + ','
																																																																																							+ self.addr_state_1 + ','
																																																																																							+ self.addr_zip5_1);
																																																																							self.affil_type_cd		:= map(left.type_cd = 'MD' => 'IN',
																																																																																					 left.type_cd = 'GR' => 'CO','');
																																																																							self.persistent_record_id		:= HASH64(left.COMPANY + ','
																																																																																											+	self.CMC_SLPK +','
																																																																																											+ left.PCMC_SLPK + ','
																																																																																											+ left.MLTRECKEY +','
																																																																																											+ self.AFFIL_TYPE_CD  +','
																																																																																											+ left.NMLS_ID	+ ','
																																																																																											+ left.FOREIGN_NMLS_ID + ','
																																																																																											+ left.LICENSE_ID + ','
																																																																																											+ left.REGULATOR + ','
																																																																																											+ left.FEDERAL_REGULATOR);														 
																																																																							self := LEFT;
																																																																							self := []));
dKeyMari__key__mari__ssn_taxid							:=project(PRTE_CSV.Proflic_Mari.dthor_data400__key__mari__ssn_taxid(ssn_taxid != ''), TRANSFORM(rKeymari__key__mari__ssn_taxid,
																																																																													self.tax_type				:= 'S4';
																																																																													self.ssn_taxid			:= if(left.ssn_taxid != '' and left.ssn_taxid[6..9] != '0000', left.ssn_taxid[6..9],'');		
																																																																													self := LEFT;
																																																																													self:= []));
dKeyMari__key__mari__did_fcra								:=project(PRTE_CSV.Proflic_Mari.dthor_data400__key__mari__did(did != 0), TRANSFORM(rKeymari__key__mari__did, 
																																																																							self.s_did						:= left.did;
																																																																							self.PRIMARY_KEY			:= IF(trim(left.license_nbr)  <> '' and trim(left.license_nbr) <> 'NR', 
																																																																																										HASH32(ut.fnTrim2Upper(left.license_nbr) + ','
																																																																																														+ ut.fnTrim2Upper(left.off_license_nbr) + ','
																																																																																														+ ut.fnTrim2Upper(left.license_state) + ','
																																																																																														+ ut.fnTrim2Upper(left.std_source_upd)),
																																																																																													0);
																																																																							self.std_prof_desc		:= MAP(	left.std_prof_cd = 'MTG' => 'MORTGAGE LENDER',
																																																																																						left.std_prof_cd = 'RLE' => 'REAL ESTATE',
																																																																																						 '');
																																																																							self.std_source_desc	:= MAP(	left.std_source_upd = 'S0021' => 'COMMONWEALTH OF MASSACHUSETTS',
																																																																																						left.std_source_upd	= 'S0117' => 'HAWAII DEPARTMENT OF COMMERCE AND CONSUMER AFFAIRS',
																																																																																						left.std_source_upd = 'S0280' => 'FLORIDA DEPARTMENT OF BUSINESS AND PROFESSIONAL REGULATION',
																																																																																						left.std_source_upd = 'S0298' => 'MICHIGAN DEPT. OF LABOR & ECONOMIC GROWTH',
																																																																																						left.std_source_upd = 'S0404' => 'VETERANS ADMINISTRATION',
																																																																																						left.std_source_upd = 'S0513' => 'TN REGULATORY BOARDS AND COMMISSIONS/COMMERCE & INSURANCE',
																																																																																						left.std_source_upd = 'S0611' => 'CALIFORNIA DEPARTMENT OF CORPORATIONS',
																																																																																						left.std_source_upd = 'S0684' => 'WASHINGTON DEPARTMENT OF FINANCIAL INSTITUTIONS',
																																																																																						  '');
																																																																							self.name_office	:= left.company;	
																																																																							self.name_company := left.company;
																																																																							self.ssn_taxid_1 	:= left.ssn_taxid;
																																																																							self.tax_type_1		:= 'S';
																																																																							self.name_first		:= left.fname;
																																																																							self.name_mid			:= left.mname;
																																																																							self.name_last		:= left.lname;
																																																																							self.name_sufx		:= left.name_suffix;
																																																																							self.name_org			:= StringLib.StringCleanSpaces(left.lname+ ' '+left.fname);
																																																																							self.name_format	:= 'F';
																																																																							self.name_org_orig := StringLib.StringCleanSpaces(left.fname + ' '+ left.mname + ' '+trim(left.lname,left,right)+ if(left.name_suffix != '',', '+left.name_suffix,''));
																																																																							self.name_mari_org	:= self.name_company;
																																																																							self.addr_addr1_1	:= StringLib.StringCleanSpaces(left.prim_range + ' '+left.predir + ' '+left.prim_name+' '+left.addr_suffix +' '+left.postdir);
																																																																							self.addr_addr2_1	:= StringLib.StringCleanSpaces(left.unit_desig+' '+left.sec_range);
																																																																							self.addr_city_1	:= left.city_name;
																																																																							self.addr_state_1	:= left.st;
																																																																							self.addr_zip5_1	:= left.zip5;
																																																																							self.addr_zip4_1	:= left.zip4;
																																																																							self.bus_prim_range		:= left.prim_range;
																																																																							self.bus_predir				:= left.predir;
																																																																							self.bus_prim_name		:= left.prim_name;
																																																																							self.bus_addr_suffix	:= left.addr_suffix;
																																																																							self.bus_postdir			:= left.postdir;
																																																																							self.bus_unit_desig		:= left.unit_desig;
																																																																							self.bus_sec_range		:= left.sec_range;
																																																																							self.bus_p_city_name	:= left.p_city_name;
																																																																							self.bus_v_city_name	:= left.city_name;
																																																																							self.bus_state				:= left.st;
																																																																							self.bus_zip5					:= left.zip5;
																																																																							self.bus_zip4					:= left.zip4;
																																																																							self.cmc_slpk					:= HASH64(left.std_source_upd + ','
																																																																																							+ left.license_nbr +','
																																																																																							+ left.license_state + ','
																																																																																							+ self.name_org_orig + ','
																																																																																							+ self.name_mari_org + ','
																																																																																							+ self.addr_addr1_1 + ','
																																																																																							+ self.addr_city_1 + ','
																																																																																							+ self.addr_state_1 + ','
																																																																																							+ self.addr_zip5_1);
																																																																								self.affil_type_cd		:= map(left.type_cd = 'MD' => 'IN',
																																																																																						 left.type_cd = 'GR' => 'CO','');
																																																																								self.persistent_record_id		:= HASH64(left.COMPANY + ','
																																																																																											+	self.CMC_SLPK +','
																																																																																											+ left.PCMC_SLPK + ','
																																																																																											+ left.MLTRECKEY +','
																																																																																											+ self.AFFIL_TYPE_CD  +','
																																																																																											+ left.NMLS_ID	+ ','
																																																																																											+ left.FOREIGN_NMLS_ID + ','
																																																																																											+ left.LICENSE_ID + ','
																																																																																											+ left.REGULATOR + ','
																																																																																											+ left.FEDERAL_REGULATOR);	
																																																																								self := LEFT;
																																																																								self:= []));


dKeyMari__key__mari__linkids								:=project(PRTE_CSV.Proflic_Mari.dthor_data400__key__mari__linkids, rKeyMari__key__mari__linkids	);


kKeymari__key__mari__autokey__address 		:= index(dKeymari__key__mari__autokey__address, {prim_name,prim_range,st,city_code,zip,sec_range,dph_lname,lname,pfname,fname,states,lname1,lname2,lname3,lookups}, {dKeymari__key__mari__autokey__address}, '~prte::key::proflic_mari::'+pIndexVersion+'::autokey::address');
kKeymari__key__mari__autokey__addressb2 	:= index(dKeymari__key__mari__autokey__addressb2, {prim_name,prim_range,st,city_code,zip,sec_range,cname_indic,cname_sec,bdid}, {dKeymari__key__mari__autokey__addressb2}, '~prte::key::proflic_mari::'+pIndexVersion+'::autokey::addressb2');
kKeymari__key__mari__autokey__citystname 	:= index(dKeymari__key__mari__autokey__citystname, {city_code,st,dph_lname,lname,pfname,fname,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeymari__key__mari__autokey__citystname}, '~prte::key::proflic_mari::'+pIndexVersion+'::autokey::citystname');
kKeymari__key__mari__autokey__citystnameb2:= index(dKeymari__key__mari__autokey__citystnameb2, {city_code,st,cname_indic,cname_sec,bdid}, {dKeymari__key__mari__autokey__citystnameb2}, '~prte::key::proflic_mari::'+pIndexVersion+'::autokey::citystnameb2');
kKeymari__key__mari__autokey__fein2 		  := index(dKeymari__key__mari__autokey__fein2, {f1,f2,f3,f4,f5,f6,f7,f8,f9,cname_indic,cname_sec,bdid}, {dKeymari__key__mari__autokey__fein2}, '~prte::key::proflic_mari::'+pIndexVersion+'::autokey::fein2');
kKeymari__key__mari__autokey__name 		  	:= index(dKeymari__key__mari__autokey__name, {dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeymari__key__mari__autokey__name}, '~prte::key::proflic_mari::'+pIndexVersion+'::autokey::name');
kKeymari__key__mari__autokey__nameb2 			:= index(dKeymari__key__mari__autokey__nameb2, {cname_indic,cname_sec,bdid}, {dKeymari__key__mari__autokey__nameb2}, '~prte::key::proflic_mari::'+pIndexVersion+'::autokey::nameb2');
kKeymari__key__mari__autokey__namewords2	:= index(dKeymari__key__mari__autokey__namewords2, {word,state,seq,bdid}, {dKeymari__key__mari__autokey__namewords2}, '~prte::key::proflic_mari::'+pIndexVersion+'::autokey::namewords2');
kKeymari__key__mari__autokey__payload 		:= index(dKeymari__key__mari__autokey__payload, {fakeid}, {dKeymari__key__mari__autokey__payload}, '~prte::key::proflic_mari::'+pIndexVersion+'::autokey::payload');
kKeymari__key__mari__autokey__phone2 			:= index(dKeymari__key__mari__autokey__phone2, {p7,p3,dph_lname,pfname,st,did}, {dKeymari__key__mari__autokey__phone2}, '~prte::key::proflic_mari::'+pIndexVersion+'::autokey::phone2');
kKeymari__key__mari__autokey__phoneb2 		:= index(dKeymari__key__mari__autokey__phoneb2, {p7,p3,cname_indic,cname_sec,st,bdid}, {dKeymari__key__mari__autokey__phoneb2}, '~prte::key::proflic_mari::'+pIndexVersion+'::autokey::phoneb2');
kKeymari__key__mari__autokey__ssn2 		  	:= index(dKeymari__key__mari__autokey__ssn2, {s1,s2,s3,s4,s5,s6,s7,s8,s9,dph_lname,pfname,did}, {dKeymari__key__mari__autokey__ssn2}, '~prte::key::proflic_mari::'+pIndexVersion+'::autokey::ssn2');
kKeymari__key__mari__autokey__stname 			:= index(dKeymari__key__mari__autokey__stname, {st,dph_lname,lname,pfname,fname,minit,yob,s4,zip,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeymari__key__mari__autokey__stname}, '~prte::key::proflic_mari::'+pIndexVersion+'::autokey::stname');
kKeymari__key__mari__autokey__stnameb2 		:= index(dKeymari__key__mari__autokey__stnameb2, {st,cname_indic,cname_sec,bdid}, {dKeymari__key__mari__autokey__stnameb2}, '~prte::key::proflic_mari::'+pIndexVersion+'::autokey::stnameb2');
kKeymari__key__mari__autokey__zip 				:= index(dKeymari__key__mari__autokey__zip, {zip,dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeymari__key__mari__autokey__zip}, '~prte::key::proflic_mari::'+pIndexVersion+'::autokey::zip');
kKeymari__key__mari__autokey__zipb2 			:= index(dKeymari__key__mari__autokey__zipb2, {zip,cname_indic,cname_sec,bdid}, {dKeymari__key__mari__autokey__zipb2}, '~prte::key::proflic_mari::'+pIndexVersion+'::autokey::zipb2');

kKeymari__key__mari__bdid 								:= index(dKeymari__key__mari__bdid, {bdid}, {dKeymari__key__mari__bdid}, '~prte::key::proflic_mari::'+pIndexVersion+'::bdid');
kKeymari__key__mari__did 									:= index(dKeymari__key__mari__did, {s_did}, {dKeymari__key__mari__did}, '~prte::key::proflic_mari::'+pIndexVersion+'::did');
kKeymari__key__mari__cmc_slpk 						:= index(dKeymari__key__mari__cmc_slpk, {cmc_slpk, affil_type_cd,std_source_upd}, {dKeymari__key__mari__cmc_slpk}, '~prte::key::proflic_mari::'+pIndexVersion+'::cmc_slpk');
kKeymari__key__mari__disciplinary_actions := index(dKeymari__key__mari__disciplinary_actions, {individual_nmls_id}, {dKeymari__key__mari__disciplinary_actions}, '~prte::key::proflic_mari::'+pIndexVersion+'::disciplinary_actions');
kKeymari__key__mari__individual_detail 		:= index(dKeymari__key__mari__individual_detail, {individual_nmls_id}, {dKeymari__key__mari__individual_detail}, '~prte::key::proflic_mari::'+pIndexVersion+'::individual_detail');
kKeymari__key__mari__license_nbr 					:= index(dKeymari__key__mari__license_nbr, {cln_license_nbr, license_state}, {dKeymari__key__mari__license_nbr}, '~prte::key::proflic_mari::'+pIndexVersion+'::license_nbr');
kKeymari__key__mari__nmls_id 			    		:= index(dKeymari__key__mari__nmls_id, {nmls_id}, {dKeymari__key__mari__nmls_id}, '~prte::key::proflic_mari::'+pIndexVersion+'::nmls_id');
kKeymari__key__mari__regulatory_actions 	:= index(dKeymari__key__mari__regulatory_actions, {nmls_id, affil_type_cd}, {dKeymari__key__mari__regulatory_actions}, '~prte::key::proflic_mari::'+pIndexVersion+'::regulatory_actions');
kKeymari__key__mari__rid 			    				:= index(dKeymari__key__mari__rid, {mari_rid}, {dKeymari__key__mari__rid}, '~prte::key::proflic_mari::'+pIndexVersion+'::rid');
kKeymari__key__mari__ssn_taxid 			    	:= index(dKeymari__key__mari__ssn_taxid, {ssn_taxid, tax_type}, {dKeymari__key__mari__ssn_taxid}, '~prte::key::proflic_mari::'+pIndexVersion+'::ssn_taxid');

kKeymari__key__mari__linkids	    				:= index(dKeymari__key__mari__linkids, {ultid,orgid,seleid,proxid,powid,empid,dotid,ultscore,orgscore,selescore,proxscore,powscore,empscore,dotscore,ultweight,orgweight,seleweight,proxweight,powweight,empweight,dotweight}, 
																									{dKeymari__key__mari__linkids}, '~prte::key::proflic_mari::'+pIndexVersion+'::linkids');

  
kKeymari__key__mari__did_fcra							:= index(dKeymari__key__mari__did_fcra, {s_did}, {dKeymari__key__mari__did_fcra}, '~prte::key::proflic_mari::fcra::'+pIndexVersion+'::did');

return	sequential(
														parallel(
																build(kKeymari__key__mari__autokey__address,  update),
																build(kKeymari__key__mari__autokey__addressb2,  update),
																build(kKeymari__key__mari__autokey__citystname,  update),
																build(kKeymari__key__mari__autokey__citystnameb2,  update),
																build(kKeymari__key__mari__autokey__fein2,  update),
																build(kKeymari__key__mari__autokey__name,  update),
																build(kKeymari__key__mari__autokey__nameb2,  update),
																build(kKeymari__key__mari__autokey__namewords2,  update),
																build(kKeymari__key__mari__autokey__payload ,  update),
																build(kKeymari__key__mari__autokey__phone2,  update),
																build(kKeymari__key__mari__autokey__phoneb2,  update),
																build(kKeymari__key__mari__autokey__ssn2,  update),
																build(kKeymari__key__mari__autokey__stname,  update),
																build(kKeymari__key__mari__autokey__stnameb2,  update),
																build(kKeymari__key__mari__autokey__zip,  update),
																build(kKeymari__key__mari__autokey__zipb2,  update),
																build(kKeymari__key__mari__bdid,  update),
																build(kKeymari__key__mari__did,  update),
																build(kKeymari__key__mari__cmc_slpk,  update),
																build(kKeymari__key__mari__disciplinary_actions,  update),
																build(kKeymari__key__mari__individual_detail,  update),
																build(kKeymari__key__mari__license_nbr,  update),
																build(kKeymari__key__mari__nmls_id,  update),
																build(kKeymari__key__mari__regulatory_actions,  update),
																build(kKeymari__key__mari__rid,  update),
																build(kKeymari__key__mari__ssn_taxid,  update),
																build(kKeymari__key__mari__linkids, update),
																build(kKeymari__key__mari__did_fcra,  update)
																)
																// ,

   											// PRTE.UpdateVersion('MariKeys ',										//	Package name
   																				 // pIndexVersion,												//	Package version
   																				 // _control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
   																				 // 'B',																	//	B = Boca, A = Alpharetta
   																				 // 'N',																	//	N = Non-FCRA, F = FCRA
   																				 // 'N'																	//	N = Do not also include boolean, Y = Include boolean, too
   																// ),
												// PRTE.UpdateVersion('FCRA_MariKeys ',										//	Package name
   																				 // pIndexVersion,												//	Package version
   																				 // _control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
   																				 // 'B',																	//	B = Boca, A = Alpharetta
   																				 // 'F',																	//	N = Non-FCRA, F = FCRA
   																				 // 'N'																	//	N = Do not also include boolean, Y = Include boolean, too
   																// )					
								);
								 

end;

