﻿IMPORT Civ_Court, civil_court, crim_common, ut, STD;

#option('multiplePersistInstances',FALSE);

//original AbInitio mapping /stub_cleaning/court/work/mp/ca_civil_county_los_angeles_02_upd.mp

fLA_old 	:= Civ_Court.File_In_CA_LosAngeles.old(trim(party_name1,all) <> '' and trim(party_name2,all) <> '');

Civil_Court.Layout_In_Matter tLAOld(fLA_old input) := Transform
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

pLAOld 	:= project(fLA_old,tLAOld(left));

//New Layout
fLA_new 	:= Civ_Court.File_In_CA_LosAngeles.new(trim(party_name1,all) <> '' and trim(party_name2,all) <> '');

Civil_Court.Layout_In_Matter tLANew(fLA_new input) := Transform
self.process_date				:= civil_court.Version_Development;
self.vendor						  := '18';
self.state_origin				:= 'CA';
self.source_file				:= 'CA-LA-CNTY-CIV-COURT';
UpperCaseNum						:= ut.CleanSpacesAndUpper(input.case_number);
self.case_key					  := UpperCaseNum;
self.parent_case_key		:= '';
TempCourtCd							:= IF(STD.Str.Find(UpperCaseNum,'-',1) > 0,REGEXFIND('^(.*)-(.*)-(.*)$',UpperCaseNum,3)[1..2],
															 IF(STD.Str.Find(UpperCaseNum,'-',1) = 0 AND REGEXFIND('^[0-9]',UpperCaseNum),UpperCaseNum[3..4],
																	IF(REGEXFIND('^[A-Z]',UpperCaseNum),UpperCaseNum[1],'')));
self.court_code					:= ut.CleanSpacesAndUpper(TempCourtCd);
self.court						  := MAP(self.court_code = 'AR' => 'AIRPORT' ,
																self.court_code = 'AH' => 'ALHAMBRA',
																self.court_code = 'AV' => 'ANTELOPE VALLEY',
																self.court_code = 'AP' => 'APPEALS',
																self.court_code = 'B' => 'LA COUNTY, LA CENTRAL',
																self.court_code = 'BF' => 'BELLFLOWER',
																self.court_code = 'BH' => 'BEVERLY HILLS',
																self.court_code = 'BB' => 'BURBANK',
																self.court_code = 'CT' => 'CATALINA',
																self.court_code = 'CA' => 'CENTRAL ARRAIGNMENT COURTS',
																self.court_code = 'CW' => 'CENTRAL CIVIL WEST',
																self.court_code = 'CH' => 'CHATSWORTH',
																self.court_code = 'CC' => 'CHILDRENS COURT',
																self.court_code = 'CM' => 'COMPTON',
																self.court_code = 'CJ' => 'CRIMINAL JUSTICE CENTER',
																self.court_code = 'DW' => 'DOWNEY',
																self.court_code = 'EL' => 'EAST LOS ANGELES',
																self.court_code = 'EJ' => 'EASTLAKE JUVENILE',
																self.court_code = 'EM' => 'EL MONTE',
																self.court_code = 'GD' => 'GLENDALE',
																self.court_code = 'HW' => 'HOLLYWOOD',
																self.court_code = 'IW' => 'INGLEWOOD',
																self.court_code = 'IJ' => 'INGLEWOOD - JUVENILE',
																self.court_code = 'LJ' => 'JUVENILE JUSTICE - LANCASTER',
																self.court_code = 'LB' => 'LONG BEACH',
																self.court_code = 'LP' => 'LOS PADRINOS',
																self.court_code = 'MH' => 'MENTAL HEALTH',
																self.court_code = 'MT' => 'METROPOLITAN',
																self.court_code = 'NW' => 'NORWALK',
																self.court_code = 'PD' => 'PASADENA',
																self.court_code = 'PN' => 'POMONA NORTH',
																self.court_code = 'PS' => 'POMONA SOUTH',
																self.court_code = 'SF' => 'SAN FERNANDO',
																self.court_code = 'SC' => 'SANTA CLARITA',
																self.court_code = 'SM' => 'SANTA MONICA',
																self.court_code = 'SS' => 'SPRING STREET',
																self.court_code = 'ST' => 'STANLEY MOSK',
																self.court_code = 'SJ' => 'SYLMAR JUVENILE',
																self.court_code = 'TR' => 'TORRANCE',
																self.court_code = 'VE' => 'VAN NUYS EAST',
																self.court_code = 'VW' => 'VAN NUYS WEST',
																self.court_code = 'WC' => 'WEST COVINA',
																self.court_code = 'WH' => 'WHITTIER','');																
self.case_number				:= UpperCaseNum;
TempCaseType						:= IF(STD.Str.Find(UpperCaseNum,'-',1) = 0 AND REGEXFIND('^[0-9]',UpperCaseNum),UpperCaseNum[5..6],'CV');
self.case_type_code			:= ut.CleanSpacesAndUpper(TempCaseType);
self.case_type					:= MAP(self.case_type_code = 'AD' => 'ADOPTION',
																self.case_type_code = 'AO' => 'ARREST ONLY',
																self.case_type_code = 'LC' => 'CIVIL - LIMITED',
																self.case_type_code = 'CV' => 'CIVIL - UNLIMITED',
																self.case_type_code = 'CP' => 'CIVIL PETITIONS',
																self.case_type_code = 'CF' => 'CRIMINAL - FELONY',
																self.case_type_code = 'CM' => 'CRIMINAL MISDEMEANOR',
																self.case_type_code = 'PC' => 'CRIMINAL PETITION',
																self.case_type_code = 'CS' => 'CHILD SUPPORT',
																self.case_type_code = 'EX' => 'EXIT ORDERS (FAMILY LAW)',
																self.case_type_code = 'FL' => 'FAMILY LAW',
																self.case_type_code = 'GO' => 'GENERAL ORDER',
																self.case_type_code = 'IN' => 'INFRACTIONS',
																self.case_type_code = 'HC' => 'HABEAS CORPUS',
																self.case_type_code = 'JD' => 'JUVENILE DELINQUENCY',
																self.case_type_code = 'JP' => 'JUVENILE DEPENDENCY',
																self.case_type_code = 'MH' => 'MENTAL HEALTH - COURT',
																self.case_type_code = 'HH' => 'MENTAL HEALTH - HOSPITAL HEARINGS',
																self.case_type_code = 'PH' => 'PAROLE HEARING',
																self.case_type_code = 'PT' => 'PATERNITY',
																self.case_type_code = 'PR' => 'POST RELEASE COMMUNITY SUPERVISION',
																self.case_type_code = 'PB' => 'PROBATE',
																self.case_type_code = 'TR' => 'PROBATION TRANSFER',
																self.case_type_code = 'RO' => 'RESTRAINING ORDER',
																self.case_type_code = 'SC' => 'SMALL CLAIMS',
																self.case_type_code = 'SJ' => 'SUMMARY JUDGEMENT',
																self.case_type_code = 'UD' => 'UNLAWFUL DETAINER', '');
self.filing_date				:= trim(input.year_of_filing,all)+trim(input.month_of_filing,all)+trim(input.day_of_filing,all);
self := [];
END;

pLANew 	:= project(fLA_new,tLANew(left));

CombineAll := pLAOld + pLANew;

dLA 	:= dedup(sort(distribute(CombineAll,hash(case_key)),
                  process_date, case_key, court_code, court, case_number,
									case_type_code, case_type, filing_date,local),
									case_key, court, case_number, case_type, 
									filing_date,local,left):
									PERSIST('~thor_data400::in::civil_CA_LosAngeles_matter');


EXPORT Map_CA_LosAngeles_Matter := dLA(case_number <> '');