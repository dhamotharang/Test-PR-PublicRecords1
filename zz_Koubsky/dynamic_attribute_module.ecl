EXPORT dynamic_attribute_module (ds_input, n_datapoints, thresh_weight) := functionmacro

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

		input_lay := record
				STRING field;
				dataset (metrics_lay) metrics;
		end;

		results_lay := record
				integer datapoints;
				REAL expected_value;
				REAL cumulative_sd;
				REAL lower_thresh;
				REAL upper_thresh;
				// BOOLEAN flag;
		end;

		metrics_lay_iterate_layout := record
				metrics_lay;
				integer mycounter;
				results_lay;
		end;

		io_lay := record
				STRING date;
				real curr_mean;
				real curr_std_dev;
				boolean pass_flag;
				string reason;
		end;
		
		final_lay := record
				string field;
				results_lay;
				io_lay;
		end;

		// create a macro that loops through each field and manipulates each value
		// start with row 1 to row n where n is the input parameter
		/* // EXAMPLE C++ FUNCTION
		integer sum_counter(integer datapoints) := BEGINC++
			int mysum=0;
			int i=1;
			while (i <= datapoints){
				mysum = mysum + i;
				i++;
				}
			return mysum;	
		ENDC++;
		*/

		//sort the datasets to ensure the date is in ascending order
		input_lay order_by_date(input_lay le) := transform
				self.field := le.field;
				self.metrics := sort(le.metrics, -date);
		end;

		//calculate expected value and standard deviation based on historical weights.
		metrics_lay_iterate_layout calc_limits(metrics_lay_iterate_layout le, metrics_lay_iterate_layout ri, integer datapoint_count) := transform
				
				//note that the first (most recent run) datapoint will not be used in calcuating metrics
				//number of datapoints to calculate metrics
				self.datapoints := datapoint_count;
				//total sum of all weights, ie. n + n-1 + n-2 + ... + 1
				integer sum_count := (datapoint_count * (datapoint_count + 1)) / 2;
				//assign a weight to each record from n to 0.  Record 1 gets a zero since it is not used
				integer weight := map(	ri.mycounter = 1											=>		0,
																ri.mycounter <= datapoint_count + 1		=> 		datapoint_count - ri.mycounter + 2, 
																0);
				//calculate the weighted average
				self.expected_value := le.expected_value + (weight * ri.mean) / sum_count;
				//calcuate the weighted standard deviation *****This calcluation may need modification*****
				self.cumulative_sd := le.cumulative_sd + (weight * power(ri.std_dev, 2)) / sum_count;
				//alternate method of calcuated combined sd / population sd based on weights
				// self.cumulative_sd := le.cumulative_sd + ( if(weight > 1, weight - 1, 0) * power(ri.std_dev, 2)) / (sum_count - datapoint_count);
				self := ri;
		END;

		
		final_lay calc_results(input_lay le) := transform
				
				//used to define the total number of data points used
				//either the number of points requested or the number of points available
				//add one to the count since we don't use the first record
				integer datapoint_count := if( count(le.metrics) + 1 > n_datapoints,
																				n_datapoints,
																				count(le.metrics) + 1 );
				//add a counter each nested record in the dataset
				metrics_prepped := project(le.metrics, transform(metrics_lay_iterate_layout, 
																													self.mycounter := counter, 
																													self := left, 
																													self := [] ));
				//itereate through each record for the metrics																								
				ds_temp_results := iterate(metrics_prepped, calc_limits(left, right, datapoint_count));
				//take the last record.  This record will represent the final value
				ds_results := ds_temp_results[datapoint_count];
				exp_val := ds_results.expected_value;
				//take sqrt since the process is returning variance
				std_dev := sqrt(ds_results.cumulative_sd);
				
				//append all the calculated results to the output
				self.field := le.field;		
				self.datapoints := ds_results.datapoints;
				self.expected_value := exp_val;
				self.cumulative_sd := std_dev;
						l_thresh := exp_val - (thresh_weight * std_dev);
				self.lower_thresh := l_thresh;
						u_thresh := exp_val + (thresh_weight * std_dev);
				self.upper_thresh := u_thresh;
				
				//return current data and pass/fail criteria
				self.date := le.metrics[1].date;
						real avg := le.metrics[1].mean;
				self.curr_mean := avg;
				self.curr_std_dev := le.metrics[1].std_dev;
					string flag_reason := map(avg > u_thresh 	=>		'Value above threshold',
																		avg < l_thresh 	=>		'Value below threshold',
																													'Pass');
				self.pass_flag := flag_reason = 'Pass';
				self.reason := flag_reason;
				
				self := [];
		end;

		
		ds_sorted := project(ds_input, order_by_date(left));
		ds_final_res := project(ds_sorted, calc_results(left));

		return ds_final_res;

endmacro;
//******Test data below******














/*
		//********** TEST DATA **********************************
		ds_input_metrics_1 := dataset( [
																		{ 20150101, 0.2297, 0, 0.6015, 0.0002001, 0.8151, 0, 0.1847 },
																		{ 20141201, 0.2286, 0, 0.5995, 0.0002248, 0.8158, 0, 0.184 },
																		{ 20141101, 0.2329, 0, 0.6093, 0.00007358, 0.813, 0, 0.1869 },
																		{ 20141001, 0.2335, 0, 0.61, 0.00007249, 0.8127, 0, 0.1873 },
																		{ 20140901, 0.2313, 0, 0.603, 0.00006882, 0.814, 0, 0.1859 },
																		{ 20140801, 0.2319, 0, 0.6069, 0.0001544, 0.8137, 0, 0.1862 },
																		{ 20140701, 0.2317, 0, 0.6064, 0.00009812, 0.8139, 0, 0.186 },
																		{ 20140601, 0.1835, 0, 0.5411, 0.0000475, 0.8502, 0, 0.1497 }
																		], metrics_lay);

		ds_input_metrics_2 := dataset( [
																		{ 20150101, 0.2297, 0, 0.6015, 0, 0, 0, 0 },
																		{ 20141201, 0.3458, 0, 0.6514, 0, 0, 0, 0 },
																		{ 20141101, 0.4182, 0, 0.6612, 0, 0, 0, 0 },
																		{ 20141001, 0.4426, 0, 0.6327, 0, 0, 0, 0 },
																		{ 20140901, 0.3987, 0, 0.6483, 0, 0, 0, 0 },
																		{ 20140801, 0.3382, 0, 0.7012, 0, 0, 0, 0 },
																		// { 20140701, 0.7651, 0, 0.6999, 0, 0, 0, 0 },
																		{ 20140601, 0.6951, 0, 0.6998, 0, 0, 0, 0 }
																		], metrics_lay);

		ds_input_metrics_3 := dataset( [
																		//{ 20150115, 34.8105682613938, 0, 0, 0, 0, 0, 0 },
																		//{ 20150114, 42.7252902415102, 0, 0, 0, 0, 0, 0 },
																		//{ 20150113, 31.3229855903075, 0, 0, 0, 0, 0, 0 },
																		//{ 20150112, 40.4713430493471, 0, 0, 0, 0, 0, 0 },
																		//{ 20150111, 40.7654892322349, 0, 0, 0, 0, 0, 0 },
																		{ 20150110, 36.7710080566436, 0, 0, 0, 0, 0, 0 },
																		{ 20150109, 34.8744425194619, 0, 0, 0, 0, 0, 0 },
																		{ 20150108, 26.8388291223226, 0, 0, 0, 0, 0, 0 },
																		{ 20150107, 50.500369330017, 0, 0, 0, 0, 0, 0 },
																		{ 20150106, 44.9465344376015, 0, 0, 0, 0, 0, 0 },
																		{ 20150105, 32.7645650021494, 0, 0, 0, 0, 0, 0 },
																		{ 20150104, 30.8642050926896, 0, 0, 0, 0, 0, 0 },
																		{ 20150103, 38.58333656567, 0, 0, 0, 0, 0, 0 },
																		{ 20150102, 37.2918247357558, 0, 0, 0, 0, 0, 0 },
																		{ 20150101, 45.4168497181485, 0, 0, 0, 0, 0, 0 },
																		{ 20141231, 48.2677749123132, 0, 0, 0, 0, 0, 0 },
																		{ 20141230, 32.9026416593816, 0, 0, 0, 0, 0, 0 },
																		{ 20141229, 50.2044467639318, 0, 0, 0, 0, 0, 0 },
																		{ 20141228, 38.3658537874368, 0, 0, 0, 0, 0, 0 },
																		{ 20141227, 58.0493405189423, 0, 0, 0, 0, 0, 0 },
																		{ 20141226, 40.1296170042658, 0, 0, 0, 0, 0, 0 },
																		{ 20141225, 46.3161021317895, 0, 0, 0, 0, 0, 0 },
																		{ 20141224, 33.5412351438375, 0, 0, 0, 0, 0, 0 },
																		{ 20141223, 33.9595451835081, 0, 0, 0, 0, 0, 0 },
																		{ 20141222, 47.8233179265153, 0, 0, 0, 0, 0, 0 },
																		{ 20141221, 37.8259321218336, 0, 0, 0, 0, 0, 0 },
																		{ 20141220, 43.6409852763295, 0, 0, 0, 0, 0, 0 },
																		{ 20141219, 29.8659141671646, 0, 0, 0, 0, 0, 0 },
																		{ 20141218, 40.8000939092877, 0, 0, 0, 0, 0, 0 },
																		{ 20141217, 36.2766712857789, 0, 0, 0, 0, 0, 0 },
																		{ 20141216, 48.834325059138, 0, 0, 0, 0, 0, 0 },
																		{ 20141215, 53.8137434035138, 0, 0, 0, 0, 0, 0 },
																		{ 20141214, 41.8377440474474, 0, 0, 0, 0, 0, 0 },
																		{ 20141213, 26.4982295778543, 0, 0, 0, 0, 0, 0 },
																		{ 20141212, 46.5810371213992, 0, 0, 0, 0, 0, 0 },
																		{ 20141211, 46.2073683139532, 0, 0, 0, 0, 0, 0 },
																		{ 20141210, 35.856167625189, 0, 0, 0, 0, 0, 0 },
																		{ 20141209, 43.2133809682687, 0, 0, 0, 0, 0, 0 },
																		{ 20141208, 29.9025744623116, 0, 0, 0, 0, 0, 0 },
																		{ 20141207, 44.4853574576519, 0, 0, 0, 0, 0, 0 },
																		{ 20141206, 25.0154544206045, 0, 0, 0, 0, 0, 0 },
																		{ 20141205, 34.7071755267975, 0, 0, 0, 0, 0, 0 },
																		{ 20141204, 32.2715363666695, 0, 0, 0, 0, 0, 0 },
																		{ 20141203, 50.2353168149876, 0, 0, 0, 0, 0, 0 },
																		{ 20141202, 42.1450548672154, 0, 0, 0, 0, 0, 0 },
																		{ 20141201, 29.1256965654156, 0, 0, 0, 0, 0, 0 },
																		{ 20141130, 13.7709910188575, 0, 0, 0, 0, 0, 0 },
																		{ 20141129, 47.4335702358987, 0, 0, 0, 0, 0, 0 },
																		{ 20141128, 42.8324762933357, 0, 0, 0, 0, 0, 0 },
																		{ 20141127, 45.4204763018584, 0, 0, 0, 0, 0, 0 },
																		{ 20141126, 38.2961299692967, 0, 0, 0, 0, 0, 0 },
																		{ 20141125, 43.8201614068654, 0, 0, 0, 0, 0, 0 },
																		{ 20141124, 42.8395413829951, 0, 0, 0, 0, 0, 0 },
																		{ 20141123, 43.8575709256947, 0, 0, 0, 0, 0, 0 },
																		{ 20141122, 42.2283924429625, 0, 0, 0, 0, 0, 0 },
																		{ 20141121, 27.521622337399, 0, 0, 0, 0, 0, 0 },
																		{ 20141120, 35.3936702280541, 0, 0, 0, 0, 0, 0 },
																		{ 20141119, 44.8275722220825, 0, 0, 0, 0, 0, 0 },
																		{ 20141118, 26.3602877001487, 0, 0, 0, 0, 0, 0 },
																		{ 20141117, 42.6120040164109, 0, 0, 0, 0, 0, 0 },
																		{ 20141116, 46.3723202307751, 0, 0, 0, 0, 0, 0 },
																		{ 20141115, 33.7734052251742, 0, 0, 0, 0, 0, 0 },
																		{ 20141114, 19.5671080201722, 0, 0, 0, 0, 0, 0 },
																		{ 20141113, 34.7464057605012, 0, 0, 0, 0, 0, 0 },
																		{ 20141112, 35.9087345638572, 0, 0, 0, 0, 0, 0 },
																		{ 20141111, 43.3259031721875, 0, 0, 0, 0, 0, 0 },
																		{ 20141110, 44.7923027917821, 0, 0, 0, 0, 0, 0 },
																		{ 20141109, 53.5337362667837, 0, 0, 0, 0, 0, 0 },
																		{ 20141108, 46.4489563353918, 0, 0, 0, 0, 0, 0 },
																		{ 20141107, 28.9944117793251, 0, 0, 0, 0, 0, 0 },
																		{ 20141106, 30.3036192405186, 0, 0, 0, 0, 0, 0 },
																		{ 20141105, 33.8903633651848, 0, 0, 0, 0, 0, 0 },
																		{ 20141104, 55.7567416547993, 0, 0, 0, 0, 0, 0 },
																		{ 20141103, 31.9096942380273, 0, 0, 0, 0, 0, 0 },
																		{ 20141102, 39.9546412860773, 0, 0, 0, 0, 0, 0 },
																		{ 20141101, 48.6377284927797, 0, 0, 0, 0, 0, 0 },
																		{ 20141031, 42.3118894188741, 0, 0, 0, 0, 0, 0 },
																		{ 20141030, 32.6184105056121, 0, 0, 0, 0, 0, 0 },
																		{ 20141029, 27.3103509508018, 0, 0, 0, 0, 0, 0 },
																		{ 20141028, 19.546091000574, 0, 0, 0, 0, 0, 0 },
																		{ 20141027, 31.9687837349448, 0, 0, 0, 0, 0, 0 },
																		{ 20141026, 26.5679999577069, 0, 0, 0, 0, 0, 0 },
																		{ 20141025, 42.1176962059814, 0, 0, 0, 0, 0, 0 },
																		{ 20141024, 45.0383092039807, 0, 0, 0, 0, 0, 0 },
																		{ 20141023, 53.6035234571027, 0, 0, 0, 0, 0, 0 },
																		{ 20141022, 34.0032942569563, 0, 0, 0, 0, 0, 0 },
																		{ 20141021, 37.1307530219059, 0, 0, 0, 0, 0, 0 },
																		{ 20141020, 47.13166364449, 0, 0, 0, 0, 0, 0 },
																		{ 20141019, 36.0116833945764, 0, 0, 0, 0, 0, 0 },
																		{ 20141018, 19.8320470751537, 0, 0, 0, 0, 0, 0 },
																		{ 20141017, 28.0475959767785, 0, 0, 0, 0, 0, 0 },
																		{ 20141016, 22.8121711471004, 0, 0, 0, 0, 0, 0 },
																		{ 20141015, 36.7544450245738, 0, 0, 0, 0, 0, 0 },
																		{ 20141014, 22.2319133797553, 0, 0, 0, 0, 0, 0 },
																		{ 20141013, 25.2504455860132, 0, 0, 0, 0, 0, 0 },
																		{ 20141012, 39.4829463832998, 0, 0, 0, 0, 0, 0 },
																		{ 20141011, 40.7927866718939, 0, 0, 0, 0, 0, 0 },
																		{ 20141010, 27.0003637724863, 0, 0, 0, 0, 0, 0 },
																		{ 20141009, 50.6898694999942, 0, 0, 0, 0, 0, 0 },
																		{ 20141008, 28.9541271834654, 0, 0, 0, 0, 0, 0 }
																		], metrics_lay);

		ds_input_test_stats := dataset( 	[	
																		{'proppurchasedcount60', ds_input_metrics_1},
																		{'testattribute_2', ds_input_metrics_2},
																		{'prsearchcount', ds_input_metrics_3}
																		], input_lay);
																		
		output(choosen( ds_input_test_stats, eyeball), named('input_data'));
*/