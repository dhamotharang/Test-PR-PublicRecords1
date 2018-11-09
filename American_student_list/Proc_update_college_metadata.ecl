//This ECL attribute performs following tasks -
//   - spray the new master college database (csv file)
//   - add the sprayed file to super file thor_data400::in::american_student_list::master_college_db
//   - add a leading 0 to act_code and create the new lookup file thor_data400::lookup::american_student_list::date::college_metadata
//   - add the new lookup file to super file thor_data400::lookup::lookup::american_student_list::college_metadata
IMPORT Lib_FileServices, _Control/*, lib_stringlib*/;

EXPORT Proc_update_college_metadata(STRING iFileName) := FUNCTION

	//spray new file
	todaydate		:= thorlib.wuid()[2..9];
	in_dest			:= American_student_list.thor_cluster + 'in::american_student_list::';
	asl_super		:= in_dest + 'master_college_db';
	//modified for prod
	current_lookup := American_student_list.thor_cluster + 'lookup::american_student_list::college_metadata_backup20130621';
	out_dest			 := American_student_list.thor_cluster + 'lookup::american_student_list::'+todaydate+'::college_metadata';
	out_dest_super := American_student_list.thor_cluster + 'lookup::american_student_list::college_metadata';
	
	spray_file  := FileServices.SprayVariable(_Control.IPAddress.bctlpedata11,
																						'/data/data_build_1/american_student/missing_colleges/'+iFileName, 
																						8192,
																						',',
																						'\r\n',
																						'',
																						'thor400_44', 
																						in_dest+todaydate+'::master_college_db',
																						,
																						,
																						,
																						TRUE,
																						,
																						FALSE);
	//Add new file to the master_college_db super file
	add_to_super:= 	sequential(fileservices.startsuperfiletransaction(),
													//fileservices.CreateSuperFile(asl_super);
													fileservices.ClearSuperFile(asl_super);
													fileservices.addsuperfile(asl_super, 
																										in_dest+todaydate+'::master_college_db'),
													fileservices.finishsuperfiletransaction()
													);

	//New input file
	ds_new_lookup	:= 	dataset(asl_super, American_student_list.layout_college_metadata_lkp, csv(heading(1), 
														separator(','),
														quote('"'),
														terminator(['\r\n','\r','\n'])));

	//Existing lookup table
	ds_current_lookup := dataset(current_lookup, 
	                       American_student_list.layout_college_metadata_lkp,
												 csv(heading(1), separator(','),quote('"'),	terminator(['\r\n','\r','\n'])));

	//act_code provided by vendor is a 4 digit code, however it is 5 digit in our current lookup table.
	//Lookup the alloy_matchkey in the existing lookup table, if it is the same as the the act code with a leading 0,
	//add a leading 0 to the act_code.
	American_student_list.layout_college_metadata_lkp xFormLookup(American_student_list.layout_college_metadata_lkp L, 
																																American_student_list.layout_college_metadata_lkp R) := TRANSFORM
		
		SELF.act_code := IF('0'+L.act_code=R.act_code,R.act_code,L.act_code);
		SELF := L;
		
	END;

	lookup_table := join(ds_new_lookup,ds_current_lookup,
	                     LEFT.alloy_matchkey=RIGHT.alloy_matchkey AND right.act_code<>'',
											 xFormLookup(LEFT,RIGHT),LEFT OUTER,LOOKUP);

	d_final := output(lookup_table,, out_dest,/* __compressed__,*/ overwrite);

	add_super := sequential(fileservices.startsuperfiletransaction(),
													//fileservices.CreateSuperFile(out_dest_super);
													fileservices.ClearSuperFile(out_dest_super);
													fileservices.addsuperfile(out_dest_super, out_dest),
													fileservices.finishsuperfiletransaction()
													);

	RETURN SEQUENTIAL(spray_file,add_to_super,d_final,add_super);
																					
END;