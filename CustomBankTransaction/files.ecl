import custombanktransaction,ut;

EXPORT files := module

export file_in := dataset('~thor_data400::in::chase_sample_0719',layouts.layout_in, csv(heading(1),separator([',']),terminator(['\n','\r\n']),Quote(['\"'])));
export new_file_in := dataset('~thor_data400::in::chase_sample_1101',layouts.new_layout_in, csv(heading(1),separator(['Ã‡']),terminator(['\n','\r\n']),Quote(['\"'])));
//export full_file_in := dataset('~thor_data400::in::chase_sample_1119',layouts.new_layout_in, csv(heading(1),separator(['Ã‡']),terminator(['\n','\r\n']),Quote(['\"'])));
export file_in_20130117:= dataset(ut.foreign_prod + 'thor_data400::in::chase_full_20130117',layouts.new_layout_in, csv(heading(1),separator(['G']),terminator(['\n','\r\n']),Quote(['\"'])));
export file_in_20140204:= dataset(ut.foreign_prod + 'thor_data400::in::chase_full_20140204',layouts.layout_in_20140204, flat);
export branch_addr_lookup_20140204:= dataset(ut.foreign_prod + 'thor_data400::in::chase::20140204::branch_addr_lookup',layouts.layout_branch_addr_lookup, csv(heading(1),separator([',']),terminator(['\n','\r\n']),Quote(['\"'])));

export base := dataset('~thor_data400::base::chase_data', layouts.base, thor);
end;