import _control, lib_fileservices;

#workunit('name','DKC Header Keys - 4');

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

key1 := DKCKeys_Xtra('~thor_data400::key::moxie.header.pln.z5.match.key','headers_v69.pln.z5.match.key');
key2 := DKCKeys_Xtra3('~thor_data400::key::moxie.header.pln.pr.pst.match.key','headers_v69.pln.pr.pst.match.key');
key3 := DKCKeys_Xtra('~thor_data400::key::moxie.header.st.pln.match.key','headers_v69.st.pln.match.key');
key4 := DKCKeys_Xtra('~thor_data400::key::moxie.header.pr.z5.match.key','headers_v69.pr.z5.match.key');
key5 := DKCKeys_Xtra('~thor_data400::key::moxie.header.st.pln.pct.match.key','headers_v69.st.pln.pct.match.key');
key6 := DKCKeys_Xtra('~thor_data400::key::moxie.header.pr.st.pct.match.key','headers_v69.pr.st.pct.match.key');

export DKC_Header_Keys_04 := parallel(key1,key2,key3,key4,key5,key6);