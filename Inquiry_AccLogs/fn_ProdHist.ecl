import ut;

export fn_prodhist() := module

		export file := if(thorlib.cluster() in ['thor10_11','thor20_11','thor100_21'] or thorlib.daliServers() = '10.173.11.12:7070',
										project(dataset('~thor100_21::out::inquiry_tracking::weekly_historical',{inquiry_acclogs.Layout.Common, string source},thor),inquiry_acclogs.Layout.Common_ThorAdditions),
										project(dataset(ut.foreign_prod + 'thor_data400::out::inquiry_tracking::weekly_historical',{inquiry_acclogs.Layout.Common, string source},thor),inquiry_acclogs.Layout.Common_ThorAdditions)
										);


				start_filename 					:= nothor(stringlib.stringfind(fileservices.superfilecontents(ut.foreign_logs + 'thor100_21::out::inquiry_tracking::weekly_historical')[1].name, '::',3));
				foreign_filename 				:= nothor(fileservices.superfilecontents(ut.foreign_logs + 'thor100_21::out::inquiry_tracking::weekly_historical')[1].name);
				foreign_filename_suffix := foreign_filename[start_filename+2..];

		export prod_filename := 'thor_data400::' + foreign_filename_suffix;

		prod_super_contents :=  nothor(fileservices.superfilecontents(ut.foreign_prod + '~thor_data400::out::inquiry_tracking::weekly_historical')[1].name);

		export is_new_logs_historical_on_prod := stringlib.stringfind(prod_super_contents, prod_filename,1) > 0;

		export buildfile := function
		
					Blank_IDs(infile, outfile) := macro 

						outfile := project(infile,
												transform({recordof(infile)}, 
														fixTime := Inquiry_AccLogs.fncleanfunctions.tTimeAdded(left.search_info.datetime);
												self.search_info.datetime		:= fixTime;
												self.search_info.function_description	:= Inquiry_AccLogs.fncleanfunctions.fnCleanUp(left.search_info.function_description);
												self.mbs.company_id 				:= '';
												self.mbs.global_company_id 	:= '';
												self.source 	:= left.source;
												self := left));
											
					endmacro;

				Previous_MBS := distribute(dataset(ut.foreign_logs + 'thor100_21::out::inquiry_tracking::weekly_historical', 
																						{recordof(File_Inquiry_MBS)}, thor)
																						(bus_intel.Vertical not in inquiry_acclogs.FnCleanFunctions.FilterCds and	
																						 bus_intel.Industry not in inquiry_acclogs.FnCleanFunctions.Industry_FilterCds and	
																						 ~inquiry_acclogs.FnTranslations.is_Disable_Observation(allow_flags.allowflags) and
																						 ~inquiry_acclogs.FnTranslations.is_Internal(allow_flags.allowflags)),
																		hash(search_info.transaction_id,
																			   search_info.login_history_id,
																				 search_info.datetime,
																				 search_info.sequence_number,
																				 search_info.function_description))
																				 ;
																									
				Blank_IDs(Previous_MBS, Previous_MBS_Blanked)
				
				keeplist := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
				
				Correct_Function_Descriptions := 
						join(Previous_MBS_Blanked, dedup(File_Function_Description_Rollups,rollup_string,all),
									right.rollup_string = stringlib.stringfilter(left.search_info.function_description, keeplist),
									transform({recordof(Previous_MBS_Blanked)},
										self.search_info.function_description := if(right.rollup_string <> '', right.selected_version, left.search_info.function_description);
										self := left), lookup, left outer);
										
				srtHistory := dedup(sort(Correct_Function_Descriptions, 
															person_q.lname, person_q.fname, search_info.product_code, search_info.transaction_type, search_info.transaction_id, search_info.login_history_id, search_info.datetime, search_info.sequence_number, search_info.function_description, local),
															person_q.lname, person_q.fname, search_info.product_code, search_info.transaction_type, search_info.transaction_id, search_info.login_history_id, search_info.datetime, search_info.sequence_number, search_info.function_description, local);
				
				build_prev_mbs := if(~is_new_logs_historical_on_prod,
									sequential(
									output(srtHistory,, '~'+prod_filename, overwrite, __compressed__),
									nothor(fileservices.promotesuperfilelist(['~thor_data400::out::inquiry_tracking::weekly_historical',
																										 '~thor_data400::out::inquiry_tracking::weekly_historical_father'],
																										 '~'+prod_filename, true))
									));

				return build_prev_mbs;

		end;
		
		// export reAppendFile := if(~is_new_logs_historical_on_prod, inquiry_acclogs.fnMapBaseAppends(file).buildFile);
		
end;