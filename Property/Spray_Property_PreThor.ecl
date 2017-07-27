import lib_fileservices;

#workunit('name','Property Sprays');

//edata10=10.150.13.201
//edata12=10.150.12.240
//edata13=192.168.0.71
//edata14=172.16.68.91

sourceMachineIP := '10.150.12.240';
fileDateSuffix := '20050815';

assessorsSpray := fileservices.sprayfixed(sourceMachineIP,'/thor_back5/fares/preThor/fares_2580_' +
			fileDateSuffix + '.d00', 3039, 'thor_dell400','~thor_data400::in::fares_2580_' + fileDateSuffix
			,,,,true,true);
				
deedsSpray := fileservices.sprayfixed(sourceMachineIP,'/thor_back5/fares/preThor/fares_1080_' +
			fileDateSuffix + '.d00', 1531, 'thor_dell400','~thor_data400::in::fares_1080_' + fileDateSuffix
			,,,,true,true);
				
searchSpray := fileservices.sprayfixed(sourceMachineIP,'/thor_back5/fares/preThor/fares_search_' +
			fileDateSuffix + '.d00', 361, 'thor_dell400','~thor_data400::in::fares_search_' + fileDateSuffix
			,,,,true,true);
				
assessorsSuper := fileservices.AddSuperFile('~thor_data400::in::fares_2580',
				'~thor_data400::in::fares_2580_' + fileDateSuffix);
				
deedsSuper := fileservices.AddSuperFile('~thor_data400::in::fares_1080',
				'~thor_data400::in::fares_1080_' + fileDateSuffix);
				
searchSuper := fileservices.AddSuperFile('~thor_data400::in::fares_search',
				'~thor_data400::in::fares_search_' + fileDateSuffix);
				
sequential(assessorsSpray,deedsSpray,searchSpray,assessorsSuper,deedsSuper,searchSuper);