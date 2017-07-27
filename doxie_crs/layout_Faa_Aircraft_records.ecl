import faa, BIPV2, FFD;

engine := doxie_crs.layout_FAR_engine;
aircraft := doxie_crs.layout_FAR_aircraft;

export layout_Faa_Aircraft_records := record
	string2 source;
  faa.layout_aircraft_registration_out_slim;
	BIPV2.IDlayouts.l_header_ids; //UltID, etc.
	string20  current_flag_mapped;
	string18  county_name;
	dataset(engine) engine_info;
	dataset(aircraft) craft_info;
	FFD.Layouts.CommonRawRecordElements;
end;
