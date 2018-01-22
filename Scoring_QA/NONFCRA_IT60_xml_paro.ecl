EXPORT NONFCRA_IT60_xml_paro(route ,name,current_dt,previous_dt) := functionmacro



file1:= dataset(route + 'scoringqa::out::nonfcra::'+name +previous_dt, Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_IT60_Paro_Global_Layout	,


thor);
 
 file2:= dataset(route + 'scoringqa::out::nonfcra::'+ name +current_dt, Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_IT60_Paro_Global_Layout	,


thor);




file1_dedup:=dedup(file1,acctno,all);
file2_dedup:=dedup(file2,acctno,all);

aa1:=join(file1_dedup,file2_dedup,left.acctno=right.acctno,inner);

aa:=aa1(acctno<>'');

DS1:=join(file1_dedup,aa,left.acctno=right.acctno,inner);

DS2:=join(file2_dedup,aa,left.acctno=right.acctno,inner);

                           
                              Missing_values:= JOIN(DS2,DS1,LEFT.acctno=RIGHT.acctno and LEFT.did!=RIGHT.did,local);
													
										pfc := count(ds1);
   cfc := count(ds2);
	 
   fcd :=cfc-pfc;
pf:=count(Missing_values);
cf:=count(Missing_values);

pd:=if(pfc!= 0 and cfc=0,1,cf/cfc);
abd:=abs(pd);
ppd:=if(pfc!= 0 and cfc=0,1,(cf/cfc)*100);
	 
	 

   	  						
										
 			

       	  Scoring_QA.Range_function_module.Distinct_function(DS2,'bansmatchflag',dis1);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'bansecoaflag',dis2);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'decsflag',dis3);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'inputaddrcharflag',dis4);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'inputsocscharflag',dis5);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'phonestatusflag',dis6);					
					Scoring_QA.Range_function_module.Distinct_function(DS2,'addrstatusflag',dis7);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'addrcharflag',dis8);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'hownstatusflag',dis9);
					Scoring_QA.Range_function_module.Range_Function_213(DS2,'estincome',dis10);
    
				
					
			
					
					Scoring_QA.Range_function_module.Distinct_function(DS2,'fnamepop',dis11);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'lnamepop',dis12);
				  Scoring_QA.Range_function_module.Distinct_function(DS2,'addrpop',dis13);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'ssnlength',dis14);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'dobpop',dis15);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'emailpop',dis16);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'ipaddrpop',dis17);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'hphnpop',dis18);
    
				
					
			
					
					dis:= dis1  + dis2  + dis3  + dis4  + dis5  + dis6  + dis7  + dis8  + dis9  + dis10 +
					       dis11 + dis12 + dis13 + dis14 + dis15 + dis16 +dis17 + dis18;
				      
							 Scoring_QA.Range_function_module.Distinct_function7(DS2,'did',did1);
	 
	 
	 did_stats:=did1;			
				
			result2_stats:= dis + did_stats;
   				
        
					
				Scoring_QA.Range_function_module.Average_func(DS2,'bansmatchflag',ave1);
				Scoring_QA.Range_function_module.Average_func(DS2,'decsflag',ave2);
				Scoring_QA.Range_function_module.Average_func(DS2,'inputsocscharflag',ave3);
		    Scoring_QA.Range_function_module.Average_func(DS2,'phonestatusflag',ave4);
			 	Scoring_QA.Range_function_module.Average_func(DS2,'addrstatusflag',ave5);
				Scoring_QA.Range_function_module.Average_func(DS2,'hownstatusflag',ave6);
		  	Scoring_QA.Range_function_module.Average_func(DS2,'estincome',ave7);			
				
      
   avearage:= ave1  + ave2  + ave3   + ave5  + ave6  + ave7 ;
			
	
	
	
   result4_stats:=avearage;
	 
	  compare_layout_stats := RECORD
		  string file_version;
			string mode;
      string field_name;
      string distribution_type;		
      STRING50 attribute_value; 
			decimal20_4 Count1;
      decimal20_4 file_count;
      decimal20_4 ds_count;

     						
    END;
		
		
		compare_layout_stats func(result4_stats l):=transform
                                         self.file_version:='IT60_paro';
																				 self.mode:='xml';
																				 self.file_count:=count(file2),
																				 self.ds_count:=count(ds2),
																				 self:=l;
		
		end;
		
		result4_stats_project:= project(result4_stats,func(left));		
     	

compare_layout_stats func1(result2_stats l):=transform
                                         self.file_version:='IT60_paro';
																				 self.mode:='xml';
																			   self.file_count:=count(file2),
																				 self.ds_count:=count(ds2),
																				 
																				 self:=l;
		
		end;
		
		result2_stats_project:= project(result2_stats,func1(left));

		
	compare_layout := RECORD
            		  string file_version;
            			string mode;
                  string field_name;
                  string distribution_type;
            			decimal20_4 p_file_count;
                  decimal20_4 c_file_count;
                  decimal20_4 file_count_diff;
									decimal20_4 matched_file_count;
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
            			decimal20_4 PSI;
            								
                        END;	

		  did_results := DATASET([{'IT60_paro','xml','did','<DID not equal>',count(file1),count(file2),count(file2)-count(file1),pfc,'<DID not equal>',pf,cf,'','','','',pd,abd,ppd,0}
	                    ], compare_layout);
   	
											
				
   
		
		FileNameNewLogical:='~ScoringQA::bss::stats::'+ name + current_dt;
		
		FileNameNewLogical1:='~ScoringQA::bss::averages::'+ name + current_dt;
		
		FileNameNewLogical2:='~ScoringQA::bss::dids::'+ name + current_dt;
		
	SaveNewFile := output(result2_stats_project,,FileNameNewLogical,CSV(HEADING(single), QUOTE('"')),overwrite,EXPIRE(10));
	 
	 	 
	 SaveNewFile1 :=output(result4_stats_project,,FileNameNewLogical1,CSV(HEADING(single), QUOTE('"')),overwrite,EXPIRE(10));
	 
	 SaveNewFile2 :=output(did_results,,FileNameNewLogical2,CSV(HEADING(single), QUOTE('"')),overwrite,EXPIRE(10));
	 
	 res:=FileServices.AddSuperFile( '~ScoringQA::bss::stats::' + current_dt , FileNameNewLogical)	;					
		
	 res1:=FileServices.AddSuperFile( '~ScoringQA::bss::averages::' +current_dt , FileNameNewLogical1)	;		
	 
	 res2:=FileServices.AddSuperFile( '~ScoringQA::bss::dids::' +current_dt , FileNameNewLogical2)	;	
						
	 
seq:=sequential(SaveNewFile,SaveNewFile1,SaveNewFile2,res,res1,res2);

return seq;

endmacro;