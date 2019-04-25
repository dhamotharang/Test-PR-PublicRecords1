﻿import ut,scoring_project_pip,Scoring_Project_Macros,Scoring_Project_DailyTracking;

rule_based_test := (real) 2.0;

req_date := (integer) ut.GetDate ;
curr_date := req_date + '_1';
// curr_date := '20130908_1' ;
prev_date := scoring_project_ks.get_past_date(req_date, 1) + '_1';
// prev_date := '20181231_1';



results_rec :=RECORD
  string9 get_score_bin;
  string80 flagship;
  string80 model;
  integer8 file_count;
  string8 date_in;
  integer8 cnt_grp;
  real8 mean;
  real8 std_dev;
  integer8 max_value;
  integer8 min_value;
 END;



 data_rec := record

  string30 acctno; 
  string80 flagship; 
	string80 model;
	string80 score ;
end;
	



oneline := record string1000 line; string2 eor := '\r\n'; end;

result1 := dataset('~ScoringQA::bins::ks::' + prev_date + '_results', results_rec, CSV(heading(0), SEPARATOR('|'), QUOTE(''), TERMINATOR('\n')));

result2 := dataset('~ScoringQA::bins::ks::' + curr_date + '_results', results_rec, CSV(heading(0), SEPARATOR('|'), QUOTE(''), TERMINATOR('\n')));


score_data1 := dataset('~ScoringQA::bins::ks::' + prev_date + '_data', data_rec, CSV(heading(0), SEPARATOR('|'), QUOTE(''), TERMINATOR('\n')));

score_data2 := dataset('~ScoringQA::bins::ks::' + curr_date + '_data', data_rec, CSV(heading(0), SEPARATOR('|'), QUOTE(''), TERMINATOR('\n')));


scores_project(ds,rec):=functionmacro
res:=project (ds, transform({  string80 product,string80 version, string80 process1,string80 customer, string80 model1,
			                                                                       recordof(rec) 
			                                     },

			                      self.product := 
														map( 
																										
														// left.flagship  = 'businessinstantid_batch_generic'  and left.model = 'bvi'  	 => 'BusinessInstantId' ,
														// left.flagship  = 'businessinstantid_batch_generic'  and left.model = 'bnap' 	 => 'BusinessInstantId' ,
														// left.flagship  = 'businessinstantid_batch_generic'  and left.model = 'bnas'	 => 'BusinessInstantId' ,
														// left.flagship  = 'businessinstantid_batch_generic'  and left.model = 'bnat'	 => 'BusinessInstantId' ,
														
														left.flagship  = 'businessinstantidv2_xml_generic'  and left.model = 'bvi'  	 => 'BusinessInstantIdv2' ,
														left.flagship  = 'businessinstantidv2_xml_generic'  and left.model = 'rep1_cvi' 	 => 'BusinessInstantIdv2' ,
														left.flagship  = 'businessinstantidv2_xml_generic'  and left.model = 'bus2exec_index_rep1'	 => 'BusinessInstantIdv2' ,
														
														left.flagship );

														  self.version := 
														map( 

														// left.flagship  = 'businessinstantid_batch_generic'   	 => '0' ,		
														left.flagship  = 'businessinstantidv2_xml_generic'   	 => '0' ,	
														
														'');


                            self.process1 := 
														map( 

														// left.flagship  = 'businessinstantid_batch_generic'   	 => 'Batch' ,					
														left.flagship  = 'businessinstantidv2_xml_generic'   	 => 'XML' ,	
													
														'');

														
														 self.customer := 
														map( 
																												
														// left.flagship  = 'businessinstantid_batch_generic'  and left.model = 'bvi'  	 => 'Generic' ,
														// left.flagship  = 'businessinstantid_batch_generic'  and left.model = 'bnap' 	 => 'Generic' ,
														// left.flagship  = 'businessinstantid_batch_generic'  and left.model = 'bnas'	 => 'Generic' ,
														// left.flagship  = 'businessinstantid_batch_generic'  and left.model = 'bnat'	 => 'Generic' ,
														left.flagship  = 'businessinstantidv2_xml_generic'  and left.model = 'bvi'	 => 'Generic' ,
														left.flagship  = 'businessinstantidv2_xml_generic'  and left.model = 'rep1_cvi'	 => 'Generic' ,
														left.flagship  = 'businessinstantidv2_xml_generic'  and left.model = 'bus2exec_index_rep1'	 => 'Generic' ,
														
														'' );														
													
														
                            self.model1 := 
														map( 
														
														// left.flagship  = 'businessinstantid_batch_generic'  and left.model = 'bvi'  	 => 'bvi' ,
														// left.flagship  = 'businessinstantid_batch_generic'  and left.model = 'bnap' 	 => 'bnap' ,
														// left.flagship  = 'businessinstantid_batch_generic'  and left.model = 'bnas'	 => 'bnas' ,
														// left.flagship  = 'businessinstantid_batch_generic'  and left.model = 'bnat'	 => 'bnat' ,
													  left.flagship  = 'businessinstantidv2_xml_generic'  and left.model = 'bvi'  	 => 'bvi' ,
														left.flagship  = 'businessinstantidv2_xml_generic'  and left.model = 'rep1_cvi' 	 => 'rep1_cvi' ,
														left.flagship  = 'businessinstantidv2_xml_generic'  and left.model = 'bus2exec_index_rep1'	 => 'bus2exec_index_rep1' ,
														
														
														'' );
														
														self := left ));
														
														return res;
														endmacro;
														

														
score_data1_project_1:=scores_project(score_data1,data_rec);

score_data1_project:=score_data1_project_1(score<>'');



 		test_rec := record
   
     score_data1_project.product; 
   	score_data1_project.version;
   	score_data1_project.process1 ;
   	score_data1_project.customer ;
   	score_data1_project.model1 ;
   	decimal19_2 max_scr:=min(group,score_data1_project.score );
   		decimal19_2 min_scr:=max(group,score_data1_project.score )
   	
   end;
   											 
    	test:=  table(score_data1_project,test_rec,product,version,process1,customer,model1);


					


score_data2_project_1:=scores_project(score_data2,data_rec);

score_data2_project:=score_data2_project_1( score<>'' );


score_name_1_layout:= record
					
  string30 acctno; 
  string80 product; 
	string80 version;
	string80 process1 ;
	string80 customer ;
	string80 model1 ;
	string80 prev_score;
	string80 curr_score;
	string80 score_name_1;
		
			end;
			
score_name_1_layout_ds:=join(score_data1_project,score_data2_project,	left.acctno=right.acctno and 
											                           left.product=right.product and 
											                           left.version=right.version and
																								  left.process1=right.process1 and 
											                           left.customer=right.customer and
																								   left.model1=right.model1,
																								 
																								 			transform(recordof(score_name_1_layout),
																											self.prev_score 	:= left.score ;
			                                                self.curr_score := right.score;
																										self.score_name_1:=		   if(left.score=right.score,'true','false');																							 
																											
																											self:=left;
																								 ),inner);
																								 

																								 
																								 
 	score_name_layout :=record


     score_name_1_layout_ds. product; 
   	score_name_1_layout_ds. version;
   	score_name_1_layout_ds. process1 ;
   	score_name_1_layout_ds. customer ;
   	score_name_1_layout_ds. model1 ;


		
			decimal19_2 score_name:=COUNT(group,score_name_1_layout_ds.score_name_1='true');
		
   	
   	
   	
   	end;
   	
   	score_name_layout_ds:= table(score_name_1_layout_ds,score_name_layout,product,version,process1,customer,model1);
		


score_result1_project:=scores_project(result1,results_rec);

defalut_ds_1_rv:=score_result1_project(product='RiskView'  and get_score_bin in ['100','101','102','103','104','200','210','222']);

defalut_ds_1_li:=score_result1_project(product='LeadIntegrity' and get_score_bin in ['200','210']);

defalut_ds_1:=defalut_ds_1_rv + defalut_ds_1_li;


score_result2_project:=scores_project(result2,results_rec);

defalut_ds_2_rv:=score_result2_project(product='RiskView'  and get_score_bin in ['100','101','102','103','104','200','210','222']);

defalut_ds_2_li:=score_result2_project(product='LeadIntegrity' and get_score_bin in ['200','210']);

defalut_ds_2:=defalut_ds_2_rv + defalut_ds_2_li;

default_rec_1 := record

  defalut_ds_1.product; 
	defalut_ds_1.version;
	defalut_ds_1.process1 ;
	defalut_ds_1.customer ;
	defalut_ds_1.model1 ;
	decimal19_2 prev_default:=sum(group,defalut_ds_1.cnt_grp);

end;
											 
 	default_rec_ds_1:=  table(defalut_ds_1,default_rec_1,product,version,process1,customer,model1);

default_rec_2 := record

  defalut_ds_2.product; 
	defalut_ds_2.version;
	defalut_ds_2.process1 ;
	defalut_ds_2.customer ;
	defalut_ds_2.model1 ;
	decimal19_2 curr_default:=sum(group,defalut_ds_2.cnt_grp);

end;
											 
 	default_rec_ds_2:=  table(defalut_ds_2,default_rec_2,product,version,process1,customer,model1);
	

// score_data1_project_biid:=score_data1_project(product='BusinessInstantId' and  model1='bvi'   
                                                              // and (decimal19_2)score  >=0 and  (decimal19_2)score  <=50 
																															 
                                            // );	
score_data1_project_biidv2:=score_data1_project(product='BusinessInstantIdv2' and  (model1='bvi'  or  model1='rep1_cvi' or model1='bus2exec_index_rep1')   
                                                              and (decimal19_2)score  >=0 and  (decimal19_2)score  <=50 
																															 
                                            );	
// score_data1_project_biid1:=score_data1_project(product='BusinessInstantId' and  (model1='bnap'  or  model1='bnas' or model1='bnat')
                                                              // and (decimal19_2)score  >=0 and  (decimal19_2)score  <=12 
																															 
                                            // );			

// score_data2_project_biid:=score_data2_project(product='BusinessInstantId' and  model1='bvi'   
                                                                // and (decimal19_2)score  >=0 and  (decimal19_2)score  <=50
																															 
                                            // );	
score_data2_project_biidv2:=score_data2_project(product='BusinessInstantIdv2' and  (model1='bvi'  or  model1='rep1_cvi' or model1='bus2exec_index_rep1')   
                                                              and (decimal19_2)score  >=0 and  (decimal19_2)score  <=50 
																															 
                                            );	
// score_data2_project_biid1:=score_data2_project(product='BusinessInstantId' and  (model1='bnap'  or  model1='bnas' or model1='bnat')
                                                              // and (decimal19_2)score  >=0 and  (decimal19_2)score  <=12 
																															 
                                            // );			
		
		dataset_prev:=score_data1_project_biidv2;
		
		dataset_curr:=score_data2_project_biidv2;
		


score_data1_project_rv_default:=score_data1_project(product='RiskView' and (decimal19_2)score  in [-2] );

score_data1_project_li_default:=score_data1_project(product='LeadIntegrity' and (decimal19_2)score  in [-2] );

score_data2_project_rv_default:=score_data2_project(product='RiskView' and (decimal19_2)score   in [-2] );

score_data2_project_li_default:=score_data2_project(product='LeadIntegrity' and (decimal19_2)score  in [-2] );


		
dataset_prev_default :=score_data1_project_rv_default + score_data1_project_li_default ;
dataset_curr_default :=score_data2_project_rv_default + score_data2_project_li_default;



To_Default_layout:= record
					
  string30 acctno; 
  string80 product; 
	string80 version;
	string80 process1 ;
	string80 customer ;
	string80 model1 ;
	string80 curr_score_valid;
	string80 prev_score_default;
				
			end;
			
To_Default_layout_ds:=join(dataset_curr_default,dataset_prev,	left.acctno=right.acctno and 
											                           left.product=right.product and 
											                           left.version=right.version and
																								  left.process1=right.process1 and 
											                           left.customer=right.customer and
																								   left.model1=right.model1,
																								 
																								 			transform(recordof(To_Default_layout),
																											self.curr_score_valid 	:= left.score ;
			                                                self.prev_score_default := right.score;
																                 																				 
																											
																											self:=left;
																								 ),inner);
																								 
	
				count_to_default_rec := record

  To_Default_layout_ds.product; 
	To_Default_layout_ds.version;
	To_Default_layout_ds.process1 ;
	To_Default_layout_ds.customer ;
	To_Default_layout_ds.model1 ;
	decimal19_2 count_to_default:=count(group,To_Default_layout_ds.curr_score_valid <> '-1');

end;
											 
 	count_to_default_rec_ds:=  table(To_Default_layout_ds,count_to_default_rec,product,version,process1,customer,model1);
	

	
		From_Default_layout:= record					
  string30 acctno; 
  string80 product; 
	string80 version;
	string80 process1 ;
	string80 customer ;
	string80 model1 ;
	string80 curr_score_default;
	string80 prev_score_valid;	
			end;
			
From_Default_layout_ds:=join(dataset_curr,dataset_prev_default,	left.acctno=right.acctno and 
											                           left.product=right.product and 
											                           left.version=right.version and
																								  left.process1=right.process1 and 
											                           left.customer=right.customer and
																								   left.model1=right.model1,
																								 
																								 			transform(recordof(From_Default_layout),
																											self.curr_score_default 	:= left.score ;
			                                                self.prev_score_valid := right.score;
																                 																				 
																											
																											self:=left;
																								 ),inner);	
																								 
count_from_default_rec := record

  from_Default_layout_ds.product; 
	from_Default_layout_ds.version;
	from_Default_layout_ds.process1 ;
	from_Default_layout_ds.customer ;
	from_Default_layout_ds.model1 ;
	decimal19_2 count_from_default:=count(group,from_Default_layout_ds.curr_score_default <> '-1');

end;
											 
 	count_from_default_rec_ds:=  table(from_Default_layout_ds,count_from_default_rec,product,version,process1,customer,model1);																					 
																								 


avg_layout_prev:= record
	  dataset_prev.product;
	  dataset_prev.version;
	  dataset_prev.process1;
	  dataset_prev.customer;

	  dataset_prev.model1;


	decimal10_5 prev_mean:= ave(group,(real)dataset_prev.score );
	decimal19_2	prev_std_dev   := sqrt(variance(group, (real) dataset_prev.score ));
	decimal19_2 prev_max_value := max(group,dataset_prev.score );
	decimal19_2 prev_min_value := min(group,dataset_prev.score );
	
		end;
		
			avg_layout_curr:= record
  dataset_curr.product;
  dataset_curr.version;
	dataset_curr.process1;
	dataset_curr.customer;

	dataset_curr.model1;

	decimal19_2 curr_mean:= ave(group,(real)dataset_curr.score );
	decimal19_2	curr_std_dev   := sqrt(variance(group, (real) dataset_curr.score ));
	decimal19_2 curr_max_value := max(group,dataset_curr.score );
	decimal19_2 curr_min_value := min(group,dataset_curr.score );
	
		end;
		
		avg_dataset_prev:=  table(dataset_prev,avg_layout_prev,product,version,process1,customer,model1);
		avg_dataset_curr:=  table(dataset_curr,avg_layout_curr,product,version,process1,customer,model1);


dual_rec := record
			string30 acctno; 
			string80 product; 
			string80 version;
			string80 process1 ;
			string80 customer ;
			string80 model1 ;
			string80 prev_dual_valid;
			string80 curr_dual_valid ;
			decimal19_2 curr_dual_valid_prev_dual_valid;
			decimal19_2 _count;	
end;
		 
											 
							dual_rec_ds:=				 join(dataset_prev,dataset_curr,left.acctno=right.acctno and 
																															left.product=right.product and 
																															left.version=right.version and
																															left.process1=right.process1 and 
																															left.customer=right.customer and
																															left.model1=right.model1,
																									transform(recordof(dual_rec),
																																			self.prev_dual_valid 	:= left.score ;
																																			self.curr_dual_valid := right.score;
																																			self.curr_dual_valid_prev_dual_valid:= (decimal19_2)right.score- (decimal19_2)left.score;
																																			self._count := 0;
																																			self:=left;
																																 ),inner);
																								 

											 
ds_sort := sort(		dual_rec_ds,version,process1,customer,model1,  acctno		);				
roll := rollup(		ds_sort, left.acctno=right.acctno and 
																															left.product=right.product and 
																															left.version=right.version and
																															left.process1=right.process1 and 
																															left.customer=right.customer and
																															left.model1=right.model1	, transform(recordof(dual_rec), self._count := left._count+right._count; self := left;));
												
	dual_rec_mean := RECORD
			roll.product; 
			roll.version;
			roll.process1 ;
			roll.customer ;
			roll.model1 ;
			decimal19_2 Dual_Mean_Chg:=ave(group,(real)roll.curr_dual_valid )- ave(group,(real)roll.prev_dual_valid );
			decimal19_2 Dual_count := count(group);
			decimal19_2 Dual_Max_Chg :=max(group,abs(roll.curr_dual_valid_prev_dual_valid));
		END;
													 
	 dual_rec_ds_mean:=  table(roll,dual_rec_mean,product,version,process1,customer,model1);
	
			
		final_rec_stats:= record		  
  string80 product;
	string80 version;
	string80 process1;
	string80 customer;
	string80 model1;	
	decimal19_2 prev_mean;
	decimal19_2	prev_std_dev;	
	decimal19_2 prev_max_value;
	decimal19_2 prev_min_value;
	decimal19_2 curr_mean;
	decimal19_2	curr_std_dev;


	decimal19_2 curr_max_value;
	decimal19_2 curr_min_value;	


	decimal19_2 diff_mean;
	decimal19_2 diff_std_dev;
	

end;
		
	final_rec_ds:=	join(avg_dataset_prev,avg_dataset_curr,left.product = right.product and
	                                                        left.version = right.version and
			                                                   left.process1 = right.process1 and
			                                                   left.customer = right.customer and
																												 left.model1 = right.model1 ,
			transform(recordof(final_rec_stats),
			self.prev_mean 	:= left.prev_mean ;
			self.curr_mean := right.curr_mean;
			self.prev_std_dev := left.prev_std_dev;
			self.prev_max_value 	:= left.prev_max_value ;
			self.prev_min_value 	:= left.prev_min_value ;
			self.curr_std_dev := right.curr_std_dev;
			self.curr_max_value := right.curr_max_value;
			self.curr_min_value := right.curr_min_value;


			self.diff_mean:=right.curr_mean - left.prev_mean;
			self.diff_std_dev:=right.curr_std_dev - left.prev_std_dev;
			self:=left;
	));
	


 	dafault_layout_prev:= record
   	 dataset_prev_default.product;
   	  dataset_prev_default.version;
   	dataset_prev_default.process1;
   	dataset_prev_default.customer;

   	dataset_prev_default.model1;

   	decimal19_2 prev_default := count(group,dataset_prev_default.score >'0');
   	
   	
   		end;
   		
   		dafault_layout_curr:= record
   	 dataset_curr_default.product;
   	 	 dataset_curr_default.version;
   	dataset_curr_default.process1;
   	dataset_curr_default.customer;

   	dataset_curr_default.model1;

   	decimal19_2 curr_default := count(group,dataset_curr_default.score >'0');
   
   	
   		end;
   		
   		default_dataset_prev:=  table(dataset_prev_default,dafault_layout_prev,product,version,process1,customer,model1);
   		default_dataset_curr:=  table(dataset_curr_default,dafault_layout_curr,product,version,process1,customer,model1);
   		
   		
   		


final_rec_default:= record	
  string30 acctno; 	  
  string80 product;
	string80 version;
	string80 process1;
	string80 customer;
	string80 model1;	
	decimal19_2 prev_default;
	decimal19_2 curr_default;	

	decimal19_2 Default_Score_Chng; 




end;
		
	final_rec_ds_default:=	join(dataset_prev_default,dataset_curr_default,left.acctno = right.acctno and
	                                                       left.product = right.product and
                                                       	 left.version = right.version and
			                                                   left.process1 = right.process1 and
			                                                   left.customer = right.customer and
																												 left.model1 = right.model1 ,
			transform(recordof(final_rec_default),
			self.prev_default 	:= (real)left.score ;
			self.curr_default := (real)right.score;

			self.Default_Score_Chng:=(real)right.score-(real)left.score;

			
			self:=left;
	));



Default_Score_Chng_layout := record

  final_rec_ds_default.product; 
	final_rec_ds_default.version;
	final_rec_ds_default.process1 ;
	final_rec_ds_default.customer ;
	final_rec_ds_default.model1 ;
	decimal19_2 Default_Score_Chng:=count(group,final_rec_ds_default.Default_Score_Chng>0 );

end;
											 
 	Default_Score_Chng_layout_ds:=  table(final_rec_ds_default,Default_Score_Chng_layout,product,version,process1,customer,model1);
	



final_rec := record

			string80 flagship;
			string80 model;
			string9 bin;
			integer8 prev_frequency;
			decimal19_5 prev_proportion;
			decimal19_5 prev_cum_proportion;
			integer8 curr_frequency;
			decimal19_5 curr_proportion;
			decimal19_5 curr_cum_proportion;
			integer8 prev_response_count;
			integer8 prev_invalid ;
			// integer8 prev_exceptions ;
			integer8 curr_response_count;
			integer8 curr_invalid ;
			// integer8 curr_exceptions ;
			decimal19_5 Prev_Mean;
			decimal19_5 prev_std_dev;
			integer8 prev_max_value;
			integer8 prev_min_value;
			integer8 prev_default;
			decimal19_5 curr_mean;
			decimal19_5 curr_std_dev;
			integer8 curr_max_value;
			integer8 curr_min_value;
			integer8 curr_default;


end;

final_result  :=
   join( result1, result2,
      left.get_score_bin = right.get_score_bin and
			left.flagship = right.flagship and
			left.model = right.model ,
			transform(recordof(final_rec),
			self.flagship 	:= left.flagship ;
			self.model := left.model;
			self.bin := left.get_score_bin;
			self.prev_frequency := left.cnt_grp;
			self.prev_proportion := left.cnt_grp/left.file_count;
      self.Prev_Mean := left.mean;
			self.prev_std_dev := left.std_dev;
			self.prev_max_value := left.max_value;
			self.prev_min_value := left.min_value;
      self.prev_invalid := if( left.get_score_bin = 'UNDEFINED', left.cnt_grp, 0);
			// self.prev_exceptions := if( left.get_score_bin in ['100','101','102','103','104','200','210','222'], left.cnt_grp, 0);
			self.prev_cum_proportion := 0;
			self.prev_default := if( left.get_score_bin in ['222'], left.cnt_grp, 0);
			// self.curr_bin := right.get_score_bin;
			self.curr_frequency := right.cnt_grp;
			self.curr_proportion := right.cnt_grp/right.file_count ;
			self.curr_cum_proportion := 0;			
			self.prev_response_count := left.file_count;
			self.curr_response_count := right.file_count;			

      self.curr_mean := right.mean;
			self.curr_std_dev := right.std_dev;
			self.curr_max_value := right.max_value;
			self.curr_min_value := right.min_value;
			
			self.curr_invalid := if( left.get_score_bin = 'UNDEFINED', right.cnt_grp, 0);
			// self.curr_exceptions := if( left.get_score_bin in ['100','101','102','103','104','200','210','222'], right.cnt_grp, 0);
      self.curr_default := if( left.get_score_bin in ['222'], right.cnt_grp, 0);
			));
			
			
	 dedup_final_0 := table(		final_result, { flagship, model, 
	                                          Prev_Mean, prev_std_dev, prev_max_value, prev_min_value, prev_response_count,
	                                          curr_mean, curr_std_dev, curr_max_value, curr_min_value, curr_response_count } );
																						
	 dedup_final_1 := dedup(		sort( dedup_final_0,
																						flagship, model, 
	                                          Prev_Mean, prev_std_dev, prev_max_value, prev_min_value, prev_response_count,
	                                          curr_mean, curr_std_dev, curr_max_value, curr_min_value, curr_response_count ),
															 flagship, model,
															Prev_Mean, prev_std_dev, prev_max_value, prev_min_value, prev_response_count,
															curr_mean, curr_std_dev, curr_max_value, curr_min_value, curr_response_count );
		// dedup_final_1;													
															
   final_result_left  :=
   join( result1, result2,
      left.get_score_bin = right.get_score_bin and
			left.flagship = right.flagship and
			left.model = right.model ,
			transform(recordof(final_rec),
			self.flagship 	:= left.flagship ;
			self.model := left.model;
			self.bin := left.get_score_bin;
			self.prev_frequency := left.cnt_grp;
			self.prev_proportion := left.cnt_grp/left.file_count;
      self.Prev_Mean := 0; // left.mean;
			self.prev_std_dev := 0; // left.std_dev;
			self.prev_max_value := 0; // left.max_value;
			self.prev_min_value := 0; // left.min_value;
      self.prev_invalid := if( left.get_score_bin  in[ 'UNDEFINED' , 'NULL'], left.cnt_grp, 0);
			// self.prev_exceptions := if( left.get_score_bin in ['100','101','102','103','104','200','210','222'], left.cnt_grp, 0);
			self.prev_cum_proportion := 0;
			self.prev_default := 0;
			// self.curr_bin := right.get_score_bin;
			self.curr_frequency := right.cnt_grp;
			self.curr_proportion := right.cnt_grp/right.file_count ;
			self.curr_cum_proportion := 0;			
			self.prev_response_count := left.file_count;
			self.curr_response_count :=  right.file_count;			

      self.curr_mean := right.mean;
			self.curr_std_dev := right.std_dev;
			self.curr_max_value := right.max_value;
			self.curr_min_value := right.min_value;
			
			self.curr_invalid := if( left.get_score_bin  in[ 'UNDEFINED' , 'NULL'], right.cnt_grp, 0);
			self.curr_default := if( left.get_score_bin in ['222'], right.cnt_grp, 0);

			), left only);
			
			
			
			final_res_left_join := join (dedup_final_1, final_result_left,
			                             		left.flagship = right.flagship and
			                                left.model = right.model,
																			transform(recordof(final_result_left),
																			self := left,
																			self := right ));

   final_result_right  :=
   join( result2, result1,
      left.get_score_bin = right.get_score_bin and
			left.flagship = right.flagship and
			left.model = right.model ,
			transform(recordof(final_rec),
			self.flagship 	:= left.flagship ;
			self.model := left.model;
			self.bin := left.get_score_bin;
			self.prev_frequency := right.cnt_grp;
			self.prev_proportion := right.cnt_grp/left.file_count;
      self.Prev_Mean := right.mean;
			self.prev_std_dev := right.std_dev;
			self.prev_max_value := right.max_value;
			self.prev_min_value := right.min_value;
      self.prev_invalid := if( right.get_score_bin in[ 'UNDEFINED' , 'NULL'], right.cnt_grp, 0);
			// self.prev_exceptions := if( right.get_score_bin in ['100','101','102','103','104','200','210','222'], right.cnt_grp, 0);
			self.prev_cum_proportion := 0;
			self.prev_default := 0;
			// self.curr_bin := right.get_score_bin;
			self.curr_frequency := left.cnt_grp;
			self.curr_proportion := left.cnt_grp/left.file_count ;
			self.curr_cum_proportion := 0;			
			self.prev_response_count := right.file_count;
			self.curr_response_count := left.file_count;			

      self.curr_mean := 0; // left.mean;
			self.curr_std_dev := 0; // left.std_dev;
			self.curr_max_value := 0; // left.max_value;
			self.curr_min_value := 0; // left.min_value;
			
			self.curr_invalid := if( left.get_score_bin in[ 'UNDEFINED' , 'NULL'], left.cnt_grp, 0);
			// self.curr_exceptions := if( left.get_score_bin in ['100','101','102','103','104','200','210','222'], left.cnt_grp, 0);
			self.curr_default := if( left.get_score_bin in ['222'], left.cnt_grp, 0);

			), left only);

			// output(sort(final_result,flagship,model,  prev_bin)) ;			

      // final_result_right;

	    final_res_right_join := join (dedup_final_1, final_result_right,
			                             		left.flagship = right.flagship and
			                                left.model = right.model,
																			transform(recordof(final_result_left),
																			self := left,
																			self := right ));
			// final_res_right_join;
			
			
			final_rec fix_cumulative(final_rec L, final_rec R) := TRANSFORM
			SELF.prev_cum_proportion := r.prev_proportion + l.prev_cum_proportion;
			SELF.curr_cum_proportion := r.curr_proportion + l.curr_cum_proportion;
	
			SELF := R;
			END;

     

									 
      final_result_all := 		final_result + 	final_res_left_join + final_res_right_join ;						 
									 
			fix_cumulative_recs := SORT( GROUP(SORT(final_result_all,flagship,model,bin),flagship,model ),
			flagship,model,bin);			


     // fix_cumulative_recs;


			i3_fix := ITERATE(fix_cumulative_recs,fix_cumulative(LEFT,RIGHT));
			
	
	
	
			final_rec_final  := record

			string80 flagship;
			string80 model;
			string9 bin;
			integer8 prev_frequency;
			decimal19_5 prev_proportion;
			decimal19_5 prev_cum_proportion;
			integer8 curr_frequency;
			decimal19_5 curr_proportion;
			decimal19_5 curr_cum_proportion;
			integer8 prev_response_count;
			integer8 prev_invalid ;
			// integer8 prev_exceptions ;
			integer8 curr_response_count;
			integer8 curr_invalid ;
			// integer8 curr_exceptions ;
			integer8 diff_frequency;
			decimal19_5 diff_proportion;
			decimal19_5 diff_cum_proportion;

			decimal19_2 Prev_Mean;
			decimal19_2 prev_std_dev;
			integer8 prev_max_value;
			integer8 prev_min_value;
			integer8 prev_default;
			decimal19_2 curr_mean;
			decimal19_2 curr_std_dev;
			integer8 curr_max_value;
			integer8 curr_min_value;
			integer8 curr_default;

      integer8 diff_response_count ;
			decimal19_2 diff_mean;
			decimal19_2 diff_std_dev;
			// integer8 diff_max_value;
			// integer8 diff_min_value;
			integer8 diff_default;

      integer8 diff_invalid ;
			// integer8 diff_exceptions ;
	
	    decimal19_4 diverg_stat;

      decimal19_5 new_check_ks;
			end;


      final_tally := project (i3_fix , transform(recordof(final_rec_final),
			                   self.diff_response_count := left.curr_response_count - left.prev_response_count  ;
			                   self.diff_frequency := left.curr_frequency - left.prev_frequency ;
												 self.diff_proportion := left.curr_proportion - left.prev_proportion;
												 self.diff_cum_proportion := if ( left.curr_cum_proportion > 0.9999,(real) 1.0, left.curr_cum_proportion ) - if ( left.prev_cum_proportion > 0.9999, (real)1.0, left.prev_cum_proportion ) ;
												 
			                   self.diff_mean := left.curr_mean - left.Prev_Mean ;
												 self.diff_std_dev := left.curr_std_dev - left.prev_std_dev;
			                   // self.diff_max_value := left.curr_max_value - left.prev_max_value ;
			                   // self.diff_min_value := left.curr_min_value - left.prev_min_value ;												 
												 self.diff_default := left.curr_default - left.prev_default ;
			                   self.diff_invalid := left.curr_invalid - left.prev_invalid ;
			                   // self.diff_exceptions := left.curr_exceptions - left.prev_exceptions ;
												 
												 self.diverg_stat :=power((left.curr_mean - left.prev_mean) , 2.0 ) /
												                         ( ( power(left.curr_std_dev, 2.0) + power(left.prev_std_dev, 2.0) ) / 2.0 ) ;
																								 
                         self.new_check_ks := 1.22 * sqrt(( ( left.curr_response_count + left.prev_response_count) / ( left.curr_response_count * left.prev_response_count)))  ; 																								 
												 self := left));
												 
      // output(choosen(final_tally, 10000), named('final_tally')) ;					
			

      ks_rec := record

      final_tally.flagship;
			final_tally.model;
			//final_tally.prev_bin;

      string80 ks_flag := '';	
			// string80 rule_based_str :='';
			
			final_tally.diverg_stat;
			
			final_tally.prev_response_count;
			final_tally.Prev_Mean;
			final_tally.prev_std_dev;			
			final_tally.prev_max_value;
			final_tally.prev_min_value;		
			
			integer8 prev_invalid := sum(group, final_tally.prev_invalid);
			// integer8 prev_exceptions := sum(group, final_tally.prev_exceptions);			

	    integer8 prev_default := sum(group, final_tally.prev_default);
			
      final_tally.curr_response_count;
			final_tally.curr_mean;
			final_tally.curr_std_dev;			
			final_tally.curr_max_value;
			final_tally.curr_min_value;			

			integer8 curr_invalid := sum(group, final_tally.curr_invalid);
			// integer8 curr_exceptions := sum(group, final_tally.curr_exceptions);			
			integer8 curr_default := sum(group, final_tally.curr_default);

       final_tally.diff_response_count;
			 final_tally.diff_mean;
			 final_tally.diff_std_dev;	
			
		
			// final_tally.diff_max_value;
			// final_tally.diff_min_value;		
			

			integer8 diff_invalid := sum(group, final_tally.diff_invalid);
			// integer8 diff_exceptions := sum(group, final_tally.diff_exceptions);				
			
			integer8 diff_default := sum(group, final_tally.diff_default);
			
			// check_ks := 1.36 / sqrt(final_tally.prev_response_count) ; 
			
			check_ks := max(group, final_tally.new_check_ks);
			
			// check_ks := 1.22 / sqrt(( ( final_tally.prev_response_count + final_tally.prev_response_count) / ( final_tally.prev_response_count * final_tally.prev_response_count)))  ; 
			
			max_diff_proportion := max(group, abs(final_tally.diff_cum_proportion) );
			max_ks 							:= max(group, abs(final_tally.diff_proportion) );
			
      bin_shift_05 := sum(group, if(abs(final_tally.diff_proportion) > .005  , 	1 , 0));		
			// sum_of_bins_gt_1 := sum(group, if(abs(final_tally.diff_proportion) > .01 , 1, 0));		
			// sum_of_bins_gt_15 := sum(group, if(abs(final_tally.diff_proportion) > .015 ,1, 0));		
			
			integer no_of_bins := count(group);
			end;
			
			table_max_ks := table(final_tally, ks_rec, flagship, model);
			
			
			
			// table_max_ks;
			
				table_max_ks_out := project (table_max_ks, transform({recordof(table_max_ks) - check_ks - max_diff_proportion - max_ks   },
																	
																
				
																	self.ks_flag := if( left.max_diff_proportion > left.check_ks ,
																	                         'Different',
																													 'Same');
																													 
																	self.diverg_stat:=left.diverg_stat * 1000;												 
															
																	
																	self := left ;));
			
			// table_max_ks_out;
					
		  // output(table_max_ks,,'~kreddy::test::table_max_ks');     
			table_max_ks_out_layout:=RECORD
  string80 flagship;
  string80 model;
  string80 ks_flag;
  decimal19_4 diverg_stat;
  integer8 prev_response_count;
  decimal19_2 prev_mean;
  decimal19_2 prev_std_dev;
  integer8 prev_max_value;
  integer8 prev_min_value;
  integer8 prev_invalid;
  integer8 prev_default;
  integer8 curr_response_count;
  decimal19_2 curr_mean;
  decimal19_2 curr_std_dev;
  integer8 curr_max_value;
  integer8 curr_min_value;
  integer8 curr_invalid;
  integer8 curr_default;
  integer8 diff_response_count;
  decimal19_2 diff_mean;
  decimal19_2 diff_std_dev;
  integer8 diff_invalid;
  integer8 diff_default;
  // decimal19_5 check_ks;
  // decimal19_5 max_diff_proportion;
  // decimal19_5 max_ks;
  integer8 bin_shift_05;
  integer8 no_of_bins;
 END;


			
 table_max_ks_out_project:=scores_project(table_max_ks_out,table_max_ks_out_layout);
 
 
 // table_max_ks_out_project;
  
    		final_rec_stats_join:= record		  
       string30 acctno; 
     string80 product; 
   	string80 version;
   	string80 process1 ;
   	string80 customer ;
   	string80 model1 ;
   	string80 prev_dual_valid;
   	string80 curr_dual_valid ;
   	decimal19_2 curr_dual_valid_prev_dual_valid;
   	
   	decimal19_2 prev_response_count;
   	decimal19_2 curr_response_count;
   	
   
   
   	
   
   end;
    final_rec_stats_join_ds:= join(table_max_ks_out_project,dual_rec_ds,left.product = right.product and
                                                          	left.version = right.version and
   			                                                   left.process1 = right.process1 and
   			                                                   left.customer = right.customer and
   																												 left.model1 = right.model1 ,
   			transform(recordof(final_rec_stats_join),
   			self.prev_response_count 	:= left.prev_response_count ;
   			self.curr_response_count := left.curr_response_count;	
   	
   			self:=right;
   	));
		
		// final_rec_stats_join_ds;
		
		
		
				


  final_rec_stats_join_ds_stats_layout := record
       final_rec_stats_join_ds.product; 
      	final_rec_stats_join_ds.version;
      	final_rec_stats_join_ds.process1 ;
      	final_rec_stats_join_ds.customer ;
      	final_rec_stats_join_ds.model1 ;
      	final_rec_stats_join_ds.prev_dual_valid;
      	final_rec_stats_join_ds.curr_dual_valid ;
      	// decimal19_2 curr_dual_valid_prev_dual_valid;
         	decimal19_2 Dual_Perc_Pos:=COUNT(group,(decimal19_2 )final_rec_stats_join_ds.curr_dual_valid - (decimal19_2 )	final_rec_stats_join_ds.prev_dual_valid > 0) ;
         	decimal19_2 Dual_Perc_Neg :=COUNT(group,(decimal19_2 )final_rec_stats_join_ds.curr_dual_valid - (decimal19_2 )	final_rec_stats_join_ds.prev_dual_valid < 0) ;
   				
         	// decimal19_2 Dual_Neg_Scr_Chg :=ave(group,((decimal19_2 )final_rec_stats_join_ds.curr_dual_valid - (decimal19_2 )	final_rec_stats_join_ds.prev_dual_valid) < 0) ;
         	// decimal19_2	avg_curr_dual_valid:=ave(group,(real)dual_rec_ds.curr_dual_valid );	
         end;
         											 
   
   
    	 final_rec_stats_join_ds_stats:=  table(final_rec_stats_join_ds,final_rec_stats_join_ds_stats_layout,product,version,process1,customer,model1);
   	
   	// final_rec_stats_join_ds_stats;

 Dual_Pos_Scr_ds:=final_rec_stats_join_ds(curr_dual_valid_prev_dual_valid> 0);
 Dual_Neg_Scr_ds:=final_rec_stats_join_ds(curr_dual_valid_prev_dual_valid<0);
 
 Dual_Pos_Scr_ds_stats_layout:= record
 
        Dual_Pos_Scr_ds.product; 
      	Dual_Pos_Scr_ds.version;
      	Dual_Pos_Scr_ds.process1 ;
      	Dual_Pos_Scr_ds.customer ;
      	Dual_Pos_Scr_ds.model1 ;
  decimal19_2 Dual_Pos_Scr_Chg:=ave(group,Dual_Pos_Scr_ds.curr_dual_valid_prev_dual_valid) ;
 end;
 Dual_Pos_Scr_ds_stats:=table(Dual_Pos_Scr_ds,Dual_Pos_Scr_ds_stats_layout,product,version,process1,customer,model1);
 
 // Dual_Pos_Scr_ds_stats;
 
  Dual_Neg_Scr_ds_stats_layout:= record
 
        Dual_Neg_Scr_ds.product; 
      	Dual_Neg_Scr_ds.version;
      	Dual_Neg_Scr_ds.process1 ;
      	Dual_Neg_Scr_ds.customer ;
      	Dual_Neg_Scr_ds.model1 ;
  decimal19_2 Dual_Neg_Scr_Chg:=ave(group,Dual_Neg_Scr_ds.curr_dual_valid_prev_dual_valid) ;
 end;
 Dual_Neg_Scr_ds_stats:=table(Dual_Neg_Scr_ds,Dual_Neg_Scr_ds_stats_layout,product,version,process1,customer,model1);
 
 // Dual_Neg_Scr_ds_stats;
 
 join1_layout:= record
  string80 product;
	string80 version;
	string80 process1;
	string80 customer;
	string80 model1;
	string80 ks_flag;
  decimal19_4 diverg_stat;
	string30 ND_Stat_Flag_10;
	string30 ND_Stat_Flag_05;
	decimal19_2	z_score;
	decimal19_2 prev_response_count;
	decimal19_2 prev_mean;
	decimal19_2	prev_std_dev;	
	decimal19_2 prev_max_value;
	decimal19_2 prev_min_value;
	decimal19_2 prev_invalid;	
	decimal19_2 curr_response_count;
	decimal19_2 curr_mean;
	decimal19_2	curr_std_dev;
	decimal19_2 curr_max_value;
	decimal19_2 curr_min_value;	
	decimal19_2 curr_invalid;	
	decimal19_2 Diff_Response_Count;
	decimal19_2 diff_mean;
	decimal19_2 diff_std_dev;
	decimal19_2 diff_invalid;
	decimal19_2 Bin_Shift_05;
	decimal19_2 No_Of_Bins;
 
 
 end;
 
 join1:=join(table_max_ks_out_project,final_rec_ds,      left.product = right.product and
                                                       	 left.version = right.version and
			                                                   left.process1 = right.process1 and
			                                                   left.customer = right.customer and
																												 left.model1 = right.model1 ,
			transform(recordof(join1_layout),
			self.ks_flag 	:= left.ks_flag ;
			self.diverg_stat := left.diverg_stat;
			self.ND_Stat_Flag_10 	:= if(abs((right.curr_mean - right.prev_mean) / (sqrt((right.prev_std_dev*right.prev_std_dev)/ left.prev_response_count + 
			                                                              (right.curr_std_dev*right.curr_std_dev) / left.curr_response_count))) > 1.645, 'Different', 'Same');	
			self.ND_Stat_Flag_05 := if(abs((right.curr_mean - right.prev_mean) / (sqrt((right.prev_std_dev*right.prev_std_dev)/ left.prev_response_count + 
			                                                              (right.curr_std_dev*right.curr_std_dev) / left.curr_response_count))) > 1.96, 'Different', 'Same');
			self.z_score 	:=   ((right.curr_mean - right.prev_mean) / (sqrt((right.prev_std_dev*right.prev_std_dev)/ left.prev_response_count + 
			                                                              (right.curr_std_dev*right.curr_std_dev) / left.curr_response_count)));
			
			self.prev_response_count 	:= left.prev_response_count ;
			self.prev_mean 	:= right.prev_mean ;
			self.prev_std_dev := right.prev_std_dev;
			self.prev_max_value 	:= right.prev_max_value ;
			self.prev_min_value 	:= right.prev_min_value ;
			self.prev_invalid := left.prev_invalid;	
			self.curr_response_count := left.curr_response_count;			
      self.curr_mean := right.curr_mean;		 
			self.curr_std_dev := right.curr_std_dev;
			self.curr_max_value := right.curr_max_value;
			self.curr_min_value := right.curr_min_value;
			self.curr_invalid := left.curr_invalid;	
			self.diff_response_count:=left.curr_response_count - left.prev_response_count;
			self.diff_mean:=right.curr_mean - right.prev_mean;
			self.diff_std_dev:=right.curr_std_dev - right.prev_std_dev;
			self.diff_invalid:=left.curr_invalid - left.prev_invalid;
			self.Bin_Shift_05 := left.Bin_Shift_05;	
			self.No_Of_Bins := left.No_Of_Bins;	
			
			self:=right;
	));
	
	// join1;

join2_layout:= record
   recordof(join1_layout);
  decimal19_2 Dual_Mean_Chg;
			decimal19_2 Dual_count;
	decimal19_2 Dual_Max_Chg ;
 end;


join2:=join(join1,dual_rec_ds_mean,                      left.product = right.product and
                                                       	 left.version = right.version and
			                                                   left.process1 = right.process1 and
			                                                   left.customer = right.customer and
																												 left.model1 = right.model1 ,
			transform(recordof(join2_layout),
			
			self.Dual_Mean_Chg := right.Dual_Mean_Chg;	
					self.Dual_count := right.Dual_count;	
			self.Dual_Max_Chg := right.Dual_Max_Chg;	
			
			self:=left;
	));
											 
 	// join2;
	
  	 join3_layout:= record		 
		 	  recordof(join2_layout);			
				decimal19_2 Dual_Perc_Pos_chg;
			 	decimal19_2 Dual_Perc_Neg_chg;
        
     end;
					
					         
          join3:=join(join2,final_rec_stats_join_ds_stats,       left.product = right.product and
                                                                 left.version = right.version and
         			                                                   left.process1 = right.process1 and
         			                                                   left.customer = right.customer and
         																												 left.model1 = right.model1 ,
         			transform(recordof(join3_layout),
         			
         			self.Dual_Perc_Pos_chg 	:= (right.Dual_Perc_Pos/left.curr_response_count)*100 ;
         			self.Dual_Perc_Neg_chg := (right.Dual_Perc_Neg/left.curr_response_count)*100 ;
         			self:=left;
         	));
         	// join3;

      	
				
	join4_layout:= record		 
		   	recordof(join3_layout);			
				decimal19_5 perc_To_Default;
			
        
    end;
					
					
          
          join4:=join(join3,count_to_default_rec_ds,       left.product = right.product and
                                                                 left.version = right.version and
         			                                                   left.process1 = right.process1 and
         			                                                   left.customer = right.customer and
         																												 left.model1 = right.model1 ,
         			transform(recordof(join4_layout),
         			
         			self.perc_To_Default 	:= (right.count_to_default/left.curr_response_count)*100 ;
         					
         			self:=left;
         	),left outer);
					
					// join4;
					
					
					
						join5_layout:= record		 
		   	recordof(join4_layout);			
				
			 	decimal19_5 perc_From_Default;
				
        
    end;
					
					
          
          join5:=join(join4,count_from_default_rec_ds,       left.product = right.product and
                                                                 left.version = right.version and
         			                                                   left.process1 = right.process1 and
         			                                                   left.customer = right.customer and
         																												 left.model1 = right.model1 ,
         			transform(recordof(join5_layout),
         			
         			self.perc_From_Default 	:= (right.count_from_default/left.curr_response_count)*100 ;
         					
         			self:=left;
         	),left outer);
					
					
								join6_layout:= record		 
		   	recordof(join5_layout);			
			
				decimal19_2 pct_score_same;
        
    end;
					
					
          
          join6:=join(join5,score_name_layout_ds,       left.product = right.product and
                                                                 left.version = right.version and
         			                                                   left.process1 = right.process1 and
         			                                                   left.customer = right.customer and
         																												 left.model1 = right.model1 ,
         			transform(recordof(join6_layout),
         			
         			self.pct_score_same 	:= (right.score_name/left.curr_response_count)*100 ;
         					
         			self:=left;
         	),left outer);
					
					// join5;
					
 				join7_layout:= record
   		                	recordof(join6_layout);
   				              decimal19_2 Dual_Pos_Scr_Chg;
             end;
   					
   					
             
             join7:=join(join6,Dual_Pos_Scr_ds_stats,       left.product = right.product and
                                                                    left.version = right.version and
            			                                                   left.process1 = right.process1 and
            			                                                   left.customer = right.customer and
            																												 left.model1 = right.model1 ,
            			transform(recordof(join7_layout),
            			
            			self.Dual_Pos_Scr_Chg 	:= right.Dual_Pos_Scr_Chg ;
            			self:=left;
            	),left outer);
							
							
							// join5;
   		
    					join8_layout:= record      		 
      		                  	recordof(join7_layout);
      		                    decimal19_2 Dual_Neg_Scr_Chg;
                 end;
      					
      					
                
                join8:=join(join7,Dual_Neg_Scr_ds_stats,       left.product = right.product and
                                                                       left.version = right.version and
               			                                                   left.process1 = right.process1 and
               			                                                   left.customer = right.customer and
               																												 left.model1 = right.model1 ,
               			transform(recordof(join8_layout),               			
               			self.Dual_Neg_Scr_Chg 	:= right.Dual_Neg_Scr_Chg ;             			
      							self:=left;
               	),left outer);
								
								
      
      

			

   

			join10_layout:= record      		 
      		                  	recordof(join8_layout);      		               													
															decimal19_2 Prev_Default;
                           
                     end;
											 

      					
      					
                
                join10:=join(join8,default_rec_ds_1,       left.product = right.product and
                                                                       left.version = right.version and
               			                                                   left.process1 = right.process1 and
               			                                                   left.customer = right.customer and
               																												 left.model1 = right.model1 ,
               			transform(recordof(join10_layout),               			
               			self.Prev_Default 	:= right.prev_default ;  
						
      							self:=left;
               	),left outer);



		join11_layout:= record      		 
      		                  	recordof(join10_layout);      		               													
															decimal19_2 curr_default;
                           
                     end;
											 

      					
      					
                
                join11:=join(join10,default_rec_ds_2,       left.product = right.product and
                                                                       left.version = right.version and
               			                                                   left.process1 = right.process1 and
               			                                                   left.customer = right.customer and
               																												 left.model1 = right.model1 ,
               			transform(recordof(join11_layout),               			
               			self.curr_default 	:= right.curr_default ;  
						
      							self:=left;
               	),left outer);
								

// BIID_Scores_BATCH_Generic_infile :=scoring_project_pip.Input_Sample_Names.BIID_Scores_BATCH_Generic_infile;
BIIDv2_Scores_XML_Generic_infile:= scoring_project_pip.Input_Sample_Names.BIIDv2_Scores_XML_Generic_infile;



input_file_count_ds_rec:=record
  string80 product; 
	string80 customer ;
	string80 process1;
  string80 model1;
	string80 version;
	decimal19_2 input_file_count;
end;


// biid_layout_input:=Record
                // Scoring_Project_Macros.Regression.global_layout;
                // Scoring_Project_Macros.Regression.pii_layout;
                // Scoring_Project_Macros.Regression.bus_layout;
                // Scoring_Project_Macros.Regression.runtime_layout;
                // End;
								
	// BIID_Scores_BATCH_Generic_infile_cnt:=count(dataset(BIID_Scores_BATCH_Generic_infile,biid_layout_input,thor));
	// BIID_Scores_XML_Generic_infile_cnt:=count(dataset(BIID_Scores_XML_Generic_infile,biid_layout_input,thor));	
					
								
biidv2_layout_input:=Record
                // Scoring_Project_Macros.Regression.biidv2_layout;
								Scoring_Project_Macros.Regression.global_layout;
                Scoring_Project_Macros.Regression.pii_layout;
                Scoring_Project_Macros.Regression.bus_layout;
                Scoring_Project_Macros.Regression.runtime_layout;
								End; 
  BIIDv2_Scores_XML_Generic_infile_cnt:=count(dataset(BIIDv2_Scores_XML_Generic_infile,biidv2_layout_input,thor));  

							

  input_file_count_ds:=DATASET([ 
	                               {'BusinessInstantIdv2','Generic','XML','bvi','0',50000},
	                               {'BusinessInstantIdv2','Generic','XML','rep1_cvi','0',50000},
																 {'BusinessInstantIdv2','Generic','XML','bus2exec_index_rep1','0',50000}
																 
                                 ],input_file_count_ds_rec);

       
                 input_file_count_ds_result:=join(join11,input_file_count_ds,  left.product = right.product and
                                                                               left.customer = right.customer and
																																							 left.process1=right.process1 and
																																							 left.model1 = right.model1 and
																																							 trim(left.version,left,right)=trim(right.version,left,right)
                     																												
                     		                     	); 	
   
	 
	  final_layout:= record
  string80 product;
	string80 version;
	string80 process1;
	string80 customer;
	string80 model1;
	string80 ks_flag;
  decimal19_4 diverg_stat;
	string30 ND_Stat_Flag_10;
	string30 ND_Stat_Flag_05;
	decimal19_2	z_score;
  string30 Default_Score_Flag;
	decimal19_2 Default_Score_Chng;
	decimal19_2 Input_File_Count;
	decimal19_2 prev_response_count;
	decimal19_2 prev_mean;
	decimal19_2	prev_std_dev;	
	decimal19_2 prev_max_value;
	decimal19_2 prev_min_value;
	decimal19_2 prev_invalid;	
	decimal19_2 Prev_Default;
	decimal19_2 curr_response_count;
	decimal19_2 curr_mean;
	decimal19_2	curr_std_dev;
	decimal19_2 curr_max_value;
	decimal19_2 curr_min_value;	
	decimal19_2 curr_invalid;	
	decimal19_2 curr_default;
	decimal19_2 Diff_Response_Count;
	decimal19_2 diff_mean;
	decimal19_2 diff_std_dev;
	decimal19_2 diff_invalid;
	decimal19_2 Diff_Default;
	decimal19_2 Bin_Shift_05;
	decimal19_2 No_Of_Bins;
	decimal19_2 Dual_Mean_Chg;
	decimal19_2 Dual_Max_Chg ;
	decimal19_2 Dual_Perc_Pos_chg;
	decimal19_2 Dual_Perc_Neg_chg;
	decimal19_5 perc_To_Default;
 	decimal19_5 perc_From_Default;
  decimal19_2 Dual_Pos_Scr_Chg;
	decimal19_2 Dual_Neg_Scr_Chg;
	decimal19_2 Dual_count;
	decimal19_2 pct_score_same;	
 end;
      	 result_1:=project(input_file_count_ds_result,transform(final_layout,self.Diff_Default:=left.curr_default-left.Prev_Default,
				 
				                                                 			self.Default_Score_Chng 	:= left.curr_default-left.Prev_Default ;  
   										                                        self.Default_Score_Flag :=IF(abs(left.curr_default-left.Prev_Default) > 3, 'Score_Alert', 'NA'),self:=left));
				 
				 
						 
				 			 result:=project(result_1,transform(final_layout,self.product:=if(left.customer in['BestBuy_10k'  ,'BestBuy'],'ChargeBackDefender',left.product),self:=left));
				 
				 input_file_count_ds_pjt:=project(input_file_count_ds,transform(recordof(input_file_count_ds),self.product:=if(left.customer in['BestBuy_10k'  ,'BestBuy'],'ChargeBackDefender',left.product),self:=left));
						 
						
				 FCRA_result:=result(product='RiskView');
				 
				 
				 NON_FCRA_result:=result(product<>'RiskView');
																									 
				
							
	//************		KS Report Exception Handling **********************
	

	        FCRA_alert_file_list:=join(input_file_count_ds_pjt(product='RiskView'),FCRA_result,trim(left.product,left,right)= trim(right.product,left,right) and 
													                 trim(left.version,left,right)= trim(right.version,left,right) and 
																					 trim(left.process1,left,right)= trim(right.process1,left,right) and 
																					 trim(left.customer,left,right)= trim(right.customer,left,right) and
																					 trim(left.model1,left,right)= trim(right.model1,left,right), 
																 transform(recordof(input_file_count_ds) -input_file_count,self:=left),left only
																																															 );
	        Non_FCRA_alert_file_list:=join(input_file_count_ds_pjt(product<>'RiskView'),NON_FCRA_result,trim(left.product,left,right)= trim(right.product,left,right) and 
													                 trim(left.version,left,right)= trim(right.version,left,right) and 
																					 trim(left.process1,left,right)= trim(right.process1,left,right) and 
																					 trim(left.customer,left,right)= trim(right.customer,left,right) and
																					 trim(left.model1,left,right)= trim(right.model1,left,right), 
																 transform(recordof(input_file_count_ds) -input_file_count,self:=left),left only
																																															);
	  
          alert_file_list:= FCRA_alert_file_list + Non_FCRA_alert_file_list;
							
						
				  lay_alert := RECORD
					INTEGER order;
					STRING line;
					END;

	        					
					alert_msg_body := PROJECT(dedup(sort(alert_file_list,product,customer,process1,model1,version),product,customer,process1,model1,version), TRANSFORM(lay_alert, SELF.order := 2;
						          SELF.line := (TRIM(LEFT.product) )[1..25]  + LEFT.customer [1..23] + LEFT.process1[1..18]  + LEFT.model1[1..13] + LEFT.version[1..13];
						          SELF := LEFT));		

			

					line_heading := ('product' ) + '\t\t\t' + 'customer' + '\t\t\t' + 'process'+ '\t\t' +  'model'+ '\t\t' + 'version';

					head_cert_realtime := DATASET([{1,    
					''	+ '\n'

					+ line_heading + '\n'
					+ '-------------------------------------------------------------------------------------'
					}], lay_alert); 		

					main_head_ds := DATASET([{3,  'KS Report ' + prev_date + ' vs ' + curr_date +' did not run properly for the following products or versions' + '\n'
					+ '\n'
					}], lay_alert);


					alert_msg:= IF(count(alert_file_list)<69,main_head_ds) + head_cert_realtime + alert_msg_body ;



			  	lay_alert Xform_func(lay_alert L,lay_alert R) := TRANSFORM
					SELF.line := TRIM(L.line, LEFT) + '\n' + TRIM(R.line, LEFT); 
					self := l;
					END;

					alert_msg_file := ITERATE(alert_msg, Xform_func(LEFT, RIGHT));
					
				
					// alert_msg_file;

				
	//********************************************************************	
							
 			  // fcra_alert_msg:=	if(count(FCRA_result)<28,'\n ALERT: This FCRA report did not run properly for all products or versions','');
   			
   			nonfcra_alert_msg:=	if(count(NON_FCRA_result)<41,'\n ALERT: This NON-FCRA report did not run properly for all products or versions','');
   																									 
   				 // result;
   
      			// out_file := output(FCRA_result , ,'~ScoringQA::out::ks1::FCRA_result' + curr_date, CSV(heading(single), quote('"')), overwrite );
    			
      			
      			string out_file_layout := '';
      
      			
            outfile := dataset('~ScoringQA::out::ks1::FCRA_result' + curr_date, typeof(out_file_layout));
      			
      
            no_of_records := count(outfile);
      			
      			
      			myrec := record, maxlength(9999999) 
      			unsigned code0; 
      			unsigned code1;
      			string line; end;
      
      			myrec ref(outfile l, integer c) := transform 
      			self.code0 := c; 
      			self.code1 := c + 1 ;
      			// self := l; 
            self.line := if( c = 1, 	'                        KS(FCRA) Report Dates   ' +  prev_date + '_VS_' + curr_date + '\n' + l.line 	, l.line);
      			
      			// self.line := if(c = 2 , 'FCRA CUSTOM'   + '\n' + l.line, if(c = 5 , 'FCRA FLAGSHIP'   + '\n' + l.line,
      			                  // if(c = 27 , 'Non Fcra Custom'   + '\n' + l.line, if(c = 32 , 'Non Fcra Flagship'   + '\n' + l.line, l.line)))) ; 
      			end;
      
      			outputs := project(outfile, ref(left, counter));
      			
      			// outputs;
      
      			MyRec Xform(myrec L,myrec R) := TRANSFORM
      			SELF.line := trim(L.line, left, right) + '\n' + trim(R.line, left, right); 
      			self := l;
      			END;
      
      			XtabOut := iterate(outputs,Xform(left,right));
      			
            // XtabOut[no_of_records];
      
      						// send_file := fileservices.SendEmailAttachText('isabel.ma@lexisnexisrisk.com',
      			// send_file := fileservices.SendEmailAttachText(Scoring_Project_DailyTracking.email_distribution.KS_Success_list,
      			 // 'KS(FCRA)'  +  'test results Direct from Thor ',
      																				 // prev_date + ' vs ' + curr_date + '\nPlease view attachment.'+ fcra_alert_msg ,
      																				 // XtabOut[no_of_records].line ,
      																				 // 'text/plain; charset=ISO-8859-3', 
      																				 // 'KS_FCRA' +  prev_date + '_VS_' + curr_date + '.csv',
      																				 // ,
      																				 // ,
      																				 // 'Scoring_QA@risk.lexisnexis.com');
      																				 
      					out_file1 := output(NON_FCRA_result , ,'~ScoringQA::out::ks1::NON_FCRA_result' + curr_date, CSV(heading(single), quote('"')), overwrite, EXPIRE(30) );
      			
      			
      			// string out_file_layout := '';
      
      			
            outfile1 := dataset('~ScoringQA::out::ks1::NON_FCRA_result' + curr_date, typeof(out_file_layout));
      			
      
            no_of_records1 := count(outfile1);
      			
      			
      			myrec1 := record, maxlength(9999999) 
      			unsigned code0; 
      			unsigned code1;
      			string line; end;
      
      			myrec1 ref1(outfile1 l, integer c) := transform 
      			self.code0 := c; 
      			self.code1 := c + 1 ;
      			// self := l; 
            self.line := if( c = 1, 	'                        KS(NON_FCRA) Report Dates   ' +  prev_date + '_VS_' + curr_date + '\n' + l.line 	, l.line);
      			
      			end;
      
      			outputs1 := project(outfile1, ref1(left, counter));
      			
      			// outputs;
      
      			MyRec1 Xform1(myrec L,myrec R) := TRANSFORM
      			SELF.line := trim(L.line, left, right) + '\n' + trim(R.line, left, right); 
      			self := l;
      			END;
      
      			XtabOut1 := iterate(outputs1,Xform1(left,right));
      			
      			
            // XtabOut[no_of_records];
      
      			
      					send_file1 := fileservices.SendEmailAttachText('isabel.ma@lexisnexisrisk.com',
      			// send_file1 := fileservices.SendEmailAttachText(Scoring_Project_DailyTracking.email_distribution.KS_Success_list,
      			      			 'KS(BIIDv2)'  +  'test results Direct from Thor ',
      																				 prev_date + ' vs ' + curr_date + '\nPlease view attachment.' + nonfcra_alert_msg,
      																				 XtabOut1[no_of_records1].line ,
      																				 'text/plain; charset=ISO-8859-3', 
      																				 'KS_NON_FCRA' +  prev_date + '_VS_' + curr_date + '.csv',
      																				 ,
      																				 ,
      																				 'Scoring_QA@risk.lexisnexis.com');	
																							 
					   send_file2 :=FileServices.SendEmail('Weiyu.Ma@lexisnexisrisk.com', 'KS Report Exceptions ' , alert_msg_file[COUNT(alert_msg_file)].line);																		 
      																				 
      																				 
           sequential ( out_file1,send_file1,IF(count(alert_file_list)>0,send_file2));		//	out_file,	send_file ,													 
     																 
     
   
EXPORT biidv2_ks_test := 'todo';