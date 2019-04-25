EXPORT Compare_function_chase_bnk4_cust_rec(current_dt,previous_dt) := functionmacro



file1:= dataset('~foreign::10.241.3.238::sghatti::out::chase_bnk4_cust_rec_'+previous_dt, RiskView_Attributes_Reports.chase_bnk4_cust_rec_layout,


 CSV(HEADING(single), QUOTE('"')));
file2:= dataset('~foreign::10.241.3.238::sghatti::out::chase_bnk4_cust_rec_'+current_dt, RiskView_Attributes_Reports.chase_bnk4_cust_rec_layout,


 CSV(HEADING(single), QUOTE('"')));




	 
   
	   
	
aa:=join(file1,file2,left.acctno=right.acctno,inner);



DS1:=join(file1,aa,left.acctno=right.acctno,inner);

DS2:=join(file2,aa,left.acctno=right.acctno,inner);


	  		RiskView_Attributes_Reports.Range_function_8(DS1,'firstcount',ra1);
      	RiskView_Attributes_Reports.Range_function_8(DS1,'lastcount',ra2);
				RiskView_Attributes_Reports.Range_function_8(DS1,'addrcount',ra3);
      	RiskView_Attributes_Reports.Range_function_8(DS1,'phonecount',ra4);
      	RiskView_Attributes_Reports.Range_function_8(DS1,'socscount',ra5);
				RiskView_Attributes_Reports.Range_function_8(DS1,'dobcount',ra6);
				RiskView_Attributes_Reports.Range_function_8(DS1,'cmpycount',ra7);
      	RiskView_Attributes_Reports.Range_function_8(DS1,'cmpyaddrcount',ra8);
				RiskView_Attributes_Reports.Range_function_8(DS1,'cmpyphonecount',ra9);
				RiskView_Attributes_Reports.Range_function_8(DS1,'fincount',ra10);
				
			
      	
				
			  	
      	ra:= ra1  + ra2  + ra3  + ra4  + ra5  + ra6  + ra7  + ra8  + ra9  + ra10;
      	
				  RiskView_Attributes_Reports.range_function_9(DS1,'socsdob',ra9_1);
					
					ra_9:=ra9_1;
					
								
							
								 
								 RiskView_Attributes_Reports.Range_Function_10(DS1,'hhriskphoneflag',ra10_1);
								 
								 
								 ra_10:=ra10_1;
								 
								 	 RiskView_Attributes_Reports.Range_Function_11(DS1,'phonedissflag',ra11_1);
								 
								 
								 ra_11:=ra11_1;
								 
								 	 RiskView_Attributes_Reports.Range_Function_12(DS1,'ecovariables',ra12_1);
								 
								 
								 ra_12:=ra12_1;
								 
								  	 RiskView_Attributes_Reports.Range_Function_14(DS1,'socsverlevel',ra14_1);
								 
								 
								 ra_14:=ra14_1;
				
					RiskView_Attributes_Reports.Distinct_function(DS1,'phonezipflag',di1);
					RiskView_Attributes_Reports.Distinct_function(DS1,'zipclassflag',di2);
					RiskView_Attributes_Reports.Distinct_function(DS1,'bansflag',di3);
					RiskView_Attributes_Reports.Distinct_function(DS1,'addrvalflag',di4);
					RiskView_Attributes_Reports.Distinct_function(DS1,'dwelltypeflag',di5);
					RiskView_Attributes_Reports.Distinct_function(DS1,'errorcode',di6);					
					RiskView_Attributes_Reports.Distinct_function(DS1,'hphonetypeflag',di7);
					RiskView_Attributes_Reports.Distinct_function(DS1,'hphonesrvc',di8);
					RiskView_Attributes_Reports.Distinct_function(DS1,'wphonetypeflag',di9);
					RiskView_Attributes_Reports.Distinct_function(DS1,'wphonesrvc',di10);
					
				RiskView_Attributes_Reports.Distinct_function(DS1,'numelever',di11);
				RiskView_Attributes_Reports.Distinct_function(DS1,'numsource',di12);
				RiskView_Attributes_Reports.Distinct_function(DS1,'numcmpyelever',di13);
		    RiskView_Attributes_Reports.Distinct_function(DS1,'numcmpysource',di14);
			 	RiskView_Attributes_Reports.Distinct_function(DS1,'tcifull',di15);
				RiskView_Attributes_Reports.Distinct_function(DS1,'tcilast',di16);
		  	RiskView_Attributes_Reports.Distinct_function(DS1,'tciaddr',di17);
				RiskView_Attributes_Reports.Distinct_function(DS1,'firstscore',di18);
				RiskView_Attributes_Reports.Distinct_function(DS1,'lastscore',di19);
				RiskView_Attributes_Reports.Distinct_function(DS1,'addrscore',di20);
		    RiskView_Attributes_Reports.Distinct_function(DS1,'phonescore',di21);
			 	RiskView_Attributes_Reports.Distinct_function(DS1,'socscore',di22);
				RiskView_Attributes_Reports.Distinct_function(DS1,'dobscore',di23);
		  	RiskView_Attributes_Reports.Distinct_function(DS1,'cmpyscore2',di24);
				RiskView_Attributes_Reports.Distinct_function(DS1,'cmpyaddrscore',di25);
		  	RiskView_Attributes_Reports.Distinct_function(DS1,'cmpyphonescore',di26);
					
					di:= di1  + di2  + di3  + di4  + di5  + di6  + di7  + di8  + di9  + di10 +
				       di11 + di12 + di13 + di14 + di15 + di16 + di17 + di18 + di19 + di20 +
						   di21 + di22 + di23 + di24 + di25 + di26;
		      	
											 
      	result1_stats:= di + ra + ra_9 + ra_10 + ra_11  + ra_12 + ra_14;
				
		      	// result1_stats;
				///////////////////////////////////////////////////////////////////////////////
				///////////////////////////////////////////////////////////////////////////////
				//////////////////////////////////////////////////////////////////////////////
				

      	RiskView_Attributes_Reports.Range_function_8(DS2,'firstcount',ran1);
      	RiskView_Attributes_Reports.Range_function_8(DS2,'lastcount',ran2);
				RiskView_Attributes_Reports.Range_function_8(DS2,'addrcount',ran3);
      	RiskView_Attributes_Reports.Range_function_8(DS2,'phonecount',ran4);
      	RiskView_Attributes_Reports.Range_function_8(DS2,'socscount',ran5);
				RiskView_Attributes_Reports.Range_function_8(DS2,'dobcount',ran6);
				RiskView_Attributes_Reports.Range_function_8(DS2,'cmpycount',ran7);
      	RiskView_Attributes_Reports.Range_function_8(DS2,'cmpyaddrcount',ran8);
				RiskView_Attributes_Reports.Range_function_8(DS2,'cmpyphonecount',ran9);
				RiskView_Attributes_Reports.Range_function_8(DS2,'fincount',ran10);
				
			
      	
				
			  	
      	ran:= ran1  + ran2  + ran3  + ran4  + ran5  + ran6  + ran7  + ran8  + ran9  + ran10;
      	
				  RiskView_Attributes_Reports.range_function_9(DS2,'socsdob',ran9_1);
					
					ran_9:=ran9_1;
					
								
							
								 
								 RiskView_Attributes_Reports.Range_Function_10(DS2,'hhriskphoneflag',ran10_1);
								 
								 
								 ran_10:=ran10_1;
								 
								 	 RiskView_Attributes_Reports.Range_Function_11(DS2,'phonedissflag',ran11_1);
								 
								 
								 ran_11:=ran11_1;
								 
								 	 RiskView_Attributes_Reports.Range_Function_12(DS2,'ecovariables',ran12_1);
								 
								 
								 ran_12:=ran12_1;
								 
								  RiskView_Attributes_Reports.Range_Function_14(DS2,'socsverlevel',ran14_1);
								 
								 
								 ran_14:=ran14_1;					 
    
				
					RiskView_Attributes_Reports.Distinct_function(DS2,'phonezipflag',dis1);
					RiskView_Attributes_Reports.Distinct_function(DS2,'zipclassflag',dis2);
					RiskView_Attributes_Reports.Distinct_function(DS2,'bansflag',dis3);
					RiskView_Attributes_Reports.Distinct_function(DS2,'addrvalflag',dis4);
					RiskView_Attributes_Reports.Distinct_function(DS2,'dwelltypeflag',dis5);
					RiskView_Attributes_Reports.Distinct_function(DS2,'errorcode',dis6);					
					RiskView_Attributes_Reports.Distinct_function(DS2,'hphonetypeflag',dis7);
					RiskView_Attributes_Reports.Distinct_function(DS2,'hphonesrvc',dis8);
					RiskView_Attributes_Reports.Distinct_function(DS2,'wphonetypeflag',dis9);
					RiskView_Attributes_Reports.Distinct_function(DS2,'wphonesrvc',dis10);
					
				RiskView_Attributes_Reports.Distinct_function(DS2,'numelever',dis11);
				RiskView_Attributes_Reports.Distinct_function(DS2,'numsource',dis12);
				RiskView_Attributes_Reports.Distinct_function(DS2,'numcmpyelever',dis13);
		    RiskView_Attributes_Reports.Distinct_function(DS2,'numcmpysource',dis14);
			 	RiskView_Attributes_Reports.Distinct_function(DS2,'tcifull',dis15);
				RiskView_Attributes_Reports.Distinct_function(DS2,'tcilast',dis16);
		  	RiskView_Attributes_Reports.Distinct_function(DS2,'tciaddr',dis17);
				RiskView_Attributes_Reports.Distinct_function(DS2,'firstscore',dis18);
				RiskView_Attributes_Reports.Distinct_function(DS2,'lastscore',dis19);
				RiskView_Attributes_Reports.Distinct_function(DS2,'addrscore',dis20);
		    RiskView_Attributes_Reports.Distinct_function(DS2,'phonescore',dis21);
			 	RiskView_Attributes_Reports.Distinct_function(DS2,'socscore',dis22);
				RiskView_Attributes_Reports.Distinct_function(DS2,'dobscore',dis23);
		  	RiskView_Attributes_Reports.Distinct_function(DS2,'cmpyscore2',dis24);
				RiskView_Attributes_Reports.Distinct_function(DS2,'cmpyaddrscore',dis25);
		  	RiskView_Attributes_Reports.Distinct_function(DS2,'cmpyphonescore',dis26);
					
					dis:= dis1  + dis2  + dis3  + dis4  + dis5  + dis6  + dis7  + dis8  + dis9  + dis10 +
				        dis11 + dis12 + dis13 + dis14 + dis15 + dis16 + dis17 + dis18 + dis19 + dis20 +
						    dis21 + dis22 + dis23 + dis24 + dis25 + dis26;
		      	
							
				
			result2_stats:= dis + ran + ran_9 + ran_10 + ran_11 + ran_12 + ran_14;
   				
         	// result2_stats;
			/////////////////////////////////////////////////////////////////////////
			/////////////////////////////////////////////////////////////////////////
			////////////////////////////////////////////////////////////////////////
					
				RiskView_Attributes_Reports.Average_func(DS1,'numelever',av1);
				RiskView_Attributes_Reports.Average_func(DS1,'numsource',av2);
				RiskView_Attributes_Reports.Average_func(DS1,'numcmpyelever',av3);
		    RiskView_Attributes_Reports.Average_func(DS1,'numcmpysource',av4);
			 	RiskView_Attributes_Reports.Average_func(DS1,'tcifull',av5);
				RiskView_Attributes_Reports.Average_func(DS1,'tcilast',av6);
		  	RiskView_Attributes_Reports.Average_func(DS1,'tciaddr',av7);
				RiskView_Attributes_Reports.Average_func(DS1,'firstscore',av8);
				RiskView_Attributes_Reports.Average_func(DS1,'lastscore',av9);
				RiskView_Attributes_Reports.Average_func(DS1,'addrscore',av10);
		    RiskView_Attributes_Reports.Average_func(DS1,'phonescore',av11);
			 	RiskView_Attributes_Reports.Average_func(DS1,'socscore',av12);
				RiskView_Attributes_Reports.Average_func(DS1,'dobscore',av13);
		  	RiskView_Attributes_Reports.Average_func(DS1,'cmpyscore2',av14);
				RiskView_Attributes_Reports.Average_func(DS1,'cmpyaddrscore',av15);
		  	RiskView_Attributes_Reports.Average_func(DS1,'cmpyphonescore',av16);
		  	
				RiskView_Attributes_Reports.Average_func(DS1,'firstcount',av17);
      	RiskView_Attributes_Reports.Average_func(DS1,'lastcount',av18);
				RiskView_Attributes_Reports.Average_func(DS1,'addrcount',av19);
      	RiskView_Attributes_Reports.Average_func(DS1,'phonecount',av20);
      	RiskView_Attributes_Reports.Average_func(DS1,'socscount',av21);
				RiskView_Attributes_Reports.Average_func(DS1,'dobcount',av22);
				RiskView_Attributes_Reports.Average_func(DS1,'cmpycount',av23);
      	RiskView_Attributes_Reports.Average_func(DS1,'cmpyaddrcount',av24);
				RiskView_Attributes_Reports.Average_func(DS1,'cmpyphonecount',av25);
				RiskView_Attributes_Reports.Average_func(DS1,'fincount',av26);	
			  RiskView_Attributes_Reports.Average_func(DS1,'socsdob',av27);
				RiskView_Attributes_Reports.Average_func(DS1,'hhriskphoneflag',av29);						 
					RiskView_Attributes_Reports.Average_func(DS1,'phonedissflag',av30);							 
					RiskView_Attributes_Reports.Average_func(DS1,'socsverlevel',av31);
					RiskView_Attributes_Reports.Average_func(DS1,'phonezipflag',av32);
					RiskView_Attributes_Reports.Average_func(DS1,'zipclassflag',av33);
					RiskView_Attributes_Reports.Average_func(DS1,'bansflag',av34);
					RiskView_Attributes_Reports.Average_func(DS1,'addrvalflag',av35);
					RiskView_Attributes_Reports.Average_func(DS1,'dwelltypeflag',av36);
					RiskView_Attributes_Reports.Average_func(DS1,'errorcode',av37);					
					RiskView_Attributes_Reports.Average_func(DS1,'hphonetypeflag',av38);
					RiskView_Attributes_Reports.Average_func(DS1,'hphonesrvc',av39);
					RiskView_Attributes_Reports.Average_func(DS1,'wphonetypeflag',av40);
					RiskView_Attributes_Reports.Average_func(DS1,'wphonesrvc',av41);
      
      	  
      	   av:= av1  + av2  + av3  + av5  + av6  + av7  + av8  + av9  + av10 +
				        av11 + av12 + av13 + av14 + av15 + av16 + av17 + av18 + av19 + av20 +
						    av21 + av22 + av23 + av24 + av25 + av26 + av27              + av29 + av30 +
				        av31 + av32 + av33 + av34 + av35 + av36 + av37 + av38 + av39 + av40 +
				        av41;
					
				RiskView_Attributes_Reports.Average_func(DS2,'numelever',ave1);
				RiskView_Attributes_Reports.Average_func(DS2,'numsource',ave2);
				RiskView_Attributes_Reports.Average_func(DS2,'numcmpyelever',ave3);
		    RiskView_Attributes_Reports.Average_func(DS2,'numcmpysource',ave4);
			 	RiskView_Attributes_Reports.Average_func(DS2,'tcifull',ave5);
				RiskView_Attributes_Reports.Average_func(DS2,'tcilast',ave6);
		  	RiskView_Attributes_Reports.Average_func(DS2,'tciaddr',ave7);			
				RiskView_Attributes_Reports.Average_func(DS2,'firstscore',ave8);
				RiskView_Attributes_Reports.Average_func(DS2,'lastscore',ave9);
				RiskView_Attributes_Reports.Average_func(DS2,'addrscore',ave10);
		    RiskView_Attributes_Reports.Average_func(DS2,'phonescore',ave11);
			 	RiskView_Attributes_Reports.Average_func(DS2,'socscore',ave12);
				RiskView_Attributes_Reports.Average_func(DS2,'dobscore',ave13);
		  	RiskView_Attributes_Reports.Average_func(DS2,'cmpyscore2',ave14);
				RiskView_Attributes_Reports.Average_func(DS2,'cmpyaddrscore',ave15);
		  	RiskView_Attributes_Reports.Average_func(DS2,'cmpyphonescore',ave16);
				
				RiskView_Attributes_Reports.Average_func(DS2,'firstcount',ave17);
      	RiskView_Attributes_Reports.Average_func(DS2,'lastcount',ave18);
				RiskView_Attributes_Reports.Average_func(DS2,'addrcount',ave19);
      	RiskView_Attributes_Reports.Average_func(DS2,'phonecount',ave20);
      	RiskView_Attributes_Reports.Average_func(DS2,'socscount',ave21);
				RiskView_Attributes_Reports.Average_func(DS2,'dobcount',ave22);
				RiskView_Attributes_Reports.Average_func(DS2,'cmpycount',ave23);
      	RiskView_Attributes_Reports.Average_func(DS2,'cmpyaddrcount',ave24);
				RiskView_Attributes_Reports.Average_func(DS2,'cmpyphonecount',ave25);
				RiskView_Attributes_Reports.Average_func(DS2,'fincount',ave26);	
			  RiskView_Attributes_Reports.Average_func(DS2,'socsdob',ave27);
				RiskView_Attributes_Reports.Average_func(DS2,'hhriskphoneflag',ave29);						 
					RiskView_Attributes_Reports.Average_func(DS2,'phonedissflag',ave30);							 
					RiskView_Attributes_Reports.Average_func(DS2,'socsverlevel',ave31);
					RiskView_Attributes_Reports.Average_func(DS2,'phonezipflag',ave32);
					RiskView_Attributes_Reports.Average_func(DS2,'zipclassflag',ave33);
					RiskView_Attributes_Reports.Average_func(DS2,'bansflag',ave34);
					RiskView_Attributes_Reports.Average_func(DS2,'addrvalflag',ave35);
					RiskView_Attributes_Reports.Average_func(DS2,'dwelltypeflag',ave36);
					RiskView_Attributes_Reports.Average_func(DS2,'errorcode',ave37);					
					RiskView_Attributes_Reports.Average_func(DS2,'hphonetypeflag',ave38);
					RiskView_Attributes_Reports.Average_func(DS2,'hphonesrvc',ave39);
					RiskView_Attributes_Reports.Average_func(DS2,'wphonetypeflag',ave40);
					RiskView_Attributes_Reports.Average_func(DS2,'wphonesrvc',ave41);
		  	
      
   avearage:= ave1  + ave2  + ave3   + ave5  + ave6  + ave7  + ave8  + ave9  + ave10 +
				           ave11 + ave12 + ave13 + ave14 + ave15 + ave16 + ave17 + ave18 + ave19 + ave20 +
						       ave21 + ave22 + ave23 + ave24 + ave25 + ave26 + ave27  + ave29 + ave30 +
				           ave31 + ave32 + ave33 + ave34 + ave35 + ave36 + ave37 + ave38 + ave39 + ave40 +
				           ave41;
			
	
	
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
   																							,transform(	compare_layout, self.file_version:='chase_bnk4_cust_rec',
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
   																							,transform(	compare_layout, self.file_version:='chase_bnk4_cust_rec',
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