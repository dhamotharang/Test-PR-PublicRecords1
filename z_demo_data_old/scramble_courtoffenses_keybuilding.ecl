import demo_data;
import corrections;

file_in:= dataset('~thor::base::demo_data_file_courtoffenses_keybuilding_prodcopy', corrections.layout_CourtOffenses,flat);

export scramble_courtoffenses_keybuilding  := dedup(sort(file_in,record),all);

