
import demo_data;
import ebr;

file_in:= dataset('~thor::base::demo_data_file_ebr_4030_prodcopy',ebr.Layout_4030_Judgement_Base,flat);
//
file_in to_finish(file_in l) := transform
self.file_number := demo_data_scrambler.fn_scramblePII('NUMBER',l.file_number);
self.bdid := (integer) demo_data_scrambler.fn_scramblePII('DID',(string) l.bdid );
self.document_number := '12345-2';
self.date_filed := demo_data_scrambler.fn_scramblePII('DOB',l.date_filed);
self := l;
end;

scrambled := project(file_in, to_finish(left));

export scramble_ebr_4030  := scrambled;