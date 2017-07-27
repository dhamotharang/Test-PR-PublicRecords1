import lib_fileservices;

#workunit('name','DKC Header Keys - 1');

//edata10=10.150.13.201
//edata12=10.150.12.240
//edata13=192.168.0.71
//edata14=172.16.68.91

DestinationIP := '172.16.68.91';
DestinationData := '/hdr_data_16/';
DestinationKeys := '/hdr_keys_16/';
DestinationXtra := '/hdr_xtra_16/';

DKCKeys_Data(string SourceKeyName,string DestKeyName)
 :=
  if(lib_fileservices.fileservices.FileExists(SourceKeyName),
	 lib_fileservices.FileServices.DKC(SourceKeyName,DestinationIP,DestinationData+DestKeyName,,,,TRUE),
	 output(SourceKeyName + ' does not exist')
	)
;

DKCKeys_Keys(string SourceKeyName,string DestKeyName)
 :=
  if(lib_fileservices.fileservices.FileExists(SourceKeyName),
	 lib_fileservices.FileServices.DKC(SourceKeyName,DestinationIP,DestinationKeys+DestKeyName,,,,TRUE),
	 output(SourceKeyName + ' does not exist')
	)
;

DKCKeys_Xtra(string SourceKeyName,string DestKeyName)
 :=
  if(lib_fileservices.fileservices.FileExists(SourceKeyName),
	 lib_fileservices.FileServices.DKC(SourceKeyName,DestinationIP,DestinationXtra+DestKeyName,,,,TRUE),
	 output(SourceKeyName + ' does not exist')
	)
;

key1 := DKCKeys_Keys('~thor_data400::key::moxie.header.lfmname.key','headers_v69.lfmname.key');
key2 := DKCKeys_Data('~thor_data400::key::moxie.header.st.lfmname.key','headers_v69.st.lfmname.key');
key3 := DKCKeys_Data('~thor_data400::key::moxie.header.zip.lfmname.key','headers_v69.zip.lfmname.key');
key4 := DKCKeys_Xtra('~thor_data400::key::moxie.header.phone7.key','headers_v69.phone7.key');
key5 := DKCKeys_Xtra('~thor_data400::key::moxie.header.st.phone7.key','headers_v69.st.phone7.key');
key6 := DKCKeys_Xtra('~thor_data400::key::moxie.header.phone7.area_code.st.key','headers_v69.phone7.area_code.st.key');
key7 := DKCKeys_Xtra('~thor_data400::key::moxie.header.ssn.fname.key','headers_v69.ssn.fname.key');
key8 := DKCKeys_Xtra('~thor_data400::key::moxie.header.did.key','headers_v69.did.key');

parallel(key1,key2,key3,key4,key5,key6,key7,key8);