import civil_court, crim_common;

fCollin 	:= Civ_Court.Map_TX_Collin_Combined;

Civil_Court.Layout_In_Matter tTXCiv(fCollin input) := Transform

self.process_date				:= civil_court.Version_Development;
self.vendor						:= '89';
self.state_origin				:= 'TX';
self.source_file				:= '(CV)TX-CollinCntyCivil';
self.case_key					:= '89'+trim(input.court,all)+trim(input.cause,all)+trim(input.year,all);
self.parent_case_key			:= '';
self.court_code					:= '';
self.court						:= 'Collin County';
self.case_number				:= input.case_num;
self.case_type_code				:= '';
self.case_type					:= '';
self.case_title					:= '';
self.case_cause_code			:= '';
self.case_cause					:= '';
self.manner_of_filing_code		:= '';
self.manner_of_filing			:= '';
self.filing_date				:= input.file_date;
self.manner_of_judgmt_code		:= '';
self.manner_of_judgmt			:= '';
self.judgmt_date				:= '';
self.ruled_for_against_code		:= '';
self.ruled_for_against			:= '';
self.judgmt_type_code			:= '';
self.judgmt_type				:= '';
self.judgmt_disposition_date	:= '';
self.judgmt_disposition_code	:= '';
self.judgmt_disposition			:= '';
self.disposition_code			:= input.disp_code;
self.disposition_description	:= input.disp_desc;
self.disposition_date			:= '';
self.suit_amount				:= '';
self.award_amount				:= '';
end;

pCollin 	:= project(fCollin,tTXCiv(left));

ddCollin 	:= dedup(sort(distribute(pCollin,hash(case_number)),
									case_number,case_key,parent_case_key,court_code,court,case_type_code,case_type,case_title,case_cause_code,case_cause,
									manner_of_filing_code,manner_of_filing,filing_date,manner_of_judgmt_code,manner_of_judgmt,judgmt_date,ruled_for_against_code,
									ruled_for_against,judgmt_type_code,judgmt_type,judgmt_disposition_date,judgmt_disposition_code,judgmt_disposition,disposition_code,			
									disposition_date,suit_amount,award_amount,local),
									case_number,case_key,parent_case_key,court_code,court,case_type_code,case_type,case_title,case_cause_code,case_cause,
									manner_of_filing_code,manner_of_filing,filing_date,manner_of_judgmt_code,manner_of_judgmt,judgmt_date,ruled_for_against_code,
									ruled_for_against,judgmt_type_code,judgmt_type,judgmt_disposition_date,judgmt_disposition_code,judgmt_disposition,disposition_code,			
									disposition_date,suit_amount,award_amount,local,left):
									PERSIST('~thor_200::in::civil_tx_collin_co_ffreplace_20071010_matter');

export Map_TX_Collin_Matter := ddCollin;