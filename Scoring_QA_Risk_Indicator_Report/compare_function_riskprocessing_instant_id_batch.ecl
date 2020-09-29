EXPORT compare_function_riskprocessing_instant_id_batch(route,current_dt,previous_dt) := functionmacro


file1:= distribute(dataset(route + scoring_project_pip.Output_Sample_Names.IID_Scores_V0_BATCH_Generic_outfile + previous_dt,Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_InstantId_Global_Layout	,


thor),(integer)acctno);



file2:= distribute(dataset(route + scoring_project_pip.Output_Sample_Names.IID_Scores_V0_BATCH_Generic_outfile + current_dt, Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_InstantId_Global_Layout	,


thor),(integer)acctno);



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

