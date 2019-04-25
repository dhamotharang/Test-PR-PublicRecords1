﻿
EXPORT compare_function_nonfcra_liscores_v4_msn1106(current_dt,previous_dt)  :=  functionmacro

nonfcra_liscores_v4_msn1106_layout:=RECORD
  string20 seq;
  string30 accountnumber;
  string name;
  string3 score;
  string2 rc1;
  string2 rc2;
  string2 rc3;
  string2 rc4;
  string6 historydate;
  unsigned6 did;
  boolean fnamepop;
  boolean lnamepop;
  boolean addrpop;
  string1 ssnlength;
  boolean dobpop;
  boolean emailpop;
  boolean ipaddrpop;
  boolean hphnpop;
 END;


DS1:= dataset('~foreign::10.241.3.238::sghatti::out::nonfcra_liscores_v4_msn1106_0'+previous_dt, nonfcra_liscores_v4_msn1106_layout,


 CSV(HEADING(single), QUOTE('"')));
DS2:= dataset('~foreign::10.241.3.238::sghatti::out::nonfcra_liscores_v4_msn1106_0'+current_dt,nonfcra_liscores_v4_msn1106_layout,


 CSV(HEADING(single), QUOTE('"')));
	
	 
    	 
      	
				RiskView_Attributes_Reports.count_function(DS1,'rc1',c13);
      	RiskView_Attributes_Reports.count_function(DS1,'rc2',c14);
      	RiskView_Attributes_Reports.count_function(DS1,'rc3',c15);
				RiskView_Attributes_Reports.count_function(DS1,'rc4',c16);
				// RiskView_Attributes_Reports.count_function(DS1,'rv_telecom_reason5',c17);
				
				tr:= c13 + c14 + c15 + c16;

RiskView_Attributes_Reports.count_function1(tr,'reason_code',tr_1);

      	
						 
				score_file1:=tr_1 ;
						 
			////////////////////////////////////////////////////////////
			////////////////////////////////////////////////////////////////
			//////////////////////////////////////////////////////////////////
			
			
	
		
				RiskView_Attributes_Reports.count_function(DS2,'rc1',cc13);
      	RiskView_Attributes_Reports.count_function(DS2,'rc2',cc14);
      	RiskView_Attributes_Reports.count_function(DS2,'rc3',cc15);
				RiskView_Attributes_Reports.count_function(DS2,'rc4',cc16);
		    // RiskView_Attributes_Reports.count_function(DS2,'rv_telecom_reason5',cc17);
		
						tr2:= cc13 + cc14 + cc15 + cc16 ;

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
																										self.file_version:='nonfcra_liscores_v4_msn1106',
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

