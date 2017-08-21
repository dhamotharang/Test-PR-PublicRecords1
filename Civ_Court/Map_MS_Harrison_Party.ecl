IMPORT Civ_Court, civil_court, ut,  Address, lib_StringLib;

#option('multiplePersistInstances',FALSE);


//original AbInitio mapping /stub_cleaning/court/work/mp/ms_civil_county_harrison02.mp

fMS := Civ_Court.Files_In_MS_Harrison.Civil;

Civil_Court.Layout_In_Party tMS(fMS input)	:= TRANSFORM
self.process_date				:= civil_court.Version_Development;
self.vendor						  := '97';
self.state_origin				:= 'MS';
self.source_file				:= 'MS-HARRISON_CTY';
self.case_key					  := '97'+ut.CleanSpacesAndUpper(input.case_num);
self.court_code					:= '';
self.court						  := 'HARRISON COUNTY';
self.case_number				:= ut.CleanSpacesAndUpper(input.case_num);
self.case_type_code			:= '';
self.case_type					:= ut.CleanSpacesAndUpper(input.case_type);
self.entity_1						:= ut.CleanSpacesAndUpper(IF(StringLib.StringFind(input.entitiy_name,',',1) > 0, StringLib.StringFindReplace(input.entitiy_name,',',', '),input.entitiy_name));
self.entity_nm_format_1 := 'L';
self.entity_type_code_1_orig := ut.CleanSpacesAndUpper(input.plt_def);
self.entity_type_description_1_orig := IF(REGEXFIND('^P',self.entity_type_code_1_orig), 'PLAINTIFF','DEFENDANT');
self.entity_type_code_1_master := IF(REGEXFIND('^P',self.entity_type_code_1_orig),'10', '30');
self := [];
end;

pMS	:= project(fMS,tMS(left));

Civ_court.Civ_Court_Cleaner(pMS,cleanMS);

ddMS 	:= dedup(sort(distribute(cleanMS,hash(case_key)),
                  process_date, case_key, court_code, case_number, case_type, case_title, entity_1, entity_nm_format_1, 
									entity_type_code_1_orig, entity_type_description_1_orig, entity_type_code_1_master, local),
									case_key, court_code, case_number, case_type, case_title, entity_1, entity_nm_format_1, 
									entity_type_code_1_orig, entity_type_description_1_orig, entity_type_code_1_master, local,left):
									PERSIST('~thor_data400::in::civil_ms_harrison_party');


EXPORT Map_MS_Harrison_Party := ddMS(entity_1 <> '');