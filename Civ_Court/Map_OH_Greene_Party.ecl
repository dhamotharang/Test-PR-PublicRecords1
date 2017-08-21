IMPORT Civ_Court, civil_court, ut, lib_StringLib, STD, Address; 

#option('multiplePersistInstances',FALSE);

//original AbInitio mapping /stub_cleaning/court/work/mp/oh_civil_greene_co_02.mp

fGreene := Civ_court.File_In_OH_Greene;

InvalidName := '(.*)(ATTN:|ATTN |ATTENTION:|ATTENTION|DOES, JOHN 1-5|DOE, JOHN|RAMIREZ, CARLOS S|, DECEASED|, DECEASE|DECEASED|DECEASE|^ROOM |^APT |'+
								'UNKNOWN |UNK |TENANT|WIFE |HUSBAND |SPOUSE |^OF THE |^HEIRS OF|^GUARDIAN|^C/O |A/S/O |^FKA |^F/K/A |JOHN DOE|JANE DOE|ATTORNEY)(.*)';

Civil_Court.Layout_In_Party tGreene(fGreene input, integer1 C)	:= TRANSFORM
self.process_date				:= civil_court.Version_Development;
self.vendor						  := '65';
self.state_origin				:= 'OH';
self.source_file				:= 'OH-CIV-GREENE-CO';
UpperCaseNum						:= ut.CleanSpacesAndUpper(input.case_num);
self.case_key					  := '65'+UpperCaseNum;
self.court_code					:= '';
self.court							:= 'GREENE COUNTY';
self.case_number				:= UpperCaseNum;
self.case_type					:= ut.CleanSpacesAndUpper(input.charge);
self.case_title					:= REGEXREPLACE('JTC|SAW',ut.CleanSpacesAndUpper(input.case_name),'');
temp_name								:= CHOOSE(C, input.attorney, input.aka_name, input.party_name1, input.party_name2);
self.entity_1						:= IF(REGEXFIND(InvalidName,temp_name), REGEXREPLACE(InvalidName,temp_name,''),
														IF(REGEXFIND('/CO|C/O',temp_name),'',temp_name));
self.entity_nm_format_1	:= CHOOSE(C, 'L','F',IF(StringLib.StringFind(temp_name,',',1) > 0,'L','U'),
																							IF(StringLib.StringFind(temp_name,',',1) > 0,'L','U'));
self.entity_type_description_1_orig	:= CHOOSE(C, IF(input.pl_def = 'PLAINTIFF','PLAINTIFF ATTORNEY',
																									IF(input.pl_def = 'DEFENDANT','DEFENDANT ATTORNEY','')),
																								 IF(input.pl_def = 'PLAINTIFF','PLAINTIFF ALIAS',
																									IF(input.pl_def = 'DEFENDANT','DEFENDANT ALIAS','')),
																								 IF(input.pl_def = 'PLAINTIFF','PLAINTIFF',
																									IF(input.pl_def = 'DEFENDANT','DEFENDANT','')),
																								 IF(input.pl_def = 'PLAINTIFF','PLAINTIFF',
																									IF(input.pl_def = 'DEFENDANT','DEFENDANT','')));
self.entity_type_code_1_master := CHOOSE(C, IF(input.pl_def = 'PLAINTIFF','20',
																									IF(input.pl_def = 'DEFENDANT','40','')),
																								 IF(input.pl_def = 'PLAINTIFF','11',
																									IF(input.pl_def = 'DEFENDANT','31','')),
																								 IF(input.pl_def = 'PLAINTIFF','10',
																									IF(input.pl_def = 'DEFENDANT','30','')),
																								 IF(input.pl_def = 'PLAINTIFF','10',
																									IF(input.pl_def = 'DEFENDANT','30','')));
self.entity_1_address_1 := CHOOSE(C,'',input.address1,input.address1,input.address1);
self.entity_1_address_2 := CHOOSE(C,'',input.address2,input.address2,input.address2);
self := [];
end;

pGreene	:= normalize(fGreene,4,tGreene(left,counter));

//Remove records with blank name and Invalid name prior to clean.
filterOH	:= pGreene(entity_1 <> '' and ~REGEXFIND(InvalidName,entity_1));

srt_OH	:= sort(distribute(filterOH,hash(case_key,entity_1)),case_number,entity_1,entity_type_description_1_orig,entity_1_address_1,local);

//Rollup to link records with case_number and name match, but missing address.
Civil_Court.Layout_In_Party RollitUp(srt_OH L, srt_OH R) := TRANSFORM
self.entity_1_address_1 := IF(L.entity_1_address_1 = '',R.entity_1_address_1,L.entity_1_address_1);
self.entity_1_address_2 := IF(L.entity_1_address_2 = '',R.entity_1_address_2,L.entity_1_address_2);
self := L;
END;

RollupName	:= rollup(srt_OH, RollitUp(left,right),case_number,entity_1,entity_type_description_1_orig,local);

Civ_court.Civ_Court_Cleaner(RollupName,cleanOH);

ddOH 	:= dedup(sort(distribute(cleanOH,hash(case_key)),
                  process_date, case_key, court, case_number, entity_1, entity_nm_format_1, 
									entity_type_description_1_orig, entity_type_code_1_master, entity_1_address_1,
									entity_1_address_2,entity_1_address_3, local),
									case_key, court, case_number, entity_1, entity_nm_format_1,entity_type_description_1_orig,
									entity_type_code_1_master, entity_1_address_1,entity_1_address_2,entity_1_address_3, local,left):
									PERSIST('~thor_data400::in::civil_OH_Greene_party');

EXPORT Map_OH_Greene_Party := ddOH;