import demo_data;
import business_header;

file_in:= dataset('~thor::base::demo_data_file_business_relatives_group_prodcopy', business_header.Layout_business_relative_group,flat);

file_in to_fix_bdids(file_in l) := transform
self.bdid := IF(l.bdid <> 0,(integer)fn_scramblePII('DID',(string)l.bdid),0);
self := l;
end;



scrambled := project(file_in, to_fix_bdids(left));


export scramble_business_relatives_group := dedup(sort(scrambled,record),all);