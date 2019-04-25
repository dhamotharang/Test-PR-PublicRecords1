

import ut,std;
// import RiskView_Attributes_Reports;

import Scoring_Project_Macros,scoring_project_pip,Scoring_Project_DailyTracking;
	a:= ut.GetDate;
fn_LastTwoMonths(string10 date_inp,integer offset) := function
res  := GLOBAL(ut.DateFrom_DaysSince1900(ut.DaysSince1900(date_inp[1..4], date_inp[5..6], date_inp[7..8]) - offset));
return res[1..8];
end;

b:=fn_LastTwoMonths(a,1);

	curr_date:= a +'_1';


prev_date:=b +'_1';

// ip:=ut.foreign_dataland_boca;


ip:='~';


// all file names changed to scoringqa::out*  06/24/2014



  	fp1:= Scoring_QA_Risk_Indicator_Report.Risk_Indicator_report_fp31505_0(ip,'fla_',curr_date,prev_date): PERSIST('BWR1_fp1');
  	fp2:= Scoring_QA_Risk_Indicator_Report.Risk_Indicator_report_fp31505_0(ip,'flad_',curr_date,prev_date): PERSIST('BWR1_fp2');
  	fp3:= Scoring_QA_Risk_Indicator_Report.Risk_Indicator_report_fp31505_0(ip,'flap_',curr_date,prev_date): PERSIST('BWR1_fp3');
  	fp4:= Scoring_QA_Risk_Indicator_Report.Risk_Indicator_report_fp31505_0(ip,'flapd_',curr_date,prev_date): PERSIST('BWR1_fp4');
  	fp5:= Scoring_QA_Risk_Indicator_Report.Risk_Indicator_report_fp31505_0(ip,'flaps_',curr_date,prev_date): PERSIST('BWR1_fp5');
  	fp6:= Scoring_QA_Risk_Indicator_Report.Risk_Indicator_report_fp31505_0(ip,'flapsd_',curr_date,prev_date): PERSIST('BWR1_fp6');
  	fp7:= Scoring_QA_Risk_Indicator_Report.Risk_Indicator_report_fp31505_0(ip,'flas_',curr_date,prev_date): PERSIST('BWR1_fp7');
  	fp8:= Scoring_QA_Risk_Indicator_Report.Risk_Indicator_report_fp31505_0(ip,'flasd_',curr_date,prev_date): PERSIST('BWR1_fp8');
  	fp9:= Scoring_QA_Risk_Indicator_Report.Risk_Indicator_report_fp31505_0(ip,'flps_',curr_date,prev_date): PERSIST('BWR1_fp9');
  	fp10:= Scoring_QA_Risk_Indicator_Report.Risk_Indicator_report_fp31505_0(ip,'flpsd_',curr_date,prev_date): PERSIST('BWR1_fp10');
  	fp11:= Scoring_QA_Risk_Indicator_Report.Risk_Indicator_report_fp31505_0(ip,'fls_',curr_date,prev_date): PERSIST('BWR1_fp11');
  	fp12:= Scoring_QA_Risk_Indicator_Report.Risk_Indicator_report_fp31505_0(ip,'flsd_',curr_date,prev_date): PERSIST('BWR1_fp12');

		
		
		    final_rpt:= fp1 + fp2 + fp3 + fp4 + fp5 + fp6 + fp7 + fp8 + fp9 + fp10 + fp11 + fp12;
										 
		

				
														
			  final_rpt1:=sort(final_rpt,-abs_proportion_diff):PERSIST('BWR1_final_fp');	
				
	      // final_rpt2:=final_rpt1(abs_proportion_diff>=0.0025);




      	 
	//let us write to a files iwth csv format
			
			out_file := output(choosen(final_rpt1,all), ,'~RiskView_Scoring_Reports::out::BSS_riskindicator_fp31505::bss' + curr_date, CSV(heading(single), quote('"')), overwrite,EXPIRE(10) );
			
			
				string out_file_layout := '';
      outfile := dataset('~RiskView_Scoring_Reports::out::BSS_riskindicator_fp31505::bss' + curr_date, typeof(out_file_layout));
			

        no_of_records := count(outfile);
      			
      	
       			myrec := record, maxlength(9999999) 
         			unsigned code0; 
         			unsigned code1;
         			string line;
      				end;
         
         			myrec ref(outfile l, integer c) := transform 
         			self.code0 := c; 
         			self.code1 := c + 1 ;
         			self := l; 
      				end;
         
         			outputs := project(outfile, ref(left, counter));
         			
         			// outputs;
         
         			MyRec Xform(myrec L,myrec R) := TRANSFORM
         			SELF.line := trim(L.line, left, right) + '\n' + trim(R.line, left, right); 
         			self := l;
         			END;
         
         			XtabOut := iterate(outputs,Xform(left,right));
         			
         			
               // XtabOut[no_of_records];
         
         				
																		 

         
         
       																		 
   SEQUENTIAL(out_file,
	 
	 fileservices.SendEmailAttachText(Scoring_Project_DailyTracking.email_distribution.BSS_Success_list,
// fileservices.SendEmailAttachText('bridgett.braaten@lexisnexis.com',					
					'BSS RiskIndicator Distribution Report',
																				'BUSINESS SERVICES SCORING(BSS)RiskIndicator Distribution FP31505 Report '+ curr_date + ' vs ' + prev_date + '\n Please view attachment.',
																				 XtabOut[no_of_records].line ,
																				 'text/plain; charset=ISO-8859-3', 
																				'BSS_RiskIndicatorDistribution_FP31505' + curr_date + '_vs_' + prev_date + '.csv',
																				 ,
																				 ,
																				 'Scoring_QA@risk.lexisnexis.com')   	
	          
  
	);
   
    
   EXPORT bss_fp31505scores := 'todo';

