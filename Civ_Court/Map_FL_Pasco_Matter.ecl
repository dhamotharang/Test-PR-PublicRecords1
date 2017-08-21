import civil_court, crim_common;

//FL Pasco Matter Mapping

fPasco 	:= Civ_Court.File_In_FL_Pasco;

Civil_Court.Layout_In_Matter tFLPascoMtr(fPasco input) := Transform

self.process_date				:= civil_court.Version_Development;
self.vendor						  := '31';
self.state_origin				:= 'FL';
self.source_file				:= 'FL-CIV-PASCO-CO';
self.case_key					  := '31'+trim(input.uniform_case_number);
self.parent_case_key		:='';
self.court_code					:='';
self.court						  :='PASCO COUNTY CIVIL COURT';
self.case_number				:= trim(input.uniform_case_number,left,right);
self.case_type_code			:= '';
self.case_type					:= 'CIVIL TENANT EVICTION';
self.case_title					:= '';
self.case_cause_code		:= '';
self.case_cause					:= '';
self.manner_of_filing_code		:= '';
self.manner_of_filing		:= '';
self.filing_date				:= if(input.date_filed <> '', 
                              input.date_filed[5..8] + input.date_filed[1..2] + input.date_filed[3..4],
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
self.disposition_code			  := '';
self.disposition_description	:= '';
self.disposition_date			  := '';
self.suit_amount				    := '';
self.award_amount				    := '';
end;

pFlPascoMtr 	:= project(fPasco,tFLPascoMtr(left));

dPasco 	:= dedup(sort(distribute(pFlPascoMtr,hash(case_key)),
                  process_date, vendor, state_origin, source_file, 
									case_key, parent_case_key, court_code, court, 
									case_number, case_type_code, case_type, case_title, 
									case_cause_code, case_cause, manner_of_filing_code, 
									manner_of_filing, filing_date, manner_of_judgmt_code, 
									manner_of_judgmt, judgmt_date, ruled_for_against_code, 
									ruled_for_against, judgmt_type_code, judgmt_type, 
									judgmt_disposition_date, judgmt_disposition_code, 
									judgmt_disposition, disposition_code, disposition_description,
									disposition_date, suit_amount, award_amount,local),
									process_date, vendor, state_origin, source_file, 
									case_key, parent_case_key, court_code, court, 
									case_number, case_type_code, case_type, case_title, 
									case_cause_code, case_cause, manner_of_filing_code, 
									manner_of_filing, filing_date, manner_of_judgmt_code, 
									manner_of_judgmt, judgmt_date, ruled_for_against_code, 
									ruled_for_against, judgmt_type_code, judgmt_type, 
									judgmt_disposition_date, judgmt_disposition_code, 
									judgmt_disposition, disposition_code, disposition_description,
									disposition_date, suit_amount, award_amount,local,left):
									PERSIST('~thor_200::in::civil_FL_Pasco_matter');
									

export Map_FL_Pasco_Matter := dPasco;