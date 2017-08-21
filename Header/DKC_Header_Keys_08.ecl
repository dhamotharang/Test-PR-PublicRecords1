import _control, lib_fileservices;

#workunit('name','DKC Header Keys - 8');

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

export DKC_Header_Keys_08 := DKCKeys_Xtra2('~thor_data400::key::moxie.header.really_long.key','headers_v69.really_long.key');