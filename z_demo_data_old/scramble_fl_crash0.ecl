//export scramble_fl_crash_did := 'todo';

import flaccidents;

file_in:= dataset('~thor::base::demo_data_file_fL_crash0_prodcopy',flaccidents.Layout_FLCrash0,flat);

recordof(file_in) reformat(file_in l):= TRANSFORM
self.accident_nbr := demo_data_scrambler.fn_scramblePII('NUMBER',l.accident_nbr);
self.microfilm_nbr := demo_data_scrambler.fn_scramblePII('NUMBER',l.microfilm_nbr);
self.accident_date := demo_data_scrambler.fn_scramblePII('DOB',l.accident_date);
self.city_town_name := if(l.city_town_name<>'', 'City Name','');
self.st_road_hhwy_name := if(l.st_road_hhwy_name<>'', 'Street 1','');
self.of_intersect_of := if(l.of_intersect_of<>'', 'Street 2','');
self:=l;
END;

scrambled1 := project(file_in,reformat(left));

export scramble_fl_crash0 := scrambled1;
