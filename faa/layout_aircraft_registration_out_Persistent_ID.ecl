import faa;
export layout_aircraft_registration_out_Persistent_ID := record
  faa.layout_aircraft_registration_out_slim and not lf;
	unsigned8 persistent_record_id; 
end;