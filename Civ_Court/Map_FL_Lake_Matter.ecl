IMPORT Civ_Court, civil_court, crim_common, ut, lib_StringLib; 

#option('multiplePersistInstances',FALSE);

fLake := Civ_court.File_In_FL_Lake;

fmtsin := '%m/%d/%Y';
fmtout := '%Y%m%d';
	
Civil_Court.Layout_In_Matter tLake(fLake input) := TRANSFORM
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
self.disposition_date		:= IF(trim(input.date_of_eviction,all) <> '', ut.ConvertDate(input.date_of_eviction), '');
self := [];
END;

pLake 	:= project(fLake,tLake(left));

dLake 	:= dedup(sort(distribute(pLake,hash(case_key)),
                  process_date,case_key, court, case_number, case_type,
									disposition_date,local),
									case_key, court, case_number, case_type, 
									disposition_date,local,left):
									PERSIST('~thor_data400::in::civil_FL_Lake_matter');

EXPORT Map_FL_Lake_Matter := dLake(trim(case_number,all)<> '');