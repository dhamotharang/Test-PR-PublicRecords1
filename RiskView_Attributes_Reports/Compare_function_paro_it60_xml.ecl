EXPORT Compare_function_paro_it60_xml(current_dt,previous_dt) := functionmacro



file1:= dataset('~foreign::10.241.3.238::sghatti::out::paro_it60_'+previous_dt, RiskView_Attributes_Reports.paro_it60_layout,


 CSV(HEADING(single), QUOTE('"')));
file2:= dataset('~foreign::10.241.3.238::sghatti::out::paro_it60_'+current_dt, RiskView_Attributes_Reports.paro_it60_layout,


 CSV(HEADING(single), QUOTE('"')));



aa:=join(file1,file2,left.acctno=right.acctno,inner);



DS1:=join(file1,aa,left.acctno=right.acctno,inner);

DS2:=join(file2,aa,left.acctno=right.acctno,inner);


	  
				
					RiskView_Attributes_Reports.Distinct_function(DS1,'bansmatchflag',di1);
					RiskView_Attributes_Reports.Distinct_function(DS1,'bansecoaflag',di2);
					RiskView_Attributes_Reports.Distinct_function(DS1,'decsflag',di3);
					RiskView_Attributes_Reports.Distinct_function(DS1,'inputaddrcharflag',di4);
					RiskView_Attributes_Reports.Distinct_function(DS1,'inputsocscharflag',di5);
					RiskView_Attributes_Reports.Distinct_function(DS1,'phonestatusflag',di6);					
					RiskView_Attributes_Reports.Distinct_function(DS1,'addrstatusflag',di7);
					RiskView_Attributes_Reports.Distinct_function(DS1,'addrcharflag',di8);
					RiskView_Attributes_Reports.Distinct_function(DS1,'hownstatusflag',di9);
					RiskView_Attributes_Reports.Distinct_function(DS1,'estincome',di10);
					
			
					
					di:= di1  + di2  + di3  + di4  + di5  + di6  + di7  + di8  + di9  + di10;
				      
		      	
											 
      	result1_stats:= di ;
				
		      	// result1_stats;
				///////////////////////////////////////////////////////////////////////////////
				///////////////////////////////////////////////////////////////////////////////
				//////////////////////////////////////////////////////////////////////////////
				

       	  RiskView_Attributes_Reports.Distinct_function(DS2,'bansmatchflag',dis1);
					RiskView_Attributes_Reports.Distinct_function(DS2,'bansecoaflag',dis2);
					RiskView_Attributes_Reports.Distinct_function(DS2,'decsflag',dis3);
					RiskView_Attributes_Reports.Distinct_function(DS2,'inputaddrcharflag',dis4);
					RiskView_Attributes_Reports.Distinct_function(DS2,'inputsocscharflag',dis5);
					RiskView_Attributes_Reports.Distinct_function(DS2,'phonestatusflag',dis6);					
					RiskView_Attributes_Reports.Distinct_function(DS2,'addrstatusflag',dis7);
					RiskView_Attributes_Reports.Distinct_function(DS2,'addrcharflag',dis8);
					RiskView_Attributes_Reports.Distinct_function(DS2,'hownstatusflag',dis9);
					RiskView_Attributes_Reports.Distinct_function(DS2,'estincome',dis10);
    
				
					
			
					
					dis:= dis1  + dis2  + dis3  + dis4  + dis5  + dis6  + dis7  + dis8  + dis9  + dis10;
				      
							
				
			result2_stats:= dis;
   				
         	// result2_stats;
			/////////////////////////////////////////////////////////////////////////
			/////////////////////////////////////////////////////////////////////////
			////////////////////////////////////////////////////////////////////////
					
			
		      RiskView_Attributes_Reports.Average_func(DS1,'bansmatchflag',av1);		
					RiskView_Attributes_Reports.Average_func(DS1,'decsflag',av2);			
					RiskView_Attributes_Reports.Average_func(DS1,'inputsocscharflag',av3);
					RiskView_Attributes_Reports.Average_func(DS1,'phonestatusflag',av4);					
					RiskView_Attributes_Reports.Average_func(DS1,'addrstatusflag',av5);					
					RiskView_Attributes_Reports.Average_func(DS1,'hownstatusflag',av6);
					RiskView_Attributes_Reports.Average_func(DS1,'estincome',av7);
		  	
			
      
      	  
      	   av:= av1  + av2  + av3  + av5  + av6  + av7;
					
				RiskView_Attributes_Reports.Average_func(DS2,'bansmatchflag',ave1);
				RiskView_Attributes_Reports.Average_func(DS2,'decsflag',ave2);
				RiskView_Attributes_Reports.Average_func(DS2,'inputsocscharflag',ave3);
		    RiskView_Attributes_Reports.Average_func(DS2,'phonestatusflag',ave4);
			 	RiskView_Attributes_Reports.Average_func(DS2,'addrstatusflag',ave5);
				RiskView_Attributes_Reports.Average_func(DS2,'hownstatusflag',ave6);
		  	RiskView_Attributes_Reports.Average_func(DS2,'estincome',ave7);			
				
      
   avearage:= ave1  + ave2  + ave3   + ave5  + ave6  + ave7 ;
			
	
	
	 result3_stats:=av;
   result4_stats:=avearage;
	 
	 //////////////////////////////////////////////////////////////////////////////////
	 /////////////////////////////////////////////////////////////////////////////////
	 //////////////////////////////////////////////////////////////////////////////////
	 
    compare_layout := RECORD
		  string file_version;
			string mode;
      string field_name;
      string distribution_type;
			decimal20_4 p_file_count;
      decimal20_4 c_file_count;
      decimal20_4 file_count_diff;
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
	
								
            END;				
     	 compare_result1:= join(result2_stats,result1_stats,
				                                        // left.file_version = right.file_version and
      	                                        left.field_name = right.field_name and
         									                      left.distribution_type = right.distribution_type and
         																	      left.attribute_value = right.attribute_value //and
         									                      // left.Count1 = right.Count1
   																							,transform(	compare_layout, self.file_version:='paro_it60',
																								                            self.mode:='xml',
																								                            self.field_name:=if(left.field_name='',right.field_name,left.field_name),
                  			 			                                              self.distribution_type:=if(left.distribution_type='',right.distribution_type,left.distribution_type),
																																						self.p_file_count:=count(file1),
																																						self.c_file_count:=count(file2),
																																						self.file_count_diff:=count(file2)-count(file1) ,
               																														  self.attribute_value:=if(left.attribute_value='',right.attribute_value,left.attribute_value),
      																																		  self.p_frequency:=right.Count1,
                  			 			                                              self.c_frequency:=left.Count1,
               																														  self.frequency_diff:=left.Count1-right.Count1,
																																						self.perc_frequency_diff:=if(right.Count1!= 0 and left.Count1=0,1,(left.Count1-right.Count1)/left.Count1),
   																																					self.p_proportion:=right.Count1/count(DS1),
                  			 			                                              self.c_proportion:=left.Count1/count(DS2),
               																														  self.proportion_diff:=(left.Count1/count(DS2))-(right.Count1/count(DS1)),
																																						self.abs_proportion_diff:=abs((left.Count1/count(DS2))-(right.Count1/count(DS1))),
																																						self.perc_proportion_diff:=if(right.Count1!= 0 and left.Count1=0,1,((left.Count1/count(DS2))-(right.Count1/count(DS1)))/(left.Count1/count(DS2)))
																																				
																																						
      																						                        ),full outer
      																																											 );

compare_result2:= join(result4_stats,result3_stats,
				                                        // left.file_version = right.file_version and
      	                                        left.field_name = right.field_name and
         									                      left.distribution_type = right.distribution_type and
         																	      left.attribute_value = right.attribute_value //and
         									                      // left.Count1 = right.Count1
   																							,transform(	compare_layout, self.file_version:='paro_it60',
																							                            	self.mode:='xml',
																								                            self.field_name:=if(left.field_name='',right.field_name,left.field_name),
                  			 			                                              self.distribution_type:=if(left.distribution_type='',right.distribution_type,left.distribution_type),
																																						self.p_file_count:=count(file1),
																																						self.c_file_count:=count(file2),
																																						self.file_count_diff:=count(file2)-count(file1) ,
               																														  self.attribute_value:=if(left.attribute_value='',right.attribute_value,left.attribute_value),
      																																		  self.p_frequency:=count(ds1),
                  			 			                                              self.c_frequency:=count(ds2),
               																														  self.frequency_diff:=count(ds2)-count(ds1),
																																						self.perc_frequency_diff:=(count(ds2)-count(ds1))/count(ds1),
   																																					self.p_proportion:=right.Count1,
                  			 			                                              self.c_proportion:=left.Count1,
               																														  self.proportion_diff:=if (right.Count1!= 0 and left.Count1=0,1,(left.Count1-right.Count1)/left.Count1),
																																						self.abs_proportion_diff:=if (right.Count1!= 0 and left.Count1=0,1,abs((left.Count1-right.Count1)/left.Count1)),
																																						self.perc_proportion_diff:=if (right.Count1!= 0 and left.Count1=0,1,((left.Count1-right.Count1)/left.Count1)/left.Count1)
																																						
      																						                        ),full outer
      																																											 );
         										compare_result:=compare_result1 + compare_result2;																														 
				// compare_result_filter1:=compare_result(abs_proportion_diff>=0.01);										
			  // compare_result_filter2:=sort(compare_result_filter1,-abs_proportion_diff);										

return choosen(compare_result,all);


endmacro;