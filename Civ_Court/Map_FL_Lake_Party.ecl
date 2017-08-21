IMPORT Civ_Court, civil_court, crim_common, ut, lib_StringLib, Address;

#option('multiplePersistInstances',FALSE);

fLake := Civ_court.File_In_FL_Lake;

Civil_Court.Layout_In_Party  tLake(fLake input, integer1 C) := TRANSFORM
self.process_date				:= civil_court.Version_Development;
self.vendor						  := '36';
self.state_origin				:= 'FL';
self.source_file				:= 'FL-CIV-LAKE-CO';
UpperCaseNum						:= ut.CleanSpacesAndUpper(input.case_num);
self.case_key					  := '36'+UpperCaseNum;
self.court_code					:= '';
self.court							:= 'FLORIDA CIVIL COURT: LAKE COUNTY';
self.case_number				:= UpperCaseNum;
self.case_type					:= 'EVICTIONS';
self.entity_nm_format_1	:='F';
TempName1								:= ut.CleanSpacesAndUpper(IF(trim(input.last_name,all) <> '',
																							trim(input.first_name,left,right)+' '+trim(input.middle_initial,left,right)+' '+trim(input.last_name,left,right),
																							trim(input.corporate_name,left,right)));
TempName2								:= ut.CleanSpacesAndUpper(IF(regexfind('dba',input.address,nocase),trim(input.address,left,right),''));
self.entity_1						:= CHOOSE(C,TempName1, TempName2); 						
self.entity_type_code_1_orig	:= ut.CleanSpacesAndUpper(input.pord);
self.entity_type_description_1_orig := IF(self.entity_type_code_1_orig = 'DEFT','DEFENDENT','PLAINTIFF');
self.entity_type_code_1_master		  := IF(self.entity_type_code_1_orig = 'DEFT','30','10');
self.entity_1_address_1	:= ut.CleanSpacesAndUpper(IF(regexfind('dba',input.address,nocase),'',trim(input.address,left,right)));
self.entity_1_address_2	:= ut.CleanSpacesAndUpper(trim(input.city,left,right)+' '+trim(input.state,all)+' '+trim(input.zip,all));
self := [];
END;

pLake	:= normalize(fLake,If(regexfind('dba',left.address,nocase),2,1),tLake(left,counter));

Civ_court.Civ_Court_Cleaner(pLake,cleanLake);

ddLake 	:= dedup(sort(distribute(cleanLake,hash(case_key)),
                  process_date,case_key, court, case_number, entity_1, entity_nm_format_1, 
									entity_type_code_1_orig, entity_type_description_1_orig, entity_type_code_1_master,
									entity_1_address_1, entity_1_address_2, local),
									case_key, court, case_number, entity_1, entity_nm_format_1, 
									entity_type_code_1_orig, entity_type_description_1_orig, entity_type_code_1_master,
									entity_1_address_1, entity_1_address_2, local,left):
									PERSIST('~thor_data400::in::civil_FL_Lake_party');

EXPORT Map_FL_Lake_Party := ddLake(trim(entity_1,all)<> '');