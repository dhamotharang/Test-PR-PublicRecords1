import custombanktransaction,ut;

EXPORT files := module

export file_in := dataset('~thor_data400::in::chase_sample_0719',layouts.layout_in, csv(heading(1),separator([',']),terminator(['\n','\r\n']),Quote(['\"'])));
export new_file_in := dataset('~thor_data400::in::chase_sample_1101',layouts.new_layout_in, csv(heading(1),separator(['Ç']),terminator(['\n','\r\n']),Quote(['\"'])));
//export full_file_in := dataset('~thor_data400::in::chase_sample_1119',layouts.new_layout_in, csv(heading(1),separator(['Ç']),terminator(['\n','\r\n']),Quote(['\"'])));
export full_file_in(string filedate) := dataset('~thor_data400::in::chase_full_' + filedate,layouts.new_layout_in, csv(heading(1),separator(['G']),terminator(['\n','\r\n']),Quote(['\"'])));

export base := dataset('~thor_data400::base::chase_data', layouts.base, thor);
end;