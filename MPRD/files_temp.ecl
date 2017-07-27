
import ut;
EXPORT files_temp := module

export idv_basc_file:=DATASET(ut.foreign_prod+'~thor_data400::in::mprd::idv_basc_file_wheader',mprd.layouts.input
,CSV(
HEADING(2)
,SEPARATOR('|')
,TERMINATOR(['\n', '\r\n'])
,QUOTE('"')
)
);                 

export fac_basc_file:=DATASET(ut.foreign_prod+'~thor_data400::in::mprd::fac_basc_file_wheader',mprd.layouts.input
,CSV(
HEADING(2)
,SEPARATOR('|')
,TERMINATOR(['\n', '\r\n'])
,QUOTE('"')
)
);              
end;