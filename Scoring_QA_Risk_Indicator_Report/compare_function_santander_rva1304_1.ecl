EXPORT compare_function_santander_rva1304_1(route,current_dt,previous_dt) := functionmacro


file1:= dataset(route + scoring_project_pip.Output_Sample_Names.RV_Scores_XML_Santander_1304_1_outfile + previous_dt,Scoring_Project_Macros.Global_Output_Layouts.FCRA_RiskView_XML_Santander_RVA1304_1_V3_Global_Layout,


thor);



file2:= dataset(route + scoring_project_pip.Output_Sample_Names.RV_Scores_XML_Santander_1304_1_outfile + current_dt, Scoring_Project_Macros.Global_Output_Layouts.FCRA_RiskView_XML_Santander_RVA1304_1_V3_Global_Layout,


thor);



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
			
	
				
      	
			  	
       	 
						 
				score_file1:=	ar_1;
						 
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
																										self.file_version:='santander_rva1304_1',
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

