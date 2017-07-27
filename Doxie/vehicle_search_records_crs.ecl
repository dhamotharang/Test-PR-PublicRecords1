

vsr := doxie.vehicle_search_records;
srt := sort(vsr, orig_vin,-registration_effective_date,
 -registration_expiration_date,-first_registration_date, case(history ,'' => 0, 'H' => 1, 3), -dt_last_seen);
ddp := dedup(srt, orig_vin);

export vehicle_search_records_crs := 
	sort(ddp,nondmvsource,-registration_effective_date,-registration_expiration_date,-first_registration_date,
	history, orig_vin,record);
