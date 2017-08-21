IMPORT Civ_Court, civil_court, crim_common, ut, Address; 

#option('multiplePersistInstances',FALSE);

//original AbInitio mapping /stub_cleaning/court/work/mp/fl_civil_county_alachua_02_upd.mp
fAlachua_lte := Civ_Court.Files_In_FL_Alachua.lte;
fAlachu_civil	:= Civ_Court.Files_In_FL_Alachua.civil;

Civil_Court.Layout_In_Party tFLAlachuaLTE(fAlachua_lte input, integer1 C) := Transform
self.process_date				:= civil_court.Version_Development;
self.vendor						  := '28';
self.state_origin				:= 'FL';
self.source_file				:= 'FL-CIV-ALACHUA-CO';
StdFileDate							:= input.file_date[5..8]+input.file_date[1..2]+input.file_date[3..4];
UpperCaseNum						:= ut.CleanSpacesAndUpper(input.case_number);
self.case_key					  := '28'+UpperCaseNum+StdFileDate;
self.court						  :=	IF(UpperCaseNum[1..2] = 'CC','ALACHUA COUNTY COURT','ALACHUA COUNTY CIRCUIT COURT');
self.case_number				:= UpperCaseNum[1..35];
self.case_type_code			:= 'LT';
self.case_type					:= 'LANDLORD/TENANT EVICTIONS';
self.case_title						:='';
UpperName									:= ut.CleanSpacesAndUpper(IF(trim(input.last_name,all) <> '',
																							trim(input.first_name,left,right)+' '+trim(input.middle_name,left,right)+' '+trim(input.last_name,left,right),
																							trim(input.company_name,left,right)));
UpperAKA									:= ut.CleanSpacesAndUpper(If(trim(input.alias_type,all) <> '' and trim(input.alias_lastname,all) <> '',
																								trim(input.alias_firstname,left,right)+' '+trim(input.alias_middlename,left,right)+' '+trim(input.alias_lastname,left,right),
																								IF(trim(input.alias_type,all) <> '' and trim(input.alias_lastname,all) = '',trim(input.alias_company,left,right), '')));
self.entity_1						  := CHOOSE(C, Uppername, UpperAKA);
self.entity_nm_format_1		:='F';
self.entity_type_code_1_orig	:= '';
self.entity_type_description_1_orig	:= ut.CleanSpacesAndUpper(input.party_descr[1..30]);
self.entity_type_code_1_master		  := map(ut.CleanSpacesAndUpper(input.party_descr) ='PLAINTIFF' => '10',
																						ut.CleanSpacesAndUpper(input.party_descr) ='DEFENDANT' => '30',
																						ut.CleanSpacesAndUpper(input.party_descr) ='COUNTER PLAINTIFF' => '30',
																						ut.CleanSpacesAndUpper(input.party_descr) ='COUNTER DEFENDANT' => '10','');
self.entity_1_address_1			:= ut.CleanSpacesAndUpper(input.addr_line1);
self.entity_1_address_2			:= ut.CleanSpacesAndUpper(input.addr_line2);								
self.entity_1_address_3			:= ut.CleanSpacesAndUpper(input.addr_line3);
self.entity_1_address_4			:= ut.CleanSpacesAndUpper(input.city+' '+input.state+' '+input.zipcode);
self := [];
end;

pAlachuaLTE	:= normalize(fAlachua_lte,2,tFLAlachuaLTE(left,counter));

//Civil File
Civil_Court.Layout_In_Party tFLAlachuaCiv(fAlachu_civil input) := Transform
self.process_date				:= civil_court.Version_Development;
self.vendor						  := '28';
self.state_origin				:= 'FL';
self.source_file				:= 'FL-CIV-ALACHUA-CO';
StdFileDate							:= input.filing_date[7..10]+input.filing_date[1..2]+input.filing_date[4..5];
UpperCaseNum						:= ut.CleanSpacesAndUpper(input.case_number);
self.case_key					  := '28'+UpperCaseNum+StdFileDate;
self.court						  :=	IF(UpperCaseNum[1..2] = 'CC','ALACHUA COUNTY COURT','ALACHUA COUNTY CIRCUIT COURT');
self.case_number				:= UpperCaseNum[1..35];
self.case_type_code			:= '';
self.case_type					:= ut.CleanSpacesAndUpper(input.filing_action);
self.case_title					:='';
UpperName								:= ut.CleanSpacesAndUpper(IF(trim(input.last_name_1,all) <> '',
																						trim(input.first_name_1,left,right)+' '+trim(input.last_name_1,left,right), trim(input.company_name_1,left,right)));
self.entity_1						:= Uppername;
self.entity_nm_format_1	:='F';
self.entity_type_code_1_orig	:= '';
self.entity_type_description_1_orig	:= ut.CleanSpacesAndUpper(input.party_description);
self.entity_type_code_1_master		  := map(ut.CleanSpacesAndUpper(input.party_description) ='PLAINTIFF' => '10',
																						ut.CleanSpacesAndUpper(input.party_description) ='DEFENDANT' => '30','');
self := [];
end;

pAlachuaCiv	:= project(fAlachu_civil,tFLAlachuaCiv(left));

//Combine both Party outputs
CombineAll	:= pAlachuaLTE(entity_1 <> '')+pAlachuaCiv(entity_1 <> '');

Civ_court.Civ_Court_Cleaner(CombineAll,cleanAlachua);

ddAlachua 	:= dedup(sort(distribute(cleanAlachua,hash(case_key)),
                  process_date,case_key,court, case_number, case_type_code, case_type, entity_1, entity_nm_format_1, 
									entity_type_code_1_orig, entity_type_description_1_orig, entity_type_code_1_master,
									entity_1_address_1, entity_1_address_2,entity_1_address_3, entity_1_address_4,local),
									case_key,court, case_number, case_type_code, case_type, entity_1, entity_nm_format_1, 
									entity_type_code_1_orig, entity_type_description_1_orig, entity_type_code_1_master,
									entity_1_address_1, entity_1_address_2,entity_1_address_3, entity_1_address_4,local,left):
									PERSIST('~thor_data400::in::civil_FL_AlachuaLTE_party');

EXPORT Map_FL_AlachuaLTE_Party := ddAlachua;