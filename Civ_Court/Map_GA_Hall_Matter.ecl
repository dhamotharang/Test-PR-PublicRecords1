IMPORT Civ_Court, civil_court, crim_common, ut, lib_StringLib, Std; 

#option('multiplePersistInstances',FALSE);

fHall := Civ_court.File_In_GA_Hall;

fmtsin := [
		'%m/%d/%Y',
		'%m/%d/%Y'
	];
	fmtout:='%Y%m%d';	
	
Civil_Court.Layout_In_Matter tHall(fHall input) := TRANSFORM
self.process_date				:= civil_court.Version_Development;
self.vendor						  := '62';
self.state_origin				:= 'GA';
self.source_file				:= 'GA-HALL_CTY-CIV-CRT';
UpperCaseNum						:= ut.CleanSpacesAndUpper(input.docket_number);
self.case_key					  := '62'+UpperCaseNum;
self.court_code					:= '';
self.court							:= 'HALL COUNTY COURT';
self.case_number				:= UpperCaseNum;
self.case_type					:= ut.CleanSpacesAndUpper(input.case_type);
self.filing_date				:= IF(trim(input.date_filed,all) <> '', Std.date.ConvertDateFormatMultiple(input.date_filed,fmtsin,fmtout), '');
self.disposition_description	:= ut.CleanSpacesAndUpper(input.disposition);
self := [];
END;

pHall 	:= project(fHall,tHall(left));

dHall 	:= dedup(sort(distribute(pHall,hash(case_key)),
                  process_date,case_key, court, case_number, case_type,
									filing_date,local),
									case_key, court, case_number, case_type, 
									filing_date,disposition_description,local,left):
									PERSIST('~thor_data400::in::civil_GA_Hall_matter');

EXPORT Map_GA_Hall_Matter := dHall(trim(case_number,all) <> '');