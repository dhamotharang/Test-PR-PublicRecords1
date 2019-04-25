EXPORT Compare_function_chase_pi02_cust_rec(current_dt,previous_dt) := functionmacro



file1:= dataset('~foreign::10.241.3.238::sghatti::out::chase_pi02_cust_rec_'+previous_dt, RiskView_Attributes_Reports.chase_pi02_cust_rec_layout,


 CSV(HEADING(single), QUOTE('"')));
file2:= dataset('~foreign::10.241.3.238::sghatti::out::chase_pi02_cust_rec_'+current_dt, RiskView_Attributes_Reports.chase_pi02_cust_rec_layout,


 CSV(HEADING(single), QUOTE('"')));


	   
	

aa:=join(file1,file2,left.acctno=right.acctno,inner);



DS1:=join(file1,aa,left.acctno=right.acctno,inner);

DS2:=join(file2,aa,left.acctno=right.acctno,inner);


	  	
      	RiskView_Attributes_Reports.Range_function_8(DS1,'firstcount',ra1);
      	RiskView_Attributes_Reports.Range_function_8(DS1,'lastcount',ra2);
				RiskView_Attributes_Reports.Range_function_8(DS1,'addrcount',ra3);
      	// RiskView_Attributes_Reports.Range_function_8(DS1,'phonecount',ra4);
      	RiskView_Attributes_Reports.Range_function_8(DS1,'socscount',ra5);
				RiskView_Attributes_Reports.Range_function_8(DS1,'dobcount',ra6);
			
				
			
      	
				
			  	
      	ra:= ra1  + ra2  + ra3   + ra5  + ra6;
      	
			
								 
								  	 RiskView_Attributes_Reports.Range_Function_14(DS1,'socsverlevel',ra14_1);
								 
								 
								 ra_14:=ra14_1;
				
					RiskView_Attributes_Reports.Distinct_function(DS1,'hriskphoneflag',di1);
					RiskView_Attributes_Reports.Distinct_function(DS1,'phonevalflag',di2);
					RiskView_Attributes_Reports.Distinct_function(DS1,'phonezipflag',di3);
					RiskView_Attributes_Reports.Distinct_function(DS1,'hriskaddrflag',di4);
					RiskView_Attributes_Reports.Distinct_function(DS1,'decsflag',di5);
					RiskView_Attributes_Reports.Distinct_function(DS1,'socsdobflag',di6);					
					RiskView_Attributes_Reports.Distinct_function(DS1,'socsvalflag',di7);
					RiskView_Attributes_Reports.Distinct_function(DS1,'drlcvalflag',di8);
					RiskView_Attributes_Reports.Distinct_function(DS1,'addrvalflag',di9);
					RiskView_Attributes_Reports.Distinct_function(DS1,'dwelltypeflag',di10);					
				RiskView_Attributes_Reports.Distinct_function(DS1,'idtheftflag',di11);
				RiskView_Attributes_Reports.Distinct_function(DS1,'aptscanflag',di12);
				RiskView_Attributes_Reports.Distinct_function(DS1,'addrhistoryflag',di13);
		    RiskView_Attributes_Reports.Distinct_function(DS1,'firstcount',di14);
			 	RiskView_Attributes_Reports.Distinct_function(DS1,'lastcount',di15);				
				RiskView_Attributes_Reports.Distinct_function(DS1,'addrcount',di16);
		  	RiskView_Attributes_Reports.Distinct_function(DS1,'hphonecount',di17);
				RiskView_Attributes_Reports.Distinct_function(DS1,'wphonecount',di18);
				RiskView_Attributes_Reports.Distinct_function(DS1,'socscount',di19);
				RiskView_Attributes_Reports.Distinct_function(DS1,'socsverlevel',di20);
		    RiskView_Attributes_Reports.Distinct_function(DS1,'dobcount',di21);				
			 	RiskView_Attributes_Reports.Distinct_function(DS1,'numelever',di22);
				RiskView_Attributes_Reports.Distinct_function(DS1,'numsource',di23);				
		  	RiskView_Attributes_Reports.Distinct_function(DS1,'firstscore',di24);
				RiskView_Attributes_Reports.Distinct_function(DS1,'lastscore',di25);
		  	RiskView_Attributes_Reports.Distinct_function(DS1,'addrscore',di26);				
			  	RiskView_Attributes_Reports.Distinct_function(DS1,'hphonescore',di27);
					RiskView_Attributes_Reports.Distinct_function(DS1,'socsscore',di28);
					RiskView_Attributes_Reports.Distinct_function(DS1,'dobscore',di29);
					RiskView_Attributes_Reports.Distinct_function(DS1,'socsmiskeyflag',di30);
					RiskView_Attributes_Reports.Distinct_function(DS1,'hphonemiskeyflag',di31);
					RiskView_Attributes_Reports.Distinct_function(DS1,'addrmiskeyflag',di32);
					RiskView_Attributes_Reports.Distinct_function(DS1,'disthphoneaddr',di33);
					RiskView_Attributes_Reports.Distinct_function(DS1,'disthphonewphone',di34);
					RiskView_Attributes_Reports.Distinct_function(DS1,'distwphoneaddr',di35);
					RiskView_Attributes_Reports.Distinct_function(DS1,'estincome',di36);
					RiskView_Attributes_Reports.Distinct_function(DS1,'numfraud',di37);
					
				
					
			di:= di1  + di2  + di3  + di4  + di5  + di6  + di7  + di8  + di9  + di10 +
				       di11 + di12 + di13 + di14 + di15 + di16 + di17 + di18 + di19 + di20 +
						   di21 + di22 + di23 + di24 + di25 + di26 + di27 + di28 + di29 + di30 +
				       di31 + di32 + di33 + di34 + di35 + di36 + di37;
		      	
											 
      	result1_stats:= di + ra +  ra_14;
				
		      	// result1_stats;
				///////////////////////////////////////////////////////////////////////////////
				///////////////////////////////////////////////////////////////////////////////
				//////////////////////////////////////////////////////////////////////////////
				

      	RiskView_Attributes_Reports.Range_function_8(DS2,'firstcount',ran1);
      	RiskView_Attributes_Reports.Range_function_8(DS2,'lastcount',ran2);
				RiskView_Attributes_Reports.Range_function_8(DS2,'addrcount',ran3);
      	// RiskView_Attributes_Reports.Range_function_8(DS2,'phonecount',ran4);
      	RiskView_Attributes_Reports.Range_function_8(DS2,'socscount',ran5);
				RiskView_Attributes_Reports.Range_function_8(DS2,'dobcount',ran6);
		
				
			
      	
				
			  	
      	ran:= ran1  + ran2  + ran3  + ran5  + ran6 ;
      	
				
								 
								  RiskView_Attributes_Reports.Range_Function_14(DS2,'socsverlevel',ran14_1);
								 
								 
								 ran_14:=ran14_1;					 
    
				
					RiskView_Attributes_Reports.Distinct_function(DS2,'hriskphoneflag',dis1);
					RiskView_Attributes_Reports.Distinct_function(DS2,'phonevalflag',dis2);
					RiskView_Attributes_Reports.Distinct_function(DS2,'phonezipflag',dis3);
					RiskView_Attributes_Reports.Distinct_function(DS2,'hriskaddrflag',dis4);
					RiskView_Attributes_Reports.Distinct_function(DS2,'decsflag',dis5);
					RiskView_Attributes_Reports.Distinct_function(DS2,'socsdobflag',dis6);					
					RiskView_Attributes_Reports.Distinct_function(DS2,'socsvalflag',dis7);
					RiskView_Attributes_Reports.Distinct_function(DS2,'drlcvalflag',dis8);
					RiskView_Attributes_Reports.Distinct_function(DS2,'addrvalflag',dis9);
					RiskView_Attributes_Reports.Distinct_function(DS2,'dwelltypeflag',dis10);					
				RiskView_Attributes_Reports.Distinct_function(DS2,'idtheftflag',dis11);
				RiskView_Attributes_Reports.Distinct_function(DS2,'aptscanflag',dis12);
				RiskView_Attributes_Reports.Distinct_function(DS2,'addrhistoryflag',dis13);
		    RiskView_Attributes_Reports.Distinct_function(DS2,'firstcount',dis14);
			 	RiskView_Attributes_Reports.Distinct_function(DS2,'lastcount',dis15);				
				RiskView_Attributes_Reports.Distinct_function(DS2,'addrcount',dis16);
		  	RiskView_Attributes_Reports.Distinct_function(DS2,'hphonecount',dis17);
				RiskView_Attributes_Reports.Distinct_function(DS2,'wphonecount',dis18);
				RiskView_Attributes_Reports.Distinct_function(DS2,'socscount',dis19);
				RiskView_Attributes_Reports.Distinct_function(DS2,'socsverlevel',dis20);
		    RiskView_Attributes_Reports.Distinct_function(DS2,'dobcount',dis21);				
			 	RiskView_Attributes_Reports.Distinct_function(DS2,'numelever',dis22);
				RiskView_Attributes_Reports.Distinct_function(DS2,'numsource',dis23);				
		  	RiskView_Attributes_Reports.Distinct_function(DS2,'firstscore',dis24);
				RiskView_Attributes_Reports.Distinct_function(DS2,'lastscore',dis25);
		  	RiskView_Attributes_Reports.Distinct_function(DS2,'addrscore',dis26);				
			  	RiskView_Attributes_Reports.Distinct_function(DS2,'hphonescore',dis27);
					RiskView_Attributes_Reports.Distinct_function(DS2,'socsscore',dis28);
					RiskView_Attributes_Reports.Distinct_function(DS2,'dobscore',dis29);
					RiskView_Attributes_Reports.Distinct_function(DS2,'socsmiskeyflag',dis30);
					RiskView_Attributes_Reports.Distinct_function(DS2,'hphonemiskeyflag',dis31);
					RiskView_Attributes_Reports.Distinct_function(DS2,'addrmiskeyflag',dis32);
					RiskView_Attributes_Reports.Distinct_function(DS2,'disthphoneaddr',dis33);
					RiskView_Attributes_Reports.Distinct_function(DS2,'disthphonewphone',dis34);
					RiskView_Attributes_Reports.Distinct_function(DS2,'distwphoneaddr',dis35);
					RiskView_Attributes_Reports.Distinct_function(DS2,'estincome',dis36);
					RiskView_Attributes_Reports.Distinct_function(DS2,'numfraud',dis37);
					
					dis:= dis1  + dis2  + dis3  + dis4  + dis5  + dis6  + dis7  + dis8  + dis9  + dis10 +
				        dis11 + dis12 + dis13 + dis14 + dis15 + dis16 + dis17 + dis18 + dis19 + dis20 +
						    dis21 + dis22 + dis23 + dis24 + dis25 + dis26 + dis27 + dis28 + dis29 + dis30 +
				        dis31 + dis32 + dis33 + dis34 + dis35 + dis36 + dis37;
		      	
							
				
			result2_stats:= dis + ran + ran_14;
   				
         	// result2_stats;
			/////////////////////////////////////////////////////////////////////////
			/////////////////////////////////////////////////////////////////////////
			////////////////////////////////////////////////////////////////////////
					
			RiskView_Attributes_Reports.Average_func(DS1,'hriskphoneflag',av1);
					RiskView_Attributes_Reports.Average_func(DS1,'phonevalflag',av2);
					RiskView_Attributes_Reports.Average_func(DS1,'phonezipflag',av3);
					RiskView_Attributes_Reports.Average_func(DS1,'hriskaddrflag',av4);
					RiskView_Attributes_Reports.Average_func(DS1,'decsflag',av5);
					RiskView_Attributes_Reports.Average_func(DS1,'socsdobflag',av6);					
					RiskView_Attributes_Reports.Average_func(DS1,'socsvalflag',av7);
					RiskView_Attributes_Reports.Average_func(DS1,'drlcvalflag',av8);
					RiskView_Attributes_Reports.Average_func(DS1,'addrvalflag',av9);
					RiskView_Attributes_Reports.Average_func(DS1,'dwelltypeflag',av10);					
				RiskView_Attributes_Reports.Average_func(DS1,'idtheftflag',av11);
				RiskView_Attributes_Reports.Average_func(DS1,'aptscanflag',av12);
				RiskView_Attributes_Reports.Average_func(DS1,'addrhistoryflag',av13);
		    RiskView_Attributes_Reports.Average_func(DS1,'firstcount',av14);
			 	RiskView_Attributes_Reports.Average_func(DS1,'lastcount',av15);				
				RiskView_Attributes_Reports.Average_func(DS1,'addrcount',av16);
		  	RiskView_Attributes_Reports.Average_func(DS1,'hphonecount',av17);
				RiskView_Attributes_Reports.Average_func(DS1,'wphonecount',av18);
				RiskView_Attributes_Reports.Average_func(DS1,'socscount',av19);
				RiskView_Attributes_Reports.Average_func(DS1,'socsverlevel',av20);
		    RiskView_Attributes_Reports.Average_func(DS1,'dobcount',av21);				
			 	RiskView_Attributes_Reports.Average_func(DS1,'numelever',av22);
				RiskView_Attributes_Reports.Average_func(DS1,'numsource',av23);				
		  	RiskView_Attributes_Reports.Average_func(DS1,'firstscore',av24);
				RiskView_Attributes_Reports.Average_func(DS1,'lastscore',av25);
		  	RiskView_Attributes_Reports.Average_func(DS1,'addrscore',av26);				
			  	RiskView_Attributes_Reports.Average_func(DS1,'hphonescore',av27);
					RiskView_Attributes_Reports.Average_func(DS1,'socsscore',av28);
					RiskView_Attributes_Reports.Average_func(DS1,'dobscore',av29);
					RiskView_Attributes_Reports.Average_func(DS1,'socsmiskeyflag',av30);
					RiskView_Attributes_Reports.Average_func(DS1,'hphonemiskeyflag',av31);
					RiskView_Attributes_Reports.Average_func(DS1,'addrmiskeyflag',av32);
					RiskView_Attributes_Reports.Average_func(DS1,'disthphoneaddr',av33);
					RiskView_Attributes_Reports.Average_func(DS1,'disthphonewphone',av34);
					RiskView_Attributes_Reports.Average_func(DS1,'distwphoneaddr',av35);
					RiskView_Attributes_Reports.Average_func(DS1,'estincome',av36);
					RiskView_Attributes_Reports.Average_func(DS1,'numfraud',av37);
		  	
      
    av:= av1  + av2  + av3  + av5  + av6  + av7  + av8  + av9  + av10 +
				        av11 + av12 + av13 + av14 + av15 + av16 + av17 + av18 + av19 + av20 +
						    av21 + av22 + av23 + av24 + av25 + av26 + av27 + av28 + av29 + av30 +
				        av31 + av32 + av33 + av34 + av35 + av36 + av37;
					
				RiskView_Attributes_Reports.Average_func(DS2,'hriskphoneflag',ave1);
					RiskView_Attributes_Reports.Average_func(DS2,'phonevalflag',ave2);
					RiskView_Attributes_Reports.Average_func(DS2,'phonezipflag',ave3);
					RiskView_Attributes_Reports.Average_func(DS2,'hriskaddrflag',ave4);
					RiskView_Attributes_Reports.Average_func(DS2,'decsflag',ave5);
					RiskView_Attributes_Reports.Average_func(DS2,'socsdobflag',ave6);					
					RiskView_Attributes_Reports.Average_func(DS2,'socsvalflag',ave7);
					RiskView_Attributes_Reports.Average_func(DS2,'drlcvalflag',ave8);
					RiskView_Attributes_Reports.Average_func(DS2,'addrvalflag',ave9);
					RiskView_Attributes_Reports.Average_func(DS2,'dwelltypeflag',ave10);					
				RiskView_Attributes_Reports.Average_func(DS2,'idtheftflag',ave11);
				RiskView_Attributes_Reports.Average_func(DS2,'aptscanflag',ave12);
				RiskView_Attributes_Reports.Average_func(DS2,'addrhistoryflag',ave13);
		    RiskView_Attributes_Reports.Average_func(DS2,'firstcount',ave14);
			 	RiskView_Attributes_Reports.Average_func(DS2,'lastcount',ave15);				
				RiskView_Attributes_Reports.Average_func(DS2,'addrcount',ave16);
		  	RiskView_Attributes_Reports.Average_func(DS2,'hphonecount',ave17);
				RiskView_Attributes_Reports.Average_func(DS2,'wphonecount',ave18);
				RiskView_Attributes_Reports.Average_func(DS2,'socscount',ave19);
				RiskView_Attributes_Reports.Average_func(DS2,'socsverlevel',ave20);
		    RiskView_Attributes_Reports.Average_func(DS2,'dobcount',ave21);				
			 	RiskView_Attributes_Reports.Average_func(DS2,'numelever',ave22);
				RiskView_Attributes_Reports.Average_func(DS2,'numsource',ave23);				
		  	RiskView_Attributes_Reports.Average_func(DS2,'firstscore',ave24);
				RiskView_Attributes_Reports.Average_func(DS2,'lastscore',ave25);
		  	RiskView_Attributes_Reports.Average_func(DS2,'addrscore',ave26);				
			  	RiskView_Attributes_Reports.Average_func(DS2,'hphonescore',ave27);
					RiskView_Attributes_Reports.Average_func(DS2,'socsscore',ave28);
					RiskView_Attributes_Reports.Average_func(DS2,'dobscore',ave29);
					RiskView_Attributes_Reports.Average_func(DS2,'socsmiskeyflag',ave30);
					RiskView_Attributes_Reports.Average_func(DS2,'hphonemiskeyflag',ave31);
					RiskView_Attributes_Reports.Average_func(DS2,'addrmiskeyflag',ave32);
					RiskView_Attributes_Reports.Average_func(DS2,'disthphoneaddr',ave33);
					RiskView_Attributes_Reports.Average_func(DS2,'disthphonewphone',ave34);
					RiskView_Attributes_Reports.Average_func(DS2,'distwphoneaddr',ave35);
					RiskView_Attributes_Reports.Average_func(DS2,'estincome',ave36);
					RiskView_Attributes_Reports.Average_func(DS2,'numfraud',ave37);
		  	
      
    avearage:= ave1  + ave2  + ave3  + ave5  + ave6  + ave7  + ave8  + ave9  + ave10 +
				        ave11 + ave12 + ave13 + ave14 + ave15 + ave16 + ave17 + ave18 + ave19 + ave20 +
						    ave21 + ave22 + ave23 + ave24 + ave25 + ave26 + ave27 + ave28 + ave29 + ave30 +
				        ave31 + ave32 + ave33 + ave34 + ave35 + ave36 + ave37;
			
	
	
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
   																							,transform(	compare_layout, self.file_version:='chase_pi02',
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
   																							,transform(	compare_layout, self.file_version:='chase_pi02',
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