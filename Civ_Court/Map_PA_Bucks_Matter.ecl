IMPORT Civ_Court, civil_court, crim_common, ut; 

#option('multiplePersistInstances',FALSE);

//original AbInitio mapping /stub_cleaning/court/work/mp/pa_civil_county_bucks_02.mp
fBucks := Civ_Court.Files_In_PA_Bucks.Civil_join;

Civil_Court.Layout_In_Matter tBucks(fBucks input) := TRANSFORM
self.process_date				:= civil_court.Version_Development;
self.vendor						  := '60';
self.state_origin				:= 'PA';
self.source_file				:= 'PA-BUCKS-CIVIL-COURT';
UpperCaseNum						:= ut.CleanSpacesAndUpper(input.dock_no);
self.case_key					  := '60'+UpperCaseNum;
self.court						  :=	'PA BUCKS COUNTY CIVIL COURT';
self.case_number				:= UpperCaseNum;
self.case_type_code			:= ut.CleanSpacesAndUpper(input.d_class_type);
self.case_type					:= ut.CleanSpacesAndUpper(input.d_class_desc);
self.filing_date				:= IF(trim(input.n_date_filed,all) <> '', trim(input.n_date_filed,all), '');
self.judgmt_date				:= IF(trim(input.d_date_filed,all) <> '' and (integer)input.d_date_filed <= (integer)input.n_date_filed and
														(integer)input.d_date_filed[1..4] > 1906, trim(input.d_date_filed,all), '');
self := [];
end;

pBucks 	:= project(fBucks,tBucks(left));

dBucks 	:= dedup(sort(distribute(pBucks,hash(case_key)),
                  process_date,case_key, court, case_number, case_type_code, case_type,
									filing_date,judgmt_date,local),
									case_key, court, case_number, case_type_code, case_type, 
									filing_date,judgmt_date,local,left):
									PERSIST('~thor_data400::in::civil_PA_Bucks_matter');

EXPORT Map_PA_Bucks_Matter := dBucks;