﻿
EXPORT compare_function_nonfcra_fpscores_v2(current_dt,previous_dt) :=  functionmacro

nonfcra_fpscores_v2_layout:=RECORD
  string30 accountnumber;
  string3 fp_score;
  string3 fp_reason;
  string3 fp_reason2;
  string3 fp_reason3;
  string3 fp_reason4;
  string3 fp_reason5;
  string3 fp_reason6;
 END;



DS1:= dataset('~foreign::10.241.3.238::sghatti::out::nonfcra_fpscores_v2_'+previous_dt, nonfcra_fpscores_v2_layout,


 CSV(HEADING(single), QUOTE('"')));
DS2:= dataset('~foreign::10.241.3.238::sghatti::out::nonfcra_fpscores_v2_'+current_dt,nonfcra_fpscores_v2_layout,


 CSV(HEADING(single), QUOTE('"')));

	 
    	 
      	
				RiskView_Attributes_Reports.count_function(DS1,'fp_reason',c13);
      	RiskView_Attributes_Reports.count_function(DS1,'fp_reason2',c14);
      	RiskView_Attributes_Reports.count_function(DS1,'fp_reason3',c15);
				RiskView_Attributes_Reports.count_function(DS1,'fp_reason4',c16);
				RiskView_Attributes_Reports.count_function(DS1,'fp_reason5',c17);
				RiskView_Attributes_Reports.count_function(DS1,'fp_reason6',c18);
				
				tr:= c13 + c14 + c15 + c16 + c17 + c18;

RiskView_Attributes_Reports.count_function1(tr,'reason_code',tr_1);

      	
						 
				score_file1:=tr_1 ;
						 
			////////////////////////////////////////////////////////////
			////////////////////////////////////////////////////////////////
			//////////////////////////////////////////////////////////////////
			
			
	
		
				RiskView_Attributes_Reports.count_function(DS2,'fp_reason',cc13);
      	RiskView_Attributes_Reports.count_function(DS2,'fp_reason2',cc14);
      	RiskView_Attributes_Reports.count_function(DS2,'fp_reason3',cc15);
				RiskView_Attributes_Reports.count_function(DS2,'fp_reason4',cc16);
		    RiskView_Attributes_Reports.count_function(DS2,'fp_reason5',cc17);
		    RiskView_Attributes_Reports.count_function(DS2,'fp_reason6',cc18);
				
						tr2:= cc13 + cc14 + cc15 + cc16 + cc17 + cc18;

RiskView_Attributes_Reports.count_function1(tr2,'reason_code',tr_2);

      	
						 
						score_file2:=	tr_2;	 
						 
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
																										self.file_version:='nonfcra_fpscores_v2',
																										self.mode:='xml',
																										                          self.field_name:=if(left.field_name='',right.field_name,left.field_name),
																																							self.p_file_count:=count(ds1),
																																							self.c_file_count:=count(ds2),
																																							self.file_count_diff:=count(ds2)-count(ds1),
                     			 			                                          	  self.reason_code:=if(left.attribute_value='',right.attribute_value,left.attribute_value),
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

