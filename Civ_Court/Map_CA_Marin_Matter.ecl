IMPORT Civ_Court, civil_court, crim_common, ut, lib_StringLib; 

#option('multiplePersistInstances',FALSE);

fMarin := Civ_court.File_In_CA_Marin;

fmtsin := '%m/%d/%Y';
fmtout := '%Y%m%d';

Civil_Court.Layout_In_Matter tMarin(fMarin input) := TRANSFORM
self.process_date				:= civil_court.Version_Development;
self.vendor						  := '38';
self.state_origin				:= 'CA';
self.source_file				:= 'CA-MARIN_CTY';
UpperCaseNum						:= ut.CleanSpacesAndUpper(input.case_number);
self.case_key					  := '38'+UpperCaseNum;
self.court						  := 'MARIN COUNTY, CA MUNICIPAL COURT';
self.case_number				:= UpperCaseNum;
self.case_type					:= ut.CleanSpacesAndUpper(input.case_type);
self.filing_date				:= ut.ConvertDate(input.date_filed);
self.disposition_description	:= ut.CleanSpacesAndUpper(input.disposition);
self.disposition_date		:= ut.ConvertDate(input.disposition_date);
self := [];
END;

pMarin 	:= project(fMarin,tMarin(left));

dMarin 	:= dedup(sort(distribute(pMarin,hash(case_key)),
                  process_date,case_key, court, case_number, case_type,
									filing_date,disposition_date,local),
									case_key, court, case_number, case_type, filing_date,
									disposition_description, disposition_date,local,left):
									PERSIST('~thor_data400::in::civil_CA_Marin_matter');

EXPORT Map_CA_Marin_Matter := dMarin(case_number <> '');