EXPORT Customized_Macro( dInput) := functionmacro

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
									d_norm1( TRIM((STRING)field_value, LEFT, RIGHT) NOT IN ['', '-1', '-']),
									d_norm1( TRIM((STRING)field_value, LEFT, RIGHT) NOT IN ['', '-1', '0']));

//median 
//count group +1/2
//sort and choosen th value
//if(count(ds_temp2) <> 0, sort(ds_temp2, abs_diff)  [(integer)((count(ds_temp2)+1)/2)].abs_diff, 0);
// med2 := sort(ds_slim, field_value)[(integer)((count(ds_slim)+1)/2)].field_value;

tb1 := table(ds_slim, {ds_slim.Field_Name; 
												mean := AVE(group, (integer)ds_slim.field_value);
												std_dev := SQRT(VARIANCE(group, (real)ds_slim.field_value));
												// median := if(count(group, ds_slim.field_value) <> 0, sort(group, ds_slim.field_value)[(integer)((count(group)+1)/2)].ds_slim.field_value,0);
												// median :=  group(sort(ds_slim, field_value)[(integer)((count(ds_slim)+1)/2)], ds_slim.field_value);
												// median :=  group(sort(ds_slim, field_value)[(integer)((count(ds_slim)+1)/2)], ds_slim.field_value);
												// median :=  sort(group, ds_slim.field_value)[(integer)((count(group)+1)/2)].field_value);
												// median := group(med2,ds_slim.field_value);

												} ,ds_slim.Field_Name);
												
												
//You have to add math stats in the table below
tb := table(d_norm1, {d_norm1.Field_Name; 
												// mean := AVE(group, (integer)d_norm1.field_value);
												// std_dev := SQRT(VARIANCE(group, (real)d_norm1.field_value));
												miss_rate := COUNT(group, d_norm1.field_value = '') / count(dInput) ;
												zero_rate := COUNT(group, d_norm1.field_value = '0')  / count(dInput); 
												neg_one_rate := COUNT(group, d_norm1.field_value = '-1')  / count(dInput);
												// median :=  sort(group, d_norm1.field_value)[(integer)((count(d_norm1)+1)/2)].field_value);
												// median :=  sort(group, d_norm1.field_value)  [(integer)((count(group)+1)/2)].field_value;
												// Minimum := min(group, field_value);
												// Maximum := max(group, field_value);
												hit_rate := 	(count(dInput) - 	COUNT(group, d_norm1.field_value = '') -
																												COUNT(group, d_norm1.field_value = '0') -
																												COUNT(group, d_norm1.field_value = '-1') )/ count(dInput);
												} ,d_norm1.Field_Name);



	stats_layout := RECORD
		STRING name;
		REAL mean;
		// REAL median; // placeholder for future use
		REAL Minimum; // placeholder for future use
		REAL Maximum; // placeholder for future use
		REAL std_dev;
		REAL miss_rate;
		REAL zero_rate;
		REAL neg_one_rate;
		REAL hit_rate;
END;			

final_join := JOIN(tb, tb1, left.Field_Name = right.Field_Name, TRANSFORM(stats_layout, self.name := right.Field_Name;
																																								self.mean := right.mean;
																																								// self.median := (real)left.median;  // placeholder for future use
																																								self.std_dev := right.std_dev;
																																								self := left;));
																																								

return final_join ;

endmacro;	
