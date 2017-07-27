import emerges;

string_rec := record
	emerges.layout_voters_out;
    unsigned integer8 __filepos { virtual(fileposition)};
end;

export File_Voters_Keybase := dataset('~thor_data400::base::emerges_voters_built',
	string_rec,flat);