import liensv2, Doxie;

file_in := UPIN.File_UPIN_base((unsigned6)did != 0);

dist_file:= distribute(file_in, hash(did));

sort_file   := sort(dist_file, did, local);

export key_UPIN_DID := index(sort_file,{unsigned6 l_did := (unsigned6)did},{sort_file},'~thor_data400::key::liensv2::UPIN::did_' + doxie.Version_SuperKey);




