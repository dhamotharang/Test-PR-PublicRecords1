import autokeyb2,standard,doxie,ut,criminal_records;

KeyName       := Criminal_Records.cluster.cluster_out+'key::corrections::';
dBase 		  := dataset([], recordof(Criminal_Records.File_offenders_autokey));

autokeyb2.MAC_FID_Payload(dBase ,'','','','','','','','','',0,0,KeyName + 'autokey::qa::payload',plk,'');
export Key_Payload :=plk;  