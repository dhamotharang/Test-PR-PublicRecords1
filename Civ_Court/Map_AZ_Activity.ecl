IMPORT Civ_Court, civil_court, ut, lib_StringLib;

#option('multiplePersistInstances',FALSE);

//original AbInitio mapping /stub_cleaning/court/work/mp/new_cleaner/az_civil_02_ffreplace2_new_cleaner_no_lookup_sc.mp

fAZ_Civil := Civ_Court.Files_In_AZ.Civil_in;
fAZ_Event	:= Civ_Court.Files_In_AZ.CS_Event;

fmtsin := '%m/%d/%Y';
fmtout := '%Y%m%d';

Civil_Court.Layout_In_Case_Activity tAZ(fAZ_Event L, fAZ_Civil R) := Transform
self.process_date				:= civil_court.Version_Development;
self.vendor						  := '11';
self.state_origin				:= 'AZ';
self.source_file				:= 'AZ-CRIM-CIVIL-COURT';
self.case_key					  := '11'+trim(R.court_id,all)+trim(R.party_case_search_key,all);
self.court_code					:= R.court_id;
self.court						  := '';
self.case_number				:= R.full_case_num;
self.event_date					:= ut.ConvertDate(L.evnt_date);
self.event_type_code		:= '';
self.event_type_description_1	:= ut.CleanSpacesAndUpper(REGEXREPLACE('\\*|!',L.evnt_description,''));
self.event_type_description_2	:= '';
self := [];
end;

jEventCivil	:= join(sort(distribute(fAZ_Event,hash(case_id,prty_id)),case_id, prty_id,local),
										sort(distribute(fAZ_Civil,hash(case_id,prty_id)),case_id, prty_id,local),
										trim(left.case_id,left,right) = trim(right.case_id,left,right) and
										trim(left.prty_id,left,right) = trim(right.prty_id,left,right),
										tAZ(left,right),local);

dAZ 	:= dedup(sort(distribute(jEventCivil,hash(case_key)),
									process_date,case_key,court_code,case_number,event_date,event_type_description_1,local),
									case_key,court_code,case_number,event_date,event_type_description_1,local,left):
									PERSIST('~thor_data400::in::civil_arizona_activity');

EXPORT Map_AZ_Activity := dAZ(event_date <> '');