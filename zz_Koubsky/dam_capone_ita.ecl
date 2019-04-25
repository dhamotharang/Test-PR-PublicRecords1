// EXPORT dam_capone_ita := 'todo';


filename := '~nkoubsky::in::ita_3_0_report_apr_2015';

in_lay := record
		string attribute;
		string statistic;
		real date1;
		real date2;
		real date3;
		real date4;
		real date5;
		real date6;
		real date7;
		real date8;
		real date9;
		real date10;
		real date11;
		real date12;
		real date13;
		real date14;
		real date15;
		real date16;
		real date17;
		real date18;
		real date19;
		real date20;
		real date21;
		real date22;
		real date23;
		real date24;
		real date25;
		real date26;
		real date27;
		real date28;
		real date29;
end;

ds_in_temp := dataset(filename, in_lay, csv(quote('"'), heading(single)));
ds_in := ds_in_temp(attribute <> '');

output(ds_in(attribute <> ''), named('input_data'));
/*
string get_date(string fieldname) := function
		
		return map(
								fieldname = 'date1' => '20121001',
								fieldname = 'date2' => '20121101',
								fieldname = 'date3' => '20130201',
								fieldname = 'date4' => '20130301',
								fieldname = 'date5' => '20130401',
								fieldname = 'date6' => '20130501',
								fieldname = 'date7' => '20130601',
								fieldname = 'date8' => '20130701',
								fieldname = 'date9' => '20130801',
								fieldname = 'date10' => '20130901',
								fieldname = 'date11' => '20131001',
								fieldname = 'date12' => '20131101',
								fieldname = 'date13' => '20131201',
								fieldname = 'date14' => '20140101',
								fieldname = 'date15' => '20140201',
								fieldname = 'date16' => '20140301',
								fieldname = 'date17' => '20140401',
								fieldname = 'date18' => '20140501',
								fieldname = 'date19' => '20140601',
								fieldname = 'date20' => '20140701',
								fieldname = 'date21' => '20140801',
								fieldname = 'date22' => '20140901',
								fieldname = 'date23' => '20141001',
								fieldname = 'date24' => '20141101',
								fieldname = 'date25' => '20141201',
								fieldname = 'date26' => '20150101',
								fieldname = 'date27' => '20150201',
								fieldname = 'date28' => '20150301',
								fieldname = 'date29' => '20150401',
								'0');
end;
*/
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
/*
norm_metrics_lay := record
	STRING field;
	metrics_lay;
end;

norm_metrics_lay full_trans(in_lay le, string temp_field) := transform
		self.field := le.attribute;
		self.date := get_date(temp_field);
		self.mean := if(le.statistic = 'mean', le.date1, 0);
		self.median := if(le.statistic = 'median', le.date1, 0);
		self.std_dev := if(le.statistic = 'standard deviation', le.date1, 0);
		self.miss_rate := if(le.statistic = 'missing rate', le.date1, 0);
		self.zero_rate := if(le.statistic = '0 rate', le.date1, 0);
		self.neg_one_rate := if(le.statistic = '-1 rate', le.date1, 0);
		self.hit_rate := if(le.statistic = 'hit rate', le.date1, 0);
		// self.mean := if(le.statistic = 'mean', le.#expand(temp_field), 0);
		// self.mean := if(le.statistic = 'mean', le.#expand(temp_field), 0);
		// self.median := if(le.statistic = 'median', le.#expand(temp_field), 0);
		// self.std_dev := if(le.statistic = 'standard deviation', le.#expand(temp_field), 0);
		// self.miss_rate := if(le.statistic = 'missing rate', le.#expand(temp_field), 0);
		// self.zero_rate := if(le.statistic = '0 rate', le.#expand(temp_field), 0);
		// self.neg_one_rate := if(le.statistic = '-1 rate', le.#expand(temp_field), 0);
		// self.hit_rate := if(le.statistic = 'hit rate', le.#expand(temp_field), 0);
		self := [];
end;


ds_temp_1 := project(ds_in, full_trans(left, 'date1'));
output(ds_temp_1, named('first_project'));

norm_metrics_lay to_metrics(norm_metrics_lay le, norm_metrics_lay ri) := transform
		self.field := le.field;
		self.date := le.date;
		self.mean := if(ri.mean = 0, le.mean, ri.mean);
		self.median := if(ri.median = 0, le.median, ri.median);
		self.std_dev := if(ri.std_dev = 0, le.std_dev, ri.std_dev);
		self.miss_rate := if(ri.miss_rate = 0, le.miss_rate, ri.miss_rate);
		self.zero_rate := if(ri.zero_rate = 0, le.zero_rate, ri.zero_rate);
		self.neg_one_rate := if(ri.neg_one_rate = 0, le.neg_one_rate, ri.neg_one_rate);
		self.hit_rate := if(ri.hit_rate = 0, le.hit_rate, ri.hit_rate);
		self := [];
end;

ds_sorted := sort(ds_temp_1(field <> ''), field);
ds_norm_metrics := rollup(ds_sorted, left.field = right.field and left.date = right.date, to_metrics(left, right));
output(ds_norm_metrics, named('rolled_data'));

ds_metrics := project(ds_norm_metrics, transform(input_metrics_lay,
																				self.field := left.field;
																				self.metrics := project(left, transform(metrics_lay,
																																self := left;
																																));
																				self := [];
																				));
																				
output(ds_metrics, named('final_data'));
*/

t_lay := record
		string attribute;
		string statistic;
		real val;
end;

join_sets(ds_le, ds_ri) := functionmacro
		
		input_metrics_lay j_trans(input_metrics_lay le, input_metrics_lay ri) := transform
				self.metrics := le.metrics + ri.metrics;
				self := le;
		end;
		
		return join(ds_le, ds_ri, left.field = right.field, j_trans(left, right));
endmacro;

ds_1 := project(ds_in, transform(t_lay, self.val := left.date1; self := left));
ds_1_new := zz_Koubsky.temp_transform(ds_1, 'date1');
//output(ds_1_new);

ds_2 := project(ds_in, transform(t_lay, self.val := left.date2; self := left));
ds_2_new := zz_Koubsky.temp_transform(ds_2, 'date2');
//output(ds_2_new);

ds_3 := project(ds_in, transform(t_lay, self.val := left.date3; self := left));
ds_3_new := zz_Koubsky.temp_transform(ds_3, 'date3');
//output(ds_3_new);

ds_4 := project(ds_in, transform(t_lay, self.val := left.date4; self := left));
ds_4_new := zz_Koubsky.temp_transform(ds_4, 'date4');
//output(ds_4_new);

ds_5 := project(ds_in, transform(t_lay, self.val := left.date5; self := left));
ds_5_new := zz_Koubsky.temp_transform(ds_5, 'date5');
//output(ds_5_new);

ds_6 := project(ds_in, transform(t_lay, self.val := left.date6; self := left));
ds_6_new := zz_Koubsky.temp_transform(ds_6, 'date6');
//output(ds_6_new);

ds_7 := project(ds_in, transform(t_lay, self.val := left.date7; self := left));
ds_7_new := zz_Koubsky.temp_transform(ds_7, 'date7');
//output(ds_7_new);

ds_8 := project(ds_in, transform(t_lay, self.val := left.date8; self := left));
ds_8_new := zz_Koubsky.temp_transform(ds_8, 'date8');
//output(ds_8_new);

ds_9 := project(ds_in, transform(t_lay, self.val := left.date9; self := left));
ds_9_new := zz_Koubsky.temp_transform(ds_9, 'date9');
//output(ds_9_new);

ds_10 := project(ds_in, transform(t_lay, self.val := left.date10; self := left));
ds_10_new := zz_Koubsky.temp_transform(ds_10, 'date10');
//output(ds_10_new);

ds_11 := project(ds_in, transform(t_lay, self.val := left.date11; self := left));
ds_11_new := zz_Koubsky.temp_transform(ds_11, 'date11');
//output(ds_11_new);

ds_12 := project(ds_in, transform(t_lay, self.val := left.date12; self := left));
ds_12_new := zz_Koubsky.temp_transform(ds_12, 'date12');
//output(ds_12_new);

ds_13 := project(ds_in, transform(t_lay, self.val := left.date13; self := left));
ds_13_new := zz_Koubsky.temp_transform(ds_13, 'date13');
//output(ds_13_new);

ds_14 := project(ds_in, transform(t_lay, self.val := left.date14; self := left));
ds_14_new := zz_Koubsky.temp_transform(ds_14, 'date14');
//output(ds_14_new);

ds_15 := project(ds_in, transform(t_lay, self.val := left.date15; self := left));
ds_15_new := zz_Koubsky.temp_transform(ds_15, 'date15');
//output(ds_15_new);

ds_16 := project(ds_in, transform(t_lay, self.val := left.date16; self := left));
ds_16_new := zz_Koubsky.temp_transform(ds_16, 'date16');
//output(ds_16_new);

ds_17 := project(ds_in, transform(t_lay, self.val := left.date17; self := left));
ds_17_new := zz_Koubsky.temp_transform(ds_17, 'date17');
//output(ds_17_new);

ds_18 := project(ds_in, transform(t_lay, self.val := left.date18; self := left));
ds_18_new := zz_Koubsky.temp_transform(ds_18, 'date18');
//output(ds_18_new);

ds_19 := project(ds_in, transform(t_lay, self.val := left.date19; self := left));
ds_19_new := zz_Koubsky.temp_transform(ds_19, 'date19');
//output(ds_19_new);

ds_20 := project(ds_in, transform(t_lay, self.val := left.date20; self := left));
ds_20_new := zz_Koubsky.temp_transform(ds_20, 'date20');
//output(ds_20_new);

ds_21 := project(ds_in, transform(t_lay, self.val := left.date21; self := left));
ds_21_new := zz_Koubsky.temp_transform(ds_21, 'date21');
//output(ds_21_new);

ds_22 := project(ds_in, transform(t_lay, self.val := left.date22; self := left));
ds_22_new := zz_Koubsky.temp_transform(ds_22, 'date22');
//output(ds_22_new);

ds_23 := project(ds_in, transform(t_lay, self.val := left.date23; self := left));
ds_23_new := zz_Koubsky.temp_transform(ds_23, 'date23');
//output(ds_23_new);

ds_24 := project(ds_in, transform(t_lay, self.val := left.date24; self := left));
ds_24_new := zz_Koubsky.temp_transform(ds_24, 'date24');
//output(ds_24_new);

ds_25 := project(ds_in, transform(t_lay, self.val := left.date25; self := left));
ds_25_new := zz_Koubsky.temp_transform(ds_25, 'date25');
//output(ds_25_new);

ds_26 := project(ds_in, transform(t_lay, self.val := left.date26; self := left));
ds_26_new := zz_Koubsky.temp_transform(ds_26, 'date26');
//output(ds_26_new);

ds_27 := project(ds_in, transform(t_lay, self.val := left.date27; self := left));
ds_27_new := zz_Koubsky.temp_transform(ds_27, 'date27');
//output(ds_27_new);

ds_28 := project(ds_in, transform(t_lay, self.val := left.date28; self := left));
ds_28_new := zz_Koubsky.temp_transform(ds_28, 'date28');
//output(ds_28_new);

ds_29 := project(ds_in, transform(t_lay, self.val := left.date29; self := left));
ds_29_new := zz_Koubsky.temp_transform(ds_29, 'date29');
//output(ds_29_new);

ds_j1 := join_sets(ds_1_new, ds_2_new);
//output(ds_j1, named('final_results_1'));
ds_j2 := join_sets(ds_j1, ds_3_new);
//output(ds_j2, named('final_results_2'));
ds_j3 := join_sets(ds_j2, ds_4_new);
//output(ds_j3, named('final_results_3'));
ds_j4 := join_sets(ds_j3, ds_5_new);
//output(ds_j4, named('final_results_4'));
ds_j5 := join_sets(ds_j4, ds_6_new);
//output(ds_j5, named('final_results_5'));
ds_j6 := join_sets(ds_j5, ds_7_new);
//output(ds_j6, named('final_results_6'));
ds_j7 := join_sets(ds_j6, ds_8_new);
//output(ds_j7, named('final_results_7'));
ds_j8 := join_sets(ds_j7, ds_9_new);
//output(ds_j8, named('final_results_8'));
ds_j9 := join_sets(ds_j8, ds_10_new);
//output(ds_j9, named('final_results_9'));
ds_j10 := join_sets(ds_j9, ds_11_new);
//output(ds_j10, named('final_results_10'));
ds_j11 := join_sets(ds_j10, ds_12_new);
//output(ds_j11, named('final_results_11'));
ds_j12 := join_sets(ds_j11, ds_13_new);
//output(ds_j12, named('final_results_12'));
ds_j13 := join_sets(ds_j12, ds_14_new);
//output(ds_j13, named('final_results_13'));
ds_j14 := join_sets(ds_j13, ds_15_new);
//output(ds_j14, named('final_results_14'));
ds_j15 := join_sets(ds_j14, ds_16_new);
//output(ds_j15, named('final_results_15'));
ds_j16 := join_sets(ds_j15, ds_17_new);
//output(ds_j16, named('final_results_16'));
ds_j17 := join_sets(ds_j16, ds_18_new);
//output(ds_j17, named('final_results_17'));
ds_j18 := join_sets(ds_j17, ds_19_new);
//output(ds_j18, named('final_results_18'));
ds_j19 := join_sets(ds_j18, ds_20_new);
//output(ds_j19, named('final_results_19'));
ds_j20 := join_sets(ds_j19, ds_21_new);
//output(ds_j20, named('final_results_20'));
ds_j21 := join_sets(ds_j20, ds_22_new);
//output(ds_j21, named('final_results_21'));
ds_j22 := join_sets(ds_j21, ds_23_new);
//output(ds_j22, named('final_results_22'));
ds_j23 := join_sets(ds_j22, ds_24_new);
//output(ds_j23, named('final_results_23'));
ds_j24 := join_sets(ds_j23, ds_25_new);
//output(ds_j24, named('final_results_24'));
ds_j25 := join_sets(ds_j24, ds_26_new);
//output(ds_j25, named('final_results_25'));
ds_j26 := join_sets(ds_j25, ds_27_new);
//output(ds_j26, named('final_results_26'));
ds_j27 := join_sets(ds_j26, ds_28_new);
//output(ds_j27, named('final_results_27'));
ds_j28 := join_sets(ds_j27, ds_29_new);
output(ds_j28, named('final_results_28'));
