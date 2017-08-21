import lib_fileservices;

#workunit('name','DKC Property 2580 Keys');

//edata10=10.150.13.201
//edata12=10.150.12.240
//edata13=192.168.0.71
//edata14=172.16.68.91

DestinationIP := '172.16.68.91';
DestinationVolume := '/fares_15/';

DKCKeys(string SourceKeyName,string DestKeyName)
 :=
  if(lib_fileservices.fileservices.FileExists(SourceKeyName),
	 lib_fileservices.FileServices.DKC(SourceKeyName,DestinationIP,DestinationVolume+DestKeyName,,,,TRUE),
	 output(SourceKeyName + ' does not exist')
	)
;

key1 := DKCKeys('~thor_data400::key::moxie.fares_2580.parcel.key','Fares_2580_Master.parcel.key');
key2 := DKCKeys('~thor_data400::key::moxie.fares_2580.fares_id.key','Fares_2580_Master.fares_id.key');
key3 := DKCKeys('~thor_data400::key::moxie.fares_2580.fpos.data.key','Fares_2580_Master.fpos.data.key');

export DKC_2580_keys := parallel(key1,key2,key3);