Import Data_Services, doxie, ln_property, ut, fcra;


export Key_Property_DID(boolean IsFCRA = false) := function

KeyName 			:= 'thor_data400::key::ln_propertyv2::';
KeyName_fcra  := 'thor_data400::key::ln_propertyv2::fcra::';

file_in := LN_PropertyV2.file_search_building((unsigned)did > 0);
file_dedup := dedup(sort(distribute(file_in, hash(did)), did, ln_fares_id, source_code, local),did, ln_fares_id,source_code, local);

//filtering by [ln_fares_id[1] != 'R'] produces FCRA compliant data
base_file := if(IsFCRA,file_dedup(ln_fares_id[1] !='R'),file_dedup);

key_name := Data_services.Data_location.Prefix('Property') + if(isFCRA, KeyName_fcra, KeyName) + doxie.Version_SuperKey + '::search.did';
									
return_file		:= INDEX(base_file,{s_did := (unsigned)did, string1 source_code_2 := source_code[2]},
											{ln_fares_id,source_code, lname, fname, prim_range, predir, prim_name, suffix, postdir, sec_range, st, p_city_name, zip, county, geo_blk},
											key_name);
													
return(return_file); 		

END;		