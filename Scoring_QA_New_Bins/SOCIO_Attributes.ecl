import RiskView_Attributes_Reports;
import Scoring_Project_Macros,scoring_project_pip,Scoring_Project_DailyTracking, scoring_QA, Scoring_QA_Risk_Indicator_Report;
import ut,std;
import RiskView_Attributes_Reports, Scoring_QA_New_Bins;

	a:= ut.GetDate;
	
fn_LastTwoMonths(string10 date_inp,integer offset) := function
res  := GLOBAL(ut.DateFrom_DaysSince1900(ut.DaysSince1900(date_inp[1..4], date_inp[5..6], date_inp[7..8]) - offset));
return res[1..8];
end;

b:=fn_LastTwoMonths(a,1);
	a1:= a +'_1';
	// a1:= '20190107_1';

b1:=b +'_1';
// b1:='20190226_1';

ip:='~';

		// rpt26:=Scoring_QA_New_Bins.Test_fpv201_attr_report(ip,a1,b1);

		// rpt29:= Scoring_QA_New_Bins.Test_ProfileBooster_attribute_report(ip,a1,b1);
		
		//rpt30:= Scoring_QA_New_Bins.Test_BIIDv2_attribute_report(ip,a1,b1);
		rpt31:= Scoring_QA_New_Bins.SOCIO_Attribute_Report(ip,a1,b1);

		// rpt26_1:=Scoring_QA_New_Bins.Test_fpv201_attr_report(ip,b1,a1);

		// rpt29_1:= Scoring_QA_New_Bins.Test_ProfileBooster_attribute_report(ip,b1,a1);
		
		//rpt30_1:= Scoring_QA_New_Bins.Test_BIIDv2_attribute_report(ip,b1,a1);
		rpt31_1:= Scoring_QA_New_Bins.SOCIO_Attribute_Report(ip,b1,a1);


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
		
		result1_stats:=dataset('~scoringqa::bss::stats1::'+ a1 ,compare_layout_stats,CSV(HEADING(single), QUOTE('"')));		
		result2_stats:=dataset('~scoringqa::bss::stats1::'+ b1 ,compare_layout_stats,CSV(HEADING(single), QUOTE('"')));		
		
    result3_stats:=dataset('~scoringqa::bss::averages1::'+ a1 ,compare_layout_stats,CSV(HEADING(single), QUOTE('"')));	
    result4_stats:=dataset('~scoringqa::bss::averages1::'+ b1 ,compare_layout_stats,CSV(HEADING(single), QUOTE('"')));	
	
			  compare_layout_stats_lay := RECORD
	    string file_version;
			string mode;
      decimal20_4 file_count;
      decimal20_4 ds_count;
    END;
		
		result1_stats_file_count_project:=project(result1_stats,transform(compare_layout_stats_lay,self:=left));
		
		dedup_result1_stats_file_count_project:= dedup(result1_stats_file_count_project,all);
		
			result2_stats_file_count_project:=project(result2_stats,transform(compare_layout_stats_lay,self:=left));
		
		dedup_result2_stats_file_count_project:=dedup(result2_stats_file_count_project,all);
		
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
												
													did_stats:=dataset('~scoringqa::bss::dids1::'+ a1 ,compare_layout,CSV(HEADING(single), QUOTE('"')));	
													
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
                           																						                        ),full outer );

                           								final_results_1:= compare_result1 + compare_result2 + did_stats;																													 
               			
                   	  	 final_results_2:= join(final_results_1,dedup_result1_stats_file_count_project,
                  				                                        left.file_version = right.file_version and
   																															  left.mode = right.mode,
                        	                                     	transform(	compare_layout,
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
    END;	
    
    tb := table(final_results, rd, final_results.file_version,final_results.mode,final_results.field_name,final_results.distribution_type); 
     
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
	 
	 	out_file := output(choosen(dedup_jn,all), ,'~dph::nonfcra::attributes::socio' + a1, CSV(heading(single), quote('"')), overwrite,EXPIRE(10));
			
				string out_file_layout := '';
      outfile := dataset('~dph::nonfcra::attributes::socio' + a1, typeof(out_file_layout));
			
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
         			
         			MyRec Xform(myrec L,myrec R) := TRANSFORM
         			SELF.line := trim(L.line, left, right) + '\n' + trim(R.line, left, right); 
         			self := l;
         			END;
         
         			XtabOut := iterate(outputs,Xform(left,right));

	new_bins_remove_superfile:= if(  STD.File.FileExists('~scoringqa::bss::stats1::'+ a1) and 
				                                 STD.File.FileExists('~scoringqa::bss::averages1::'+ a1) and 
			                                   STD.File.FileExists('~scoringqa::bss::dids1::'+ a1),
																				 
      	           sequential(FileServices.DeleteSuperFile('~scoringqa::bss::stats1::' + a1),
   							              FileServices.DeleteSuperFile('~scoringqa::bss::averages1::' + a1),
					                    FileServices.DeleteSuperFile('~scoringqa::bss::dids1::' + a1)) 
															);
					
				  	    old_bins_remove_superfile:= if(  NOTHOR(STD.File.FileExists('~scoringqa::bss::stats1::'+ b1) and 
															STD.File.FileExists('~scoringqa::bss::averages1::'+ b1)  and
   			        							STD.File.FileExists('~scoringqa::bss::dids1::'+ b1)),
         	           sequential(FileServices.DeleteSuperFile('~scoringqa::bss::stats1::' + b1),
      							            FileServices.DeleteSuperFile('~scoringqa::bss::averages1::' + b1),
   					FileServices.DeleteSuperFile('~scoringqa::bss::dids1::' + b1)));		
   			 
        new_bins:= if( not NOTHOR(STD.File.FileExists('~scoringqa::bss::stats1::'+ a1) and STD.File.FileExists('~scoringqa::bss::averages1::'+ a1) and 
   			                                                                                  STD.File.FileExists('~scoringqa::bss::dids1::'+ a1)),
         	           sequential(FileServices.CreateSuperFile('~scoringqa::bss::stats1::' + a1),
      							            FileServices.CreateSuperFile('~scoringqa::bss::averages1::' + a1),
   					FileServices.CreateSuperFile('~scoringqa::bss::dids1::' + a1),rpt31) );
                																		 
         old_bins:= if( not NOTHOR(STD.File.FileExists('~scoringqa::bss::stats1::'+ b1) and STD.File.FileExists('~scoringqa::bss::averages1::'+ b1)  and
   			                                                                                  STD.File.FileExists('~scoringqa::bss::dids1::'+ b1)),
         	           sequential(FileServices.CreateSuperFile('~scoringqa::bss::stats1::' + b1),
      							            FileServices.CreateSuperFile('~scoringqa::bss::averages1::' + b1),
   					FileServices.CreateSuperFile('~scoringqa::bss::dids1::' + b1),rpt31_1) );

	 send_file:=	
fileservices.SendEmailAttachText('daniel.harkins@lexisnexisrisk.com,matthew.ludewig@lexisnexisrisk.com',					
					'SOCIO_v5 Attribute Distribution Report',
																				'BUSINESS SERVICES SCORING(BSS)NonFCRA Attribute Distribution Report '+ a1 + ' vs ' + b1 + '\n Please view attachment.',
																				 XtabOut[no_of_records].line ,
																				 'text/plain; charset=ISO-8859-3', 
																				'SOCIO_AttributeDistributionShifts_' + a1 + '_vs_' + b1 + '.csv',
																				 ,
																				 ,
																				 'daniel.harkins@lexisnexisrisk.com,matthew.ludewig@lexisnexisrisk.com') ;  	
	          
		   sequential (new_bins_remove_superfile,old_bins_remove_superfile,new_bins,old_bins, out_file, send_file );	//new_bins_remove_superfile,old_bins_remove_superfile,

EXPORT SOCIO_Attributes := 'todo';