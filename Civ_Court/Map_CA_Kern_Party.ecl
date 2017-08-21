IMPORT Civ_Court, civil_court, crim_common, ut, Address; 

#option('multiplePersistInstances',FALSE);

//original AbInitio mapping /stub_cleaning/court/work/mp/ca_civil_county_kern_02_jt.mp

fKern 	:= Civ_Court.Files_In_CA_Kern.civil;

Civil_Court.Layout_In_Party tKern(fKern input, integer1 C) := Transform
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
self.entity_1						:= ut.CleanSpacesAndUpper(CHOOSE(C,input.name1,input.name2));
self.entity_nm_format_1	:= 'L';
self.entity_type_code_1_orig := ut.CleanSpacesAndUpper(CHOOSE(C,input.Status1,input.Status2));
self.entity_type_description_1_orig := '';
self.entity_type_code_1_master := '';
self := [];
END;

pKern	:= normalize(fKern,2,tKern(left,counter));
ded_kern := dedup(sort(pKern(entity_1 <> ''),case_number,entity_1),case_number,entity_1);
srtKern	:= sort(distribute(ded_kern,hash(case_type_code)),case_number,entity_1,case_type_code);

//Lookup files
lkp_case	:= sort(distribute(Civ_Court.Files_In_CA_Kern.case_category,hash(code)), code,local);
lkp_party_type	:= sort(distribute(Civ_Court.Files_In_CA_Kern.party_type,hash(type_code)), type_code,local);

Civil_Court.Layout_In_Party lkpCase(pKern l, lkp_case r) := TRANSFORM
self.case_type	:= ut.CleanSpacesAndUpper(r.code_description);
self := l;
end;

lKernCase	:= join(pKern, lkp_case,
										trim(left.case_type_code,all) = trim(right.code,all),
										lkpCase(left,right),left outer, lookup);
//Redestribute for party code lookup
re_distrib	:= sort(distribute(lKernCase,hash(entity_type_code_1_orig)),case_number,entity_1,entity_type_code_1_orig,local);

Civil_Court.Layout_In_Party lkpParty(re_distrib l, lkp_party_type r) := TRANSFORM
self.entity_type_description_1_orig	:= ut.CleanSpacesAndUpper(r.type_description);
self.entity_type_code_1_master := trim(r.entity_type_master,all);
self := l;
end;

lKernParty_old	:= join(re_distrib, lkp_party_type,
										trim(left.entity_type_code_1_orig,all) = trim(right.type_code,all),
										lkpParty(left,right),left outer,lookup);						

//New Kern Civil Layout/Format
fKern_new := Civ_Court.Files_In_CA_Kern.civil_new;

Civil_Court.Layout_In_Party tKern_new(fKern_new input) := Transform
self.process_date				:= civil_court.Version_Development;
self.vendor						  := '49';
self.state_origin				:= 'CA';
self.source_file				:= 'CA-CIV-KERN-CO';
self.case_key					  := '49'+trim(input.CaseNumber);
self.parent_case_key		:= '';
self.court_code					:= '';
self.court						  := 'KERN COUNTY-CIVIL COURT';
self.case_number				:= input.CaseNumber;
self.case_type					:= input.CaseType;
self.entity_1						:= input.PartyName;
self.entity_nm_format_1	:= 'F';
self.entity_type_code_1_orig := '';
self.entity_type_description_1_orig := stringlib.StringToUpperCase(input.PartyType);
self.entity_type_code_1_master := map(self.entity_type_code_1_orig = 'Arbitrator' => '60',
																			self.entity_type_code_1_orig = 'Assignee of Record' => '70', 
																			self.entity_type_code_1_orig = 'Beneficiary' => '70', 
																			self.entity_type_code_1_orig = 'Claimant' => '10', 
																			self.entity_type_code_1_orig = 'Conservator' => '60', 
																			self.entity_type_code_1_orig = 'Cross Complainant' => '70', 
																			self.entity_type_code_1_orig = 'Cross Defendant' => '70', 
																			self.entity_type_code_1_orig = 'Deceased' => '70', 
																			self.entity_type_code_1_orig = 'Defendant' => '30', 
																			self.entity_type_code_1_orig = 'Employee' => '70', 
																			self.entity_type_code_1_orig = 'Guardian' => '70', 
																			self.entity_type_code_1_orig = 'Guardian Ad Litem' => '70', 
																			self.entity_type_code_1_orig = 'Incompetent-PL' => '70', 
																			self.entity_type_code_1_orig = 'Intervenor-PL' => '70', 
																			self.entity_type_code_1_orig = 'Lien Claimant' => '70', 
																			self.entity_type_code_1_orig = 'Objector' => '70', 
																			self.entity_type_code_1_orig = 'Other Parent' => '70', 
																			self.entity_type_code_1_orig = 'Petitioner' => '10', 
																			self.entity_type_code_1_orig = 'Petitioner 1' => '10', 
																			self.entity_type_code_1_orig = 'Petitioner 2' => '10', 
																			self.entity_type_code_1_orig = 'Plaintiff' => '10', 
																			self.entity_type_code_1_orig = 'Real Party Interest' => '10', 
																			self.entity_type_code_1_orig = 'Receiver' => '60', 
																		  self.entity_type_code_1_orig = 'Respondent' => '30',
																			self.entity_type_code_1_orig = 'Settlor' => '70',  '70');

self := [];
END;

lKernParty_new 	:= project(fKern_new,tKern_new(left));

lKernParty := lKernParty_old + lKernParty_new;

Civ_court.Civ_Court_Cleaner(lKernParty,cleanKern);

ddKern 	:= dedup(sort(distribute(cleanKern(entity_1 <> ''),hash(case_key)),
                  process_date,case_key, court, case_number, case_type_code, case_type, entity_1, entity_nm_format_1, 
									entity_type_code_1_orig, entity_type_description_1_orig, local),
									case_key, court, case_number, case_type, entity_1, entity_nm_format_1, 
									entity_type_code_1_orig, entity_type_description_1_orig, local,left):
									PERSIST('~thor_data400::in::civil_CA_Kern_party');

EXPORT Map_CA_Kern_Party := ddKern;