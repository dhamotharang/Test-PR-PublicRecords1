EXPORT SOCIO_Attribute_Report(route,current_dt,previous_dt) := functionmacro

 file1_2:= dataset(route + scoring_project_pip.Output_Sample_Names.SOCIO_Attributes_V5_outfile + previous_dt,Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_SOCIO_Monitoring_v5_LAYOUT, thor);

 file2_2:= dataset(route + scoring_project_pip.Output_Sample_Names.SOCIO_Attributes_V5_outfile + current_dt, Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_SOCIO_Monitoring_v5_LAYOUT, thor);

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
    
  	
		
//SOCIO Range Functions
Scoring_QA_New_Bins.SOCIO_New_Bins.range_function_socio(DS2,'SeRs_Score',range1);
Scoring_QA_New_Bins.SOCIO_New_Bins.range_function_socio(DS2,'SeMA_Score',range2);
Scoring_QA_New_Bins.SOCIO_New_Bins.range_function_socio(DS2,'SeMo_Score',range3);
Scoring_QA_New_Bins.SOCIO_New_Bins.range_function_socio_2(DS2,'Score',range4);
Scoring_QA_New_Bins.SOCIO_New_Bins.range_function_socio_3(DS2,'age_in_years',range5);
Scoring_QA_New_Bins.SOCIO_New_Bins.range_function_socio_4(DS2,'readmissionscore_category',range6);
Scoring_QA_New_Bins.SOCIO_New_Bins.range_function_socio_4(DS2,'medicationadherencescore_category',range7);
Scoring_QA_New_Bins.SOCIO_New_Bins.range_function_socio_4(DS2,'motivationscore_category',range8);


ran:= range1+range2+range3+range4+range5+range6+range7+range8;


//SOCIO Distinct Functions
//Scoring_QA_New_Bins.SOCIO_New_Bins.Distinct_function(DS2,'SeRs_Score',dist1);
//Scoring_QA_New_Bins.SOCIO_New_Bins.Distinct_function(DS2,'SeMA_Score',dist2);
//Scoring_QA_New_Bins.SOCIO_New_Bins.Distinct_function(DS2,'SeMo_Score',dist3);
//Scoring_QA_New_Bins.SOCIO_New_Bins.Distinct_function(DS2,'Score',dist4);


	//			dis := dist1+dist2+dist3+dist4;
				
							 Scoring_QA.range_function_module.Distinct_function7(DS2,'acctno',did1);
	 
	 did_stats:=did1;
			
			//result2_stats:= dis+ did_stats ; //ran + 
			result2_stats:= ran + did_stats ; //ran + 
        


Scoring_QA_New_Bins.SOCIO_New_Bins.Average_func(DS2,'SeRs_Score',ave1);
Scoring_QA_New_Bins.SOCIO_New_Bins.Average_func(DS2,'SeMA_Score',ave2);
Scoring_QA_New_Bins.SOCIO_New_Bins.Average_func(DS2,'SeMo_Score',ave3);
Scoring_QA_New_Bins.SOCIO_New_Bins.Average_func(DS2,'Score',ave4);
Scoring_QA_New_Bins.SOCIO_New_Bins.Average_func(DS2,'age_in_years',ave5);
Scoring_QA_New_Bins.SOCIO_New_Bins.Average_func(DS2,'readmissionscore_category',ave6);
Scoring_QA_New_Bins.SOCIO_New_Bins.Average_func(DS2,'medicationadherencescore_category',ave7);
Scoring_QA_New_Bins.SOCIO_New_Bins.Average_func(DS2,'motivationscore_category',ave8);

      	
      	   avearage:= ave1+ave2+ave3+ave4+ave5+ave6+ave7+ave8;
					
	
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
                                         self.file_version:='SOCIO_v5';
																				 self.mode:='Batch';
																				 self.file_count:=count(file2),
																				 self.ds_count:=count(ds2),
																				 self:=l;
		end;
		
		result4_stats_project:= project(result4_stats,func(left));		

compare_layout_stats func1(result2_stats l):=transform
                                         self.file_version:='SOCIO_v5';
																				 self.mode:='Batch';
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

		  did_results := DATASET([{'SOCIO_v5','Batch','did','<DID not equal>',count(file1),count(file2),count(file2)-count(file1),pfc,'<DID not equal>',pf,cf,'','','','',pd,abd,ppd,0}
	                    ], compare_layout);
		
		FileNameNewLogical:='~ScoringQA::bss::stats1::'+ scoring_project_pip.Output_Sample_Names.SOCIO_Attributes_V5_outfile[2..] + current_dt;
		
		FileNameNewLogical1:='~ScoringQA::bss::averages1::'+ scoring_project_pip.Output_Sample_Names.SOCIO_Attributes_V5_outfile[2..] + current_dt;
		
		FileNameNewLogical2:='~ScoringQA::bss::dids1::'+ scoring_project_pip.Output_Sample_Names.SOCIO_Attributes_V5_outfile[2..] + current_dt;
		
  	SaveNewFile := output(result2_stats_project,,FileNameNewLogical,CSV(HEADING(single), QUOTE('"')),overwrite,EXPIRE(10));
	 	 
	 SaveNewFile1 :=output(result4_stats_project,,FileNameNewLogical1,CSV(HEADING(single), QUOTE('"')),overwrite,EXPIRE(10));
	 
	 SaveNewFile2 :=output(did_results,,FileNameNewLogical2,CSV(HEADING(single), QUOTE('"')),overwrite,EXPIRE(10));
	 
	 res:=FileServices.AddSuperFile( '~ScoringQA::bss::stats1::' + current_dt , FileNameNewLogical)	;					
		
	 res1:=FileServices.AddSuperFile( '~ScoringQA::bss::averages1::' +current_dt , FileNameNewLogical1)	;		
	 
	 res2:=FileServices.AddSuperFile( '~ScoringQA::bss::dids1::' +current_dt , FileNameNewLogical2)	;	
						
seq:=sequential(SaveNewFile,SaveNewFile1,SaveNewFile2,res,res1,res2); //SaveNewFile2

return seq;

endmacro;
