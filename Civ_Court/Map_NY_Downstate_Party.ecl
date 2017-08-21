IMPORT Civ_Court, civil_court, ut,  Address, lib_StringLib;

#option('multiplePersistInstances',FALSE);

//original AbInitio mapping /stub_cleaning/court/work/mp/ny_civil_downstate_02_update.mp

fCase	:= Civ_Court.Files_In_NY_Downstate.Case_in;
fAty	:= Civ_Court.Files_In_NY_Downstate.Atty_In;
court	:= sort(Civ_Court.Files_In_NY_Downstate.Cnty_Codes_lkp,code);

//Join Case and Aty for easier processing of a single file
//slim layout to just output fields used by party
l_temp	:= RECORD 
	string2	county_code;
	string11	idxno;
	string3		seqno;
	string1		court_type;
	string60  court;
	string30	name_pltf;
	string30	name_dfdt;
	string20	atty_name;
	string20	trial_counsel_name;
	string1		pltf_defdt_ind;
END;

l_temp	tCaseAty(fCase L, fAty R) := TRANSFORM
	self.county_code	:= L.county_code;
	self.idxno				:= L.idxno;
	self.seqno				:= L.seqno;
	self.court_type		:= L.court_type;
	self.name_pltf		:= ut.CleanSpacesAndUpper(L.name_pltf);
	self.name_dfdt		:= ut.CleanSpacesAndUpper(L.name_dfdt);
	self.atty_name		:= ut.CleanSpacesAndUpper(R.atty_of_record_name);
	self.trial_counsel_name	:= ut.CleanSpacesAndUpper(R.trial_counsel_name);
	self.pltf_defdt_ind	:= ut.CleanSpacesAndUpper(R.pltf_defdt_indicator);
	self := L;
	self := [];
END;

jCaseAty	:= join(sort(distribute(fCase(idxno <> ''),hash(idxno,seqno,county_code)),idxno,seqno,county_code,court_type,local),
									sort(distribute(fAty,hash(idxno,seqno,county_code)),idxno,seqno,county_code,local),
									trim(left.county_code,all) = trim(right.county_code,all) and
									trim(left.idxno,all) = trim(right.idxno,all) and
									trim(left.seqno,all) = trim(right.seqno,all),
									tCaseAty(left,right),left outer,local);
									
//Do court code lookup because court_type is needed and not stored in final output
l_temp	lkpCourt(jCaseAty L, court R)	:= TRANSFORM
	self.court	:= map(trim(L.court_type) = '0' => ut.CleanSpacesAndUpper(R.description)+' COUNTY, NY COUNTY COURT',
										trim(L.court_type) = '1' => ut.CleanSpacesAndUpper(R.description)+' COUNTY, NY SUPERIOR COURT',
										ut.CleanSpacesAndUpper(R.description)+' COUNTY, NY COURT');
	self := L;
END;

jCaseCourt	:= join(jCaseAty, court,
										trim(left.county_code,all) = trim(right.code,all),
										lkpCourt(left,right),left outer,lookup);

BadNames	:= 'FOR CONFERENCE ONLY|ATTY FOR CHILD| COUNSEL|REFEREE|LAW GUARDIAN|SETTLEMENT CONF ONLY|COURT APPOINTED|COURT ORDER';
										
Civil_Court.Layout_In_Party tNY(jCaseCourt input, integer1 C)	:= TRANSFORM
self.process_date				:= civil_court.Version_Development;
self.vendor						  := '25';
self.state_origin				:= 'NY';
self.source_file				:= 'NY-STATEWIDE-CIV-CRT';
ClnCase									:= trim(input.county_code,all)+trim(input.idxno,all)+trim(input.seqno,all);
self.case_key					  := '25'+ ClnCase;
self.parent_case_key		:= trim(input.county_code,all)+trim(input.idxno,all);
self.court_code					:= trim(input.county_code,all);
self.court						  := trim(input.court);
self.case_number				:= ClnCase;
self.case_title					:= IF(input.name_pltf <> '',ut.CleanSpacesAndUpper(input.name_pltf)+' VS '+ ut.CleanSpacesAndUpper(input.name_dfdt),'');
ClnPltName							:= IF(REGEXFIND('IN THE MATTER OF',input.name_pltf,nocase),'',ut.CleanSpacesAndUpper(input.name_pltf));
ClnDefName							:= IF(REGEXFIND('IN THE MATTER OF',input.name_dfdt,nocase),'',ut.CleanSpacesAndUpper(input.name_dfdt));
ClnAttyName							:= IF(REGEXFIND('[0-9]+',input.atty_name) or REGEXFIND(BadNames,StringLib.StringFindReplace(input.atty_name,'.','')),'',
														ut.CleanSpacesAndUpper(input.atty_name));
ClnCounselName					:= IF(REGEXFIND('[0-9]+',input.trial_counsel_name) or REGEXFIND(BadNames,StringLib.StringFindReplace(input.trial_counsel_name,'.','')),'',
														ut.CleanSpacesAndUpper(input.trial_counsel_name));
self.entity_1						:= CHOOSE(C,ClnPltName,ClnDefName,ClnAttyName,ClnCounselName);
self.entity_nm_format_1 := CHOOSE(C,'U','U','F','F');
self.entity_type_description_1_orig	:= CHOOSE(C,'PLAINTIFF','DEFENDANT',MAP(input.pltf_defdt_ind = '1' => 'ATTORNEY OF RECORD: PLAINTIFF',
																																						input.pltf_defdt_ind = '2' => 'ATTORNEY OF RECORD: DEFENDANT',
																																						'ATTY OF RECORD: UNSPECIFIED'),
																																				MAP(input.pltf_defdt_ind = '1' => 'TRIAL COUNSEL: PLAINTIFF',
																																						input.pltf_defdt_ind = '2' => 'TRIAL COUNSEL: DEFENDANT',
																																						'TRIAL COUNSEL: UNSPECIFIED'));
self.entity_type_code_1_master := CHOOSE(C,'10','30', MAP(input.pltf_defdt_ind = '1' => '21',
																													input.pltf_defdt_ind = '2' => '41','50'),
																											MAP(input.pltf_defdt_ind = '1' => '21',
																													input.pltf_defdt_ind = '2' => '41','50'));
self := [];
end;

pNY	:= normalize(jCaseCourt,4,tNY(left,counter));

//Remove records with blank name prior to clean.
filterNY	:= pNY(entity_1 <> '');

Civ_court.Civ_Court_Cleaner(filterNY,cleanNY);

ddNY 	:= dedup(sort(distribute(cleanNY,hash(case_key)),
                  process_date, case_key, court, case_number, entity_1, entity_nm_format_1, 
									entity_type_description_1_orig, entity_type_code_1_master, local),
									case_key, court, case_number, entity_1, entity_nm_format_1, 
									entity_type_description_1_orig, entity_type_code_1_master, local,left):
									PERSIST('~thor_data400::in::civil_NY_Downstate_party');

EXPORT Map_NY_Downstate_Party := ddNY;