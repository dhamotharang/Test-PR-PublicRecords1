import civil_court, crim_common, ut;

//CA Santa Barbara Matter Mapping

fSantaBarbara := Civ_court.File_In_CA_SantaBarbara(party_type <> 'Extended Connection');

Civil_Court.Layout_In_Matter tSantaBarbara(fSantaBarbara input) := Transform

self.process_date				:= civil_court.Version_Development;
self.vendor						  := '24';
self.state_origin				:= 'CA';
self.source_file				:= 'CA-CIV-SA-BARBARA-CO';
self.case_key					  := '24'+ input.case_num;
self.court						  := 'SANTA BARBARA COUNTY';
self.case_number				:= input.case_num;
self.case_type_code			:= '';
self.case_type					:= input.case_type;
self.case_title					:= input.case_title;
self.case_cause_code		:= '';
self.case_cause					:= '';
self.filing_date				:= If(trim(input.case_filing_date,left,right) <> '',ut.ConvertDate(input.case_status_date),'');
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
self := [];
end;

pCASantaBarbara 	:= project(fSantaBarbara,tSantaBarbara(left));

dCASantaBarbara 	:= dedup(sort(distribute(pCASantaBarbara,hash(case_key)),
                  process_date, vendor, state_origin, source_file, 
									case_key, court, case_number, case_type, case_title, 
									filing_date,local), process_date, vendor, state_origin,
									source_file, case_key, court, case_number, case_type, 
									case_title, filing_date,local,left):
									PERSIST('~thor_data400::in::civil_CA_Santa_Barbara_matter');
									

export Map_CA_Santa_Barbara_Matter := dCASantaBarbara;