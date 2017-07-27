import FLAccidents;
inc := dedup(sort(distribute(FLAccidents.InFile_NtlAccidents_Alpharetta.incident(
															trim(last_changed,left,right)[7..10]+ trim(last_changed,left,right)[1..2]+trim(last_changed,left,right)[4..5]<'20101112')
															,hash(vehicle_incident_id))
						,vehicle_incident_id,order_id,sequence_nbr,trim(last_changed,left,right)[7..10]+ trim(last_changed,left,right)[1..2]+trim(last_changed,left,right)[4..5],local)
						,vehicle_incident_id,order_id,right,local);
veh := dedup(sort(distribute(FLAccidents.InFile_NtlAccidents_Alpharetta.vehicles(
															trim(last_changed,left,right)[7..10]+ trim(last_changed,left,right)[1..2]+trim(last_changed,left,right)[4..5]<'20101112'),hash(vehicle_incident_id))
						,vehicle_incident_id,vehvin,trim(last_changed,left,right)[7..10]+ trim(last_changed,left,right)[1..2]+trim(last_changed,left,right)[4..5],local)
						,vehicle_incident_id,vehvin,right,local);

FLAccidents_Ecrash.Layout_CRU_Incidents trecs(inc L, veh R) := transform
self.tag_state := if(R.tag_state != '', R.tag_state, L.state_abbr);
self.loss_date := trim(L.loss_date,left,right)[7..10]+ trim(L.loss_date,left,right)[1..2]+trim(L.loss_date,left,right)[4..5];
self.inc_last_changed := trim(L.last_changed,left,right)[7..10]+ trim(L.last_changed,left,right)[1..2]+trim(L.last_changed,left,right)[4..5];
self.veh_last_changed := trim(R.last_changed,left,right)[7..10]+ trim(R.last_changed,left,right)[1..2]+trim(R.last_changed,left,right)[4..5];
self.inc_userid := L.userid;
self.veh_userid := R.userid;
self := L;
self := R;
end;

base := join(inc,veh,
							left.vehicle_incident_id = right.vehicle_incident_id,
							trecs(left,right),local) : persist('~thor_data400::persist::cru_incidents');
							



export File_CRU_Incidents := base;














