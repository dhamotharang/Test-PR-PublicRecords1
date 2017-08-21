
import demo_data;
import ebr;

file_in:= dataset('~thor::base::demo_data_file_ebr_4020_prodcopy',ebr.Layout_4020_Tax_Liens_Base,flat);
//
file_in to_finish(file_in l) := transform
self.file_number := demo_data_scrambler.fn_scramblePII('NUMBER',l.file_number);
self.bdid := (integer) demo_data_scrambler.fn_scramblePII('DID',(string) l.bdid );
self.document_number := '12345-2';
self.date_filed := demo_data_scrambler.fn_scramblePII('DOB',l.date_filed);
self := l;
end;

scrambled := project(file_in, to_finish(left));

export scramble_ebr_4020  := scrambled;