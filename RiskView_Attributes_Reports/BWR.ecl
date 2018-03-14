import RiskView_Attributes_Reports;



import ut,std;
import RiskView_Attributes_Reports;

	a:= ut.GetDate;
fn_LastTwoMonths(string10 date_inp,integer offset) := function
res  := GLOBAL(ut.DateFrom_DaysSince1900(ut.DaysSince1900(date_inp[1..4], date_inp[5..6], date_inp[7..8]) - offset));
return res[1..8];
end;

b:=fn_LastTwoMonths(a,1);
	a1:= a +'_1';


b1:=b +'_1';
								
				compare_layout := RECORD
		  string file_version;
			string mode;
      string field_name;
      string distribution_type;
			decimal20_4 p_file_count;
      decimal20_4 c_file_count;
      decimal20_4 file_count_diff;
      STRING50 attribute_value; 
      decimal20_4 p_frequency;
      decimal20_4 c_frequency;
      decimal20_4 frequency_diff;
			decimal20_4 perc_frequency_diff;
   	  decimal20_4 p_proportion;
      decimal20_4 c_proportion;
      decimal20_4 proportion_diff;
			decimal20_4 abs_proportion_diff;
			decimal20_4 perc_proportion_diff;								
            END;					
								rpt1:=dataset('~RiskView_Attributes_Reports::Data::rpt1' + ut.GetDate,compare_layout,csv);
								rpt2:=dataset('~RiskView_Attributes_Reports::Data::rpt2' + ut.GetDate,compare_layout,csv);
								rpt3:=dataset('~RiskView_Attributes_Reports::Data::rpt3' + ut.GetDate,compare_layout,csv);
								rpt4:=dataset('~RiskView_Attributes_Reports::Data::rpt4' + ut.GetDate,compare_layout,csv);
								rpt5:=dataset('~RiskView_Attributes_Reports::Data::rpt5' + ut.GetDate,compare_layout,csv);
								rpt6:=dataset('~RiskView_Attributes_Reports::Data::rpt6' + ut.GetDate,compare_layout,csv);
								rpt7:=dataset('~RiskView_Attributes_Reports::Data::rpt7' + ut.GetDate,compare_layout,csv);
								rpt8:=dataset('~RiskView_Attributes_Reports::Data::rpt8' + ut.GetDate,compare_layout,csv);
								rpt9:=dataset('~RiskView_Attributes_Reports::Data::rpt9' + ut.GetDate,compare_layout,csv);
								rpt10:=dataset('~RiskView_Attributes_Reports::Data::rpt10' + ut.GetDate,compare_layout,csv);
							  rpt11:=dataset('~RiskView_Attributes_Reports::Data::rpt11' + ut.GetDate,compare_layout,csv);
								rpt12:=dataset('~RiskView_Attributes_Reports::Data::rpt12' + ut.GetDate,compare_layout,csv);
								rpt13:=dataset('~RiskView_Attributes_Reports::Data::rpt13' + ut.GetDate,compare_layout,csv);
								rpt14:=dataset('~RiskView_Attributes_Reports::Data::rpt14' + ut.GetDate,compare_layout,csv);
								rpt15:=dataset('~RiskView_Attributes_Reports::Data::rpt15' + ut.GetDate,compare_layout,csv);
								rpt16:=dataset('~RiskView_Attributes_Reports::Data::rpt16' + ut.GetDate,compare_layout,csv);
								rpt17:=dataset('~RiskView_Attributes_Reports::Data::rpt17' + ut.GetDate,compare_layout,csv);
								rpt18:=dataset('~RiskView_Attributes_Reports::Data::rpt18' + ut.GetDate,compare_layout,csv);
								rpt19:=dataset('~RiskView_Attributes_Reports::Data::rpt19' + ut.GetDate,compare_layout,csv);
								rpt20:=dataset('~RiskView_Attributes_Reports::Data::rpt20' + ut.GetDate,compare_layout,csv);
								rpt21:=dataset('~RiskView_Attributes_Reports::Data::rpt21' + ut.GetDate,compare_layout,csv);
								rpt22:=dataset('~RiskView_Attributes_Reports::Data::rpt22' + ut.GetDate,compare_layout,csv);
								
								
	  // rpt1:=RiskView_Attributes_Reports.Compare_function_v3(a1,b1) : PERSIST('BWR_rpt1');
	   // rpt2:=RiskView_Attributes_Reports.Compare_function_li_batch_v3(a1,b1): PERSIST('BWR_rpt2');
		// rpt3:=RiskView_Attributes_Reports.compare_function_batch_fcra_rvattributes_v3(a1,b1): PERSIST('BWR_rpt3');
		// rpt4:=RiskView_Attributes_Reports.compare_function_li_xml_v3(a1,b1): PERSIST('BWR_rpt4');		
		// rpt5:=RiskView_Attributes_Reports.Compare_function_fcra_experian_rva_v3_batch(a1,b1): PERSIST('BWR_rpt5');
		// rpt6:=RiskView_Attributes_Reports.Compare_function_fcra_experian_rva_v3_xml(a1,b1): PERSIST('BWR_rpt6');
		
	  // rpt7:=RiskView_Attributes_Reports.compare_function_li_xml_v4(a1,b1): PERSIST('BWR_rpt7');
		// rpt8:=RiskView_Attributes_Reports.compare_function_nonfcra_fpscoresattributes_v2(a1,b1): PERSIST('BWR_rpt8');
		// rpt9:=RiskView_Attributes_Reports.Compare_function_v4_batch(a1,b1): PERSIST('BWR_rpt9');
		// rpt10:=RiskView_Attributes_Reports.Compare_function_v4(a1,b1): PERSIST('BWR_rpt10');		
		// rpt11:=RiskView_Attributes_Reports.Compare_function_nonfcra_ita_capitalone_batch_v30(a1,b1): PERSIST('BWR_rpt11');
		// rpt12:=RiskView_Attributes_Reports.compare_function_fp_attributes_and_scores_batch_v2(a1,b1): PERSIST('BWR_rpt12');
		// rpt13:=RiskView_Attributes_Reports.compare_function_nonfcra_liattributes_batch_v4(a1,b1): PERSIST('BWR_rpt13');
		
		// rpt14:=RiskView_Attributes_Reports.Compare_function_chase_bnk4_batch(a1,b1): PERSIST('BWR_rpt14');
		// rpt15:=RiskView_Attributes_Reports.Compare_function_chase_bnk4_cust_rec(a1,b1): PERSIST('BWR_rpt15');
		// rpt16:=RiskView_Attributes_Reports.Compare_function_chase_cbbl_cust_rec(a1,b1): PERSIST('BWR_rpt16');
		// rpt17:=RiskView_Attributes_Reports.Compare_function_chase_pi02_batch_cust_rec(a1,b1): PERSIST('BWR_rpt17');
		// rpt18:=RiskView_Attributes_Reports.Compare_function_chase_pi02_cust_rec(a1,b1): PERSIST('BWR_rpt18');
		// rpt19:=RiskView_Attributes_Reports.Compare_function_paro_it60_xml(a1,b1): PERSIST('BWR_rpt19');
		// rpt20:=RiskView_Attributes_Reports.Compare_function_paro_it60_batch(a1,b1): PERSIST('BWR_rpt20');
		// rpt21:=RiskView_Attributes_Reports.Compare_function_paro_it61_xml(a1,b1): PERSIST('BWR_rpt21');
		// rpt22:=RiskView_Attributes_Reports.Compare_function_paro_it61_batch(a1,b1): PERSIST('BWR_rpt22');
	
		    final_rpt:= rpt1  + rpt2 + rpt3 + rpt4 + rpt5  + rpt6 + rpt7 + rpt8 + rpt9 + rpt10 + 
				            rpt11 + rpt12 + rpt13 + rpt14 + rpt15 + rpt16 + rpt17 + rpt18 + rpt19 + rpt20 +
										rpt21 + rpt22;
											
			  final_rpt1:=sort(final_rpt,-abs_proportion_diff): PERSIST('BWR_final');	
				
	     	// final_rpt2:=final_rpt(abs_proportion_diff>=0.01);		


tc2 := output(rpt2, ,'~RiskView_Attributes_Reports::out::test::rpt2' + ut.GetDate, CSV(heading(single), quote('"')), overwrite );


    // rpt:=RiskView_Attributes_Reports.Compare_function_v4('20131010','20131009');
    // rpt1:=RiskView_Attributes_Reports.Compare_function_v3('20130917 ','20130919 ');
		// warning_flag =1 results only
		
		// output(choosen(rpt,all));
		
		// output(rpt(distribution_type=''));
      	 
	//let us write to a files iwth csv format
			
			out_file := output(choosen(final_rpt1,all), ,'~RiskView_Attributes_Reports::out::results' + ut.GetDate, CSV(heading(single), quote('"')), overwrite );
			
			
				string out_file_layout := '';
      outfile := dataset('~RiskView_Attributes_Reports::out::results' + ut.GetDate, typeof(out_file_layout));
			

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
         
         				
																		 
         
         
         
       																		 
   // SEQUENTIAL( out_file,out_file1,out_file2,out_file3,out_file4,out_file5,out_file6,out_file8,out_file9,out_file10,
	 SEQUENTIAL( out_file,tc2,
	 	 fileservices.SendEmailAttachText('sivaram.ghatti@lexisnexis.com,narasimha.peruka@lexisnexis.com,Nathan.Koubsky@lexisnexis.com,suman.burjukindi@lexisnexis.com,jayson.alayay@lexisnexis.com,karthik.reddy@lexisnexis.com',
	 // fileservices.SendEmailAttachText('sivaram.ghatti@lexisnexis.com, Becki.Wilken@lexisnexis.com, Randy.Niemeyer@lexisnexis.com, InsurView.IV-QA@risk.lexisnexis.com, Chad.Grinsteiner@lexisnexis.com,Nathan.Koubsky@lexisnexis.com , Todd.Steil@lexisnexis.com',
// fileservices.SendEmailAttachText('karthik.reddy@lexisnexis.com',					
					'BSS Attribute Distribution Report',
																				'BUSINESS SERVICES SCORING(BSS)Attribute Distribution Report '+ a + ' vs ' + b + '\n Please view attachment.',
																				 XtabOut[no_of_records].line ,
																				 'text/plain; charset=ISO-8859-3', 
																				'BSS_AttributeDistributionShifts_' + a + '_vs_' + b + '.csv',
																				 ,
																				 ,
																				 'karthik.reddy@lexisnexis.com')   	
	          
  
	);
   
    
   
EXPORT BWR := 'success';

