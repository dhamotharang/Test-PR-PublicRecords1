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
			IF( NOT fileservices.superfileexists(KeyNames(pversion,pUseDelta).company_super),fileservices.createsuperfile(KeyNames(pversion,pUseDelta).company_super)),
			IF( NOT fileservices.superfileexists(KeyNames(pversion,pUseDelta).address1_super),fileservices.createsuperfile(KeyNames(pversion,pUseDelta).address1_super)),
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
			IF( NOT fileservices.superfileexists(KeyNames(pversion,pUseDelta).company_father),fileservices.createsuperfile(KeyNames(pversion,pUseDelta).company_father)),
			IF( NOT fileservices.superfileexists(KeyNames(pversion,pUseDelta).address1_father),fileservices.createsuperfile(KeyNames(pversion,pUseDelta).address1_father)),
			);												
		RETURN superFiles;
	END;
	
	
	/*-------------------- updatexIDLSuperFiles ----------------------------------------------------*/
	EXPORT updatexIDLSuperFile(string baseSuperFile, string fatherSuperFile, string inFile,boolean pUseDelta = false,  string delta_file='' ) := FUNCTION
	
		 action := 	If(pUseDelta,
								If(delta_file =''
								,nothor(fileServices.AddSuperfile(baseSuperFile, inFile))
								,Sequential(
									 nothor(fileservices.Removesuperfile(baseSuperFile,delta_file))
									,nothor(fileServices.AddSuperfile(baseSuperFile, inFile))	
									,nothor(fileservices.Clearsuperfile(fatherSuperFile,true))
									,nothor(fileservices.Addsuperfile(fatherSuperFile,delta_file))															
									)						
								)
								,Sequential(
								FileServices.PromoteSuperFileList([baseSuperFile, fatherSuperFile], inFile, true)
							)
							);
		return action;

	END;
	
	
	/*-------------------- updateAllxIDLSuperFiles ----------------------------------------------------*/
	KeyIn := Bair_ExternalLinkKeys.KeyNames(pversion,pUseDelta);
	
	t1 	:= updatexIDLSuperFile(KeyIn.meow_super,			KeyIn.meow_father,			KeyIn.meow_logical		,pUseDelta,		KeyIn.meow_Delta);	
	t2 	:= updatexIDLSuperFile(KeyIn.name_super,			KeyIn.name_father,			KeyIn.name_logical		,pUseDelta,		KeyIn.name_Delta);	
	t3 	:= updatexIDLSuperFile(KeyIn.address_super,		KeyIn.address_father,		KeyIn.address_logical	,pUseDelta, 	KeyIn.address_Delta);	
	t4 	:= updatexIDLSuperFile(KeyIn.ssn_super,				KeyIn.ssn_father,				KeyIn.ssn_logical			,pUseDelta,		KeyIn.ssn_Delta);	
	t5 	:= updatexIDLSuperFile(KeyIn.lexid_super,			KeyIn.lexid_father,			KeyIn.lexid_logical		,pUseDelta,	 	KeyIn.lexid_Delta);	
	t6 	:= updatexIDLSuperFile(KeyIn.dob_super,				KeyIn.dob_father,				KeyIn.dob_logical			,pUseDelta,		KeyIn.dob_Delta);	
	t7 	:= updatexIDLSuperFile(KeyIn.zip_super,				KeyIn.zip_father,				KeyIn.zip_logical			,pUseDelta,		KeyIn.zip_Delta);	
	t8 	:= updatexIDLSuperFile(KeyIn.vin_super,				KeyIn.vin_father,				KeyIn.vin_logical			,pUseDelta,		KeyIn.vin_Delta);	
	t9 	:= updatexIDLSuperFile(KeyIn.dln_super,				KeyIn.dln_father,				KeyIn.dln_logical			,pUseDelta,		KeyIn.dln_Delta);	
	t10	:= updatexIDLSuperFile(KeyIn.plate_super,			KeyIn.plate_father,			KeyIn.plate_logical		,pUseDelta,	 	KeyIn.plate_Delta);	
	t11 := updatexIDLSuperFile(KeyIn.ph_super,				KeyIn.ph_father,				KeyIn.ph_logical			,pUseDelta,		KeyIn.ph_Delta);	
	t12	:= updatexIDLSuperFile(KeyIn.lfz_super,				KeyIn.lfz_father,				KeyIn.lfz_logical			,pUseDelta,		KeyIn.lfz_Delta);	
	t13	:= updatexIDLSuperFile(KeyIn.latlong_super,		KeyIn.latlong_father,		KeyIn.latlong_logical	,pUseDelta, 	KeyIn.latlong_Delta);	
	t14	:= updatexIDLSuperFile(KeyIn.company_super,		KeyIn.company_father,		KeyIn.company_logical	,pUseDelta, 	KeyIn.company_Delta);	
	t15	:= updatexIDLSuperFile(KeyIn.address1_super,	KeyIn.address1_father,	KeyIn.address1_logical,pUseDelta, 	KeyIn.address1_Delta);	

	export updateAllSF := sequential(createSuperFiles(),nothor(fileservices.StartSuperFileTransaction()),t1, 
	t2, t3, t4, t5, t6, t7, t8, t9, t10, t11, t12, t13,t14,t15,nothor(fileservices.FinishSuperFileTransaction()));
	
end;