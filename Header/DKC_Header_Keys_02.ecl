import lib_fileservices;

#workunit('name','DKC Header Keys - 2');

//edata10=10.150.13.201
//edata12=10.150.12.240
//edata13=192.168.0.71
//edata14=172.16.68.91

DestinationIP := '172.16.68.91';
DestinationData := '/hdr_data_16/';
DestinationKeys := '/hdr_keys_16/';
DestinationXtra2 := '/hdr_xtra2_16/';

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

DKCKeys_Xtra2(string SourceKeyName,string DestKeyName)
 :=
  if(lib_fileservices.fileservices.FileExists(SourceKeyName),
	 lib_fileservices.FileServices.DKC(SourceKeyName,DestinationIP,DestinationXtra2+DestKeyName,,,,TRUE),
	 output(SourceKeyName + ' does not exist')
	)
;

key1 := DKCKeys_Data('~thor_data400::key::moxie.header.zip.dph_lname.name_first.name_middle.name_last.dob.key','headers_v69.zip.dph_lname.name_first.name_middle.name_last.dob.key');
key2 := DKCKeys_Keys('~thor_data400::key::moxie.header.dph_lname.name_first.name_middle.name_last.dob.key','headers_v69.dph_lname.name_first.name_middle.name_last.dob.key');
key3 := DKCKeys_Xtra2('~thor_data400::key::moxie.header.st.dph_lname.name_first.name_middle.name_last.dob.key','headers_v69.st.dph_lname.name_first.name_middle.name_last.dob.key');

parallel(key1,key2,key3);