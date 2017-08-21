import civil_court, crim_common;

fCollin 	:= Civ_Court.Map_TX_Collin_Combined;

Civil_Court.Layout_In_Case_Activity tTXCiv(fCollin input) := Transform

self.process_date 				:= Crim_Common.Version_In_Arrest_Offenses;
self.vendor						:='89';
self.state_origin				:='TX';
self.source_file				:='(CV)TX-CollinCntyCivil';
self.case_key					:='89'+trim(input.court,all)+trim(input.cause,all)+trim(input.year,all);
self.court_code					:='';
self.court						:='Collin County';
self.case_number				:=input.case_num;
self.event_date					:=if(input.court_date<>'00000000',
									input.court_date,
									'');
self.event_type_code			:='';
self.event_type_description_1	:=regexreplace('^[\\.]+$',if(regexfind('[0-9]',regexreplace('\\"',trim(input.court_txt,left,right),''),0)='',
									regexreplace('\\"',trim(input.court_txt,left,right),
									''),''), '');
self.event_type_description_2	:='';
end;

pCollin 	:= project(fCollin,tTXCiv(left));

ddCollin 	:= dedup(sort(distribute(pCollin,hash(case_number)),
									case_number,case_key,court_code,court,case_number,event_date,event_type_code,event_type_description_1,event_type_description_2,local),
									case_number,case_key,court_code,court,case_number,event_date,event_type_code,event_type_description_1,event_type_description_2,local,left):
									PERSIST('~thor_200::in::civil_tx_collin_co_ffreplace_20071010_activity');

export Map_TX_Collin_Case_Activity := ddCollin;