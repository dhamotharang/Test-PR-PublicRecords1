IMPORT Civ_Court, civil_court, crim_common, ut, Std;

#option('multiplePersistInstances',FALSE);

//original AbInitio mapping /stub_cleaning/court/work/mp/fl_civil_county_orange02.mp

fOrange := Civ_Court.Files_In_FL_Orange.Raw_RecType_1;

fmtsin := [
		'%m/%d/%Y',
		'%m/%d/%Y'
	];
	fmtout:='%Y%m%d';	

Civil_Court.Layout_In_Matter tFLOrange(fOrange input) := Transform
self.process_date				:= civil_court.Version_Development;
self.vendor						  := '42';
self.state_origin				:= 'FL';
self.source_file				:= 'FL-ORANGE_CTY';
UpperCaseNum						:= ut.CleanSpacesAndUpper(input.case_no);
self.case_key					  := '42'+UpperCaseNum;
self.court						  := 'ORANGE COUNTY COURT: '+ut.CleanSpacesAndUpper(input.court);
self.case_number				:= UpperCaseNum;
self.filing_date				:= IF(trim(input.filing_date,all) <> '', Std.Date.ConvertDateFormatMultiple(input.filing_date,fmtsin,fmtout), '');
self.disposition_description	:= If(trim(input.disposition_desc,left,right) = '', ut.CleanSpacesAndUpper(input.case_status_desc),
																		ut.CleanSpacesAndUpper(input.disposition_desc));
self.disposition_date		:= If(trim(input.disposition_desc,left,right) = '',Std.Date.ConvertDateFormatMultiple(input.case_status_date,fmtsin,fmtout),
															Std.Date.ConvertDateFormatMultiple(input.disposition_date,fmtsin,fmtout));
self := [];
end;

pFlOrange 	:= project(fOrange,tFLOrange(left));

fOrangeNew := Civ_Court.Files_In_FL_Orange.new_raw;

Civil_Court.Layout_In_Matter tFLOrangeNew(fOrangeNew input) := Transform
self.process_date				:= civil_court.Version_Development;
self.vendor						  := '42';
self.state_origin				:= 'FL';
self.source_file				:= 'FL-ORANGE_CTY';
self.case_key					  := '42'+ input.UniformCaseNumber;
self.court						  := 'ORANGE COUNTY COURT';
self.case_number				:= input.UniformCaseNumber;
self.filing_date				:= IF(trim(input.CaseFileDate,all) <> '', ut.ConvertDate(input.CaseFileDate), '');
self.disposition_description	:= If(trim(input.DispositionDesc,left,right) = '', '',
																		ut.CleanSpacesAndUpper(input.DispositionDesc));
self.disposition_date		:= If(trim(input.DispositionDate,left,right)<> '',ut.ConvertDate(input.DispositionDate),
															'');
self := [];
end;

pFlOrangeNew 	:= project(fOrangeNew,tFLOrangeNew(left));

pFlOrangeAll := pFlOrange + pFlOrangeNew;

dOrange 	:= dedup(sort(distribute(pFlOrange,hash(case_key)),
                  process_date,case_key, court, case_number, filing_date, disposition_date,local),
									case_key, court, case_number, filing_date, disposition_date, disposition_description,local,left):
									PERSIST('~thor_data400::in::civil_FL_Orange_matter');

EXPORT Map_FL_Orange_Matter := dOrange(case_number <> '');