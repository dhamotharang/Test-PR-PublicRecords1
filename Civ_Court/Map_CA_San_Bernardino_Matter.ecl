import civil_court, ut, crim_common;

//FL Pasco Matter Mapping

fCASanBernardino 	:= Civ_Court.File_In_CA_San_Bernardino;

Civil_Court.Layout_In_Matter tCASanBernardinoMatter(fCASanBernardino input) := Transform

self.process_date				:= civil_court.Version_Development;
self.vendor						  := '19';
self.state_origin				:= 'CA';
self.source_file				:= 'CA-S-BDNO-CO-CIV-CRT';
self.case_key					  := '19'+trim(input.CaseNumber);
self.parent_case_key		:='';
self.court_code					:='';
self.court						  :='';
self.case_number				:= trim(input.CaseType) + trim(input.CaseNumber);
self.case_type_code     := trim(input.CaseType);
self.case_type          := map(trim(input.CaseType) = 'ACI' => 'CIVIL APPEAL',
                               trim(input.CaseType) = 'ACR' => 'CRIMINAL APPEAL',
															 trim(input.CaseType) = 'ADO' => 'ADOPTIONS',
															 trim(input.CaseType) = 'CIF' => 'CIVIL FAMILY LAW',
															 trim(input.CaseType) = 'CIM' => 'CIVIL MENTAL HEALTH',
															 trim(input.CaseType) = 'CIP' => 'CIVIL PROBATE',
															 trim(input.CaseType) = 'CIV' => 'CIVIL',
															 trim(input.CaseType) = 'CON' => 'CONSERVATORSHIP',
															 trim(input.CaseType) = 'CS'  => 'CHILD SUPPORT (GOVERNMENTAL)',
															 trim(input.CaseType) = 'FAM' => 'FAMILY LAW',
															 trim(input.CaseType) = 'FEL' => 'FELONY',
															 trim(input.CaseType) = 'GAR' => 'GUARDIANSHIP',
															 trim(input.CaseType) = 'JCP' => 'JUDICIAL COUNCIL COORDINATED',
															 trim(input.CaseType) = 'MEN' => 'MENTAL HEALTH',
															 trim(input.CaseType) = 'ODA' => 'CHILD SUPPORT (RANCHO)',
															 trim(input.CaseType) = 'OFL' => 'FAMILY LAW (ONTARIO)',
															 trim(input.CaseType) = 'PA'  => 'PARKING APPEAL',
															 trim(input.CaseType) = 'PRO' => 'PROBATE',
															 trim(input.CaseType) = 'RFL' => 'FAMILY LAW',
															 trim(input.CaseType) = 'SFL' => 'SAN BERNARDINO FAMILY LAW',
															 trim(input.CaseType) = 'SLC' => 'SAN BERNARDINO LMT CONSERVATORSHIP',
															 trim(input.CaseType) = 'SMC' => 'SMALL CLAIMS',
															 trim(input.CaseType) = 'SPR' => 'SAN BERNARDINO PROBATE',
															 trim(input.CaseType) = 'UD'  => 'UNLAWFUL DETAINER',
															 trim(input.CaseType) = 'VFL' => 'VICTORVILLE FAMILY LAW',
															 trim(input.CaseType) = 'VPR' => 'VICTORVILLE PROBATE',
															 trim(input.CaseType) = 'WHC' => 'WRIT OF HAEBEUS CORPUS','');
self.filing_date				:= '20' + input.FilingDate[7..8] + input.FilingDate[1..2] + input.FilingDate[4..5];
self := [];
end;

pCASanBernardinoMatter 	:= project(fCASanBernardino,tCASanBernardinoMatter(left));

dSanBernardino 	:= dedup(sort(distribute(pCASanBernardinoMatter,hash(case_key)),
                  process_date, vendor, state_origin, source_file, 
									case_key, case_number, case_type_code, case_type,
									filing_date,local),case_key, case_number, case_type_code, case_type,
									filing_date,left, local):
									PERSIST('~thor_200::in::civil_CA_San Bernardino_matter');
									

export Map_CA_San_Bernardino_Matter := dSanBernardino;