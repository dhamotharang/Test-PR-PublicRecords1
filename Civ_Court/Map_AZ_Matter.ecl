IMPORT Civ_Court, civil_court, ut, lib_StringLib, Std;

#option('multiplePersistInstances',FALSE);

//original AbInitio mapping /stub_cleaning/court/work/mp/new_cleaner/az_civil_02_ffreplace2_new_cleaner_no_lookup_sc.mp

fAZ := Civ_Court.Files_In_AZ.Civil_in;

fmtsin := [
		'%m/%d/%Y',
		'%m/%d/%Y'
	];
	fmtout:='%Y%m%d';	

Civil_Court.Layout_In_Matter tAZ(fAZ input) := Transform
self.process_date				:= civil_court.Version_Development;
self.vendor						  := '11';
self.state_origin				:= 'AZ';
self.source_file				:= 'AZ-CRIM-CIVIL-COURT';
self.case_key					  := '11'+trim(input.court_id,all)+trim(input.party_case_search_key,all);
self.court_code					:= input.court_id;
self.court						  := '';
self.case_number				:= input.full_case_num;
self.case_type_code			:= '';
self.case_type					:= input.case_category;
tmpCaseTitle						:= REGEXREPLACE('\\*|!',input.case_title,'');
self.case_title					:= IF(StringLib.StringFind(tmpCaseTitle,' VS',1)>0 AND Civ_Court.IsInvalidName(tmpCaseTitle) = 0,tmpCaseTitle,'');
self.filing_date				:= Std.Date.ConvertDateFormatMultiple(input.filing_date,fmtsin,fmtout);
self.disposition_date		:= Std.Date.ConvertDateFormatMultiple(input.disposition_date,fmtsin,fmtout);
self := [];
end;

pAZ 	:= project(fAZ,tAZ(left));

dAZ 	:= dedup(sort(distribute(pAZ,hash(case_key)),
                  process_date, case_key, court_code, case_number, case_type, 
									case_title, filing_date, disposition_date,local),
									case_key, court_code, case_number, case_type, 
									case_title, filing_date, disposition_date,local,left):
									PERSIST('~thor_data400::in::civil_arizona_matter');


EXPORT Map_AZ_Matter := dAZ(case_number <> '');