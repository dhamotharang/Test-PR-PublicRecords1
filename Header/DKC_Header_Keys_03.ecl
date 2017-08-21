import _control, lib_fileservices;

#workunit('name','DKC Header Keys - 3');

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

key1 := DKCKeys_Xtra('~thor_data400::key::moxie.header.zip.street_name.prim_range.lfmname.ssn.key','headers_v69.zip.street_name.prim_range.lfmname.ssn.key');
key2 := DKCKeys_Keys('~thor_data400::key::moxie.header.ssn4.lfmname.key','headers_v69.ssn4.lfmname.key');
key3 := DKCKeys_Keys('~thor_data400::key::moxie.header.st.dob_year.dob_month.dph_lname.lfmname.key','headers_v69.st.dob_year.dob_month.dph_lname.lfmname.key');
key4 := DKCKeys_Keys('~thor_data400::key::moxie.header.dob_year.dob_month.dph_lname.lfmname.key','headers_v69.dob_year.dob_month.dph_lname.lfmname.key');

export DKC_Header_Keys_03 := parallel(key1,key2,key3,key4);