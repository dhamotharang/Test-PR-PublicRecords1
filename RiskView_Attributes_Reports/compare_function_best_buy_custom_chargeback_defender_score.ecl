EXPORT compare_function_best_buy_custom_chargeback_defender_score(current_dt,previous_dt) := functionmacro

best_buy_custom_chargeback_defender_score_layout:=RECORD
    string30 account;
  string2 socsverlevel;
  string2 phoneverlevel;
  string20 correctlast;
  string10 correcthphone;
  string9 correctsocs;
  string50 correctaddr;
  string3 altareacode;
  string8 areacodesplitdate;
  string15 verfirst;
  string20 verlast;
  string50 veraddr;
  string30 vercity;
  string2 verstate;
  string5 verzip5;
  string4 verzip4;
  string10 nameaddrphone;
  string1 hphonetypeflag;
  string1 dwelltypeflag;
  string6 sic;
  string2 phoneverlevel2;
  string20 correctlast2;
  string10 correcthphone2;
  string50 correctaddr2;
  string3 altareacode2;
  string8 areacodesplitdate2;
  string15 verfirst2;
  string20 verlast2;
  string50 veraddr2;
  string30 vercity2;
  string2 verstate2;
  string5 verzip52;
  string4 verzip42;
  string10 nameaddrphone2;
  string1 hphonetypeflag2;
  string1 dwelltypeflag2;
  string6 sic2;
  string3 cb_score;
  string2 cb_reason1;
  string2 cb_reason2;
  string2 cb_reason3;
  string2 cb_reason4;
  string2 cb_reason5;
  string2 cb_reason6;
  string2 cb_reason7;
  string2 cb_reason8;
  string2 cb_reason9;
  string2 cb_reason10;
  string2 cb_reason11;
  string2 cb_reason12;
  string200 errorcode;
 END;


DS1:= dataset('~foreign::10.241.3.238::sghatti::out::best_buy_custom_chargeback_defender_score_'+previous_dt, best_buy_custom_chargeback_defender_score_layout,


 CSV(HEADING(single), QUOTE('"')));
DS2:= dataset('~foreign::10.241.3.238::sghatti::out::best_buy_custom_chargeback_defender_score_'+current_dt, best_buy_custom_chargeback_defender_score_layout,


 CSV(HEADING(single), QUOTE('"')));

	 
    	  RiskView_Attributes_Reports.count_function(DS1,'cb_reason1',c1);
      	RiskView_Attributes_Reports.count_function(DS1,'cb_reason2',c2);
				RiskView_Attributes_Reports.count_function(DS1,'cb_reason3',c3);
      	RiskView_Attributes_Reports.count_function(DS1,'cb_reason4',c4);
				
				 RiskView_Attributes_Reports.count_function(DS1,'cb_reason5',c5);
      	RiskView_Attributes_Reports.count_function(DS1,'cb_reason6',c6);
				RiskView_Attributes_Reports.count_function(DS1,'cb_reason7',c7);
      	RiskView_Attributes_Reports.count_function(DS1,'cb_reason8',c8);
				
				RiskView_Attributes_Reports.count_function(DS1,'cb_reason9',c9);
      	RiskView_Attributes_Reports.count_function(DS1,'cb_reason10',c10);
				RiskView_Attributes_Reports.count_function(DS1,'cb_reason11',c11);
      	RiskView_Attributes_Reports.count_function(DS1,'cb_reason12',c12);
				
				
				
ar:=	c1  + c2  + c3  + c4  + c5  + c6  + c7  + c8  + c9  + c10 +
				     c11 + c12;	

	

			RiskView_Attributes_Reports.count_function1(ar,'cb_reason',ar_1);
			
	
				
      	
						 
				score_file1:=	ar_1 ;
						 
			////////////////////////////////////////////////////////////
			////////////////////////////////////////////////////////////////
			//////////////////////////////////////////////////////////////////
			
			
	      RiskView_Attributes_Reports.count_function(DS2,'cb_reason1',cc1);
      	RiskView_Attributes_Reports.count_function(DS2,'cb_reason2',cc2);
				RiskView_Attributes_Reports.count_function(DS2,'cb_reason3',cc3);
      	RiskView_Attributes_Reports.count_function(DS2,'cb_reason4',cc4);
				
				 RiskView_Attributes_Reports.count_function(DS2,'cb_reason5',cc5);
      	RiskView_Attributes_Reports.count_function(DS2,'cb_reason6',cc6);
				RiskView_Attributes_Reports.count_function(DS2,'cb_reason7',cc7);
      	RiskView_Attributes_Reports.count_function(DS2,'cb_reason8',cc8);
				
				RiskView_Attributes_Reports.count_function(DS2,'cb_reason9',cc9);
      	RiskView_Attributes_Reports.count_function(DS2,'cb_reason10',cc10);
				RiskView_Attributes_Reports.count_function(DS2,'cb_reason11',cc11);
      	RiskView_Attributes_Reports.count_function(DS2,'cb_reason12',cc12);  
		
ar2:=	cc1  + cc2  + cc3  + cc4  + cc5  + cc6  + cc7  + cc8  + cc9  + cc10 +
				     cc11 + cc12;	

	RiskView_Attributes_Reports.count_function1(ar2,'cb_reason',ar_2);
			
      	
		     	
				
			  	
       
						 
						score_file2:=	ar_2;	 
						 
		    compare_layout := RECORD
   		   string file_version;
				 string mode;
   		   string field_name;
				 integer p_file_count;
				 integer c_file_count;
				 integer file_count_diff;
         STRING50 reason_code; 
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
							 
			compare_result1:= join(score_file2,score_file1,
   				                                    
         	                                        left.field_name = right.field_name and
            									               	      left.attribute_value = right.attribute_value //and
            									                      // left.Count1 = right.Count1
      																							,transform(	compare_layout, 
																										self.file_version:='best_buy_custom_chargeback_defender',
																										self.mode:='xml',
																										                          self.field_name:=if(left.field_name='',right.field_name,left.field_name),
																																							self.p_file_count:=count(ds1),
																																							self.c_file_count:=count(ds2),
																																							self.file_count_diff:=count(ds2)-count(ds1),
                     			 			                                          	  self.reason_code:= if(left.attribute_value='',  right.attribute_value, left.attribute_value ) ,
         																																		  self.p_frequency:=right.Count1,
                     			 			                                              self.c_frequency:=left.Count1,
                  																														self.frequency_diff:=left.Count1-right.Count1,
   																																						self.perc_frequency_diff:=if (right.Count1!= 0 and left.Count1=0,1,(left.Count1-right.Count1)/left.Count1),
      																																				self.p_proportion:=right.Count1/count(ds1),
                     			 			                                              self.c_proportion:=left.Count1/count(ds2),
                  																													  self.proportion_diff:=(left.Count1/count(ds2))-(right.Count1/count(ds1)),
   																																						self.abs_proportion_diff:=abs((left.Count1/count(ds2))-(right.Count1/count(ds1))),
   																																						self.perc_proportion_diff:=if (right.Count1!= 0 and left.Count1=0,1,abs(((left.Count1/count(ds2))-(right.Count1/count(ds1)))/(left.Count1/count(ds2))))
   																																						
         																						                        ),full outer
         																																											 );					 
							 
							 
							 
						 
																										 
																																														 
							return choosen(compare_result1,all);			
							
							
							endmacro;

