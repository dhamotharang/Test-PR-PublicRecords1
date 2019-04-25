import RiskView_Attributes_Reports;



import ut,std;
// import RiskView_Attributes_Reports;

	a:= ut.GetDate;
fn_LastTwoMonths(string10 date_inp,integer offset) := function
res  := GLOBAL(ut.DateFrom_DaysSince1900(ut.DaysSince1900(date_inp[1..4], date_inp[5..6], date_inp[7..8]) - offset));
return res[1..8];
end;

b:=fn_LastTwoMonths(a,1);

	a1:= a +'_1';


b1:=b +'_1';

  	rpt1:= RiskView_Attributes_Reports.compare_function_batch_fcra_rvscores_v3(a1,b1): PERSIST('BWR1_rpt1');
		rpt2:= RiskView_Attributes_Reports.compare_function_batch_fcra_rvscores_v4(a1,b1): PERSIST('BWR1_rpt2');
		rpt3:= RiskView_Attributes_Reports.compare_function_fcra_rvscores_v4(a1,b1): PERSIST('BWR1_rpt3');
		rpt4:= RiskView_Attributes_Reports.compare_function_nonfcra_fpscores_v2(a1,b1): PERSIST('BWR1_rpt4');
		rpt5:= RiskView_Attributes_Reports.compare_function_nonfcra_liscores_v4_msn1106(a1,b1): PERSIST('BWR1_rpt5');
		rpt6:= RiskView_Attributes_Reports.compare_function_rvscores_v3(a1,b1): PERSIST('BWR1_rpt6');
		rpt7:= RiskView_Attributes_Reports.compare_function_t_mobile_rvt1210_1_cust_rec(a1,b1): PERSIST('BWR1_rpt7');
		rpt8:= RiskView_Attributes_Reports.compare_function_t_mobile_rvt1212_1_cust_rec(a1,b1): PERSIST('BWR1_rpt8');
		rpt9:=RiskView_Attributes_Reports.compare_function_best_buy_custom_chargeback_defender_score(a1,b1): PERSIST('BWR1_rpt9');
	  rpt10:=RiskView_Attributes_Reports.compare_function_riskprocessing_instant_id(a1,b1): PERSIST('BWR1_rpt10');	
		rpt11:=RiskView_Attributes_Reports.compare_function_field_change(a1,b1): PERSIST('BWR1_rpt11');			
		rpt12:=RiskView_Attributes_Reports.compare_function_santander_rva1007_1(a1,b1): PERSIST('BWR1_rpt12');
		rpt13:=RiskView_Attributes_Reports.compare_function_santander_rva1007_2(a1,b1): PERSIST('BWR1_rpt13');
		rpt14:=RiskView_Attributes_Reports.compare_function_regional_acceptance_rva1008_1(a1,b1): PERSIST('BWR1_rpt14');		
		rpt15:=RiskView_Attributes_Reports.compare_function_business_instant_id_cust_rec(a1,b1): PERSIST('BWR1_rpt15');
		rpt16:=RiskView_Attributes_Reports.compare_function_business_instant_id_cust_rec_batch(a1,b1): PERSIST('BWR1_rpt16');
		rpt17:=RiskView_Attributes_Reports.compare_function_nonfcra_liscores_batch_v4(a1,b1): PERSIST('BWR1_rpt17');
		rpt18:=RiskView_Attributes_Reports.compare_function_riskprocessing_instant_id_batch(a1,b1): PERSIST('BWR1_rpt18');
		rpt19:=RiskView_Attributes_Reports.compare_function_fp_scores_batch_v2(a1,b1): PERSIST('BWR1_rpt19');
		
		
		
		    final_rpt:= rpt1 + rpt2  + rpt3 + rpt4 + rpt5 + rpt6 + rpt7 + rpt8 + rpt9 + rpt10 +
				            rpt11  + rpt12 + rpt13 + rpt14 + rpt15 + rpt16 + rpt17 + rpt18 + rpt19;
		

				
														
			  final_rpt1:=sort(final_rpt,-abs_proportion_diff):PERSIST('BWR1_final');	
				
	      // final_rpt2:=final_rpt1(abs_proportion_diff>=0.0025);




      	 
	//let us write to a files iwth csv format
			
			out_file := output(choosen(final_rpt1,all), ,'~RiskView_Scoring_Reports::out::results' + ut.GetDate, CSV(heading(single), quote('"')), overwrite );
			
			
				string out_file_layout := '';
      outfile := dataset('~RiskView_Scoring_Reports::out::results' + ut.GetDate, typeof(out_file_layout));
			

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
	 
	 fileservices.SendEmailAttachText('sivaram.ghatti@lexisnexis.com,narasimha.peruka@lexisnexis.com,Nathan.Koubsky@lexisnexis.com,suman.burjukindi@lexisnexis.com,jayson.alayay@lexisnexis.com,karthik.reddy@lexisnexis.com',
// fileservices.SendEmailAttachText('karthik.reddy@lexisnexis.com',					
					'BSS RiskIndicator Distribution Report',
																				'BUSINESS SERVICES SCORING(BSS)RiskIndicator Distribution Report '+ a + ' vs ' + b + '\n Please view attachment.',
																				 XtabOut[no_of_records].line ,
																				 'text/plain; charset=ISO-8859-3', 
																				'BSS_RiskIndicatorDistribution_' + a + '_vs_' + b + '.csv',
																				 ,
																				 ,
																				 'karthik.reddy@lexisnexis.com')   	
	          
  
	);
   
    
   
    
   
EXPORT BWR1 := 'success';


	

