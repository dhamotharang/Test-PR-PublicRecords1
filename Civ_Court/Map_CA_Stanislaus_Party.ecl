IMPORT Civ_Court, civil_court, crim_common, ut, lib_StringLib, Address; 

fStanislaus := Civ_court.File_In_CA_Stanislaus(Case_Type <> 'CRIMINAL' and Case_Type <> 'JUVENILE' and Case_Type <> 'JUVENILE TRAFFIC' and Case_Type <> 'TRAFFIC');

Civil_Court.Layout_In_Party  tStanislaus(fStanislaus input) := TRANSFORM
self.process_date				:= civil_court.Version_Development;
self.vendor						  := '37';
self.state_origin				:= 'CA';
self.source_file				:= 'CA-Stanislaus_County';
self.case_key					  := '37'+ input.Case_Number;
self.court_code					:= '';
self.court						  :=	input.Location;
self.case_number				:= input.Case_Number;
self.case_type_code			:= '';
self.case_type					:= input.Case_Type;
self.case_title					:= input.Case_Caption;
self.entity_1						:= if(input.Party_First_Name = 'null',input.Party_Last_Name, input.Party_First_Name + ' ' + input.Party_Middle_Name + ' ' + input.Party_Last_Name);
self.entity_nm_format_1	:='F';
self.entity_type_description_1_orig := input.Party_Role;
self.entity_type_code_1_master		  := MAP(input.Party_Role = 'DEFENDANT' => '30',
																input.Party_Role = 'MINOR DEFENDANT' => '30', 
																input.Party_Role = 'DEFENDENT\'S GUARDIAN AD LITEM' => '30' ,
																input.Party_Role = 'PLAINTIFF' => '10',
																input.Party_Role = 'PLAINTIFF\'S GUARDIAN AD LITEM' => '10',
																input.Party_Role = 'MINOR PLAINTIFF' => '10',
																input.Party_Role = 'CONSERVATEE' => '70', 
																input.Party_Role = 'CONSERVATOR' => '70', 
																input.Party_Role = 'CROSS-COMPLAINANT' => '70', 
																input.Party_Role = 'INTERVENOR' => '70',
																input.Party_Role = 'OBJECTOR' => '70', 
																input.Party_Role = 'PETITIONER' => '70', 
																input.Party_Role = 'RESPONDENT' => '70',
																input.Party_Role = 'DECEASED' => '90','');
self := [];
END;

pStanislaus 	:= project(fStanislaus,tStanislaus(left));

Civ_court.Civ_Court_Cleaner(pStanislaus,cleanStanislaus);

ddStanislaus 	:= dedup(sort(distribute(cleanStanislaus,hash(case_key)),
								process_date,case_key, court, case_number, case_type, entity_1, entity_nm_format_1, 
								entity_type_description_1_orig, entity_type_code_1_master, local),
								case_key, court, case_number, case_type, entity_1, entity_nm_format_1, 
								entity_type_description_1_orig, entity_type_code_1_master, local,left):
								PERSIST('~thor_data400::in::civil_CA_Stanislaus_party');
								
EXPORT Map_CA_Stanislaus_Party := ddStanislaus;