//Copy(const varstring sourceLogicalName, const varstring destinationGroup, const varstring destinationLogicalName, const varstring sourceDali='', integer4 timeOut=-1, const varstring espServerIpPort=lib_system.ws_fs_server, integer4 maxConnections=-1, boolean allowoverwrite=false, boolean replicate=false)

d1 :=  fileservices.Copy('~thor_data50::in::infousa_fbn_new', 					'thor400_92', '~thor_data400::in::infousa_fbn_new', '10.173.72.201');
d2 :=  fileservices.Copy('~thor_data50::in::infousa_fbn_lexx001_20051010.d00',	'thor400_92', '~thor_data400::in::infousa_fbn_lexx001_20051010.d00', '10.173.72.201');
d3 :=  fileservices.Copy('~thor_data50::in::infousa_fbn_lexx001_20051104.d00',	'thor400_92', '~thor_data400::in::infousa_fbn_lexx001_20051104.d00', '10.173.72.201');
d4 :=  fileservices.Copy('~thor_data50::in::infousa_fbn_lexx001_20051202.d00',	'thor400_92', '~thor_data400::in::infousa_fbn_lexx001_20051202.d00', '10.173.72.201');
d5 :=  fileservices.Copy('~thor_data50::in::infousa_fbn_lexx001_20060109.d00',	'thor400_92', '~thor_data400::in::infousa_fbn_lexx001_20060109.d00', '10.173.72.201');
d6 :=  fileservices.Copy('~thor_data50::in::infousa_fbn_lexx001_20060206.d00',	'thor400_92', '~thor_data400::in::infousa_fbn_lexx001_20060206.d00', '10.173.72.201');
                                                                                         
sequential(
	
	 d1 
	,d2 
	,d3 
	,d4 
	,d5 
	,d6 

);