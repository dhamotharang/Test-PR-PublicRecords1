#stored('cluster','bair-prod');
#stored('did_add_force','thor');
#option('hdCompressorType', 'NONE');
#OPTION('multiplePersistInstances',FALSE);
#option('maxCsvRowSizeMb', 90);

buildname := 'Bair|Agency';
version 	:= 'yyyymmdd_hhmmss';
pUseProd 	:= true;
IsUpdates := if(regexfind('w|W', version) = true, false, true);
	
#WORKUNIT('name', 'Bair ' + if(IsUpdates, 'DELTA ', 'FULL ') +  'BUILD: ' + version)
Bair.Build_all(buildname, version, pUseProd, IsUpdates);