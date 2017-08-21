IMPORT Civ_Court, civil_court, ut, lib_StringLib, STD, Address;

#option('multiplePersistInstances',FALSE);

//original AbInitio mapping /stub_cleaning/court/work/mp/mi_civil_county_saginaw02.mp

fSaginaw := Civ_court.File_In_MI_Saginaw;

Civil_Court.Layout_In_Party tSaginaw(fSaginaw input, integer1 C) := TRANSFORM
self.process_date				:= civil_court.Version_Development;
self.vendor						  := '56';
self.state_origin				:= 'MI';
self.source_file				:= 'MI-CIV-SAGINAW-CO';
UpperCaseNum						:= ut.CleanSpacesAndUpper(input.case_num);
self.case_key					  := '56'+UpperCaseNum;
self.court_code					:= '';
self.court							:= 'COUNTY OF SAGINAW 70TH DISTRICT STATE COURT';
self.case_number				:= UpperCaseNum;
self.case_type					:= ut.CleanSpacesAndUpper(input.case_type);
self.case_title					:= ut.CleanSpacesAndUpper(input.case_title);
self.entity_1						:= CHOOSE(C, input.plaintiff, input.defendant);
self.entity_nm_format_1	:= CHOOSE(C,IF(StringLib.StringFind(input.plaintiff,',',1) > 0,'L','U'),
																		IF(StringLib.StringFind(input.defendant,',',1) > 0,'L','U'));
self.entity_type_description_1_orig := CHOOSE(C, 'PLAINTIFF', 'DEFENDANT');
self.entity_type_code_1_master := CHOOSE(C, '10', '30');
self.entity_1_address_1 := CHOOSE(C, input.plaintiff_street, input.def_street);
self.entity_1_address_2 := CHOOSE(C, input.plaintiff_csz, input.def_csz);
self := [];
end;

pSaginaw	:= normalize(fSaginaw,2,tSaginaw(left,counter));

//Remove records with blank name prior to clean.
filterMI	:= pSaginaw(entity_1 <> '');

//Rollup to populate entity_1 address
srt_output := sort(filterMI,case_number,case_type,entity_1,-entity_1_address_1,-entity_1_address_2);

Civil_Court.Layout_In_Party PopAddr(srt_output L, srt_output R) := TRANSFORM
	self.entity_1_address_1	:= IF(L.entity_1_address_1 = '', R.entity_1_address_1, L.entity_1_address_1);
	self.entity_1_address_2	:= IF(L.entity_1_address_2 = '',R.entity_1_address_2, L.entity_1_address_2);
	self										:= L;
END;

rEntityAddr	:= rollup(srt_output, PopAddr(left,right),case_number,case_type,case_title,entity_1); 

Civ_court.Civ_Court_Cleaner(rEntityAddr,cleanMI);

ddMI 	:= dedup(sort(distribute(cleanMI,hash(case_key)),
                  process_date, case_key, court, case_number, case_type, entity_1, entity_nm_format_1, 
									entity_type_description_1_orig, entity_type_code_1_master, entity_1_address_1,
									entity_1_address_2, local),
									case_key, court, case_number, case_type, entity_1, entity_nm_format_1, 
									entity_type_description_1_orig, entity_type_code_1_master, entity_1_address_1,
									entity_1_address_2, local,left):
									PERSIST('~thor_data400::in::civil_MI_Saginaw_party');

EXPORT Map_MI_Saginaw_Party := ddMI;