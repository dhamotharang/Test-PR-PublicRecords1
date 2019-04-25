// EXPORT dam_trending_model := 'todo';

IMPORT riskview, riskprocessing, Scoring_Project_Macros;

statsfile_name := '~dam::out::ita_capone_stats_201504';
output_filename := '~dam::out::ita_capone_analysis_201504';
// ***************************************

metrics_lay := record
		STRING date;
		REAL mean;
		REAL median;
		REAL std_dev;
		REAL miss_rate;
		REAL zero_rate;
		REAL neg_one_rate;
		REAL hit_rate;
end;

//layout for output file
input_metrics_lay := record
		STRING field;
		dataset (metrics_lay) metrics;
end;

ds_new_stats := dataset(statsfile_name, input_metrics_lay, THOR);

												// dynamic_attribute_module (ds_input, n_datapoints, thresh_weight)
final_results := zz_Koubsky.dynamic_attribute_module(ds_new_stats, 12, .25);
output(final_results,, output_filename, thor, overwrite);