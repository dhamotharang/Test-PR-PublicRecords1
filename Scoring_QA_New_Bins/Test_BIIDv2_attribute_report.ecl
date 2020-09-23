EXPORT Test_BIIDv2_attribute_report(route,current_dt,previous_dt) := functionmacro

 file1_2:= distribute(dataset(route + scoring_project_pip.Output_Sample_Names.BIIDv2_Scores_XML_Generic_outfile + previous_dt,Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_BusinessInstantIdv2_Layout, thor),(integer)acctno);

 file2_2:= distribute(dataset(route + scoring_project_pip.Output_Sample_Names.BIIDv2_Scores_XML_Generic_outfile + current_dt, Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_BusinessInstantIdv2_Layout, thor),(integer)acctno);

file1 := file1_2(errorcode='');
file2 := file2_2(errorcode='');

aa1:=join(file1,file2,left.acctno=right.acctno,inner);

aa:=aa1(acctno<>'');

DS1:=join(file1,aa,left.acctno=right.acctno,inner);

DS2:=join(file2,aa,left.acctno=right.acctno,inner);

				 Missing_values:= JOIN(DS2,DS1,LEFT.acctno=RIGHT.acctno and LEFT.seq=RIGHT.seq,local);
					
					pfc := count(ds1);
   cfc := count(ds2);
   fcd :=cfc-pfc;
	 
pf:=count(Missing_values);
cf:=count(Missing_values);

pd:=if(pfc!= 0 and cfc=0,1,cf/cfc);
abd:=abs(pd);
ppd:=if(pfc!= 0 and cfc=0,1,(cf/cfc)*100);
	 
//*******	 
// Scoring_QA_New_Bins.Test_BIIDV2_new_bins.range_function_1(DS2,'bvi',range1);
//*******
// Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_2(DS2,'addrchangedistance',range2);

// Scoring_QA_New_Bins.Test_FPv201_new_bins.range_function_3(DS2,'addrchangeecontrajectoryindex',range3);

      	// ran:= range1+range2+range3+range4+range5;
      	
// Scoring_QA_New_Bins.Test_FPv201_new_bins.Distinct_function(DS2,'inputphonetype',dist5);

// Scoring_QA_New_Bins.Test_FPv201_new_bins.Distinct_function(DS2,'prevaddrdwelltype',dist6);

// Scoring_QA_New_Bins.Test_FPv201_new_bins.Distinct_function(DS2,'prevaddrstatus',dist7);

Scoring_QA_New_Bins.Test_BIIDv2_new_bins.Distinct_function(DS2,'bvi',dist1);
Scoring_QA_New_Bins.Test_BIIDV2_new_bins.Distinct_function(DS2,'rep1_cvi',dist2);
Scoring_QA_New_Bins.Test_BIIDV2_new_bins.Distinct_function(DS2,'bus2exec_index_rep1',dist3);

Scoring_QA_New_Bins.Test_BIIDV2_new_bins.Distinct_function(DS2,'bus_ri_1',dist4);
Scoring_QA_New_Bins.Test_BIIDV2_new_bins.Distinct_function(DS2,'bus_ri_2',dist5);
Scoring_QA_New_Bins.Test_BIIDV2_new_bins.Distinct_function(DS2,'bus_ri_3',dist6);

Scoring_QA_New_Bins.Test_BIIDV2_new_bins.Distinct_function(DS2,'rep1_nas_summary',dist7);
Scoring_QA_New_Bins.Test_BIIDV2_new_bins.Distinct_function(DS2,'rep1_nap_summary',dist8);
Scoring_QA_New_Bins.Test_BIIDV2_new_bins.Distinct_function(DS2,'rep1_hri_1',dist9);
Scoring_QA_New_Bins.Test_BIIDV2_new_bins.Distinct_function(DS2,'rep1_hri_2',dist10);
Scoring_QA_New_Bins.Test_BIIDV2_new_bins.Distinct_function(DS2,'rep1_hri_3',dist11);

	// Scoring_QA_New_Bins.Test_FPv201_new_bins.Distinct_function2(DS2,'addrchangeecontrajectory',dist1);

Scoring_QA_New_Bins.Test_BIIDV2_new_bins.Distinct_function2(DS2,'bus_company_name',dist12);
Scoring_QA_New_Bins.Test_BIIDV2_new_bins.Distinct_function2(DS2,'bus_addr1',dist13);
Scoring_QA_New_Bins.Test_BIIDV2_new_bins.Distinct_function2(DS2,'bus_z5',dist14);
Scoring_QA_New_Bins.Test_BIIDV2_new_bins.Distinct_function2(DS2,'bus_city_name',dist15);
Scoring_QA_New_Bins.Test_BIIDV2_new_bins.Distinct_function2(DS2,'bus_st',dist16);

Scoring_QA_New_Bins.Test_BIIDV2_new_bins.Distinct_function2(DS2,'rep1_firstname',dist17);
Scoring_QA_New_Bins.Test_BIIDV2_new_bins.Distinct_function2(DS2,'rep1_lastname',dist18);
Scoring_QA_New_Bins.Test_BIIDV2_new_bins.Distinct_function2(DS2,'rep1_addr1',dist19);
Scoring_QA_New_Bins.Test_BIIDV2_new_bins.Distinct_function2(DS2,'rep1_st',dist20);
Scoring_QA_New_Bins.Test_BIIDV2_new_bins.Distinct_function2(DS2,'rep1_z5',dist21);
Scoring_QA_New_Bins.Test_BIIDV2_new_bins.Distinct_function2(DS2,'rep1_ssn',dist22);
Scoring_QA_New_Bins.Test_BIIDV2_new_bins.Distinct_function2(DS2,'rep1_phone10',dist23);

				dis := dist1+dist2+dist3+dist4+dist5+dist6+dist7+dist8+dist9+dist10+dist11+dist12+dist13+dist14+dist15+dist16+dist17+dist18+dist19+dist20+dist21+dist22+dist23;
				
							 Scoring_QA.range_function_module.Distinct_function7(DS2,'acctno',did1);
	 
	 did_stats:=did1;
			
			result2_stats:= dis+ did_stats ; //ran + 
        
			  Scoring_QA_New_Bins.Test_BIIDV2_new_bins.Average_func(DS2,'bvi',ave1);
				
Scoring_QA_New_Bins.Test_BIIDV2_new_bins.Average_func(DS2,'rep1_cvi',ave2);

Scoring_QA_New_Bins.Test_BIIDV2_new_bins.Average_func(DS2,'bus2exec_index_rep1',ave3);

Scoring_QA_New_Bins.Test_BIIDV2_new_bins.Average_func(DS2,'rep1_nas_summary',ave4);

Scoring_QA_New_Bins.Test_BIIDV2_new_bins.Average_func(DS2,'rep1_nap_summary',ave5);

// Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'addrchangeecontrajectoryindex',ave4);

// Scoring_QA_New_Bins.Test_FPv201_new_bins.Average_func(DS2,'addrchangeincomediff',ave5);

      	
      	   avearage:= ave1+ave2+ave3+ave4+ave5;
	
   result4_stats:=avearage   ;

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
                                         self.file_version:='BusinessInstantID_20';
																				 self.mode:='xml';
																				 self.file_count:=count(file2),
																				 self.ds_count:=count(ds2),
																				 self:=l;
		end;
		
		result4_stats_project:= project(result4_stats,func(left));		

compare_layout_stats func1(result2_stats l):=transform
                                         self.file_version:='BusinessInstantID_20';
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

		  did_results := DATASET([{'BusinessInstantID_20','xml','did','<DID not equal>',count(file1),count(file2),count(file2)-count(file1),pfc,'<DID not equal>',pf,cf,'','','','',pd,abd,ppd,0}
	                    ], compare_layout);
		
		FileNameNewLogical:='~ScoringQA::bss::stats::'+ scoring_project_pip.Output_Sample_Names.BIIDv2_Scores_XML_Generic_outfile[2..] + current_dt;
		
		FileNameNewLogical1:='~ScoringQA::bss::averages::'+ scoring_project_pip.Output_Sample_Names.BIIDv2_Scores_XML_Generic_outfile[2..] + current_dt;
		
		FileNameNewLogical2:='~ScoringQA::bss::dids::'+ scoring_project_pip.Output_Sample_Names.BIIDv2_Scores_XML_Generic_outfile[2..] + current_dt;
		
	 SaveNewFile := output(result2_stats_project,,FileNameNewLogical,CSV(HEADING(single), QUOTE('"')),overwrite,EXPIRE(10));
	 	 
	 SaveNewFile1 :=output(result4_stats_project,,FileNameNewLogical1,CSV(HEADING(single), QUOTE('"')),overwrite,EXPIRE(10));
	 
	 SaveNewFile2 :=output(did_results,,FileNameNewLogical2,CSV(HEADING(single), QUOTE('"')),overwrite,EXPIRE(10));
	 
	 res:=FileServices.AddSuperFile( '~ScoringQA::bss::stats::' + current_dt , FileNameNewLogical)	;					
		
	 res1:=FileServices.AddSuperFile( '~ScoringQA::bss::averages::' +current_dt , FileNameNewLogical1)	;		
	 
	 res2:=FileServices.AddSuperFile( '~ScoringQA::bss::dids::' +current_dt , FileNameNewLogical2)	;	
						
seq:=sequential(SaveNewFile,SaveNewFile1,SaveNewFile2,res,res1,res2); //SaveNewFile2

return seq;

endmacro;
