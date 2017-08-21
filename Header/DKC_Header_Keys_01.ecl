import _control, lib_fileservices;

#workunit('name','DKC Header Keys - 1');

DKCKeys_Data(string SourceKeyName,string DestKeyName)
 :=
  if(lib_fileservices.fileservices.FileExists(SourceKeyName),
	 lib_fileservices.FileServices.DKC(SourceKeyName,DKC_Moxie_Server,DKC_Moxie_Mounts.DestinationData+DestKeyName,,,,TRUE),
	 output(SourceKeyName + ' does not exist')
	)
;

DKCKeys_Keys(string SourceKeyName,string DestKeyName)
 :=
  if(lib_fileservices.fileservices.FileExists(SourceKeyName),
	 lib_fileservices.FileServices.DKC(SourceKeyName,DKC_Moxie_Server,DKC_Moxie_Mounts.DestinationKeys+DestKeyName,,,,TRUE),
	 output(SourceKeyName + ' does not exist')
	)
;

DKCKeys_Xtra(string SourceKeyName,string DestKeyName)
 :=
  if(lib_fileservices.fileservices.FileExists(SourceKeyName),
	 lib_fileservices.FileServices.DKC(SourceKeyName,DKC_Moxie_Server,DKC_Moxie_Mounts.DestinationXtra+DestKeyName,,,,TRUE),
	 output(SourceKeyName + ' does not exist')
	)
;

DKCKeys_Xtra2(string SourceKeyName,string DestKeyName)
 :=
  if(lib_fileservices.fileservices.FileExists(SourceKeyName),
	 lib_fileservices.FileServices.DKC(SourceKeyName,DKC_Moxie_Server,DKC_Moxie_Mounts.DestinationXtra2+DestKeyName,,,,TRUE),
	 output(SourceKeyName + ' does not exist')
	)
;

DKCKeys_Xtra3(string SourceKeyName,string DestKeyName)
 :=
  if(lib_fileservices.fileservices.FileExists(SourceKeyName),
	 lib_fileservices.FileServices.DKC(SourceKeyName,DKC_Moxie_Server,DKC_Moxie_Mounts.DestinationXtra3+DestKeyName,,,,TRUE),
	 output(SourceKeyName + ' does not exist')
	)
;

key1 := DKCKeys_Keys('~thor_data400::key::moxie.header.lfmname.key','headers_v69.lfmname.key');
key2 := DKCKeys_Xtra3('~thor_data400::key::moxie.header.st.lfmname.key','headers_v69.st.lfmname.key');
key3 := DKCKeys_Data('~thor_data400::key::moxie.header.zip.lfmname.key','headers_v69.zip.lfmname.key');
//key4 := DKCKeys_Xtra('~thor_data400::key::moxie.header.phone7.key','headers_v69.phone7.key');
//key5 := DKCKeys_Xtra('~thor_data400::key::moxie.header.st.phone7.key','headers_v69.st.phone7.key');
key6 := DKCKeys_Xtra('~thor_data400::key::moxie.header.phone7.area_code.st.key','headers_v69.phone7.area_code.st.key');
key7 := DKCKeys_Xtra('~thor_data400::key::moxie.header.ssn.fname.key','headers_v69.ssn.fname.key');
key8 := DKCKeys_Xtra('~thor_data400::key::moxie.header.did.key','headers_v69.did.key');
key9 := DKCKeys_Xtra2('~thor_data400::key::moxie.header.ssn5.lfmname.key','headers_v69.ssn5.lfmname.key');

export DKC_Header_Keys_01 := parallel(key1,key2,key3,key6,key7,key8,key9);