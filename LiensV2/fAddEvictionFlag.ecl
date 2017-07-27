export fAddEvictionFlag(DATASET(liensv2.Layout_liens_main_module.layout_liens_main) main_file) := function

//////////// add flag
liensv2.Layout_liens_main_module.layout_liens_main addevic(liensv2.Layout_liens_main_module.layout_liens_main L) := transform
	self.eviction := if(regexfind('(EJECT)|(EVICT)', L.filing_type_desc + L.orig_filing_type) and l.eviction = '', 'Y', l.eviction);
	self := l;
end;

flagged_main_file := project(main_file, addevic(left));

//////////// create file name
id := main_file[1].tmsid[1..2];
filename := 'thor_data400::out::liens::eviction_extract_' + id;

//////////// save eviction records in seperate file
output(flagged_main_file(eviction = 'Y'), , filename, overwrite);

//////////// output noneviction records
new_main_file := flagged_main_file(eviction <> 'Y');

return new_main_file;

end;