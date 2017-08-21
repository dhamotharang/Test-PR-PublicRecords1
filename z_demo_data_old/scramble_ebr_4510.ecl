
import demo_data;
import ebr;

file_in:= dataset('~thor::base::demo_data_file_ebr_4510_prodcopy',ebr.Layout_4510_UCC_Filings_Base,flat);
//
//
file_in to_finish(file_in l) := transform
self.file_number := demo_data_scrambler.fn_scramblePII('NUMBER',l.file_number);
self.bdid := (integer) demo_data_scrambler.fn_scramblePII('DID',(string) l.bdid );
self.secured_party :='';
self.assignee := '';
self.DOCUMENT_NUMBER := demo_data_scrambler.fn_scramblePII('CHARS',l.document_number);
self.orig_file_number := demo_data_scrambler.fn_scramblePII('CHARS',l.orig_file_number);
self.date_filed := demo_data_scrambler.fn_scramblePII('DOB',l.date_filed);
self := l;
end;

scrambled := project(file_in, to_finish(left));

export scramble_ebr_4510  := scrambled;


 