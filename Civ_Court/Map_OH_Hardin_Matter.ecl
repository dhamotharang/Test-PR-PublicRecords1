import civil_court, crim_common;

fHardin 	:= civ_court.File_In_OH_Hardin(party_name <> 'Party Name');

Civil_Court.Layout_In_Matter tOHCiv(fHardin input) := Transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.process_date				:= civil_court.Version_Development;
self.vendor						:= '92';
self.state_origin				:= 'OH';
self.source_file				:= '(CV)OH-HardinCntyCivil';
self.case_key					:= '92'+hash(trim(input.case_number,all));
self.parent_case_key			:= '';
self.court_code					:= '';
self.court						:= 'Hardin County';
self.case_number				:= input.case_number;
self.case_type_code				:= '';
self.case_type					:= '';
self.case_title					:= '';
self.case_cause_code			:= '';
self.case_cause					:= '';
self.manner_of_filing_code		:= '';
self.manner_of_filing			:= '';
self.filing_date				:= if(fSlashedMDYtoCYMD(input.filed_date)<>'00000000',
									fSlashedMDYtoCYMD(input.filed_date),
									'');
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
self.disposition_code			:= '';
self.disposition_description	:= '';
self.disposition_date			:= if(fSlashedMDYtoCYMD(input.dispo_date)<>'00000000',
									fSlashedMDYtoCYMD(input.dispo_date),
									'');
self.suit_amount				:= '';
self.award_amount				:= '';
end;

pHardin 	:= project(fHardin,tOHCiv(left));

ddHardin 	:= dedup(sort(distribute(pHardin,hash(case_number)),
									case_number,case_key,parent_case_key,court_code,court,case_type_code,case_type,case_title,case_cause_code,case_cause,
									manner_of_filing_code,manner_of_filing,filing_date,manner_of_judgmt_code,manner_of_judgmt,judgmt_date,ruled_for_against_code,
									ruled_for_against,judgmt_type_code,judgmt_type,judgmt_disposition_date,judgmt_disposition_code,judgmt_disposition,disposition_code,			
									-disposition_date,suit_amount,award_amount,local),
									case_number,case_key,parent_case_key,court_code,court,case_type_code,case_type,case_title,case_cause_code,case_cause,
									manner_of_filing_code,manner_of_filing,filing_date,manner_of_judgmt_code,manner_of_judgmt,judgmt_date,ruled_for_against_code,
									ruled_for_against,judgmt_type_code,judgmt_type,judgmt_disposition_date,judgmt_disposition_code,judgmt_disposition,disposition_code,			
									suit_amount,award_amount,local,left):
									PERSIST('~thor_200::in::civil_OH_Hardin_20061219_20080211_matter');

export Map_OH_Hardin_Matter := ddHardin;