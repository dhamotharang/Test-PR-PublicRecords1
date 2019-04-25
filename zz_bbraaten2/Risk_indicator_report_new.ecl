EXPORT compare_function_riskprocessing_instant_id(route,current_dt,previous_dt) := functionmacro

import Scoring_QA_Risk_Indicator_Report, zz_asinha;

file1:= dataset(route + scoring_project_pip.Output_Sample_Names.IID_Scores_V0_XML_Generic_outfile + previous_dt,zz_asinha.Layout_Original_InstantID_Generic.NONFCRA_InstantId_Global_Layout	,

thor);



file2:= dataset(route + scoring_project_pip.Output_Sample_Names.IID_Scores_V0_XML_Generic_outfile + current_dt, zz_asinha.Layout_Original_InstantID_Generic.NONFCRA_InstantId_Global_Layout	,

thor);


aa1:=join(file1,file2,left.acctno=right.acctno,inner);

aa:=aa1(acctno<>'');

DS1:=join(file1,aa,left.acctno=right.acctno,inner);

DS2:=join(file2,aa,left.acctno=right.acctno,inner);

	 
    	  Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'hri_1',c1);
      	Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'hri_2',c2);
				Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'hri_3',c3);
      	Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'hri_4',c4);
			  Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'hri_5',c5);
      	Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'hri_6',c6);
				// Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'hri_7',c7);
      	// Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'hri_8',c8);
				// Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'hri_9',c9);
      	// Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'hri_10',c10);
			  // Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'hri_11',c11);
      	// Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'hri_12',c12);
				// Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'hri_13',c13);
      	// Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'hri_14',c14);
				// Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'hri_15',c15);
      	// Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'hri_16',c16);
			  // Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'hri_17',c17);
      	// Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'hri_18',c18);
				// Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'hri_19',c19);
      	// Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'hri_20',c20);
				
ar:=	c1  + c2  + c3  + c4 + c5 + c6 ;
	

			Scoring_QA_Risk_Indicator_Report.functions.count_function1(ar,'hri_indicator',ar_1);
			
	
				
      
				
				
						 
				score_file1:=	ar_1;
						 
			////////////////////////////////////////////////////////////
			////////////////////////////////////////////////////////////////
			//////////////////////////////////////////////////////////////////
			
			
	      
    	  Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'hri_1',cc1);
      	Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'hri_2',cc2);
				Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'hri_3',cc3);
      	Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'hri_4',cc4);
			  Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'hri_5',cc5);
      	Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'hri_6',cc6);
				
				// Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'hri_7',cc7);
      	// Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'hri_8',cc8);
				// Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'hri_9',cc9);
      	// Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'hri_10',cc10);
			  // Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'hri_11',cc11);
      	// Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'hri_12',cc12);
				// Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'hri_13',cc13);
      	// Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'hri_14',cc14);
				// Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'hri_15',cc15);
      	// Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'hri_16',cc16);
			  // Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'hri_17',cc17);
      	// Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'hri_18',cc18);
				// Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'hri_19',cc19);
      	// Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'hri_20',cc20);
				
ar2:=	cc1  + cc2  + cc3  + cc4 + cc5 + cc6 ;
	

			Scoring_QA_Risk_Indicator_Report.functions.count_function1(ar2,'hri_indicator',ar_2);
			
	
				
      	
				
				
				
						score_file2:=	ar_2;	 
						 
		    compare_layout := RECORD
   		   string file_version;
				 string mode;
   		   string field_name;
				 integer p_file_count;
				 integer c_file_count;
				 integer file_count_diff;
         STRING50 reason_code; 
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
							 
			compare_result1:= join(score_file2,score_file1,
   				                                    
         	                                        left.field_name = right.field_name and
            									               	      left.attribute_value = right.attribute_value //and
            									                      // left.Count1 = right.Count1
      																							,transform(	compare_layout, 
																										self.file_version:='riskprocessing_instant_id',
																										self.mode:='xml',
																										                          self.field_name:=if(left.field_name='',right.field_name,left.field_name),
																																							self.p_file_count:=count(ds1),
																																							self.c_file_count:=count(ds2),
																																							self.file_count_diff:=count(ds2)-count(ds1),
                     			 			                                          	  self.reason_code:= if(left.attribute_value='',  right.attribute_value, left.attribute_value ) ,
         																																		  self.p_frequency:=right.Count1,
                     			 			                                              self.c_frequency:=left.Count1,
                  																														self.frequency_diff:=left.Count1-right.Count1,
   																																						self.perc_frequency_diff:=if (left.Count1!= 0 and right.Count1=0,1,(left.Count1-right.Count1)/right.Count1),
      																																				self.p_proportion:=right.Count1/count(ds1),
                     			 			                                              self.c_proportion:=left.Count1/count(ds2),
                  																													  self.proportion_diff:=(left.Count1/count(ds2))-(right.Count1/count(ds1)),
   																																						self.abs_proportion_diff:=abs((left.Count1/count(ds2))-(right.Count1/count(ds1))),
   																																						self.perc_proportion_diff:=if (left.Count1!= 0 and right.Count1=0,1,abs(((left.Count1/count(ds2))-(right.Count1/count(ds1)))/(right.Count1/count(ds1))))
   																																						
         																						                        ),full outer
         																																											 );					 
							 
							 
							 
						 
																										 
																																														 
							return choosen(compare_result1,all);			
							
							
endmacro;






EXPORT compare_function_riskprocessing_instant_id_batch(route,current_dt,previous_dt) := functionmacro


file1:= dataset(route + scoring_project_pip.Output_Sample_Names.IID_Scores_V0_BATCH_Generic_outfile + previous_dt,zz_asinha.Layout_Original_InstantID_Generic.NONFCRA_InstantId_Global_Layout	,


thor);



file2:= dataset(route + scoring_project_pip.Output_Sample_Names.IID_Scores_V0_BATCH_Generic_outfile + current_dt, zz_asinha.Layout_Original_InstantID_Generic.NONFCRA_InstantId_Global_Layout	,


thor);



aa1:=join(file1,file2,left.acctno=right.acctno,inner);

aa:=aa1(acctno<>'');

DS1:=join(file1,aa,left.acctno=right.acctno,inner);

DS2:=join(file2,aa,left.acctno=right.acctno,inner);
	 
    	  Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'hri_1',c1);
      	Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'hri_2',c2);
				Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'hri_3',c3);
      	Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'hri_4',c4);
			  Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'hri_5',c5);
      	Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'hri_6',c6);
				// Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'hri_7',c7);
      	// Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'hri_8',c8);
				// Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'hri_9',c9);
      	// Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'hri_10',c10);
			  // Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'hri_11',c11);
      	// Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'hri_12',c12);
				// Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'hri_13',c13);
      	// Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'hri_14',c14);
				// Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'hri_15',c15);
      	// Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'hri_16',c16);
			  // Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'hri_17',c17);
      	// Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'hri_18',c18);
				// Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'hri_19',c19);
      	// Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'hri_20',c20);
				
ar:=	c1  + c2  + c3  + c4 + c5 + c6 ;	

	

			Scoring_QA_Risk_Indicator_Report.functions.count_function1(ar,'hri_indicator',ar_1);
			
	
				
      
				
				
						 
				score_file1:=	ar_1;
						 
			////////////////////////////////////////////////////////////
			////////////////////////////////////////////////////////////////
			//////////////////////////////////////////////////////////////////
			
			
	      
    	  Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'hri_1',cc1);
      	Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'hri_2',cc2);
				Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'hri_3',cc3);
      	Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'hri_4',cc4);
			  Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'hri_5',cc5);
      	Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'hri_6',cc6);
				
				// Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'hri_7',cc7);
      	// Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'hri_8',cc8);
				// Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'hri_9',cc9);
      	// Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'hri_10',cc10);
			  // Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'hri_11',cc11);
      	// Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'hri_12',cc12);
				// Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'hri_13',cc13);
      	// Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'hri_14',cc14);
				// Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'hri_15',cc15);
      	// Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'hri_16',cc16);
			  // Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'hri_17',cc17);
      	// Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'hri_18',cc18);
				// Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'hri_19',cc19);
      	// Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'hri_20',cc20);
				
ar2:=	cc1  + cc2  + cc3  + cc4 + cc5 + cc6;		

	

			Scoring_QA_Risk_Indicator_Report.functions.count_function1(ar2,'hri_indicator',ar_2);
			
	
				
      	
				
				
				
						score_file2:=	ar_2;	 
						 
		    compare_layout := RECORD
   		   string file_version;
				 string mode;
   		   string field_name;
				 integer p_file_count;
				 integer c_file_count;
				 integer file_count_diff;
         STRING50 reason_code; 
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
							 
			compare_result1:= join(score_file2,score_file1,
   				                                    
         	                                        left.field_name = right.field_name and
            									               	      left.attribute_value = right.attribute_value //and
            									                      // left.Count1 = right.Count1
      																							,transform(	compare_layout, 
																										self.file_version:='riskprocessing_instant_id',
																										self.mode:='batch',
																										                          self.field_name:=if(left.field_name='',right.field_name,left.field_name),
																																							self.p_file_count:=count(ds1),
																																							self.c_file_count:=count(ds2),
																																							self.file_count_diff:=count(ds2)-count(ds1),
                     			 			                                          	  self.reason_code:= if(left.attribute_value='',  right.attribute_value, left.attribute_value ) ,
         																																		  self.p_frequency:=right.Count1,
                     			 			                                              self.c_frequency:=left.Count1,
                  																														self.frequency_diff:=left.Count1-right.Count1,
   																																						self.perc_frequency_diff:=if (left.Count1!= 0 and right.Count1=0,1,(left.Count1-right.Count1)/right.Count1),
      																																				self.p_proportion:=right.Count1/count(ds1),
                     			 			                                              self.c_proportion:=left.Count1/count(ds2),
                  																													  self.proportion_diff:=(left.Count1/count(ds2))-(right.Count1/count(ds1)),
   																																						self.abs_proportion_diff:=abs((left.Count1/count(ds2))-(right.Count1/count(ds1))),
   																																						self.perc_proportion_diff:=if (left.Count1!= 0 and right.Count1=0,1,abs(((left.Count1/count(ds2))-(right.Count1/count(ds1)))/(right.Count1/count(ds1))))
   																																						
         																						                        ),full outer
         																																											 );					 
							 
							 
							 
						 
																										 
																																														 
							return choosen(compare_result1,all);			
							
							
endmacro;





import ut,std;
// import RiskView_Attributes_Reports;

import Scoring_Project_Macros,scoring_project_pip,Scoring_Project_DailyTracking ,Scoring_QA_Risk_Indicator_Report;
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



  	fprpt1:= Scoring_QA_Risk_Indicator_Report.compare_function_batch_fcra_rvscores_v3(ip,curr_date,prev_date): PERSIST('BWR1_fprpt1');
		fprpt2:= Scoring_QA_Risk_Indicator_Report.compare_function_batch_fcra_rvscores_v4(ip,curr_date,prev_date): PERSIST('BWR1_fprpt2');		
		fprpt3:= Scoring_QA_Risk_Indicator_Report.compare_function_fcra_rvscores_v4(ip,curr_date,prev_date): PERSIST('BWR1_fprpt3');
   	fprpt4:= Scoring_QA_Risk_Indicator_Report.compare_function_rvscores_v3(ip,curr_date,prev_date): PERSIST('BWR1_fprpt4');
		fprpt5:=Scoring_QA_Risk_Indicator_Report.compare_function_best_buy_custom_chargeback_defender_score(ip,curr_date,prev_date): PERSIST('BWR1_fprpt5');	
		fprpt6:=Scoring_QA_Risk_Indicator_Report.compare_function_business_instant_id_cust_rec(ip,curr_date,prev_date): PERSIST('BWR1_fprpt6');
		fprpt7:=Scoring_QA_Risk_Indicator_Report.compare_function_business_instant_id_cust_rec_batch(ip,curr_date,prev_date): PERSIST('BWR1_fprpt7');		
		fprpt8:=Scoring_QA_Risk_Indicator_Report.compare_function_biid_xml_chase(ip,curr_date,prev_date): PERSIST('BWR1_fprpt8');		
		fprpt9:=Scoring_QA_Risk_Indicator_Report.compare_function_nonfcra_liscores_batch_v4(ip,curr_date,prev_date): PERSIST('BWR1_fprpt9');
		fprpt10:=Scoring_QA_Risk_Indicator_Report.compare_function_fp_scores_batch_v2(ip,curr_date,prev_date): PERSIST('BWR1_fprpt10');		
		fprpt11:= Scoring_QA_Risk_Indicator_Report.compare_function_nonfcra_fpscores_v2(ip,curr_date,prev_date): PERSIST('BWR1_fprpt11');	
		fprpt22:= Scoring_QA_Risk_Indicator_Report.compare_function_nonfcra_fpscores_v3(ip,curr_date,prev_date): PERSIST('BWR1_fprpt22');
		fprpt12:= Scoring_QA_Risk_Indicator_Report.compare_function_nonfcra_liscores_v4_msn1106(ip,curr_date,prev_date): PERSIST('BWR1_fprpt12');		
		fprpt13:=Scoring_QA_Risk_Indicator_Report.compare_function_regional_acceptance_rva1008_1(ip,curr_date,prev_date): PERSIST('BWR1_fprpt13');	
	  fprpt14:=compare_function_riskprocessing_instant_id(ip,curr_date,prev_date): PERSIST('BWR1_fprpt14');	
		fprpt15:=compare_function_riskprocessing_instant_id_batch(ip,curr_date,prev_date): PERSIST('BWR1_fprpt15');
		fprpt16:=Scoring_QA_Risk_Indicator_Report.compare_function_riskviewv2_xml_enova1103(ip,curr_date,prev_date): PERSIST('BWR1_fprpt16');		
		fprpt17:=Scoring_QA_Risk_Indicator_Report.compare_function_santander_rva1304_1(ip,curr_date,prev_date): PERSIST('BWR1_fprpt17');
		fprpt18:=Scoring_QA_Risk_Indicator_Report.compare_function_santander_rva1304_2(ip,curr_date,prev_date): PERSIST('BWR1_fprpt18');		
		fprpt19:= Scoring_QA_Risk_Indicator_Report.compare_function_t_mobile_rvt1210_1_cust_rec(ip,curr_date,prev_date): PERSIST('BWR1_fprpt19');
		fprpt20:= Scoring_QA_Risk_Indicator_Report.compare_function_t_mobile_rvt1212_1_cust_rec(ip,curr_date,prev_date): PERSIST('BWR1_fprpt20');		
		fprpt21:=Scoring_QA_Risk_Indicator_Report.compare_function_XML_fcra_rvscores_v5(ip,curr_date,prev_date): PERSIST('BWR1_fprpt21');	
		
		
		
		    final_fprpt:= fprpt1 + fprpt2  + fprpt3 + fprpt4 + fprpt5 + fprpt6 + fprpt7 + fprpt8  +  fprpt9 + fprpt10 +
				            fprpt11  + fprpt12 + fprpt13  + fprpt14 + fprpt15 + fprpt16 + fprpt17 + fprpt18 + fprpt19 + fprpt20 + fprpt21 + fprpt22;
		

				
														
			  final_fprpt1:=sort(final_fprpt,-abs_proportion_diff):PERSIST('BWRfp1_final');	
				
	      // final_rpt2:=final_rpt1(abs_proportion_diff>=0.0025);




      	 
	//let us write to a files iwth csv format
			
			out_file := output(choosen(final_fprpt1,all), ,'~RiskView_Scoring_Reports::out::BSS_riskindicator::bss' + curr_date, CSV(heading(single), quote('"')), overwrite,EXPIRE(10) );
			
			
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
// fileservices.SendEmailAttachText('karthik.reddy@lexisnexis.com',					
					'BSS RiskIndicator Distribution Report',
																				'BUSINESS SERVICES SCORING(BSS)RiskIndicator Distribution Report '+ curr_date + ' vs ' + prev_date + '\n Please view attachment.',
																				 XtabOut[no_of_records].line ,
																				 'text/plain; charset=ISO-8859-3', 
																				'BSS_RiskIndicatorDistribution_' + curr_date + '_vs_' + prev_date + '.csv',
																				 ,
																				 ,
																				 'karthik.reddy@lexisnexis.com')   	
	          
  
	);
   

EXPORT Risk_indicator_report_new := 'todo';