import ut;
export Statistics(

	string pversion = 'qa'
 
) :=
module

	ut.macGetCoverageDates(files(pversion).base.new	,'Zoom Base'	,dt_first_seen	,dt_last_seen	,Zoom_base_Coverage_stats	,false,19500000,20080000);

	export All :=
	sequential(
		output(Zoom_base_Coverage_stats, named('Zoom_Base_Coverage_Stats'))
	);

end;