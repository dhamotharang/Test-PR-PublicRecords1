EXPORT Files_GA_raw := module

export file_aa :=  dataset('~thor_data400::in::prolic::ga::all_available::raw',Layouts_GA_raw.aa,CSV(separator('\t'),terminator(['\n','\r\n']),Quote('')));

export file_med_raw := dataset('~thor_data400::in::prolic::ga::medical::raw',Layouts_GA_raw.medraw,CSV(heading(1),separator(','),terminator(['\n','\r\n']),Quote('\"'),ESCAPE('\''))) ;

export file_lpn_raw := dataset('~thor_data400::in::prolic::ga::nurses::lpn',Layouts_GA_raw.lpn_raw,CSV(separator('\t'),terminator(['\n','\r\n']),Quote('')));

export file_rn_raw := dataset('~thor_data400::in::prolic::ga::nurses::rn',Layouts_GA_raw.rn_raw,CSV(separator('\t'),terminator(['\n','\r\n']),Quote('')));

end;