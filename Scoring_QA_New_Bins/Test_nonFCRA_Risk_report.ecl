import ut,std;
// import RiskView_Attributes_Reports;

import Scoring_Project_Macros,scoring_project_pip,Scoring_Project_DailyTracking, Scoring_QA_Risk_Indicator_Report, Scoring_QA;
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



  	rpt1:= Scoring_QA_Risk_Indicator_Report.compare_function_batch_fcra_rvscores_v3(ip,curr_date,prev_date): PERSIST('BWR1_rpt1');
		rpt2:= Scoring_QA_Risk_Indicator_Report.compare_function_batch_fcra_rvscores_v4(ip,curr_date,prev_date): PERSIST('BWR1_rpt2');		
		rpt3:= Scoring_QA_Risk_Indicator_Report.compare_function_fcra_rvscores_v4(ip,curr_date,prev_date): PERSIST('BWR1_rpt3');
   	rpt4:= Scoring_QA_Risk_Indicator_Report.compare_function_rvscores_v3(ip,curr_date,prev_date): PERSIST('BWR1_rpt4');
		// rpt5:=Scoring_QA_Risk_Indicator_Report.compare_function_best_buy_custom_chargeback_defender_score(ip,curr_date,prev_date): PERSIST('BWR1_rpt5');	
		rpt6:=Scoring_QA_Risk_Indicator_Report.compare_function_business_instant_id_cust_rec(ip,curr_date,prev_date): PERSIST('BWR1_rpt6');//done
		rpt7:=Scoring_QA_Risk_Indicator_Report.compare_function_business_instant_id_cust_rec_batch(ip,curr_date,prev_date): PERSIST('BWR1_rpt7');	
		rpt8:=Scoring_QA_Risk_Indicator_Report.compare_function_biid_xml_chase(ip,curr_date,prev_date): PERSIST('BWR1_rpt8');//done		
		rpt9:=Scoring_QA_Risk_Indicator_Report.compare_function_nonfcra_liscores_batch_v4(ip,curr_date,prev_date): PERSIST('BWR1_rpt9');
		// rpt10:=Scoring_QA_Risk_Indicator_Report.compare_function_fp_scores_batch_v2(ip,curr_date,prev_date): PERSIST('BWR1_rpt10');		
		// rpt11:= Scoring_QA_Risk_Indicator_Report.compare_function_nonfcra_fpscores_v2(ip,curr_date,prev_date): PERSIST('BWR1_rpt11');	
		rpt22:= Scoring_QA_Risk_Indicator_Report.compare_function_nonfcra_fpscores_v3(ip,curr_date,prev_date): PERSIST('BWR1_rpt22');
		rpt12:= Scoring_QA_Risk_Indicator_Report.compare_function_nonfcra_liscores_v4_msn1106(ip,curr_date,prev_date): PERSIST('BWR1_rpt12');		
		// rpt13:=Scoring_QA_Risk_Indicator_Report.compare_function_regional_acceptance_rva1008_1(ip,curr_date,prev_date): PERSIST('BWR1_rpt13');	
	  rpt14:=Scoring_QA_Risk_Indicator_Report.compare_function_riskprocessing_instant_id(ip,curr_date,prev_date): PERSIST('BWR1_rpt14');	
		rpt15:=Scoring_QA_Risk_Indicator_Report.compare_function_riskprocessing_instant_id_batch(ip,curr_date,prev_date): PERSIST('BWR1_rpt15');
		// rpt16:=Scoring_QA_Risk_Indicator_Report.compare_function_riskviewv2_xml_enova1103(ip,curr_date,prev_date): PERSIST('BWR1_rpt16');		
		// rpt17:=Scoring_QA_Risk_Indicator_Report.compare_function_santander_rva1304_1(ip,curr_date,prev_date): PERSIST('BWR1_rpt17');
		// rpt18:=Scoring_QA_Risk_Indicator_Report.compare_function_santander_rva1304_2(ip,curr_date,prev_date): PERSIST('BWR1_rpt18');		
		// rpt19:= Scoring_QA_Risk_Indicator_Report.compare_function_t_mobile_rvt1210_1_cust_rec(ip,curr_date,prev_date): PERSIST('BWR1_rpt19');
		// rpt20:= Scoring_QA_Risk_Indicator_Report.compare_function_t_mobile_rvt1212_1_cust_rec(ip,curr_date,prev_date): PERSIST('BWR1_rpt20');		
		rpt21:=Scoring_QA_Risk_Indicator_Report.compare_function_XML_fcra_rvscores_v5(ip,curr_date,prev_date): PERSIST('BWR1_rpt21');	
		rpt23:=Scoring_QA_Risk_Indicator_Report.compare_function_fp_scores_batch_v201_AMEX(ip,curr_date,prev_date): PERSIST('BWR1_rpt23');	
		
		
		
		    final_rpt:=  rpt6 + rpt7 + rpt8  +  rpt9 +  rpt12 + rpt14 + rpt15 + rpt23;
										 
		

				
														
			  final_rpt1:=sort(final_rpt,-abs_proportion_diff):PERSIST('BWR1_final');	
				
	      // final_rpt2:=final_rpt1(abs_proportion_diff>=0.0025);




      	 
	//let us write to a files iwth csv format
			
			out_file := output(choosen(final_rpt1,all), ,'~RiskView_Scoring_Reports::out::BSS_riskindicator::bss' + curr_date, CSV(heading(single), quote('"')), overwrite,EXPIRE(10) );
			
			
				string out_file_layout := '';
      outfile := dataset('~RiskView_Scoring_Reports::out::BSS_riskindicator::bss' + curr_date, typeof(out_file_layout));
			

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
																				'BUSINESS SERVICES SCORING(BSS)nonFCRA RiskIndicator Distribution Report '+ curr_date + ' vs ' + prev_date + '\n Please view attachment.',
																				 XtabOut[no_of_records].line ,
																				 'text/plain; charset=ISO-8859-3', 
																				'BSS_RiskIndicatorDistribution_' + curr_date + '_vs_' + prev_date + '.csv',
																				 ,
																				 ,
																				 'Scoring_QA@risk.lexisnexis.com')   	
	          
  
	);
   
    
   
    
EXPORT Test_nonFCRA_Risk_report := 'todo';