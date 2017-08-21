#workunit('name','Foreclosure Build')
stats_foreclosure(dataset(property.Layout_Fares_Foreclosure_V2) ds_foreclosure) := function
	layout_foreclosure_stats := record
		ds_foreclosure.state;
		ds_foreclosure.county;
		string8 min_recording_dt := min(group,ds_foreclosure.recording_date);
		string8 max_recording_dt := max(group,ds_foreclosure.recording_date);
		total_count := count(group);
	end;

	tbl_foreclosure_stats := table(ds_foreclosure,
									layout_foreclosure_stats,
									ds_foreclosure.state,
									ds_foreclosure.county,
									few);

	return tbl_foreclosure_stats;
end;

max_process_date := max(property.file_foreclosure_building,regexfind('^[0-9]{8}$',trim(process_date),0));

ds_first := stats_foreclosure(property.file_foreclosure_building);
ds_second := stats_foreclosure(property.file_foreclosure_building(process_date != max_process_date));

typeof(ds_first) tStats(ds_first l, ds_second r) := transform
	self := l;
end;

ds_stats := join(ds_first, ds_second,
				 left.state = right.state and
				 left.county = right.county and
				 left.min_recording_dt = right.min_recording_dt,
				 tStats(left,right),
				 left only);

export Foreclosure_Stats_Metadata := if(count(ds_stats) > 0,
										sequential(
											output(choosen(ds_stats,1000),named('new_updated_foreclosure_counties')),
											fileservices.sendemail('gwitz@seisint.com;kgummadi@seisint.com;DCADataInsightTeam@Choicepoint.com',
												'Foreclosure Stats for build version ' + max_process_date,
												'New or updated foreclosure county stats: http://prod_esp:8010/WsWorkunits/WUInfo?Wuid=' + workunit)
											),
										output('No new or updated foreclosure counties')
										);