import vehlic,ut;
veh := vehlic.File_Vehicles(history='',source_code !='AE');

vehslim := record
	unsigned6 did;
	qstring22 vehnum;
	integer8 dt_first_seen;
	qstring8  First_Registration_Date;
	qstring8  Registration_Effective_Date;
	qstring8  Title_Issue_Date;
end;

vehslim normit(veh l, integer c) := transform
	self.did := (unsigned6)(integer)choose(c, l.own_1_did, l.reg_1_did, l.own_2_did, l.reg_2_did);
	self.vehnum := l.orig_state + l.VEHICLE_NUMBERxBG1;
    self.dt_first_seen := MAP(l.orig_state='TX'=>ut.min2((integer)l.title_issue_date,(integer)l.registration_effective_date),
										 l.orig_state='WI'=>(integer)l.registration_effective_date,
										 l.orig_state='MO'=>ut.min2((integer)l.first_registration_date,(integer)l.title_issue_date),
										 l.orig_state='NC'=>ut.min2((integer)l.title_issue_date,(integer)l.plate_issue_date),
										 (integer)l.first_registration_date);
	self := l;
end;

vehnorm := normalize(veh, 4, normit(left, counter));
vehdist := distribute(vehnorm(did > 0), hash(did));

vehsrtd := sort(vehdist, did, -dt_first_seen, vehnum, local);
vehddpd := dedup(vehsrtd, did, local);

export bestvehicle := vehddpd : persist('persist::Watchdog_BestVehicle');