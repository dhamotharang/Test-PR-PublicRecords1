﻿IMPORT did_add, PromoteSupers, ut;
EXPORT AddressesInfo(string pVersion) := module
	
	shared dsVer 	:= dataset(filenames().OutputF.RefreshAddresses,{string8 pVersion},flat,opt);
	
	EXPORT IsTimeForRefresh	:= if(	nothor(fileservices.fileExists(filenames().OutputF.RefreshAddresses)), 
									ut.DaysApart( dsVer[1].pVersion, pVersion) >= Constants().RefreshAddresses, 
									true);
	
	PromoteSupers.MAC_SF_BuildProcess(dataset([{pVersion}],{string8 pVersion}), filenames().OutputF.RefreshAddresses, PostRefreshAddresses ,2,,true);
	EXPORT Post 	:= if(	 IsTimeForRefresh
							,sequential(PostRefreshAddresses, output('refresh_addresses_version Changed', named('RefreshAddressesChanged')))
							,sequential(output('refresh_addresses_version Not Changed', named('RefreshAddressesNotChanged'))));			
END;