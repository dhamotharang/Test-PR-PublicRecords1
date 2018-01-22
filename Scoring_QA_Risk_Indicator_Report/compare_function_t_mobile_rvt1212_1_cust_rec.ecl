﻿EXPORT compare_function_t_mobile_rvt1212_1_cust_rec(route,current_dt,previous_dt) :=  functionmacro


file1:= dataset(route + scoring_project_pip.Output_Sample_Names.RV_Scores_XML_Tmobile_rvt1212_1_outfile + previous_dt,Scoring_Project_Macros.Global_Output_Layouts.FCRA_RiskView_XML_T_mobile_RVT1212_1_v4_Global_Layout,


thor);



file2:= dataset(route + scoring_project_pip.Output_Sample_Names.RV_Scores_XML_Tmobile_rvt1212_1_outfile + current_dt, Scoring_Project_Macros.Global_Output_Layouts.FCRA_RiskView_XML_T_mobile_RVT1212_1_v4_Global_Layout,


thor);




aa1:=join(file1,file2,left.acctno=right.acctno,inner);

aa:=aa1(acctno<>'');

DS1:=join(file1,aa,left.acctno=right.acctno,inner);

DS2:=join(file2,aa,left.acctno=right.acctno,inner);

	 
    	 
      	
				Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'rv_telecom_reason',c13);
      	Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'rv_telecom_reason2',c14);
      	Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'rv_telecom_reason3',c15);
				Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'rv_telecom_reason4',c16);
				Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'rv_telecom_reason5',c17);
				
				tr:= c13 + c14 + c15 + c16 + c17;

Scoring_QA_Risk_Indicator_Report.functions.count_function1(tr,'telecom_reason',tr_1);

      	
						 
				score_file1:=tr_1 ;
						 
			////////////////////////////////////////////////////////////
			////////////////////////////////////////////////////////////////
			//////////////////////////////////////////////////////////////////
			
			
	
		
				Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'rv_telecom_reason',cc13);
      	Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'rv_telecom_reason2',cc14);
      	Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'rv_telecom_reason3',cc15);
				Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'rv_telecom_reason4',cc16);
		    Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'rv_telecom_reason5',cc17);
		
						tr2:= cc13 + cc14 + cc15 + cc16 + cc17;

Scoring_QA_Risk_Indicator_Report.functions.count_function1(tr2,'telecom_reason',tr_2);

      	
						 
						score_file2:=	tr_2;	 
						 
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
																										self.file_version:='t_mobile_rvt1212_1_cust_rec',
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

