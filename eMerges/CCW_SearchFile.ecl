import eMerges, ut;

f := eMerges.file_ccw_out;

  Layout_Searchfile := RECORD
		unsigned6 rid;
		eMerges.layout_ccw_out;
  END;
	
ut.MAC_Sequence_Records_NewRec(f,Layout_Searchfile,rid,outf);

export CCW_SearchFile := outf : PERSIST('persist::ccw_searchfile');