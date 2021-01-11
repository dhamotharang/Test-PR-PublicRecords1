EXPORT Address_Shell_Tracking_DailyReport := FUNCTION
// #workunit('name','AddressShell_DailyReport');
import ut;
import std, Scoring_Project, ashirey,Scoring_Project_Macros,  Scoring_Project_DailyTracking;

dt := ut.getdate;
decimal19_2 thresh := 1.00;

	
// ******** START: NON FCRA CURRENT MODE CALCULATIONS *********************************************************************************************************************

nonfcra_ds_curr := distribute(dataset('~scoringqa::out::nonfcra::addressshell_batch_generic_attributes_v1_' + dt + '_1', 	Scoring_Project_Macros.Global_Output_Layouts.AddressShell_Attributes_V1_BATCH_Generic_Global_Layout, thor)(length(trim(errorcode,left,right))= 0 ),(integer)acctno);


nonfcra_filenames_details :=  nothor(STD.File.LogicalFileList('scoringqa::out::nonfcra::addressshell_batch_generic_attributes_v1_*_1'));


nonfcra_filelist := sort(nonfcra_filenames_details, -modified);

nonfcra_p_file_name := nonfcra_filelist[2].name;
nonfcra_prev_date := nonfcra_p_file_name[length(nonfcra_p_file_name)-9.. length(nonfcra_p_file_name)-2];

cleaned_nonfcra_curr_date := dt;
cleaned_nonfcra_prev_date := nonfcra_prev_date;

nonfcra_ds_prev := distribute(dataset('~'+ nonfcra_p_file_name, Scoring_Project_Macros.Global_Output_Layouts.AddressShell_Attributes_V1_BATCH_Generic_Global_Layout, thor)(length(trim(errorcode,left,right))= 0 ),(integer)acctno);


		nonfcra_join1 := JOIN(nonfcra_ds_curr, nonfcra_ds_prev, LEFT.acctno=RIGHT.acctno, transform(left));
		nonfcra_clean_file := nonfcra_join1(acctno <> '');
		nonfcra_ds_curr_join := JOIN(nonfcra_ds_curr, nonfcra_clean_file, LEFT.acctno=RIGHT.acctno, transform(left));
		nonfcra_ds_prev_join := JOIN(nonfcra_ds_prev, nonfcra_clean_file, LEFT.acctno=RIGHT.acctno, transform(left));

/* LAYOUT FLATTENING */ 
				 ashirey.flatten(nonfcra_ds_curr_join, nonfcra_curr_output, ,true , ,);
         ashirey.flatten(nonfcra_ds_prev_join, nonfcra_prev_output, ,true , ,);
         nonfcra_curr_ds := Scoring_Project.BocaShell_Normalized_Code(nonfcra_curr_output, 'acctno');
         nonfcra_prev_ds := 	Scoring_Project.BocaShell_Normalized_Code(nonfcra_prev_output, 'acctno');
         
         nonfcra_layout := record
         recordof(nonfcra_curr_ds);
         Integer flag;
         end;
         
         
         nonfcra_jn := JOIN(nonfcra_curr_ds, nonfcra_prev_ds, left.accountnumber = right.accountnumber and
         														 left.field_name = right.field_name,
         														TRANSFORM(nonfcra_layout, 
         																			self.flag := If(left.field_value <> right.field_value, 1, 0);
         																			self := Left;
         																			));
         														
         nonfcra_filter_join := nonfcra_jn(flag = 1, field_name <> 'proflic_build_date');	
         
         nonfcra_recrd := record
         nonfcra_filter_join.field_name;
         Integer Difference_count := count(group);
         decimal19_2  Difference_Percent :=  (count(group)/count(nonfcra_ds_curr_join))*100;
         end;
         
         nonfcra_result := table(nonfcra_filter_join, nonfcra_recrd, nonfcra_filter_join.field_name);



re_filter1_nonfcra := nonfcra_result(field_name not in ['time_ms'], Difference_Percent > thresh);
re_filter2_nonfcra := SORT(re_filter1_nonfcra, -Difference_Percent);

// ******** END: NonFCRA CURRENT MODE CALCULATIONS *********************************************************************************************************************



		
		MyRec := RECORD
			INTEGER order;
			STRING line;
		END;

		max_diff := (STRING)SORT(re_filter1_nonfcra, -Difference_Percent)[1].Difference_Percent + '%';
		
		ds_no_diff := DATASET([{2, 'No differences exceeding the ' + thresh + '% threshold'}], MyRec);
		
		STRING filler := '                                                                                                                    ';

		outfile_cert_realtime := IF(COUNT(re_filter2_nonfcra) > 0,
																			PROJECT(re_filter2_nonfcra, TRANSFORM(MyRec, SELF.order := 2;
																			SELF.line := (TRIM(LEFT.Field_Name) + filler)[1..75] + (LEFT.Difference_count + filler)[1..25] + LEFT.Difference_Percent + '%')),
																			ds_no_diff);

																			
		line_heading := ('Field Name' + filler)[1..75] + ('Difference Count' + filler)[1..25] + 'Difference Percent';

		main_head := DATASET([{1,   'AddressShell Cert Attributes Tracking Report' + '\n'
													+ '*** This report is produced by Scoring QA ***' + '\n\n'
													}], MyRec); 		
				
		head_cert_realtime := DATASET([{1,    
														'Environment:  CERT - NONFCRA'	+ '\n'
													+ 'Archive date:  999999' + '\n'
													+ 'Previous run date:  ' + cleaned_nonfcra_prev_date + '\n'
													+ 'Current run date:  ' + cleaned_nonfcra_curr_date + '\n' 
													+ 'Previous record count:  ' + COUNT(nonfcra_ds_prev) + '\n'
													+ 'Current record count:  ' + COUNT(nonfcra_ds_curr) + '\n'
													+ 'Compared records:  ' + COUNT(nonfcra_clean_file) + '\n'
													+ 'Threshold:  ' + thresh + '%' + '\n'  
													+ '\n' 
													+ line_heading + '\n'
													+ '-----------------------------------------------------------------------------------------------------------------'
													}], MyRec); 
													

		

		output_cert_realtime := PROJECT(SORT(head_cert_realtime + outfile_cert_realtime, order), TRANSFORM(MyRec, SELF.order := 2; SELF := LEFT));
	

		output_append := main_head + output_cert_realtime ;
		output_full := SORT(output_append, order);
		// OUTPUT(output_full, NAMED('output_full'));

		MyRec Xform(myrec L,myrec R) := TRANSFORM
				SELF.line := TRIM(L.line, LEFT) + '\n' + TRIM(R.line, LEFT); 
				self := l;
		END;

		XtabOut := ITERATE(output_full, Xform(LEFT, RIGHT));
  	// OUTPUT(XtabOut, NAMED('XtabOut'));

		 final := FileServices.SendEmail(Scoring_Project_DailyTracking.email_distribution.addr_reports, 'AddressShell Cert Tracking Report: MaxDiff ' + max_diff, XtabOut[COUNT(XtabOut)].line):
		// final := FileServices.SendEmail('Bridgett.braaten@lexisnexis.com;nathan.koubsky@lexisnexis.com', 'TEST...AddressShell Cert Tracking Report: MaxDiff ' + max_diff, XtabOut[COUNT(XtabOut)].line):
		// final := FileServices.SendEmail('Bridgett.braaten@lexisnexis.com', 'TEST...AddressShell Cert Tracking Report: MaxDiff ' + max_diff, XtabOut[COUNT(XtabOut)].line):
		// final := FileServices.SendEmail(Scoring_Project_DailyTracking.email_distribution.fail_list, 'TEST......LeadIntegrity 4.1 Daily Tracking Report: MaxDiff ' + max_diff, XtabOut[COUNT(XtabOut)].line):
									// WHEN(CRON('0 11 * * *')), //run at 6:00 AM
									// FAILURE(FileServices.SendEmail(Scoring_Project_DailyTracking.email_distribution.fail_list,'AddressShell Cert Tracking job failed','The failed workunit is:' + WORKUNIT + FAILMESSAGE));
									FAILURE(FileServices.SendEmail(Scoring_Project_DailyTracking.email_distribution.Bocashell_collections_fail_list,'AddressShell Cert Tracking job failed','The failed workunit is:' + WORKUNIT + FAILMESSAGE));

		RETURN final;
END;	
// final;