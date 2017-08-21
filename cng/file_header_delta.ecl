import header;

export file_header_delta := module

export adds := dataset('~thor_data400::out::header::deltas_adds', layout_header_delta.adds, csv(separator('\t')));

export rems := dataset('~thor_data400::out::header::deltas_rems', layout_header_delta.rems, thor);

export chgs := dataset('~thor_data400::out::header::deltas_chgs', layout_header_delta.chgs, csv(separator('\t')));

export combined := dataset('~thor_data400::out::header::deltas', layout_header_delta.combined, thor);
end;