import emerges, ut;

f := eMerges.file_hunters_keybuild;

  Layout_Searchfile := RECORD
	  unsigned6 rid;
		emerges.layout_hunters_out;
	END;
	
ut.MAC_Sequence_Records_NewRec(f,Layout_Searchfile,rid,outf);

export huntfish_searchfile := outf : PERSIST('persist::hunting_fishing_searchfile');