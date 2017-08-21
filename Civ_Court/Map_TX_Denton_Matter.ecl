IMPORT Civ_Court, civil_court, ut, lib_StringLib;

#option('multiplePersistInstances',FALSE);

//original AbInitio mapping /stub_cleaning/court/work/mp/tx_civil_denton02.mp

fTXDenton	:= Civ_Court.File_In_TX_Denton;

fmtsin := [
		'%m/%d/%Y',
		'%m/%d/%y'
];
fmtout := '%Y%m%d';

Civil_Court.Layout_In_Matter tDenton(fTXDenton input) := Transform
	self.process_date				:= civil_court.Version_Development;
	self.vendor						  := '39';
	self.state_origin				:= 'TX';
	self.source_file				:= 'TX_DENTON_COUNTY';
	StdFileDate							:= ut.ConvertDateMultiple(input.FiledDate,fmtsin,fmtout);
	self.case_key						:= '39'+ut.CleanSpacesAndUpper(input.CaseNumber)+StdFileDate;
	self.parent_case_key		:='';
	self.court_code					:='';
	self.court							:= 'DENTON COUNTY COURT';
	self.case_number				:= ut.CleanSpacesAndUpper(input.CaseNumber);
	self.case_type_code			:= '';
	self.case_type					:= ut.CleanSpacesAndUpper(input.CaseType);
	self.case_title					:= ut.CleanSpacesAndUpper(input.CaseTitle);
	self.filing_date				:= ut.ConvertDateMultiple(input.FiledDate,fmtsin,fmtout);
	self.disposition_description	:=  ut.CleanSpacesAndUpper(input.CaseStatus);
	self.disposition_date		:= ut.ConvertDateMultiple(input.CaseStatusDate,fmtsin,fmtout);
	self	:= [];
end;

pDenton 	:= project(fTXDenton,tDenton(left));

dDenton 	:= dedup(sort(distribute(pDenton,hash(case_key)),
									case_key,court,case_number,filing_date,case_type,case_title,disposition_description,disposition_date, local),
									case_key,court,case_number,filing_date,case_type,case_title,disposition_description,disposition_date, local,left):
									PERSIST('~thor_data400::in::civil_TX_Denton_matter');

EXPORT Map_TX_Denton_Matter := dDenton(case_number <> '');