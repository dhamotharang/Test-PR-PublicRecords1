IMPORT Civ_Court, civil_court, ut, lib_StringLib, Std;

#option('multiplePersistInstances',FALSE);

//original AbInitio mapping /stub_cleaning/court/work/mp/tx_civil_gregg02_upd.mp

fTXGregg	:= Civ_Court.File_In_TX_Gregg(trim(CaseNumber,left,right) <> 'test');

fmtsin := [
		'%m/%d/%Y',
		'%m-%d-%Y'
	];
	fmtout:='%Y%m%d';	

Civil_Court.Layout_In_Case_Activity tTX(fTXGregg input, integer1 C) := Transform
self.process_date				:= civil_court.Version_Development;
self.vendor						  := '41';
self.state_origin				:= 'TX';
self.source_file				:= 'TX Gregg County Ct';
self.case_key						:= '41'+ut.CleanSpacesAndUpper(input.CaseNumber);
self.court							:= 'GREGG COUNTY COURT';
self.case_number				:= input.CaseNumber;
self.event_date					:= CHOOSE(C,Std.date.ConvertDateFormatMultiple(input.FileDate,fmtsin,fmtout),Std.date.ConvertDateFormatMultiple(input.LastEventDate,fmtsin,fmtout));
self.event_type_description_1:= ut.CleanSpacesAndUpper(CHOOSE(C,'FILING DATE',input.LastEventType));
self := [];
end;

pTX	:= normalize(fTXGregg,2,tTX(left,counter));

dTX 	:= dedup(sort(distribute(pTX,hash(case_key)),
									process_date,case_key,court,case_number,event_date,event_type_description_1,local),
									case_key,court,case_number,event_date,event_type_description_1,local,left):
									PERSIST('~thor_data400::in::civil_TX_Gregg_activity');

EXPORT Map_TX_Gregg_Activity := dTX(event_type_description_1 <> '');