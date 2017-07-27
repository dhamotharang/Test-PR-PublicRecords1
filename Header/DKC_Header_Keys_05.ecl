import lib_fileservices;

#workunit('name','DKC Header Keys - 5');

//edata10=10.150.13.201
//edata12=10.150.12.240
//edata13=192.168.0.71
//edata14=172.16.68.91

DestinationIP := '172.16.68.91';
DestinationXtra := '/hdr_xtra_16/';

DKCKeys_Xtra(string SourceKeyName,string DestKeyName)
 :=
  if(lib_fileservices.fileservices.FileExists(SourceKeyName),
	 lib_fileservices.FileServices.DKC(SourceKeyName,DestinationIP,DestinationXtra+DestKeyName,,,,TRUE),
	 output(SourceKeyName + ' does not exist')
	)
;

key1 := DKCKeys_Xtra('~thor_data400::key::moxie.header.zip.dob.fname.key','headers_v69.zip.dob.fname.key');
key2 := DKCKeys_Xtra('~thor_data400::key::moxie.header.uniqueid.rec_type.key','headers_v69.uniqueid.rec_type.key');
key3 := DKCKeys_Xtra('~thor_data400::key::moxie.header.dob.lfmname.key','headers_v69.dob.lfmname.key');
key4 := DKCKeys_Xtra('~thor_data400::key::moxie.header.st.dob.fname.key','headers_v69.st.dob.fname.key');
key5 := DKCKeys_Xtra('~thor_data400::key::moxie.header.dob.fname.key','headers_v69.dob.fname.key');

parallel(key1,key2,key3,key4,key5);