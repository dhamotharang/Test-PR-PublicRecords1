EXPORT compare_function_fcra_rvscores_v4(route,current_dt,previous_dt) := functionmacro

//rvp1104_0 8/15 deprecated depmsey
file1:= distribute(dataset(route + scoring_project_pip.Output_Sample_Names.RV_Scores_V4_XML_Generic_outfile + previous_dt,  Scoring_Project_Macros.Global_Output_Layouts.FCRA_RiskView_Generic_allflagships_V4_Global_Layout,

thor),(integer)acctno);
file2:= distribute(dataset(route + scoring_project_pip.Output_Sample_Names.RV_Scores_V4_XML_Generic_outfile + current_dt,  Scoring_Project_Macros.Global_Output_Layouts.FCRA_RiskView_Generic_allflagships_V4_Global_Layout,

thor),(integer)acctno);
 
 
aa1:=join(file1,file2,left.acctno=right.acctno,inner);

aa:=aa1(acctno<>'');

DS1:=join(file1,aa,left.acctno=right.acctno,inner);

DS2:=join(file2,aa,left.acctno=right.acctno,inner);


	
	 
    	  Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'rv_auto_reason',c1);
      	Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'rv_auto_reason2',c2);
				Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'rv_auto_reason3',c3);
      	Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'rv_auto_reason4',c4);
				Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'rv_auto_reason5',c5);
				
ar:=	c1  + c2  + c3  + c4 + c5;	

	

			Scoring_QA_Risk_Indicator_Report.functions.count_function1(ar,'auto_reason',ar_1);
			
	
				
      	Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'rv_bank_reason',c6);
				Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'rv_bank_reason2',c7);
      	Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'rv_bank_reason3',c8);
      	Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'rv_bank_reason4',c9);
				Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'rv_bank_reason5',c10);
				
br:= c6  + c7  + c8  + c9 + c10;

Scoring_QA_Risk_Indicator_Report.functions.count_function1(br,'bank_reason',br_1);
				
				Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'rv_retail_reason',c11);
				Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'rv_retail_reason2',c12);
      	Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'rv_retail_reason3',c13);
				Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'rv_retail_reason4',c14);
				Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'rv_retail_reason5',c15);
		
rr:=  c11 + c12 + c13 + c14 + c15;

Scoring_QA_Risk_Indicator_Report.functions.count_function1(rr,'retail_reason',rr_1);

				Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'rv_telecom_reason',c16);
      	Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'rv_telecom_reason2',c17);
      	Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'rv_telecom_reason3',c18);
				Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'rv_telecom_reason4',c19);
				Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'rv_telecom_reason5',c20);
				
tr:=  c16 + c17 + c18 + c19 + c20;

Scoring_QA_Risk_Indicator_Report.functions.count_function1(tr,'telecom_reason',tr_1);

      	Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'rv_money_reason',c21);
      	Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'rv_money_reason2',c22);
				Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'rv_money_reason3',c23);
				Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'rv_money_reason4',c24);
				Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'rv_money_reason5',c25);
			
			
mr:= c21 + c22 + c23 + c24 + c25;

Scoring_QA_Risk_Indicator_Report.functions.count_function1(mr,'money_reason',mr_1);

				// Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'rv_prescreen_reason',c26);
      
	// pr:= c26;

// Scoring_QA_Risk_Indicator_Report.functions.count_function1(pr,'prescreen_reason',pr_1);
				
			  	
       	 
						 
				score_file1:=	ar_1  + br_1 + rr_1+	tr_1 + mr_1 ;
						 
			////////////////////////////////////////////////////////////
			////////////////////////////////////////////////////////////////
			//////////////////////////////////////////////////////////////////
			
			
			 Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'rv_auto_reason',cc1);
      	Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'rv_auto_reason2',cc2);
				Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'rv_auto_reason3',cc3);
      	Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'rv_auto_reason4',cc4);
				Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'rv_auto_reason5',cc5);
				
ar2:=	cc1  + cc2  + cc3  + cc4 + cc5;	

	

			Scoring_QA_Risk_Indicator_Report.functions.count_function1(ar2,'auto_reason',ar_2);
			
	
				
      	Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'rv_bank_reason',cc6);
				Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'rv_bank_reason2',cc7);
      	Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'rv_bank_reason3',cc8);
      	Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'rv_bank_reason4',cc9);
				Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'rv_bank_reason5',cc10);
				
br2:= cc6  + cc7  + cc8  + cc9 + cc10;

Scoring_QA_Risk_Indicator_Report.functions.count_function1(br2,'bank_reason',br_2);
				
				Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'rv_retail_reason',cc11);
				Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'rv_retail_reason2',cc12);
      	Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'rv_retail_reason3',cc13);
				Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'rv_retail_reason4',cc14);
				Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'rv_retail_reason5',cc15);
		
rr2:=  cc11 + cc12 + cc13 + cc14 + cc15;

Scoring_QA_Risk_Indicator_Report.functions.count_function1(rr2,'retail_reason',rr_2);

				Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'rv_telecom_reason',cc16);
      	Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'rv_telecom_reason2',cc17);
      	Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'rv_telecom_reason3',cc18);
				Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'rv_telecom_reason4',cc19);
				Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'rv_telecom_reason5',cc20);
				
tr2:=  cc16 + cc17 + cc18 + cc19 + cc20;

Scoring_QA_Risk_Indicator_Report.functions.count_function1(tr2,'telecom_reason',tr_2);

      	Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'rv_money_reason',cc21);
      	Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'rv_money_reason2',cc22);
				Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'rv_money_reason3',cc23);
				Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'rv_money_reason4',cc24);
				Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'rv_money_reason5',cc25);
			
			
mr2:= cc21 + cc22 + cc23 + cc24 + cc25;

Scoring_QA_Risk_Indicator_Report.functions.count_function1(mr2,'money_reason',mr_2);

				// Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'rv_prescreen_reason',cc26);
      
// pr2:= cc26;

// Scoring_QA_Risk_Indicator_Report.functions.count_function1(pr2,'prescreen_reason',pr_2);
			  	
			
	    
						 
						score_file2:=	ar_2  + br_2 + rr_2+	tr_2 + mr_2 ;	 
						 
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
																										self.file_version:='fcra_rvscores_v4',
																										self.mode:='xml',
																										                          self.field_name:=if(left.field_name='',right.field_name,left.field_name),
																																							self.p_file_count:=count(ds1),
																																							self.c_file_count:=count(ds2),
																																							self.file_count_diff:=count(ds2)-count(ds1),
                     			 			                                          	  self.reason_code:=if(left.attribute_value='',right.attribute_value,left.attribute_value),
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

