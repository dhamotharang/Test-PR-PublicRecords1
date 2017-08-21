
import demo_data;
import cellphone;

file_in:= dataset('~thor::base::demo_data_file_neustar_prodcopy',cellphone.layoutNeuStar,flat);

recordof(file_in) to_scramble(file_in l) := transform
self.cellphone := demo_data_scrambler.fn_scramblePII('phone',l.cellphone);
self := l;
end;

export scramble_neustar := dedup(sort(project(file_in,to_scramble(left)),record),all);