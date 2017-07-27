import sexoffender, doxie_build, FFD;
export layout_sexoffender_searchevents := record, maxlength(200000)
	  sexoffender.layout_common_offense;
	  string10   source := doxie_build.buildstate;
	  string10   failurelocation := 'XX';
	  integer    failurecode := 0;
	  string50   failuremessage := '';
		FFD.Layouts.CommonRawRecordElements;
end;