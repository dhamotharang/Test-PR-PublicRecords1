//export scramble_fl_crash_did := 'todo';

import flaccidents;

file_in:= dataset('~thor::base::demo_data_file_fL_crash6_prodcopy',flaccidents.Layout_FLcrash6_base,flat);

export scramble_fl_crash6 := file_in(false=true);

