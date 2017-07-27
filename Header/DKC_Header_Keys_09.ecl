import lib_fileservices;

#workunit('name','DKC Header Keys - 9');

//edata10=10.150.13.201
//edata12=10.150.12.240
//edata13=192.168.0.71
//edata14=172.16.68.91

DestinationIP := '172.16.68.91';
DestinationKeys := '/hdr_keys_16/';

DKCKeys_Keys(string SourceKeyName,string DestKeyName)
 :=
  if(lib_fileservices.fileservices.FileExists(SourceKeyName),
	 lib_fileservices.FileServices.DKC(SourceKeyName,DestinationIP,DestinationKeys+DestKeyName,,,,TRUE),
	 output(SourceKeyName + ' does not exist')
	)
;

key1 := DKCKeys_Keys('~thor_data400::key::moxie.header.st.county.lfmname.key','headers_v69.st.county.lfmname.key');
key2 := DKCKeys_Keys('~thor_data400::key::moxie.header.st.county.dph_lname.name_first.name_middle.name_last.dob.key','headers_v69.st.county.dph_lname.name_first.name_middle.name_last.dob.key');

parallel(key1,key2);