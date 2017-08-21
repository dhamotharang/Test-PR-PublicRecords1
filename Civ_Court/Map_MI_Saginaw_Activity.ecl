IMPORT Civ_Court, civil_court, crim_common, ut, lib_StringLib;

#option('multiplePersistInstances',FALSE);

//original AbInitio mapping /stub_cleaning/court/work/mp/mi_civil_county_saginaw02.mp

fSaginaw := Civ_court.File_In_MI_Saginaw;

fmtsin := [
		'%m/%d/%Y',
		'%m/%d/%y'
];
fmtout := '%Y%m%d';

Civil_Court.Layout_In_Case_Activity tSaginaw(fSaginaw input, integer1 C) := TRANSFORM
self.process_date				:= civil_court.Version_Development;
self.vendor						  := '56';
self.state_origin				:= 'MI';
self.source_file				:= 'MI-CIV-SAGINAW-CO';
UpperCaseNum						:= ut.CleanSpacesAndUpper(input.case_num);
self.case_key					  := '56'+UpperCaseNum;
self.court_code					:= '';
self.court							:= 'COUNTY OF SAGINAW 70TH DISTRICT STATE COURT';
self.case_number				:= UpperCaseNum;
self.event_date					:= CHOOSE(C,input.activity_date1,input.activity_date2,input.activity_date3,input.activity_date4,input.activity_date5,
																		input.activity_date6,input.activity_date7,input.activity_date8,input.activity_date9,input.activity_date10);
self.event_type_description_1 := CHOOSE(C,input.activity1,input.activity2,input.activity3,input.activity4,input.activity5,
																		input.activity6,input.activity7,input.activity8,input.activity9,input.activity10);
self := [];
end;

pSaginaw	:= normalize(fSaginaw,10,tSaginaw(left,counter));

filterSaginaw := pSaginaw(event_type_description_1 <> '');

dMI 	:= dedup(sort(distribute(filterSaginaw,hash(case_key)),
									process_date,case_key,court,case_number,event_date,event_type_description_1,local),
									case_key,court,case_number,event_date,event_type_description_1,local,left):
									PERSIST('~thor_data400::in::civil_MI_Saginaw_activity');

EXPORT Map_MI_Saginaw_Activity := dMI;