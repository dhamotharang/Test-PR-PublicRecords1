import VersionControl, bair_composite;

EXPORT util(string version = '', boolean pUseProd = false, boolean pDelta = false):= MODULE
	
	shared FS := FileServices;
	
	nightly_files_list	:=	nothor(FS.LogicalFileList('*::in::bair::*',false,true))(~regexfind('history|helper::ucr_group_classifications|dbo::intersectioncoordinates|::rdi::|agency_layers',name));
	export MoveNightlyInputFilesToHistory := sequential(
					FS.StartSuperFileTransaction(),								
						nothor(apply(nightly_files_list, FS.PromoteSuperFileList(['~' + name, '~' + name + '::history'], ,true))),
					FS.FinishSuperFileTransaction()
						);
	
	prepped_files_list	:=	nothor(FS.LogicalFileList('*in::bair_prepped::*',false,true))(~regexfind('::history', name));
	export MovePreppedInputFilesToHistory := sequential(
					FS.StartSuperFileTransaction(),								
						nothor(apply(prepped_files_list, FS.PromoteSuperFileList(['~' + name, '~' + name + '::history'], ,true))),
					FS.FinishSuperFileTransaction()
						);
						
	export MovePreppedToInSuperFiles := sequential(
					 FS.StartSuperFileTransaction(),
						 nothor(FS.PromoteSuperFileList(['~thor_data400::in::prepped::cfs::dbo::cfs_2::built',bair.FileNames_Prepped(pUseProd).cfs_2_in])),
						 nothor(FS.PromoteSuperFileList(['~thor_data400::in::prepped::cfs::dbo::cfs_officers_2::built',bair.FileNames_Prepped(pUseProd).cfs_2_off_in])),
						 nothor(FS.PromoteSuperFileList(['~thor_data400::in::prepped::event::dbo::mo::built',bair.FileNames_Prepped(pUseProd).mo_in])),
						 nothor(FS.PromoteSuperFileList(['~thor_data400::in::prepped::event::dbo::mo_udf::built',bair.FileNames_Prepped(pUseProd).mo_udf_in])),
						 nothor(FS.PromoteSuperFileList(['~thor_data400::in::prepped::event::dbo::persons::built',bair.FileNames_Prepped(pUseProd).persons_in])),
						 nothor(FS.PromoteSuperFileList(['~thor_data400::in::prepped::event::dbo::persons_udf::built',bair.FileNames_Prepped(pUseProd).persons_udf_in])),
						 nothor(FS.PromoteSuperFileList(['~thor_data400::in::prepped::event::dbo::vehicles::built',bair.FileNames_Prepped(pUseProd).vehicle_in])),
						 nothor(FS.PromoteSuperFileList(['~thor_data400::in::prepped::crash::dbo::crash::built',bair.FileNames_Prepped(pUseProd).crash_in])),
						 nothor(FS.PromoteSuperFileList(['~thor_data400::in::prepped::crash::dbo::person::built',bair.FileNames_Prepped(pUseProd).cra_per_in])),
						 nothor(FS.PromoteSuperFileList(['~thor_data400::in::prepped::crash::dbo::vehicle::built',bair.FileNames_Prepped(pUseProd).cra_veh_in])),
						 nothor(FS.PromoteSuperFileList(['~thor_data400::in::prepped::lpr::dbo::licenseplateevent::built',bair.FileNames_Prepped(pUseProd).lpr_in])),
						 nothor(FS.PromoteSuperFileList(['~thor_data400::in::prepped::offenders::dbo::offender::built',bair.FileNames_Prepped(pUseProd).offender_in])),
						 nothor(FS.PromoteSuperFileList(['~thor_data400::in::prepped::offenders::dbo::offender_classification::built',bair.FileNames_Prepped(pUseProd).offender_class_in])),
						 nothor(FS.PromoteSuperFileList(['~thor_data400::in::prepped::offenders::dbo::offender_picture::built',bair.FileNames_Prepped(pUseProd).offender_pic_in])),
						 nothor(FS.PromoteSuperFileList(['~thor_data400::in::prepped::deletes::built',bair.FileNames_Prepped(pUseProd).agency_del_in])),
					 FS.FinishSuperFileTransaction()
						);
		
	shared dintermediate := nothor(fileservices.LogicalFileList('*::intermediate*', false, true));
	
	dbuilt_and_dintermediate_filenames
		:= table(dintermediate(~regexfind('geohash',name))
						,{d_built := if(regexfind('agency_deletes', name), regexreplace('::intermediate', name, '::built'), regexreplace('::intermediate_delta', name, '::delta::built'))
						,d_intermediate := name});

	export SaveDeltaBuiltBasesToIntermediary := sequential(
			FS.StartSuperFileTransaction(),
				nothor(apply(dbuilt_and_dintermediate_filenames, FS.AddSuperFile('~' + d_intermediate, '~' + d_built, addcontents := true))),
			FS.FinishSuperFileTransaction()
			);
	
	export dintermediate_super_owners
		:= table(dintermediate
				,{name
				,super_owners_cnt := if(FS.GetSuperFileSubName('~' + name, 1) <> ''
																,count(FS.LogicalFileSuperOwners('~' + FS.GetSuperFileSubName('~' + name, 1)))
																,0
																)
				,has_owner_delete	:= if(FS.GetSuperFileSubName('~' + name, 1) <> ''
																,if(count(FS.LogicalFileSuperOwners('~' + FS.GetSuperFileSubName('~' + name, 1))(regexfind('::delete', name))) > 0
																	,true
																	,false
																	)
																,false
																)
				});
				
	export RemoveIntermediaryDeltas := sequential(
			FS.StartSuperFileTransaction(),
				nothor(apply(dintermediate_super_owners, if(1 = super_owners_cnt, FS.ClearSuperFile('~' + name, true), FS.ClearSuperFile('~' + name)))),
			FS.FinishSuperFileTransaction()
			);
				
	export PromoteIntermediaryGeoHashFullToBuilt := sequential(
			 nothor(FS.PromoteSuperFileList([Bair.Filenames_Intermediary(pUseProd).Geohash_base, bair.Filenames().geohash_base.built, bair.Filenames().geohash_base.delete], deltail := true))
			// ,nothor(FS.PromoteSuperFileList([Bair.Filenames_Intermediary(pUseProd).Geohash_lpr_base, bair.Filenames().geohash_lpr_base.built, bair.Filenames().geohash_lpr_base.father, bair.Filenames().geohash_lpr_base.delete], deltail := true))
			,nothor(FS.PromoteSuperFileList([Bair.Filenames_Intermediary(pUseProd).Geohash_key, bair.keynames().geohash_key.built, bair.keynames().geohash_key.delete], deltail := true))
			// ,nothor(FS.PromoteSuperFileList([Bair.Filenames_Intermediary(pUseProd).Geohash_lpr_key, bair.keynames().geohash_lpr_key.built, bair.keynames().geohash_lpr_key.father, bair.keynames().geohash_lpr_key.delete], deltail := true))
			,nothor(FS.ClearSuperFile(bair.Filenames().geohash_base.qa))
			// ,nothor(FS.ClearSuperFile(bair.Filenames().geohash_lpr_base.qa))
			,nothor(FS.ClearSuperFile(bair.keynames().geohash_key.qa))
			// ,nothor(FS.ClearSuperFile(bair.keynames().geohash_lpr_key.qa))
			,FS.AddSuperFile(bair.Filenames().geohash_base.qa, bair.Filenames().geohash_base.built, addcontents := true)
			// ,FS.AddSuperFile(bair.Filenames().geohash_lpr_base.qa, bair.Filenames().geohash_lpr_base.built, addcontents := true)
			,FS.AddSuperFile(bair.keynames().geohash_key.qa, bair.keynames().geohash_key.built, addcontents := true)
			// ,FS.AddSuperFile(bair.keynames().geohash_lpr_key.qa, bair.keynames().geohash_lpr_key.built, addcontents := true)
			);
	
	EXPORT Comp_Delta_Clear:= sequential(	
			FS.StartSuperFileTransaction(),
				nothor(FS.RemoveOwnedSubFiles(bair_composite.Filenames(pUseProd,true).composite_input,true)),
				nothor(FS.ClearSuperFile(bair_composite.Filenames(pUseProd,true).composite_input)),
			FS.FinishSuperFileTransaction()
			);
					
	EXPORT Comp_Temp_Clear:= sequential(	
			FS.StartSuperFileTransaction(),
				nothor(FS.RemoveOwnedSubFiles(bair_composite.Filenames(pUseProd,true).composite_temp,true)),
				nothor(FS.ClearSuperFile(bair_composite.Filenames(pUseProd,true).composite_temp)),
			FS.FinishSuperFileTransaction()
			);
					
	EXPORT Comp_Temp_Set:= sequential(
			FS.StartSuperFileTransaction(),
				nothor(FS.addsuperfile(bair_composite.Filenames(pUseProd,true).composite_temp, '~thor400_data::base::composite_public_safety_data_delta', addcontents := true)),
			FS.FinishSuperFileTransaction()
			);
END;