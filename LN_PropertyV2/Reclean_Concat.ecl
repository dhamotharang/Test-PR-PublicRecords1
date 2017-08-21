import ut;

ds_assess 	:= LN_PropertyV2.Reclean_Assessor;//dataset('~thor_dell400::persist::File_Assessment_dedup',LN_PropertyV2.layout_deed_mortgage_property_search,flat);
ds_deed		:= LN_PropertyV2.Reclean_Deed;//dataset('~thor_dell400::persist::File_Deed_dedup',LN_PropertyV2.layout_deed_mortgage_property_search,flat);
ds_search 	:= dataset(ut.foreign_prod+'~thor_data400::in::ln_propertyv2::search',LN_PropertyV2.layout_deed_mortgage_property_search,flat);

ds_concat	:= ds_assess + ds_deed + ds_search;
output(count(ds_concat));

ds_dedup	:= dedup(sort(distribute(ds_concat,hash(ln_fares_id,source_code)),
					ln_fares_id,source_code,title,fname,mname,lname,name_suffix,cname,nameasis,
					prim_range,predir,prim_name,suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,zip,zip4,local),
					ln_fares_id,source_code,title,fname,mname,lname,name_suffix,cname,nameasis,
					prim_range,predir,prim_name,suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,zip,zip4,local) : PERSIST('~thor_dell400::persist::ln_propertyv2_search_reclean_dedup');
					
//ds_output	:= output(ds_dedup,,'~thor_data400::in::ln_propertyv2::search_reclean',overwrite);
					
export Reclean_Concat := ds_dedup;