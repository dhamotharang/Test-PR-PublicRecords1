EXPORT dam_get_stats(file_date) := functionmacro

		IMPORT riskview, riskprocessing, Scoring_Project_Macros;
		
		// Need a way to check for today's file and then use it for the date.  Date could also be passed in as a parameter
		// file_date := '20150319';

		// ******* Input report info here ********
		infile_name := '~scoringqa::out::nonfcra::ita_batch_capitalone_attributes_v3_'+file_date+'_1';
		// eyeball := 25000;
		statsfile_name := '~dam::out::ita_dynamic_attribute_module_stats';
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

		ds_old_stats := dataset(statsfile_name, input_metrics_lay, THOR);
		// output(ds_old_stats);

		//layout for dialy ITA data collections
		ita_layout := RECORD
			Scoring_Project_Macros.Regression.ITA_V3_OutLay_new;
			RiskProcessing.layout_internal_extras;
		END;

		ds_temp := dataset(infile_name, ita_layout, THOR);
		ds_ita := ds_temp;
		// output(CHOOSEN(ds_temp, 10), named('input_sample'));

		//layout for metrics from zz_Koubsky.macro_stats_cap_one
		stats_layout := RECORD
			STRING name;
			REAL mean;
			REAL median;
			REAL std_dev;
			REAL miss_rate;
			REAL zero_rate;
			REAL neg_one_rate;
			REAL hit_rate;
		END;

		//compile statistics from daily data collections
		DATASET ita_stats := zz_Koubsky.dam_get_ita_stats(ds_ita);
		// zz_Koubsky.macro_stats_cap_one(ds_ita, 'v3__subjectssnrecentcount') +
		// zz_Koubsky.macro_stats_cap_one(ds_ita, 'v3__prsearchcollectioncount');


		//convert the ita_stats to the child dataset layout
		metrics_lay metrics_trans(stats_layout le) := transform
				self.date := file_date;
				self := le;
		end;

		//append new stats to existing file and cleanup metrics per descriptions below
		input_metrics_lay new_data_append(input_metrics_lay le, stats_layout ri) := transform
				self.field := le.field;
						//append new metrics to existing file
						met_1 := project(ri, metrics_trans(left)) + le.metrics;
						//sort by dates and remove blank dates
						met_2 := sort(met_1(length(date) = 8), -(integer)date);
						//dedup same dates
						met_3 := dedup(met_2, date);
						//keep last 50 datapoints
						met_4 := met_3[1..50];
				self.metrics := met_4;
		end;

		ds_new_stats := join(ds_old_stats, ita_stats, left.field = right.name, new_data_append(left, right));
		
		ds_final_stats := ds_new_stats;

		act_1 := output(ds_final_stats,, statsfile_name+'_1', thor, overwrite, expire(20));
		
		//workaround for rewriting the file to the file we opened.
		temp_file := dataset(statsfile_name+'_1', input_metrics_lay, THOR);
		act_2 := output(temp_file,, statsfile_name, thor, overwrite, expire(20));
		sequential(act_1, act_2);
		
		return ds_final_stats;
endmacro;