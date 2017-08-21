IMPORT Civ_Court, civil_court, ut, lib_StringLib;

#option('multiplePersistInstances',FALSE);

//original AbInitio mapping /stub_cleaning/court/work/mp/ny_civil_downstate_02_update.mp

fNY	:= sort(Civ_Court.Files_In_NY_Downstate.Case_in,idxno,seqno,county_code,court_type);
court	:= sort(Civ_Court.Files_In_NY_Downstate.Cnty_Codes_lkp,code);

Civil_Court.Layout_In_Matter tNY(fNY L, court R) := Transform
self.process_date				:= civil_court.Version_Development;
self.vendor						  := '25';
self.state_origin				:= 'NY';
self.source_file				:= 'NY-STATEWIDE-CIV-CRT';
ClnCase									:= trim(L.county_code,all)+trim(L.idxno,all)+trim(L.seqno,all);
self.case_key					  := '25'+ ClnCase;
self.parent_case_key		:= trim(L.county_code,all)+trim(L.idxno,all);
self.court_code					:= trim(L.county_code,all);
self.court						  := map(trim(L.court_type) = '0' => ut.CleanSpacesAndUpper(R.description)+' COUNTY, NY COUNTY COURT',
																trim(L.court_type) = '1' => ut.CleanSpacesAndUpper(R.description)+' COUNTY, NY SUPERIOR COURT',
																ut.CleanSpacesAndUpper(R.description)+' COUNTY, NY COURT');
self.case_number				:= ClnCase;
self.case_title					:= IF(L.name_pltf <> '',ut.CleanSpacesAndUpper(L.name_pltf)+' VS '+ ut.CleanSpacesAndUpper(L.name_dfdt),'');
self.disposition_code 	:= trim(L.case_status,all);
self.disposition_description := map(self.disposition_code = '01' => 'ACTIVE',
																		self.disposition_code = '02' => 'CONSOLIDATED',
																		self.disposition_code = '03' => 'RESTORED',
																		self.disposition_code = '04' => 'STAYED',
																		self.disposition_code = '05' => 'DISPOSED',
																		self.disposition_code = '06' => 'STAYED, MOTION PENDING',
																		self.disposition_code = '07' => 'DISPOSED, MOTION PENDING',
																		self.disposition_code = '11' => 'TRANSFERRED TO COUNTY COURT',
																		self.disposition_code = '15' => 'REFERRED TO JUDICIAL HEARING OFFICER',
																		self.disposition_code = '17' => 'REF TO JUCICIAL HEARING OFFICER, MOTION PENDING','');
self.disposition_date		:= IF(trim(L.disposition_date,all) <> '00000000',trim(L.disposition_date,all),'');
TrimSuedAmt							:= IF(trim(L.sued_amt,all) <> '000000000',trim(L.sued_amt,all),'');
self.suit_amount				:= ut.rmv_ld_zeros(TrimSuedAmt);
TrimAwardAmt						:= IF(trim(L.award_amt,all) <> '000000000000',trim(L.award_amt,all),'');
self.award_amount				:= ut.rmv_ld_zeros(TrimAwardAmt);
self := [];
end;

jNY 	:= join(fNY(idxno <> ''),court,
							trim(left.county_code,all) = trim(right.code,all),
							tNY(left,right),left outer,lookup);

dNY 	:= dedup(sort(distribute(jNY,hash(case_key)),
                  process_date, case_key, court, case_number, case_title,
									disposition_code, disposition_description, disposition_date,local),
									case_key, court, case_number, case_title, disposition_code, 
									disposition_description, disposition_date, suit_amount,award_amount,local,left):
									PERSIST('~thor_data400::in::civil_NY_Downstate_matter');

EXPORT Map_NY_Downstate_Matter := dNY;