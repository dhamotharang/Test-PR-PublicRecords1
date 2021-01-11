EXPORT BusinessShell_Tracking_Report_new := Function
import ut;
import std, Scoring_Project,Scoring_Project_PIP, ashirey,Scoring_Project_Macros,  Scoring_Project_DailyTracking;

dt := ut.getdate;
decimal19_2 thresh := 1.00;
// decimal19_2 thresh := 0;

	

// ******** START: NON FCRA CURRENT MODE CALCULATIONS *********************************************************************************************************************

nonfcra_ds_curr := distribute(dataset('~ScoringQA::out::NONFCRA::BusinessShell_xml_generic_attributes_v2_' + dt + '_1', Scoring_Project_Macros.Global_Output_Layouts.BusinessShell_Attributes_V2_XML_Generic_Global_Layout, thor)(length(trim(errorcode,left,right))= 0 ),(integer)acctno);


nonfcra_filenames_details :=  nothor(STD.File.LogicalFileList('ScoringQA::out::NONFCRA::BusinessShell_xml_generic_attributes_v2_*_1'));


nonfcra_filelist := sort(nonfcra_filenames_details, -modified);

nonfcra_p_file_name := nonfcra_filelist[2].name;
nonfcra_prev_date := nonfcra_p_file_name[length(nonfcra_p_file_name)-9.. length(nonfcra_p_file_name)-2];

cleaned_nonfcra_curr_date := dt;
cleaned_nonfcra_prev_date := nonfcra_prev_date;

nonfcra_ds_prev := distribute(dataset('~'+ nonfcra_p_file_name, Scoring_Project_Macros.Global_Output_Layouts.BusinessShell_Attributes_V2_XML_Generic_Global_Layout, thor)(length(trim(errorcode,left,right))= 0 ),(integer)acctno);

clean_prev := nonfcra_ds_prev(errorcode = '');
clean_curr := nonfcra_ds_curr(errorcode = '');

ashirey.flatten(clean_prev,clean_ds_1_flat);
ashirey.flatten(clean_curr,clean_ds_2_flat);

ds_results2 := Scoring_Project_PIP.Compare_dsets_macro_email(clean_ds_1_flat, clean_ds_2_flat, ['acctno'], thresh);

ds_results := ds_results2(field <> 'time_ms');


		
		MyRec := RECORD
			INTEGER order;
			STRING line;
		END;

		max_diff := (STRING)ds_results[1].diff_pct	 + '%';
		
		
		
		ds_no_diff := DATASET([{2, 'No differences exceeding the ' + thresh + '% threshold'}], MyRec);
		
		STRING filler := '        ';

		outfile_cert_realtime := IF(COUNT(ds_results) > 0,
																			PROJECT(ds_results, TRANSFORM(MyRec, SELF.order := 2;
																			SELF.line := (TRIM(LEFT.Field) + filler)[1..50] + (LEFT.diff_cnt	 + filler)[1..10] + (LEFT.diff_pct	 + '%'+filler)[1..10]+ (left.up_cnt + filler)[1..10]    + (left.up_pct + '%'+filler)[1..10] + (left.down_cnt + filler)[1..10]    + (left.down_pct + '%')[1..10]     )),
																			ds_no_diff);

																			
		line_heading := ('Field' + filler)[1..50] + ('Diff Cnt' + filler)[1..10] + ('Diff Pct' + filler)[1..10]+ ('Up Cnt' + filler)[1..10]+ ('Up Pct' + filler)[1..10]+('Down Cnt' + filler)[1..10] + ('Down Pct' + filler)[1..10];

		main_head := DATASET([{1,   'BusinessShell Tracking Report' + '\n'
													+ '*** This report is produced by Scoring QA ***' + '\n\n'
													}], MyRec); 		
				
		head_cert_realtime := DATASET([{1,    
														'Environment:  CERT - NONFCRA'	+ '\n'
													+ 'Archive date:  999999' + '\n'
													+ 'Previous run date:  ' + cleaned_nonfcra_prev_date + '\n'
													+ 'Current run date:  ' + cleaned_nonfcra_curr_date + '\n' 
													+ 'Previous record count:  ' + COUNT(clean_prev) + '\n'
													+ 'Current record count:  ' + COUNT(clean_curr) + '\n'
													+ 'Compared records:  ' + ds_results[1].total_cnt + '\n'
													+ 'Threshold:  ' + thresh + '%' + '\n'  
													+ '\n' 
													+ line_heading + '\n'
													+ '-----------------------------------------------------------------------------------------------------------------'
													}], MyRec); 
													

		

		output_cert_realtime := PROJECT(SORT(head_cert_realtime + outfile_cert_realtime, order), TRANSFORM(MyRec, SELF.order := 2; SELF := LEFT));
	

		output_append := main_head + output_cert_realtime ;


		MyRec Xform(myrec L,myrec R) := TRANSFORM
				SELF.line := TRIM(L.line, LEFT) + '\n' + TRIM(R.line, LEFT); 
				self := l;
		END;

		XtabOut := ITERATE(output_append, Xform(LEFT, RIGHT));

		 final := FileServices.SendEmail(Scoring_Project_DailyTracking.email_distribution.business_reports, 'BusinessShell Tracking Report: MaxDiff ' + max_diff, XtabOut[COUNT(XtabOut)].line):
		 // final := FileServices.SendEmail('Bridgett.braaten@lexisnexis.com;' , 'Business Shell Cert Attributes Tracking Report: MaxDiff ' + max_diff, XtabOut[COUNT(XtabOut)].line):
	
									FAILURE(FileServices.SendEmail(Scoring_Project_DailyTracking.email_distribution.Bocashell_collections_fail_list,'Business Shell Cert Tracking job failed','The failed workunit is:' + WORKUNIT + FAILMESSAGE));

		RETURN final;
END;	

