EXPORT MAC_compare_files_diff (diff_files_0, inputFile,outputfile, no_of_keys, primary_list, first_key,  second_key,  third_key, pview_file_name ) := functionmacro


      inputFile_0   := distribute(inputFile,  hash(first_key));	
			outputfile_0  := distribute(outputfile, hash(first_key));
			


      diff_files := project (diff_files_0, transform( {recordof(diff_files_0) - hash_combine}, self := left));

      // output(diff_files, named ('diff_files'));
			

			
			prob_records_0 := join(inputFile_0, diff_files,
			
			 #if ( (integer) no_of_keys = 1 )
													(qstring) left.first_key = right.key1, 
													transform({ integer1 flag_data, recordof(inputFile_0)  },
								                    self.flag_data := 1 ,
													          self := left),
													 local  );
													
													
			 #elseif ( (integer) no_of_keys = 3 )
													(qstring) left.first_key =  right.key1 and
													(qstring) left.second_key = right.key2 and
													(qstring) left.third_key =  right.key3,
													transform({ integer1 flag_data, recordof(inputFile_0)  },
								                    self.flag_data := 1 ,
													          self := left), 
													, local );
			 #elseif ( (integer) no_of_keys = 2 )
												 	(qstring) left.first_key = right.key1 and 
													(qstring) left.second_key = right.key2,
													transform({ integer1 flag_data, recordof(inputFile_0)  },
								                    self.flag_data := 1 ,
													          self := left),
																	 local );
			 #end									
             			
									
	   prob_records_1 := join(outputfile_0, diff_files,
			
			 #if ( (integer) no_of_keys = 1 )
													(qstring) left.first_key = right.key1, 
													transform({ integer1 flag_data, recordof(inputFile_0)  },
								                    self.flag_data := 2 ,
													          self := left),
													 local  );
													
													
			 #elseif ( (integer) no_of_keys = 3 )
													(qstring) left.first_key =  right.key1, 
													(qstring) left.second_key = right.key2,
													(qstring) left.third_key =  right.key3,
													transform({ integer1 flag_data, recordof(inputFile_0)  },
								                    self.flag_data := 2 ,
													          self := left), 
													, local );
			 #elseif ( (integer) no_of_keys = 2 )
												 	(qstring) left.first_key = right.key1 and
													(qstring) left.second_key = right.key2,
													transform({ integer1 flag_data, recordof(inputFile_0)  },
								                    self.flag_data := 2 ,
													          self := left)
																	, local );
			 #end									
									
		  prob_records := prob_records_0 + prob_records_1;
			
			// res1 := output(prob_records_0,,'~pview::compare::mcr_1st', Thor, overwrite, compressed );
			res1 := output(prob_records_0,,pview_file_name + '_1st', Thor, overwrite, compressed );
			
			res3 := output(prob_records_1,,pview_file_name + '_2nd', Thor, overwrite, compressed );
			
			
			siva_compare.MAC_compare_file_columns_new(prob_records_0, prob_records_1,  file5, no_of_keys, primary_list, first_key,  second_key,  third_key);

			// output(file5);


			siva_compare.MAC_compare_file_text(file5,  file6 , primary_list);

			// output(file6);


      prob_records_hash := distribute(prob_records, hash(first_key));
			file6_hash        := distribute(file6, hash(first_key));

			final_result_0 := join(prob_records_hash, file6_hash,
																													// (qstring) left.key1 = (qstring) right.key1 and
																													// (qstring) left.key2 = (qstring) right.key2 and
																													// (qstring) left.key3 = (qstring) right.key3 );
											
			 #if ( (integer) no_of_keys = 1 )
													 (qstring) left.first_key = (qstring) right.first_key, local );
													
													
			 #elseif ( (integer) no_of_keys = 3 )
													 (qstring) left.first_key = (qstring) right.first_key  and		 
													 (qstring) left.second_key = (qstring) right.second_key  and
													 (qstring) left.third_key = (qstring) right.third_key, local );
			 #elseif ( (integer) no_of_keys = 2 )
													 (qstring) left.first_key = (qstring) right.first_key  and		                    
													 (qstring) left.second_key = (qstring) right.second_key, local );
			 #end														
													
			output(	count(final_result_0), named('counts_where_files_differ'));
					 
			 
			 
      final_result_1	:=  project( final_result_0, transform({recordof(final_result_0) },
						                  self.text_string := TRIM(StringLib.StringCleanSpaces(left.text_string));
											        self := left));
															
      final_result_2	:=  project( final_result_1, transform({recordof(final_result_1) },															
												self.text_string := if( left.text_string[1] in [','], left.text_string[2 .. length(left.text_string) - 1],  left.text_string);
			                  self := left));
												
			 
						 //group by text_string
			
			final_result := distribute(final_result_2, hash(text_string));
			
			grp_rec := record


			cnt_grp := count(group);
			trim(final_result.text_string);


			end;

			 
			 
			 group_result := table(final_result, grp_rec, text_string);
			 
			output(sort(group_result, cnt_grp ), named ('aggregate_report'));
			
			res2 := output( final_result, ,'~pview::compare::' +  workunit + '_' + ut.getdate, overwrite);
													

			
		return sequential(res1,res3, res2 );				
		
endmacro;		