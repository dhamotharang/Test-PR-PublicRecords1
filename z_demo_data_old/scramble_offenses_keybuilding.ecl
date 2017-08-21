import demo_data;
import corrections;

file_in:= dataset('~thor::base::demo_data_file_offenses_keybuilding_prodcopy', corrections.layout_offense,flat);

export scramble_offenses_keybuilding  := dedup(sort(file_in,record),all);

