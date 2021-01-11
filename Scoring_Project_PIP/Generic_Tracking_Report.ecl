EXPORT Generic_Tracking_Report(ds, layout , type_, join_by) := Functionmacro
import ut;
import std, Scoring_Project, ashirey,Scoring_Project_Macros,  Scoring_Project_DailyTracking;

// layout := if((string)Type_ = 'FPV201', dataset(scoring_project_Macros.Global_Output_Layouts.NONFCRA_FraudPoint_V201_AmericanExpress_Global_Layout), (string)'');
// layout_in := Record
// recordof(layout;
// end;
// ds_type := string ds[length(ds)-13];

// ds_short := ds_type[length(ds_type)-11];

dt := ut.getdate;
	// dt1:= '20170904';

fn_LastTwoMonths(string10 date_inp,integer offset) := function
res  := GLOBAL(ut.DateFrom_DaysSince1900(ut.DaysSince1900(date_inp[1..4], date_inp[5..6], date_inp[7..8]) - offset));
return res[1..8];
end;

b:=fn_LastTwoMonths(dt,1);
// b:='20180621';
	

// decimal19_2 thresh := 1.00;
decimal19_2 thresh := 0;

	

// ******** START: NON FCRA CURRENT MODE CALCULATIONS *********************************************************************************************************************

// nonfcra_ds_curr := dataset('~ScoringQA::out::NONFCRA::Profile_Booster_Batch_CapitalOne_attributes_v1_' + dt + '_1', Scoring_Project_Macros.Global_Output_Layouts.ProfileBooster_layout, thor)(length(trim(errorcode,left,right))= 0 );
// nonfcra_ds_curr := dataset('~' + ds + dt + '_1', layout, thor)(length(trim(errorcode,left,right))= 0 );
nonfcra_ds_curr := distribute(dataset('~' + ds + dt + '_1', layout, thor),(integer)join_by);

// nonfcra_ds_curr := nonfcra_ds_curr_in(errorcdoe = '');

nonfcra_filenames_details :=  nothor(STD.File.LogicalFileList(ds +'*' + '_1'));
// nonfcra_filenames_details :=  nothor(STD.File.LogicalFileList('file'));


// nonfcra_filelist := sort(nonfcra_filenames_details, -modified);

// nonfcra_p_file_name := nonfcra_filelist[2].name;
// nonfcra_prev_date := nonfcra_p_file_name[length(nonfcra_p_file_name)-9.. length(nonfcra_p_file_name)-2];
nonfcra_prev_date := b; 


cleaned_nonfcra_curr_date := dt;
cleaned_nonfcra_prev_date := nonfcra_prev_date;



// nonfcra_ds_prev := dataset('~'+ nonfcra_p_file_name, Scoring_Project_Macros.Global_Output_Layouts.ProfileBooster_layout, thor)(length(trim(errorcode,left,right))= 0 );
// nonfcra_ds_prev := dataset('~'+ nonfcra_p_file_name, layout, thor)(length(trim(errorcode,left,right))= 0 );
nonfcra_ds_prev := distribute(dataset('~' + ds + nonfcra_prev_date + '_1', layout, thor),(integer)join_by);




clean_prev := nonfcra_ds_prev(errorcode = '');
clean_curr := nonfcra_ds_curr(errorcode = '');

ds_results2 := Scoring_Project_PIP.Compare_dsets_macro_email(clean_prev, clean_curr, [join_by], thresh);

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

		main_head := DATASET([{1,   type_ +' Cert Attributes Tracking Report' + '\n'
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


name := output(((string) type_+' '+ cleaned_nonfcra_curr_date + ' '+  'vs' + ' '+  nonfcra_prev_date));
out := Output(choosen(ds_results, all));

final := sequential(name, out);

		 // final := FileServices.SendEmail('Bridgett.braaten@lexisnexis.com', 'Cert Tracking Reports:', WORKUNIT):
	
									// FAILURE(FileServices.SendEmail('Bridgett.braaten@lexisnexis.com','Cert Tracking job failed','The failed workunit is:' + WORKUNIT + FAILMESSAGE));

		RETURN final;
	endmacro;