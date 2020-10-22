EXPORT UI_PSI_Compare_Macro(unique_field, new_input_file_records, old_input_file_records, new_Tag, old_Tag,email_list) := FUNCTIONMACRO


		aa1:=join(new_input_file_records, old_input_file_records,left.#expand(unique_field)=right.#expand(unique_field),inner);

		aa:=aa1(#expand(unique_field)<>'');

		DS1:=join(old_input_file_records,aa,left.#expand(unique_field)=right.#expand(unique_field),inner);

		DS2:=join(new_input_file_records,aa,left.#expand(unique_field)=right.#expand(unique_field),inner);
 
		new_Distribution_report:=Kel_Shell_QA_UI.Distribution_Module_call(unique_field, DS2, new_Tag);
		old_Distribution_report:=Kel_Shell_QA_UI.Distribution_Module_call(unique_field, DS1, old_Tag);
		
		
		Layout_file2:=RECORD
			string attribute;
			string category;
			STRING SourceDescription;
			string distribution_type;
			string attribute_value;
			integer8 result_cnt;
			decimal10_4 result_perc;
			END;

    score_file_current:=	project(new_Distribution_report,transform({Layout_file2;integer8 file_count; integer8 ds_count;},
                          self.ds_count:=count(DS2);	
													self.file_count:=count(DS2);	
													self:=left;
													)); 
													
	  score_file_previous:=	project(old_Distribution_report,transform({Layout_file2;integer8 file_count; integer8 ds_count;},
                          self.ds_count:=count(DS1);
												  self.file_count:=count(DS1);	
													self:=left;
													)); 
		
	  compare_layout := RECORD
			// string file_version;
			// string mode;
			string Previous_file;
			string current_file;
			decimal20_4 p_file_count;
			decimal20_4 c_file_count;
			decimal20_4 file_count_diff;
			decimal20_4 matched_file_count;
			string attribute;
			string Category;
			STRING SourceDescription;
			string distribution_type;
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
						 
    final_results:= join(score_file_current,score_file_previous,
										 // left.file_version = right.file_version and
								      left.attribute = right.attribute and
											left.Category = right.Category and
											left.SourceDescription = right.SourceDescription and
											left.distribution_type = right.distribution_type and
											left.attribute_value = right.attribute_value 
											,transform(	compare_layout,
													 // self.file_version:=  if(left.file_version='',right.file_version,left.file_version),
													 // self.mode:=   if(left.mode='',right.mode,left.mode),
													 self.Previous_file:= old_Tag;
													 self.current_file:= new_Tag;
													 self.attribute:=if(left.attribute='',right.attribute,left.attribute),
													 self.Category:=if(left.Category='',right.Category,left.Category),
													 self.SourceDescription:=if(left.SourceDescription='',right.SourceDescription,left.SourceDescription),
													 self.distribution_type:=if(left.distribution_type='',right.distribution_type,left.distribution_type),
													 self.p_file_count:= count(old_input_file_records),
													 self.c_file_count:= count(new_input_file_records),
													 self.file_count_diff:=  count(new_input_file_records)-count(old_input_file_records),
													 self.matched_file_count:=count(DS1);
													 self.attribute_value:=if(left.attribute_value='',right.attribute_value,left.attribute_value),
													 self.p_frequency:=right.result_cnt,
													 self.c_frequency:=left.result_cnt,
													 self.frequency_diff:=left.result_cnt-right.result_cnt,
													 self.perc_frequency_diff:=if(left.result_cnt!= 0 and right.result_cnt=0,1,(left.result_cnt-right.result_cnt)/right.result_cnt),
													 self.p_proportion:=right.result_cnt/right.ds_count,
													 self.c_proportion:=left.result_cnt/left.ds_count,
													 self.proportion_diff:=(left.result_cnt/left.ds_count)-(right.result_cnt/right.ds_count),
													 self.abs_proportion_diff:=abs((left.result_cnt/left.ds_count)-(right.result_cnt/right.ds_count)),
													 self.perc_proportion_diff:=if(left.result_cnt!= 0 and right.result_cnt=0,1,((left.result_cnt/left.ds_count)-(right.result_cnt/right.ds_count))/(right.result_cnt/right.ds_count)),
													self.PSI := ((right.result_cnt/right.ds_count)-(left.result_cnt/left.ds_count))*ln(((right.result_cnt/right.ds_count)/(left.result_cnt/left.ds_count)))
						),full outer );

  
   	rd := record
   // final_results.file_version;
   // final_results.mode;
    final_results.attribute;
    final_results.distribution_type;
    sumofPSI := sum(group, final_results.PSI);
   			// MAP(STD.Str.find(final_results.attribute_value, 'Count', 1) > 0 =>  final_results.p_proportion,
   									// STD.Str.find(final_results.attribute_value, 'Avg', 1) > 0 =>  final_results.p_proportion,
   									// sum(group, final_results.p_proportion));
    END;	
    
    tb := table(final_results, rd,final_results.attribute,final_results.distribution_type); 
   
    compare_layout_3 := RECORD
			// string file_version;
			// string mode;
			string Previous_file;
			string current_file;
			decimal20_4 p_file_count;
			decimal20_4 c_file_count;
			decimal20_4 file_count_diff;
			decimal20_4 matched_file_count;
			string100 attribute;
			string Category;
			string SourceDescription;
			string30 distribution_type;
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
       
    jn := JOIN(final_results, tb,left.attribute = right.attribute and
		                             // left.Category = right.Category and
																 left.distribution_type = right.distribution_type ,
                TRANSFORM(compare_layout_3,
								// self.distribution_type:=if(left.distribution_type='range' and (not RegexFind('[-~!@&%#$^*()_=+?<>,/"{}|]',TRIM(left.attribute_value,LEFT,RIGHT))
								                                                              // or (integer)left.attribute_value <=-1 )								                                                          
								                           // ,'distinct',left.distribution_type);
																					 
							  self.distribution_type:=left.distribution_type;
								self.attribute_value:=if(left.attribute_value='average' or left.attribute_value='0-9999999999','',left.attribute_value);												 
      					self.sumofPSI := right.sumofPSI;
      					self.warning_flag := If(right.sumofPSI > 0.1 , 1, 0);
      					self := left;
								));
         	      			 

	  dedup_jn:=dedup(jn,all);																																				 
		
		final_PSI_output:=choosen(sort(dedup_jn,attribute,distribution_type,attribute_value),all);	
		
	  //RETURN final_PSI_output;					

result1:=STD.System.Email.SendEmail(email_list, 'KAT Notification',  'Your compare job has kicked-off. Your WUID is ' + workunit + ' .');

// result2:=output(final_PSI_output);

result3:=STD.System.Email.SendEmail(email_list, 'KAT Notification',  'Your compare job has completed. Your WUID is ' + workunit + ' .' + '\n You can see the results here. \n http://alawqpnc018.risk.regn.net/KAT/ ');

seq:=sequential(result1,output(final_PSI_output), result3);

RETURN seq;
							
ENDMACRO;