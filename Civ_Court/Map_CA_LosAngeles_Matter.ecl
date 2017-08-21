IMPORT Civ_Court, civil_court, crim_common, ut;

#option('multiplePersistInstances',FALSE);

//original AbInitio mapping /stub_cleaning/court/work/mp/ca_civil_county_los_angeles_02_upd.mp

fLA 	:= Civ_Court.File_In_CA_LosAngeles(trim(party_name1,all) <> '' and trim(party_name2,all) <> '');

Civil_Court.Layout_In_Matter tLA(fLA input) := Transform
self.process_date				:= civil_court.Version_Development;
self.vendor						  := '18';
self.state_origin				:= 'CA';
self.source_file				:= 'CA-LA-CNTY-CIV-COURT';
UpperCaseNum						:= ut.CleanSpacesAndUpper(input.case_number);
self.case_key					  := '18'+ut.CleanSpacesAndUpper(input.dist_prfx)+ut.CleanSpacesAndUpper(input.case_type)+UpperCaseNum;
self.parent_case_key		:= '';
self.court_code					:= ut.CleanSpacesAndUpper(input.dist_prfx);
self.court						  := map(self.court_code = 'B' => 'LA COUNTY, LA CENTRAL' ,
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
self.case_type_code			:= ut.CleanSpacesAndUpper(input.case_type);
self.case_type					:= map(self.case_type_code = 'C' => 'CIVIL',
																self.case_type_code = 'D' => 'DIVORCE',
																self.case_type_code = 'Q' => 'DOMESTIC VIOLENCE',
																self.case_type_code = 'P' => 'PROBATE',
																self.case_type_code = 'S' => 'SPECIAL PROCEEDINGS',
																self.case_type_code = 'Y' => 'DOMESTIC SUPPORT',
																self.case_type_code = 'Z' => 'DOMESTIC SUPPORT',
																self.case_type_code = 'L' => 'RESL', '');
self.filing_date				:= trim(input.year_of_filing,all)+trim(input.month_of_filing,all)+trim(input.day_of_filing,all);
self := [];
END;

pLA 	:= project(fla,tLA(left));

dLA 	:= dedup(sort(distribute(pLA,hash(case_key)),
                  process_date, case_key, court_code, court, case_number,
									case_type_code, case_type, filing_date,local),
									case_key, court, case_number, case_type, 
									filing_date,local,left):
									PERSIST('~thor_data400::in::civil_CA_LosAngeles_matter');


EXPORT Map_CA_LosAngeles_Matter := dLA(case_number <> '');