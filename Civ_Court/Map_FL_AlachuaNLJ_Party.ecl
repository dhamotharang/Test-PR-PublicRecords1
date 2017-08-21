IMPORT Civ_Court, civil_court, crim_common, ut, Address; 

#option('multiplePersistInstances',FALSE);

//original AbInitio mapping /stub_cleaning/court/work/mp/fl_civil_county_alachua__nlj_02_upd.mp
fAlachua_nlj := Civ_Court.Files_In_FL_Alachua.nlj;

Civil_Court.Layout_In_Party tFLAlachuaNLJ(fAlachua_nlj input, integer1 C) := Transform
self.process_date				:= civil_court.Version_Development;
self.vendor						  := '46';
self.state_origin				:= 'FL';
self.source_file				:= 'FL-ALACHUA-CO-NLJ';
UpperCaseNum						:= ut.CleanSpacesAndUpper(input.case_number);
self.case_key					  := '46'+UpperCaseNum;
self.court						  := 'ALACHUA COUNTY - CIRCUIT CIVIL';
self.case_number				:= UpperCaseNum;
self.case_type_code			:= '';
self.case_type					:= 'CIRCUIT CIVIL VERDICT';
self.case_title					:='';
UpperName								:= ut.CleanSpacesAndUpper(IF(trim(input.Party_last_name,all) <> '',
																							trim(input.Party_first_name,left,right)+' '+trim(input.Party_middle_name,left,right)+' '+trim(input.Party_last_name,left,right),
																							trim(input.Party_company_name,left,right)));
UpperAtty								:= ut.CleanSpacesAndUpper(If(trim(input.Attorney_last_name,all) <> '',
																							trim(input.Attorney_first_name,left,right)+' '+trim(input.Attorney_middle_name,left,right)+' '+trim(input.Attorney_last_name,left,right),
																							trim(input.Attorney_company_name,left,right)));
self.entity_1						:= CHOOSE(C, Uppername, UpperAtty);
self.entity_nm_format_1	:='F';
self.entity_type_code_1_orig	:= ut.CleanSpacesAndUpper(input.party_code);
self.entity_type_description_1_orig	:= CHOOSE(C,If(self.entity_type_code_1_orig[1] = 'P','PLAINTIFF',
																									IF(self.entity_type_code_1_orig[1] = 'D','DEFENDANT','OTHER')),
																								If(self.entity_type_code_1_orig[1] = 'P','ATTORNEY FOR PLAINTIFF',
																									IF(self.entity_type_code_1_orig[1] = 'D','ATTORNEY FOR DEFENDANT','ATTORNEY - UNSPECIFIED')));
self.entity_type_code_1_master		  := CHOOSE(C,If(self.entity_type_code_1_orig[1] = 'P','10',
																									IF(self.entity_type_code_1_orig[1] = 'D','30','70')),
																								If(self.entity_type_code_1_orig[1] = 'P','20',
																									IF(self.entity_type_code_1_orig[1] = 'D','40','50')));
self := [];
end;

pAlachuaLTE	:= normalize(fAlachua_nlj,IF(trim(left.Attorney_last_name + left.Attorney_company_name,left,right) = '',1,2),tFLAlachuaNLJ(left,counter));

Civ_court.Civ_Court_Cleaner(pAlachuaLTE,cleanAlachua);

ddAlachua 	:= dedup(sort(distribute(cleanAlachua,hash(case_key)),
                  process_date,case_key,court, case_number, case_type_code, case_type, entity_1, entity_nm_format_1, 
									entity_type_code_1_orig, entity_type_description_1_orig, entity_type_code_1_master,local),
									case_key, court, case_number, case_type_code, case_type, entity_1, entity_nm_format_1, 
									entity_type_code_1_orig, entity_type_description_1_orig, entity_type_code_1_master,local,left):
									PERSIST('~thor_data400::in::civil_FL_AlachuaNLJ_party');

EXPORT Map_FL_AlachuaNLJ_Party := ddAlachua;