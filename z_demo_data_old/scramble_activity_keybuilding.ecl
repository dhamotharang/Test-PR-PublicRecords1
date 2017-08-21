import demo_data;
import corrections;

file_in:= dataset('~thor::base::demo_data_file_activity_keybuilding_prodcopy', corrections.layout_activity,flat);

export scramble_activity_keybuilding  := dedup(sort(file_in,record),all);

