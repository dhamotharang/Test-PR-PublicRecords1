EXPORT compare_function_biid_xml_chase(route,current_dt,previous_dt) := functionmacro




file1:= distribute(dataset(route + scoring_project_pip.Output_Sample_Names.BIID_Scores_Batch_Chase_outfile + previous_dt,Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_CHASE_BusinessInstantId_Global_Layout,

thor),(integer)acctno);



file2:= distribute(dataset(route + scoring_project_pip.Output_Sample_Names.BIID_Scores_Batch_Chase_outfile +current_dt,Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_CHASE_BusinessInstantId_Global_Layout,


thor),(integer)acctno);



aa1:=join(file1,file2,left.acctno=right.acctno,inner);

aa:=aa1(acctno<>'');

DS1:=join(file1,aa,left.acctno=right.acctno,inner);

DS2:=join(file2,aa,left.acctno=right.acctno,inner);

    	  Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'pri_1',c1);
      	Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'pri_2',c2);
				Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'pri_3',c3);
      	Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'pri_4',c4);
			  Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'pri_5',c5);
      	Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'pri_6',c6);
				Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'pri_7',c7);
      	Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'pri_8',c8);
				Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'rep_pri_1',c9);
      	Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'rep_pri_2',c10);
			  Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'rep_pri_3',c11);
      	Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'rep_pri_4',c12);
				Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'rep_pri_5',c13);
      	Scoring_QA_Risk_Indicator_Report.functions.count_function(DS1,'rep_pri_6',c14);
			
				
ar:=	c1  + c2  + c3  + c4 + c5 + c6 + c7 + c8  + c9  + c10 +
		  c11 + c12 + c13 + c14;	

	

			Scoring_QA_Risk_Indicator_Report.functions.count_function1(ar,'pri_indicator',ar_1);
			
	
				
      
				
				
						 
				score_file1:=	ar_1;
						 
			////////////////////////////////////////////////////////////
			////////////////////////////////////////////////////////////////
			//////////////////////////////////////////////////////////////////
			
			
	      
    	  Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'pri_1',cc1);
      	Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'pri_2',cc2);
				Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'pri_3',cc3);
      	Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'pri_4',cc4);
			  Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'pri_5',cc5);
      	Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'pri_6',cc6);
				Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'pri_7',cc7);
      	Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'pri_8',cc8);
				Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'rep_pri_1',cc9);
      	Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'rep_pri_2',cc10);
			  Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'rep_pri_3',cc11);
      	Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'rep_pri_4',cc12);
				Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'rep_pri_5',cc13);
      	Scoring_QA_Risk_Indicator_Report.functions.count_function(DS2,'rep_pri_6',cc14);
				
ar2:=	cc1  + cc2  + cc3  + cc4 + cc5 + cc6 + cc7 + cc8  + cc9  + cc10 +
		  cc11 + cc12 + cc13 + cc14;		

	

			Scoring_QA_Risk_Indicator_Report.functions.count_function1(ar2,'pri_indicator',ar_2);
			
	
				
      	
				
				
				
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
																										self.file_version:='biid_chase',
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

