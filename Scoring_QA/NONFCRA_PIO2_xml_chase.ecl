EXPORT NONFCRA_PIO2_xml_chase(route,current_dt,previous_dt) := functionmacro



 file1_2:= distribute(dataset(route + scoring_project_pip.Output_Sample_Names.PRIO_Scores_XML_Chase_PIO2_outfile + previous_dt, Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_Chase_PIO2_Global_Layout,


thor),(integer)acctno);
 
 file2_2:= distribute(dataset(route + scoring_project_pip.Output_Sample_Names.PRIO_Scores_XML_Chase_PIO2_outfile + current_dt, Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_Chase_PIO2_Global_Layout,


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
ppd:=if(pfc!= 0 and cfc=0,1,(cf/cfc)*100)	;
    
				
					Scoring_QA.Range_function_module.range_function_25(DS2,'hriskphoneflag',dis1);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'phonevalflag',dis2);
					Scoring_QA.Range_function_module.range_function_76(DS2,'phonezipflag',dis3);
					Scoring_QA.Range_function_module.range_function_76(DS2,'hriskaddrflag',dis4);
					Scoring_QA.Range_function_module.range_function_76(DS2,'decsflag',dis5);
					Scoring_QA.Range_function_module.range_function_76(DS2,'socsdobflag',dis6);					
					Scoring_QA.Range_function_module.range_function_76(DS2,'socsvalflag',dis7);
					Scoring_QA.Range_function_module.Distinct_function5(DS2,'drlcvalflag',dis8);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'addrvalflag',dis9);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'dwelltypeflag',dis10);					
				Scoring_QA.Range_function_module.Distinct_function(DS2,'idtheftflag',dis11);
				Scoring_QA.Range_function_module.Distinct_function(DS2,'aptscanflag',dis12);
				Scoring_QA.Range_function_module.Distinct_function5(DS2,'addrhistoryflag',dis13);
		    Scoring_QA.Range_function_module.Distinct_function(DS2,'firstcount',dis14);
			 	Scoring_QA.Range_function_module.Distinct_function(DS2,'lastcount',dis15);				
				Scoring_QA.Range_function_module.Distinct_function(DS2,'addrcount',dis16);
		  	Scoring_QA.Range_function_module.Distinct_function(DS2,'hphonecount',dis17);
				Scoring_QA.Range_function_module.range_function_76(DS2,'wphonecount',dis18);
				Scoring_QA.Range_function_module.Distinct_function(DS2,'socscount',dis19);
				Scoring_QA.Range_function_module.Range_Function_204(DS2,'socsverlevel',dis20);
		    Scoring_QA.Range_function_module.Distinct_function(DS2,'dobcount',dis21);				
			 	Scoring_QA.Range_function_module.Range_Function_202(DS2,'numelever',dis22);
				Scoring_QA.Range_function_module.Range_Function_203(DS2,'numsource',dis23);				
		  	Scoring_QA.Range_function_module.Range_Function_200(DS2,'firstscore',dis24);
				Scoring_QA.Range_function_module.Range_Function_200(DS2,'lastscore',dis25);
		  	Scoring_QA.Range_function_module.Range_Function_200(DS2,'addrscore',dis26);				
			  	Scoring_QA.Range_function_module.Range_Function_200(DS2,'hphonescore',dis27);
					Scoring_QA.Range_function_module.Range_Function_200(DS2,'socsscore',dis28);
					Scoring_QA.Range_function_module.Range_Function_200(DS2,'dobscore',dis29);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'socsmiskeyflag',dis30);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'hphonemiskeyflag',dis31);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'addrmiskeyflag',dis32);
					Scoring_QA.Range_function_module.range_function_76(DS2,'disthphoneaddr',dis33);
					Scoring_QA.Range_function_module.range_function_76(DS2,'disthphonewphone',dis34);
					Scoring_QA.Range_function_module.range_function_76(DS2,'distwphoneaddr',dis35);
					Scoring_QA.Range_function_module.Range_Function_201(DS2,'estincome',dis36);
					Scoring_QA.Range_function_module.range_function_25(DS2,'numfraud',dis37);
					
	      	Scoring_QA.Range_function_module.Distinct_function(DS2,'fnamepop',dis38);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'lnamepop',dis39);
				  Scoring_QA.Range_function_module.Distinct_function(DS2,'addrpop',dis40);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'ssnlength',dis41);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'dobpop',dis42);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'emailpop',dis43);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'ipaddrpop',dis44);
					Scoring_QA.Range_function_module.Distinct_function(DS2,'hphnpop',dis45);
					
					dis:= dis1  + dis2  + dis3  + dis4  + dis5  + dis6  + dis7  + dis8  + dis9  + dis10 +
				        dis11 + dis12 + dis13 + dis14 + dis15 + dis16 + dis17 + dis18 + dis19 + dis20 +
						    dis21 + dis22 + dis23 + dis24 + dis25 + dis26 + dis27 + dis28 + dis29 + dis30 +
				        dis31 + dis32 + dis33 + dis34 + dis35 + dis36 + dis37 + dis38 + dis39 + dis40 +
				        dis41 + dis42 + dis43 + dis44 + dis45; 
		      	
							
				
			result2_stats:= dis ;
   				
       
					
				Scoring_QA.Range_function_module.Average_func(DS2,'hriskphoneflag',ave1);
					Scoring_QA.Range_function_module.Average_func(DS2,'phonevalflag',ave2);
					Scoring_QA.Range_function_module.Average_func(DS2,'phonezipflag',ave3);
					Scoring_QA.Range_function_module.Average_func(DS2,'hriskaddrflag',ave4);
					Scoring_QA.Range_function_module.Average_func(DS2,'decsflag',ave5);
					Scoring_QA.Range_function_module.Average_func(DS2,'socsdobflag',ave6);					
					Scoring_QA.Range_function_module.Average_func(DS2,'socsvalflag',ave7);
					Scoring_QA.Range_function_module.Average_func(DS2,'drlcvalflag',ave8);
					Scoring_QA.Range_function_module.Average_func(DS2,'addrvalflag',ave9);
					Scoring_QA.Range_function_module.Average_func(DS2,'dwelltypeflag',ave10);					
				Scoring_QA.Range_function_module.Average_func(DS2,'idtheftflag',ave11);
				Scoring_QA.Range_function_module.Average_func(DS2,'aptscanflag',ave12);
				Scoring_QA.Range_function_module.Average_func(DS2,'addrhistoryflag',ave13);
		    Scoring_QA.Range_function_module.Average_func(DS2,'firstcount',ave14);
			 	Scoring_QA.Range_function_module.Average_func(DS2,'lastcount',ave15);				
				Scoring_QA.Range_function_module.Average_func(DS2,'addrcount',ave16);
		  	Scoring_QA.Range_function_module.Average_func(DS2,'hphonecount',ave17);
				Scoring_QA.Range_function_module.Average_func(DS2,'wphonecount',ave18);
				Scoring_QA.Range_function_module.Average_func(DS2,'socscount',ave19);
				Scoring_QA.Range_function_module.Average_func(DS2,'socsverlevel',ave20);
		    Scoring_QA.Range_function_module.Average_func(DS2,'dobcount',ave21);				
			 	Scoring_QA.Range_function_module.Average_func(DS2,'numelever',ave22);
				Scoring_QA.Range_function_module.Average_func(DS2,'numsource',ave23);				
		  	Scoring_QA.Range_function_module.Average_func(DS2,'firstscore',ave24);
				Scoring_QA.Range_function_module.Average_func(DS2,'lastscore',ave25);
		  	Scoring_QA.Range_function_module.Average_func(DS2,'addrscore',ave26);				
			  	Scoring_QA.Range_function_module.Average_func(DS2,'hphonescore',ave27);
					Scoring_QA.Range_function_module.Average_func(DS2,'socsscore',ave28);
					Scoring_QA.Range_function_module.Average_func(DS2,'dobscore',ave29);
					Scoring_QA.Range_function_module.Average_func(DS2,'socsmiskeyflag',ave30);
					Scoring_QA.Range_function_module.Average_func(DS2,'hphonemiskeyflag',ave31);
					Scoring_QA.Range_function_module.Average_func(DS2,'addrmiskeyflag',ave32);
					Scoring_QA.Range_function_module.Average_func(DS2,'disthphoneaddr',ave33);
					Scoring_QA.Range_function_module.Average_func(DS2,'disthphonewphone',ave34);
					Scoring_QA.Range_function_module.Average_func(DS2,'distwphoneaddr',ave35);
					Scoring_QA.Range_function_module.Average_func(DS2,'estincome',ave36);
					Scoring_QA.Range_function_module.Average_func(DS2,'numfraud',ave37);
		  	
      
    avearage:= ave1  + ave2  + ave3  + ave5  + ave6  + ave7  + ave8  + ave9  + ave10 +
				        ave11 + ave12 + ave13 + ave14 + ave15 + ave16 + ave17 + ave18 + ave19 + ave20 +
						    ave21 + ave22 + ave23 + ave24 + ave25 + ave26 + ave27 + ave28 + ave29 + ave30 +
				        ave31 + ave32 + ave33 + ave34 + ave35 + ave36 + ave37;
			
	
	
	
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
                                         self.file_version:='PIO2_chase';
																				 self.mode:='xml';
																				 self.file_count:=count(file2),
																				 self.ds_count:=count(ds2),
																				 self:=l;
		
		end;
		
		result4_stats_project:= project(result4_stats,func(left));		
     	

compare_layout_stats func1(result2_stats l):=transform
                                         self.file_version:='PIO2_chase';
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


		  did_results := DATASET([{'nonfcra_pio2_chase','xml','did','<DID not equal>',count(file1),count(file2),count(file2)-count(file1),pfc,'<DID not equal>',pf,cf,'','','','',pd,abd,ppd,0}
	                    ], compare_layout);
   	
				
   
		
		FileNameNewLogical:='~ScoringQA::bss::stats::'+ scoring_project_pip.Output_Sample_Names.PRIO_Scores_XML_Chase_PIO2_outfile[2..] + current_dt;
		
		FileNameNewLogical1:='~ScoringQA::bss::averages::'+ scoring_project_pip.Output_Sample_Names.PRIO_Scores_XML_Chase_PIO2_outfile[2..] + current_dt;
		
		FileNameNewLogical2:='~ScoringQA::bss::dids::'+ scoring_project_pip.Output_Sample_Names.PRIO_Scores_XML_Chase_PIO2_outfile[2..] + current_dt;
		
	SaveNewFile := output(result2_stats_project,,FileNameNewLogical,CSV(HEADING(single), QUOTE('"')),overwrite,EXPIRE(10));
	 
	 	 
	 SaveNewFile1 :=output(result4_stats_project,,FileNameNewLogical1,CSV(HEADING(single), QUOTE('"')),overwrite,EXPIRE(10));
	 
	 SaveNewFile2 :=output(did_results,,FileNameNewLogical2,CSV(HEADING(single), QUOTE('"')),overwrite,EXPIRE(10));
	 
	 res:=FileServices.AddSuperFile( '~ScoringQA::bss::stats::' + current_dt , FileNameNewLogical)	;					
		
	 res1:=FileServices.AddSuperFile( '~ScoringQA::bss::averages::' +current_dt , FileNameNewLogical1)	;		
	 
	 res2:=FileServices.AddSuperFile( '~ScoringQA::bss::dids::' +current_dt , FileNameNewLogical2)	;	
						
	 
seq:=sequential(SaveNewFile,SaveNewFile1,SaveNewFile2,res,res1,res2);

return seq;

endmacro;