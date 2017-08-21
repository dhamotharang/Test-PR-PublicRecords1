#workunit('name','Marriage Divorce Stats')

layout_mar_div := record
	string35 county;
	string8	coverage_dt;
	marriage_divorce_v2.layout_mar_div_base;
end;

layout_mar_div tPopulateCounty(marriage_divorce_v2.layout_mar_div_base l) := transform
	self.county := if(l.filing_type = '3', l.marriage_county, l.divorce_county);
	self.coverage_dt := if(l.filing_type = '3', regexfind('^[0-9]{6,8}$',trim(l.marriage_dt),0), regexfind('^[0-9]{6,8}$',trim(l.divorce_dt),0));
	self := l;
end;

ds_marriage_divorce := project(marriage_divorce_v2.file_mar_div_base, tPopulateCounty(left));

stats_mardiv(dataset(layout_mar_div) ds_mardiv) := function
	layout_mardiv_stats := record
		ds_mardiv.state_origin;
		ds_mardiv.county;
		ds_mardiv.filing_type;
		string8 min_coverage_dt := min(group,ds_mardiv.coverage_dt);
		string8 max_coverage_dt := max(group,ds_mardiv.coverage_dt);
		total_count := count(group);
	end;
	
	tbl_mardiv_stats := table(ds_mardiv,
							layout_mardiv_stats,
							ds_mardiv.state_origin,
							ds_mardiv.county,
							ds_mardiv.filing_type,
							few);

	return tbl_mardiv_stats;
end;

max_process_date := max(ds_marriage_divorce(regexfind('^[0-9]{8}$',trim(process_date))),ds_marriage_divorce.process_date);

ds_mardiv_first := stats_mardiv(ds_marriage_divorce(trim(coverage_dt) != ''));
ds_mardiv_second := stats_mardiv(ds_marriage_divorce(trim(coverage_dt) != '' and process_date != max_process_date));

typeof(ds_mardiv_first) tStats(ds_mardiv_first l, ds_mardiv_second r) := transform
	self := l;
end;

ds_mardiv_stats := join(ds_mardiv_first, ds_mardiv_second,
						 left.state_origin = right.state_origin and
						 left.county = right.county and
						 left.min_coverage_dt = right.min_coverage_dt,
						 tStats(left,right),
						 left only);

export MarriageDivorce_Stats_Metadata := if(count(ds_mardiv_stats) > 0,
											sequential(
												output(choosen(ds_mardiv_stats,1000),named('new_updated_marriage_divorce_counties')),
												fileservices.sendemail('kgummadi@seisint.com;metadata@seisint.com',
													'Marriage/Divorce Stats for build version ' + max_process_date,
													'New or updated marriage/divorce county stats: http://prod_esp:8010/WsWorkunits/WUInfo?Wuid=' + workunit)
												),
											output('No new or updated marriage/divorce counties')
											);