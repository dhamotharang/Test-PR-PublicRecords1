import demo_data;
import corp2;

file_in:= dataset('~thor::base::demo_data_file_eventdata_prodcopy',Corp2.Layout_Corporate_Direct_event_Base ,flat);


file_in to_fix_bdids(file_in l) := transform
self.bdid := IF(l.bdid <> 0,(integer)fn_scramblePII('DID',(string)l.bdid),0);
self := l;
end;


scrambled := project(file_in, to_fix_bdids(left));


export scramble_eventdata  := dedup(sort(scrambled,record),all);

