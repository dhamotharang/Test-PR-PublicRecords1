import header, dx_Header;  

hf := header.File_HHID_Current;

export data_key_HHID_Did := PROJECT (hf, dx_Header.layouts.i_hhid);

//TODO: same as data_key_Did_hhid
