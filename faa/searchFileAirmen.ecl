import faa, ut;

f := faa.file_airmen_data_bldg; 

  Layout_Searchfile := RECORD
	unsigned6 airmen_id;
	faa.layout_airmen_Persistent_ID;
  END;
	
ut.MAC_Sequence_Records_NewRec(f,Layout_Searchfile,airmen_id,outf);

export searchfileAirmen := outf : PERSIST('persist::faa_airmen_searchfile');