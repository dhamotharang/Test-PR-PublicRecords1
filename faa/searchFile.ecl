f := faa.searchFile_Linkids; 

  Layout_Searchfile := RECORD
  unsigned6 aircraft_id;
	faa.layout_aircraft_registration_out_Persistent_ID;
	END;
		
export searchfile := project(f, Layout_Searchfile) : PERSIST('persist::faa_aircraft_searchfile');