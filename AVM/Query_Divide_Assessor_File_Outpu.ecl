f := AVM.avm_assessor_out;

total_record_count := count(AVM.avm_assessor_out);
record_count_fourth := round(total_record_count/4);

part1 := choosen(f, record_count_fourth);
part2 := choosen(f, record_count_fourth, record_count_fourth + 1);
part3 := choosen(f, record_count_fourth, (record_count_fourth *2) + 1);
part4 := choosen(f, record_count_fourth + 1, (record_count_fourth *3) + 1);

part1_min_id := min(part1, avm_property_id);
part1_max_id := max(part1, avm_property_id);
part1_min_id;
part1_max_id;

part2_min_id := min(part2, avm_property_id);
part2_max_id := max(part2, avm_property_id);
part2_min_id;
part2_max_id;

part3_min_id := min(part3, avm_property_id);
part3_max_id := max(part3, avm_property_id);
part3_min_id;
part3_max_id;

part4_min_id := min(part4, avm_property_id);
part4_max_id := max(part4, avm_property_id);
part4_min_id;
part4_max_id;

output(part1,,'OUT::AVM_Assessor_1',overwrite);
output(part2,,'OUT::AVM_Assessor_2',overwrite);
output(part3,,'OUT::AVM_Assessor_3',overwrite);
output(part4,,'OUT::AVM_Assessor_4',overwrite);