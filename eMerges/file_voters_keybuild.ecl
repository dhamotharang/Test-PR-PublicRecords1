string_rec := record
	emerges.layout_voters_out;
    unsigned integer8 __filepos { virtual(fileposition)};
end;
export file_voters_keybuild := dataset('~thor_data400::base::emerges_voters',
	string_rec,flat);