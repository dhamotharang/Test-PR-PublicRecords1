IMPORT Civ_Court, civil_court, ut, lib_StringLib, Std;

#option('multiplePersistInstances',FALSE);

//original AbInitio mapping /stub_cleaning/court/work/mp/tx_civil_gregg02_upd.mp

fTXGregg	:= Civ_Court.File_In_TX_Gregg(trim(CaseNumber,left,right) <> 'test');

fmtsin := [
		'%m/%d/%Y',
		'%m/%d/%y'
];
fmtout := '%Y%m%d';

Civil_Court.Layout_In_Matter tTXGregg(fTXGregg input) := Transform
	self.process_date				:= civil_court.Version_Development;
	self.vendor						  := '41';
	self.state_origin				:= 'TX';
	self.source_file				:= 'TX Gregg County Ct';
	self.case_key						:= '41'+ut.CleanSpacesAndUpper(input.CaseNumber);
	self.parent_case_key		:='';
	self.court_code					:='';
	self.court							:= 'GREGG COUNTY COURT';
	self.case_number				:= ut.CleanSpacesAndUpper(input.CaseNumber);
	self.case_type_code			:= '';
	self.case_type					:= ut.CleanSpacesAndUpper(input.CaseType);
	self.case_title					:= ut.CleanSpacesAndUpper(input.CaseTitle);
	self.filing_date				:= Std.date.ConvertDateFormatMultiple(input.FileDate,fmtsin,fmtout);
	self.disposition_description	:=  ut.CleanSpacesAndUpper(input.ActiveCaseStatus);
	self.disposition_date		:= Std.date.ConvertDateFormatMultiple(input.CaseStatusDate,fmtsin,fmtout);
	self	:= [];
end;

pGregg 	:= project(fTXGregg,tTXGregg(left));

dGregg 	:= dedup(sort(distribute(pGregg,hash(case_key)),
									case_key,court,case_number,filing_date,case_type,case_title,disposition_description,disposition_date,local),
									case_key,court,case_number,filing_date,case_type,case_title,disposition_description,disposition_date,local,left):
									PERSIST('~thor_data400::in::civil_TX_Gregg_matter');

EXPORT map_TX_Gregg_Matter := dGregg(case_number <> '');