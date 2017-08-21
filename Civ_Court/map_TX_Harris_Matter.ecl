import civil_court, crim_common;

fHarris 	:= Civ_Court.File_In_TX_Harris(CS != 'CS');

Civil_Court.Layout_In_Matter tTXCiv(fHarris input) := Transform

self.process_date				:= civil_court.Version_Development;
self.vendor						:='90';
self.state_origin				:='TX';
self.source_file				:='TX-HarrisCntyCivil';
self.case_key					:='90'+ input.CASNUM;
self.parent_case_key			:='';
self.court_code					:='';//input.CRT - sent request for code defs to receiving
self.court						:='Harris County';
self.case_number				:= input.CASNUM;
self.case_type_code				:= '';
self.case_type					:= input.CASETYPE;
self.case_title					:= '';
self.case_cause_code			:= '';
self.case_cause					:= '';
self.manner_of_filing_code		:= '';
self.manner_of_filing			:= '';
self.filing_date				:= map(input.FILDT[1..2] >= '19' and input.FILDT < self.process_date =>
									   input.FILDT, '');
self.manner_of_judgmt_code		:= '';
self.manner_of_judgmt			:= '';
self.judgmt_date				:= map(input.JUDDT[1..2] >= '19' and input.JUDDT < self.process_date =>
									   input.JUDDT, '');
self.ruled_for_against_code		:= '';
self.ruled_for_against			:= '';
self.judgmt_type_code			:= '';
self.judgmt_type				:= '';
self.judgmt_disposition_date	:= '';
self.judgmt_disposition_code	:= '';
self.judgmt_disposition			:= '';
self.disposition_code			:= '';
self.disposition_description	:= '';
self.disposition_date			:= '';
self.suit_amount				:= '';
self.award_amount				:= '';
end;

pHarris 	:= project(fHarris,tTXCiv(left));

ddHarris 	:= dedup(sort(distribute(pHarris,hash(case_key)),
									case_key,court,case_type,filing_date,judgmt_date,local),
									case_key,court,case_type,local,left):
									PERSIST('~thor_200::in::civil_tx_Harris_matter');

export Map_TX_Harris_Matter := ddHarris;