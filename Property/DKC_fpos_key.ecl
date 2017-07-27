import lib_fileservices;

#workunit('name','DKC Property FPOS Key');

DestinationIP := '172.16.68.91';
DestinationVolume := '/fares_14/';

DKCKeys(string KeyFileName,string Destfilename)
 :=
  if(lib_fileservices.fileservices.FileExists(KeyFileName),
	 lib_fileservices.FileServices.DKC(KeyFileName,DestinationIP,DestinationVolume+Destfilename,,,,TRUE),
	 output(KeyFileName + ' does not exist')
	)
;
 
export DKC_fpos_key := DKCKeys('~thor_dell400_2::key::moxie.fares_search.fpos.data.key','fares_search.fpos.data.key');
