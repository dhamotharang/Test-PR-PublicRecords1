EXPORT temp_transform(ds_temp, t_field) := functionmacro

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
										fieldname = 'date30' => '20150501',
										'0');
		end;

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

		norm_metrics_lay := record
			STRING field;
			metrics_lay;
		end;

		g_date := get_date(t_field);

		norm_metrics_lay full_trans(ds_temp le) := transform
				self.field := le.attribute;
				self.date := g_date;
				self.mean := if(le.statistic = 'mean', le.val, 0);
				self.median := if(le.statistic = 'median', le.val, 0);
				self.std_dev := if(le.statistic = 'standard deviation', le.val, 0);
				self.miss_rate := if(le.statistic = 'missing rate', le.val, 0);
				self.zero_rate := if(le.statistic = '0 rate', le.val, 0);
				self.neg_one_rate := if(le.statistic = '-1 rate', le.val, 0);
				self.hit_rate := if(le.statistic = 'hit rate', le.val, 0);
				self := [];
		end;


		ds_temp_1 := project(ds_temp, full_trans(left));
		// output(ds_temp_1, named('first_project'));

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
		// output(ds_norm_metrics, named('rolled_data'));

		ds_metrics := project(ds_norm_metrics, transform(input_metrics_lay,
																						self.field := left.field;
																						self.metrics := project(left, transform(metrics_lay,
																																		self := left;
																																		));
																						self := [];
																						));
																						
		// output(ds_metrics, named('final_data'));
		return ds_metrics;		
endmacro;