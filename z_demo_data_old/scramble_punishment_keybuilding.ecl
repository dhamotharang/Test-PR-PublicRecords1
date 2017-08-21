import demo_data;
import corrections;

file_in:= dataset('~thor::base::demo_data_file_punishment_keybuilding_prodcopy', corrections.layout_crimpunishment,flat);

export scramble_punishment_keybuilding  := dedup(sort(file_in,record),all);

