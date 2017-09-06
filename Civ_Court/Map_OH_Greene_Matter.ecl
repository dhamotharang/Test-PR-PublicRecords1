IMPORT Civ_Court, civil_court, ut, lib_StringLib, STD; 

#option('multiplePersistInstances',FALSE);

//original AbInitio mapping /stub_cleaning/court/work/mp/oh_civil_greene_co_02.mp

fGreene := Civ_court.File_In_OH_Greene;

fmtsin := [
		'%m/%d/%Y',
		'%m/%d/%Y'
	];
	fmtout:='%Y%m%d';	

Civil_Court.Layout_In_Matter tGreene(fGreene input) := TRANSFORM
self.process_date				:= civil_court.Version_Development;
self.vendor						  := '65';
self.state_origin				:= 'OH';
self.source_file				:= 'OH-CIV-GREENE-CO';
UpperCaseNum						:= ut.CleanSpacesAndUpper(input.case_num);
self.case_key					  := '65'+UpperCaseNum;
self.court_code					:= '';
self.court							:= 'GREENE COUNTY';
self.case_number				:= UpperCaseNum;
self.case_type					:= ut.CleanSpacesAndUpper(input.charge);
self.case_title					:= REGEXREPLACE('JTC|SAW',ut.CleanSpacesAndUpper(input.case_name),'');
TempFileDte							:= IF(trim(input.file_date,all) <> '', Std.Date.ConvertDateFormatMultiple(input.file_date,fmtsin,fmtout), '');
self.filing_date				:= IF(STD.DATE.IsValidDate((INTEGER) TempFileDte),TempFileDte,'');
self := [];
END;

pGreene 	:= project(fGreene,tGreene(left));

dGreene 	:= dedup(sort(distribute(pGreene,hash(case_key)),
                  process_date,case_key, court, case_number, case_type,
									case_title, filing_date,local),
									case_key, court, case_number, case_type, filing_date,
									case_title, disposition_description,local,left):
									PERSIST('~thor_data400::in::civil_OH_Greene_matter');


EXPORT Map_OH_Greene_Matter := dGreene(case_number <> '');