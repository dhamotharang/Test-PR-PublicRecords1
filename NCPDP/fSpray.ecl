IMPORT _Control, lib_fileservices, lib_stringlib, VersionControl, tools;

EXPORT fSpray(STRING filedate) := FUNCTION
	cluster1:='~thor_data400';
	dest_group:= if((tools._Constants.IsDataland),'thor40_241','thor400_44');
	
	CreateProvInfoSuper 	:= FileServices.CreateSuperFile(Filenames().prov_info_Input.Sprayed, FALSE);
	CreateProvRelatSuper	:= FileServices.CreateSuperFile(Filenames().prov_relat_Input.Sprayed, FALSE);
	CreateMedicaidSuper		:= FileServices.CreateSuperFile(Filenames().medicaid_Input.Sprayed, FALSE);
	CreateTaxonomySuper		:= FileServices.CreateSuperFile(Filenames().taxonomy_Input.Sprayed, FALSE);
	CreateDemographicSuper  := FileServices.CreateSuperFile(Filenames().demographic_Input.Sprayed, FALSE);
	CreatePayCenterSuper	:= FileServices.CreateSuperFile(Filenames().pay_center_Input.Sprayed, FALSE);
	CreateParentOrgSuper	:= FileServices.CreateSuperFile(Filenames().parent_org_Input.Sprayed, FALSE);
	CreateEprescribeSuper	:= FileServices.CreateSuperFile(Filenames().eprescribe_Input.Sprayed, FALSE);
	CreateRemitInfoSuper	:= FileServices.CreateSuperFile(Filenames().remit_info_Input.Sprayed, FALSE);
	CreateStateLicSuper		:= FileServices.CreateSuperFile(Filenames().state_lic_Input.Sprayed, FALSE);
	CreateServiceInfoSuper:= FileServices.CreateSuperFile(Filenames().services_info_Input.Sprayed, FALSE);
	CreateChangeOwnerSuper:= FileServices.CreateSuperFile(Filenames().change_owner_Input.Sprayed, FALSE);
								
	CreateProvInfoSuperfileIfNotExist :=
	  IF(NOT FileServices.SuperFileExists(Filenames().prov_info_Input.Sprayed), CreateProvInfoSuper);
	CreateProvRelatSuperfileIfNotExist	:=
		IF(NOT FileServices.SuperFileExists(Filenames().prov_relat_Input.Sprayed), CreateProvRelatSuper);
	CreateMedicaidSuperfileIfNotExist	:=
		IF(NOT FileServices.SuperFileExists(Filenames().medicaid_Input.Sprayed), CreateMedicaidSuper);
	CreateTaxonomySuperfileIfNotExist	:=
		IF(NOT FileServices.SuperFileExists(Filenames().taxonomy_Input.Sprayed), CreateTaxonomySuper);
	CreateDemographicSuperfileIfNotExist	:=
		IF(NOT FileServices.SuperFileExists(Filenames().demographic_Input.Sprayed), CreateDemographicSuper);
	CreatePayCenterSuperfileIfNotExist	:=
		IF(NOT FileServices.SuperFileExists(Filenames().pay_center_Input.Sprayed), CreatePayCenterSuper);
	CreateParentOrgSuperfileIfNotExist	:=
		IF(NOT FileServices.SuperFileExists(Filenames().parent_org_Input.Sprayed), CreateParentOrgSuper);
	CreateEprescribeSuperfileIfNotExist	:=
		IF(NOT FileServices.SuperFileExists(Filenames().eprescribe_Input.Sprayed), CreateEprescribeSuper);
	CreateRemitInfoSuperfileIfNotExist	:=
		IF(NOT FileServices.SuperFileExists(Filenames().remit_info_Input.Sprayed), CreateRemitInfoSuper);
	CreateStateLicSuperfileIfNotExist	:=
		IF(NOT FileServices.SuperFileExists(Filenames().state_lic_Input.Sprayed), CreateStateLicSuper);
	CreateServiceInfoSuperfileIfNotExist	:=
		IF(NOT FileServices.SuperFileExists(Filenames().services_info_Input.Sprayed), CreateServiceInfoSuper);
	CreateChangeOwnerSuperfileIfNotExist	:=
		IF(NOT FileServices.SuperFileExists(Filenames().change_owner_Input.Sprayed), CreateChangeOwnerSuper);

	do_prov_info_spray :=
			 FileServices.SprayFixed(_Control.IPAddress.bctlpedata10,
			                         '/data/data_build_4/NCPDP/data/' + filedate + '/mas.txt',
															 1002,
															 dest_group,
															 Cluster1 + '::in::' + _Dataset().name + '::prov_information::' + filedate + '::data', compress := TRUE);
	do_prov_relat_spray	:=
				FileServices.SprayFixed(_Control.IPAddress.bctlpedata10,
																'/data/data_build_4/NCPDP/data/' + filedate + '/mas_rr.txt',
																152,
																dest_group,
																Cluster1 + '::in::' + _Dataset().name + '::prov_relationship::' + filedate + '::data', compress := TRUE);
	do_medicaid_spray	:=
				FileServices.SprayFixed(_Control.IPAddress.bctlpedata10,
																'/data/data_build_4/NCPDP/data/' + filedate + '/mas_md.txt',
																152,
																dest_group,
																Cluster1 + '::in::' + _Dataset().name + '::medicaid::' + filedate + '::data', compress := TRUE);
	do_taxonomy_spray	:=
				FileServices.SprayFixed(_Control.IPAddress.bctlpedata10,
																'/data/data_build_4/NCPDP/data/' + filedate + '/mas_tx.txt',
																152,
																dest_group,
																Cluster1 + '::in::' + _Dataset().name + '::taxonomy::' + filedate + '::data', compress := TRUE);
	do_demographic_spray	:=
				FileServices.SprayFixed(_Control.IPAddress.bctlpedata10,
																'/data/data_build_4/NCPDP/data/' + filedate + '/mas_af.txt',
																1002,
																dest_group,
																Cluster1 + '::in::' + _Dataset().name + '::demographic::' + filedate + '::data', compress := TRUE);
	do_pay_center_spray	:= 
				FileServices.SprayFixed(_Control.IPAddress.bctlpedata10,
																'/data/data_build_4/NCPDP/data/' + filedate + '/mas_pc.txt',
																502,
																dest_group,
																Cluster1 + '::in::' + _Dataset().name + '::pay_center::' + filedate + '::data', compress := TRUE);
	do_parent_org_spray	:=
				FileServices.SprayFixed(_Control.IPAddress.bctlpedata10,
																'/data/data_build_4/NCPDP/data/' + filedate + '/mas_pr.txt',
																502,
																dest_group,
																Cluster1 + '::in::' + _Dataset().name + '::parent_org::' + filedate + '::data', compress := TRUE);
	do_eprescribe_spray	:=
				FileServices.SprayFixed(_Control.IPAddress.bctlpedata10,
																'/data/data_build_4/NCPDP/data/' + filedate + '/mas_erx.txt',
																152,
																dest_group,
																Cluster1 + '::in::' + _Dataset().name + '::eprescribe::' + filedate + '::data', compress := TRUE);
	do_remit_info_spray	:=
				FileServices.SprayFixed(_Control.IPAddress.bctlpedata10,
																'/data/data_build_4/NCPDP/data/' + filedate + '/mas_rec.txt',
																502,
																dest_group,
																Cluster1 + '::in::' + _Dataset().name + '::remit_information::' + filedate + '::data', compress := TRUE);
	do_state_lic_spray	:=
				FileServices.SprayFixed(_Control.IPAddress.bctlpedata10,
																'/data/data_build_4/NCPDP/data/' + filedate + '/mas_stl.txt',
																152,
																dest_group,
																Cluster1 + '::in::' + _Dataset().name + '::state_license::' + filedate + '::data', compress := TRUE);
	do_services_spray	:=
				FileServices.SprayFixed(_Control.IPAddress.bctlpedata10,
																'/data/data_build_4/NCPDP/data/' + filedate + '/mas_svc.txt',
																152,
																dest_group,
																Cluster1 + '::in::' + _Dataset().name + '::services_information::' + filedate + '::data', compress := TRUE);
	do_change_owner_spray	:=
				FileServices.SprayFixed(_Control.IPAddress.bctlpedata10,
																'/data/data_build_4/NCPDP/data/' + filedate + '/mas_coo.txt',
																152,
																dest_group,
																Cluster1 + '::in::' + _Dataset().name + '::change_ownership::' + filedate + '::data', compress := TRUE);
				
		
																			
	addProvInfoSuper :=
			 FileServices.AddSuperFile(Filenames().prov_info_Input.Sprayed,
			                           Cluster1 + '::in::' + _Dataset().name + '::prov_information::' + filedate + '::data');
	addProvRelatSuper	:=
				FileServices.AddSuperFile(Filenames().prov_relat_Input.Sprayed,
																	Cluster1 + '::in::' + _Dataset().name + '::prov_relationship::' + filedate + '::data');
	addMedicaidSuper	:=									 
				FileServices.AddSuperFile(Filenames().medicaid_Input.Sprayed,
																	Cluster1 + '::in::' + _Dataset().name + '::medicaid::' + filedate + '::data');
	addTaxonomySuper	:=
				FileServices.AddSuperFile(Filenames().taxonomy_Input.Sprayed,
																	Cluster1 + '::in::' + _Dataset().name + '::taxonomy::' + filedate + '::data');
	addDemographicSuper	:=
				FileServices.AddSuperFile(Filenames().demographic_Input.Sprayed,
																	Cluster1 + '::in::' + _Dataset().name + '::demographic::' + filedate + '::data');
	addPayCenterSuper	:=
				FileServices.AddSuperFile(Filenames().pay_center_Input.Sprayed,
																	Cluster1 + '::in::' + _Dataset().name + '::pay_center::' + filedate + '::data');
	addParentOrgSuper	:=
				FileServices.AddSuperFile(Filenames().parent_org_Input.Sprayed,
																	Cluster1 + '::in::' + _Dataset().name + '::parent_org::' + filedate + '::data');
	addEprescribeSuper	:=
				FileServices.AddSuperFile(Filenames().eprescribe_Input.Sprayed,
																	Cluster1 + '::in::' + _Dataset().name + '::eprescribe::' + filedate + '::data');
	addRemitInfoSuper	:=
				FileServices.AddSuperFile(Filenames().remit_info_Input.Sprayed,
																	Cluster1 + '::in::' + _Dataset().name + '::remit_information::' + filedate + '::data');
	addStateLicSuper	:=
				FileServices.AddSuperFile(Filenames().state_lic_Input.Sprayed,
																	Cluster1 + '::in::' + _Dataset().name + '::state_license::' + filedate + '::data');
	addServiceSuper	:=
				FileServices.AddSuperFile(Filenames().services_info_Input.Sprayed,
																	Cluster1 + '::in::' + _Dataset().name + '::services_information::' + filedate + '::data');
	addChangeOwnerSuper	:=
				FileServices.AddSuperFile(Filenames().change_owner_Input.Sprayed,
																	Cluster1 + '::in::' + _Dataset().name + '::change_ownership::' + filedate + '::data');
/* Check to see if sprayed file is already in superfile.  If sprayed file is present,
   remove sprayed file from subsuperfile and respray and add to superfile again. */

	doProvInfoSeq :=
	  SEQUENTIAL(CreateProvInfoSuperfileIfNotExist,
							 IF(FileServices.FindSuperFileSubName(Filenames().prov_info_Input.Sprayed,
							                                      Cluster1 + '::in::' + _Dataset().name + '::prov_information::' + filedate + '::data') > 0,
									FileServices.RemoveSuperFile(Filenames().prov_info_Input.Sprayed,
									                             Cluster1 + '::in::' + _Dataset().name + '::prov_information::' + filedate + '::data'))
							 ,do_prov_info_spray
							 ,addProvInfoSuper);
	doProvRelatSeq	:=
		SEQUENTIAL(CreateProvRelatSuperfileIfNotExist,
							 IF(FileServices.FindSuperFileSubName(Filenames().prov_relat_Input.Sprayed,
																										Cluster1 + '::in::' + _Dataset().name + '::prov_relationship::' + filedate + '::data') > 0,
									FileServices.RemoveSuperFile(Filenames().prov_relat_Input.Sprayed,
																							 Cluster1 + '::in::' + _Dataset().name + '::prov_relationship::' + filedate + '::data'))
								,do_prov_relat_spray
								,addProvRelatSuper);
	doMedicaidSeq	:=
		SEQUENTIAL(CreateMedicaidSuperfileIfNotExist,
							 IF(FileServices.FindSuperFileSubName(Filenames().medicaid_Input.Sprayed,
																										Cluster1 + '::in::' + _Dataset().name + '::medicaid::' + filedate + '::data') > 0,
									FileServices.RemoveSuperFile(Filenames().medicaid_Input.Sprayed,
																							 Cluster1 + '::in::' + _Dataset().name + '::medicaid::' + filedate + '::data'))
								,do_medicaid_spray
								,addMedicaidSuper);
	doTaxonomySeq	:=
		SEQUENTIAL(CreateTaxonomySuperfileIfNotExist,
							 IF(FileServices.FindSuperFileSubName(Filenames().taxonomy_Input.Sprayed,
																										Cluster1 + '::in::' + _Dataset().name + '::taxonomy::' + filedate + '::data') > 0,
									FileServices.RemoveSuperFile(Filenames().taxonomy_Input.Sprayed,
																							 Cluster1 + '::in::' + _Dataset().name + '::taxonomy::' + filedate + '::data'))
									,do_taxonomy_spray
									,addTaxonomySuper);
	doDemographicSeq	:=
		SEQUENTIAL(CreateDemographicSuperfileIfNotExist,
							 IF(FileServices.FindSuperFileSubName(Filenames().demographic_Input.Sprayed,
																										Cluster1 + '::in::' + _Dataset().name + '::demographic::' + filedate + '::data') > 0,
									FileServices.RemoveSuperFile(Filenames().demographic_Input.Sprayed,
																							 Cluster1 + '::in::' + _Dataset().name + '::demographic::' + filedate + '::data'))
									,do_demographic_spray
									,addDemographicSuper);
	doPayCenterSeq	:=
		SEQUENTIAL(CreatePayCenterSuperfileIfNotExist,
							 IF(FileServices.FindSuperFileSubName(Filenames().pay_center_Input.Sprayed,
																										Cluster1 + '::in::' + _Dataset().name + '::pay_center::' + filedate + '::data') > 0,
									FileServices.RemoveSuperFile(Filenames().pay_center_Input.Sprayed,
																							 Cluster1 + '::in::' + _Dataset().name + '::pay_center::' + filedate + '::data'))
									,do_pay_center_spray
									,addPayCenterSuper);
	doParentOrgSeq	:=
		SEQUENTIAL(CreateParentOrgSuperfileIfNotExist,
							 IF(FileServices.FindSuperFileSubName(Filenames().parent_org_Input.Sprayed,
																										Cluster1 + '::in::' + _Dataset().name + '::parent_org::' + filedate + '::data') > 0,
									FileServices.RemoveSuperFile(Filenames().parent_org_Input.Sprayed,
																							 Cluster1 + '::in::' + _Dataset().name + '::parent_org::' + filedate + '::data'))
									,do_parent_org_spray
									,addParentOrgSuper);
	doEprescribeSeq	:=
		SEQUENTIAL(CreateEprescribeSuperfileIfNotExist,
							 IF(FileServices.FindSuperFileSubName(Filenames().eprescribe_Input.Sprayed,
																										Cluster1 + '::in::' + _Dataset().name + '::epresribe::' + filedate + '::data') > 0,
									FileServices.RemoveSuperFile(Filenames().eprescribe_Input.Sprayed,
																							 Cluster1 + '::in::' + _Dataset().name + '::epresribe::' + filedate + '::data'))
									,do_eprescribe_spray
									,addEprescribeSuper);
	doRemitInfoSeq	:=
		SEQUENTIAL(CreateRemitInfoSuperfileIfNotExist,
							 IF(FileServices.FindSuperFileSubName(Filenames().remit_info_Input.Sprayed,
																										Cluster1 + '::in::' + _Dataset().name + '::remit_information::' + filedate + '::data') > 0,
									FileServices.RemoveSuperFile(Filenames().remit_info_Input.Sprayed,
																							 Cluster1 + '::in::' + _Dataset().name + '::remit_information::' + filedate + '::data'))
									,do_remit_info_spray
									,addRemitInfoSuper);
	doStateLicSeq	:=
		SEQUENTIAL(CreateStateLicSuperfileIfNotExist,
							 IF(FileServices.FindSuperFileSubName(Filenames().state_lic_Input.Sprayed,
																										Cluster1 + '::in::' + _Dataset().name + '::state_license::' + filedate + '::data') > 0,
									FileServices.RemoveSuperFile(Filenames().state_lic_Input.Sprayed,
																							 Cluster1 + '::in::' + _Dataset().name + '::state_license::' + filedate + '::data'))
									,do_state_lic_spray
									,addStateLicSuper);
	doServiceSeq	:=
		SEQUENTIAL(CreateServiceInfoSuperfileIfNotExist,
							 IF(FileServices.FindSuperFileSubName(Filenames().services_info_Input.Sprayed,
																										Cluster1 + '::in::' + _Dataset().name + '::services_information::' + filedate + '::data') > 0,
									FileServices.RemoveSuperFile(Filenames().services_info_Input.Sprayed,
																							 Cluster1 + '::in::' + _Dataset().name + '::services_information::' + filedate + '::data'))
									,do_services_spray
									,addServiceSuper);
	doChangeOwnerSeq	:=
		SEQUENTIAL(CreateChangeOwnerSuperfileIfNotExist,
							 IF(FileServices.FindSuperFileSubName(Filenames().change_owner_Input.Sprayed,
																										Cluster1 + '::in::' + _Dataset().name + '::change_ownership::' + filedate + 'data') > 0,
									FileServices.RemoveSuperFile(Filenames().change_owner_Input.Sprayed,
																							 Cluster1 + '::in::' + _Dataset().name + '::change_owndership::' + filedate + '::data'))
									,do_change_owner_spray
									,addChangeOwnerSuper);
	
	doAll	:=
		PARALLEL(doProvInfoSeq,
						 doProvRelatSeq,
						 doMedicaidSeq,
						 doTaxonomySeq,
						 doDemographicSeq,
						 doPayCenterSeq,
						 doParentOrgSeq,
						 doEprescribeSeq,
						 doRemitInfoSeq,
						 doStateLicSeq,
						 doServiceSeq,
						 doChangeOwnerSeq);
	RETURN doAll;
END;