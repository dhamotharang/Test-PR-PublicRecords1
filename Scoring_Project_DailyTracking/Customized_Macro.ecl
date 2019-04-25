EXPORT Customized_Macro( dInput) :=  functionmacro

import ut, std;
																						
import SALT23;

 Data_Layout := RECORD
 string100 Field_Name;
  SALT23.StrType field_value{ MAXLENGTH(200000) };
 END;
		
  loadxml('<xml/>');
  // counter used in choose() later on
  #declare(field_values) #set(field_values,'counter')
	#declare(field_set) #set(field_set,'counter')
  // Count of the input data fields
  #declare(field_cnt) #set(field_cnt,0)
  #exportxml(fields,recordof(dInput))

  #for(fields)
    #for(field)
			#append(field_values,',(string)left.'+%'{@label}'%)
			#set(field_cnt,%field_cnt%+1)
			#append(field_set, ',\''+%'{@label}'%+'\'')
    #end
  #end
	
	#if (%field_cnt% = 0)
		return 'No input given';
	#end
	
	#if (%field_cnt% > 0)
  // Produce the output, with one row for every field/column.
	#uniquename(d_norm)
  %d_norm%:=
		normalize(dInput,
		          %field_cnt%,
	            transform(Data_Layout,
							self.Field_Name:= choose(%field_set%),
							self.field_value:=choose(#expand(%'field_values'%))
							));

	d_norm1 := %d_norm%;
	#end


	BOOLEAN normal_stats := TRUE;
	// BOOLEAN normal_stats := FALSE;

	
	// NICK is just excluding <blank> and -1.
	ds_slim := IF(normal_stats,
									// d_norm1( TRIM((STRING)field_value, LEFT, RIGHT) NOT IN ['', '-1', '-']),
									d_norm1( TRIM((STRING)field_value, LEFT, RIGHT) NOT IN ['', '-1', '-']),
									d_norm1( TRIM((STRING)field_value, LEFT, RIGHT) NOT IN ['', '-1', '0']));


tb1 := table(ds_slim, {ds_slim.Field_Name; 
												mean := AVE(group, (real)ds_slim.field_value);
												std_dev := SQRT(VARIANCE(group, (real)ds_slim.field_value));
												} ,ds_slim.Field_Name);
					
d_norm_test_lay:=record
					 string100 Field_Name2;
           SALT23.StrType field_value2{ MAXLENGTH(200000) };
end;
					d_norm_test:=project(d_norm1,transform(d_norm_test_lay,self.Field_Name2:=left.Field_Name;self.field_value2:=left.field_value;
					                                       ));
																								 
	median_rec := RECORD
   d_norm_test.Field_Name2;
   StCnt := d_norm_test[(integer)((count(d_norm_test)+1)/2)].field_value2;//median
   StCnt2 := d_norm_test[(integer)((count(d_norm_test)+1)/4)].field_value2;//q1
   StCnt3 := d_norm_test[(integer)((count(d_norm_test)+1)/4)*3].field_value2;//q3
   END;
    median_ds:= TABLE(d_norm_test,median_rec,Field_Name2);																			 
												
//You have to add math stats in the table below
tb := table(d_norm1, {d_norm1.Field_Name; 

												miss_rate := COUNT(group, d_norm1.field_value = '') / count(dInput) ;
												zero_rate := COUNT(group, d_norm1.field_value = '0')  / count(dInput); 
												neg_one_rate := COUNT(group, d_norm1.field_value = '-1')  / count(dInput);
												median := '';
												Q1 := '';
												Q3 := '';
												Minimum := min(group, (real)d_norm1.field_value);
												Maximum := Max(group, (real)d_norm1.field_value);				
												hit_rate := 	(count(dInput) - 	COUNT(group, d_norm1.field_value = '') -
																												COUNT(group, d_norm1.field_value = '0') -
																												COUNT(group, d_norm1.field_value = '-1') )/ count(dInput);
												} ,d_norm1.Field_Name);



	stats_layout := RECORD
		STRING name;
		REAL mean;
		REAL Minimum; // placeholder for future use 
	 REAL Q1; // placeholder for future use
	 // REAL Q2; // placeholder for future use
		REAL median; // placeholder for future use
	 REAL Q3; // placeholder for future use		
		REAL Maximum; // placeholder for future use
		REAL std_dev;
		REAL miss_rate;
		REAL zero_rate;
		REAL neg_one_rate;

		REAL hit_rate;
END;			

final_join := JOIN(tb, tb1, left.Field_Name = right.Field_Name, TRANSFORM(stats_layout, self.name := right.Field_Name;
																																								self.mean := right.mean;
																																								self.Q1 := (real)left.Q1;  // placeholder for future use
																																								self.median := (real)left.median;  // placeholder for future use
																																								self.Q3 := (real)left.Q3;  // placeholder for future use																																						
																																								self.Minimum := (real)left.Minimum;  // placeholder for future use
																																								self.Maximum := (real)left.Maximum;  // placeholder for future use
																																								self.std_dev := right.std_dev;
																																								self := left;));
					
																																								
final_join2 := JOIN(final_join, dedup(sort(d_norm_test,(real)Field_Name2,(real)field_value2),(real)Field_Name2), left.name = right.Field_Name2, TRANSFORM(stats_layout, 
																																self.median := (real)sort(d_norm_test(Field_Name2=left.name),(real)field_value2)[(integer)((count(d_norm_test(Field_Name2=left.name))+1)/2)].field_value2;
																																self.Q3 := (real)sort(d_norm_test(Field_Name2=left.name),(real)field_value2)[(integer)((count(d_norm_test(Field_Name2=left.name))+1)/4)*3].field_value2;
																																self.Q1 := (real)sort(d_norm_test(Field_Name2=left.name),(real)field_value2)[(integer)((count(d_norm_test(Field_Name2=left.name))+1)/4)].field_value2;
																																								self := left;),left outer);
																																								
																																					
		// output(final_join, named('output_no_median'));				
		// output(d_norm_test, named('output_d_norm_test'));				
return final_join2 ;

endmacro;