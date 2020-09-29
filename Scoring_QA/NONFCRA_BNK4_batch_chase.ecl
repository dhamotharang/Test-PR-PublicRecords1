EXPORT NONFCRA_BNK4_batch_chase(route,current_dt,previous_dt) := functionmacro



 file1_2:= distribute(dataset(route + scoring_project_pip.Output_Sample_Names.BC10_Scores_BATCH_Chase_BNK4_outfile + previous_dt, Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_Chase_BNK4_Global_Layout,


thor),(integer)acctno);
 
 file2_2:= distribute(dataset(route + scoring_project_pip.Output_Sample_Names.BC10_Scores_BATCH_Chase_BNK4_outfile + current_dt, Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_Chase_BNK4_Global_Layout,


thor),(integer)acctno);

	   file1 := file1_2(errorcode='');
file2 := file2_2(errorcode='');

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


								 Scoring_QA.Range_function_module.Range_Function_25(DS2,'hhriskphoneflag',ran10_1);
								 
								 
								 ran_10:=ran10_1;
								 
								 	 Scoring_QA.Range_function_module.Range_Function_206(DS2,'phonedissflag',ran11_1);
								 
								 
								 ran_11:=ran11_1;
								 
								 	 Scoring_QA.Range_function_module.Range_Function_205(DS2,'ecovariables',ran12_1);
								 
								 
								 ran_12:=ran12_1;
								 
								  Scoring_QA.Range_function_module.Range_Function_204(DS2,'socsverlevel',ran14_1);
								 
								 
								 ran_14:=ran14_1;					 
    
				
					Scoring_QA.Range_function_module.Distinct_function(DS2,'phonezipflag',dis1);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'zipclassflag',dis2);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'bansflag',dis3);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'addrvalflag',dis4);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'dwelltypeflag',dis5);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'errorcode',dis6);					
					Scoring_QA.Range_function_module.range_function_25(DS2,'hphonetypeflag',dis7);
					Scoring_QA.Range_function_module.Range_Function_208(DS2,'hphonesrvc',dis8);
					Scoring_QA.Range_function_module.Range_Function_212(DS2,'wphonetypeflag',dis9);
					Scoring_QA.Range_function_module.Range_Function_208(DS2,'wphonesrvc',dis10);
					
				Scoring_QA.Range_function_module.Range_Function_202(DS2,'numelever',dis11);
				Scoring_QA.Range_function_module.Range_Function_203(DS2,'numsource',dis12);
				Scoring_QA.Range_function_module.Distinct_function(DS2,'numcmpyelever',dis13);
		    Scoring_QA.Range_function_module.Range_Function_209(DS2,'numcmpysource',dis14);
			 	Scoring_QA.Range_function_module.Range_Function_211(DS2,'tcifull',dis15);
				Scoring_QA.Range_function_module.Range_Function_210(DS2,'tcilast',dis16);
		  	Scoring_QA.Range_function_module.Range_Function_210(DS2,'tciaddr',dis17);
				Scoring_QA.Range_function_module.Range_Function_200(DS2,'firstscore',dis18);
				Scoring_QA.Range_function_module.Range_Function_200(DS2,'lastscore',dis19);
				Scoring_QA.Range_function_module.Range_Function_200(DS2,'addrscore',dis20);
		    Scoring_QA.Range_function_module.Range_Function_200(DS2,'phonescore',dis21);
			 	Scoring_QA.Range_function_module.Range_Function_200(DS2,'socscore',dis22);
				Scoring_QA.Range_function_module.Range_Function_200(DS2,'dobscore',dis23);
		  	Scoring_QA.Range_function_module.Range_Function_200(DS2,'cmpyscore2',dis24);
				Scoring_QA.Range_function_module.Range_Function_200(DS2,'cmpyaddrscore',dis25);
		  	Scoring_QA.Range_function_module.Range_Function_200(DS2,'cmpyphonescore',dis26);
				Scoring_QA.Range_function_module.Range_Function_206(DS2,'fincount',dis27);
				Scoring_QA.Range_function_module.Range_Function_207(DS2,'firstcount',dis28);
				Scoring_QA.Range_function_module.Range_Function_206(DS2,'phonecount',dis29);
				Scoring_QA.Range_function_module.Distinct_function(DS2,'socsdob',dis30);
				
					Scoring_QA.Range_function_module.Distinct_function(DS2,'fnamepop',dis31);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'lnamepop',dis32);
				  Scoring_QA.Range_function_module.Distinct_function(DS2,'addrpop',dis33);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'ssnlength',dis34);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'dobpop',dis35);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'emailpop',dis36);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'ipaddrpop',dis37);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'hphnpop',dis38);
					
					dis:= dis1  + dis2  + dis3  + dis4  + dis5  + dis6  + dis7  + dis8  + dis9  + dis10 +
				        dis11 + dis12 + dis13 + dis14 + dis15 + dis16 + dis17 + dis18 + dis19 + dis20 +
						    dis21 + dis22 + dis23 + dis24 + dis25 + dis26 + dis27 + dis28 + dis29 + dis30 +
								dis31 + dis32 + dis33 + dis34 + dis35 + dis36 + dis37 + dis38;
		      	
							
				
			result2_stats:= dis   + ran_10 + ran_11 + ran_12 + ran_14;
   				
     
					
				Scoring_QA.Range_function_module.Average_func(DS2,'numelever',ave1);
				Scoring_QA.Range_function_module.Average_func(DS2,'numsource',ave2);
				Scoring_QA.Range_function_module.Average_func(DS2,'numcmpyelever',ave3);
		    Scoring_QA.Range_function_module.Average_func(DS2,'numcmpysource',ave4);
			 	Scoring_QA.Range_function_module.Average_func(DS2,'tcifull',ave5);
				Scoring_QA.Range_function_module.Average_func(DS2,'tcilast',ave6);
		  	Scoring_QA.Range_function_module.Average_func(DS2,'tciaddr',ave7);			
				Scoring_QA.Range_function_module.Average_func(DS2,'firstscore',ave8);
				Scoring_QA.Range_function_module.Average_func(DS2,'lastscore',ave9);
				Scoring_QA.Range_function_module.Average_func(DS2,'addrscore',ave10);
		    Scoring_QA.Range_function_module.Average_func(DS2,'phonescore',ave11);
			 	Scoring_QA.Range_function_module.Average_func(DS2,'socscore',ave12);
				Scoring_QA.Range_function_module.Average_func(DS2,'dobscore',ave13);
		  	Scoring_QA.Range_function_module.Average_func(DS2,'cmpyscore2',ave14);
				Scoring_QA.Range_function_module.Average_Function_1(DS2,'cmpyaddrscore',ave15);
		  	Scoring_QA.Range_function_module.Average_func(DS2,'cmpyphonescore',ave16);
				
				Scoring_QA.Range_function_module.Average_func(DS2,'firstcount',ave17);
      	Scoring_QA.Range_function_module.Average_func(DS2,'lastcount',ave18);
				Scoring_QA.Range_function_module.Average_func(DS2,'addrcount',ave19);
      	Scoring_QA.Range_function_module.Average_func(DS2,'phonecount',ave20);
      	Scoring_QA.Range_function_module.Average_func(DS2,'socscount',ave21);
				Scoring_QA.Range_function_module.Average_func(DS2,'dobcount',ave22);
				Scoring_QA.Range_function_module.Average_func(DS2,'cmpycount',ave23);
      	Scoring_QA.Range_function_module.Average_func(DS2,'cmpyaddrcount',ave24);
				Scoring_QA.Range_function_module.Average_func(DS2,'cmpyphonecount',ave25);
				Scoring_QA.Range_function_module.Average_func(DS2,'fincount',ave26);	
			  Scoring_QA.Range_function_module.Average_func(DS2,'socsdob',ave27);
				Scoring_QA.Range_function_module.Average_func(DS2,'hhriskphoneflag',ave29);						 
					Scoring_QA.Range_function_module.Average_func(DS2,'phonedissflag',ave30);							 
					Scoring_QA.Range_function_module.Average_func(DS2,'socsverlevel',ave31);
					Scoring_QA.Range_function_module.Average_func(DS2,'phonezipflag',ave32);
					Scoring_QA.Range_function_module.Average_func(DS2,'zipclassflag',ave33);
					Scoring_QA.Range_function_module.Average_func(DS2,'bansflag',ave34);
					Scoring_QA.Range_function_module.Average_func(DS2,'addrvalflag',ave35);
					Scoring_QA.Range_function_module.Average_func(DS2,'dwelltypeflag',ave36);
					Scoring_QA.Range_function_module.Average_func(DS2,'errorcode',ave37);					
					Scoring_QA.Range_function_module.Average_func(DS2,'hphonetypeflag',ave38);
					Scoring_QA.Range_function_module.Average_func(DS2,'hphonesrvc',ave39);
					Scoring_QA.Range_function_module.Average_func(DS2,'wphonetypeflag',ave40);
					Scoring_QA.Range_function_module.Average_func(DS2,'wphonesrvc',ave41);
		  	
      
   avearage:= ave1  + ave2  + ave3   + ave5  + ave6  + ave7  + ave8  + ave9  + ave10 +
				           ave11 + ave12 + ave13 + ave14 + ave15 + ave16 + ave17 + ave18 + ave19 + ave20 +
						       ave21 + ave22 + ave23 + ave24 + ave25 + ave26 + ave27  + ave29 + ave30 +
				           ave31 + ave32 + ave33 + ave34 + ave35 + ave36 + ave37 + ave38 + ave39 + ave40 +
				           ave41;
			
	
	

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
                                         self.file_version:='BNK4_chase';
																				 self.mode:='batch';
																				 self.file_count:=count(file2),
																				 self.ds_count:=count(ds2),
																				 self:=l;
		
		end;
		
		result4_stats_project:= project(result4_stats,func(left));		
     	

compare_layout_stats func1(result2_stats l):=transform
                                         self.file_version:='BNK4_chase';
																				 self.mode:='batch';
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

											
				  did_results := DATASET([{'nonfcra_bnk4_chase','batch','did','<DID not equal>',count(file1),count(file2),count(file2)-count(file1),pfc,'<DID not equal>',pf,cf,'','','','',pd,abd,ppd,0}
	                    ], compare_layout);
   	
							
   
		
		FileNameNewLogical:='~ScoringQA::bss::stats::'+ scoring_project_pip.Output_Sample_Names.BC10_Scores_BATCH_Chase_BNK4_outfile[2..] + current_dt;
		
		FileNameNewLogical1:='~ScoringQA::bss::averages::'+ scoring_project_pip.Output_Sample_Names.BC10_Scores_BATCH_Chase_BNK4_outfile[2..] + current_dt;
		
		FileNameNewLogical2:='~ScoringQA::bss::dids::'+ scoring_project_pip.Output_Sample_Names.BC10_Scores_BATCH_Chase_BNK4_outfile[2..] + current_dt;
		
	SaveNewFile := output(result2_stats_project,,FileNameNewLogical,CSV(HEADING(single), QUOTE('"')),overwrite,EXPIRE(10));
	 
	 	 
	 SaveNewFile1 :=output(result4_stats_project,,FileNameNewLogical1,CSV(HEADING(single), QUOTE('"')),overwrite,EXPIRE(10));
	 
	 SaveNewFile2 :=output(did_results,,FileNameNewLogical2,CSV(HEADING(single), QUOTE('"')),overwrite,EXPIRE(10));
	 
	 res:=FileServices.AddSuperFile( '~ScoringQA::bss::stats::' + current_dt , FileNameNewLogical)	;					
		
	 res1:=FileServices.AddSuperFile( '~ScoringQA::bss::averages::' +current_dt , FileNameNewLogical1)	;		
	 
	 res2:=FileServices.AddSuperFile( '~ScoringQA::bss::dids::' +current_dt , FileNameNewLogical2)	;	
						
	 
seq:=sequential(SaveNewFile,SaveNewFile1,SaveNewFile2,res,res1,res2);

return seq;

endmacro;