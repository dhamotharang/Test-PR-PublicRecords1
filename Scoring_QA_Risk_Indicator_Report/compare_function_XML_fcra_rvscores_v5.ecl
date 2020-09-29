EXPORT compare_function_XML_fcra_rvscores_v5(route,current_dt,previous_dt) := functionmacro





file1:= distribute(dataset(route + scoring_project_pip.Output_Sample_Names.RV_Scores_Attributes_V5_XML_Generic_outfile + previous_dt,Scoring_Project_Macros.Global_Output_Layouts.FCRA_RiskView_Generic_allflagships_Attributes_V5_Global_Layout,



thor),(integer)acctno);
file2:= distribute(dataset(route + scoring_project_pip.Output_Sample_Names.RV_Scores_Attributes_V5_XML_Generic_outfile +current_dt,Scoring_Project_Macros.Global_Output_Layouts.FCRA_RiskView_Generic_allflagships_Attributes_V5_Global_Layout,



thor),(integer)acctno);
 
 
aa1:=join(file1,file2,left.acctno=right.acctno,inner);

aa:=aa1(acctno<>'');

DS1:=join(file1,aa,left.acctno=right.acctno,inner);

DS2:=join(file2,aa,left.acctno=right.acctno,inner);


	
	 
    	  Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'auto_reason1',c1);
      	Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'auto_reason2',c2);
				Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'auto_reason3',c3);
      	Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'auto_reason4',c4);
			
				
ar:=	c1  + c2  + c3  + c4;	

	

			Scoring_QA_Risk_Indicator_Report.functions.count_function1(ar,'auto_reason',ar_1);
			
	
				
      	Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'bankcard_reason1',c6);
				Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'bankcard_reason2',c7);
      	Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'bankcard_reason3',c8);
      	Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'bankcard_reason4',c9);
				
				
br:= c6  + c7  + c8  + c9 ;

Scoring_QA_Risk_Indicator_Report.functions.count_function1(br,'bankcard_reason',br_1);
				
				Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'short_term_lending_reason1',c11);
				Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'short_term_lending_reason2',c12);
      	Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'short_term_lending_reason3',c13);
				Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'short_term_lending_reason4',c14);
				
		
		rr:=  c11 + c12 + c13 + c14;

Scoring_QA_Risk_Indicator_Report.functions.count_function1(rr,'short_term_lending_reason',rr_1);

				Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'telecommunications_reason1',c16);
      	Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'telecommunications_reason2',c17);
      	Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'telecommunications_reason3',c18);
				Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'telecommunications_reason4',c19);
			
				
				tr:=  c16 + c17 + c18 + c19;

Scoring_QA_Risk_Indicator_Report.functions.count_function1(tr,'telecommunications_reason',tr_1);


		 
				score_file1:=	ar_1  + br_1 + rr_1+	tr_1 ;
						 
			////////////////////////////////////////////////////////////
			////////////////////////////////////////////////////////////////
			//////////////////////////////////////////////////////////////////
			
			
			  Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'auto_reason1',cc1);
      	Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'auto_reason2',cc2);
				Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'auto_reason3',cc3);
      	Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'auto_reason4',cc4);
	
				
ar2:=	cc1  + cc2  + cc3  + cc4;	

	

			Scoring_QA_Risk_Indicator_Report.functions.count_function1(ar2,'auto_reason',ar_2);
			
	
				
      	Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'bankcard_reason1',cc6);
				Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'bankcard_reason2',cc7);
      	Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'bankcard_reason3',cc8);
      	Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'bankcard_reason4',cc9);
		
				
br2:= cc6  + cc7  + cc8  + cc9 ;

Scoring_QA_Risk_Indicator_Report.functions.count_function1(br2,'bankcard_reason',br_2);
				
				Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'short_term_lending_reason1',cc11);
				Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'short_term_lending_reason2',cc12);
      	Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'short_term_lending_reason3',cc13);
				Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'short_term_lending_reason4',cc14);
				
		
		rr2:=  cc11 + cc12 + cc13 + cc14;

Scoring_QA_Risk_Indicator_Report.functions.count_function1(rr2,'short_term_lending_reason',rr_2);

				Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'telecommunications_reason1',cc16);
      	Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'telecommunications_reason2',cc17);
      	Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'telecommunications_reason3',cc18);
				Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'telecommunications_reason4',cc19);
		
				
				tr2:=  cc16 + cc17 + cc18 + cc19;

Scoring_QA_Risk_Indicator_Report.functions.count_function1(tr2,'telecommunications_reason',tr_2);

     

						score_file2:=	ar_2  + br_2 + rr_2+	tr_2  ;	 
						 
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
																										self.file_version:='fcra_rvscores_v5',
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

