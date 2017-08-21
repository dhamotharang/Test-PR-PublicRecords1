import prte2_faa, faa;

export as_header_airmen := module

//this then gets read into a separate process (our Header process) for the creation and managing of our LexID's
export person_header_airmen_recs := faa.airmen_as_header(files.header_airmen_plus(did_out<>''),,true);

end;
