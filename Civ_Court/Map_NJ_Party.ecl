IMPORT Civ_Court, civil_court, ut,  Address, lib_StringLib;

#option('multiplePersistInstances',FALSE);

//original AbInitio mapping /stub_cleaning/court/work/mp/nj_civil_02.mp

CaseHeader	:= Civ_Court.Files_In_NJ.case_header; //used for case_title
Party				:= Civ_Court.Files_In_NJ.party;
Alias				:= Civ_Court.Files_In_NJ.party_alias;
Guardian		:= Civ_Court.Files_In_NJ.guardian;

//Join party to case header to get case title
l_tempParty	:= RECORD
string55 case_title;
string3 case_type_code;
recordof(Party);
string30	alias_name;
string2		alternate_type_code;
string30	guardian_name;
END;

l_tempParty jParty_case(Party L, CaseHeader R) := TRANSFORM
self.case_title	:= ut.CleanSpacesAndUpper(R.case_title);
self.case_type_code := ut.CleanSpacesAndUpper(R.case_type_code);
self	:= L;
self	:= [];
END;

jPartyCase	:= join(sort(distribute(Party,hash(docketed_judgement_year,docketed_judgement_seq_num)),docketed_judgement_year,docketed_judgement_seq_num,local),
										sort(distribute(CaseHeader,hash(docketed_judgement_year,docketed_judgement_seq_num)),docketed_judgement_year,docketed_judgement_seq_num,local),
										trim(left.docketed_judgement_year,all) = trim(right.docketed_judgement_year,all) and
										trim(left.docketed_judgement_seq_num,all) = trim(right.docketed_judgement_seq_num,all),
										jParty_case(left,right),local);
										
//Join with Alias and Guardian files for easier processing
l_tempParty jParty_alias(jPartyCase L, Alias R) := TRANSFORM
self.alias_name	:= ut.CleanSpacesAndUpper(R.party_name);
self.alternate_type_code	:= ut.CleanSpacesAndUpper(R.alternate_type_code);
self	:= L;
END;

jPartyAlias	:= join(sort(jPartyCase,docketed_judgement_year,docketed_judgement_seq_num,local),
										sort(distribute(Alias,hash(docketed_judgement_year,docketed_judgement_seq_num)),docketed_judgement_year,docketed_judgement_seq_num,local),
										trim(left.docketed_judgement_year,all) = trim(right.docketed_judgement_year,all) and
										trim(left.docketed_judgement_seq_num,all) = trim(right.docketed_judgement_seq_num,all) and
										StringLib.StringCleanSpaces(left.party_name) = StringLib.StringCleanSpaces(right.party_name) and
										right.alternate_type_code <> 'AK',
										jParty_alias(left,right),left outer, local);

l_tempParty jParty_guardian(jPartyAlias L, Guardian R) := TRANSFORM
self.guardian_name	:= ut.CleanSpacesAndUpper(R.party_name);
self	:= L;
END;

jPartyGuardian	:= join(jPartyAlias,
												sort(distribute(Guardian,hash(docketed_judgement_year,docketed_judgement_seq_num)),docketed_judgement_year,docketed_judgement_seq_num,local),
												trim(left.docketed_judgement_year,all) = trim(right.docketed_judgement_year,all) and
												trim(left.docketed_judgement_seq_num,all) = trim(right.docketed_judgement_seq_num,all),
												jParty_guardian(left,right),left outer, local);										

Civil_Court.Layout_In_Party tNJ(jPartyGuardian input, integer1 C)	:= TRANSFORM
self.process_date				:= civil_court.Version_Development;
self.vendor						  := '59';
self.state_origin				:= 'NJ';
self.source_file				:= 'NJ-STATEWIDE';
self.case_key					  := '59'+ut.CleanSpacesAndUpper(input.docketed_judgement_year)+ut.CleanSpacesAndUpper(input.docketed_judgement_seq_num);
self.court_code					:=  ut.CleanSpacesAndUpper(input.court_code);
self.court						  :=	'NEW JERSEY COURT';
//self.case_type_code			:=	ut.CleanSpacesAndUpper(L.case_type_code); currently not used as there is no description table
self.case_title					:=	ut.CleanSpacesAndUpper(input.case_title);
ClnParty								:= StringLib.StringFindReplace(input.party_name,'A.K.A','');
self.entity_1						:= CHOOSE(C,StringLib.StringCleanSpaces(ClnParty),
																		StringLib.StringCleanSpaces(input.alias_name),
																		StringLib.StringCleanSpaces(input.guardian_name));
self.entity_nm_format_1 := 'L';
self.entity_type_code_1_orig := CHOOSE(C,StringLib.StringFindReplace(input.party_role_type_code,'CD',''),
																				 StringLib.StringFindReplace(input.party_role_type_code,'CD',''),
																				 'D3');
self.entity_type_description_1_orig := CHOOSE(C,IF(input.party_role_type_code = 'C','CREDITOR',
																									IF(input.party_role_type_code = 'D','DEBTOR','')),
																								IF(input.party_role_type_code = 'C','CREDITOR',
																									IF(input.party_role_type_code = 'D','DEBTOR','')),
																								'GUARDIAN');
self.entity_type_code_1_master := CHOOSE(C,MAP(input.party_role_type_code = 'C' and StringLib.StringFind(input.party_name,'A.K.A',1) = 0 => '10',
																								input.party_role_type_code = 'C' and StringLib.StringFind(input.party_name,'A.K.A',1) > 0 => '11',
																								input.party_role_type_code = 'D' and StringLib.StringFind(input.party_name,'A.K.A',1) = 0 => '30','31'),
																						MAP(input.party_role_type_code = 'C' and input.alternate_type_code <> 'FL' => '11',
																								input.party_role_type_code = 'C' and input.alternate_type_code = 'FL' => '10',
																								input.party_role_type_code = 'D' and input.alternate_type_code = 'FL' => '30','31'),
																							'70');
self.entity_1_address_1 := CHOOSE(C,ut.CleanSpacesAndUpper(input.party_street_name),ut.CleanSpacesAndUpper(input.party_street_name),'');
self.entity_1_address_2 := CHOOSE(C,ut.CleanSpacesAndUpper(input.party_addt_street_name),ut.CleanSpacesAndUpper(input.party_addt_street_name),'');
self.entity_1_address_3 := CHOOSE(C,ut.CleanSpacesAndUpper(input.party_city_name)+' '+ut.CleanSpacesAndUpper(input.party_state_code)+' '+
																		IF(input.party_zip_code <> '000000000',trim(input.party_zip_code,all),''),
																		ut.CleanSpacesAndUpper(input.party_city_name)+' '+ut.CleanSpacesAndUpper(input.party_state_code)+' '+
																		IF(input.party_zip_code <> '000000000',trim(input.party_zip_code,all),''),'');
self := [];
end;

pNJ	:= normalize(jPartyGuardian,3,tNJ(left,counter));

//Remove records with blank name prior to clean.
filterNJ	:= pNJ(entity_1 <> '');

Civ_court.Civ_Court_Cleaner(filterNJ,cleanNJ);

ddNJ 	:= dedup(sort(distribute(cleanNJ,hash(case_key)),
                  process_date,case_key,court,entity_1,entity_type_description_1_orig,
									entity_type_code_1_master,entity_1_address_1,entity_1_address_2,entity_1_address_3, local),
									case_key,court,entity_1,entity_type_description_1_orig,entity_type_code_1_master,
									entity_1_address_1,entity_1_address_2,entity_1_address_3, local,left):
									PERSIST('~thor_data400::in::civil_NJ_party');

EXPORT Map_NJ_Party := ddNJ;