
import demo_data;
import uccv2;

file_in:= dataset('~thor::base::demo_data_file_uccv2_main_base_prodcopy',uccv2.Layout_UCC_Common.layout_ucc_new,flat);
 
uccv2.layout_ucc_common.layout_ucc_new to_scramble(file_in l) := transform
self.duns_number := stringlib.stringfindreplace(stringlib.stringfindreplace(l.duns_number,'1','3'),'2','4');
self.filing_number := stringlib.stringfindreplace(stringlib.stringfindreplace(l.filing_number,'1','3'),'2','4');
self.orig_filing_number := stringlib.stringfindreplace(stringlib.stringfindreplace(l.orig_filing_number,'1','3'),'2','4');
self.filing_date := l.filing_date[1..7]+'1';
self.orig_filing_date := l.orig_filing_date[1..7]+'1';
self := l;
end;

export scramble_uccv2_main_base := dedup(sort(project(file_in,to_scramble(left )),record),all);
