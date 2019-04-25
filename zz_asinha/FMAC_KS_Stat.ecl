EXPORT FMAC_KS_Stat(inputFile,inputLay,inputBaseFile) := FUNCTIONMACRO

	ds_input := inputFile; 
	ds_base := inputBaseFile;

	base_date := ds_base[1].date_in[..8];
	current_date := ds_input[1].date_in[..8];

/* ************************************
 *         KS Calculations            *
************************************* */
	ks_lay := record
			inputLay;
			decimal10_8 curr_proportion;
			decimal10_8 cum_proportion;
			decimal10_8 cum_prop_diff;
			decimal10_8 max_prop_diff;
			boolean ks_flag;
			integer curr_samplesize;
			integer prev_samplesize;
			integer8 sum_bin_freq;
	end;

	ds_ks_input := ds_input + ds_base;
	
	ds_ks_temp_1 := project(ds_ks_input, transform(ks_lay,
																					self.curr_proportion := left.bincount/left.samplesize,
																					self := left,
																					self := []) );


	ds_ks_temp := project(ds_ks_temp_1,transform(ks_lay,
																								self.bincount := if(left.bin='999',0,left.bincount),
																								self := left));

	// s_ds_ks_temp := sort(ds_ks_temp, (integer) date, (integer) bin[1..3]);
	s_ds_ks_temp := sort(ds_ks_temp, (integer) date);   // removed bin from sort - see above - since it was messing up the cum_proportion and sum_bin_freq

	ds_cum_ks := iterate(s_ds_ks_temp, transform(ks_lay,
																								self.cum_proportion := if(left.date_in = right.date_in, left.cum_proportion + right.curr_proportion, right.curr_proportion),
																								self.sum_bin_freq := if(left.date_in = right.date_in, left.sum_bin_freq + right.bincount, right.bincount),
																								self := right
																								) );

	diff_cum_ks_base := ds_cum_ks(date_in[..8] = base_date);

	diff_cum_ks := join(diff_cum_ks_base, ds_cum_ks, left.bin = right.bin,
																									transform(ks_lay,
																														self.cum_prop_diff := abs(left.cum_proportion - right.cum_proportion),
																														self.curr_samplesize := right.samplesize,
																														self.prev_samplesize := left.samplesize,
																														self := right) );


	ks_lay2 := record
			diff_cum_ks.date_in;
			decimal10_8 KS_Stat_Original := max(group, diff_cum_ks.cum_prop_diff);
			curr_response_count := diff_cum_ks.curr_samplesize;
			prev_response_count := diff_cum_ks.prev_samplesize;
			sum_bins_freq := max(group, diff_cum_ks.sum_bin_freq);
			decimal10_8 KS_Threshold_SigLevel_0_001 := 0;
			decimal10_8 KS_Threshold_SigLevel_0_1 := 0;
			decimal10_8 KS_Threshold_SigLevel_0_4 := 0;
			decimal10_8 KS_Threshold_SigLevel_0_6 := 0;
			boolean ks_flag := false;
	end;

	max_cum_ks := table(diff_cum_ks, ks_lay2, date_in);

	ks_weight_0_1 := 1.22;
	ks_weight_0_4 := 0.897;
	ks_weight_0_6 := 0.775;
	ks_weight_0_001 := 1.95;

	ds_ks_flag := project(max_cum_ks, transform(recordof(max_cum_ks),
																							self.ks_flag := 	left.KS_Stat_Original > 
																																ks_weight_0_1 * sqrt(( ( left.curr_response_count + left.prev_response_count) / ( left.curr_response_count * left.prev_response_count)));
																							self.KS_Threshold_SigLevel_0_001 := ks_weight_0_001 * sqrt(( ( left.curr_response_count + left.prev_response_count) / ( left.curr_response_count * left.prev_response_count)));
																							self.KS_Threshold_SigLevel_0_1 := ks_weight_0_1 * sqrt(( ( left.curr_response_count + left.prev_response_count) / ( left.curr_response_count * left.prev_response_count)));
																							self.KS_Threshold_SigLevel_0_4 := ks_weight_0_4 * sqrt(( ( left.curr_response_count + left.prev_response_count) / ( left.curr_response_count * left.prev_response_count)));
																							self.KS_Threshold_SigLevel_0_6 := ks_weight_0_6 * sqrt(( ( left.curr_response_count + left.prev_response_count) / ( left.curr_response_count * left.prev_response_count)));
																							self := left) );
	
	ds_ks_flag_current_date := ds_ks_flag(date_in[..8] = current_date);


	Return ds_ks_flag_current_date;

ENDMACRO;

