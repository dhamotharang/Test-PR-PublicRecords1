IMPORT _Control, lib_fileservices, lib_stringlib, VersionControl;

EXPORT fSpray := FUNCTION
	dest_group := IF(VersionControl._Flags.IsDataland, 'thor40_241', 'thor400_84');
	CreateSuper := FileServices.CreateSuperFile(Filenames().Input.Sprayed, FALSE);
								
	CreateSuperfileIfNotExist :=
	  IF(NOT FileServices.SuperFileExists(Filenames().Input.Sprayed), CreateSuper);
		
	do_spray :=
	  IF(COUNT(FileServices.RemoteDirectory(_Control.IPAddress.edata12,'/hds_180/CNLD_Practitioner/')(size > 0)) > 0,
					FileServices.SprayVariable(_Control.IPAddress.edata12,'/hds_180/CNLD_Practitioner/practitioner.csv',
																			,',',,,dest_group,cluster+'in::'+ _Dataset().name + '::data',-1,,,true,,true
																		)
			 );
																			
	addSuper :=
	  IF(COUNT(FileServices.RemoteDirectory(_Control.IPAddress.edata12,'/hds_180/CNLD_Practitioner/')(size > 0)) > 0,
					FileServices.AddSuperFile(Filenames().Input.Sprayed,cluster + 'in::' + _Dataset().name + '::data')
			 );
										 
/* Check to see if sprayed file is already in superfile.  If sprayed file is present,
   remove sprayed file from subsuperfile and respray and add to superfile again. */

	doSeq :=
	  SEQUENTIAL(CreateSuperfileIfNotExist,
							 IF(FileServices.FindsuperFileSubName(Filenames().Input.Sprayed,
							                                      cluster + 'in::' + _Dataset().name + '::data') > 0,
									FileServices.RemoveSuperFile(Filenames().Input.Sprayed,
									                             cluster + 'in::' + _Dataset().name + '::data'))
							 ,do_spray
							 ,addSuper);
											
	RETURN doSeq;
END;