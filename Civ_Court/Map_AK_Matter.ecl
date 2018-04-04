IMPORT Civ_Court, civil_court, crim_common, ut, Std;

#option('multiplePersistInstances',FALSE);

//original AbInitio mapping /stub_cleaning/court/work/mp/ak_civil_02_ffreplace.mp

fAlaska 	:= Civ_Court.File_In_AK.Input(case_type = 'Civil');

fmtsin := [
		'%m/%d/%Y',
		'%m/%d/%Y'
	];
	fmtout:='%Y%m%d';	

Civil_Court.Layout_In_Matter tAlaskaMatter(fAlaska input) := Transform
self.process_date				:= civil_court.Version_Development;
self.vendor						  := '01';
self.state_origin				:= 'AK';
self.source_file				:= 'AK-CRIM-CIVIL-COURT';
self.case_key					  := '01'+ut.CleanSpacesAndUpper(input.case_num);
self.parent_case_key		:= '';
self.court_code					:= ut.CleanSpacesAndUpper(input.court_code);
self.court						  := 'ALASKA CIVIL COURT';
self.case_number				:= ut.CleanSpacesAndUpper(input.case_num);
self.case_type_code			:= '';
self.case_type					:= ut.CleanSpacesAndUpper(input.case_type);
self.case_title					:= '';
self.case_cause_code		:= ut.CleanSpacesAndUpper(input.criminal_charge_statute);
self.case_cause					:= ut.CleanSpacesAndUpper(input.criminal_charge_offense);
self.manner_of_filing_code		:= '';
self.manner_of_filing		:= '';
self.filing_date				:= IF(input.date_filed <> '', 
                              Std.date.ConvertDateFormatMultiple(input.date_filed,fmtsin,fmtout),
															'');
self.manner_of_judgmt_code		:= '';
self.manner_of_judgmt		:= '';
self.judgmt_date				:= '';
self.ruled_for_against_code	:= '',
self.ruled_for_against			:= '';
self.judgmt_type_code			  := '';
self.judgmt_type				    := '';
self.judgmt_disposition_date	:= '';
self.judgmt_disposition_code	:= '';
self.judgmt_disposition			:= '';
self.disposition_code			  := ut.CleanSpacesAndUpper(input.civil_dispo);
self.disposition_description	:= '';
self.disposition_date			  := IF(input.civil_case_closed_date <> '', 
                              input.civil_case_closed_date[7..10] + input.civil_case_closed_date[1..2] + input.civil_case_closed_date[4..5],
															'');
self.suit_amount				    := REGEXREPLACE('\\.[0-9]+',input.amount,'');
self.award_amount				    := REGEXREPLACE('\\.[0-9]+',input.award_amount,'');
end;

pAlaskaMtr 	:= sort(project(fAlaska,tAlaskaMatter(left)), case_key, disposition_code, local);

//Lookup disposition
lkp_case	:= sort(Civ_Court.File_In_AK.CaseDispositionCodesLkp, case_disp_code, local);

Civil_Court.Layout_In_Matter lkpDisp(pAlaskaMtr l, lkp_case r) := TRANSFORM
self.disposition_description	:= ut.CleanSpacesAndUpper(IF(l.disposition_code <> '', regexreplace('^\\*',r.case_disp_desc,''), ''));
self := l;
end;

lAlaskaDisp	:= join(pAlaskaMtr, lkp_case,
										left.disposition_code = right.case_disp_code,
										lkpDisp(left,right),left outer,lookup,local);

dAlaska 	:= dedup(sort(distribute(lAlaskaDisp,hash(case_key)),
                  process_date, case_key, court_code, court, 
									case_number, case_type_code, case_type, case_cause_code,
									case_cause, filing_date, disposition_code, disposition_description,
									disposition_date, suit_amount, award_amount,local), 
									case_key, court_code, court, case_number, case_type_code, 
									case_type, case_cause_code, case_cause, filing_date,
									disposition_code, disposition_description,
									disposition_date, suit_amount, award_amount,local,left):
									PERSIST('~thor_data400::in::civil_alaska_matter');
									

export Map_AK_Matter := dAlaska(case_number <> '');