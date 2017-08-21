import demo_data;
import business_header;

file_in:= dataset('~thor::base::demo_data_file_business_relatives_prodcopy', business_header.Layout_business_relative,flat);

file_in to_fix_bdids(file_in l) := transform
self.bdid1 := IF(l.bdid1 <> 0,(integer)fn_scramblePII('DID',(string)l.bdid1),0);
self.bdid2 := IF(l.bdid2 <> 0,(integer)fn_scramblePII('DID',(string)l.bdid2),0);
self := l;
end;



scrambled := project(file_in, to_fix_bdids(left));


export scramble_business_relatives := dedup(sort(scrambled,record),all);