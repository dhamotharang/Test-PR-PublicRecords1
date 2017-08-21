ds_util := utilfile.file_util_in;

rCoverageStats_ds_util := record
	CountGroup := count(group);
	connect_date_MinNonBlank := min(group,if(ds_util.connect_date<>'',ds_util.connect_date,'99999999'));
	connect_date_MaxNonBlank := max(group,if(ds_util.connect_date<>'',ds_util.connect_date,'00000000'));
	date_added_to_exchange_MinNonBlank := min(group,if(ds_util.date_added_to_exchange<>'',ds_util.date_added_to_exchange,'99999999'));
	date_added_to_exchange_MaxNonBlank := max(group,if(ds_util.date_added_to_exchange<>'',ds_util.date_added_to_exchange,'00000000'));
	record_date_MinNonBlank := min(group,if(ds_util.record_date<>'',ds_util.record_date,'99999999'));
	record_date_MaxNonBlank := max(group,if(ds_util.record_date<>'',ds_util.record_date,'00000000'));
	ds_util.util_type;
end;

tStats := table(ds_util,rCoverageStats_ds_util,util_type,few);

zOrig_Stats := output(choosen(tStats,all));

export out_base_coverage_stats := zOrig_Stats;
									 