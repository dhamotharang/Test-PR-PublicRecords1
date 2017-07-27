import faa, ut;

f := faa.file_aircraft_registration_bldg_bid; 

  Layout_Searchfile := RECORD
	  unsigned6 aircraft_id;
		faa.layout_aircraft_registration_out_slim;
	END;
	
ut.MAC_Sequence_Records_NewRec(f,Layout_Searchfile,aircraft_id,outf);

export searchfile_bid := outf : PERSIST('persist::faa_aircraft_searchfile_bid');