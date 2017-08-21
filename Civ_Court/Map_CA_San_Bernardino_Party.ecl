IMPORT Civ_Court, civil_court, crim_common, ut, Address; 

#option('multiplePersistInstances',FALSE);

fSanBernardino := Civ_Court.File_In_CA_San_Bernardino;

Civil_Court.Layout_In_Party tSanBernardinoP(fSanBernardino input) := Transform
self.process_date				:= civil_court.Version_Development;
self.vendor						  := '19';
self.state_origin				:= 'CA';
self.source_file				:= 'CA-S-BDNO-CO-CIV-CRT';
self.case_key					  := '19'+trim(input.CaseNumber);
self.parent_case_key		:= '';
self.court_code					:= '';
self.court						  := '';
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
self.entity_1						:= trim(input.Plaintiff);
self.entity_nm_format_1	:= 'L';
self.entity_type_code_1_orig := '';
self.entity_type_description_1_orig := 'PLAINTIFF';
self.entity_type_code_1_master := '10';
self := [];
END;

SanBernardinoPartyP 	:= project(fSanBernardino,tSanBernardinoP(left));

Civil_Court.Layout_In_Party tSanBernardinoD(fSanBernardino input) := Transform
self.process_date				:= civil_court.Version_Development;
self.vendor						  := '19';
self.state_origin				:= 'CA';
self.source_file				:= 'CA-S-BDNO-CO-CIV-CRT';
self.case_key					  := '19'+trim(input.CaseNumber);
self.parent_case_key		:= '';
self.court_code					:= '';
self.court						  := '';
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
self.entity_1						:= trim(input.Defendant);
self.entity_nm_format_1	:= 'L';
self.entity_type_code_1_orig := '';
self.entity_type_description_1_orig := 'DEFENDANT';
self.entity_type_code_1_master := '30';
self := [];
END;

SanBernardinoPartyD 	:= project(fSanBernardino,tSanBernardinoD(left));

SanBernardinoAll := SanBernardinoPartyP + SanBernardinoPartyD;

Civ_court.Civ_Court_Cleaner(SanBernardinoAll,cleanSanBernardino);

ddSanBernardino 	:= dedup(sort(distribute(cleanSanBernardino(entity_1 <> ''),hash(case_key)),
                  process_date,case_key, court, case_number, case_type_code, case_type, entity_1, entity_nm_format_1, 
									entity_type_code_1_orig, entity_type_description_1_orig, local),
									case_key, court, case_number, case_type, entity_1, entity_nm_format_1, 
									entity_type_code_1_orig, entity_type_description_1_orig, local,left):
									PERSIST('~thor_data400::in::civil_CA_San_Bernardino_party');

EXPORT Map_CA_San_Bernardino_Party := ddSanBernardino;