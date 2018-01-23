EXPORT BocaShell_Cert_Detailed_Tracking := function
XPORT BocaShell_41_Cert_Tracking_DailyReport := FUNCTION

import ut;
import std, Scoring_Project, ashirey,Scoring_Project_Macros;

dt := ut.getdate;
decimal19_2 thresh := 1.25;


ds_curr := dataset('~scoringqa::out::fcra::bocashell_41_historydate_999999_cert_' + dt + '_1', Scoring_Project_Macros.Global_Output_Layouts.BocaShell_Global_Layout, thor)(length(trim(errorcode,left,right))= 0 );
// bs_cert_curr_choosen := choosen(bs_cert_curr, 10);
// bs_cert_curr_choosen;

filenames_details :=  nothor(STD.File.LogicalFileList('scoringqa::out::fcra::bocashell_41_historydate_999999_cert_*_1'));


filelist := sort(filenames_details, -modified);

p_file_name := filelist[2].name;
prev_date := p_file_name[length(p_file_name)-9.. length(p_file_name)-2];

cleaned_curr_date := dt;
cleaned_prev_date := prev_date;

ds_prev := dataset('~'+ p_file_name, Scoring_Project_Macros.Global_Output_Layouts.BocaShell_Global_Layout, thor)(length(trim(errorcode,left,right))= 0 );

ds_resultsFCRA_41 := zz_bbraaten2.Compare_dsets_macro_email(ds_prev, ds_curr, ['acctno'], thresh);

re_filter2_FCRA_41 := ds_resultsFCRA_41(field <> 'time_ms');


 //******** START: NON FCRA CURRENT MODE CALCULATIONS *********************************************************************************************************************

nonfcra_ds_curr := dataset('~scoringqa::out::nonfcra::bocashell_41_historydate_999999_cert_' + dt + '_1', Scoring_Project_Macros.Global_Output_Layouts.BocaShell_Global_Layout, thor)(length(trim(errorcode,left,right))= 0 );


nonfcra_filenames_details :=  nothor(STD.File.LogicalFileList('scoringqa::out::nonfcra::bocashell_41_historydate_999999_cert_*_1'));


nonfcra_filelist := sort(nonfcra_filenames_details, -modified);

nonfcra_p_file_name := nonfcra_filelist[2].name;
nonfcra_prev_date := nonfcra_p_file_name[length(nonfcra_p_file_name)-9.. length(nonfcra_p_file_name)-2];

cleaned_nonfcra_curr_date := dt;
cleaned_nonfcra_prev_date := nonfcra_prev_date;

nonfcra_ds_prev := dataset('~'+ nonfcra_p_file_name, Scoring_Project_Macros.Global_Output_Layouts.BocaShell_Global_Layout, thor)(length(trim(errorcode,left,right))= 0 );

ds_resultsNonFCRA_41 := zz_bbraaten2.Compare_dsets_macro_email(nonfcra_ds_prev, nonfcra_ds_curr, ['acctno'], thresh);

re_filter2_NonFCRA_41 := ds_resultsNonFCRA_41(field <> 'time_ms');
// ******** END: NonFCRA CURRENT MODE CALCULATIONS *********************************************************************************************************************recrd, fcra_filter_join.field_name);


ds_curr_50 := dataset('~scoringqa::out::fcra::bocashell_50_historydate_999999_cert_' + dt + '_1', Scoring_Project_Macros.Global_Output_Layouts.BocaShell_Global_Layout, thor)(length(trim(errorcode,left,right))= 0 );


filenames_details_50 :=  nothor(STD.File.LogicalFileList('scoringqa::out::fcra::bocashell_50_historydate_999999_cert_*_1'));


filelist_50 := sort(filenames_details, -modified);

p_file_name_50 := filelist[2].name;
prev_date_50 := p_file_name[length(p_file_name)-9.. length(p_file_name)-2];

cleaned_curr_date_50 := dt;
cleaned_prev_date_50 := prev_date;

ds_prev_50 := dataset('~'+ p_file_name, Scoring_Project_Macros.Global_Output_Layouts.BocaShell_Global_Layout, thor)(length(trim(errorcode,left,right))= 0 );

ds_resultsFCRA_50 := zz_bbraaten2.Compare_dsets_macro_email(ds_prev_50, ds_curr_50, ['acctno'], thresh);

re_filter2_FCRA_50 := ds_resultsFCRA_50(field <> 'time_ms');

// ******** END: NonFCRA CURRENT MODE CALCULATIONS *********************************************************************************************************************recrd, fcra_filter_join.field_name);


nonfcra_ds_curr_50 := dataset('~scoringqa::out::nonfcra::bocashell_50_historydate_999999_cert_' + dt + '_1', Scoring_Project_Macros.Global_Output_Layouts.BocaShell_Global_Layout, thor)(length(trim(errorcode,left,right))= 0 );


nonfcra_filenames_details_50 :=  nothor(STD.File.LogicalFileList('scoringqa::out::nonfcra::bocashell_50_historydate_999999_cert_*_1'));


nonfcra_filelist_50 := sort(nonfcra_filenames_details, -modified);

nonfcra_p_file_name_50 := nonfcra_filelist[2].name;
nonfcra_prev_date_50 := nonfcra_p_file_name[length(nonfcra_p_file_name)-9.. length(nonfcra_p_file_name)-2];

cleaned_nonfcra_curr_date_50 := dt;
cleaned_nonfcra_prev_date_50 := nonfcra_prev_date;

nonfcra_ds_prev_50 := dataset('~'+ nonfcra_p_file_name, Scoring_Project_Macros.Global_Output_Layouts.BocaShell_Global_Layout, thor)(length(trim(errorcode,left,right))= 0 );
ds_resultsNonFCRA_50 := zz_bbraaten2.Compare_dsets_macro_email(nonfcra_ds_prev_50, nonfcra_ds_curr_50, ['acctno'], thresh);

re_filter2_NonFCRA_50 := ds_resultsNonFCRA_50(field <> 'time_ms');


// ******** END: NonFCRA CURRENT MODE CALCULATIONS *********************************************************************************************************************recrd, fcra_filter_join.field_name);



		MyRec := RECORD
			INTEGER order;
			STRING line;
		END;

		max_diff := (STRING)SORT(re_filter2_FCRA_41 + re_filter2_NonFCRA_41 + re_filter2_FCRA_50 + re_filter2_NonFCRA_50, -diff_pct)[1].diff_pct + '%';
		
		ds_no_diff := DATASET([{2, 'No differences exceeding the ' + thresh + '% threshold'}], MyRec);
		
		STRING filler := '                                                                                                                    ';

		outfile_cert_realtime := IF(COUNT(re_filter2_FCRA_41) > 0,
																			PROJECT(re_filter2_FCRA_41, TRANSFORM(MyRec, SELF.order := 2;
																			SELF.line := (TRIM(LEFT.Field) + filler)[1..50] + (LEFT.diff_cnt	 + filler)[1..10] + (LEFT.diff_pct	 + '%'+filler)[1..10]+ (left.up_cnt + filler)[1..10]    + (left.up_pct + '%'+filler)[1..10] + (left.down_cnt + filler)[1..10]    + (left.down_pct + '%')[1..10]     )),
																			ds_no_diff);
					
		outfile_cert_archive := IF(COUNT(re_filter2_NonFCRA_41) > 0,
																			PROJECT(re_filter2_NonFCRA_41, TRANSFORM(MyRec, SELF.order := 2;
																			SELF.line := (TRIM(LEFT.Field) + filler)[1..50] + (LEFT.diff_cnt	 + filler)[1..10] + (LEFT.diff_pct	 + '%'+filler)[1..10]+ (left.up_cnt + filler)[1..10]    + (left.up_pct + '%'+filler)[1..10] + (left.down_cnt + filler)[1..10]    + (left.down_pct + '%')[1..10]     )),
																			ds_no_diff);
																			
		outfile_prod_realtime := IF(COUNT(re_filter2_FCRA_50) > 0,
																			PROJECT(re_filter2_FCRA_50, TRANSFORM(MyRec, SELF.order := 2;
																			SELF.line := (TRIM(LEFT.Field) + filler)[1..50] + (LEFT.diff_cnt	 + filler)[1..10] + (LEFT.diff_pct	 + '%'+filler)[1..10]+ (left.up_cnt + filler)[1..10]    + (left.up_pct + '%'+filler)[1..10] + (left.down_cnt + filler)[1..10]    + (left.down_pct + '%')[1..10]     )),
																			ds_no_diff);
																			
		outfile_prod_archive := IF(COUNT(re_filter2_NonFCRA_50) > 0,
																			PROJECT(re_filter2_NonFCRA_50, TRANSFORM(MyRec, SELF.order := 2;
																			SELF.line := (TRIM(LEFT.Field) + filler)[1..50] + (LEFT.diff_cnt	 + filler)[1..10] + (LEFT.diff_pct	 + '%'+filler)[1..10]+ (left.up_cnt + filler)[1..10]    + (left.up_pct + '%'+filler)[1..10] + (left.down_cnt + filler)[1..10]    + (left.down_pct + '%')[1..10]     )),
																			ds_no_diff);
																			
		line_heading := ('Fielde' + filler)[1..50] + ('Diff Cnt' + filler)[1..10] + ('Diff Pct' + filler)[1..10]+ ('Up Cnt' + filler)[1..10]+ ('Up Pct' + filler)[1..10]+('Down Cnt' + filler)[1..10] + ('Down Pct' + filler)[1..10];

		main_head := DATASET([{1,   'BocaShell Cert Attributes Tracking Report' + '\n'
													+ '*** This report is produced by Scoring QA ***' + '\n\n'
													}], MyRec); 		
				
		head_cert_realtime := DATASET([{1,    
														'Environment:  CERT - FCRA 41'	+ '\n'
													+ 'Archive date:  999999' + '\n'
													+ 'Previous run date:  ' + ds_prev + '\n'
													+ 'Current run date:  ' + ds_curr + '\n' 
													+ 'Previous record count:  ' + COUNT(cleaned_prev_date) + '\n'
													+ 'Current record count:  ' + COUNT(cleaned_curr_date) + '\n'
													+ 'Compared records:  ' + COUNT(re_filter2_FCRA_41[1].total_cnt) + '\n'
													+ 'Threshold:  ' + thresh + '%' + '\n'  
													+ '\n' 
													+ line_heading + '\n'
													+ '-----------------------------------------------------------------------------------------------------------------'
													}], MyRec); 
													

		head_cert_archive := DATASET([{1,    
														'Environment:  CERT - NONFCRA 41'	+ '\n'
													+ 'Archive date:  999999' + '\n'
													+ 'Previous run date:  ' + nonfcra_ds_curr + '\n'
													+ 'Current run date:  ' + cleaned_curr_date + '\n' 
													+ 'Previous record count:  ' + COUNT(cleaned_nonfcra_prev_date) + '\n'
													+ 'Current record count:  ' + COUNT(cleaned_nonfcra_curr_date) + '\n'
													+ 'Compared records:  ' + COUNT(re_filter2_NonFCRA_41[1].total_cnt) + '\n'
													+ 'Threshold:  ' + thresh + '%' + '\n'  
													+ '\n' 
													+ line_heading + '\n'
													+ '-----------------------------------------------------------------------------------------------------------------'
													}], MyRec);
													
		head_prod_realtime := DATASET([{1,    
														'Environment:  CERT - FCRA 50'	+ '\n'
													+ 'Archive date:  999999' + '\n'
													+ 'Previous run date:  ' + ds_prev_50 + '\n'
													+ 'Current run date:  ' + ds_curr_50 + '\n' 
													+ 'Previous record count:  ' + COUNT(cleaned_prev_date_50) + '\n'
													+ 'Current record count:  ' + COUNT(cleaned_curr_date_50) + '\n'
													+ 'Compared records:  ' + COUNT(re_filter2_FCRA_50[1].total_cnt) + '\n'
													+ 'Threshold:  ' + thresh + '%' + '\n'  
													+ '\n' 
													+ line_heading + '\n'
													+ '-----------------------------------------------------------------------------------------------------------------'
													}], MyRec); 
													

		head_prod_archive := DATASET([{1,    
														'Environment:  CERT - NONFCRA 50'	+ '\n'
													+ 'Archive date:  999999' + '\n'
													+ 'Previous run date:  ' + nonfcra_ds_curr_50 + '\n'
													+ 'Current run date:  ' + cleaned_curr_date_50 + '\n' 
													+ 'Previous record count:  ' + COUNT(cleaned_nonfcra_prev_date_50) + '\n'
													+ 'Current record count:  ' + COUNT(cleaned_nonfcra_curr_date_50) + '\n'
													+ 'Compared records:  ' + COUNT(re_filter2_NonFCRA_50[1].total_cnt) + '\n'
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

		 // final := FileServices.SendEmail(Scoring_Project_DailyTracking.email_distribution.general_list_all, 'BocaShell 4.1 Cert Tracking Report: MaxDiff ' + max_diff, XtabOut[COUNT(XtabOut)].line):
		final := FileServices.SendEmail('Bridgett.Braaten@lexisnexis.com', 'BocaShell Detailed Cert Tracking Report: MaxDiff ' + max_diff, XtabOut[COUNT(XtabOut)].line):
		// final := FileServices.SendEmail(Scoring_Project_DailyTracking.email_distribution.fail_list, 'TEST......LeadIntegrity 4.1 Daily Tracking Report: MaxDiff ' + max_diff, XtabOut[COUNT(XtabOut)].line):
									// WHEN(CRON('0 11 * * *')), //run at 6:00 AM
									FAILURE(FileServices.SendEmail('Bridgett.Braaten@lexisnexis.com','BocaShell Detailed Cert Tracking CRON job failed','The failed workunit is:' + WORKUNIT + FAILMESSAGE));

		RETURN final;
END;	
// final;