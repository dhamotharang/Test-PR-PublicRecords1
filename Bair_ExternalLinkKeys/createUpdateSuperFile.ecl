EXPORT createUpdateSuperFile(string pversion, boolean pUseDelta = false) := MODULE
											
	EXPORT createSuperFiles() := FUNCTION
		superFiles := SEQUENTIAL(
	//qa super
			//IF( NOT fileservices.superfileexists(KeyNames(pversion,pUseDelta).spec_super),fileservices.createsuperfile(KeyNames(pversion,pUseDelta).spec_super)),															
			IF( NOT fileservices.superfileexists(KeyNames(pversion,pUseDelta).meow_super),fileservices.createsuperfile(KeyNames(pversion,pUseDelta).meow_super)),		
			IF( NOT fileservices.superfileexists(KeyNames(pversion,pUseDelta).name_super),fileservices.createsuperfile(KeyNames(pversion,pUseDelta).name_super)),
			IF( NOT fileservices.superfileexists(KeyNames(pversion,pUseDelta).address_super),fileservices.createsuperfile(KeyNames(pversion,pUseDelta).address_super)),
			IF( NOT fileservices.superfileexists(KeyNames(pversion,pUseDelta).ssn_super),fileservices.createsuperfile(KeyNames(pversion,pUseDelta).ssn_super)),
			IF( NOT fileservices.superfileexists(KeyNames(pversion,pUseDelta).dob_super),fileservices.createsuperfile(KeyNames(pversion,pUseDelta).dob_super)),
			IF( NOT fileservices.superfileexists(KeyNames(pversion,pUseDelta).zip_super),fileservices.createsuperfile(KeyNames(pversion,pUseDelta).zip_super)),
			IF( NOT fileservices.superfileexists(KeyNames(pversion,pUseDelta).dln_super),fileservices.createsuperfile(KeyNames(pversion,pUseDelta).dln_super)),
			IF( NOT fileservices.superfileexists(KeyNames(pversion,pUseDelta).ph_super),fileservices.createsuperfile(KeyNames(pversion,pUseDelta).ph_super)),
			IF( NOT fileservices.superfileexists(KeyNames(pversion,pUseDelta).lfz_super),fileservices.createsuperfile(KeyNames(pversion,pUseDelta).lfz_super)),	
			IF( NOT fileservices.superfileexists(KeyNames(pversion,pUseDelta).vin_super),fileservices.createsuperfile(KeyNames(pversion,pUseDelta).vin_super)),
			IF( NOT fileservices.superfileexists(KeyNames(pversion,pUseDelta).lexid_super),fileservices.createsuperfile(KeyNames(pversion,pUseDelta).lexid_super)),
			IF( NOT fileservices.superfileexists(KeyNames(pversion,pUseDelta).latlong_super),fileservices.createsuperfile(KeyNames(pversion,pUseDelta).latlong_super)),
			IF( NOT fileservices.superfileexists(KeyNames(pversion,pUseDelta).plate_super),fileservices.createsuperfile(KeyNames(pversion,pUseDelta).plate_super)),
	//father		
			//IF( NOT fileservices.superfileexists(KeyNames(pversion,pUseDelta).spec_father),fileservices.createsuperfile(KeyNames(pversion,pUseDelta).spec_father)),															
			IF( NOT fileservices.superfileexists(KeyNames(pversion,pUseDelta).meow_father),fileservices.createsuperfile(KeyNames(pversion,pUseDelta).meow_father)),		
			IF( NOT fileservices.superfileexists(KeyNames(pversion,pUseDelta).name_father),fileservices.createsuperfile(KeyNames(pversion,pUseDelta).name_father)),
			IF( NOT fileservices.superfileexists(KeyNames(pversion,pUseDelta).address_father),fileservices.createsuperfile(KeyNames(pversion,pUseDelta).address_father)),
			IF( NOT fileservices.superfileexists(KeyNames(pversion,pUseDelta).ssn_father),fileservices.createsuperfile(KeyNames(pversion,pUseDelta).ssn_father)),
			IF( NOT fileservices.superfileexists(KeyNames(pversion,pUseDelta).dob_father),fileservices.createsuperfile(KeyNames(pversion,pUseDelta).dob_father)),
			IF( NOT fileservices.superfileexists(KeyNames(pversion,pUseDelta).zip_father),fileservices.createsuperfile(KeyNames(pversion,pUseDelta).zip_father)),
			IF( NOT fileservices.superfileexists(KeyNames(pversion,pUseDelta).dln_father),fileservices.createsuperfile(KeyNames(pversion,pUseDelta).dln_father)),
			IF( NOT fileservices.superfileexists(KeyNames(pversion,pUseDelta).ph_father),fileservices.createsuperfile(KeyNames(pversion,pUseDelta).ph_father)),
			IF( NOT fileservices.superfileexists(KeyNames(pversion,pUseDelta).lfz_father),fileservices.createsuperfile(KeyNames(pversion,pUseDelta).lfz_father)),	
			IF( NOT fileservices.superfileexists(KeyNames(pversion,pUseDelta).vin_father),fileservices.createsuperfile(KeyNames(pversion,pUseDelta).vin_father)),
			IF( NOT fileservices.superfileexists(KeyNames(pversion,pUseDelta).lexid_father),fileservices.createsuperfile(KeyNames(pversion,pUseDelta).lexid_father)),
			IF( NOT fileservices.superfileexists(KeyNames(pversion,pUseDelta).latlong_father),fileservices.createsuperfile(KeyNames(pversion,pUseDelta).latlong_father)),
			IF( NOT fileservices.superfileexists(KeyNames(pversion,pUseDelta).plate_father),fileservices.createsuperfile(KeyNames(pversion,pUseDelta).plate_father)),
			);												
		RETURN superFiles;
	END;
	
	/*-------------------- updatexIDLSuperFiles ----------------------------------------------------*/
	EXPORT updatexIDLSuperFile(string baseSuperFile, string fatherSuperFile, string inFile,boolean pUseDelta = false) := FUNCTION
		action := If(pUseDelta,
								Sequential(
								FileServices.AddSuperfile(baseSuperFile, inFile)
								)
								,Sequential(
								FileServices.PromoteSuperFileList([baseSuperFile, fatherSuperFile], inFile, true)
							)
							);
		return action;
	END;
	
	/*-------------------- updateAllxIDLSuperFiles ----------------------------------------------------*/
	t1 	:= updatexIDLSuperFile(KeyNames(pversion,pUseDelta).meow_super,			KeyNames(pversion,pUseDelta).meow_father,			KeyNames(pversion,pUseDelta).meow_logical,pUseDelta);	
	t2 	:= updatexIDLSuperFile(KeyNames(pversion,pUseDelta).name_super,			KeyNames(pversion,pUseDelta).name_father,			KeyNames(pversion,pUseDelta).name_logical,pUseDelta);
	t3 	:= updatexIDLSuperFile(KeyNames(pversion,pUseDelta).address_super,	KeyNames(pversion,pUseDelta).address_father,	KeyNames(pversion,pUseDelta).address_logical,pUseDelta);
	t4 	:= updatexIDLSuperFile(KeyNames(pversion,pUseDelta).ssn_super,			KeyNames(pversion,pUseDelta).ssn_father,			KeyNames(pversion,pUseDelta).ssn_logical,pUseDelta);
	t5 	:= updatexIDLSuperFile(KeyNames(pversion,pUseDelta).lexid_super,		KeyNames(pversion,pUseDelta).lexid_father,		KeyNames(pversion,pUseDelta).lexid_logical,pUseDelta);
	t6 	:= updatexIDLSuperFile(KeyNames(pversion,pUseDelta).dob_super,			KeyNames(pversion,pUseDelta).dob_father,			KeyNames(pversion,pUseDelta).dob_logical,pUseDelta);
	t7 	:= updatexIDLSuperFile(KeyNames(pversion,pUseDelta).zip_super,			KeyNames(pversion,pUseDelta).zip_father,			KeyNames(pversion,pUseDelta).zip_logical,pUseDelta);
	t8 	:= updatexIDLSuperFile(KeyNames(pversion,pUseDelta).vin_super,			KeyNames(pversion,pUseDelta).vin_father,			KeyNames(pversion,pUseDelta).vin_logical,pUseDelta);
	t9 	:= updatexIDLSuperFile(KeyNames(pversion,pUseDelta).dln_super,			KeyNames(pversion,pUseDelta).dln_father,			KeyNames(pversion,pUseDelta).dln_logical,pUseDelta);
	t10	:= updatexIDLSuperFile(KeyNames(pversion,pUseDelta).plate_super,		KeyNames(pversion,pUseDelta).plate_father,		KeyNames(pversion,pUseDelta).plate_logical,pUseDelta);
	t11 := updatexIDLSuperFile(KeyNames(pversion,pUseDelta).ph_super,				KeyNames(pversion,pUseDelta).ph_father,				KeyNames(pversion,pUseDelta).ph_logical,pUseDelta);
	t12	:= updatexIDLSuperFile(KeyNames(pversion,pUseDelta).lfz_super,			KeyNames(pversion,pUseDelta).lfz_father,			KeyNames(pversion,pUseDelta).lfz_logical,pUseDelta);
	t13	:= updatexIDLSuperFile(KeyNames(pversion,pUseDelta).latlong_super,	KeyNames(pversion,pUseDelta).latlong_father,	KeyNames(pversion,pUseDelta).latlong_logical,pUseDelta);

	export updateAllSF := sequential(t1, 
	t2, t3, t4, t5, t6, t7, t8, t9, t10, t11, t12, t13);
	
end;