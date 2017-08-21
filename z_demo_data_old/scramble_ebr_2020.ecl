
import demo_data;
import ebr;
/* missed this on base file, null dataset for now.

file_in:= dataset('~thor::base::demo_data_file_ebr_2020_prodcopy',ebr.Layout_2020_Trade_Payment_Trends_Base,flat);

file_in to_finish(file_in l) := transform
self.file_number := demo_data_scrambler.fn_scramblePII('NUMBER',l.file_number);
self.bdid := (integer) demo_data_scrambler.fn_scramblePII('DID',(string) l.bdid );
self := l;
end;

scrambled := project(file_in, to_finish(left));
*/
export scramble_ebr_2020  := dataset([],ebr.Layout_2020_Trade_Payment_Trends_Base); 

