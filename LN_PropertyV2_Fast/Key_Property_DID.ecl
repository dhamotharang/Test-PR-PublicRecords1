Import Data_Services, doxie, ln_property, ut, fcra,LN_PropertyV2;


export Key_Property_DID(boolean IsFCRA = false, boolean isFast = false) := function

keyPrefix			:= if(isFast,'property_fast','ln_propertyv2');

KeyName 			:= 'thor_data400::key::'+keyPrefix+'::';
KeyName_fcra  := 'thor_data400::key::'+keyPrefix+'::fcra::';

file_in0	:= LN_PropertyV2_Fast.CleanSearch(false);
file_in1	:= LN_PropertyV2_Fast.CleanSearch(true, true);

file_in2	:= if(isFast,file_in1,file_in0);

file_in := file_in2((unsigned)did > 0);
file_dedup := dedup(sort(distribute(file_in, hash(did)), did, ln_fares_id, source_code, local),did, ln_fares_id,source_code, local);

//filtering by [ln_fares_id[1] != 'R'] produces FCRA compliant data
//base_file := if(IsFCRA,file_dedup(ln_fares_id[1] !='R'),file_dedup);
LN_PropertyV2_Fast.FCRA_compliance_MAC(isFCRA,file_dedup,file_out);
base_file := file_out;

key_name := Constants.keyServerPointer+ if(isFCRA, KeyName_fcra, KeyName) + doxie.Version_SuperKey + '::search.did';
									
return_file		:= INDEX(base_file,{s_did := (unsigned)did, string1 source_code_2 := source_code[2]},
											{ln_fares_id,source_code, lname, fname, prim_range, predir, prim_name, suffix, postdir, sec_range, st, p_city_name, zip, county, geo_blk},
											key_name);
													
return(return_file); 		

END;		