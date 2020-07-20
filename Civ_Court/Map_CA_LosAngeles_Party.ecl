IMPORT Civ_Court, civil_court, crim_common, ut, Address, lib_StringLib;

#option('multiplePersistInstances',FALSE);

//original AbInitio mapping /stub_cleaning/court/work/mp/ca_civil_county_los_angeles_02_upd.mp

fLA 	:= Civ_Court.File_In_CA_LosAngeles;

Civil_Court.Layout_In_Party tLA(fLA input, integer1 C) := Transform
self.process_date				:= civil_court.Version_Development;
self.vendor						  := '18';
self.state_origin				:= 'CA';
self.source_file				:= 'CA-LA-CNTY-CIV-COURT';
UpperCaseNum						:= ut.CleanSpacesAndUpper(input.case_number);
// self.case_key					  := '18'+ut.CleanSpacesAndUpper(input.dist_prfx)+ut.CleanSpacesAndUpper(input.case_type)+UpperCaseNum;
self.case_key					  := ut.CleanSpacesAndUpper(UpperCaseNum);
self.parent_case_key		:= '';
self.court_code					:= ut.CleanSpacesAndUpper(input.branch_code_id);
self.court						  := MAP(self.court_code = 'B' => 'LA COUNTY, LA CENTRAL' ,
																self.court_code = 'E' => 'LA COUNTY, BURBANK/GLENDALE',
																self.court_code = 'G' => 'LA COUNTY, NORTH EAST PASADENA',
																self.court_code = 'K' => 'LA COUNTY, EAST POMONA' ,
																self.court_code = 'L' => 'LA COUNTY, NORTH WEST VAN NUYS',
																self.court_code = 'M' => 'LA COUNTY, PALMDALE/LANCASTER',
																self.court_code = 'N' => 'LA COUNTY, SOUTH LONG BEACH', 
																self.court_code = 'O' => 'LA COUNTY, PALMDALE',
																self.court_code = 'P' => 'LA COUNTY, NORTH VALLEY/SAN FERNANDO VALLEY', 
																self.court_code = 'S' => 'LA COUNTY, WEST SANTA MONICA', 
																self.court_code = 'T' => 'LA COUNTY, SOUTH CENTRAL COMPTON', 
																self.court_code = 'V' => 'LA COUNTY, SOUTH EAST NORWALK',
																self.court_code = 'Y' => 'LA COUNTY, SOUTH WEST TORRANCE','');
self.case_number				:= UpperCaseNum;
// self.case_type_code			:= ut.CleanSpacesAndUpper(input.case_type);
// self.case_type					:= MAP(self.case_type_code = 'C' => 'CIVIL',
																// self.case_type_code = 'D' => 'DIVORCE',
																// self.case_type_code = 'Q' => 'DOMESTIC VIOLENCE',
																// self.case_type_code = 'P' => 'PROBATE',
																// self.case_type_code = 'S' => 'SPECIAL PROCEEDINGS',
																// self.case_type_code = 'Y' => 'DOMESTIC SUPPORT',
																// self.case_type_code = 'Z' => 'DOMESTIC SUPPORT',
																// self.case_type_code = 'L' => 'RESL', '');
ClnName1							:= IF(REGEXFIND('^\\.',input.party_name1),REGEXREPLACE('^\\.',input.party_name1,''),
														IF(REGEXFIND('CHANGE NAME|^does [0-9]+',input.party_name1,NOCASE),'',
															ut.CleanSpacesAndUpper(input.party_name1)));
ClnName2							:= IF(REGEXFIND('^\\.',input.party_name2),REGEXREPLACE('^\\.',input.party_name2,''),
														IF(REGEXFIND('CHANGE NAME|^does [0-9]+',input.party_name2,NOCASE),'',
															ut.CleanSpacesAndUpper(input.party_name2)));
self.entity_1					:= CHOOSE(C,ClnName1,ClnName2);
self.entity_nm_format_1 := 'U'; //Names are in mixed format
self.entity_type_description_1_orig  := CHOOSE(C,IF(StringLib.StringFind(input.party_type,'--',1)>0,'DEFENDANT','PLAINTIFF'),
																									IF(StringLib.StringFind(input.party_type,'--',1)>0,'PLAINTIFF','DEFENDANT'));
self.entity_type_code_1_master := CHOOSE(C,IF(StringLib.StringFind(input.party_type,'--',1)>0,'30','10'),
																						IF(StringLib.StringFind(input.party_type,'--',1)>0,'10','30'));
self := [];
END;

pLA	:= normalize(fLA,2,tLA(left,counter));

//Filter blank entity_1 prior to cleaning
filter_LA_All := filter_LA + filter_LA_New;
// filter_LA	:= pLA(trim(entity_1,all) <> '');

Civ_court.Civ_Court_Cleaner(filter_LA,cleanLA);

ddLA 	:= dedup(sort(distribute(cleanLA,hash(case_key)),
                  process_date,case_key, court_code, court, case_number, entity_1, 
									entity_type_code_1_orig, entity_type_description_1_orig, local),
									case_key, court_code, court, case_number, entity_1, entity_nm_format_1, 
									entity_type_code_1_orig, entity_type_description_1_orig, entity_type_code_1_master, local,left):
									PERSIST('~thor_data400::in::civil_CA_LosAngeles_party');

EXPORT Map_CA_LosAngeles_Party := ddLA;