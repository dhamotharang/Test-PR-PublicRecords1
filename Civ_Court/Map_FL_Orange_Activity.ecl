IMPORT Civ_Court, civil_court, crim_common, ut;

#option('multiplePersistInstances',FALSE);

//original AbInitio mapping /stub_cleaning/court/work/mp/fl_civil_county_orange02.mp

fOrange := Civ_Court.Files_In_FL_Orange.Raw_RecType_3;

fmtsin := '%m/%d/%Y';
fmtout := '%Y%m%d';

Civil_Court.Layout_In_Case_Activity tFLOrange(fOrange input) := Transform
self.process_date				:= civil_court.Version_Development;
self.vendor						  := '42';
self.state_origin				:= 'FL';
self.source_file				:= 'FL-ORANGE_CTY';
UpperCaseNum						:= ut.CleanSpacesAndUpper(input.case_no);
self.case_key					  := '42'+UpperCaseNum;
self.court						  := 'ORANGE COUNTY COURT: '+ut.CleanSpacesAndUpper(input.court);
self.case_number				:= UpperCaseNum;
self.event_date					:= ut.ConvertDate(input.event_date);
self.event_type_code		:= ut.CleanSpacesAndUpper(input.event_code);
self.event_type_description_1	:= ut.CleanSpacesAndUpper(input.event_code_desc);
self := [];
end;

pFlOrange 	:= project(fOrange,tFLOrange(left));

dOrange 	:= dedup(sort(distribute(pFlOrange,hash(case_key)),
									process_date,case_key,court,case_number,event_date,event_type_code,event_type_description_1,local),
									case_key,court,case_number,event_date,event_type_code,event_type_description_1,local,left):
									PERSIST('~thor_data400::in::civil_FL_Orange_activity');


EXPORT Map_FL_Orange_Activity := dOrange(case_number <> '');