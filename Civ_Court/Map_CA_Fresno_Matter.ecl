IMPORT Civ_Court, civil_court, crim_common, ut, lib_StringLib; 

#option('multiplePersistInstances',FALSE);

fFresno := Civ_court.File_In_CA_Fresno(trim(case_title,all) <> '' and not regexfind('In re: [0-9]+',case_title,nocase));

fmtsin := '%m/%d/%Y';
fmtout := '%Y%m%d';

Civil_Court.Layout_In_Matter tFresno(fFresno input) := TRANSFORM
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
CleanFileDate						:= ut.ConvertDate(input.file_date);
self.filing_date				:= IF(trim(input.file_date,all) <> '', CleanFileDate, '');
self.disposition_description	:= ut.CleanSpacesAndUpper(input.current_case_status);
CleanStatusDte					:= ut.ConvertDate(input.case_status_date);
self.disposition_date		:= IF(trim(input.case_status_date,all) <> '', CleanStatusDte,'');
self := [];
END;

pFresno 	:= project(fFresno,tFresno(left));

dFresno 	:= dedup(sort(distribute(pFresno,hash(case_key)),
                  process_date,case_key, court, case_number, case_type_code, case_type,
									filing_date,disposition_date,local),
									case_key, court, case_number, case_type_code, case_type, 
									filing_date,disposition_description, disposition_date,local,left):
									PERSIST('~thor_data400::in::civil_CA_Fresno_matter');

EXPORT Map_CA_Fresno_Matter := dFresno(case_number <> '');