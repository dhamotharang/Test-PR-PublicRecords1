export layout_sexoffender_search_raw := record, maxlength(200000)
	  sexoffender.layout_out_main;
	  string10 source := doxie_build.buildstate;
	  dataset(doxie.layout_sexoffender_aka) aka;
	  dataset(sexoffender.layout_common_offense) offenses;
end;