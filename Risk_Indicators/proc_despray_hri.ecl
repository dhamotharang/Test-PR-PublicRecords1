export proc_despray_hri :=


//Dkc(const varstring logicalName, 
//const varstring destinationIP, 
//const varstring destinationPath, 
//integer4 timeOut=-1, 
//const varstring espServerIpPort=lib_system.ws_fs_server, 
//integer4 maxConnections=-1, 
//boolean allowoverwrite=false) : c,context,entrypoint='fsDkc'; 
  

FileServices.Dkc('~thor_data400::key::hri_address_to_sic_qa',
	'10.150.12.240', 
	'/thor_back5/local_data/hri/landing_zone/hri.z5.prim_name.suffix.predir.postdir.prim_range.sec_range.sic_code.key',,,, true); 

