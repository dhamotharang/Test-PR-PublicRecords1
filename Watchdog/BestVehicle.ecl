import vehicleV2,ut;

veh := VehicleV2.file_vehicleV2_party(source_code<>'AE' and append_did>0 and (history='' or trim(history)='E'));

vehslim := record
	unsigned6 did;
	integer   date_;
	string32  vehnum;
end;
										 
vehslim normit(veh le) := transform
 self.did    := le.append_DID;
 //keep these individual state handlings to preserve what was done in original bestvehicle code
 self.date_  := MAP(le.state_origin='TX' and le.source_code='DI' => ut.min2((integer)le.Ttl_latest_Issue_Date,(integer)le.Reg_latest_Effective_Date),
                   le.state_origin='WI' and le.source_code='DI' => (integer)le.Reg_latest_Effective_Date,
				   le.state_origin='MO' and le.source_code='DI' => ut.min2((integer)le.Ttl_latest_Issue_Date,(integer)le.Reg_latest_Effective_Date),
				   le.state_origin='NC' and le.source_code='DI' => (integer)le.Ttl_latest_Issue_Date,
				   ut.max2((integer)le.Reg_latest_Effective_Date,(integer)le.Ttl_latest_Issue_Date)
				  );
 self.vehnum := le.state_origin + trim(le.vehicle_key, left, right);
 self        := le;
end;

vehnorm := project(veh,normit(left));

vehdist  := distribute(vehnorm,hash(did));
veh_sort := sort(vehdist,did,-date_, vehnum,local);
veh_dedup := dedup(veh_sort,did,local);

export bestvehicle := veh_dedup: persist('persist::Watchdog_BestVehiclev2');