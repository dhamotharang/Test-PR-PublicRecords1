string_rec := record
	emerges.layout_ccw_out;
    unsigned integer8 __filepos { virtual(fileposition)};
end;
export file_ccw_keybuild := 
	dataset('~thor_data400::base::emerges_ccw',
	string_rec,flat);