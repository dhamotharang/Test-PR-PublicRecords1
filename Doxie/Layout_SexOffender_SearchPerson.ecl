import sexoffender, doxie_build, doxie, FFD;

export layout_sexoffender_searchperson := record , maxlength(200000)
	sexoffender.layout_out_main;
  DATASET(sexoffender.Layout_Out_Alt) addresses;
	string10   source := doxie_build.buildstate;
	string10   failurelocation := 'XX';
	integer    failurecode := 0;
	string50   failuremessage := '';
	FFD.Layouts.CommonRawRecordElements;
end;