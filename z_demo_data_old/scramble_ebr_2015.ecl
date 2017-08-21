
import demo_data;
import ebr;

file_in:= dataset('~thor::base::demo_data_file_ebr_2015_prodcopy',ebr.Layout_2015_Trade_Payment_Totals_Base,flat);
//
file_in to_finish(file_in l) := transform
self.file_number := demo_data_scrambler.fn_scramblePII('NUMBER',l.file_number);
self.bdid := (integer) demo_data_scrambler.fn_scramblePII('DID',(string) l.bdid );
self := l;
end;

scrambled := project(file_in, to_finish(left));

export scramble_ebr_2015  := scrambled; 

