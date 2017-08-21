EXPORT MAC_Compare_files_macro_new (inputFile,outputfile, no_of_keys, primary_list, first_key,  second_key,  third_key, compare_file_name, pview_file_name  ) := functionmacro


 import ut;
 
 
 // output (primary_list);
 
 siva_compare.MAC_compare_files (inputFile,  file3_dis, 1, primary_list );


  // output(file3_dis, named ('file3_dis'));
	
 siva_compare.MAC_compare_files (outputfile, file4_dis, 2, primary_list );
 
  // output(file4_dis, named ('file4_dis'));
 
// these files have only keys, hash combine , flag data 
// we are trying to identify where hash)combine is different 

		file3  := distribute(file3_dis, hash(key1));
		file4  := distribute(file4_dis, hash(key1));
			
		
	   diff_files_0 := join( file3, file4,
	                     left.key1 = right.key1 and	
											 left.key2 = right.key2 and
											 left.key3 = right.key3 and
											 left.hash_combine <> right.hash_combine , local ) ;



	   output(diff_files_0,, compare_file_name, overwrite);
	
	
			diff_count := count(diff_files_0);

			output(diff_count);

      return 
			if (  diff_count = 0 , 
			siva_compare.MAC_compare_files_no_diff (),
			siva_compare.MAC_compare_files_diff ( diff_files_0, inputFile, outputfile, no_of_keys, primary_list, first_key,  second_key,  third_key , pview_file_name)
			 );
			
 
	endmacro;

