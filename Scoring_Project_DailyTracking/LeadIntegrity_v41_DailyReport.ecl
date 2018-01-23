EXPORT LeadIntegrity_v41_DailyReport := FUNCTION

		IMPORT STD, ut,Scoring_Project_Macros,scoring_project_pip;
		
		//**** THRESHOLD ****************
		decimal19_2 thresh := 1.25;
		//*******************************

		curr_date := (INTEGER)ut.GetDate;
		// curr_date := 20150116;
		prev_date := (INTEGER)ut.date_math(ut.GetDate, -1); //Changed because it would break every 1st of the month the old way.
		// prev_date := 20150113;
		
		clean_prev_date := STD.Date.Month(prev_date) + '/' + STD.Date.Day(prev_date) + '/' + STD.Date.Year(prev_date);
		clean_curr_date := STD.Date.Month(curr_date) + '/' + STD.Date.Day(curr_date) + '/' + STD.Date.Year(curr_date);
		
		//************input and output file names***************	
		
     LI_Generic_msn1210_1_infile  :=  scoring_project_pip.Input_Sample_Names.LI_Generic_msn1210_1_infile;

     LI_Attributes_V4_BATCH_Generic_msn1106_0_outfile := scoring_project_pip.Output_Sample_Names.LI_Attributes_V4_BATCH_Generic_msn1106_0_outfile;
     LI_Attributes_V4_BATCH_Generic_msn1106_0_historydate_201207_outfile := scoring_project_pip.Output_Sample_Names.LI_Attributes_V4_BATCH_Generic_msn1106_0_historydate_201207_outfile;

     PROD_LI_Attributes_V4_BATCH_Generic_msn1106_0_outfile := scoring_project_pip.Output_Sample_Names.PROD_LI_Attributes_V4_BATCH_Generic_msn1106_0_outfile;
     PROD_LI_Attributes_V4_BATCH_Generic_msn1106_0_historydate_201207_outfile := scoring_project_pip.Output_Sample_Names.PROD_LI_Attributes_V4_BATCH_Generic_msn1106_0_historydate_201207_outfile;

     //******************************************************

		//*******CERT DATA*******************************************************************************//
		//Get the two most recently completed data collections for current and archive modes
		current_files_temp := nothor(STD.File.LogicalFileList(LI_Attributes_V4_BATCH_Generic_msn1106_0_outfile +'20*_1'));
		archive_files_temp := nothor(STD.File.LogicalFileList(LI_Attributes_V4_BATCH_Generic_msn1106_0_historydate_201207_outfile + '20*_1'));

		current_files := current_files_temp(Stringlib.StringFilterOut(modified[1..10], '-') <= (String)curr_date);
		archive_files := archive_files_temp(Stringlib.StringFilterOut(modified[1..10], '-') <= (String)curr_date);

		current_filelist := sort(current_files, -modified);
		archive_filelist := sort(archive_files, -modified);

		//auto_current := ut.foreign_dataland + current_filelist[1].name;
		auto_previous := current_filelist[2].name;
		//auto_current_archive := ut.foreign_dataland + archive_filelist[1].name;
		auto_previous_archive := archive_filelist[2].name;
		
		//auto_curr_date := current_filelist[1].modified[6..7] + '/' + current_filelist[1].modified[9..10] + '/' + current_filelist[1].modified[1..4];
		auto_prev_date := current_filelist[2].modified[6..7] + '/' + current_filelist[2].modified[9..10] + '/' + current_filelist[2].modified[1..4];
		//auto_arch_curr_date := archive_filelist[1].modified[6..7] + '/' + archive_filelist[1].modified[9..10] + '/' + archive_filelist[1].modified[1..4];
		auto_arch_prev_date := archive_filelist[2].modified[6..7] + '/' + archive_filelist[2].modified[9..10] + '/' + archive_filelist[2].modified[1..4];
	
		//if the right files exist take those, otherwise if current isn't there, the report will fail. If it is there it will try the previous date,
		//if not there then look for the second most recent data collection.
		

		infile_current := LI_Attributes_V4_BATCH_Generic_msn1106_0_outfile + curr_date + '_1';
		infile_previous := if(nothor(STD.File.FileExists(LI_Attributes_V4_BATCH_Generic_msn1106_0_outfile + prev_date + '_1')),
		                     LI_Attributes_V4_BATCH_Generic_msn1106_0_outfile + prev_date + '_1', auto_previous);
		infile_current_archive := LI_Attributes_V4_BATCH_Generic_msn1106_0_historydate_201207_outfile + curr_date + '_1'; 
		infile_previous_archive := if(nothor(STD.File.FileExists(LI_Attributes_V4_BATCH_Generic_msn1106_0_historydate_201207_outfile + prev_date + '_1')),
		                     LI_Attributes_V4_BATCH_Generic_msn1106_0_historydate_201207_outfile + prev_date + '_1', auto_previous_archive);

		//Get the correct date for the corresponding file
		// cleaned_current_date := if(nothor(STD.File.FileExists('~scoringqa::out::nonfcra::leadintegrity_batch_generic_attributes_v4_' + curr_date + '_1')), clean_curr_date, auto_curr_date);
		cleaned_curr_date := clean_curr_date;
		cleaned_prev_date := if(nothor(STD.File.FileExists(LI_Attributes_V4_BATCH_Generic_msn1106_0_outfile + prev_date + '_1')), clean_prev_date, auto_prev_date);
		// cleaned_curr_arch_date := if(nothor(STD.File.FileExists('~scoringqa::out::nonfcra::leadintegrity_batch_generic_attributes_v4_' + curr_date + '_historydate_201207')), clean_curr_date, auto_arch_curr_date);
		cleaned_curr_arch_date := clean_curr_date;
		cleaned_prev_arch_date := if(nothor(STD.File.FileExists(LI_Attributes_V4_BATCH_Generic_msn1106_0_historydate_201207_outfile + prev_date + '_1')), clean_prev_date, auto_arch_prev_date);
		
		//**********************************************************************************************//
		//*******PROD DATA******************************************************************************//

		//Get the two most recently completed prod data collections for current and archive modes
		current_prod_files_temp := nothor(STD.File.LogicalFileList('~ScoringQA::out::NONFCRA::PROD_leadintegrity_batch_generic_attributes_v4_*_1*'));
		archive_prod_files_temp := nothor(STD.File.LogicalFileList('~ScoringQA::out::NONFCRA::PROD_leadintegrity_batch_generic_attributes_v4*_historydate_201207_1*'));

		current_prod_files := current_prod_files_temp(Stringlib.StringFilterOut(modified[1..10], '-') <= (String)curr_date);
		archive_prod_files := archive_prod_files_temp(Stringlib.StringFilterOut(modified[1..10], '-') <= (String)curr_date);

		current_prod_filelist := sort(current_prod_files, -modified);
		archive_prod_filelist := sort(archive_prod_files, -modified);

		auto_prod_previous := current_prod_filelist[2].name;
		auto_prod_previous_archive := archive_prod_filelist[2].name;
		
		auto_prod_prev_date := current_prod_filelist[2].modified[6..7] + '/' + current_prod_filelist[2].modified[9..10] + '/' + current_prod_filelist[2].modified[1..4];
		auto_prod_arch_prev_date := archive_prod_filelist[2].modified[6..7] + '/' + archive_prod_filelist[2].modified[9..10] + '/' + archive_prod_filelist[2].modified[1..4]; 

		//Get the correct date for the corresponding file
		cleaned_prod_curr_date := clean_curr_date;
		cleaned_prod_prev_date := if(nothor(STD.File.FileExists('~scoringqa::out::nonfcra::prod_leadintegrity_batch_generic_attributes_v4_' + prev_date + '_1')), clean_prev_date, auto_prod_prev_date);
		cleaned_prod_curr_arch_date := clean_curr_date;
		cleaned_prod_prev_arch_date := if(nothor(STD.File.FileExists('~scoringqa::out::nonfcra::prod_leadintegrity_batch_generic_attributes_v4_' + prev_date + '_historydate_201207_1')), clean_prev_date, auto_prod_arch_prev_date);

		//Get the correct file names
		infile_current_prod := '~scoringqa::out::nonfcra::prod_leadintegrity_batch_generic_attributes_v4_' + curr_date + '_1';
		infile_previous_prod := if(nothor(STD.File.FileExists('~scoringqa::out::nonfcra::prod_leadintegrity_batch_generic_attributes_v4_' + prev_date + '_1')),
		                      '~scoringqa::out::nonfcra::prod_leadintegrity_batch_generic_attributes_v4_' + prev_date + '_1', auto_prod_previous);
		infile_current_archive_prod := '~scoringqa::out::nonfcra::prod_leadintegrity_batch_generic_attributes_v4_' + curr_date + '_historydate_201207_1';
		infile_previous_archive_prod := if(nothor(STD.File.FileExists('~scoringqa::out::nonfcra::prod_leadintegrity_batch_generic_attributes_v4_' + prev_date + '_historydate_201207_1')),
		                     '~scoringqa::out::nonfcra::prod_leadintegrity_batch_generic_attributes_v4_' + prev_date + '_historydate_201207_1', auto_prod_previous_archive);
		
		//**********************************************************************************************//
		
		ds_prev_orig := DATASET(infile_previous,Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_LeadIntegrity_Attributes_V4_Global_Layout, thor);// CSV(heading(2), quote('"')));
		ds_curr_orig := DATASET(infile_current, Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_LeadIntegrity_Attributes_V4_Global_Layout, thor);
		ds_prev_archive_orig := DATASET(infile_previous_archive,Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_LeadIntegrity_Attributes_V4_Global_Layout, thor);
		ds_curr_archive_orig := DATASET(infile_current_archive,Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_LeadIntegrity_Attributes_V4_Global_Layout, thor);

		ds_prev_prod_orig := DATASET(infile_previous_prod, Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_LeadIntegrity_Attributes_V4_Global_Layout, thor);
		ds_curr_prod_orig := DATASET(infile_current_prod, Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_LeadIntegrity_Attributes_V4_Global_Layout, thor);
		ds_prev_archive_prod_orig := DATASET(infile_previous_archive_prod, Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_LeadIntegrity_Attributes_V4_Global_Layout, thor);
		ds_curr_archive_prod_orig := DATASET(infile_current_archive_prod, Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_LeadIntegrity_Attributes_V4_Global_Layout, thor);

    //************ Filter out records with errors before compiling report ************************
	
		ds_prev := ds_prev_orig(length(trim(errorcode,left,right))= 0 );
		ds_curr :=ds_curr_orig(length(trim(errorcode,left,right))= 0 ); 
		ds_prev_archive :=ds_prev_archive_orig(length(trim(errorcode,left,right))= 0 );
		ds_curr_archive :=ds_curr_archive_orig(length(trim(errorcode,left,right))= 0 );

		ds_prev_prod :=ds_prev_prod_orig(length(trim(errorcode,left,right))= 0 );
		ds_curr_prod :=ds_curr_prod_orig(length(trim(errorcode,left,right))= 0 );
		ds_prev_archive_prod := ds_prev_archive_prod_orig(length(trim(errorcode,left,right))= 0 );
		ds_curr_archive_prod := ds_curr_archive_prod_orig(length(trim(errorcode,left,right))= 0 );

		//**********************************************************************************************
		
		// roxie error codes handling report code
		

file_count_function(string infile_name) := function

layout_input :=Record
                Scoring_Project_Macros.Regression.global_layout;
                Scoring_Project_Macros.Regression.pii_layout;
                Scoring_Project_Macros.Regression.runtime_layout;
                End;
							 
return count(dataset( infile_name,layout_input, thor));
                            
end;
		
input_file_count_ds_rec:=record
                         string file_name; 
	                       decimal19_2 input_file_count;
                         end;

input_file_count_ds:=DATASET([ 
													     {LI_Attributes_V4_BATCH_Generic_msn1106_0_outfile + curr_date,file_count_function(LI_Generic_msn1210_1_infile)}, 
												       {LI_Attributes_V4_BATCH_Generic_msn1106_0_historydate_201207_outfile + curr_date,file_count_function(LI_Generic_msn1210_1_infile)},
															 {PROD_LI_Attributes_V4_BATCH_Generic_msn1106_0_outfile + curr_date,file_count_function(LI_Generic_msn1210_1_infile)}, 
												       {PROD_LI_Attributes_V4_BATCH_Generic_msn1106_0_historydate_201207_outfile+ curr_date,file_count_function(LI_Generic_msn1210_1_infile)},
												       {LI_Attributes_V4_BATCH_Generic_msn1106_0_outfile + prev_date,file_count_function(LI_Generic_msn1210_1_infile)}, 
												       {LI_Attributes_V4_BATCH_Generic_msn1106_0_historydate_201207_outfile + prev_date,file_count_function(LI_Generic_msn1210_1_infile)},
															 {PROD_LI_Attributes_V4_BATCH_Generic_msn1106_0_outfile + prev_date,file_count_function(LI_Generic_msn1210_1_infile)}, 
												       {PROD_LI_Attributes_V4_BATCH_Generic_msn1106_0_historydate_201207_outfile+ prev_date,file_count_function(LI_Generic_msn1210_1_infile)}																		
                             ],input_file_count_ds_rec);														 													


result_lay:= record
			string file_name;  
			decimal19_2 Input_File_Count;
			decimal19_2 curr_response_count;
			decimal19_2 curr_response_count_pct;
			end;
		
						
								  ds_curr_roxie_error_codes_cnt:=	count(ds_curr_orig( length(trim(errorcode,left,right))<> 0 ));	
									ds_curr_archive_roxie_error_codes_cnt:=	count(ds_curr_archive_orig( length(trim(errorcode,left,right))<> 0 ));	
									ds_curr_prod_roxie_error_codes_cnt:=	count(ds_curr_prod_orig( length(trim(errorcode,left,right))<> 0 ));	
									ds_curr_archive_prod_roxie_error_codes_cnt:=	count(ds_curr_archive_prod_orig( length(trim(errorcode,left,right))<> 0 ));	
								 
   						    ds_prev_roxie_error_codes_cnt:=	count(ds_prev_orig( length(trim(errorcode,left,right))<> 0 ));	
									ds_prev_archive_roxie_error_codes_cnt:=	count(ds_prev_archive_orig( length(trim(errorcode,left,right))<> 0 ));	
									ds_prev_prod_roxie_error_codes_cnt:=	count(ds_prev_prod_orig( length(trim(errorcode,left,right))<> 0 ));	
									ds_prev_archive_prod_roxie_error_codes_cnt:=	count(ds_prev_archive_prod_orig( length(trim(errorcode,left,right))<> 0 ));		
   								
   												    
roxie_error_codes_cnt_ds:=DATASET([ {LI_Attributes_V4_BATCH_Generic_msn1106_0_outfile+ curr_date,ds_curr_roxie_error_codes_cnt}, 
												        {LI_Attributes_V4_BATCH_Generic_msn1106_0_historydate_201207_outfile+ curr_date,ds_curr_archive_roxie_error_codes_cnt},
															  {PROD_LI_Attributes_V4_BATCH_Generic_msn1106_0_outfile+ curr_date,ds_curr_prod_roxie_error_codes_cnt}, 
												        {PROD_LI_Attributes_V4_BATCH_Generic_msn1106_0_historydate_201207_outfile+ curr_date,ds_curr_archive_prod_roxie_error_codes_cnt},
																{LI_Attributes_V4_BATCH_Generic_msn1106_0_outfile+ prev_date,ds_prev_roxie_error_codes_cnt}, 
												        {LI_Attributes_V4_BATCH_Generic_msn1106_0_historydate_201207_outfile+ prev_date,ds_prev_archive_roxie_error_codes_cnt},
															  {PROD_LI_Attributes_V4_BATCH_Generic_msn1106_0_outfile+ prev_date,ds_prev_prod_roxie_error_codes_cnt}, 
												        {PROD_LI_Attributes_V4_BATCH_Generic_msn1106_0_historydate_201207_outfile+ prev_date,ds_prev_archive_prod_roxie_error_codes_cnt}
                              ],input_file_count_ds_rec);											
   														
   				
join1 := join(roxie_error_codes_cnt_ds,input_file_count_ds,left.file_name=right.file_name,transform(recordof(result_lay),self.file_name:= right.file_name[26..],
                                                                                                              self.Input_File_Count:= right.Input_File_Count,   
																																																							self.curr_response_count:= left.input_file_count, 
																																									self.curr_response_count_pct:= (left.input_file_count/right.Input_File_Count)*100 
             ) );



filter:=30;
   							
   		
flag2:=join1(curr_response_count_pct>filter);



// ******** START: CURRENT MODE CALCULATIONS *********************************************************************************************************************
		ds_j1 := JOIN(ds_curr, ds_prev, LEFT.accountnumber=RIGHT.accountnumber, transform(left));
		clean_file := ds_j1(accountnumber <> '');
		ds_curr_join := JOIN(ds_curr, clean_file, LEFT.accountnumber=RIGHT.accountnumber, transform(left));
		ds_prev_join := JOIN(ds_prev, clean_file, LEFT.accountnumber=RIGHT.accountnumber, transform(left));

		//  Calculate differences accross all fields - current mode
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'ageoldestrecord',r1);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'agenewestrecord',r2);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'recentupdate',r3);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'srcsconfirmidaddrcount',r4);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'creditbureaurecord',r5);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'verificationfailure',r6);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'ssnnotfound',r7);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'ssnfoundother',r8);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'verifiedname',r9);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'verifiedssn',r10);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'verifiedphone',r11);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'verifiedaddress',r12);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'verifieddob',r13);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'ageriskindicator',r14);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'subjectssncount',r15);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'subjectaddrcount',r16);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'subjectphonecount',r17);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'subjectssnrecentcount',r18);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'subjectaddrrecentcount',r19);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'subjectphonerecentcount',r20);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'ssnidentitiescount',r21);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'ssnaddrcount',r22);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'ssnidentitiesrecentcount',r23);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'ssnaddrrecentcount',r24);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'inputaddrphonecount',r25);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'inputaddrphonerecentcount',r26);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'phoneidentitiescount',r27);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'phoneidentitiesrecentcount',r28);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'phoneother',r29);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'ssnlastnamecount',r30);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'subjectlastnamecount',r31);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'lastnamechangeage',r32);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'lastnamechangecount01',r33);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'lastnamechangecount03',r34);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'lastnamechangecount06',r35);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'lastnamechangecount12',r36);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'lastnamechangecount24',r37);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'lastnamechangecount60',r38);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'sfduaddridentitiescount',r39);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'sfduaddrssncount',r40);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'ssnagedeceased',r41);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'ssnrecent',r42);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'ssnlowissueage',r43);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'ssnhighissueage',r44);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'ssnissuestate',r45);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'ssnnonus',r46);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'ssn3years',r47);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'ssnafter5',r48);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'ssnproblems',r49);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'relativescount',r50);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'relativesbankruptcycount',r51);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'relativesfelonycount',r52);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'relativespropownedcount',r53);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,' relativespropownedtaxtotal',r54);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'relativesdistanceclosest',r55);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'inputaddrageoldestrecord',r56);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'inputaddragenewestrecord',r57);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'inputaddrhistoricalmatch',r58);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'inputaddrlenofres',r59);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'inputaddrdwelltype',r60);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'inputaddrdelivery',r61);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'inputaddrapplicantowned',r62);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'inputaddrfamilyowned',r63);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'inputaddroccupantowned',r64);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'inputaddragelastsale',r65);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,' inputaddrlastsalesprice',r66);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'inputaddrmortgagetype',r67);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'inputaddrnotprimaryres',r68);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'inputaddractivephonelist',r69);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,' inputaddrtaxvalue',r70);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'inputaddrtaxyr',r71);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,' inputaddrtaxmarketvalue',r72);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,' inputaddravmvalue',r73);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,' inputaddravmvalue12',r74);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,' inputaddravmvalue60',r75);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'inputaddrcountyindex',r76);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'inputaddrtractindex',r77);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'inputaddrblockindex',r78);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,' inputaddrmedianincome',r79);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,' inputaddrmedianvalue',r80);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'inputaddrmurderindex',r81);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'inputaddrcartheftindex',r82);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'inputaddrburglaryindex',r83);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'inputaddrcrimeindex',r84);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'inputaddrmobilityindex',r85);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'inputaddrvacantpropcount',r86);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'inputaddrbusinesscount',r87);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'inputaddrsinglefamilycount',r88);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'inputaddrmultifamilycount',r89);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'curraddrageoldestrecord',r90);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'curraddragenewestrecord',r91);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'curraddrlenofres',r92);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'curraddrdwelltype',r93);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'curraddrapplicantowned',r94);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'curraddrfamilyowned',r95);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'curraddroccupantowned',r96);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'curraddragelastsale',r97);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,' curraddrlastsalesprice',r98);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'curraddrmortgagetype',r99);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'curraddractivephonelist',r100);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,' curraddrtaxvalue',r101);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'curraddrtaxyr',r102);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,' curraddrtaxmarketvalue',r103);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,' curraddravmvalue',r104);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,' curraddravmvalue12',r105);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,' curraddravmvalue60',r106);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'curraddrcountyindex',r107);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'curraddrtractindex',r108);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'curraddrblockindex',r109);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,' curraddrmedianincome',r110);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,' curraddrmedianvalue',r111);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'curraddrmurderindex',r112);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'curraddrcartheftindex',r113);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'curraddrburglaryindex',r114);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'curraddrcrimeindex',r115);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'prevaddrageoldestrecord',r116);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'prevaddragenewestrecord',r117);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'prevaddrlenofres',r118);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'prevaddrdwelltype',r119);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'prevaddrapplicantowned',r120);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'prevaddrfamilyowned',r121);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'prevaddroccupantowned',r122);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'prevaddragelastsale',r123);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,' prevaddrlastsalesprice',r124);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,' prevaddrtaxvalue',r125);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'prevaddrtaxyr',r126);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,' prevaddrtaxmarketvalue',r127);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,' prevaddravmvalue',r128);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'prevaddrcountyindex',r129);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'prevaddrtractindex',r130);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'prevaddrblockindex',r131);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,' prevaddrmedianincome',r132);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,' prevaddrmedianvalue',r133);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'prevaddrmurderindex',r134);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'prevaddrcartheftindex',r135);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'prevaddrburglaryindex',r136);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'prevaddrcrimeindex',r137);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'addrmostrecentdistance',r138);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'addrmostrecentstatediff',r139);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,' addrmostrecenttaxdiff',r140);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'addrmostrecentmoveage',r141);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,' addrmostrecentincomediff',r142);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,' addrmostrecentvaluediff',r143);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'addrmostrecentcrimediff',r144);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'addrrecentecontrajectory',r145);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'addrrecentecontrajectoryindex',r146);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'educationattendedcollege',r147);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'educationprogram2yr',r148);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'educationprogram4yr',r149);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'educationprogramgraduate',r150);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'educationinstitutionprivate',r151);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'educationinstitutionrating',r152);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'educationfieldofstudytype',r153);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'addrstability',r154);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'statusmostrecent',r155);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'statusprevious',r156);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'statusnextprevious',r157);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'addrchangecount01',r158);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'addrchangecount03',r159);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'addrchangecount06',r160);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'addrchangecount12',r161);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'addrchangecount24',r162);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'addrchangecount60',r163);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,' estimatedannualincome',r164);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'assetowner',r165);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'propertyowner',r166);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'propownedcount',r167);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,' propownedtaxtotal',r168);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'propownedhistoricalcount',r169);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'propageoldestpurchase',r170);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'propagenewestpurchase',r171);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'propagenewestsale',r172);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,' propnewestsaleprice',r173);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'propnewestsalepurchaseindex',r174);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'proppurchasedcount01',r175);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'proppurchasedcount03',r176);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'proppurchasedcount06',r177);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'proppurchasedcount12',r178);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'proppurchasedcount24',r179);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'proppurchasedcount60',r180);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'propsoldcount01',r181);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'propsoldcount03',r182);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'propsoldcount06',r183);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'propsoldcount12',r184);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'propsoldcount24',r185);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'propsoldcount60',r186);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'watercraftowner',r187);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'watercraftcount',r188);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'watercraftcount01',r189);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'watercraftcount03',r190);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'watercraftcount06',r191);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'watercraftcount12',r192);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'watercraftcount24',r193);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'watercraftcount60',r194);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'aircraftowner',r195);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'aircraftcount',r196);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'aircraftcount01',r197);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'aircraftcount03',r198);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'aircraftcount06',r199);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'aircraftcount12',r200);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'aircraftcount24',r201);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'aircraftcount60',r202);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'wealthindex',r203);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'businessactiveassociation',r204);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'businessinactiveassociation',r205);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'businessassociationage',r206);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'businesstitle',r207);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'businessinputaddrcount',r208);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'derogseverityindex',r209);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'derogcount',r210);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'derogrecentcount',r211);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'derogage',r212);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'felonycount',r213);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'felonyage',r214);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'felonycount01',r215);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'felonycount03',r216);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'felonycount06',r217);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'felonycount12',r218);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'felonycount24',r219);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'felonycount60',r220);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'arrestcount',r221);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'arrestage',r222);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'arrestcount01',r223);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'arrestcount03',r224);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'arrestcount06',r225);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'arrestcount12',r226);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'arrestcount24',r227);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'arrestcount60',r228);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'liencount',r229);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'lienfiledcount',r230);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,' lienfiledtotal',r231);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'lienfiledage',r232);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'lienfiledcount01',r233);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'lienfiledcount03',r234);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'lienfiledcount06',r235);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'lienfiledcount12',r236);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'lienfiledcount24',r237);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'lienfiledcount60',r238);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'lienreleasedcount',r239);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,' lienreleasedtotal',r240);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'lienreleasedage',r241);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'lienreleasedcount01',r242);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'lienreleasedcount03',r243);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'lienreleasedcount06',r244);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'lienreleasedcount12',r245);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'lienreleasedcount24',r246);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'lienreleasedcount60',r247);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'bankruptcycount',r248);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'bankruptcyage',r249);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'bankruptcytype',r250);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,' bankruptcystatus',r251);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'bankruptcycount01',r252);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'bankruptcycount03',r253);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'bankruptcycount06',r254);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'bankruptcycount12',r255);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'bankruptcycount24',r256);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'bankruptcycount60',r257);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'evictioncount',r258);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'evictionage',r259);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'evictioncount01',r260);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'evictioncount03',r261);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'evictioncount06',r262);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'evictioncount12',r263);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'evictioncount24',r264);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'evictioncount60',r265);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'accidentcount',r266);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'accidentage',r267);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'recentactivityindex',r268);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'nonderogcount',r269);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'nonderogcount01',r270);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'nonderogcount03',r271);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'nonderogcount06',r272);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'nonderogcount12',r273);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'nonderogcount24',r274);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'nonderogcount60',r275);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'voterregistrationrecord',r276);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'profliccount',r277);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'proflicage',r278);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'proflictypecategory',r279);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'proflicexpired',r280);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'profliccount01',r281);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'profliccount03',r282);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'profliccount06',r283);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'profliccount12',r284);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'profliccount24',r285);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'profliccount60',r286);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'prsearchlocatecount',r287);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'prsearchlocatecount01',r288);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'prsearchlocatecount03',r289);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'prsearchlocatecount06',r290);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'prsearchlocatecount12',r291);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'prsearchlocatecount24',r292);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'prsearchpersonalfinancecount',r293);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'prsearchpersonalfinancecount01',r294);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'prsearchpersonalfinancecount03',r295);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'prsearchpersonalfinancecount06',r296);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'prsearchpersonalfinancecount12',r297);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'prsearchpersonalfinancecount24',r298);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'prsearchothercount',r299);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'prsearchothercount01',r300);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'prsearchothercount03',r301);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'prsearchothercount06',r302);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'prsearchothercount12',r303);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'prsearchothercount24',r304);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'prsearchidentityssns',r305);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'prsearchidentityaddrs',r306);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'prsearchidentityphones',r307);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'prsearchssnidentities',r308);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'prsearchaddridentities',r309);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'prsearchphoneidentities',r310);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'subprimeofferrequestcount',r311);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'subprimeofferrequestcount01',r312);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'subprimeofferrequestcount03',r313);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'subprimeofferrequestcount06',r314);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'subprimeofferrequestcount12',r315);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'subprimeofferrequestcount24',r316);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'subprimeofferrequestcount60',r317);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'inputphonemobile',r318);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'inputphonetype',r319);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'inputphoneservicetype',r320);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'inputareacodechange',r321);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'phoneedaageoldestrecord',r322);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'phoneedaagenewestrecord',r323);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'phoneotherageoldestrecord',r324);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'phoneotheragenewestrecord',r325);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'inputphonehighrisk',r326);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'inputphoneproblems',r327);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'onlinedirectory',r328);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'inputaddrsiccode',r329);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'inputaddrvalidation',r330);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'inputaddrerrorcode',r331);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'inputaddrhighrisk',r332);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'curraddrcorrectional',r333);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'prevaddrcorrectional',r334);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'historicaladdrcorrectional',r335);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'inputaddrproblems',r336);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'donotmail',r337);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'identityrisklevel',r338);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'idverrisklevel',r339);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'idveraddressassoccount',r340);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'idverssncreditbureaucount',r341);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'idverssncreditbureaudelete',r342);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'sourcerisklevel',r343);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'sourcewatchlist',r344);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'sourceorderactivity',r345);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'sourceordersourcecount',r346);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'sourceorderagelastorder',r347);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'variationrisklevel',r348);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'variationidentitycount',r349);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'variationmsourcesssncount',r350);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'variationmsourcesssnunrelcount',r351);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'variationdobcount',r352);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'variationdobcountnew',r353);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'searchvelocityrisklevel',r354);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'searchunverifiedssncountyear',r355);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'searchunverifiedaddrcountyear',r356);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'searchunverifieddobcountyear',r357);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'searchunverifiedphonecountyear',r358);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'assocrisklevel',r359);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'assocsuspicousidentitiescount',r360);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'assoccreditbureauonlycount',r361);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'assoccreditbureauonlycountnew',r362);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'assoccreditbureauonlycountmonth',r363);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'assochighrisktopologycount',r364);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'validationrisklevel',r365);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'correlationrisklevel',r366);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'divrisklevel',r367);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'divssnidentitymsourcecount',r368);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'divssnidentitymsourceurelcount',r369);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'divssnlnamecountnew',r370);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'divssnaddrmsourcecount',r371);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'divaddridentitycount',r372);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'divaddridentitycountnew',r373);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'divaddridentitymsourcecount',r374);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'divaddrsuspidentitycountnew',r375);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'divaddrssncount',r376);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'divaddrssncountnew',r377);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'divaddrssnmsourcecount',r378);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'divsearchaddrsuspidentitycount',r379);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'searchcomponentrisklevel',r380);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'searchssnsearchcount',r381);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'searchaddrsearchcount',r382);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'searchphonesearchcount',r383);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'componentcharrisklevel',r384);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'historydate',r385);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,' did',r386);
			 // Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'fnamepop',r387);
			 // Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'lnamepop',r388);
			 // Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'addrpop',r389);
			 // Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'ssnlength',r390);
			 // Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'dobpop',r391);
			 // Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'emailpop',r392);
			 // Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'ipaddrpop',r393);
			 // Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join,ds_curr_join,'hphnpop',r394);
			 
		result:=  r1+r2+r3+r4+r5+r6+r7+r8+r9+r10+r11+r12+r13+r14+r15+r16+r17+r18+r19+r20+
			 r21+r22+r23+r24+r25+r26+r27+r28+r29+r30+r31+r32+r33+r34+r35+r36+r37+r38+r39+r40+
			 r41+r42+r43+r44+r45+r46+r47+r48+r49+r50+r51+r52+r53+r54+r55+r56+r57+r58+r59+r60+
			 r61+r62+r63+r64+r65+r66+r67+r68+r69+r70+r71+r72+r73+r74+r75+r76+r77+r78+r79+r80+
			 r81+r82+r83+r84+r85+r86+r87+r88+r89+r90+r91+r92+r93+r94+r95+r96+r97+r98+r99+r100+
			 r101+r102+r103+r104+r105+r106+r107+r108+r109+r110+r111+r112+r113+r114+r115+r116+r117+r118+r119+r120+
			 r121+r122+r123+r124+r125+r126+r127+r128+r129+r130+r131+r132+r133+r134+r135+r136+r137+r138+r139+r140+
			 r141+r142+r143+r144+r145+r146+r147+r148+r149+r150+r151+r152+r153+r154+r155+r156+r157+r158+r159+r160+
			 r161+r162+r163+r164+r165+r166+r167+r168+r169+r170+r171+r172+r173+r174+r175+r176+r177+r178+r179+r180+
			 r181+r182+r183+r184+r185+r186+r187+r188+r189+r190+r191+r192+r193+r194+r195+r196+r197+r198+r199+r200+
			 r201+r202+r203+r204+r205+r206+r207+r208+r209+r210+r211+r212+r213+r214+r215+r216+r217+r218+r219+r220+
			 r221+r222+r223+r224+r225+r226+r227+r228+r229+r230+r231+r232+r233+r234+r235+r236+r237+r238+r239+r240+
			 r241+r242+r243+r244+r245+r246+r247+r248+r249+r250+r251+r252+r253+r254+r255+r256+r257+r258+r259+r260+
			 r261+r262+r263+r264+r265+r266+r267+r268+r269+r270+r271+r272+r273+r274+r275+r276+r277+r278+r279+r280+
			 r281+r282+r283+r284+r285+r286+r287+r288+r289+r290+r291+r292+r293+r294+r295+r296+r297+r298+r299+r300+
			 r301+r302+r303+r304+r305+r306+r307+r308+r309+r310+r311+r312+r313+r314+r315+r316+r317+r318+r319+r320+
			 r321+r322+r323+r324+r325+r326+r327+r328+r329+r330+r331+r332+r333+r334+r335+r336+r337+r338+r339+r340+
			 r341+r342+r343+r344+r345+r346+r347+r348+r349+r350+r351+r352+r353+r354+r355+r356+r357+r358+r359+r360+
			 r361+r362+r363+r364+r365+r366+r367+r368+r369+r370+r371+r372+r373+r374+r375+r376+r377+r378+r379+r380+
			 r381+r382+r383+r384+r385+r386;//+r387+r388+r389+r390+r391+r392+r393+r394;
			 
		re_filter1:=result(Difference_Percent > thresh);
		re_filter2:=SORT(re_filter1, -Difference_Percent);
// ******** END: CURRENT MODE CALCULATIONS *********************************************************************************************************************


// ******** START: ARCHIVE MODE CALCULATIONS *********************************************************************************************************************
ds_j1_archive := JOIN(ds_curr_archive, ds_prev_archive, LEFT.accountnumber=RIGHT.accountnumber, transform(left));
		clean_file_archive := ds_j1_archive(accountnumber <> '');
		ds_curr_join_archive := JOIN(ds_curr_archive, clean_file_archive, LEFT.accountnumber=RIGHT.accountnumber, transform(left));
		ds_prev_join_archive := JOIN(ds_prev_archive, clean_file_archive, LEFT.accountnumber=RIGHT.accountnumber, transform(left));

		//  Calculate differences accross all fields - archive mode
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'ageoldestrecord', ra1);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'agenewestrecord', ra2);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'recentupdate', ra3);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'srcsconfirmidaddrcount', ra4);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'creditbureaurecord', ra5);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'verificationfailure', ra6);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'ssnnotfound', ra7);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'ssnfoundother', ra8);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'verifiedname', ra9);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'verifiedssn', ra10);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'verifiedphone', ra11);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'verifiedaddress', ra12);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'verifieddob', ra13);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'ageriskindicator', ra14);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'subjectssncount', ra15);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'subjectaddrcount', ra16);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'subjectphonecount', ra17);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'subjectssnrecentcount', ra18);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'subjectaddrrecentcount', ra19);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'subjectphonerecentcount', ra20);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'ssnidentitiescount', ra21);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'ssnaddrcount', ra22);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'ssnidentitiesrecentcount', ra23);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'ssnaddrrecentcount', ra24);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'inputaddrphonecount', ra25);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'inputaddrphonerecentcount', ra26);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'phoneidentitiescount', ra27);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'phoneidentitiesrecentcount', ra28);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'phoneother', ra29);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'ssnlastnamecount', ra30);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'subjectlastnamecount', ra31);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'lastnamechangeage', ra32);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'lastnamechangecount01', ra33);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'lastnamechangecount03', ra34);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'lastnamechangecount06', ra35);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'lastnamechangecount12', ra36);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'lastnamechangecount24', ra37);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'lastnamechangecount60', ra38);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'sfduaddridentitiescount', ra39);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'sfduaddrssncount', ra40);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'ssnagedeceased', ra41);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'ssnrecent', ra42);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'ssnlowissueage', ra43);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'ssnhighissueage', ra44);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'ssnissuestate', ra45);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'ssnnonus', ra46);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'ssn3years', ra47);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'ssnafter5', ra48);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'ssnproblems', ra49);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'relativescount', ra50);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'relativesbankruptcycount', ra51);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'relativesfelonycount', ra52);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'relativespropownedcount', ra53);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,' relativespropownedtaxtotal', ra54);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'relativesdistanceclosest', ra55);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'inputaddrageoldestrecord', ra56);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'inputaddragenewestrecord', ra57);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'inputaddrhistoricalmatch', ra58);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'inputaddrlenofres', ra59);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'inputaddrdwelltype', ra60);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'inputaddrdelivery', ra61);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'inputaddrapplicantowned', ra62);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'inputaddrfamilyowned', ra63);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'inputaddroccupantowned', ra64);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'inputaddragelastsale', ra65);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,' inputaddrlastsalesprice', ra66);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'inputaddrmortgagetype', ra67);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'inputaddrnotprimaryres', ra68);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'inputaddractivephonelist', ra69);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,' inputaddrtaxvalue', ra70);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'inputaddrtaxyr', ra71);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,' inputaddrtaxmarketvalue', ra72);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,' inputaddravmvalue', ra73);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,' inputaddravmvalue12', ra74);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,' inputaddravmvalue60', ra75);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'inputaddrcountyindex', ra76);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'inputaddrtractindex', ra77);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'inputaddrblockindex', ra78);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,' inputaddrmedianincome', ra79);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,' inputaddrmedianvalue', ra80);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'inputaddrmurderindex', ra81);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'inputaddrcartheftindex', ra82);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'inputaddrburglaryindex', ra83);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'inputaddrcrimeindex', ra84);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'inputaddrmobilityindex', ra85);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'inputaddrvacantpropcount', ra86);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'inputaddrbusinesscount', ra87);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'inputaddrsinglefamilycount', ra88);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'inputaddrmultifamilycount', ra89);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'curraddrageoldestrecord', ra90);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'curraddragenewestrecord', ra91);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'curraddrlenofres', ra92);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'curraddrdwelltype', ra93);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'curraddrapplicantowned', ra94);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'curraddrfamilyowned', ra95);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'curraddroccupantowned', ra96);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'curraddragelastsale', ra97);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,' curraddrlastsalesprice', ra98);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'curraddrmortgagetype', ra99);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'curraddractivephonelist', ra100);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,' curraddrtaxvalue', ra101);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'curraddrtaxyr', ra102);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,' curraddrtaxmarketvalue', ra103);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,' curraddravmvalue', ra104);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,' curraddravmvalue12', ra105);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,' curraddravmvalue60', ra106);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'curraddrcountyindex', ra107);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'curraddrtractindex', ra108);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'curraddrblockindex', ra109);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,' curraddrmedianincome', ra110);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,' curraddrmedianvalue', ra111);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'curraddrmurderindex', ra112);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'curraddrcartheftindex', ra113);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'curraddrburglaryindex', ra114);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'curraddrcrimeindex', ra115);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'prevaddrageoldestrecord', ra116);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'prevaddragenewestrecord', ra117);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'prevaddrlenofres', ra118);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'prevaddrdwelltype', ra119);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'prevaddrapplicantowned', ra120);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'prevaddrfamilyowned', ra121);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'prevaddroccupantowned', ra122);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'prevaddragelastsale', ra123);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,' prevaddrlastsalesprice', ra124);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,' prevaddrtaxvalue', ra125);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'prevaddrtaxyr', ra126);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,' prevaddrtaxmarketvalue', ra127);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,' prevaddravmvalue', ra128);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'prevaddrcountyindex', ra129);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'prevaddrtractindex', ra130);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'prevaddrblockindex', ra131);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,' prevaddrmedianincome', ra132);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,' prevaddrmedianvalue', ra133);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'prevaddrmurderindex', ra134);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'prevaddrcartheftindex', ra135);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'prevaddrburglaryindex', ra136);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'prevaddrcrimeindex', ra137);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'addrmostrecentdistance', ra138);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'addrmostrecentstatediff', ra139);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,' addrmostrecenttaxdiff', ra140);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'addrmostrecentmoveage', ra141);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,' addrmostrecentincomediff', ra142);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,' addrmostrecentvaluediff', ra143);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'addrmostrecentcrimediff', ra144);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'addrrecentecontrajectory', ra145);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'addrrecentecontrajectoryindex', ra146);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'educationattendedcollege', ra147);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'educationprogram2yr', ra148);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'educationprogram4yr', ra149);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'educationprogramgraduate', ra150);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'educationinstitutionprivate', ra151);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'educationinstitutionrating', ra152);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'educationfieldofstudytype', ra153);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'addrstability', ra154);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'statusmostrecent', ra155);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'statusprevious', ra156);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'statusnextprevious', ra157);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'addrchangecount01', ra158);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'addrchangecount03', ra159);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'addrchangecount06', ra160);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'addrchangecount12', ra161);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'addrchangecount24', ra162);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'addrchangecount60', ra163);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,' estimatedannualincome', ra164);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'assetowner', ra165);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'propertyowner', ra166);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'propownedcount', ra167);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,' propownedtaxtotal', ra168);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'propownedhistoricalcount', ra169);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'propageoldestpurchase', ra170);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'propagenewestpurchase', ra171);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'propagenewestsale', ra172);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,' propnewestsaleprice', ra173);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'propnewestsalepurchaseindex', ra174);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'proppurchasedcount01', ra175);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'proppurchasedcount03', ra176);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'proppurchasedcount06', ra177);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'proppurchasedcount12', ra178);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'proppurchasedcount24', ra179);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'proppurchasedcount60', ra180);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'propsoldcount01', ra181);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'propsoldcount03', ra182);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'propsoldcount06', ra183);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'propsoldcount12', ra184);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'propsoldcount24', ra185);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'propsoldcount60', ra186);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'watercraftowner', ra187);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'watercraftcount', ra188);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'watercraftcount01', ra189);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'watercraftcount03', ra190);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'watercraftcount06', ra191);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'watercraftcount12', ra192);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'watercraftcount24', ra193);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'watercraftcount60', ra194);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'aircraftowner', ra195);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'aircraftcount', ra196);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'aircraftcount01', ra197);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'aircraftcount03', ra198);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'aircraftcount06', ra199);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'aircraftcount12', ra200);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'aircraftcount24', ra201);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'aircraftcount60', ra202);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'wealthindex', ra203);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'businessactiveassociation', ra204);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'businessinactiveassociation', ra205);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'businessassociationage', ra206);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'businesstitle', ra207);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'businessinputaddrcount', ra208);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'derogseverityindex', ra209);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'derogcount', ra210);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'derogrecentcount', ra211);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'derogage', ra212);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'felonycount', ra213);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'felonyage', ra214);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'felonycount01', ra215);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'felonycount03', ra216);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'felonycount06', ra217);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'felonycount12', ra218);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'felonycount24', ra219);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'felonycount60', ra220);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'arrestcount', ra221);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'arrestage', ra222);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'arrestcount01', ra223);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'arrestcount03', ra224);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'arrestcount06', ra225);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'arrestcount12', ra226);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'arrestcount24', ra227);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'arrestcount60', ra228);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'liencount', ra229);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'lienfiledcount', ra230);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,' lienfiledtotal', ra231);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'lienfiledage', ra232);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'lienfiledcount01', ra233);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'lienfiledcount03', ra234);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'lienfiledcount06', ra235);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'lienfiledcount12', ra236);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'lienfiledcount24', ra237);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'lienfiledcount60', ra238);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'lienreleasedcount', ra239);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,' lienreleasedtotal', ra240);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'lienreleasedage', ra241);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'lienreleasedcount01', ra242);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'lienreleasedcount03', ra243);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'lienreleasedcount06', ra244);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'lienreleasedcount12', ra245);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'lienreleasedcount24', ra246);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'lienreleasedcount60', ra247);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'bankruptcycount', ra248);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'bankruptcyage', ra249);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'bankruptcytype', ra250);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,' bankruptcystatus', ra251);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'bankruptcycount01', ra252);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'bankruptcycount03', ra253);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'bankruptcycount06', ra254);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'bankruptcycount12', ra255);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'bankruptcycount24', ra256);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'bankruptcycount60', ra257);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'evictioncount', ra258);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'evictionage', ra259);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'evictioncount01', ra260);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'evictioncount03', ra261);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'evictioncount06', ra262);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'evictioncount12', ra263);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'evictioncount24', ra264);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'evictioncount60', ra265);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'accidentcount', ra266);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'accidentage', ra267);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'recentactivityindex', ra268);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'nonderogcount', ra269);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'nonderogcount01', ra270);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'nonderogcount03', ra271);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'nonderogcount06', ra272);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'nonderogcount12', ra273);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'nonderogcount24', ra274);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'nonderogcount60', ra275);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'voterregistrationrecord', ra276);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'profliccount', ra277);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'proflicage', ra278);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'proflictypecategory', ra279);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'proflicexpired', ra280);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'profliccount01', ra281);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'profliccount03', ra282);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'profliccount06', ra283);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'profliccount12', ra284);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'profliccount24', ra285);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'profliccount60', ra286);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'prsearchlocatecount', ra287);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'prsearchlocatecount01', ra288);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'prsearchlocatecount03', ra289);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'prsearchlocatecount06', ra290);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'prsearchlocatecount12', ra291);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'prsearchlocatecount24', ra292);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'prsearchpersonalfinancecount', ra293);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'prsearchpersonalfinancecount01', ra294);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'prsearchpersonalfinancecount03', ra295);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'prsearchpersonalfinancecount06', ra296);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'prsearchpersonalfinancecount12', ra297);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'prsearchpersonalfinancecount24', ra298);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'prsearchothercount', ra299);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'prsearchothercount01', ra300);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'prsearchothercount03', ra301);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'prsearchothercount06', ra302);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'prsearchothercount12', ra303);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'prsearchothercount24', ra304);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'prsearchidentityssns', ra305);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'prsearchidentityaddrs', ra306);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'prsearchidentityphones', ra307);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'prsearchssnidentities', ra308);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'prsearchaddridentities', ra309);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'prsearchphoneidentities', ra310);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'subprimeofferrequestcount', ra311);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'subprimeofferrequestcount01', ra312);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'subprimeofferrequestcount03', ra313);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'subprimeofferrequestcount06', ra314);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'subprimeofferrequestcount12', ra315);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'subprimeofferrequestcount24', ra316);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'subprimeofferrequestcount60', ra317);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'inputphonemobile', ra318);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'inputphonetype', ra319);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'inputphoneservicetype', ra320);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'inputareacodechange', ra321);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'phoneedaageoldestrecord', ra322);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'phoneedaagenewestrecord', ra323);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'phoneotherageoldestrecord', ra324);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'phoneotheragenewestrecord', ra325);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'inputphonehighrisk', ra326);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'inputphoneproblems', ra327);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'onlinedirectory', ra328);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'inputaddrsiccode', ra329);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'inputaddrvalidation', ra330);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'inputaddrerrorcode', ra331);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'inputaddrhighrisk', ra332);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'curraddrcorrectional', ra333);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'prevaddrcorrectional', ra334);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'historicaladdrcorrectional', ra335);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'inputaddrproblems', ra336);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'donotmail', ra337);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'identityrisklevel', ra338);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'idverrisklevel', ra339);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'idveraddressassoccount', ra340);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'idverssncreditbureaucount', ra341);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'idverssncreditbureaudelete', ra342);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'sourcerisklevel', ra343);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'sourcewatchlist', ra344);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'sourceorderactivity', ra345);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'sourceordersourcecount', ra346);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'sourceorderagelastorder', ra347);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'variationrisklevel', ra348);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'variationidentitycount', ra349);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'variationmsourcesssncount', ra350);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'variationmsourcesssnunrelcount', ra351);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'variationdobcount', ra352);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'variationdobcountnew', ra353);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'searchvelocityrisklevel', ra354);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'searchunverifiedssncountyear', ra355);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'searchunverifiedaddrcountyear', ra356);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'searchunverifieddobcountyear', ra357);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'searchunverifiedphonecountyear', ra358);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'assocrisklevel', ra359);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'assocsuspicousidentitiescount', ra360);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'assoccreditbureauonlycount', ra361);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'assoccreditbureauonlycountnew', ra362);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'assoccreditbureauonlycountmonth', ra363);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'assochighrisktopologycount', ra364);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'validationrisklevel', ra365);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'correlationrisklevel', ra366);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'divrisklevel', ra367);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'divssnidentitymsourcecount', ra368);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'divssnidentitymsourceurelcount', ra369);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'divssnlnamecountnew', ra370);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'divssnaddrmsourcecount', ra371);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'divaddridentitycount', ra372);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'divaddridentitycountnew', ra373);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'divaddridentitymsourcecount', ra374);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'divaddrsuspidentitycountnew', ra375);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'divaddrssncount', ra376);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'divaddrssncountnew', ra377);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'divaddrssnmsourcecount', ra378);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'divsearchaddrsuspidentitycount', ra379);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'searchcomponentrisklevel', ra380);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'searchssnsearchcount', ra381);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'searchaddrsearchcount', ra382);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'searchphonesearchcount', ra383);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'componentcharrisklevel', ra384);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'historydate', ra385);
			 Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,' did', ra386);
			 // Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'fnamepop', ra387);
			 // Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'lnamepop', ra388);
			 // Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'addrpop', ra389);
			 // Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'ssnlength', ra390);
			 // Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'dobpop', ra391);
			 // Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'emailpop', ra392);
			 // Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'ipaddrpop', ra393);
			 // Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive,ds_curr_join_archive,'hphnpop', ra394);
			 
		result_archive := ra1+ra2+ra3+ra4+ra5+ra6+ra7+ra8+ra9+ra10+ra11+ra12+ra13+ra14+ra15+ra16+ra17+ra18+ra19+ra20+
			 ra21+ra22+ra23+ra24+ra25+ra26+ra27+ra28+ra29+ra30+ra31+ra32+ra33+ra34+ra35+ra36+ra37+ra38+ra39+ra40+
			 ra41+ra42+ra43+ra44+ra45+ra46+ra47+ra48+ra49+ra50+ra51+ra52+ra53+ra54+ra55+ra56+ra57+ra58+ra59+ra60+
			 ra61+ra62+ra63+ra64+ra65+ra66+ra67+ra68+ra69+ra70+ra71+ra72+ra73+ra74+ra75+ra76+ra77+ra78+ra79+ra80+
			 ra81+ra82+ra83+ra84+ra85+ra86+ra87+ra88+ra89+ra90+ra91+ra92+ra93+ra94+ra95+ra96+ra97+ra98+ra99+ra100+
			 ra101+ra102+ra103+ra104+ra105+ra106+ra107+ra108+ra109+ra110+ra111+ra112+ra113+ra114+ra115+ra116+ra117+ra118+ra119+ra120+
			 ra121+ra122+ra123+ra124+ra125+ra126+ra127+ra128+ra129+ra130+ra131+ra132+ra133+ra134+ra135+ra136+ra137+ra138+ra139+ra140+
			 ra141+ra142+ra143+ra144+ra145+ra146+ra147+ra148+ra149+ra150+ra151+ra152+ra153+ra154+ra155+ra156+ra157+ra158+ra159+ra160+
			 ra161+ra162+ra163+ra164+ra165+ra166+ra167+ra168+ra169+ra170+ra171+ra172+ra173+ra174+ra175+ra176+ra177+ra178+ra179+ra180+
			 ra181+ra182+ra183+ra184+ra185+ra186+ra187+ra188+ra189+ra190+ra191+ra192+ra193+ra194+ra195+ra196+ra197+ra198+ra199+ra200+
			 ra201+ra202+ra203+ra204+ra205+ra206+ra207+ra208+ra209+ra210+ra211+ra212+ra213+ra214+ra215+ra216+ra217+ra218+ra219+ra220+
			 ra221+ra222+ra223+ra224+ra225+ra226+ra227+ra228+ra229+ra230+ra231+ra232+ra233+ra234+ra235+ra236+ra237+ra238+ra239+ra240+
			 ra241+ra242+ra243+ra244+ra245+ra246+ra247+ra248+ra249+ra250+ra251+ra252+ra253+ra254+ra255+ra256+ra257+ra258+ra259+ra260+
			 ra261+ra262+ra263+ra264+ra265+ra266+ra267+ra268+ra269+ra270+ra271+ra272+ra273+ra274+ra275+ra276+ra277+ra278+ra279+ra280+
			 ra281+ra282+ra283+ra284+ra285+ra286+ra287+ra288+ra289+ra290+ra291+ra292+ra293+ra294+ra295+ra296+ra297+ra298+ra299+ra300+
			 ra301+ra302+ra303+ra304+ra305+ra306+ra307+ra308+ra309+ra310+ra311+ra312+ra313+ra314+ra315+ra316+ra317+ra318+ra319+ra320+
			 ra321+ra322+ra323+ra324+ra325+ra326+ra327+ra328+ra329+ra330+ra331+ra332+ra333+ra334+ra335+ra336+ra337+ra338+ra339+ra340+
			 ra341+ra342+ra343+ra344+ra345+ra346+ra347+ra348+ra349+ra350+ra351+ra352+ra353+ra354+ra355+ra356+ra357+ra358+ra359+ra360+
			 ra361+ra362+ra363+ra364+ra365+ra366+ra367+ra368+ra369+ra370+ra371+ra372+ra373+ra374+ra375+ra376+ra377+ra378+ra379+ra380+
			 ra381+ra382+ra383+ra384+ra385+ra386;//+ra387+ra388+ra389+ra390+ra391+ra392+ra393+ra394;
			 
		re_filter1_archive := result_archive(Difference_Percent > thresh);
		re_filter2_archive := SORT(re_filter1_archive, -Difference_Percent);		
// ******** END: ARCHIVE MODE CALCULATIONS *********************************************************************************************************************
		

// ******** START: PROD CURRENT MODE CALCULATIONS *********************************************************************************************************************
		ds_j1_prod := JOIN(ds_curr_prod, ds_prev_prod, LEFT.accountnumber=RIGHT.accountnumber, transform(left));
		clean_file_prod := ds_j1_prod(accountnumber <> '');
		ds_curr_join_prod := JOIN(ds_curr_prod, clean_file_prod, LEFT.accountnumber=RIGHT.accountnumber, transform(left));
		ds_prev_join_prod := JOIN(ds_prev_prod, clean_file_prod, LEFT.accountnumber=RIGHT.accountnumber, transform(left));

		//  Calculate differences accross all fields - current mode
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'ageoldestrecord',p1);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'agenewestrecord',p2);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'recentupdate',p3);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'srcsconfirmidaddrcount',p4);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'creditbureaurecord',p5);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'verificationfailure',p6);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'ssnnotfound',p7);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'ssnfoundother',p8);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'verifiedname',p9);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'verifiedssn',p10);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'verifiedphone',p11);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'verifiedaddress',p12);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'verifieddob',p13);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'ageriskindicator',p14);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'subjectssncount',p15);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'subjectaddrcount',p16);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'subjectphonecount',p17);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'subjectssnrecentcount',p18);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'subjectaddrrecentcount',p19);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'subjectphonerecentcount',p20);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'ssnidentitiescount',p21);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'ssnaddrcount',p22);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'ssnidentitiesrecentcount',p23);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'ssnaddrrecentcount',p24);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'inputaddrphonecount',p25);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'inputaddrphonerecentcount',p26);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'phoneidentitiescount',p27);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'phoneidentitiesrecentcount',p28);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'phoneother',p29);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'ssnlastnamecount',p30);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'subjectlastnamecount',p31);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'lastnamechangeage',p32);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'lastnamechangecount01',p33);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'lastnamechangecount03',p34);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'lastnamechangecount06',p35);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'lastnamechangecount12',p36);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'lastnamechangecount24',p37);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'lastnamechangecount60',p38);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'sfduaddridentitiescount',p39);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'sfduaddrssncount',p40);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'ssnagedeceased',p41);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'ssnrecent',p42);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'ssnlowissueage',p43);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'ssnhighissueage',p44);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'ssnissuestate',p45);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'ssnnonus',p46);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'ssn3years',p47);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'ssnafter5',p48);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'ssnproblems',p49);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'relativescount',p50);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'relativesbankruptcycount',p51);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'relativesfelonycount',p52);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'relativespropownedcount',p53);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,' relativespropownedtaxtotal',p54);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'relativesdistanceclosest',p55);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'inputaddrageoldestrecord',p56);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'inputaddragenewestrecord',p57);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'inputaddrhistoricalmatch',p58);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'inputaddrlenofres',p59);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'inputaddrdwelltype',p60);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'inputaddrdelivery',p61);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'inputaddrapplicantowned',p62);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'inputaddrfamilyowned',p63);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'inputaddroccupantowned',p64);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'inputaddragelastsale',p65);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,' inputaddrlastsalesprice',p66);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'inputaddrmortgagetype',p67);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'inputaddrnotprimaryres',p68);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'inputaddractivephonelist',p69);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,' inputaddrtaxvalue',p70);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'inputaddrtaxyr',p71);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,' inputaddrtaxmarketvalue',p72);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,' inputaddravmvalue',p73);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,' inputaddravmvalue12',p74);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,' inputaddravmvalue60',p75);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'inputaddrcountyindex',p76);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'inputaddrtractindex',p77);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'inputaddrblockindex',p78);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,' inputaddrmedianincome',p79);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,' inputaddrmedianvalue',p80);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'inputaddrmurderindex',p81);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'inputaddrcartheftindex',p82);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'inputaddrburglaryindex',p83);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'inputaddrcrimeindex',p84);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'inputaddrmobilityindex',p85);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'inputaddrvacantpropcount',p86);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'inputaddrbusinesscount',p87);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'inputaddrsinglefamilycount',p88);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'inputaddrmultifamilycount',p89);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'curraddrageoldestrecord',p90);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'curraddragenewestrecord',p91);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'curraddrlenofres',p92);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'curraddrdwelltype',p93);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'curraddrapplicantowned',p94);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'curraddrfamilyowned',p95);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'curraddroccupantowned',p96);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'curraddragelastsale',p97);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,' curraddrlastsalesprice',p98);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'curraddrmortgagetype',p99);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'curraddractivephonelist',p100);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,' curraddrtaxvalue',p101);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'curraddrtaxyr',p102);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,' curraddrtaxmarketvalue',p103);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,' curraddravmvalue',p104);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,' curraddravmvalue12',p105);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,' curraddravmvalue60',p106);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'curraddrcountyindex',p107);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'curraddrtractindex',p108);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'curraddrblockindex',p109);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,' curraddrmedianincome',p110);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,' curraddrmedianvalue',p111);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'curraddrmurderindex',p112);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'curraddrcartheftindex',p113);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'curraddrburglaryindex',p114);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'curraddrcrimeindex',p115);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'prevaddrageoldestrecord',p116);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'prevaddragenewestrecord',p117);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'prevaddrlenofres',p118);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'prevaddrdwelltype',p119);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'prevaddrapplicantowned',p120);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'prevaddrfamilyowned',p121);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'prevaddroccupantowned',p122);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'prevaddragelastsale',p123);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,' prevaddrlastsalesprice',p124);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,' prevaddrtaxvalue',p125);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'prevaddrtaxyr',p126);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,' prevaddrtaxmarketvalue',p127);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,' prevaddravmvalue',p128);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'prevaddrcountyindex',p129);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'prevaddrtractindex',p130);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'prevaddrblockindex',p131);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,' prevaddrmedianincome',p132);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,' prevaddrmedianvalue',p133);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'prevaddrmurderindex',p134);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'prevaddrcartheftindex',p135);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'prevaddrburglaryindex',p136);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'prevaddrcrimeindex',p137);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'addrmostrecentdistance',p138);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'addrmostrecentstatediff',p139);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,' addrmostrecenttaxdiff',p140);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'addrmostrecentmoveage',p141);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,' addrmostrecentincomediff',p142);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,' addrmostrecentvaluediff',p143);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'addrmostrecentcrimediff',p144);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'addrrecentecontrajectory',p145);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'addrrecentecontrajectoryindex',p146);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'educationattendedcollege',p147);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'educationprogram2yr',p148);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'educationprogram4yr',p149);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'educationprogramgraduate',p150);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'educationinstitutionprivate',p151);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'educationinstitutionrating',p152);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'educationfieldofstudytype',p153);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'addrstability',p154);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'statusmostrecent',p155);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'statusprevious',p156);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'statusnextprevious',p157);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'addrchangecount01',p158);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'addrchangecount03',p159);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'addrchangecount06',p160);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'addrchangecount12',p161);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'addrchangecount24',p162);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'addrchangecount60',p163);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,' estimatedannualincome',p164);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'assetowner',p165);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'propertyowner',p166);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'propownedcount',p167);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,' propownedtaxtotal',p168);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'propownedhistoricalcount',p169);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'propageoldestpurchase',p170);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'propagenewestpurchase',p171);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'propagenewestsale',p172);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,' propnewestsaleprice',p173);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'propnewestsalepurchaseindex',p174);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'proppurchasedcount01',p175);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'proppurchasedcount03',p176);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'proppurchasedcount06',p177);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'proppurchasedcount12',p178);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'proppurchasedcount24',p179);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'proppurchasedcount60',p180);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'propsoldcount01',p181);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'propsoldcount03',p182);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'propsoldcount06',p183);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'propsoldcount12',p184);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'propsoldcount24',p185);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'propsoldcount60',p186);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'watercraftowner',p187);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'watercraftcount',p188);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'watercraftcount01',p189);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'watercraftcount03',p190);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'watercraftcount06',p191);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'watercraftcount12',p192);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'watercraftcount24',p193);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'watercraftcount60',p194);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'aircraftowner',p195);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'aircraftcount',p196);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'aircraftcount01',p197);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'aircraftcount03',p198);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'aircraftcount06',p199);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'aircraftcount12',p200);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'aircraftcount24',p201);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'aircraftcount60',p202);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'wealthindex',p203);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'businessactiveassociation',p204);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'businessinactiveassociation',p205);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'businessassociationage',p206);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'businesstitle',p207);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'businessinputaddrcount',p208);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'derogseverityindex',p209);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'derogcount',p210);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'derogrecentcount',p211);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'derogage',p212);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'felonycount',p213);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'felonyage',p214);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'felonycount01',p215);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'felonycount03',p216);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'felonycount06',p217);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'felonycount12',p218);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'felonycount24',p219);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'felonycount60',p220);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'arrestcount',p221);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'arrestage',p222);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'arrestcount01',p223);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'arrestcount03',p224);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'arrestcount06',p225);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'arrestcount12',p226);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'arrestcount24',p227);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'arrestcount60',p228);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'liencount',p229);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'lienfiledcount',p230);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,' lienfiledtotal',p231);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'lienfiledage',p232);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'lienfiledcount01',p233);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'lienfiledcount03',p234);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'lienfiledcount06',p235);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'lienfiledcount12',p236);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'lienfiledcount24',p237);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'lienfiledcount60',p238);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'lienreleasedcount',p239);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,' lienreleasedtotal',p240);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'lienreleasedage',p241);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'lienreleasedcount01',p242);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'lienreleasedcount03',p243);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'lienreleasedcount06',p244);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'lienreleasedcount12',p245);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'lienreleasedcount24',p246);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'lienreleasedcount60',p247);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'bankruptcycount',p248);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'bankruptcyage',p249);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'bankruptcytype',p250);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,' bankruptcystatus',p251);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'bankruptcycount01',p252);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'bankruptcycount03',p253);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'bankruptcycount06',p254);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'bankruptcycount12',p255);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'bankruptcycount24',p256);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'bankruptcycount60',p257);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'evictioncount',p258);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'evictionage',p259);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'evictioncount01',p260);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'evictioncount03',p261);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'evictioncount06',p262);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'evictioncount12',p263);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'evictioncount24',p264);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'evictioncount60',p265);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'accidentcount',p266);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'accidentage',p267);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'recentactivityindex',p268);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'nonderogcount',p269);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'nonderogcount01',p270);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'nonderogcount03',p271);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'nonderogcount06',p272);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'nonderogcount12',p273);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'nonderogcount24',p274);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'nonderogcount60',p275);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'voterregistrationrecord',p276);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'profliccount',p277);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'proflicage',p278);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'proflictypecategory',p279);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'proflicexpired',p280);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'profliccount01',p281);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'profliccount03',p282);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'profliccount06',p283);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'profliccount12',p284);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'profliccount24',p285);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'profliccount60',p286);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'prsearchlocatecount',p287);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'prsearchlocatecount01',p288);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'prsearchlocatecount03',p289);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'prsearchlocatecount06',p290);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'prsearchlocatecount12',p291);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'prsearchlocatecount24',p292);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'prsearchpersonalfinancecount',p293);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'prsearchpersonalfinancecount01',p294);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'prsearchpersonalfinancecount03',p295);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'prsearchpersonalfinancecount06',p296);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'prsearchpersonalfinancecount12',p297);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'prsearchpersonalfinancecount24',p298);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'prsearchothercount',p299);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'prsearchothercount01',p300);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'prsearchothercount03',p301);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'prsearchothercount06',p302);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'prsearchothercount12',p303);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'prsearchothercount24',p304);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'prsearchidentityssns',p305);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'prsearchidentityaddrs',p306);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'prsearchidentityphones',p307);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'prsearchssnidentities',p308);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'prsearchaddridentities',p309);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'prsearchphoneidentities',p310);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'subprimeofferrequestcount',p311);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'subprimeofferrequestcount01',p312);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'subprimeofferrequestcount03',p313);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'subprimeofferrequestcount06',p314);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'subprimeofferrequestcount12',p315);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'subprimeofferrequestcount24',p316);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'subprimeofferrequestcount60',p317);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'inputphonemobile',p318);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'inputphonetype',p319);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'inputphoneservicetype',p320);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'inputareacodechange',p321);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'phoneedaageoldestrecord',p322);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'phoneedaagenewestrecord',p323);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'phoneotherageoldestrecord',p324);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'phoneotheragenewestrecord',p325);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'inputphonehighrisk',p326);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'inputphoneproblems',p327);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'onlinedirectory',p328);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'inputaddrsiccode',p329);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'inputaddrvalidation',p330);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'inputaddrerrorcode',p331);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'inputaddrhighrisk',p332);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'curraddrcorrectional',p333);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'prevaddrcorrectional',p334);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'historicaladdrcorrectional',p335);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'inputaddrproblems',p336);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'donotmail',p337);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'identityrisklevel',p338);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'idverrisklevel',p339);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'idveraddressassoccount',p340);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'idverssncreditbureaucount',p341);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'idverssncreditbureaudelete',p342);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'sourcerisklevel',p343);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'sourcewatchlist',p344);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'sourceorderactivity',p345);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'sourceordersourcecount',p346);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'sourceorderagelastorder',p347);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'variationrisklevel',p348);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'variationidentitycount',p349);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'variationmsourcesssncount',p350);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'variationmsourcesssnunrelcount',p351);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'variationdobcount',p352);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'variationdobcountnew',p353);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'searchvelocityrisklevel',p354);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'searchunverifiedssncountyear',p355);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'searchunverifiedaddrcountyear',p356);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'searchunverifieddobcountyear',p357);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'searchunverifiedphonecountyear',p358);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'assocrisklevel',p359);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'assocsuspicousidentitiescount',p360);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'assoccreditbureauonlycount',p361);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'assoccreditbureauonlycountnew',p362);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'assoccreditbureauonlycountmonth',p363);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'assochighrisktopologycount',p364);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'validationrisklevel',p365);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'correlationrisklevel',p366);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'divrisklevel',p367);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'divssnidentitymsourcecount',p368);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'divssnidentitymsourceurelcount',p369);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'divssnlnamecountnew',p370);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'divssnaddrmsourcecount',p371);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'divaddridentitycount',p372);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'divaddridentitycountnew',p373);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'divaddridentitymsourcecount',p374);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'divaddrsuspidentitycountnew',p375);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'divaddrssncount',p376);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'divaddrssncountnew',p377);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'divaddrssnmsourcecount',p378);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'divsearchaddrsuspidentitycount',p379);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'searchcomponentrisklevel',p380);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'searchssnsearchcount',p381);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'searchaddrsearchcount',p382);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'searchphonesearchcount',p383);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'componentcharrisklevel',p384);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'historydate',p385);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,' did',p386);
		// Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'fnamepop',p387);
		// Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'lnamepop',p388);
		// Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'addrpop',p389);
		// Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'ssnlength',p390);
		// Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'dobpop',p391);
		// Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'emailpop',p392);
		// Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'ipaddrpop',p393);
		// Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_prod,ds_curr_join_prod,'hphnpop',p394);
			 
		result_prod :=  p1+p2+p3+p4+p5+p6+p7+p8+p9+p10+p11+p12+p13+p14+p15+p16+p17+p18+p19+p20+
			 p21+p22+p23+p24+p25+p26+p27+p28+p29+p30+p31+p32+p33+p34+p35+p36+p37+p38+p39+p40+
			 p41+p42+p43+p44+p45+p46+p47+p48+p49+p50+p51+p52+p53+p54+p55+p56+p57+p58+p59+p60+
			 p61+p62+p63+p64+p65+p66+p67+p68+p69+p70+p71+p72+p73+p74+p75+p76+p77+p78+p79+p80+
			 p81+p82+p83+p84+p85+p86+p87+p88+p89+p90+p91+p92+p93+p94+p95+p96+p97+p98+p99+p100+
			 p101+p102+p103+p104+p105+p106+p107+p108+p109+p110+p111+p112+p113+p114+p115+p116+p117+p118+p119+p120+
			 p121+p122+p123+p124+p125+p126+p127+p128+p129+p130+p131+p132+p133+p134+p135+p136+p137+p138+p139+p140+
			 p141+p142+p143+p144+p145+p146+p147+p148+p149+p150+p151+p152+p153+p154+p155+p156+p157+p158+p159+p160+
			 p161+p162+p163+p164+p165+p166+p167+p168+p169+p170+p171+p172+p173+p174+p175+p176+p177+p178+p179+p180+
			 p181+p182+p183+p184+p185+p186+p187+p188+p189+p190+p191+p192+p193+p194+p195+p196+p197+p198+p199+p200+
			 p201+p202+p203+p204+p205+p206+p207+p208+p209+p210+p211+p212+p213+p214+p215+p216+p217+p218+p219+p220+
			 p221+p222+p223+p224+p225+p226+p227+p228+p229+p230+p231+p232+p233+p234+p235+p236+p237+p238+p239+p240+
			 p241+p242+p243+p244+p245+p246+p247+p248+p249+p250+p251+p252+p253+p254+p255+p256+p257+p258+p259+p260+
			 p261+p262+p263+p264+p265+p266+p267+p268+p269+p270+p271+p272+p273+p274+p275+p276+p277+p278+p279+p280+
			 p281+p282+p283+p284+p285+p286+p287+p288+p289+p290+p291+p292+p293+p294+p295+p296+p297+p298+p299+p300+
			 p301+p302+p303+p304+p305+p306+p307+p308+p309+p310+p311+p312+p313+p314+p315+p316+p317+p318+p319+p320+
			 p321+p322+p323+p324+p325+p326+p327+p328+p329+p330+p331+p332+p333+p334+p335+p336+p337+p338+p339+p340+
			 p341+p342+p343+p344+p345+p346+p347+p348+p349+p350+p351+p352+p353+p354+p355+p356+p357+p358+p359+p360+
			 p361+p362+p363+p364+p365+p366+p367+p368+p369+p370+p371+p372+p373+p374+p375+p376+p377+p378+p379+p380+
			 p381+p382+p383+p384+p385+p386;//+p387+p388+p389+p390+p391+p392+p393+p394;
			 
		re_filter1_prod := result_prod(Difference_Percent > thresh);
		re_filter2_prod := SORT(re_filter1_prod, -Difference_Percent);
// ******** END: PROD CURRENT MODE CALCULATIONS *********************************************************************************************************************

// ******** START: PROD ARCHIVE MODE CALCULATIONS *********************************************************************************************************************
ds_j1_archive_prod := JOIN(ds_curr_archive_prod, ds_prev_archive_prod, LEFT.accountnumber=RIGHT.accountnumber, transform(left));
		clean_file_archive_prod := ds_j1_archive_prod(accountnumber <> '');
		ds_curr_join_archive_prod := JOIN(ds_curr_archive_prod, clean_file_archive_prod, LEFT.accountnumber=RIGHT.accountnumber, transform(left));
		ds_prev_join_archive_prod := JOIN(ds_prev_archive_prod, clean_file_archive_prod, LEFT.accountnumber=RIGHT.accountnumber, transform(left));

		//  Calculate differences accross all fields - archive mode
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'ageoldestrecord',pa1);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'agenewestrecord',pa2);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'recentupdate',pa3);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'srcsconfirmidaddrcount',pa4);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'creditbureaurecord',pa5);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'verificationfailure',pa6);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'ssnnotfound',pa7);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'ssnfoundother',pa8);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'verifiedname',pa9);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'verifiedssn',pa10);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'verifiedphone',pa11);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'verifiedaddress',pa12);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'verifieddob',pa13);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'ageriskindicator',pa14);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'subjectssncount',pa15);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'subjectaddrcount',pa16);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'subjectphonecount',pa17);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'subjectssnrecentcount',pa18);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'subjectaddrrecentcount',pa19);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'subjectphonerecentcount',pa20);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'ssnidentitiescount',pa21);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'ssnaddrcount',pa22);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'ssnidentitiesrecentcount',pa23);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'ssnaddrrecentcount',pa24);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'inputaddrphonecount',pa25);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'inputaddrphonerecentcount',pa26);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'phoneidentitiescount',pa27);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'phoneidentitiesrecentcount',pa28);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'phoneother',pa29);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'ssnlastnamecount',pa30);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'subjectlastnamecount',pa31);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'lastnamechangeage',pa32);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'lastnamechangecount01',pa33);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'lastnamechangecount03',pa34);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'lastnamechangecount06',pa35);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'lastnamechangecount12',pa36);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'lastnamechangecount24',pa37);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'lastnamechangecount60',pa38);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'sfduaddridentitiescount',pa39);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'sfduaddrssncount',pa40);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'ssnagedeceased',pa41);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'ssnrecent',pa42);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'ssnlowissueage',pa43);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'ssnhighissueage',pa44);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'ssnissuestate',pa45);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'ssnnonus',pa46);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'ssn3years',pa47);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'ssnafter5',pa48);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'ssnproblems',pa49);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'relativescount',pa50);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'relativesbankruptcycount',pa51);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'relativesfelonycount',pa52);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'relativespropownedcount',pa53);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,' relativespropownedtaxtotal',pa54);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'relativesdistanceclosest',pa55);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'inputaddrageoldestrecord',pa56);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'inputaddragenewestrecord',pa57);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'inputaddrhistoricalmatch',pa58);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'inputaddrlenofres',pa59);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'inputaddrdwelltype',pa60);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'inputaddrdelivery',pa61);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'inputaddrapplicantowned',pa62);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'inputaddrfamilyowned',pa63);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'inputaddroccupantowned',pa64);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'inputaddragelastsale',pa65);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,' inputaddrlastsalesprice',pa66);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'inputaddrmortgagetype',pa67);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'inputaddrnotprimaryres',pa68);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'inputaddractivephonelist',pa69);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,' inputaddrtaxvalue',pa70);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'inputaddrtaxyr',pa71);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,' inputaddrtaxmarketvalue',pa72);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,' inputaddravmvalue',pa73);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,' inputaddravmvalue12',pa74);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,' inputaddravmvalue60',pa75);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'inputaddrcountyindex',pa76);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'inputaddrtractindex',pa77);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'inputaddrblockindex',pa78);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,' inputaddrmedianincome',pa79);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,' inputaddrmedianvalue',pa80);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'inputaddrmurderindex',pa81);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'inputaddrcartheftindex',pa82);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'inputaddrburglaryindex',pa83);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'inputaddrcrimeindex',pa84);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'inputaddrmobilityindex',pa85);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'inputaddrvacantpropcount',pa86);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'inputaddrbusinesscount',pa87);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'inputaddrsinglefamilycount',pa88);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'inputaddrmultifamilycount',pa89);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'curraddrageoldestrecord',pa90);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'curraddragenewestrecord',pa91);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'curraddrlenofres',pa92);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'curraddrdwelltype',pa93);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'curraddrapplicantowned',pa94);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'curraddrfamilyowned',pa95);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'curraddroccupantowned',pa96);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'curraddragelastsale',pa97);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,' curraddrlastsalesprice',pa98);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'curraddrmortgagetype',pa99);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'curraddractivephonelist',pa100);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,' curraddrtaxvalue',pa101);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'curraddrtaxyr',pa102);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,' curraddrtaxmarketvalue',pa103);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,' curraddravmvalue',pa104);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,' curraddravmvalue12',pa105);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,' curraddravmvalue60',pa106);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'curraddrcountyindex',pa107);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'curraddrtractindex',pa108);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'curraddrblockindex',pa109);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,' curraddrmedianincome',pa110);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,' curraddrmedianvalue',pa111);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'curraddrmurderindex',pa112);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'curraddrcartheftindex',pa113);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'curraddrburglaryindex',pa114);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'curraddrcrimeindex',pa115);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'prevaddrageoldestrecord',pa116);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'prevaddragenewestrecord',pa117);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'prevaddrlenofres',pa118);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'prevaddrdwelltype',pa119);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'prevaddrapplicantowned',pa120);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'prevaddrfamilyowned',pa121);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'prevaddroccupantowned',pa122);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'prevaddragelastsale',pa123);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,' prevaddrlastsalesprice',pa124);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,' prevaddrtaxvalue',pa125);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'prevaddrtaxyr',pa126);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,' prevaddrtaxmarketvalue',pa127);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,' prevaddravmvalue',pa128);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'prevaddrcountyindex',pa129);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'prevaddrtractindex',pa130);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'prevaddrblockindex',pa131);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,' prevaddrmedianincome',pa132);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,' prevaddrmedianvalue',pa133);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'prevaddrmurderindex',pa134);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'prevaddrcartheftindex',pa135);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'prevaddrburglaryindex',pa136);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'prevaddrcrimeindex',pa137);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'addrmostrecentdistance',pa138);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'addrmostrecentstatediff',pa139);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,' addrmostrecenttaxdiff',pa140);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'addrmostrecentmoveage',pa141);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,' addrmostrecentincomediff',pa142);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,' addrmostrecentvaluediff',pa143);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'addrmostrecentcrimediff',pa144);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'addrrecentecontrajectory',pa145);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'addrrecentecontrajectoryindex',pa146);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'educationattendedcollege',pa147);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'educationprogram2yr',pa148);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'educationprogram4yr',pa149);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'educationprogramgraduate',pa150);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'educationinstitutionprivate',pa151);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'educationinstitutionrating',pa152);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'educationfieldofstudytype',pa153);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'addrstability',pa154);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'statusmostrecent',pa155);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'statusprevious',pa156);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'statusnextprevious',pa157);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'addrchangecount01',pa158);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'addrchangecount03',pa159);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'addrchangecount06',pa160);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'addrchangecount12',pa161);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'addrchangecount24',pa162);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'addrchangecount60',pa163);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,' estimatedannualincome',pa164);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'assetowner',pa165);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'propertyowner',pa166);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'propownedcount',pa167);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,' propownedtaxtotal',pa168);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'propownedhistoricalcount',pa169);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'propageoldestpurchase',pa170);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'propagenewestpurchase',pa171);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'propagenewestsale',pa172);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,' propnewestsaleprice',pa173);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'propnewestsalepurchaseindex',pa174);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'proppurchasedcount01',pa175);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'proppurchasedcount03',pa176);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'proppurchasedcount06',pa177);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'proppurchasedcount12',pa178);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'proppurchasedcount24',pa179);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'proppurchasedcount60',pa180);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'propsoldcount01',pa181);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'propsoldcount03',pa182);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'propsoldcount06',pa183);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'propsoldcount12',pa184);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'propsoldcount24',pa185);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'propsoldcount60',pa186);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'watercraftowner',pa187);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'watercraftcount',pa188);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'watercraftcount01',pa189);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'watercraftcount03',pa190);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'watercraftcount06',pa191);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'watercraftcount12',pa192);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'watercraftcount24',pa193);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'watercraftcount60',pa194);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'aircraftowner',pa195);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'aircraftcount',pa196);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'aircraftcount01',pa197);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'aircraftcount03',pa198);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'aircraftcount06',pa199);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'aircraftcount12',pa200);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'aircraftcount24',pa201);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'aircraftcount60',pa202);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'wealthindex',pa203);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'businessactiveassociation',pa204);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'businessinactiveassociation',pa205);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'businessassociationage',pa206);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'businesstitle',pa207);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'businessinputaddrcount',pa208);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'derogseverityindex',pa209);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'derogcount',pa210);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'derogrecentcount',pa211);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'derogage',pa212);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'felonycount',pa213);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'felonyage',pa214);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'felonycount01',pa215);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'felonycount03',pa216);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'felonycount06',pa217);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'felonycount12',pa218);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'felonycount24',pa219);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'felonycount60',pa220);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'arrestcount',pa221);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'arrestage',pa222);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'arrestcount01',pa223);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'arrestcount03',pa224);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'arrestcount06',pa225);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'arrestcount12',pa226);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'arrestcount24',pa227);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'arrestcount60',pa228);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'liencount',pa229);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'lienfiledcount',pa230);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,' lienfiledtotal',pa231);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'lienfiledage',pa232);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'lienfiledcount01',pa233);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'lienfiledcount03',pa234);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'lienfiledcount06',pa235);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'lienfiledcount12',pa236);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'lienfiledcount24',pa237);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'lienfiledcount60',pa238);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'lienreleasedcount',pa239);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,' lienreleasedtotal',pa240);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'lienreleasedage',pa241);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'lienreleasedcount01',pa242);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'lienreleasedcount03',pa243);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'lienreleasedcount06',pa244);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'lienreleasedcount12',pa245);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'lienreleasedcount24',pa246);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'lienreleasedcount60',pa247);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'bankruptcycount',pa248);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'bankruptcyage',pa249);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'bankruptcytype',pa250);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,' bankruptcystatus',pa251);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'bankruptcycount01',pa252);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'bankruptcycount03',pa253);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'bankruptcycount06',pa254);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'bankruptcycount12',pa255);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'bankruptcycount24',pa256);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'bankruptcycount60',pa257);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'evictioncount',pa258);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'evictionage',pa259);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'evictioncount01',pa260);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'evictioncount03',pa261);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'evictioncount06',pa262);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'evictioncount12',pa263);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'evictioncount24',pa264);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'evictioncount60',pa265);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'accidentcount',pa266);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'accidentage',pa267);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'recentactivityindex',pa268);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'nonderogcount',pa269);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'nonderogcount01',pa270);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'nonderogcount03',pa271);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'nonderogcount06',pa272);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'nonderogcount12',pa273);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'nonderogcount24',pa274);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'nonderogcount60',pa275);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'voterregistrationrecord',pa276);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'profliccount',pa277);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'proflicage',pa278);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'proflictypecategory',pa279);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'proflicexpired',pa280);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'profliccount01',pa281);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'profliccount03',pa282);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'profliccount06',pa283);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'profliccount12',pa284);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'profliccount24',pa285);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'profliccount60',pa286);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'prsearchlocatecount',pa287);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'prsearchlocatecount01',pa288);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'prsearchlocatecount03',pa289);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'prsearchlocatecount06',pa290);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'prsearchlocatecount12',pa291);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'prsearchlocatecount24',pa292);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'prsearchpersonalfinancecount',pa293);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'prsearchpersonalfinancecount01',pa294);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'prsearchpersonalfinancecount03',pa295);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'prsearchpersonalfinancecount06',pa296);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'prsearchpersonalfinancecount12',pa297);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'prsearchpersonalfinancecount24',pa298);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'prsearchothercount',pa299);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'prsearchothercount01',pa300);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'prsearchothercount03',pa301);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'prsearchothercount06',pa302);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'prsearchothercount12',pa303);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'prsearchothercount24',pa304);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'prsearchidentityssns',pa305);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'prsearchidentityaddrs',pa306);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'prsearchidentityphones',pa307);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'prsearchssnidentities',pa308);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'prsearchaddridentities',pa309);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'prsearchphoneidentities',pa310);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'subprimeofferrequestcount',pa311);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'subprimeofferrequestcount01',pa312);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'subprimeofferrequestcount03',pa313);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'subprimeofferrequestcount06',pa314);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'subprimeofferrequestcount12',pa315);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'subprimeofferrequestcount24',pa316);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'subprimeofferrequestcount60',pa317);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'inputphonemobile',pa318);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'inputphonetype',pa319);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'inputphoneservicetype',pa320);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'inputareacodechange',pa321);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'phoneedaageoldestrecord',pa322);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'phoneedaagenewestrecord',pa323);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'phoneotherageoldestrecord',pa324);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'phoneotheragenewestrecord',pa325);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'inputphonehighrisk',pa326);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'inputphoneproblems',pa327);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'onlinedirectory',pa328);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'inputaddrsiccode',pa329);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'inputaddrvalidation',pa330);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'inputaddrerrorcode',pa331);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'inputaddrhighrisk',pa332);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'curraddrcorrectional',pa333);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'prevaddrcorrectional',pa334);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'historicaladdrcorrectional',pa335);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'inputaddrproblems',pa336);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'donotmail',pa337);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'identityrisklevel',pa338);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'idverrisklevel',pa339);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'idveraddressassoccount',pa340);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'idverssncreditbureaucount',pa341);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'idverssncreditbureaudelete',pa342);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'sourcerisklevel',pa343);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'sourcewatchlist',pa344);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'sourceorderactivity',pa345);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'sourceordersourcecount',pa346);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'sourceorderagelastorder',pa347);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'variationrisklevel',pa348);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'variationidentitycount',pa349);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'variationmsourcesssncount',pa350);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'variationmsourcesssnunrelcount',pa351);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'variationdobcount',pa352);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'variationdobcountnew',pa353);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'searchvelocityrisklevel',pa354);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'searchunverifiedssncountyear',pa355);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'searchunverifiedaddrcountyear',pa356);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'searchunverifieddobcountyear',pa357);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'searchunverifiedphonecountyear',pa358);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'assocrisklevel',pa359);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'assocsuspicousidentitiescount',pa360);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'assoccreditbureauonlycount',pa361);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'assoccreditbureauonlycountnew',pa362);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'assoccreditbureauonlycountmonth',pa363);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'assochighrisktopologycount',pa364);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'validationrisklevel',pa365);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'correlationrisklevel',pa366);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'divrisklevel',pa367);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'divssnidentitymsourcecount',pa368);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'divssnidentitymsourceurelcount',pa369);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'divssnlnamecountnew',pa370);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'divssnaddrmsourcecount',pa371);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'divaddridentitycount',pa372);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'divaddridentitycountnew',pa373);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'divaddridentitymsourcecount',pa374);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'divaddrsuspidentitycountnew',pa375);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'divaddrssncount',pa376);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'divaddrssncountnew',pa377);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'divaddrssnmsourcecount',pa378);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'divsearchaddrsuspidentitycount',pa379);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'searchcomponentrisklevel',pa380);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'searchssnsearchcount',pa381);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'searchaddrsearchcount',pa382);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'searchphonesearchcount',pa383);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'componentcharrisklevel',pa384);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'historydate',pa385);
		Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,' did',pa386);
		// Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'fnamepop',pa387);
		// Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'lnamepop',pa388);
		// Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'addrpop',pa389);
		// Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'ssnlength',pa390);
		// Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'dobpop',pa391);
		// Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'emailpop',pa392);
		// Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'ipaddrpop',pa393);
		// Scoring_Project_DailyTracking.Functions.diff_count_function(ds_prev_join_archive_prod,ds_curr_join_archive_prod,'hphnpop',pa394);
			 
		result_archive_prod := pa1+pa2+pa3+pa4+pa5+pa6+pa7+pa8+pa9+pa10+pa11+pa12+pa13+pa14+pa15+pa16+pa17+pa18+pa19+pa20+
			 pa21+pa22+pa23+pa24+pa25+pa26+pa27+pa28+pa29+pa30+pa31+pa32+pa33+pa34+pa35+pa36+pa37+pa38+pa39+pa40+
			 pa41+pa42+pa43+pa44+pa45+pa46+pa47+pa48+pa49+pa50+pa51+pa52+pa53+pa54+pa55+pa56+pa57+pa58+pa59+pa60+
			 pa61+pa62+pa63+pa64+pa65+pa66+pa67+pa68+pa69+pa70+pa71+pa72+pa73+pa74+pa75+pa76+pa77+pa78+pa79+pa80+
			 pa81+pa82+pa83+pa84+pa85+pa86+pa87+pa88+pa89+pa90+pa91+pa92+pa93+pa94+pa95+pa96+pa97+pa98+pa99+pa100+
			 pa101+pa102+pa103+pa104+pa105+pa106+pa107+pa108+pa109+pa110+pa111+pa112+pa113+pa114+pa115+pa116+pa117+pa118+pa119+pa120+
			 pa121+pa122+pa123+pa124+pa125+pa126+pa127+pa128+pa129+pa130+pa131+pa132+pa133+pa134+pa135+pa136+pa137+pa138+pa139+pa140+
			 pa141+pa142+pa143+pa144+pa145+pa146+pa147+pa148+pa149+pa150+pa151+pa152+pa153+pa154+pa155+pa156+pa157+pa158+pa159+pa160+
			 pa161+pa162+pa163+pa164+pa165+pa166+pa167+pa168+pa169+pa170+pa171+pa172+pa173+pa174+pa175+pa176+pa177+pa178+pa179+pa180+
			 pa181+pa182+pa183+pa184+pa185+pa186+pa187+pa188+pa189+pa190+pa191+pa192+pa193+pa194+pa195+pa196+pa197+pa198+pa199+pa200+
			 pa201+pa202+pa203+pa204+pa205+pa206+pa207+pa208+pa209+pa210+pa211+pa212+pa213+pa214+pa215+pa216+pa217+pa218+pa219+pa220+
			 pa221+pa222+pa223+pa224+pa225+pa226+pa227+pa228+pa229+pa230+pa231+pa232+pa233+pa234+pa235+pa236+pa237+pa238+pa239+pa240+
			 pa241+pa242+pa243+pa244+pa245+pa246+pa247+pa248+pa249+pa250+pa251+pa252+pa253+pa254+pa255+pa256+pa257+pa258+pa259+pa260+
			 pa261+pa262+pa263+pa264+pa265+pa266+pa267+pa268+pa269+pa270+pa271+pa272+pa273+pa274+pa275+pa276+pa277+pa278+pa279+pa280+
			 pa281+pa282+pa283+pa284+pa285+pa286+pa287+pa288+pa289+pa290+pa291+pa292+pa293+pa294+pa295+pa296+pa297+pa298+pa299+pa300+
			 pa301+pa302+pa303+pa304+pa305+pa306+pa307+pa308+pa309+pa310+pa311+pa312+pa313+pa314+pa315+pa316+pa317+pa318+pa319+pa320+
			 pa321+pa322+pa323+pa324+pa325+pa326+pa327+pa328+pa329+pa330+pa331+pa332+pa333+pa334+pa335+pa336+pa337+pa338+pa339+pa340+
			 pa341+pa342+pa343+pa344+pa345+pa346+pa347+pa348+pa349+pa350+pa351+pa352+pa353+pa354+pa355+pa356+pa357+pa358+pa359+pa360+
			 pa361+pa362+pa363+pa364+pa365+pa366+pa367+pa368+pa369+pa370+pa371+pa372+pa373+pa374+pa375+pa376+pa377+pa378+pa379+pa380+
			 pa381+pa382+pa383+pa384+pa385+pa386;//+pa387+pa388+pa389+pa390+pa391+pa392+pa393+pa394;
			 
		re_filter1_archive_prod := result_archive_prod(Difference_Percent > thresh);
		re_filter2_archive_prod := SORT(re_filter1_archive_prod, -Difference_Percent);		
// ******** END: PROD ARCHIVE MODE CALCULATIONS *********************************************************************************************************************
		
		MyRec := RECORD
			INTEGER order;
			STRING line;
		END;

		max_diff := (STRING)SORT(re_filter1 + re_filter1_archive + re_filter1_prod + re_filter1_archive_prod, -Difference_Percent)[1].Difference_Percent + '%';
		
		ds_no_diff := DATASET([{2, 'No differences exceeding the ' + thresh + '% threshold'}], MyRec);
		
		STRING filler := '                                                                                                                    ';

		outfile_cert_realtime := IF(COUNT(re_filter2) > 0,
																			PROJECT(re_filter2, TRANSFORM(MyRec, SELF.order := 2;
																			SELF.line := (TRIM(LEFT.Field_Name) + filler)[1..40] + '\t\t' + (LEFT.Difference_count + filler)[1..10] + '\t\t\t' + LEFT.Difference_Percent + '%')),
																			ds_no_diff);
					
		outfile_cert_archive := IF(COUNT(re_filter2_archive) > 0,
																			PROJECT(re_filter2_archive, TRANSFORM(MyRec, SELF.order := 2;
																			SELF.line := (TRIM(LEFT.Field_Name) + filler)[1..40] + '\t\t' + (LEFT.Difference_count + filler)[1..10] + '\t\t\t' + LEFT.Difference_Percent + '%')),
																			ds_no_diff);
																			
		outfile_prod_realtime := IF(COUNT(re_filter2_prod) > 0,
																			PROJECT(re_filter2_prod, TRANSFORM(MyRec, SELF.order := 2;
																			SELF.line := (TRIM(LEFT.Field_Name) + filler)[1..40] + '\t\t' + (LEFT.Difference_count + filler)[1..10] + '\t\t\t' + LEFT.Difference_Percent + '%')),
																			ds_no_diff);
																			
		outfile_prod_archive := IF(COUNT(re_filter2_archive_prod) > 0,
																			PROJECT(re_filter2_archive_prod, TRANSFORM(MyRec, SELF.order := 2;
																			SELF.line := (TRIM(LEFT.Field_Name) + filler)[1..40] + '\t\t' + (LEFT.Difference_count + filler)[1..10] + '\t\t\t' + LEFT.Difference_Percent + '%')),
																			ds_no_diff);
																			
		line_heading := ('Field Name' + filler)[1..40] + '\t\t' + 'Difference Count' + '\t\t' + 'Difference Percent';

		main_head := DATASET([{1,   'LeadIntegrity 4.1 Attributes Tracking Report' + '\n'
													+ '*** This report is produced by Scoring QA. Please send comments to Nathan Koubsky ***' + '\n\n'
													}], MyRec); 		
				
		head_cert_realtime := DATASET([{1,    
														'Environment:  CERT'	+ '\n'
													+ 'Archive date:  999999' + '\n'
													+ 'Previous run date:  ' + cleaned_prev_date + '\n'
													+ 'Current run date:  ' + cleaned_curr_date + '\n' 
													+ 'Previous record count:  ' + COUNT(ds_prev) + '\n'
													+ 'Current record count:  ' + COUNT(ds_curr) + '\n'
													+ 'Compared records:  ' + COUNT(clean_file) + '\n'
													+ 'Threshold:  ' + thresh + '%' + '\n'  
													+ '\n' 
													+ line_heading + '\n'
													+ '-------------------------------------------------------------------------------------'
													}], MyRec); 
													

		head_cert_archive := DATASET([{1,    
														'Environment:  CERT'	+ '\n'
													+ 'Archive date:  201207' + '\n'
													+ 'Previous run date:  ' + cleaned_prev_arch_date + '\n'
													+ 'Current run date:  ' + cleaned_curr_arch_date + '\n' 
													+ 'Previous record count:  ' + COUNT(ds_prev_archive) + '\n'
													+ 'Current record count:  ' + COUNT(ds_curr_archive) + '\n'
													+ 'Compared records:  ' + COUNT(clean_file_archive) + '\n'
													+ 'Threshold:  ' + thresh + '%' + '\n'  
													+ '\n' 
													+ line_heading + '\n'
													+ '-------------------------------------------------------------------------------------'
													}], MyRec);
													
		head_prod_realtime := DATASET([{1,    
														'Environment:  PROD'	+ '\n'
													+ 'Archive date:  999999' + '\n'
													+ 'Previous run date:  ' + cleaned_prod_prev_date + '\n'
													+ 'Current run date:  ' + cleaned_prod_curr_date + '\n' 
													+ 'Previous record count:  ' + COUNT(ds_prev_prod) + '\n'
													+ 'Current record count:  ' + COUNT(ds_curr_prod) + '\n'
													+ 'Compared records:  ' + COUNT(clean_file_prod) + '\n'
													+ 'Threshold:  ' + thresh + '%' + '\n'  
													+ '\n' 
													+ line_heading + '\n'
													+ '-------------------------------------------------------------------------------------'
													}], MyRec); 
													

		head_prod_archive := DATASET([{1,    
														'Environment:  PROD'	+ '\n'
													+ 'Archive date:  201207' + '\n'
													+ 'Previous run date:  ' + cleaned_prod_prev_arch_date + '\n'
													+ 'Current run date:  ' + cleaned_prod_curr_arch_date + '\n' 
													+ 'Previous record count:  ' + COUNT(ds_prev_archive_prod) + '\n'
													+ 'Current record count:  ' + COUNT(ds_curr_archive_prod) + '\n'
													+ 'Compared records:  ' + COUNT(clean_file_archive_prod) + '\n'
													+ 'Threshold:  ' + thresh + '%' + '\n'  
													+ '\n' 
													+ line_heading + '\n'
													+ '-------------------------------------------------------------------------------------'
													}], MyRec);  

		spacer := DATASET([{3,    
														'\n' 
													+ '\n' 
													+ '\n' 
													}], MyRec);
		
		spacer2 := PROJECT(spacer, TRANSFORM(MyRec, SELF.order := 5; SELF := LEFT));
		spacer3 := PROJECT(spacer, TRANSFORM(MyRec, SELF.order := 7; SELF := LEFT));

		output_cert_realtime := PROJECT(SORT(head_cert_realtime + outfile_cert_realtime, order), TRANSFORM(MyRec, SELF.order := 2; SELF := LEFT));
		output_cert_archive := PROJECT(SORT(head_cert_archive + outfile_cert_archive, order), TRANSFORM(MyRec, SELF.order := 4; SELF := LEFT));
		output_prod_realtime := PROJECT(SORT(head_prod_realtime + outfile_prod_realtime, order), TRANSFORM(MyRec, SELF.order := 6; SELF := LEFT));
		output_prod_archive := PROJECT(SORT(head_prod_archive + outfile_prod_archive, order), TRANSFORM(MyRec, SELF.order := 8; SELF := LEFT));
		// OUTPUT(output_cert_realtime, NAMED('output_cert_realtime'));
		// OUTPUT(output_cert_archive, NAMED('output_cert_archive'));

		output_append := main_head + output_cert_realtime + spacer + output_cert_archive + spacer2 + output_prod_realtime + spacer3 + output_prod_archive;
		output_full := SORT(output_append, order);
		// OUTPUT(output_full, NAMED('output_full'));

		MyRec Xform(myrec L,myrec R) := TRANSFORM
				SELF.line := TRIM(L.line, LEFT) + '\n' + TRIM(R.line, LEFT); 
				self := l;
		END;

		XtabOut := ITERATE(output_full, Xform(LEFT, RIGHT));
  	// OUTPUT(XtabOut, NAMED('XtabOut'));
		
	//*****************************************************************
	
			// roxie error codes handling report code
			
	outfile_ds2 := IF(COUNT(flag2) > 0,
      																			PROJECT(flag2, TRANSFORM(MyRec, SELF.order := 2;
      																			SELF.line := (TRIM(LEFT.file_name) + filler)[1..75] + '\t' + LEFT.Input_File_Count + filler[1..13] + '\t' + LEFT.curr_response_count[1..10] + filler[1..10] + '\t' + 
   																				LEFT.curr_response_count_pct[1..20] ))
      																			);			
    
		
	failure_line_heading := ('file_name' ) + '\t\t\t\t\t\t\t\t\t\t' + '   Input_File_Cnt' + '\t' + '     error_response_cnt'+ '\t' + 'error_response_cnt_pct';
      
      		
  failure_head_cert_realtime := DATASET([{1,    
   														''	+ '\n'
   												
   													+ failure_line_heading + '\n'
   													+ '----------------------------------------------------------------------------------------------------------------------------------'
   													}], MyRec); 			
  failure_main_head_ds := DATASET([{2,   ' Data collection files ROXIE error codes counts exceeded '+ filter + '% threshold' + '\n'
      												 + '\n'
      													}], MyRec); 		
     			
    
      
      		output_ds_pjt := PROJECT(outfile_ds2, TRANSFORM(MyRec, SELF.order := 3; SELF := LEFT));

	   		
          output_ds2:= IF(COUNT(flag2) > 0,failure_main_head_ds,ds_no_diff) + failure_head_cert_realtime + output_ds_pjt ;
      		

     
      		MyRec Xform_func(myrec L,myrec R) := TRANSFORM
      				SELF.line := TRIM(L.line, LEFT) + '\n' + TRIM(R.line, LEFT); 
      				self := l;
      		END;
      
      		XtabOut_ds2 := ITERATE(output_ds2, Xform_func(LEFT, RIGHT));
		
//******************************************************************************
		
success_op:=FileServices.SendEmail(Scoring_Project_DailyTracking.email_distribution.general_list_all, 'LeadIntegrity 4.1 Daily Tracking Report: MaxDiff ' + max_diff, XtabOut[COUNT(XtabOut)].line);
failure_op:=FileServices.SendEmail(Scoring_Project_DailyTracking.email_distribution.fail_list, 'LeadIntegrity 4.1 Daily Tracking Report failed', XtabOut_ds2[COUNT(XtabOut_ds2)].line);

		final := if(count(flag2)>0,failure_op,success_op): 																	//Normal operations
		// final := FileServices.SendEmail(Scoring_Project_DailyTracking.email_distribution.fail_list, 'TEST......LeadIntegrity 4.1 Daily Tracking Report: MaxDiff ' + max_diff, XtabOut[COUNT(XtabOut)].line):															//Testing 
		// final := FileServices.SendEmail(Scoring_Project_DailyTracking.email_distribution.fail_list, 'LeadIntegrity 4.1 Daily Tracking Report: MaxDiff ' + max_diff + ' Manual run ' + cleaned_prev_date + ' - ' + cleaned_curr_date, XtabOut[COUNT(XtabOut)].line):	//Manual Run
									// WHEN(CRON('0 11 * * *')), //run at 6:00 AM
									FAILURE(FileServices.SendEmail(Scoring_Project_DailyTracking.email_distribution.fail_list,'LIA4 CRON job failed','The failed workunit is:' + WORKUNIT + FAILMESSAGE));

		RETURN final;
END;