IMPORT Civ_Court, civil_court, crim_common, ut, Address; 

#option('multiplePersistInstances',FALSE);

//original AbInitio mapping /stub_cleaning/court/work/mp/fl_civil_county_alachua_02_upd.mp
fAlachua_lte := Civ_Court.Files_In_FL_Alachua.lte;
fAlachu_civil	:= Civ_Court.Files_In_FL_Alachua.civil;

Civil_Court.Layout_In_Matter tFLAlachuaLTE(fAlachua_lte input) := Transform
self.process_date				:= civil_court.Version_Development;
self.vendor						  := '28';
self.state_origin				:= 'FL';
self.source_file				:= 'FL-CIV-ALACHUA-CO';
StdFileDate							:= input.file_date[5..8]+input.file_date[1..2]+input.file_date[3..4];
UpperCaseNum						:= ut.CleanSpacesAndUpper(input.case_number);
self.case_key					  := '28'+UpperCaseNum+StdFileDate;
self.court						  :=	IF(UpperCaseNum[1..2] = 'CC','ALACHUA COUNTY COURT','ALACHUA COUNTY CIRCUIT COURT');
self.case_number				:= UpperCaseNum[1..35];
self.case_type_code			:= 'LT';
self.case_type					:= 'LANDLORD/TENANT EVICTIONS';
self.case_cause					:= ut.CleanSpacesAndUpper(input.cause_of_action);
self.filing_date				:= if(StdFileDate <> '', StdFileDate, '');
self := [];
end;

pFlAlachuaLTE 	:= project(fAlachua_lte,tFLAlachuaLTE(left));

Civil_Court.Layout_In_Matter tFLAlachuaCiv(fAlachu_civil input) := Transform
self.process_date				:= civil_court.Version_Development;
self.vendor						  := '28';
self.state_origin				:= 'FL';
self.source_file				:= 'FL-CIV-ALACHUA-CO';
StdFileDate							:= input.filing_date[7..10]+input.filing_date[1..2]+input.filing_date[4..5];
UpperCaseNum						:= ut.CleanSpacesAndUpper(input.case_number);
self.case_key					  := '28'+UpperCaseNum+StdFileDate;
self.court						  :=	IF(UpperCaseNum[1..2] = 'CC','ALACHUA COUNTY COURT','ALACHUA COUNTY CIRCUIT COURT');
self.case_number				:= UpperCaseNum[1..35];
TempName1								:= ut.CleanSpacesAndUpper(IF(trim(input.last_name_1,all) <> '', input.first_name_1+' '+input.last_name_1,
															input.company_name_1));
TempName2								:= ut.CleanSpacesAndUpper(IF(trim(input.last_name_2,all) <> '', input.first_name_2+' '+input.last_name_2,
															input.company_name_2)); 
self.case_title					:= '';
self.case_cause					:= ut.CleanSpacesAndUpper(input.filing_action);
self.filing_date				:= if(StdFileDate <> '', StdFileDate, '');
self := [];
end;

pFlAlachuaCiv 	:= project(fAlachu_civil,tFLAlachuaCiv(left));

//Combine both Matter outputs
CombineAll	:= pFlAlachuaLTE+pFlAlachuaCiv;

dAlachua 	:= dedup(sort(distribute(CombineAll,hash(case_key)),
                  process_date,case_key, court, case_number, case_type_code, case_type, case_title, 
									case_cause, filing_date,local),
									case_key, court, case_number, case_type_code, case_type, case_title, 
									case_cause, filing_date,local,left):
									PERSIST('~thor_data400::in::civil_FL_AlachuaLTE_matter');

EXPORT Map_FL_AlachuaLTE_Matter := dAlachua;