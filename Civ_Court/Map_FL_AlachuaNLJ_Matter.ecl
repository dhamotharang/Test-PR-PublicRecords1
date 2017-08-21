IMPORT Civ_Court, civil_court, crim_common, ut, Address; 

#option('multiplePersistInstances',FALSE);

//original AbInitio mapping /stub_cleaning/court/work/mp/fl_civil_county_alachua__nlj_02_upd.mp
fAlachua_nlj := Civ_Court.Files_In_FL_Alachua.nlj;

Civil_Court.Layout_In_Matter tFLAlachuaNLJ(fAlachua_nlj input) := Transform
self.process_date				:= civil_court.Version_Development;
self.vendor						  := '46';
self.state_origin				:= 'FL';
self.source_file				:= 'FL-ALACHUA-CO-NLJ';
UpperCaseNum						:= ut.CleanSpacesAndUpper(input.case_number);
self.case_key					  := '46'+UpperCaseNum;
self.court						  := 'ALACHUA COUNTY - CIRCUIT CIVIL';
self.case_number				:= UpperCaseNum;
self.case_type_code			:= '';
self.case_type					:= 'CIRCUIT CIVIL VERDICT';
self := [];
end;

pFlAlachuaNLJ 	:= project(fAlachua_nlj,tFLAlachuaNLJ(left));

dAlachua 	:= dedup(sort(distribute(pFlAlachuaNLJ,hash(case_key)),
                  process_date,case_key, court, case_number, case_type,local),
									case_key, court, case_number, case_type,local,left):
									PERSIST('~thor_data400::in::civil_FL_AlachuaNLJ_matter');

EXPORT Map_FL_AlachuaNLJ_Matter := dAlachua;