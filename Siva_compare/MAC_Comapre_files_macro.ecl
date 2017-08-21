EXPORT MAC_Comapre_files_macro (inputFile,outputfile, no_of_keys, primary_list, key1, key2, key3 ) := functionmacro


 import ut;
 
 siva_compare.MAC_compare_files (inputFile, file3_dis, 1, primary_list);

 siva_compare.MAC_compare_files (outputfile, file4_dis, 2, primary_list);
 
 
  // output(file3,, '~pview::compare::file3', overwrite);                                                                  
 
 
  // output(file4,, '~pview::compare::file4', overwrite); 

file3  := distribute(file3_dis, hash(pid));
file4  := distribute(file4_dis, hash(pid));
	
		
	 diff_files_0 := join( file3, file4,
	 #if ( (integer) no_of_keys = 1 )
											(qstring) left.key1 = (qstring) right.key1 and
											
											
	 #elseif ( (integer) no_of_keys = 3 )
											 (qstring) left.key1 = (qstring) right.key1 and											 
											 (qstring) left.key2 = (qstring) right.key2 and
											 (qstring) left.key3 = (qstring) right.key3 and
	 #elseif ( (integer) no_of_keys = 2 )
											 (qstring) left.key1 = (qstring) right.key1 and						 
		                   (qstring) left.key2 = (qstring) right.key2 and 
	 #end											
								
											 left.hash_combine <> right.hash_combine , local ) ;


  // output(diff_files_0, named ('diff_files_0'));
	
	  // output(diff_files_0(AccountNumber = '110786U136078'));

	
	
	
			diff_count := count(diff_files_0);

			// diff_Count = 0 -- files are same 

			total_files_0 := file3 + file4;
			
			// output(total_files_0(AccountNumber = '110786U136078'));

			total_files := project (total_files_0, transform( {recordof(total_files_0) - hash_combine}, self := left));
			
			// output(total_files (AccountNumber = '110786U136078') , named ('total_files'));
			

			// diff_files := table(diff_files_0,  { operatorid, sequencenum, textLineSeq} );

      diff_files := project (diff_files_0, transform( {recordof(diff_files_0) - hash_combine}, self := left));

      // output(diff_files, named ('diff_files'));
			
			prob_records_0 := join(total_files, diff_files,
			
	 #if ( (integer) no_of_keys = 1 )
											(qstring) left.key1 = (qstring) right.key1, local  );
											
											
	 #elseif ( (integer) no_of_keys = 3 )
	                     (qstring) left.key1 = (qstring) right.key1  and		 
											 (qstring) left.key2 = (qstring) right.key2   and
											 (qstring) left.key3 = (qstring) right.key3 , local );
	 #elseif ( (integer) no_of_keys = 2 )
                       (qstring) left.key1 = (qstring) right.key1  and		                   
											 (qstring) left.key2 = (qstring) right.key2, local );
	 #end									
             					// (qstring) left.key1 = (qstring) right.key1 and
											// (qstring) left.key2 = (qstring) right.key2 and
											// (qstring) left.key3 = (qstring) right.key3 );
										
	    //output(prob_records , named ('problem_records'));
			
			prob_records := distribute(prob_records_0, hash(key1));
			
			res1 := output(prob_records,,'~pview::compare::mcr', overwrite);
			
				siva_compare.MAC_compare_file_columns(prob_records, file5, no_of_keys, primary_list, key1,  key2,  key3);

			// output(file5);


			siva_compare.MAC_compare_file_text(file5,  file6 , primary_list);

			// output(file6);


			final_result_0 := join(total_files, file6,
																													// (qstring) left.key1 = (qstring) right.key1 and
																													// (qstring) left.key2 = (qstring) right.key2 and
																													// (qstring) left.key3 = (qstring) right.key3 );
											
			 #if ( (integer) no_of_keys = 1 )
													(qstring) left.key1 = (qstring) right.key1, local );
													
													
			 #elseif ( (integer) no_of_keys = 3 )
													 (qstring) left.key1 = (qstring) right.key1  and		 
													 (qstring) left.key2 = (qstring) right.key2  and
													 (qstring) left.key3 = (qstring) right.key3, local );
			 #elseif ( (integer) no_of_keys = 2 )
													 (qstring) left.key1 = (qstring) right.key1  and		                    
													 (qstring) left.key2 = (qstring) right.key2, local );
			 #end														
													
					 output(	count(final_result_0), named('counts_where_files_differ'));
					 
			 
			 
      final_result_1	:=  project( final_result_0, transform({recordof(final_result_0) },
						                  self.text_string := TRIM(StringLib.StringCleanSpaces(left.text_string));
											        self := left));
															
      final_result	:=  project( final_result_1, transform({recordof(final_result_1) },															
												self.text_string := if( left.text_string[1] in [','], left.text_string[2 .. length(left.text_string) - 1],  left.text_string);
			                  self := left));
												
			 
						 //group by text_string
			grp_rec := record


			cnt_grp := count(group);
			trim(final_result.text_string);


			end;

			 
			 
			 group_result := table(final_result, grp_rec, text_string);
			 
			//output(sort(group_result, cnt_grp ), named ('aggregate_report'));
			
			res2 := output( final_result, ,'~pview::compare::' + ut.getdate, overwrite);
													
		return sequential(res1,res2);				
		
	endmacro;

