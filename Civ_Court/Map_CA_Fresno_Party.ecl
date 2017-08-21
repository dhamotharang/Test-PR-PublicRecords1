IMPORT Civ_Court, civil_court, crim_common, ut, lib_StringLib, Address; 

#option('multiplePersistInstances',FALSE);

fFresno := Civ_court.File_In_CA_Fresno(trim(case_title,all) <> '' and not regexfind('In re: [0-9]+',case_title,nocase));

party_pattern := '(.*)VS(.*)';
dba_pattern		:= '(.*)dba(.*)';

Civil_Court.Layout_In_Party  tFresno(fFresno input, integer1 C) := TRANSFORM
self.process_date				:= civil_court.Version_Development;
self.vendor						  := '21';
self.state_origin				:= 'CA';
self.source_file				:= 'CA-FRESNO-CO-CIV-CRT';
UpperCaseNum						:= ut.CleanSpacesAndUpper(input.case_number);
self.case_key					  := '21'+' '+UpperCaseNum[3..4]+' '+UpperCaseNum; //Not sure the reason for this since location code is alread in case_number
self.court_code					:= UpperCaseNum[3..4];
self.court						  :=	map(self.court_code = 'CE' => 'FRESNO COUNTY: CENTRAL DIVISION',
														self.court_code = 'CL' => 'FRESNO COUNTY: CLOVIS DIVISION',
														self.court_code = 'CO' => 'FRESNO COUNTY: COALINGA DIVISION',
														self.court_code = 'FI' => 'FRESNO COUNTY: FIREBAUGH DIVISION',
														self.court_code = 'FO' => 'FRESNO COUNTY: FOWLER DIVISION',
														self.court_code = 'KE' => 'FRESNO COUNTY: KERMAN DIVISION',
														self.court_code = 'RE' => 'FRESNO COUNTY: REEDLEY DIVISION',
														self.court_code = 'SA' => 'FRESNO COUNTY: SANGER DIVISION',
														self.court_code = 'SE' => 'FRESNO COUNTY: SELMA DIVISION','FRESNO COUNTY');
self.case_number				:= UpperCaseNum;
self.case_type_code			:= ut.CleanSpacesAndUpper(input.case_type)[1..2];
self.case_type					:= StringLib.StringCleanSpaces(REGEXREPLACE('LIMITED -|UNLIMITED -',ut.CleanSpacesAndUpper(input.case_type)[3..],''));
self.case_title					:= input.case_title;
TempName1								:= IF(REGEXFIND(party_pattern,input.case_title,NOCASE),REGEXFIND(party_pattern,input.case_title,1,NOCASE),trim(input.case_title,left,right));
ClnName1								:= REGEXREPLACE('in the matter of|in matter of',TempName1,'',NOCASE);
TempName2								:= REGEXFIND(party_pattern,input.case_title,2,NOCASE);
ClnName2								:= REGEXREPLACE('^\\.',TempName2,'');
self.entity_1						:= ut.CleanSpacesAndUpper(CHOOSE(C,ClnName1,ClnName2));
self.entity_nm_format_1	:='F';
self.entity_type_description_1_orig := CHOOSE(C, 'PLAINTIFF', 'DEFENDENT');
self.entity_type_code_1_master		  := CHOOSE(C, '10', '30');
self := [];
END;

pFresno	:= normalize(fFresno,2,tFresno(left,counter));

//Normaliz DBA name
Civil_Court.Layout_In_Party  NormDBA(pFresno input, integer1 C) := TRANSFORM
TempName1								:= IF(REGEXFIND(dba_pattern,input.entity_1,NOCASE),REGEXFIND(dba_pattern,input.entity_1,1,NOCASE),trim(input.entity_1,left,right));
ClnName1								:= REGEXREPLACE('AND$|,$',trim(TempName1,left,right),'');
TempName2								:= REGEXFIND(dba_pattern,input.entity_1,2,NOCASE);
ClnName2								:= REGEXREPLACE('^,',trim(TempName2,left,right),'');
self.entity_1						:= ut.CleanSpacesAndUpper(CHOOSE(C,ClnName1,ClnName2));
self := input;
END;

NormFresno	:= normalize(pFresno(entity_1 <> ''),2,NormDBA(left,counter));

Civ_court.Civ_Court_Cleaner(NormFresno,cleanFresno);

ddFresno 	:= dedup(sort(distribute(cleanFresno(entity_1 <> ''),hash(case_key)),
                  process_date,case_key, court, case_number, case_type_code, case_type, entity_1, entity_nm_format_1, 
									entity_type_code_1_orig, entity_type_description_1_orig, entity_type_code_1_master, local),
									case_key, court, case_number, case_type_code, case_type, entity_1, entity_nm_format_1, 
									entity_type_code_1_orig, entity_type_description_1_orig, entity_type_code_1_master, local,left):
									PERSIST('~thor_data400::in::civil_CA_Fresno_party');

EXPORT Map_CA_Fresno_Party := ddFresno;