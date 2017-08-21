#workunit('name', 'D&B Companies/Contacts Build Process ' + DNB.version);

//edata10=10.150.13.201
//edata12=10.150.12.240
//edata13=192.168.0.71
//edata14=172.16.68.91

//Make sure these attributes are correct:
//dnb.version

DestinationIP		:= '10.173.212.10';
DestinationVolume	:= '/dnb_16/';

DNB.Proc_Build_All(DestinationIP, DestinationVolume).All;