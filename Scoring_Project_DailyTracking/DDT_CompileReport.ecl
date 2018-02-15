import ut;

// outrec_lay := record
	// string datasetname;
	// string envment;
	// string location;
	// string cluster;
	// string buildversion;
	// string keycount;
	// string releasedate;
// end;

outrec := record
			Scoring_Project_DailyTracking.Attributes.ddt_layout;
end;

outrec_2 := record
			outrec;
			string other_version;
			string other_date;
end;

// Dataset with data
// environment = 'P' or 'Q'
// location [optional] = 'B' or 'Q' or '' or '*'
// cluster [optional] = 'N' or 'F' or '' or '*' or 'S' - Customer Support or 'FS' - FCRA Customer Support or 'T' - Customer Test
// date deployed = <blank> if previous day, else a date can be input.  Note that a dataset will not return if it has been redeployed on a subsequent date

EXPORT DDT_CompileReport( dataset(outrec) ddt_set, string env, string loc, string clus, string histdt) := function
		
		yesterday := ut.date_math(ut.getdate, -1);
		
		environment_name := 	map(	env = 'P' 		=>		'Prod',
																env = 'Q'			=>		'Cert',
																										'Unknown');
		other_envment_name := map(	env = 'P' 		=>		'Cert',
																env = 'Q'			=>		'Prod',
																										'Unknown');
		
		cluster_name 		:= 	map(		clus = 'F' 		=>		'FCRA',
																clus = 'N'		=>		'NonFCRA',
																										'Unknown');
		date_name				:=	map(	histdt = '' 		=> 	yesterday,
															histdt = 'all'	=>	'all current datasets',
																									histdt);
		
		date_form(string rel_date) := function
				a := Stringlib.StringFind(rel_date, '/', 1);
				b := Stringlib.StringFind(rel_date, '/', 2);
				c := b + 4;
				mo := intformat((integer)rel_date[1..(a-1)], 2, 1);
				dom := intformat((integer)rel_date[(a+1)..(b-1)], 2, 1);
				yr := intformat((integer)rel_date[(b+1)..c], 4, 1);
				return yr + mo + dom;
		end;
		
		// filter the dataset according to the input parameters
		temp_set := map(		histdt = '' 		=> 	ddt_set(envment = env and location = loc and cluster = clus and date_form(releasedate) = yesterday),
												histdt = 'all'	=>	ddt_set(envment = env and location = loc and cluster = clus),
																						ddt_set(envment = env and location = loc and cluster = clus and date_form(releasedate) = histdt));
		
		opposite_set := join(	temp_set, ddt_set, 	left.datasetname = right.datasetname
																							and left.envment <> right.envment
																							and left.cluster = right.cluster,
																							transform(	outrec_2,	
																													self.other_version := right.buildversion;
																													self.other_date := right.releasedate;
																													self := left; ) );
		
		// generate the report
		MyRec := RECORD
			INTEGER order;
			STRING line;
		END;
		
		ds_no_data := DATASET([{2, 'No data deployed on the given date'}], MyRec);
		STRING filler := '                                                                                                                    ';
		
		// result_set := if(count(temp_set) > 0,
											// project(opposite_set, 
												// transform(MyRec, 
													// self.order := 2;
													// self.line :=	(left.datasetname + filler)[1..35] + 
																				// (left.buildversion + filler)[1..25] + 
																				// (left.releasedate + filler)[1..35] +
																				// (left.other_version + filler)[1..25] +
																				// (left.other_date + filler)[1..35];
																				// ) ),
											// ds_no_data);
		
		// line_heading := ('Dataset Name' + filler)[1..35] + 
										// (trim(environment_name, right) + ' Build Version' + filler)[1..25] + 
										// (trim(environment_name, right) + ' Release Date' + filler)[1..35] + 
										// (trim(other_envment_name, right) + ' Build Version' + filler)[1..25] +
										// (trim(other_envment_name, right) + ' Release Date' + filler)[1..35];

		result_set := if(count(temp_set) > 0,
											project(opposite_set, 
												transform(MyRec, 
													self.order := 2;
													self.line :=	(left.datasetname + filler)[1..25] + 
																				(left.buildversion + filler)[1..20] + 
																				(left.releasedate + filler)[1..28] +
																				(left.other_version + filler)[1..20] +
																				(left.other_date + filler)[1..28];
																				) ),
											ds_no_data);
											
		line_heading := ('Dataset' + filler)[1..25] + 
										(trim(environment_name, right) + filler)[1..20] + 
										(trim(environment_name, right) + filler)[1..28] + 
										(trim(other_envment_name, right) + filler)[1..20] +
										(trim(other_envment_name, right) + filler)[1..28] +
										'\n' +
										('Name' + filler)[1..25] + 
										('Build Version' + filler)[1..20] + 
										('Release Date' + filler)[1..28] + 
										('Build Version' + filler)[1..20] + 
										('Release Date' + filler)[1..28];

		// main_head := DATASET([{1,   'Data Deployment Tracking Report' + '\n'
													// + '*** This report is produced by Scoring QA. Please send comments to Nathan Koubsky ***' + '\n\n'
													// }], MyRec); 		
			
		detailed_head := DATASET([{1,    
														'Environment:  '	+ environment_name + '\n'
													+ 'Cluster:  ' + cluster_name + '\n'
													+ 'Data Date:  ' + date_name + '\n\n'
													+ line_heading + '\n'
													// + '--------------------------------------------------------------------------------------------------------------------------------------------'
													+ '-----------------------------------------------------------------------------------------------------------------'
													}], MyRec); 
													

		spacer := DATASET([{3,    
														'\n' 
													+ '\n'  
													}], MyRec);
		
		// spacer2 := PROJECT(spacer, TRANSFORM(MyRec, SELF.order := 5; SELF := LEFT));
		// spacer3 := PROJECT(spacer, TRANSFORM(MyRec, SELF.order := 7; SELF := LEFT));

		output_data := PROJECT(SORT(detailed_head + result_set, order), TRANSFORM(MyRec, SELF.order := 2; SELF := LEFT));

		// output_append := main_head + output_data + spacer;
		output_append := output_data + spacer;
		output_full := SORT(output_append, order);
		// OUTPUT(output_full, NAMED('output_full'));

		MyRec Xform(myrec L,myrec R) := TRANSFORM
				SELF.line := TRIM(L.line, LEFT) + '\n' + TRIM(R.line, LEFT); 
				self := L;
		END;

		XtabOut := ITERATE(output_full, Xform(LEFT, RIGHT));
  	// OUTPUT(XtabOut, NAMED('XtabOut'));

		return XtabOut[COUNT(XtabOut)].line;

end;