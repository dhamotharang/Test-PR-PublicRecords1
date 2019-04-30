IMPORT Civ_Court, civil_court, crim_common, ut, lib_StringLib, Std; 

#option('multiplePersistInstances',FALSE);

fStanislaus := Civ_court.File_In_CA_Stanislaus(Case_Type <> 'CRIMINAL' and Case_Type <> 'JUVENILE' and Case_Type <> 'JUVENILE TRAFFIC' and Case_Type <> 'TRAFFIC');


Civil_Court.Layout_In_Matter tStanislaus(fStanislaus input) := TRANSFORM
self.process_date				:= civil_court.Version_Development;
self.vendor						  := '37';
self.state_origin				:= 'CA';
self.source_file				:= 'CA-Stanislaus_County';
self.case_key					  := '37'+ input.case_number;
self.court						  := input.location;
self.case_number				:= input.case_number;
self.case_type					:= input.case_type;
self.filing_date				:= if(input.file_date <> '', input.file_date[1..4]+input.file_date[6..7]+input.file_date[9..10], '');
self.case_cause_code := input.charge_causes_count;
self.case_cause     := input.norm_primary_cause;
self.disposition_code	:= input.case_status;
self.disposition_description	:= input.norm_outcome;
self := [];
END;

pStanislaus 	:= project(fStanislaus,tStanislaus(left));

dStanislaus 	:= dedup(sort(distribute(pStanislaus,hash(case_key)),
                  process_date,case_key, court, case_number, case_type,
									filing_date,case_cause_code,case_cause,local),case_key, court, case_number, case_type, filing_date,
									case_cause_code,case_cause,local,left):
									PERSIST('~thor_data400::in::civil_CA_Stanislaus_matter');

EXPORT Map_CA_Stanislaus_Matter := dStanislaus;