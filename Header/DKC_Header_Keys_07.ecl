import _control, lib_fileservices;

#workunit('name','DKC Header Keys - 7');

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

key1 := DKCKeys_Keys('~thor_data400::key::moxie.header.st.city.lfmname.dob.key','headers_v69.st.city.lfmname.dob.key');
key2 := DKCKeys_Keys('~thor_data400::key::moxie.header.st.city.dob.fname.key','headers_v69.st.city.dob.fname.key');
key3 := DKCKeys_Xtra3('~thor_data400::key::moxie.header.st.city.dph_lname.name_first.name_middle.name_last.dob.key','headers_v69.st.city.dph_lname.name_first.name_middle.name_last.dob.key');

export DKC_Header_Keys_07 := parallel(key1,key2,key3);