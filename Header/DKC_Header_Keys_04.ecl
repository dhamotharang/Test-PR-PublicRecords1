import lib_fileservices;

#workunit('name','DKC Header Keys - 4');

//edata10=10.150.13.201
//edata12=10.150.12.240
//edata13=192.168.0.71
//edata14=172.16.68.91

DestinationIP := '172.16.68.91';
DestinationData := '/hdr_data_16/';
DestinationXtra := '/hdr_xtra_16/';

DKCKeys_Data(string SourceKeyName,string DestKeyName)
 :=
  if(lib_fileservices.fileservices.FileExists(SourceKeyName),
	 lib_fileservices.FileServices.DKC(SourceKeyName,DestinationIP,DestinationData+DestKeyName,,,,TRUE),
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

key1 := DKCKeys_Xtra('~thor_data400::key::moxie.header.pln.z5.match.key','headers_v69.pln.z5.match.key');
key2 := DKCKeys_Data('~thor_data400::key::moxie.header.pln.pr.pst.match.key','headers_v69.pln.pr.pst.match.key');
key3 := DKCKeys_Xtra('~thor_data400::key::moxie.header.st.pln.match.key','headers_v69.st.pln.match.key');
key4 := DKCKeys_Xtra('~thor_data400::key::moxie.header.pr.z5.match.key','headers_v69.pr.z5.match.key');
key5 := DKCKeys_Xtra('~thor_data400::key::moxie.header.st.pln.pct.match.key','headers_v69.st.pln.pct.match.key');
key6 := DKCKeys_Xtra('~thor_data400::key::moxie.header.pr.st.pct.match.key','headers_v69.pr.st.pct.match.key');

parallel(key1,key2,key3,key4,key5,key6);