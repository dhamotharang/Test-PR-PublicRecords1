import lib_fileservices, _control;

#workunit('name','Despray DKC Relatives');

//edata10=10.150.13.201
//edata12=10.150.12.240
//edata13=192.168.0.71
//edata14=172.16.68.91
//edata15=10.173.14.12

DestinationIP := _control.IPAddress.edata14a;
DestinationVolume := '/relatives_82/';

DKCKeys(string SourceKeyName,string DestKeyName)
 :=
  if(lib_fileservices.fileservices.FileExists(SourceKeyName),
	 lib_fileservices.FileServices.DKC(SourceKeyName,DestinationIP,DestinationVolume+DestKeyName,,,,TRUE),
	 output(SourceKeyName + ' does not exist')
	)
;

d00 := fileservices.despray('~thor400_84::out::relatives',DestinationIP,DestinationVolume + 'relatives.d00',,,,true);
key1 := DKCKeys('~thor400_84::key::moxie.relatives.same_lname.person1.person2.number_cohabits.recent_cohabit.key','relatives.same_lname.person1.person2.number_cohabits.recent_cohabit.key');
key2 := DKCKeys('~thor400_84::key::moxie.relatives.same_lname.person2.person1.number_cohabits.recent_cohabit.key','relatives.same_lname.person2.person1.number_cohabits.recent_cohabit.key');

parallel(d00,key1,key2);