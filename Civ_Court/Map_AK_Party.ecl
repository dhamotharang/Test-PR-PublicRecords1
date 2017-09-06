IMPORT Civ_Court, civil_court, crim_common, ut, Address, lib_StringLib, Std; 

#option('multiplePersistInstances',FALSE);
//original AbInitio mapping /stub_cleaning/court/work/mp/ak_civil_02_ffreplace.mp

fAlaska 	:= Civ_Court.File_In_AK.Input(case_type = 'Civil');

//Lookup Attorney name to replace attorney code
lkp_Attorney	:= sort(Civ_Court.File_In_AK.AttorneyCodesLkp,attorney_code);

civ_court.Layout_In_AK.Layout_AK lkpAtty1(fAlaska l, lkp_Attorney r) := Transform
tempAtty				:= If(trim(l.attorney1,all) <> '', trim(r.lastname,left,right)+' '+trim(r.firstname,left,right)+' '+trim(r.middlename,left,right),'');
tempAtty2				:= If(trim(l.attorney1,all) <> '' and REGEXFIND('^NULL',tempAtty),trim(r.companyname,left,right),tempAtty);
self.attorney1	:= StringLib.StringFindReplace(tempAtty2,'NULL',' ');
self := l;
end;

lAlaskaAtty1	:= join(fAlaska, lkp_Attorney,
										trim(left.attorney1,all) = trim(right.attorney_code,all),
										lkpAtty1(left,right),left outer, lookup);
										
civ_court.Layout_In_AK.Layout_AK lkpAtty2(lAlaskaAtty1 l, lkp_Attorney r) := Transform
tempAtty				:= If(trim(l.attorney2,all) <> '', trim(r.lastname,left,right)+' '+trim(r.firstname,left,right)+' '+trim(r.middlename,left,right),'');
tempAtty2				:= If(trim(l.attorney2,all) <> '' and REGEXFIND('^NULL',tempAtty),trim(r.companyname,left,right),tempAtty);
self.attorney2	:= StringLib.StringFindReplace(tempAtty2,'NULL',' ');
self := l;
end;

lAlaskaAtty2	:= join(lAlaskaAtty1, lkp_Attorney,
										trim(left.attorney2,all) = trim(right.attorney_code,all),
										lkpAtty2(left,right),left outer, lookup);



fmtsin := [
		'%m/%d/%Y',
		'%m/%d/%Y'
	];
	fmtout:='%Y%m%d';	

Civil_Court.Layout_In_Party tAlaska(lAlaskaAtty2 input, integer1 C) := Transform
self.process_date				:= civil_court.Version_Development;
self.vendor						  := '01';
self.state_origin				:= 'AK';
self.source_file				:= 'AK-CRIM-CIVIL-COURT';
self.case_key					  := '01'+ut.CleanSpacesAndUpper(input.case_num);
self.parent_case_key		:= '';
self.court_code					:= ut.CleanSpacesAndUpper(input.court_code);
self.court						  := 'ALASKA CIVIL COURT';
self.case_number				:= ut.CleanSpacesAndUpper(input.case_num);
self.case_type_code			:= '';
self.case_type					:= ut.CleanSpacesAndUpper(input.case_type);
UpperName								:= ut.CleanSpacesAndUpper(input.first_name+' '+input.middle_initial+' '+input.last_name);
UpperCompany						:= ut.CleanSpacesAndUpper(input.company_name);
ClnName									:= IF(trim(UpperName,all) = '',UpperCompany,UpperName);
ClnAtty1								:= ut.CleanSpacesAndUpper(input.attorney1);
ClnAtty2								:= ut.CleanSpacesAndUpper(input.attorney2);
self.entity_1						:= StringLib.StringCleanSpaces(CHOOSE(C, ClnName, ClnAtty1, ClnAtty2));
self.entity_nm_format_1	:= CHOOSE(C,'F','L','L');
self.entity_type_code_1_orig	:= ut.CleanSpacesAndUpper(input.type_person);
self.entity_type_description_1_orig := '';
self.entity_type_code_1_master := map(self.entity_type_code_1_orig = 'AKA' => '51',
																			self.entity_type_code_1_orig = 'APPL' => '70',
																			self.entity_type_code_1_orig = 'APET' => '70',
																			self.entity_type_code_1_orig = 'ATT' => '50',
																			self.entity_type_code_1_orig = 'DCDNT' => '70',
																			self.entity_type_code_1_orig = 'DFNDT' => '30',
																			self.entity_type_code_1_orig = '3DEF' => '30',
																			self.entity_type_code_1_orig = '4DEF' => '30',
																			self.entity_type_code_1_orig = '5DEF' => '30',
																			self.entity_type_code_1_orig = '6DEF' => '30',
																			self.entity_type_code_1_orig = 'GAL' => '70',
																			self.entity_type_code_1_orig = 'INTV' => '70',
																			self.entity_type_code_1_orig = 'MNR' => '70',
																			self.entity_type_code_1_orig = 'MPET' => '70',
																			self.entity_type_code_1_orig = 'PET' => '70',
																			self.entity_type_code_1_orig = 'PHY' => '70',
																			self.entity_type_code_1_orig = 'PLNTF' => '10',
																			self.entity_type_code_1_orig = '3PL' => '10',
																			self.entity_type_code_1_orig = '4PL' => '10',
																			self.entity_type_code_1_orig = '5PL' => '10',
																			self.entity_type_code_1_orig = '6PL' => '10',
																			self.entity_type_code_1_orig = 'RSPND' => '70', '90');
self.entity_1_dob	:= IF(input.birth_date <> '', 
                        Std.date.ConvertDateFormatMultiple(input.birth_date,fmtsin,fmtout),
															'');
self := [];
end;

pAlaska	:= normalize(lAlaskaAtty2,IF(trim(left.Attorney1,all) <> '' and trim(left.Attorney2,all) <> '',3,
																 IF(trim(left.Attorney1,all) <> '' and trim(left.Attorney2,all) = '',2,1)),tAlaska(left,counter));
																 
srtAlaska := sort(distribute(pAlaska(entity_1 <> ''),hash(entity_type_code_1_orig)),case_key,entity_type_code_1_orig,local);

//Lookup Person Type Codes
lkp_PersonType	:= sort(distribute(Civ_Court.File_In_AK.PersonTypeCodesLkp,hash(person_type_code)), person_type_code, local);

Civil_Court.Layout_In_Party lkpPartyDesc(srtAlaska l, lkp_PersonType r) := Transform
self.entity_type_description_1_orig := ut.CleanSpacesAndUpper(r.person_type_desc);
self := l;
end;

lAlaskaParty	:= join(srtAlaska, lkp_PersonType,
											trim(left.entity_type_code_1_orig,all) = trim(right.person_type_code,all),
											lkpPartyDesc(left,right),left outer,lookup,local);
											
//replace attorney entity_type descriptions
Civil_Court.Layout_In_Party fixAtty(lAlaskaParty l) := Transform
self.entity_type_description_1_orig := IF(l.entity_nm_format_1 = 'L' and l.entity_type_code_1_orig = 'DFNDT','ATTORNEY FOR DEFENDANT',
																				IF(l.entity_nm_format_1 = 'L' and l.entity_type_code_1_orig = 'PLNTF','ATTORNEY FOR PLAINTIFF',
																					IF(l.entity_nm_format_1 = 'L','ATTORNEY',l.entity_type_description_1_orig)));
self.entity_type_code_1_master := IF(l.entity_nm_format_1 = 'L' and l.entity_type_code_1_orig = 'DFNDT','40',
																		IF(l.entity_nm_format_1 = 'L' and l.entity_type_code_1_orig = 'PLNTF','20',
																				IF(l.entity_nm_format_1 = 'L','50',l.entity_type_code_1_master)));
self.entity_1_dob	:= IF(l.entity_nm_format_1 = 'L','',l.entity_1_dob);
self := l;
end;

fAttyRec	:= project(lAlaskaParty,fixAtty(left));
										
Civ_court.Civ_Court_Cleaner(fAttyRec,cleanAlaska);

ddAlaska 	:= dedup(sort(distribute(cleanAlaska,hash(case_key)),
                  process_date,case_key, court_code, court, case_number, case_type_code, case_type, entity_1, entity_nm_format_1, 
									entity_type_code_1_orig, entity_type_description_1_orig, entity_type_code_1_master, entity_1_dob, local),
									case_key, court_code, court, case_number, case_type_code, case_type, entity_1, entity_nm_format_1, 
									entity_type_code_1_orig, entity_type_description_1_orig, entity_type_code_1_master, entity_1_dob, local,left):
									PERSIST('~thor_data400::in::civil_alaska_party');

EXPORT Map_AK_Party := ddAlaska;