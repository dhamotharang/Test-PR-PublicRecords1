IMPORT Civ_Court, civil_court, ut, lib_StringLib, Std;

#option('multiplePersistInstances',FALSE);

//original AbInitio mapping /stub_cleaning/court/work/mp/ny_civil_upstate_02_update_new_lkp.mp

fNY	:= sort(Civ_court.Files_In_NY_Upstate.Case_in,idxno,county_code,court_code);
court	:= sort(Civ_court.Files_In_NY_Upstate.county_lkp,code);
case_status := sort(Civ_court.Files_In_NY_Upstate.Case_status_lkp,code);
action_type	:= dedup(sort(Civ_court.Files_In_NY_Upstate.Action_type_lkp,action_type));


fmtsin := [
		'%m/%d/%Y',
		'%m-%d-%Y'
	];
	fmtout:='%Y%m%d';	

Civil_Court.Layout_In_Matter tNY(fNY L, court R) := Transform
self.process_date				:= civil_court.Version_Development;
self.vendor						  := '30';
self.state_origin				:= 'NY';
self.source_file				:= 'NY-UPSTATE-CIV-COURT';
ClnCase									:= trim(L.county_code,all)+trim(L.idxno,all);
self.case_key					  := '30'+ ClnCase;
self.parent_case_key		:= '';
self.court_code					:= trim(L.county_code,all);
self.court						  := map(trim(L.court_code) = '0' => 'NEW YORK STATE LOWER CIVIL COURT: '+ut.CleanSpacesAndUpper(R.description),
																trim(L.court_code) = '1' => 'NEW YORK STATE SUPREME CIVIL COURT: '+ut.CleanSpacesAndUpper(R.description),
																'NEW YORK STATE COURT');
self.case_number				:= ClnCase;
self.case_type_code			:= L.action_type;
self.case_type					:= '';
self.case_title					:= IF(L.plaintiff <> '',ut.CleanSpacesAndUpper(L.plaintiff)+' VS '+ ut.CleanSpacesAndUpper(L.defendant),'');
self.disposition_code 	:= ut.CleanSpacesAndUpper(L.case_status);
self.disposition_description := '';
self.disposition_date 	:= Std.Date.ConvertDateFormatMultiple(L.disposition_date, fmtsin, fmtout);
self := [];
end;

jNY 	:= join(fNY(idxno <> ''),court,
							trim(left.county_code,all) = trim(right.code,all),
							tNY(left,right),left outer,lookup);
							
//Lookup case disposition
Civil_Court.Layout_In_Matter tDisp(jNY L, case_status R) := Transform
self.disposition_description := ut.CleanSpacesAndUpper(R.description);
self := L;
END;

jNYCase	:= join(jNY, case_status,
								trim(left.disposition_code,all) = trim(right.code,all),
								tDisp(left,right), left outer, lookup);
								
//Lookup action type(case_type) - *There is a description field in the raw input file, but lookup file is more detailed
Civil_Court.Layout_In_Matter tAction(jNYCase L, action_type R) := TRANSFORM
self.case_type	:= ut.CleanSpacesAndUpper(R.description);
self := L;
END;

jNYAction	:= join(jNYCase, action_type,
									trim(left.case_type_code,all) = trim(right.action_type,all),
									tAction(left,right), left outer, lookup);
								
dNY 	:= dedup(sort(distribute(jNYAction,hash(case_key)),
                  process_date, case_key, court, case_number, case_title, case_type,
									disposition_code, disposition_description, disposition_date,local),
									case_key, court, case_number, case_title, case_type, disposition_code, 
									disposition_description,local,left):
									PERSIST('~thor_data400::in::civil_NY_Upstate_matter');


EXPORT Map_NY_Upstate_Matter := dNY;