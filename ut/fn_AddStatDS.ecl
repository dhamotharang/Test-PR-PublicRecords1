export fn_AddStatDS(dataset(ut.layout_stats_extend) stats/*, string name*/) := 
FUNCTION
/*
sf := '~thor_data400::cemtemp::stats::'+trim(ut.stored_statname);
lf := sf + trim(name) + thorlib.wuid();

go := sequential(
	output(stats,,lf),
	if(not FileServices.SuperFileExists(sf), FileServices.CreateSuperFile(sf)),
	FileServices.AddSuperFile(sf, lf));

return if(ut.stored_statname <> '' and name <> '', go);
*/
return output(stats, named('STATS'), extend,all);


END;