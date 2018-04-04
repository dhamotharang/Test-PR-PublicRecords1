IMPORT Civ_Court, civil_court, crim_common, ut, Std;

#option('multiplePersistInstances',FALSE);

//original AbInitio mapping /stub_cleaning/court/work/mp/ca_civil_county_kern_02_jt.mp

fKern 	:= Civ_Court.Files_In_CA_Kern.civil;

fmtsin := [
		'%m/%d/%Y',
		'%m/%d/%Y'
	];
	fmtout:='%Y%m%d';	

Civil_Court.Layout_In_Matter tKern(fKern input) := Transform
self.process_date				:= civil_court.Version_Development;
self.vendor						  := '49';
self.state_origin				:= 'CA';
self.source_file				:= 'CA-CIV-KERN-CO';
self.case_key					  := '49'+trim(input.FileNo,all)+ut.CleanSpacesAndUpper(input.JudicialCode);
self.parent_case_key		:= '';
self.court_code					:= ut.CleanSpacesAndUpper(input.IndexType);
self.court						  := IF(self.court_code = 'CI','KERN COUNTY-CIVIL COURT INDEX', 'KERN COUNTY-CIVIL COURT');
self.case_number				:= trim(input.FileNo,all);
self.case_type_code			:= ut.CleanSpacesAndUpper(input.jc1);
self.case_type					:= '';
self.case_cause_code		:= ut.CleanSpacesAndUpper(input.jc2);
self.case_cause					:= '';
self.filing_date				:= Std.Date.ConvertDateFormatMultiple(input.filedate,fmtsin,fmtout);
self := [];
END;

pKern 	:= project(fKern,tKern(left));
srtKern	:= sort(distribute(pKern,hash(case_type_code)),case_number,case_type_code);

//Lookup Files
lkp_case	:= sort(distribute(Civ_Court.Files_In_CA_Kern.case_category,hash(code)),code,local);
lkp_cause	:= sort(distribute(Civ_Court.Files_In_CA_Kern.case_type,hash(code)),code,local);	

Civil_Court.Layout_In_Matter lkpCase(pKern l, lkp_case r) := TRANSFORM
self.case_type	:= ut.CleanSpacesAndUpper(IF(l.case_type_code <> '',r.code_description, ''));
self := l;
end;

lKernCase	:= join(pKern, lkp_case,
										trim(left.case_type_code,all) = trim(right.code,all),
										lkpCase(left,right),left outer,lookup);
										
//Re distribute for case_cause lookup
re_destrib := sort(distribute(lKernCase,hash(case_cause_code)),case_number,case_cause_code,local);

Civil_Court.Layout_In_Matter lkpCause(re_destrib l, lkp_cause r) := TRANSFORM
self.case_cause	:= ut.CleanSpacesAndUpper(r.code_description);
self := l;
end;

lKernCause_old	:= join(re_destrib, lkp_cause,
										trim(left.case_cause_code,all) = trim(right.code,all),
										lkpCause(left,right),left outer,lookup);

//New Kern Civil Layout/Format
fKern_new := Civ_Court.Files_In_CA_Kern.civil_new;

Civil_Court.Layout_In_Matter tKern_new(fKern_new input) := Transform
self.process_date				:= civil_court.Version_Development;
self.vendor						  := '49';
self.state_origin				:= 'CA';
self.source_file				:= 'CA-CIV-KERN-CO';
self.case_key					  := '49'+trim(input.CaseNumber);
self.parent_case_key		:= '';
self.court						  := 'KERN COUNTY-CIVIL COURT';
self.case_number				:= input.CaseNumber;
a := stringlib.StringFind(input.FileDate, ' 0:00', 1);
self.filing_date				:= if(stringlib.StringFind(input.FileDate, ' 0:00', 1) = 1,Std.Date.ConvertDateFormatMultiple(input.FileDate[1..a],fmtsin,fmtout),
                              Std.Date.ConvertDateFormatMultiple(input.FileDate,fmtsin,fmtout));
self := [];
END;
										
lKernParty_new 	:= project(fKern_new,tKern_new(left));

lKernCause := lKernCause_old + lKernParty_new;

dKern 	:= dedup(sort(distribute(lKernCause,hash(case_key)),
                  process_date,case_key, court, case_number, case_type,
									case_cause, filing_date,local),
									case_key, court, case_number, case_type, 
									case_cause, filing_date,local,left):
									PERSIST('~thor_data400::in::civil_CA_Kern_matter');
										
EXPORT Map_CA_Kern_Matter := dKern(case_number <> '');