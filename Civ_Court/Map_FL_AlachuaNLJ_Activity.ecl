IMPORT Civ_Court, civil_court, crim_common, ut, Address; 

#option('multiplePersistInstances',FALSE);

//original AbInitio mapping /stub_cleaning/court/work/mp/fl_civil_county_alachua__nlj_02_upd.mp
fAlachua_nlj := Civ_Court.Files_In_FL_Alachua.nlj;

fmtsin := '%m/%d/%Y';
fmtout := '%Y%m%d';

Civil_Court.Layout_In_Case_Activity tFLAlachuaNLJ(fAlachua_nlj input) := Transform
self.process_date				:= civil_court.Version_Development;
self.vendor						  := '46';
self.state_origin				:= 'FL';
self.source_file				:= 'FL-ALACHUA-CO-NLJ';
UpperCaseNum						:= ut.CleanSpacesAndUpper(input.case_number);
self.case_key					  := '46'+UpperCaseNum;
self.court						  := 'ALACHUA COUNTY - CIRCUIT CIVIL';
self.case_number				:= UpperCaseNum;
self.event_date					:= ut.ConvertDate(input.Docket_date);
self.event_type_code		:='';
self.event_type_description_1	:= 'DOCKET INFORMATION - CIRCUIT CIVIL VERDICT';
self.event_type_description_2	:= ut.CleanSpacesAndUpper(input.Docket_text);
self := [];
end;

pFlAlachuaNLJ 	:= project(fAlachua_nlj,tFLAlachuaNLJ(left));

dAlachua 	:= dedup(sort(distribute(pFlAlachuaNLJ,hash(case_key)),
									process_date,case_key,court_code,court,case_number,event_date,event_type_code,event_type_description_1,event_type_description_2,local),
									case_key,court_code,court,case_number,event_date,event_type_code,event_type_description_1,event_type_description_2,local,left):
									PERSIST('~thor_data400::in::civil_FL_AlachuaNLJ_activity');

EXPORT Map_FL_AlachuaNLJ_Activity := dAlachua;