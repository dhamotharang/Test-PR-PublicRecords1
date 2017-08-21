IMPORT _Control;

EXPORT fsprayNPPES_Taxonomy(STRING filedate) := FUNCTION

  groupname := IF(_Control.ThisEnvironment.name	 = 'Dataland', 'thor40_241', 'thor400_44');

	spray := FileServices.SprayVariable(
	           _Control.IPAddress.bctlpedata10,      															// source IP
						 '/data/hds_180/nppes/npi_taxonomy_codes/' + filedate + '/*.csv', 		// source Path
						 ,                          																		// max record size
						 ,                                															// field separator
						 ,                                															// record terminator
						 ,              	                															// quoted field delimiter
						 groupName, 																										// cluster (destination group)
						 '~thor_data400::in::nppes::' + fileDate + '::taxonomy_codes', 	// logical filename on thor
						 ,                                															// timeout value
						 ,                                															// esp info
						 ,                                															// max connections
						 true,         																									// overwrite
						 ,        																											// replicate
						 true       																										// compress
					 );

  CreateSuperfile := FileServices.CreateSuperFile('~thor_data400::in::nppes::taxonomy_codes');

  createSuperIfNotExist := IF(NOT FileServices.SuperFileExists('~thor_data400::in::nppes::taxonomy_codes'),
	                            CreateSuperfile); 

  add_super :=
	  SEQUENTIAL(FileServices.StartSuperFileTransaction(),
				       FileServices.AddSuperFile('~thor_data400::in::nppes::taxonomy_codes',
				                                 '~thor_data400::in::nppes::' + fileDate + '::taxonomy_codes'),
				       FileServices.FinishSuperFileTransaction());

  clear := FileServices.ClearSuperFile('~thor_data400::in::nppes::taxonomy_codes', FALSE); 

  steps := SEQUENTIAL(clear, spray, add_super);

  do_super := SEQUENTIAL(createSuperIfNotExist, steps);

  RETURN do_super;

END;