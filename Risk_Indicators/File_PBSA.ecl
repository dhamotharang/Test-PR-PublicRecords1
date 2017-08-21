import risk_indicators,ut;
export File_PBSA := module

export raw := dataset('~thor_data200::in::mtcsa_raw', layout_pbsa.raw, CSV(heading(1),	separator(','),	quote('"'),	terminator(['\r\n','\r','\n'])));

export base := dataset('~thor_data200::base::mtcsa_clean', layout_pbsa.base, flat);


end;
