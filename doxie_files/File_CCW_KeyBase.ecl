import emerges,Data_Services;

string_rec := record
	emerges.layout_ccw_out;
    unsigned integer8 __filepos { virtual(fileposition)};
end;

export File_CCW_KeyBase := dataset(Data_Services.Data_Location.prefix('person_header')+'thor_data400::base::emerges_ccw_built',
	string_rec,flat);