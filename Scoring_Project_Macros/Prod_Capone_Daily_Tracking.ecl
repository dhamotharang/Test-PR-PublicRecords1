export Prod_Capone_Daily_Tracking := FUNCTION
//retired v3
//retired v5 oked 3/12
//making new//making new
import ut;
import std, Scoring_Project, ashirey,Scoring_Project_Macros, Scoring_Project_PIP,Scoring_Project_DailyTracking;

dt := ut.getdate;
decimal19_2 thresh := 0.01;


ds_curr := distribute(dataset('~ScoringQA::out::NONFCRA::Profile_Booster_Batch_Prod_CapitalOne_attributes_v1_' + dt + '_1', Scoring_Project_Macros.Global_Output_Layouts.ProfileBooster_layout, thor)(length(trim(errorcode,left,right))= 0 ),(integer)acctno);

filenames_details :=  nothor(STD.File.LogicalFileList('ScoringQA::out::NONFCRA::Profile_Booster_Batch_Prod_CapitalOne_attributes_v1_*_1'));


filelist := sort(filenames_details, -modified);

p_file_name := filelist[2].name;
prev_date := p_file_name[length(p_file_name)-9.. length(p_file_name)-2];

cleaned_curr := dt;
cleaned_prev := prev_date;

ds_prev := distribute(dataset('~'+ p_file_name, Scoring_Project_Macros.Global_Output_Layouts.ProfileBooster_layout, thor)(length(trim(errorcode,left,right))= 0 ),(integer)acctno);

clean_prev := ds_prev(errorcode = '');
clean_curr := ds_curr(errorcode = '');

ds_results2 := Scoring_Project_PIP.Compare_dsets_macro_email(clean_prev, clean_curr, ['acctno'], thresh);

re_filter2 := ds_results2(field <> 'time_ms');

//v3 retired
// ******** START: ARCHIVE MODE CALCULATIONS *********************************************************************************************************************
/*
ds_curr_archive := dataset('~ScoringQA::out::FCRA::RiskView_Batch_Prod_Capitalone_attributes_V3_' + dt + '_1', scoring_project_Macros.Global_Output_Layouts.FCRA_RiskView_BATCH_Capitalone_Attributes_V3_Global_Layout, thor)(length(trim(errorcode,left,right))= 0 );

filenames_details_arch :=  nothor(STD.File.LogicalFileList('ScoringQA::out::FCRA::RiskView_Batch_Prod_Capitalone_attributes_V3_*_1'));


filelist_arch := sort(filenames_details_arch, -modified);

p_arch_file_name := filelist_arch[2].name;
prev_arch_date := p_arch_file_name[length(p_arch_file_name)-9.. length(p_arch_file_name)-2];

cleaned_curr_arch_date := dt;
cleaned_prev_arch_date := prev_arch_date;

ds_prev_archive := dataset('~'+ p_arch_file_name, scoring_project_Macros.Global_Output_Layouts.FCRA_RiskView_BATCH_Capitalone_Attributes_V3_Global_Layout, thor)(length(trim(errorcode,left,right))= 0 );

clean_prev_archive := ds_prev_archive(errorcode = '');
clean_curr_archive := ds_curr_archive(errorcode = '');

ds_results2_archive := zz_bbraaten2.Compare_dsets_macro_email(clean_prev_archive, clean_curr_archive, ['accountnumber'], thresh);

re_filter2_archive := ds_results2_archive(field <> 'time_ms');

		// join1_arch := JOIN(ds_curr_archive, ds_prev_archive, LEFT.accountnumber=RIGHT.accountnumber, transform(left));
		// clean_file_archive := join1_arch(accountnumber <> '');
		// ds_curr_arch_join := JOIN(ds_curr_archive, clean_file_archive, LEFT.accountnumber=RIGHT.accountnumber, transform(left));
		// ds_prev_arch_join := JOIN(ds_prev_archive, clean_file_archive, LEFT.accountnumber=RIGHT.accountnumber, transform(left));

// ashirey.flatten(ds_curr_arch_join, fcra_arch_curr_output, ,true , ,);
// ashirey.flatten(ds_prev_arch_join, fcra_arch_prev_output, ,true, ,);
// fcra_arch_curr_ds := Scoring_Project.BocaShell_Normalized_Code(fcra_arch_curr_output, 'accountnumber');
// fcra_arch_prev_ds := 	Scoring_Project.BocaShell_Normalized_Code(fcra_arch_prev_output, 'accountnumber');

// fcra_arch_layout := record
// recordof(fcra_arch_curr_ds);
// Integer flag;
// end;


// fcra_arch_jn := JOIN(fcra_arch_curr_ds, fcra_arch_prev_ds, left.accountnumber = right.accountnumber and
														 // left.field_name = right.field_name,
														// TRANSFORM(fcra_arch_layout, 
																			// self.flag := If(left.field_value <> right.field_value, 1, 0);
																			// self := Left;
																			// ));
														
// fcra_arch_filter_join := fcra_arch_jn(flag = 1, field_name <> 'proflic_build_date');	

// fcra_arch_recrd := record
// fcra_arch_filter_join.field_name;
// Integer Difference_count := count(group);
// decimal19_2  Difference_Percent :=  (count(group)/count(ds_curr_arch_join))*100;
// end;

// fcra_arch_result := table(fcra_arch_filter_join, fcra_arch_recrd, fcra_arch_filter_join.field_name);

// re_filter1_archive := fcra_arch_result(field_name not in ['aircraft_build_date', 'historydatetimestamp', 'property_build_date', 'time_ms'], Difference_Percent > thresh);
// re_filter2_archive := SORT(re_filter1_archive, -Difference_Percent);
*/
// ******** END: ARCHIVE MODE CALCULATIONS *********************************************************************************************************************
		
//retired v5
// ******** START: NON FCRA CURRENT MODE CALCULATIONS *********************************************************************************************************************

nonfcra_ds_curr := dataset('~scoringqa::out::fcra::riskview_xml_generic_prod_allflagships_attributes_v5_' + dt + '_1',  Scoring_Project_Macros.Global_Output_Layouts.FCRA_RiskView_Generic_allflagships_Attributes_V5_Global_Layout, thor)(length(trim(errorcode,left,right))= 0 );


nonfcra_filenames_details :=  nothor(STD.File.LogicalFileList('scoringqa::out::fcra::riskview_xml_generic_prod_allflagships_attributes_v5_*_1'));


nonfcra_filelist := sort(nonfcra_filenames_details, -modified);

nonfcra_p_file_name := nonfcra_filelist[2].name;
nonfcra_prev_date := nonfcra_p_file_name[length(nonfcra_p_file_name)-9.. length(nonfcra_p_file_name)-2];

cleaned_nonfcra_curr_date := dt;
cleaned_nonfcra_prev_date := nonfcra_prev_date;

nonfcra_ds_prev := dataset('~'+ nonfcra_p_file_name, Scoring_Project_Macros.Global_Output_Layouts.FCRA_RiskView_Generic_allflagships_Attributes_V5_Global_Layout, thor)(length(trim(errorcode,left,right))= 0 );

clean_prev_nonfcra := nonfcra_ds_prev(errorcode = '');
clean_curr_nonfcra := nonfcra_ds_curr(errorcode = '');

ds_results2_nonfcra := Scoring_Project_PIP.Compare_dsets_macro_email(clean_prev_nonfcra, clean_curr_nonfcra, ['acctno'], thresh);

re_filter2_nonfcra := ds_results2_nonfcra(field <> 'time_ms');


// ******** END: NonFCRA CURRENT MODE CALCULATIONS *********************************************************************************************************************

// ******** START: NonFCRA ARCHIVE MODE CALCULATIONS *********************************************************************************************************************

nonfcra_ds_curr_arch := dataset('~ScoringQA::out::NONFCRA::ITA_batch_Prod_CapitalOne_attributes_v3_' + dt + '_1', scoring_project_Macros.Global_Output_Layouts.NONFCRA_ITA_BATCH_CapitalOne_attributes_v3_Global_Layout, thor)(length(trim(errorcode,left,right))= 0 );


nonfcra_filenames_details_arch :=  nothor(STD.File.LogicalFileList('ScoringQA::out::NONFCRA::ITA_batch_Prod_CapitalOne_attributes_v3_*_1'));


nonfcra_filelist_arch := sort(nonfcra_filenames_details_arch, -modified);

nonfcra_p_file_name_arch := nonfcra_filelist_arch[2].name;
nonfcra_prev_date_arch := nonfcra_p_file_name_arch[length(nonfcra_p_file_name_arch)-9.. length(nonfcra_p_file_name_arch)-2];

cleaned_nonfcra_curr_date_arch := dt;
cleaned_nonfcra_prev_date_arch := nonfcra_prev_date_arch;

nonfcra_ds_prev_arch := dataset('~'+ nonfcra_p_file_name_arch, scoring_project_Macros.Global_Output_Layouts.NONFCRA_ITA_BATCH_CapitalOne_attributes_v3_Global_Layout, thor)(length(trim(errorcode,left,right))= 0 );

nonfcra_clean_prev := nonfcra_ds_prev_arch(errorcode = '');
nonfcra_clean_curr := nonfcra_ds_curr_arch(errorcode = '');

nonfcra_ds_results2 := Scoring_Project_PIP.Compare_dsets_macro_email(nonfcra_clean_prev, nonfcra_clean_curr, ['acctno'], thresh);

re_filter2_nonfcra_arch := nonfcra_ds_results2(field <> 'time_ms' and field <> 'seq');


// ******** END: NonFCRA ARCHIVE MODE CALCULATIONS *********************************************************************************************************************
		
		MyRec := RECORD
			INTEGER order;
			STRING line;
		END;

		// max_diff := (STRING)SORT( re_filter2 +   re_filter2_nonfcra_arch, -diff_pct)[1].diff_pct + '%';
		max_diff := (STRING)SORT( re_filter2 +  re_filter2_nonfcra + re_filter2_nonfcra_arch, -diff_pct)[1].diff_pct + '%';
		// max_diff := (STRING)SORT( re_filter2 + re_filter2_archive + re_filter2_nonfcra + re_filter2_nonfcra_arch, -diff_pct)[1].diff_pct + '%';
		// max_diff := (STRING)re_filter2_nonfcra_arch[1].diff_pct	 + '%';
		
		ds_no_diff := DATASET([{2, 'No differences exceeding the ' + thresh + '% threshold'}], MyRec);
		
		STRING filler := '                                                                                                                    ';

		outfile_cert_realtime := IF(COUNT(re_filter2) > 0,
																			PROJECT(re_filter2, TRANSFORM(MyRec, SELF.order := 2;
																			SELF.line := (TRIM(LEFT.Field) + filler)[1..50] + (LEFT.diff_cnt	 + filler)[1..10] + (LEFT.diff_pct	 + '%'+filler)[1..10]+ (left.up_cnt + filler)[1..10]    + (left.up_pct + '%'+filler)[1..10] + (left.down_cnt + filler)[1..10]    + (left.down_pct + '%')[1..10]     )),
																			ds_no_diff);
					
		// outfile_cert_archive := IF(COUNT(re_filter2_archive) > 0,
																			// PROJECT(re_filter2_archive, TRANSFORM(MyRec, SELF.order := 2;
																			// SELF.line := (TRIM(LEFT.Field) + filler)[1..50] + (LEFT.diff_cnt	 + filler)[1..10] + (LEFT.diff_pct	 + '%'+filler)[1..10]+ (left.up_cnt + filler)[1..10]    + (left.up_pct + '%'+filler)[1..10] + (left.down_cnt + filler)[1..10]    + (left.down_pct + '%')[1..10]     )),
																			// ds_no_diff);
																			
		outfile_prod_realtime := IF(COUNT(re_filter2_nonfcra) > 0,
																			PROJECT(re_filter2_nonfcra, TRANSFORM(MyRec, SELF.order := 2;
																			SELF.line := (TRIM(LEFT.Field) + filler)[1..50] + (LEFT.diff_cnt	 + filler)[1..10] + (LEFT.diff_pct	 + '%'+filler)[1..10]+ (left.up_cnt + filler)[1..10]    + (left.up_pct + '%'+filler)[1..10] + (left.down_cnt + filler)[1..10]    + (left.down_pct + '%')[1..10]     )),
																			ds_no_diff);
																			
		outfile_prod_archive := IF(COUNT(re_filter2_nonfcra_arch) > 0,
																			PROJECT(re_filter2_nonfcra_arch, TRANSFORM(MyRec, SELF.order := 2;
																			SELF.line := (TRIM(LEFT.Field) + filler)[1..50] + (LEFT.diff_cnt	 + filler)[1..10] + (LEFT.diff_pct	 + '%'+filler)[1..10]+ (left.up_cnt + filler)[1..10]    + (left.up_pct + '%'+filler)[1..10] + (left.down_cnt + filler)[1..10]    + (left.down_pct + '%')[1..10]     )),
																			ds_no_diff);
																			
		line_heading := ('Field' + filler)[1..50] + ('Diff Cnt' + filler)[1..10] + ('Diff Pct' + filler)[1..10]+ ('Up Cnt' + filler)[1..10]+ ('Up Pct' + filler)[1..10]+('Down Cnt' + filler)[1..10] + ('Down Pct' + filler)[1..10];

		main_head := DATASET([{1,   'Capone Prod Attributes Tracking Report' + '\n'
													+ '*** This report is produced by Scoring QA ***' + '\n\n'
													}], MyRec); 		
				
		head_cert_realtime := DATASET([{1,    
														'Environment:  Prod - Profile Booster Capone'+ '\n\n'
														+ 'Archive date:  999999'  + '\n'
														+ 'Previous run date:  ' +  cleaned_prev  + '\n'
													+ 'Current run date:  ' + cleaned_curr  + '\n'
													+ 'Previous record count:  ' + COUNT(ds_prev)  + '\n'
													+ 'Current record count:  ' + COUNT(ds_curr)  + '\n'
													+ 'Compared records:  ' +re_filter2[1].total_cnt + '\n'
													+ 'Threshold:  ' + thresh + '%'	+ '\n'
													 + '\n'
													+ line_heading + '\n'
													+ '-----------------------------------------------------------------------------------------------------------------'
													}], MyRec); 
													

		// head_cert_archive := DATASET([{1,    
														// 'Environment:  Prod - RV v3 Capone Prescreen'	+ '\n\n'
													// + 'Archive date:  999999' + '\n'
													// + 'Previous run date:  ' + cleaned_prev_arch_date + '\n'
													// + 'Current run date:  ' + cleaned_curr_arch_date + '\n' 
													// + 'Previous record count:  ' + COUNT(nonfcra_clean_prev) + '\n'
													// + 'Current record count:  ' + COUNT(nonfcra_clean_curr) + '\n'
													// + 'Compared records:  ' + re_filter2_archive[1].total_cnt + '\n'
													// + 'Threshold:  ' + thresh + '%' + '\n'  
													// + '\n' 
													// + line_heading + '\n'
													// + '-----------------------------------------------------------------------------------------------------------------'
													// }], MyRec);
													
		head_prod_realtime := DATASET([{1,    
														'Environment:  Prod - RV v5 Generic'	+ '\n\n'
													+ 'Archive date:  999999' + '\n'
													+ 'Previous run date:  ' + cleaned_nonfcra_prev_date + '\n'
													+ 'Current run date:  ' + cleaned_nonfcra_curr_date + '\n' 
													+ 'Previous record count:  ' + COUNT(clean_prev) + '\n'
													+ 'Current record count:  ' + COUNT(clean_curr) + '\n'
													+ 'Compared records:  ' + re_filter2_nonfcra[1].total_cnt+ '\n'
													+ 'Threshold:  ' + thresh + '%' + '\n'  
													+ '\n' 
													+ line_heading + '\n'
													+ '-----------------------------------------------------------------------------------------------------------------'
													}], MyRec); 
													

		head_prod_archive := DATASET([{1,    
														'Environment:  Prod - ITA v3 Capone'	+ '\n\n'
													+ 'Archive date:  999999' + '\n'
													+ 'Previous run date:  ' + cleaned_nonfcra_prev_date_arch + '\n'
													+ 'Current run date:  ' + cleaned_nonfcra_curr_date_arch + '\n' 
													+ 'Previous record count:  ' + COUNT(nonfcra_clean_prev) + '\n'
													+ 'Current record count:  ' + COUNT(nonfcra_clean_curr) + '\n'
													+ 'Compared records:  ' + re_filter2_nonfcra_arch[1].total_cnt + '\n'
													+ 'Threshold:  ' + thresh + '%' + '\n'  
													+ '\n' 
													+ line_heading + '\n'
													+ '-----------------------------------------------------------------------------------------------------------------'
													}], MyRec);  

		spacer := DATASET([{3,    
														'\n' 
													+ '\n' 
													+ '\n' 
													}], MyRec);
		
		spacer2 := PROJECT(spacer, TRANSFORM(MyRec, SELF.order := 5; SELF := LEFT));
		spacer3 := PROJECT(spacer, TRANSFORM(MyRec, SELF.order := 7; SELF := LEFT));

		output_cert_realtime := PROJECT(SORT(head_cert_realtime + outfile_cert_realtime, order), TRANSFORM(MyRec, SELF.order := 2; SELF := LEFT));
		// output_cert_archive := PROJECT(SORT(head_cert_archive + outfile_cert_archive, order), TRANSFORM(MyRec, SELF.order := 4; SELF := LEFT));
		output_prod_realtime := PROJECT(SORT(head_prod_realtime + outfile_prod_realtime, order), TRANSFORM(MyRec, SELF.order := 6; SELF := LEFT));
		output_prod_archive := PROJECT(SORT(head_prod_archive + outfile_prod_archive, order), TRANSFORM(MyRec, SELF.order := 8; SELF := LEFT));


		// output_append := main_head +spacer + output_cert_realtime + spacer3 + output_prod_archive;
		output_append := main_head +spacer + output_cert_realtime +  spacer2 + output_prod_realtime + spacer3 + output_prod_archive;
		// output_append := main_head + output_cert_realtime + spacer + output_cert_archive + spacer2 + output_prod_realtime + spacer3 + output_prod_archive;
		output_full := SORT(output_append, order);

		MyRec Xform(myrec L,myrec R) := TRANSFORM
				SELF.line := TRIM(L.line, LEFT) + '\n' + TRIM(R.line, LEFT); 
				self := l;
		END;

		XtabOut := ITERATE(output_full, Xform(LEFT, RIGHT));

		final := FileServices.SendEmail(Scoring_Project_DailyTracking.email_distribution.prod_reports, 'Prod Tracking Report: MaxDiff ' + max_diff, XtabOut[COUNT(XtabOut)].line);
		// final := FileServices.SendEmail('Bridgett.braaten@lexisnexis.com', 'Capone Prod Tracking Report: MaxDiff ' + max_diff, XtabOut[COUNT(XtabOut)].line);

		RETURN final;
END;	
// final;
