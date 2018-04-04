IMPORT Civ_Court, civil_court, ut, lib_StringLib, Std;

#option('multiplePersistInstances',FALSE);

//original AbInitio mapping /stub_cleaning/court/work/mp/ia_civil_02.mp

fIA := Civ_Court.Files_In_IA.Civil_in;


fmtsin := [
		'%m/%d/%Y',
		'%d-%b-%y'
	];
	fmtout:='%Y%m%d';	

Civil_Court.Layout_In_Matter tIA(fIA input) := Transform
self.process_date				:= civil_court.Version_Development;
self.vendor						  := '88';
self.state_origin				:= 'IA';
self.source_file				:= 'IA STATEWIDE';
self.case_key					  := '88'+trim(input.case_number,left,right);
self.court_code					:= '';
self.court						  := 'IOWA CIVIL COURT';
self.case_number				:= trim(input.case_number,left,right);
self.case_title					:= trim(input.case_title,left,right);
self.filing_date				:= Std.Date.ConvertDateFormatMultiple(input.file_date,fmtsin,fmtout);
self := [];
end;

pIA 	:= project(fIA,tIA(left));

dIA 	:= dedup(sort(distribute(pIA,hash(case_key)),
                  process_date,case_key, court, case_number, filing_date,local),
									case_key, court, case_number, filing_date,local,left):
									PERSIST('~thor_data400::in::civil_IA_matter');

EXPORT Map_IA_Matter := dIA(case_number <> '');