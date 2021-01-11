


import RiskView_Attributes_Reports;

import Scoring_Project_Macros,scoring_project_pip,Scoring_Project_DailyTracking, scoring_QA;

import ut,std;
import RiskView_Attributes_Reports;

	a:= ut.GetDate;
	
fn_LastTwoMonths(string10 date_inp,integer offset) := function
res  := GLOBAL(ut.DateFrom_DaysSince1900(ut.DaysSince1900(date_inp[1..4], date_inp[5..6], date_inp[7..8]) - offset));
return res[1..8];
end;

b:=fn_LastTwoMonths(a,1);
	a1:= a +'_1';
	// a1:= '20180601_1';


b1:=b +'_1';
// b1:='20180531_1';


// ip:='~';
ip:='~';
						
	  rpt1:=Scoring_QA_New_Bins.test_rvv3_generic_xml_attr_report(ip,a1,b1); //done
	
	  rpt2:=Scoring_QA_New_Bins.test_rvv4_xml_attr_report(ip,a1,b1);//done
		
		rpt3:=Scoring_QA_New_Bins.test_rvv3_generic_batch_attr_report(ip,a1,b1);//done
				
    rpt4:=Scoring_QA_New_Bins.test_rvv4_batch_attr_report(ip,a1,b1);//done
		
		// rpt5:=Scoring_QA.NONFCRA_ITA_capitalone_batch_v3(ip,a1,b1);
		
		// rpt6:=Scoring_QA.FCRA_RiskView_batch_capitalone_attributes_v3(ip,a1,b1);
		
		// rpt7:=Scoring_QA.FCRA_RiskView_batch_capitalone_attributes_v2(ip,a1,b1);
		
		// rpt8:=Scoring_QA.FCRA_RiskView_creditacceptancecorp_batch_v2(ip,a1,b1);
		
		// rpt9:=Scoring_QA.NONFCRA_leadintegrity_batch_generic_attributes_v3(ip,n9,a1,b1);
		
		// rpt10:=Scoring_QA.NONFCRA_leadintegrity_xml_generic_attributes_v3(ip,n10,a1,b1);
		
		// rpt11:=Scoring_QA.NONFCRA_leadintegrity_batch_generic_attributes_v4(ip,a1,b1);
		
		// rpt12:=Scoring_QA.NONFCRA_leadintegrity_xml_generic_attributes_v4(ip,a1,b1);
		
		// rpt13:=Scoring_QA.NONFCRA_Fraudpoint_batch_generic_attributes_v2(ip,a1,b1);
		
		// rpt14:=Scoring_QA.NONFCRA_Fraudpoint_xml_generic_attributes_v2(ip,a1,b1);
		
		// rpt15:=Scoring_QA.NONFCRA_PIO2_batch_chase(ip,a1,b1);
		
		// rpt16:=Scoring_QA.NONFCRA_PIO2_xml_chase(ip,a1,b1);
		
		// rpt17:=Scoring_QA.NONFCRA_BNK4_batch_chase(ip,a1,b1);
		
		// rpt18:=Scoring_QA.NONFCRA_BNK4_xml_chase(ip,a1,b1);

    // rpt19:=Scoring_QA.NONFCRA_CBBL_xml_chase(ip,a1,b1);
		
		// rpt20:=Scoring_QA.NONFCRA_IT60_batch_paro(ip,a1,b1);
		
		// rpt21:=Scoring_QA.NONFCRA_IT60_xml_paro(ip,a1,b1);
		
		// rpt22:=Scoring_QA.NONFCRA_IT61_batch_paro(ip,a1,b1);
		
		// rpt23:=Scoring_QA.NONFCRA_IT61_xml_paro(ip,a1,b1);
		
rpt24:=Scoring_QA_New_Bins.test_rvv3_experian_batch_attr_report(ip,a1,b1);//done
		
		rpt25:=Scoring_QA_New_Bins.test_rvv3_experian_xml_attr_report(ip,a1,b1);//done
		// rpt26:=Scoring_QA.NONFCRA_Fraudpoint_xml_American_Express_attributes_v201(ip,a1,b1);

		rpt27:=Scoring_QA_New_Bins.test_riskview_v5_generic_attr_report(ip,a1,b1);//done
		
		rpt28:=Scoring_QA_New_Bins.test_riskview_v5_c1_attr_report(ip,a1,b1);
		
		//*********************************************************************************************************************
		rpt1_1:=Scoring_QA_New_Bins.test_rvv3_generic_xml_attr_report(ip,b1,a1);
	
	  rpt2_1:=Scoring_QA_New_Bins.test_rvv4_xml_attr_report(ip,b1,a1);
		
		rpt3_1:=Scoring_QA_New_Bins.test_rvv3_generic_batch_attr_report(ip,b1,a1);
				
    rpt4_1:=Scoring_QA_New_Bins.test_rvv4_batch_attr_report(ip,b1,a1);
		
		// rpt5_1:=Scoring_QA.NONFCRA_ITA_capitalone_batch_v3(ip,b1,a1);
		
		// rpt6_1:=Scoring_QA.FCRA_RiskView_batch_capitalone_attributes_v3(ip,b1,a1);
		
		// rpt7_1:=Scoring_QA.FCRA_RiskView_batch_capitalone_attributes_v2(ip,b1,a1);
		
		// rpt8_1:=Scoring_QA.FCRA_RiskView_creditacceptancecorp_batch_v2(ip,b1,a1);
		
		// rpt9_1:=Scoring_QA.NONFCRA_leadintegrity_batch_generic_attributes_v3(ip,n9,b1,a1);
		
		// rpt10_1:=Scoring_QA.NONFCRA_leadintegrity_xml_generic_attributes_v3(ip,n10,b1,a1);
		
		// rpt11_1:=Scoring_QA.NONFCRA_leadintegrity_batch_generic_attributes_v4(ip,b1,a1);
		
		// rpt12_1:=Scoring_QA.NONFCRA_leadintegrity_xml_generic_attributes_v4(ip,b1,a1);
		
		// rpt13_1:=Scoring_QA.NONFCRA_Fraudpoint_batch_generic_attributes_v2(ip,b1,a1);
		
		// rpt14_1:=Scoring_QA.NONFCRA_Fraudpoint_xml_generic_attributes_v2(ip,b1,a1);
			
		// rpt15_1:=Scoring_QA.NONFCRA_PIO2_batch_chase(ip,b1,a1);
		
		// rpt16_1:=Scoring_QA.NONFCRA_PIO2_xml_chase(ip,b1,a1);
		
		// rpt17_1:=Scoring_QA.NONFCRA_BNK4_batch_chase(ip,b1,a1);
		
		// rpt18_1:=Scoring_QA.NONFCRA_BNK4_xml_chase(ip,b1,a1);

    // rpt19_1:=Scoring_QA.NONFCRA_CBBL_xml_chase(ip,b1,a1);
		
		// rpt20_1:=Scoring_QA.NONFCRA_IT60_batch_paro(ip,b1,a1);
		
		// rpt21_1:=Scoring_QA.NONFCRA_IT60_xml_paro(ip,b1,a1);
		
		// rpt22_1:=Scoring_QA.NONFCRA_IT61_batch_paro(ip,b1,a1);
		
		// rpt23_1:=Scoring_QA.NONFCRA_IT61_xml_paro(ip,b1,a1);
		
		rpt24_1:=Scoring_QA_New_Bins.test_rvv3_experian_batch_attr_report(ip,b1,a1);
		
		rpt25_1:=Scoring_QA_New_Bins.test_rvv3_experian_xml_attr_report(ip,b1,a1);
		
		// rpt26_1:=Scoring_QA.NONFCRA_Fraudpoint_xml_American_Express_attributes_v201(ip,b1,a1);
			
		rpt27_1:=Scoring_QA_New_Bins.test_riskview_v5_generic_attr_report(ip,b1,a1);
		
		// rpt28_1:=Scoring_QA.FCRA_RiskView_batch_capitalone_attributes_v5(ip,b1,a1);
		rpt28_1:=Scoring_QA_New_Bins.test_riskview_v5_c1_attr_report(ip,b1,a1);

		
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
		
		


	
		
		result1_stats:=dataset('~scoringqa::bss::stats::'+ a1 ,compare_layout_stats,CSV(HEADING(single), QUOTE('"')));		
		result2_stats:=dataset('~scoringqa::bss::stats::'+ b1 ,compare_layout_stats,CSV(HEADING(single), QUOTE('"')));		
		
    result3_stats:=dataset('~scoringqa::bss::averages::'+ a1 ,compare_layout_stats,CSV(HEADING(single), QUOTE('"')));	
    result4_stats:=dataset('~scoringqa::bss::averages::'+ b1 ,compare_layout_stats,CSV(HEADING(single), QUOTE('"')));	
	
	
	
               	
      
		
		
			  compare_layout_stats_lay := RECORD
	    string file_version;
			string mode;
      // string field_name;
      // string distribution_type;		
      // STRING50 attribute_value; 
			// decimal20_4 Count1;
      decimal20_4 file_count;
      decimal20_4 ds_count;
     						
    END;
		
		result1_stats_file_count_project:=project(result1_stats,transform(compare_layout_stats_lay,self:=left));
		
		dedup_result1_stats_file_count_project:= dedup(result1_stats_file_count_project,all);
		
			result2_stats_file_count_project:=project(result2_stats,transform(compare_layout_stats_lay,self:=left));
		
		dedup_result2_stats_file_count_project:=dedup(result2_stats_file_count_project,all);
	
	
	// result1_stats;
	// result2_stats;
	// result3_stats;
	// result4_stats;
		
		
   	
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
												
													did_stats:=dataset('~scoringqa::bss::dids::'+ a1 ,compare_layout,CSV(HEADING(single), QUOTE('"')));	
													
													
                   	  	 compare_result1:= join(result1_stats,result2_stats,
                  				                                        left.file_version = right.file_version and
   																															 left.mode = right.mode and
                        	                                        left.field_name = right.field_name and
                           									                      left.distribution_type = right.distribution_type and
                           																	      left.attribute_value = right.attribute_value 
                     																							,transform(	compare_layout,self.file_version:=  if(left.file_version='',right.file_version,left.file_version),
   																																                           self.mode:=   if(left.mode='',right.mode,left.mode),
   																																												   self.field_name:=if(left.field_name='',right.field_name,left.field_name),
                                    			 			                                             self.distribution_type:=if(left.distribution_type='',right.distribution_type,left.distribution_type),
                  																																					 self.p_file_count:= right.file_count,
                  																																					 self.c_file_count:= left.file_count,
                  																																					 self.file_count_diff:=  left.file_count-right.file_count,
																																														 self.matched_file_count:=right.ds_count;
                                 																														 self.attribute_value:=if(left.attribute_value='',right.attribute_value,left.attribute_value),
                        																																		 self.p_frequency:=right.Count1,
                                    			 			                                             self.c_frequency:=left.Count1,
                                 																														 self.frequency_diff:=left.Count1-right.Count1,
                                                                                             self.perc_frequency_diff:=if(left.Count1!= 0 and right.Count1=0,1,(left.Count1-right.Count1)/right.Count1),
   																																				                	 self.p_proportion:=right.Count1/right.ds_count,
                  			 			                                                               self.c_proportion:=left.Count1/left.ds_count,
               																														                   self.proportion_diff:=(left.Count1/left.ds_count)-(right.Count1/right.ds_count),
																																						                 self.abs_proportion_diff:=abs((left.Count1/left.ds_count)-(right.Count1/right.ds_count)),
																	                                                           self.perc_proportion_diff:=if(left.Count1!= 0 and right.Count1=0,1,((left.Count1/left.ds_count)-(right.Count1/right.ds_count))/(right.Count1/right.ds_count)),
                  																																					self.PSI := ((right.Count1/right.ds_count)-(left.Count1/left.ds_count))*ln(((right.Count1/right.ds_count)/(left.Count1/left.ds_count)))
   																																						),full outer );
                  
                   compare_result2:= join(result3_stats,result4_stats,
                     				                                        left.file_version = right.file_version and
																																		 left.mode = right.mode and
                           	                                        left.field_name = right.field_name and
                              									                      left.distribution_type = right.distribution_type and
                              																	      left.attribute_value = right.attribute_value 
                        																							,transform(	compare_layout, self.file_version:=  if(left.file_version='',right.file_version,left.file_version),
   																																                                self.mode:=   if(left.mode='',right.mode,left.mode),
   																																												        self.field_name:=if(left.field_name='',right.field_name,left.field_name),
                                    			 			                                                  self.distribution_type:=if(left.distribution_type='',right.distribution_type,left.distribution_type),
                  																																					      self.p_file_count:= right.file_count,
                  																																					      self.c_file_count:= left.file_count,
                  																																					      self.file_count_diff:=  left.file_count-right.file_count,
																																																	self.matched_file_count:=right.ds_count;
                                 																														      self.attribute_value:=if(left.attribute_value='',right.attribute_value,left.attribute_value),
                        																																		      self.p_frequency:=right.ds_count,
                                    			 			                                                  self.c_frequency:=left.ds_count,
                                    																														  self.frequency_diff:=left.ds_count-right.ds_count,
                                                                                                  self.perc_frequency_diff:=(left.ds_count-right.ds_count)/right.ds_count,
                        																																			    self.p_proportion:=right.Count1,
                                       			 			                                                self.c_proportion:=left.Count1,
                                    																														  self.proportion_diff:=if (right.Count1!= 0 and left.Count1=0,1,(left.Count1-right.Count1)),
                     																																						  self.abs_proportion_diff:=if (right.Count1!= 0 and left.Count1=0,1,abs((left.Count1-right.Count1))),
                                                                                                  self.perc_proportion_diff:=if (left.Count1!= 0 and right.Count1=0,1,(left.Count1-right.Count1)/right.Count1),
																																																	self.PSI :=0;
                     																																						  
                           																						                        ),full outer
                           										
      																															 );
   
		  

                           								final_results_1:= compare_result1 + compare_result2 + did_stats;																													 
                  										
                  
             
                
               			
                   	  	 final_results_2:= join(final_results_1,dedup_result1_stats_file_count_project,
                  				                                        left.file_version = right.file_version and
   																															  left.mode = right.mode 
                        	                                     	,transform(	compare_layout,
																																	                     self.c_file_count:=  if(left.c_file_count= 0 ,right.file_count,left.c_file_count);
																																										   self.matched_file_count:=  right.ds_count,
																																													 self:=left,
                  																																					 
                  																																					
   																																						));
               	
               			
                   	  	 final_results_3:= join(final_results_2,dedup_result2_stats_file_count_project,
                  				                                        left.file_version = right.file_version and
   																															  left.mode = right.mode 
                        	                                     	,transform(	compare_layout,
																																
                  																																					  self.p_file_count:= if(left.p_file_count= 0 ,right.file_count,left.p_file_count);
																																															 self.matched_file_count:=  right.ds_count,
																																																 self:=left,
                  																																					
   																																						));

      									 final_results_4:= project(final_results_3,
                  				                                        
                        	                                     	transform(	compare_layout,
																																
                  																																					  self.file_count_diff:= left.c_file_count-left.p_file_count,
																																																 self:=left,
                  																																					
   																																						));			
														
   	final_results:=final_results_4(file_version<>'file_version');
   	
      																																					
   	
   	
   	
   	rd := record
   final_results.file_version;
   final_results.mode;
    final_results.field_name;
   final_results.distribution_type;
   
   
   			sumofPSI := sum(group, final_results.PSI);
   			// MAP(STD.Str.find(final_results.attribute_value, 'Count', 1) > 0 =>  final_results.p_proportion,
   									// STD.Str.find(final_results.attribute_value, 'Avg', 1) > 0 =>  final_results.p_proportion,
   									// sum(group, final_results.p_proportion));
    END;	
    
    tb := table(final_results, rd, final_results.file_version,final_results.mode,final_results.field_name,final_results.distribution_type); 
   
    
    // output(tb, all);
    
    
     
         compare_layout_3 := RECORD
      	 	  string file_version;
           	string mode;
            string100 field_name;
      	    string30 distribution_type;
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
      			 decimal20_4 sumofPSI;
      			Integer warning_flag;
       END;	
       
       jn := JOIN(final_results, tb, left.file_version = right.file_version and left.mode = right.mode and
                           	                                        left.field_name = right.field_name and
                              									                      left.distribution_type = right.distribution_type ,
                              																	      
      															 TRANSFORM(compare_layout_3,
								self.distribution_type:=if(left.distribution_type='range' and (not RegexFind('[-~!@&%#$^*()_=+?<>,/"{}|]',TRIM(left.attribute_value,LEFT,RIGHT))
								                                                              or (integer)left.attribute_value <=-1 )								                                                          
								                           ,'distinct',left.distribution_type);
							  self.attribute_value:=if(left.attribute_value='average' or left.attribute_value='0-9999999999','',left.attribute_value);												 
      																				self.sumofPSI := right.sumofPSI;
      																				self.warning_flag := If(right.sumofPSI > 0.1 , 1, 0);
      																																						self := left;));
   
   
         	
         			 
   // jn;
	 dedup_jn:=dedup(jn,all);
	 
	 	out_file := output(choosen(dedup_jn,all), ,'~RiskView_Attributes_Reports::out::AttributeDistribution' + a1, CSV(heading(single), quote('"')), overwrite);
			
			
				string out_file_layout := '';
      outfile := dataset('~RiskView_Attributes_Reports::out::AttributeDistribution' + a1, typeof(out_file_layout));
			

        no_of_records := count(outfile);
      			
      	
       			myrec := record, maxlength(9999999) 
         			unsigned code0; 
         			unsigned code1;
         			string line;
      				end;
         
         			myrec ref(outfile l, integer c) := transform 
         			self.code0 := c; 
         			self.code1 := c + 1 ;
         			self := l; 
      				end;
         
         			outputs := project(outfile, ref(left, counter));
         			
         			// outputs;
         
         			MyRec Xform(myrec L,myrec R) := TRANSFORM
         			SELF.line := trim(L.line, left, right) + '\n' + trim(R.line, left, right); 
         			self := l;
         			END;
         
         			XtabOut := iterate(outputs,Xform(left,right));
							
							
			  //////////////////////// report 2///////////////////////////////////
							
						filtered_dedup_jn:=dedup_jn(file_version in ['ITA_V3_Capone' , 'RISKVIEW_v3_capone_prescreen' , 'RISKVIEW_v2_capone_prescreen', 'RISKVIEW_v5_capone_prescreen']);
							
			out_file1 := output(choosen(filtered_dedup_jn,all), ,'~RiskView_Attributes_Reports::out::AttributeDistribution1' + a1, CSV(heading(single), quote('"')), overwrite);
			
			
				string out_file_layout1 := '';
				
      outfile1 := dataset('~RiskView_Attributes_Reports::out::AttributeDistribution1' + a1, typeof(out_file_layout));
			

        no_of_records1 := count(outfile1);
      			
      	
       
         
         			myrec ref1(outfile1 l, integer c) := transform 
         			self.code0 := c; 
         			self.code1 := c + 1 ;
         			self := l; 
      				end;
         
         			outputs1 := project(outfile1, ref1(left, counter));
         			
         			// outputs;
         
         			MyRec Xform1(myrec L,myrec R) := TRANSFORM
         			SELF.line := trim(L.line, left, right) + '\n' + trim(R.line, left, right); 
         			self := l;
         			END;
         
         			XtabOut1 := iterate(outputs1,Xform1(left,right));								
							
         			
         			
	new_bins_remove_superfile:= if(  STD.File.FileExists('~scoringqa::bss::stats::'+ a1) and 
				                                 STD.File.FileExists('~scoringqa::bss::averages::'+ a1) and 
			                                   STD.File.FileExists('~scoringqa::bss::dids::'+ a1),
																				 
      	           sequential(FileServices.DeleteSuperFile('~scoringqa::bss::stats::' + a1),
   							              FileServices.DeleteSuperFile('~scoringqa::bss::averages::' + a1),
					                    FileServices.DeleteSuperFile('~scoringqa::bss::dids::' + a1)) 
															);
					
				  	    old_bins_remove_superfile:= if(  NOTHOR(STD.File.FileExists('~scoringqa::bss::stats::'+ b1) and STD.File.FileExists('~scoringqa::bss::averages::'+ b1)  and
   			                                                                                  STD.File.FileExists('~scoringqa::bss::dids::'+ b1)),
         	           sequential(FileServices.DeleteSuperFile('~scoringqa::bss::stats::' + b1),
      							            FileServices.DeleteSuperFile('~scoringqa::bss::averages::' + b1),
   					FileServices.DeleteSuperFile('~scoringqa::bss::dids::' + b1)));		
   			 
        new_bins:= if( not NOTHOR(STD.File.FileExists('~scoringqa::bss::stats::'+ a1) and STD.File.FileExists('~scoringqa::bss::averages::'+ a1) and 
   			                                                                                  STD.File.FileExists('~scoringqa::bss::dids::'+ a1)),
         	           sequential(FileServices.CreateSuperFile('~scoringqa::bss::stats::' + a1),
      							            FileServices.CreateSuperFile('~scoringqa::bss::averages::' + a1),
   					FileServices.CreateSuperFile('~scoringqa::bss::dids::' + a1),rpt1,rpt2,rpt3,rpt4,rpt24,rpt25,rpt27) );
                																		 
         old_bins:= if( not NOTHOR(STD.File.FileExists('~scoringqa::bss::stats::'+ b1) and STD.File.FileExists('~scoringqa::bss::averages::'+ b1)  and
   			                                                                                  STD.File.FileExists('~scoringqa::bss::dids::'+ b1)),
         	           sequential(FileServices.CreateSuperFile('~scoringqa::bss::stats::' + b1),
      							            FileServices.CreateSuperFile('~scoringqa::bss::averages::' + b1),
   					FileServices.CreateSuperFile('~scoringqa::bss::dids::' + b1),rpt1_1,rpt2_1,rpt3_1,rpt4_1,rpt24_1,rpt25_1,rpt27_1) );

         
	 send_file:=	
 	 fileservices.SendEmailAttachText(Scoring_Project_DailyTracking.email_distribution.BSS_Success_list,
// fileservices.SendEmailAttachText('Bridgett.braaten@lexisnexis.com',					
					'BSS Attribute Distribution Report',
																				'BUSINESS SERVICES SCORING(BSS)Attribute Distribution Report '+ a1 + ' vs ' + b1 + '\n Please view attachment.',
																				 XtabOut[no_of_records].line ,
																				 'text/plain; charset=ISO-8859-3', 
																				'FCRA_AttributeDistributionShifts_' + a1 + '_vs_' + b1 + '.csv',
																				 ,
																				 ,
																				 'Scoring_QA@risk.lexisnexis.com') ;  	
	          
  	 send_file1:=	
 	 fileservices.SendEmailAttachText(Scoring_Project_DailyTracking.email_distribution.BSS_Capone_Specific_Success_list,
// fileservices.SendEmailAttachText('Bridgett.braaten@lexisnexis.com',					
					'FCRA Attribute Distribution Report CAPONE Product specific ',
					'BUSINESS SERVICES SCORING(BSS)Attribute Distribution Report'+ a1 + ' vs ' + b1 + '\n Please view attachment.',
																				 XtabOut1[no_of_records1].line ,
																				 'text/plain; charset=ISO-8859-3', 
																				'FCRA_AttributeDistributionShifts_' + a1 + '_vs_' + b1 + '.csv',
																				 ,
																				 ,
																				 'Scoring_QA@risk.lexisnexis.com') ;  	
	          

   
	 
		   sequential (new_bins_remove_superfile,old_bins_remove_superfile,new_bins,old_bins, out_file, send_file );	

// EXPORT bss := 'todo';
EXPORT Test_FCRA_Attributes := 'todo';
