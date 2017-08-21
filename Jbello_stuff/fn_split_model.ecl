import ut;

rs:={ string30 orig_model_desc, string25 orig_series_desc, string36 vina_model_desc };

ds := dataset(ut.foreign_prod+'~thor_data400::persist::veh_modelseries',rs,flat);

	PATTERN	ws			:= PATTERN('[ ]');
	PATTERN	Alpha		:= PATTERN('[a-zA-Z0-9-/.]');
	PATTERN	Word		:= Alpha+;
	PATTERN	aModel		:= first Word PENALTY(1);

	PATTERN	notAlpha	:= PATTERN('[A-Z-a-z]*[0-9,-\\/().][A-Z-a-z]*');
	PATTERN	Junk		:= notAlpha+;
	PATTERN	aSeries		:= first Junk PENALTY(1);

	RULE	ModelComponent	:= aModel | aSeries;
	RULE	SeriesComponent	:= aSeries;

	ps1:=record
		string25 vina_model_desc:=ds.vina_model_desc;
		string25 Model:=MATCHTEXT(ModelComponent);
	end;
	ps2:=record
		string25 vp_series_name:=ds.vina_model_desc;
		string25 Series:=MATCHTEXT(SeriesComponent);
	end;

	modelOut:=parse(ds
					// (source_code='AE')
					,vina_model_desc,ModelComponent,ps1,not matched,best,NOCASE)
			:persist('~thor_data400::persist::veh_ModelComponent')
			;
	seriesOut:=parse(ds
					// (source_code='AE')
					,vina_model_desc,SeriesComponent,ps2,not matched,BEST,first,NOCASE)
			:persist('~thor_data400::persist::veh_SeriesComponent')
			;

r1:=record
	modelOut.vina_model_desc,
	modelOut.Model,
	cnt:=count(group),
end;
t1:=table(modelOut,r1,vina_model_desc,Model)
		:persist('~thor_data400::persist::veh_ModelComponent_cnt')
		;


output(sort(t1,-cnt));
// output(modelOut);
// output(seriesOut);











