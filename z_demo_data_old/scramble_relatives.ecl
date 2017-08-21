import demo_data, header;

file_in:= dataset('~thor::base::demo_data_file_relatives_prodcopy', header.Layout_relatives,flat);

/*
For this file we will NOT USE the macro as the 
only fields  to scramble are 2 DID is front person1 and person2
we will use the DID scramble function here;
*/

recordof(file_in) scrambleDID(file_in l):= TRANSFORM
self.person1 := (Integer)fn_scramblePII('DID',(String)l.person1);// Check if this is going to be truncated
self.person2 := (Integer)fn_scramblePII('DID',(string)l.person2);
self := l;

END;

export scramble_relatives := dedup(sort(project(file_in, scrambleDID(LEFT)),record),all);