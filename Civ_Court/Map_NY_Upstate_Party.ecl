IMPORT Civ_Court, civil_court, ut,  Address, lib_StringLib, STD;

#option('multiplePersistInstances',FALSE);

//original AbInitio mapping /stub_cleaning/court/work/mp/ny_civil_downstate_02_update.mp

fCase	:= Civ_Court.Files_In_NY_Upstate.Case_in(idxno <> '');
fAty	:= Civ_Court.Files_In_NY_Upstate.Atty_In(attorney_client <> '');
fMtn	:= Civ_Court.Files_In_NY_Upstate.Mtn_in(justice <> '');
fApr	:= Civ_Court.Files_In_NY_Upstate.Apr_in(justice <> '');

// Lookups
court	:= Civ_Court.Files_In_NY_Upstate.County_lkp;
justice_lkp	:= dedup(sort(Civ_Court.Files_In_NY_Upstate.Justice_lkp(literal_justice_name <> ''),county_code,justice,cars_id,justice_last_name,justice_first_name,part_no,part_num));
action_type	:= dedup(sort(Civ_court.Files_In_NY_Upstate.Action_type_lkp,code,action_type,description));

//Temp layout to do a county lookup which will be used for other file joins. Only outputting fields needed for party file
l_temp	:= RECORD
	string2 	county_code;
	string13  county;				//used to store county field needed for court
  string15	idxno;
	string2 	court_code;
	string40	plaintiff;
  string40 	defendant;
	string5 	action_type;
	string5 	justice;
	string5 	pj_justice;
	string5 	mtn_justice;
	string5 	apr_justice;
END;

//Do court code lookup because court_type is needed and not stored in final output
l_temp	lkpCourt(fCase L, court R)	:= TRANSFORM
	self.county_code	:= L.county_code;
	self.county				:= ut.CleanSpacesAndUpper(R.description); //used for court
	self.idxno				:= L.idxno;
	self.plaintiff		:= ut.CleanSpacesAndUpper(L.plaintiff);
  self.defendant		:= ut.CleanSpacesAndUpper(L.defendant);
	self.action_type	:= ut.CleanSpacesAndUpper(L.action_type);
	self.justice			:= ut.CleanSpacesAndUpper(L.justice);
	self.pj_justice		:= ut.CleanSpacesAndUpper(L.pj_justice);
	self := L;
	self := [];
END;

jCaseCourt	:= join(sort(distribute(fCase,hash(county_code)),county_code,local),
										sort(distribute(court,hash(code)),code,local),
										trim(left.county_code,all) = trim(right.code,all),
										lkpCourt(left,right),left outer,lookup,local);
										
//Split out multiple defendant names
aka_pattern := '(.*)(AKA |A/K/A |F/K/A |DBA |D/B/A )(.*)';
l_temp2	:= RECORD
	integer		WordCount_pl;
	integer		WordCount_def;
	string2 	county_code;
	string13  county;				//used to store county field needed for court
  string15	idxno;
	string2 	court_code;
	string40	plaintiff;
  string40 	defendant;
	string5 	action_type;
	string5 	justice;
	string5 	pj_justice;
	string5 	mtn_justice;
	string5 	apr_justice;
	string		pl_aka;
	string		plaintiff1;
	string		plaintiff2;
	string		plaintiff3;
	string		def_aka;
	string		defendant1;
	string		defendant2;
	string		defendant3;
END;

l_temp2 SplitNames(jCaseCourt L) := TRANSFORM
	self.WordCount_pl		:= STD.STr.CountWords(L.plaintiff,';');
	self.WordCount_def	:= STD.STr.CountWords(L.defendant,';');
	CleanPl				:= REGEXREPLACE(';$',L.plaintiff,'');
	TempPl				:= IF(STD.STr.FIND(CleanPl,';') > 0,REGEXREPLACE('$',CleanPl,';'),CleanPl);
	self.pl_aka		:= trim(IF(REGEXFIND(aka_pattern,TempPl),REGEXFIND(aka_pattern,TempPl,3),''),left,right); //Not used - missing too much info
	self.plaintiff1	:= trim(IF(self.WordCount_pl = 1 and ~REGEXFIND(aka_pattern,TempPl),TempPl,
													IF(self.WordCount_pl = 1 and REGEXFIND(aka_pattern,TempPl),
														REGEXREPLACE('(AKA |A/K/A |F/K/A |DBA |D/B/A )(.*)',TempPl,''),
														IF(self.WordCount_pl > 1, TempPl[1..STD.Str.Find(TempPl,';',1) - 1],TempPl))),left,right);
	self.plaintiff2	:= trim(IF(self.WordCount_pl > 1, TempPl[STD.Str.Find(TempPl,';',1)+ 1..STD.Str.Find(TempPl,';',2) - 1],''),left,right);
	self.plaintiff3	:= trim(IF(self.WordCount_pl > 2, TempPl[STD.Str.Find(TempPl,';',2)+ 1..STD.Str.Find(TempPl,';',3) - 1],''),left,right);
	CleanDef				:= REGEXREPLACE(';$',L.defendant,'');
	TempDef					:= IF(STD.STr.FIND(CleanDef,';') > 0,REGEXREPLACE('$',CleanDef,';'),CleanDef);
	self.def_aka		:= trim(IF(REGEXFIND(aka_pattern,TempDef),REGEXFIND(aka_pattern,TempDef,3),''),left,right);
	self.defendant1	:= trim(IF(self.WordCount_def = 1 and ~REGEXFIND(aka_pattern,TempDef),TempDef,
													IF(self.WordCount_def = 1 and REGEXFIND(aka_pattern,TempDef),
														REGEXREPLACE('(AKA |A/K/A |F/K/A |DBA |D/B/A )(.*)',TempDef,''),
														IF(self.WordCount_def > 1, TempDef[1..STD.Str.Find(TempDef,';',1) - 1],TempDef))),left,right);
	self.defendant2	:= trim(IF(self.WordCount_def > 1, TempDef[STD.Str.Find(TempDef,';',1)+ 1..STD.Str.Find(TempDef,';',2) - 1],''),left,right);
	self.defendant3	:= trim(IF(self.WordCount_def > 2, TempDef[STD.Str.Find(TempDef,';',2)+ 1..STD.Str.Find(TempDef,';',3) - 1],''),left,right);
	self	:= L;
	self 	:= [];
END;
	
dParseNames	:= project(jCaseCourt, SplitNames(left));
										
//Process Case file first - will process each seperately then concat at the end
Civil_Court.Layout_In_Party tCase(dParseNames input, integer1 C)	:= TRANSFORM
self.process_date				:= civil_court.Version_Development;
self.vendor						  := '30';
self.state_origin				:= 'NY';
self.source_file				:= 'NY-UPSTATE-CIV-COURT';
ClnCase									:= trim(input.county_code,all)+trim(input.idxno,all);
self.case_key					  := '30'+ ClnCase;
self.parent_case_key		:= '';
self.court_code					:= trim(input.county_code,all);
self.court						  := map(trim(input.court_code) = '0' => 'NEW YORK STATE LOWER CIVIL COURT: '+input.county,
																trim(input.court_code) = '1' => 'NEW YORK STATE SUPREME CIVIL COURT: '+input.county,
																'NEW YORK STATE COURT');
self.case_number				:= ClnCase;
self.case_type_code			:= input.action_type;
self.case_type					:= '';
self.case_title					:= IF(input.plaintiff <> '',ut.CleanSpacesAndUpper(input.plaintiff)+' VS '+ ut.CleanSpacesAndUpper(input.defendant),'');
self.entity_1						:= CHOOSE(C,input.plaintiff1,input.plaintiff2,input.plaintiff3,
																		input.def_aka,input.defendant1,input.defendant2,input.defendant3,
																		input.justice,input.pj_justice);
self.entity_nm_format_1	:= CHOOSE(C,'U','U','U','U','U','U','U','F','F');
self.entity_type_code_1_orig	:= CHOOSE(C,'','','','','','','',input.justice,input.pj_justice);
self.entity_type_description_1_orig := CHOOSE(C,'PLAINTIFF','PLAINTIFF','PLAINTIFF',
																								'DEFENDANT AKA','DEFENDANT','DEFENDANT','DEFENDANT',
																								'JUSTICE','POST JUDGEMENT JUSTICE');
self.entity_type_code_1_master := CHOOSE(C,'10','10','10','30','30','30','30','60','60');
self := [];
END;

nCase	:= normalize(dParseNames,9,tCase(left,counter));

//Process Motion file - join to case to get fields for case_key and court and to prevent orphans
l_temp joinCaseMtn(jCaseCourt L, fMtn R) := TRANSFORM
	self.mtn_justice	:= ut.CleanSpacesAndUpper(R.justice);
	self := L;
	self := [];
END;

jCaseMtn	:= join(sort(distribute(jCaseCourt,hash(county_code,idxno)),county_code,idxno,local),
									sort(distribute(fMtn,hash(county_code,idxno)),county_code,idxno,local),
									trim(left.county_code,all) = trim(right.county_code,all) and
									trim(left.idxno,all) = trim(right.idxno,all),
									joinCaseMtn(left,right),left outer, local);
									
Civil_Court.Layout_In_Party tMtn(jCaseMtn input)	:= TRANSFORM
self.process_date				:= civil_court.Version_Development;
self.vendor						  := '30';
self.state_origin				:= 'NY';
self.source_file				:= 'NY-UPSTATE-CIV-COURT';
ClnCase									:= trim(input.county_code,all)+trim(input.idxno,all);
self.case_key					  := '30'+ ClnCase;
self.parent_case_key		:= '';
self.court_code					:= trim(input.county_code,all);
self.court						  := map(trim(input.court_code) = '0' => 'NEW YORK STATE LOWER CIVIL COURT: '+input.county,
																trim(input.court_code) = '1' => 'NEW YORK STATE SUPREME CIVIL COURT: '+input.county,
																'NEW YORK STATE COURT');
self.case_number				:= ClnCase;
self.case_type_code			:= input.action_type;
self.case_type					:= '';
self.case_title					:= IF(input.plaintiff <> '',ut.CleanSpacesAndUpper(input.plaintiff)+' VS '+ ut.CleanSpacesAndUpper(input.defendant),'');
self.entity_1						:= input.mtn_justice;
self.entity_nm_format_1	:= 'F';
self.entity_type_code_1_orig	:= input.mtn_justice;
self.entity_type_description_1_orig := 'JUSTICE';
self.entity_type_code_1_master := '60';
self := [];
END;

pMtn	:= project(jCaseMtn, tMtn(left));
									
//Process Appearance file - join to case to get fields for case_key and court and to prevent orphans
l_temp joinCaseApr(jCaseCourt L, fApr R) := TRANSFORM
	self.apr_justice	:= ut.CleanSpacesAndUpper(R.justice);
	self := L;
	self := [];
END;

jCaseApr	:= join(sort(distribute(jCaseCourt,hash(county_code,idxno)),county_code,idxno,local),
									sort(distribute(fApr,hash(county_code,idxno)),county_code,idxno,local),
									trim(left.county_code,all) = trim(right.county_code,all) and
									trim(left.idxno,all) = trim(right.idxno,all),
									joinCaseApr(left,right),left outer, local);
									
Civil_Court.Layout_In_Party tApr(jCaseApr input)	:= TRANSFORM
self.process_date				:= civil_court.Version_Development;
self.vendor						  := '30';
self.state_origin				:= 'NY';
self.source_file				:= 'NY-UPSTATE-CIV-COURT';
ClnCase									:= trim(input.county_code,all)+trim(input.idxno,all);
self.case_key					  := '30'+ ClnCase;
self.parent_case_key		:= '';
self.court_code					:= trim(input.county_code,all);
self.court						  := map(trim(input.court_code) = '0' => 'NEW YORK STATE LOWER CIVIL COURT: '+input.county,
																trim(input.court_code) = '1' => 'NEW YORK STATE SUPREME CIVIL COURT: '+input.county,
																'NEW YORK STATE COURT');
self.case_number				:= ClnCase;
self.case_type_code			:= input.action_type;
self.case_type					:= '';
self.case_title					:= IF(input.plaintiff <> '',ut.CleanSpacesAndUpper(input.plaintiff)+' VS '+ ut.CleanSpacesAndUpper(input.defendant),'');
self.entity_1						:= input.apr_justice;
self.entity_nm_format_1	:= 'F';
self.entity_type_code_1_orig	:= input.apr_justice;
self.entity_type_description_1_orig := 'APPEARANCE JUSTICE';
self.entity_type_code_1_master := '60';
self := [];
END;

pApr	:= project(jCaseApr, tApr(left));

//Concat all outputs together and dedup
concatAll	:= nCase(entity_1 <> '')+pMtn(entity_1 <> '')+pApr(entity_1 <> '');
dedAll		:= dedup(sort(distribute(concatAll, hash(case_key)),case_key, entity_1, local), local);

BadNames := 'JOHN DOE|ALL JUDGES|TEST |UNKNOWN JUDGE|TO BE ANNOUNCED|REF |1ST JUDGE|2ND JUDGE|TRIAL CALENDAR|/(.*)';
//Lookup justice name
Civil_Court.Layout_In_Party tJustice(dedAll L, justice_lkp R) := TRANSFORM
tempName				:= IF(REGEXFIND('^[0-9]',L.entity_1),ut.CleanSpacesAndUpper(R.literal_justice_name),L.entity_1);
self.entity_1		:= REGEXREPLACE(BadNames,tempName,'');
self.entity_1_address_1	:= IF(REGEXFIND('^[0-9]',L.entity_1),ut.CleanSpacesAndUpper(R.justice_address),'');
self.entity_1_address_2	:= IF(REGEXFIND('^[0-9]',L.entity_1),ut.CleanSpacesAndUpper(R.justice_city_state),'');
self.entity_1_address_3	:= IF(REGEXFIND('^[0-9]',L.entity_1),trim(R.justice_zip,all),'');
self := L;
END;

lkpJusticeName	:= join(sort(distribute(dedAll,hash(court_code,entity_1)),court_code,entity_1,local),
												sort(distribute(justice_lkp,hash(county_code,justice)),county_code,justice,justice_last_name,justice_first_name,local),
												trim(left.court_code,all) = trim(right.county_code,all) and
												trim(left.entity_1,left,right) = trim(right.justice,left,right),
												tJustice(left,right), left outer, lookup,local);
												
//Lookup action type(case_type) - *There is a description field in the raw CAS input file, but lookup file is more detailed
Civil_Court.Layout_In_Party tAction(lkpJusticeName L, action_type R) := TRANSFORM
self.case_type	:= ut.CleanSpacesAndUpper(R.description);
self := L;
END;

jNYAction	:= join(sort(distribute(lkpJusticeName(entity_1 <> ''),hash(court_code,case_type_code)),court_code,case_type_code,local),
									sort(distribute(action_type,hash(code,action_type)),code,action_type,description,local),
									trim(left.court_code,all)	= trim(right.code,all) and
									trim(left.case_type_code,all) = trim(right.action_type,all),
									tAction(left,right), left outer, lookup,local);

Civ_court.Civ_Court_Cleaner(jNYAction,cleanNY);

ddNY 	:= dedup(sort(distribute(cleanNY,hash(case_key)),
                  process_date, case_key, court, case_number, entity_1, entity_nm_format_1, 
									entity_type_description_1_orig, entity_type_code_1_master,
									entity_1_address_1, entity_1_address_2, entity_1_address_3, local),
									case_key, court, case_number, entity_1, entity_nm_format_1, 
									entity_type_description_1_orig, entity_type_code_1_master,
									entity_1_address_1, entity_1_address_2, entity_1_address_3, local,left):
									PERSIST('~thor_data400::in::civil_NY_Upstate_party');

EXPORT Map_NY_Upstate_Party := ddNY(regexfind('^[A-Z]',entity_1));