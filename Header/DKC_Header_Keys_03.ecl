import lib_fileservices;

#workunit('name','DKC Header Keys - 3');

//edata10=10.150.13.201
//edata12=10.150.12.240
//edata13=192.168.0.71
//edata14=172.16.68.91

DestinationIP := '172.16.68.91';
DestinationKeys := '/hdr_keys_16/';
DestinationXtra2 := '/hdr_xtra_16/';

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

key1 := DKCKeys_Xtra2('~thor_data400::key::moxie.header.zip.street_name.prim_range.lfmname.ssn.key','headers_v69.zip.street_name.prim_range.lfmname.ssn.key');
key2 := DKCKeys_Keys('~thor_data400::key::moxie.header.ssn4.lfmname.key','headers_v69.ssn4.lfmname.key');
key3 := DKCKeys_Keys('~thor_data400::key::moxie.header.phone.key','headers_v69.phone.key');
key4 := DKCKeys_Keys('~thor_data400::key::moxie.header.st.dob_year.dob_month.dph_lname.lfmname.key','headers_v69.st.dob_year.dob_month.dph_lname.lfmname.key');
key5 := DKCKeys_Keys('~thor_data400::key::moxie.header.dob_year.dob_month.dph_lname.lfmname.key','headers_v69.dob_year.dob_month.dph_lname.lfmname.key');

parallel(key1,key2,key3,key4,key5);