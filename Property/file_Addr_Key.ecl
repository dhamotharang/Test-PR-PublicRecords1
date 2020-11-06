IMPORT $, dx_Property;

Foreclosure_Address := property.File_Foreclosure_Base_v2(TRIM(foreclosure_id,LEFT,RIGHT) NOT IN Suppress_FID);

slim := PROJECT(Foreclosure_Address, TRANSFORM(dx_Property.Layouts.i_address,
																								//Fields added for delta update project - DF-28049
																								SELF.record_sid				:= LEFT.record_sid;
																								SELF.global_sid				:= LEFT.global_sid;
																								SELF.dt_effective_first	:= 0;
																								SELF.dt_effective_last	:= 0;
																								SELF.delta_ind					:= 0;
																								SELF := LEFT));
																								
cleaned := slim(situs1_zip !='' and 
								situs1_prim_range !='' and 
								situs1_prim_name !='');
								
//should prevent duplicate records within each source but may have duplicates across sources - DF-26073
dedCleaned := DEDUP(SORT(cleaned,foreclosure_id,-process_date),ALL, EXCEPT process_date);

EXPORT file_Addr_Key := dedCleaned;