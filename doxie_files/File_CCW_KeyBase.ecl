import emerges;

string_rec := record
	emerges.layout_ccw_out;
    unsigned integer8 __filepos { virtual(fileposition)};
end;

export File_CCW_KeyBase := dataset('~thor_data400::base::emerges_ccw_built',
	string_rec,flat);