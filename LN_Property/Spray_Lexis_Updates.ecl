import lib_stringlib, lib_fileservices, _control;

process_date := '20060719';
srcIP := _control.IPAddress.edata10;

/*
SprayFixed(
           const varstring sourceIP
         , const varstring sourcePath
		 , integer4 recordSize
		 , const varstring destinationGroup
		 , const varstring destinationLogicalName
		 , integer4 timeOut=-1
		     , const varstring espServerIpPort=lib_system.ws_fs_server
			 , integer4 maxConnections=-1
			 , boolean allowoverwrite=false
			 , boolean replicate=false
			 , boolean compress=false) : c,context,entrypoint='fsSprayFixed';
*/

lib_fileservices.FileServices.sprayfixed(
  //'10.150.13.201'
  srcIP
 ,'/data_build_2/property/ln/'+process_date+'/ln_assessor_'+process_date+'_base.d00'
 ,3288
 ,'thor_dell400_2'
 ,'~thor_dell400_2::in::ln_property::'+process_date+'::assessor'
 ,,,,true,true,true
);
			 
lib_fileservices.FileServices.sprayfixed(
  //'10.150.13.201'
  srcIP
 ,'/data_build_2/property/ln/'+process_date+'/ln_deed_sam_'+process_date+'_base.d00'
 ,2998
 ,'thor_dell400_2'
 ,'~thor_dell400_2::in::ln_property::'+process_date+'::deed'
 ,,,,true,true,true
);

lib_fileservices.FileServices.sprayfixed(
  //'10.150.13.201'
  srcIP
 ,'/data_build_2/property/ln/'+process_date+'/ln_deed_sam_'+process_date+'_addlnames.d00'
 ,2353
 ,'thor_dell400_2'
 ,'~thor_dell400_2::in::ln_property::'+process_date+'::addl_names'
 ,,,,true,true,true
);

lib_fileservices.FileServices.sprayfixed(
  //'10.150.13.201'
  srcIP
 ,'/data_build_2/property/ln/'+process_date+'/ln_property_'+process_date+'_search.d00'
 ,429
 ,'thor_dell400_2'
 ,'~thor_dell400_2::in::ln_property::'+process_date+'::search'
 ,,,,true,true,true
);

lib_fileservices.FileServices.sprayfixed(
  //'10.150.13.201'
  srcIP
 ,'/data_build_2/property/ln/'+process_date+'/ln_repl_assessor_'+process_date+'_base.d00'
 ,3288
 ,'thor_dell400_2'
 ,'~thor_dell400_2::in::ln_property::'+process_date+'::repl_assessor'
 ,,,,true,true,true
);

//File rarely exists
/*
lib_fileservices.FileServices.sprayfixed(
  //'10.150.13.201'
  srcIP
 ,'/data_build_2/property/ln/'+process_date+'/ln_repl_sam_'+process_date+'_base.d00'
 ,2998
 ,'thor_dell400_2'
 ,'~thor_dell400_2::in::ln_property::'+process_date+'::repl_deed'
 ,,,,true,true,true
);
*/
lib_fileservices.FileServices.sprayfixed(
  //'10.150.13.201'
  srcIP
 ,'/data_build_2/property/ln/'+process_date+'/ln_repl_property_'+process_date+'_search.d00'
 ,429
 ,'thor_dell400_2'
 ,'~thor_dell400_2::in::ln_property::'+process_date+'::repl_search'
 ,,,,true,true,true
);

fileservices.addsuperfile('~thor_data400::in::ln_property::assessor',     '~thor_dell400_2::in::ln_property::'+process_date+'::assessor');
fileservices.addsuperfile('~thor_data400::in::ln_property::deed',         '~thor_dell400_2::in::ln_property::'+process_date+'::deed');
fileservices.addsuperfile('~thor_data400::in::ln_property::addl_names',   '~thor_dell400_2::in::ln_property::'+process_date+'::addl_names');
fileservices.addsuperfile('~thor_data400::in::ln_property::search',       '~thor_dell400_2::in::ln_property::'+process_date+'::search');
fileservices.addsuperfile('~thor_data400::in::ln_property::search_repl',  '~thor_dell400_2::in::ln_property::'+process_date+'::repl_search');
fileservices.addsuperfile('~thor_data400::in::ln_property::assessor_repl','~thor_dell400_2::in::ln_property::'+process_date+'::repl_assessor');