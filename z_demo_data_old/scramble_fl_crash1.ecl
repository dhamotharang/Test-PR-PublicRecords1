//export scramble_fl_crash_did := 'todo';

import flaccidents;

file_in:= dataset('~thor::base::demo_data_file_fL_crash1_prodcopy',flaccidents.Layout_FLCrash1,flat);

recordof(file_in) reformat(file_in l):= TRANSFORM
self.accident_nbr := demo_data_scrambler.fn_scramblePII('NUMBER',l.accident_nbr);
self.invest_agy_rpt_nbr:='';
self.invest_name:='';
self.invest_rank:='';
self.invest_id_badge_nbr:='';
self.dept_name:='';
self:=l;
END;

scrambled1 := project(file_in,reformat(left));

export scramble_fl_crash1 := scrambled1;


