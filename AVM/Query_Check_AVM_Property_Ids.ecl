search_file := dataset('~thor_dell400_2::temp::avm_search', AVM.Layout_AVM_Search, flat);
count(search_file);

demo_file := AVM.File_Demo_Counties_With_Addr;
count(demo_file);
output(demo_file);

// match property ids

layout_demo_property_id := record
unsigned6 avm_property_id := (unsigned6)demo_file.AVMPropertyId;
end;

demo_file_ids := table(demo_file, layout_demo_property_id);
count(demo_file_ids);

demo_file_ids_dedup := dedup(demo_file_ids, all);
count(demo_file_ids_dedup);

layout_search_property_id := record
search_file.avm_property_id;
end;

search_file_ids := table(search_file, layout_search_property_id);
count(search_file_ids);

search_file_ids_dedup := dedup(search_file_ids, all);
count(search_file_ids_dedup);

demo_match := join(search_file_ids_dedup,
                   demo_file_ids_dedup,
			    left.avm_property_id = right.avm_property_id,
			    transform(layout_search_property_id, self := left),
			    hash);
			    
count(demo_match);

sample_demo_ids := enth(demo_file_ids_dedup, 100);

// Get demo file data

sample_demo_data := join(demo_file,
                         sample_demo_ids,
					(unsigned6)left.AVMPropertyId = right.avm_property_id,
					transform(AVM.Layout_Demo_Counties_With_Addr, self := left),
					lookup);
					
output(sort(sample_demo_data, (unsigned6)AVMPropertyId), all);

// Get search file data
sample_search_data := join(search_file,
                           sample_demo_ids,
					  left.avm_property_id = right.avm_property_id,
					  transform(AVM.Layout_AVM_Search, self := left),
					  lookup);

output(sort(sample_search_data, avm_property_id), all);

deeds_file := dataset('~thor_dell400_2::temp::avm_deeds_out', AVM.Layout_AVM_Deed, flat);

sample_deeds_data := join(deeds_file,
                           sample_demo_ids,
					  (unsigned6)left.avm_property_id = right.avm_property_id,
					  transform(AVM.Layout_AVM_Deed, self := left),
					  lookup);

output(sample_deeds_data, all);

assessors_file := dataset('~thor_dell400_2::temp::avm_assessor_out', AVM.Layout_AVM_Assessor, flat);

sample_assessors_data := join(assessors_file,
                           sample_demo_ids,
					  (unsigned6)left.avm_property_id = right.avm_property_id,
					  transform(AVM.Layout_AVM_Assessor, self := left),
					  lookup);

output(sample_assessors_data, all);

assessors_append_file := dataset('~thor_dell400_2::temp::avm_assessor_append_out', AVM.Layout_AVM_Assessor_Append, flat);

sample_assessors_append_data := join(assessors_append_file,
                                     sample_demo_ids,
					            (unsigned6)left.avm_property_id = right.avm_property_id,
					            transform(AVM.Layout_AVM_Assessor_Append, self := left),
					            lookup);

output(sample_assessors_append_data, all);

