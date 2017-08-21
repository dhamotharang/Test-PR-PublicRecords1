IMPORT Civ_Court, civil_court, ut, lib_StringLib;

#option('multiplePersistInstances',FALSE);

//original AbInitio mapping /stub_cleaning/court/work/mp/ms_civil_county_harrison02.mp

fMS := Civ_Court.Files_In_MS_Harrison.Civil;

Civil_Court.Layout_In_Case_Activity tMS(fMS input, integer1 C) := Transform
self.process_date				:= civil_court.Version_Development;
self.vendor						  := '97';
self.state_origin				:= 'MS';
self.source_file				:= 'MS-HARRISON_CTY';
self.case_key					  := '97'+ut.fnTrim2Upper(input.case_num);
self.court_code					:= '';
self.court						  := 'HARRISON COUNTY';
self.case_number				:= ut.fnTrim2Upper(input.case_num);
ClnDispDate							:= IF(input.disposition_date = '10000000','',input.disposition_date);
ClnOffenseDate					:= IF(input.offense_date = '10000000','',input.offense_date);
self.event_date					:= CHOOSE(C,ClnDispDate,ClnOffenseDate);
ClnDisposition					:= REGEXREPLACE('PASS TO FILES|UNKNOWN',input.disposition,'',NOCASE);
ClnOffense							:= REGEXREPLACE('PASS TO FILES|UNKNOWN',input.offense,'',NOCASE);
self.event_type_description_1 := CHOOSE(C,ut.fnTrim2Upper(ClnDisposition),ut.fnTrim2Upper(ClnOffense));
self.event_type_description_2	:= '';
self := [];
end;

nMS	:= normalize(fMS,2,tMS(left,counter));

ddMS 	:= dedup(sort(distribute(nMS,hash(case_key)),
									process_date,case_key,court,case_number,event_date,event_type_description_1,local),
									case_key,court,case_number,event_date,event_type_description_1,local,left):
									PERSIST('~thor_data400::in::civil_ms_harrison_activity'); 

EXPORT Map_MS_Harrison_Activity := ddMS(event_type_description_1 <> '');