EXPORT Compare_Results_macro( dInput) := functionmacro

// EXPORT Customized_Macro( dInput) := functionmacro

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


	// BOOLEAN normal_stats := TRUE;
	// BOOLEAN normal_stats := FALSE;
	
	// NICK is just excluding <blank> and -1.
	// ds_slim := IF(normal_stats,
									// d_norm1( (STRING)field_value NOT IN ['']),
									// d_norm1( TRIM((STRING)field_value, LEFT, RIGHT) NOT IN ['', '-1', '0']));

	// slim_count2 := COUNT(ds_slim.field_value);
// integer mid_count2 := (slim_count2 / 2);
	// sorted_ds2 := SORT(ds_slim, -field_value);
	// medn2 := sorted_ds2[mid_count2];


	// temp_median2 := (REAL)medn2.field_value;			

tb1 := table(d_norm1, {d_norm1.Field_Name; 
												mean := AVE(group, (integer)d_norm1.field_value);
												std_dev := SQRT(VARIANCE(group, (real)d_norm1.field_value));
												// median1 := 	slim_count2;
												// median2 := 	mid_count2;
												// median := 	group( medn2.field_value);
												// median := 	;
												
												} ,d_norm1.Field_Name);

	// slim_count2 := COUNT(group);
// mid_count2 := (slim_count2/2);
	// sorted_ds2 := SORT(group, -ds_slim.field_value);
	// medn2 := sorted_ds2[mid_count2];


	// temp_median2 := (REAL)medn2.field_value;													
												

												
												
//You have to add math stats in the table below
tb := table(d_norm1, {d_norm1.Field_Name; 
												// mean := AVE(group, (integer)d_norm1.field_value);
												// std_dev := SQRT(VARIANCE(group, (real)d_norm1.field_value));
												miss_rate := COUNT(group, (integer)d_norm1.field_value < 300) / count(dInput) ;
												// zero_rate := COUNT(group, d_norm1.field_value = '0')  / count(dInput); 
												// neg_one_rate := COUNT(group, d_norm1.field_value = '-1')  / count(dInput);
												// hit_rate := 	(count(dInput) - 	COUNT(group, d_norm1.field_value = '') -
												hit_rate := 	count(group,(integer)d_norm1.field_value > 300)/ count(dInput);
												} ,d_norm1.Field_Name);
	// temp_median2 := (REAL)medn2.#expand(at_name);			

		// self.median_abs_dev := 	(1/full_count)*sum(ds, abs((REAL) #expand(at_name) - temp_median2));


	stats_layout := RECORD
		STRING name;
		REAL mean;
		// REAL median; // placeholder for future use
		REAL std_dev;
		REAL miss_rate;
				// real Median;
				// real Median1;
				// real Median2;

		// REAL zero_rate;
		// REAL neg_one_rate;
		REAL hit_rate;
END;			

final_join := JOIN(tb, tb1, left.Field_Name = right.Field_Name, TRANSFORM(stats_layout, self.name := right.Field_Name;
																																								self.mean := right.mean;
																																								// self.Median1 := right.Median1;  // placeholder for future use
																																								// self.Median2 := right.Median2;  // placeholder for future use
																																								// self.Median := right.Median;  // placeholder for future use
																																								self.std_dev := right.std_dev;
																																								self := left;));
																																								

return final_join ;

endmacro;	
