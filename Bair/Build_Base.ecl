
//Defines full build process
import _control, versioncontrol, std, lib_stringlib;

export Build_Base( string		version		= ''
									,boolean	pUseProd	= false
									,boolean	pDelta		= false
									,boolean 	EmptyBase	= false
								 ) := module
  
	shared promote_base_modname := Bair.Promote(version, pUseProd,pDelta, true); //promote base
	
	export build_base_cfs := module	
					
		shared lf := Bair.Filenames(version, pUseProd, pDelta).dbo_cfs_Base.new;
		cfs := if(EmptyBase
							,dataset([], bair.layouts.dbo_cfs_Base)
							,Bair.AppendDID_Payload(version,pUseProd,pDelta).cfs_w_lexid
							);					
		VersionControl.macBuildNewLogicalFile(lf, cfs, BuildFile);
		export cfs_all := sequential(				
											 if(STD.File.FileExists(lf), output(lf + ' already exist;'), BuildFile)
											,promote_base_modname.promote_cfs.buildfiles.New2Built
											);
	end;	

	export build_base_mo := module
	
		shared lf := Bair.Filenames(version, pUseProd, pDelta).Dbo_event_mo_Base.new;
		mo := if(EmptyBase
						,dataset([], bair.layouts.dbo_event_mo_final_Base)
						,Bair.AppendDID_Payload(version,pUseProd,pDelta).mo_w_lexid
						// ,Bair.Update_Base(version,pUseProd,pDelta).MO_base
						);
		VersionControl.macBuildNewLogicalFile(lf, mo, BuildFile);
		export mo_all	:= sequential(				
											 if(STD.File.FileExists(lf), output(lf + ' already exist;'), BuildFile)
											,promote_base_modname.promote_mo.buildfiles.New2Built
											);
	end;
	
	export build_base_mo_udf := module
	
		shared lf := Bair.Filenames(version, pUseProd, pDelta).event_dbo_mo_udf_Base.new;
		mo_udf := if(EmptyBase
								,dataset([], bair.layouts.mo_udf_Base)
								,Bair.Update_Base(version,pUseProd,pDelta).MO_UDF_base
								);
		VersionControl.macBuildNewLogicalFile(lf, mo_udf, BuildFile);
		export mo_udf_all	:= sequential(				
													 if(STD.File.FileExists(lf), output(lf + ' already exist;'), BuildFile)
													,promote_base_modname.promote_mo_udf.buildfiles.New2Built
													);
	end;

	export build_base_persons := module
		
		shared lf := Bair.Filenames(version, pUseProd, pDelta).Dbo_event_persons_Base.new;
		eve_pers := if(EmptyBase
									,dataset([], bair.layouts.dbo_event_persons_final_Base)
									,Bair.AppendDID_Payload(version,pUseProd,pDelta).per_w_lexid
									);
		VersionControl.macBuildNewLogicalFile(lf, eve_pers, BuildFile);
		export persons_all := sequential(				
													 if(STD.File.FileExists(lf), output(lf + ' already exist;'), BuildFile)
													,promote_base_modname.promote_persons.buildfiles.New2Built
													);
	end;
	
	export build_base_persons_udf := module
					
		shared lf := Bair.Filenames(version, pUseProd, pDelta).event_dbo_persons_udf_Base.new;
		eve_pers_udf := if(EmptyBase
											,dataset([], bair.layouts.persons_udf_Base)
											,Bair.Update_Base(version,pUseProd,pDelta).PERSONS_UDF_base
											);
		VersionControl.macBuildNewLogicalFile(lf, eve_pers_udf, BuildFile);
		export persons_udf_all := sequential(				
															 if(STD.File.FileExists(lf), output(lf + ' already exist;'), BuildFile)
															,promote_base_modname.promote_persons_udf.buildfiles.New2Built
															);
	end;
		
	export build_base_vehicle := module
					
		shared lf := Bair.Filenames(version, pUseProd, pDelta).Dbo_event_vehicle_Base.new;
		eve_veh := if(EmptyBase
									,dataset([], bair.layouts.dbo_event_vehicle_final_Base)
									,Bair.Update_Base(version,pUseProd,pDelta).VEHICLE_base
									);
		VersionControl.macBuildNewLogicalFile(lf, eve_veh, BuildFile);
		export vehicle_all := sequential(				
													 if(STD.File.FileExists(lf), output(lf + ' already exist;'), BuildFile)
													,promote_base_modname.promote_vehicle.buildfiles.New2Built
													);
	end;
	
	export build_base_group_access := module
					
		shared lf := Bair.Filenames(version, pUseProd, pDelta).event_group_access_Base.new;
		group_access := if(EmptyBase
											,dataset([], bair.layouts.event_group_access_Base)
											,Bair.Update_Base(version,pUseProd,pDelta).GROUP_ACCESS_base
											);
		VersionControl.macBuildNewLogicalFile(lf, group_access, BuildFile);
		export group_access_all	:= sequential(				
																 if(STD.File.FileExists(lf), output(lf + ' already exist;'), BuildFile)
																,promote_base_modname.promote_group_access.buildfiles.New2Built
																);
	end;
		
	export build_base_intel := module
					
		shared lf := Bair.Filenames(version, pUseProd, pDelta).dbo_intel_Base.new;
		intel := if(EmptyBase
								,dataset([], bair.layouts.dbo_intel_Base)
								,Bair.Update_Base(version,pUseProd,pDelta).INTEL_base
								);
		VersionControl.macBuildNewLogicalFile(lf, intel, BuildFile);
		export intel_all := sequential(				
												 if(STD.File.FileExists(lf), output(lf + ' already exist;'), BuildFile)
												,promote_base_modname.promote_intel.buildfiles.New2Built
												);
	end;
	
	export build_base_offenders := module
					
		shared lf := Bair.Filenames(version, pUseProd, pDelta).Dbo_offenders_Base.new;
		offenders := if(EmptyBase
										,dataset([], bair.layouts.dbo_offenders_Base)
										,Bair.AppendDID_Payload(version,pUseProd,pDelta).off_w_lexid
										);
		VersionControl.macBuildNewLogicalFile(lf, offenders, BuildFile);
		export offenders_all := sequential(				
														 if(STD.File.FileExists(lf), output(lf + ' already exist;'), BuildFile)
														,promote_base_modname.promote_offenders.buildfiles.New2Built
														);
	end;
	
	export build_base_offenders_picture := module
					
		shared lf := Bair.Filenames(version, pUseProd, pDelta).Dbo_offenders_picture_Base.new;
		offenders_picture := if(EmptyBase
													,dataset([], bair.layouts.dbo_offenders_picture_Base)
													,Bair.Update_Base(version,pUseProd,pDelta).Offenders_Picture_base
													);
		VersionControl.macBuildNewLogicalFile(lf, offenders_picture, BuildFile);
		export offenders_picture_all := sequential(				
																		 if(STD.File.FileExists(lf), output(lf + ' already exist;'), BuildFile)
																		,promote_base_modname.promote_offenders_picture.buildfiles.New2Built
																		);
	end;
	
	export build_base_crash := module
					
		shared lf := Bair.Filenames(version, pUseProd, pDelta).Dbo_crash_Base.new;
		crash := if(EmptyBase
							,dataset([], bair.layouts.dbo_crash_Base)
							,Bair.AppendDID_Payload(version,pUseProd, pDelta).crash_w_lexid
							);
		VersionControl.macBuildNewLogicalFile(lf, crash, BuildFile);
		export crash_all := sequential(				
												 if(STD.File.FileExists(lf), output(lf + ' already exist;'), BuildFile)
												,promote_base_modname.promote_crash.buildfiles.New2Built
												);
	end;
	
	export build_base_LPR := module
					
		shared lf := Bair.Filenames(version, pUseProd, pDelta).lpr_Dbo_licenseplateevent_Base.new;
		LPR := if(EmptyBase
							,dataset([], bair.layouts.lpr_dbo_LicensePlateEvent_Base)
							,Bair.Update_Base(version,pUseProd, pDelta).LPR_base
							);
		VersionControl.macBuildNewLogicalFile(lf, LPR, BuildFile);
		export LPR_all := sequential(				
											 if(STD.File.FileExists(lf), output(lf + ' already exist;'), BuildFile)
											,promote_base_modname.promote_LPR.buildfiles.New2Built
											);
	end;
	
	export build_base_Shotspotter := module
					
		shared lf := Bair.Filenames(version, pUseProd, pDelta).gunop_Dbo_shot_incident_Base.new;
		Shotspotter := if(EmptyBase
										,dataset([], bair.layouts.gunop_dbo_shot_incident_Base)
										,Bair.Update_Base(version,pUseProd,pDelta).SHOTSPOTTER_base
										);
		VersionControl.macBuildNewLogicalFile(lf, Shotspotter, BuildFile);
		export Shotspotter_all := sequential(				
															 if(STD.File.FileExists(lf), output(lf + ' already exist;'), BuildFile)
															,promote_base_modname.promote_Shotspotter.buildfiles.New2Built
															);
	end;
	
	export build_base_DataProvider := module
					
		shared lf := Bair.Filenames(version, pUseProd, pDelta).event_dbo_data_provider_Base.new;
		DataProvider := if(EmptyBase
											,dataset([], bair.layouts.event_dbo_data_provider_Base)
											,Bair.Update_Base(version,pUseProd,pDelta).DataProvider_Base
											);
		VersionControl.macBuildNewLogicalFile(lf, DataProvider, BuildFile);
		export DataProvider_all := sequential(				
									 if(STD.File.FileExists(lf), output(lf + ' already exist;'), BuildFile)
									,promote_base_modname.promote_DataProvider.buildfiles.New2Built
									);
	end;
	
	export build_base_DataProviderLoc := module
					
		shared lf := Bair.Filenames(version, pUseProd, pDelta).event_dbo_data_provider_location_Base.new;
		DataProviderLoc := if(EmptyBase
													,dataset([], bair.layouts.event_dbo_data_provider_location_In)
													,Bair.Update_Base(version,pUseProd,pDelta).DataProviderLoc_Base
													);
		VersionControl.macBuildNewLogicalFile(lf, DataProviderLoc, BuildFile);
		export DataProviderLoc_all := sequential(				
																	 if(STD.File.FileExists(lf), output(lf + ' already exist;'), BuildFile)
																	,promote_base_modname.promote_DataProviderLoc.buildfiles.New2Built
																	);
	end;
	
	export build_base_DataProviderImp := module
					
		shared lf := Bair.Filenames(version, pUseProd, pDelta).event_dbo_data_provider_import_Base.new;
		DataProviderImp := if(EmptyBase
													,dataset([], bair.layouts.event_dbo_data_provider_import_In)
													,Bair.Update_Base(version,pUseProd,pDelta).DataProviderImp_Base
													);
		VersionControl.macBuildNewLogicalFile(lf, DataProviderImp, BuildFile);
		export DataProviderImp_all := sequential(				
																	 if(STD.File.FileExists(lf), output(lf + ' already exist;'), BuildFile)
																	,promote_base_modname.promote_DataProviderImp.buildfiles.New2Built
																	);
	end;
	
	export build_base_AgencyCrimeTypeLookup := module
					
		shared lf := Bair.Filenames(version, pUseProd, pDelta).event_dbo_AgencyCrimeTypeLookup_Base.new;
		AgencyCrimeLookup := Update_Base(version,pUseProd,pDelta).AgencyCrimeTypeLookup_base;
		VersionControl.macBuildNewLogicalFile(lf, AgencyCrimeLookup, BuildFile);
		export AgencyCrimeLookup_all := sequential(				
																		 if(STD.File.FileExists(lf), output(lf + ' already exist;'), BuildFile)
																		,promote_base_modname.promote_AgencyCrimeLookup.buildfiles.New2Built
																		);
	end;
	
	export build_base_AgencyCfsTypeLookup := module
					
		shared lf := Bair.Filenames(version, pUseProd, pDelta).cfs_dbo_AgencyCfsTypeLookup_Base.new;
		AgencyCfsLookup := Update_Base(version,pUseProd,pDelta).AgencyCfsTypeLookup_base;
		VersionControl.macBuildNewLogicalFile(lf, AgencyCfsLookup, BuildFile);
		export AgencyCfsLookup_all := sequential(				
																	 if(STD.File.FileExists(lf), output(lf + ' already exist;'), BuildFile)
																	,promote_base_modname.promote_AgencyCfsLookup.buildfiles.New2Built
																	);
	end;
	
	export build_base_Notes := module
					
		shared lf := Bair.Filenames(version, pUseProd, pDelta).Notes_Base.new;
		Notes := if(EmptyBase
								,dataset([], bair.layouts.Notes_Base)
								,Bair.Update_Base(version,pUseProd, pDelta).Notes_base
								);
		VersionControl.macBuildNewLogicalFile(lf, Notes, BuildFile, pCompress := false);
		export Notes_all := sequential(				
												 if(STD.File.FileExists(lf), output(lf + ' already exist;'), BuildFile)
												,promote_base_modname.promote_Notes.buildfiles.New2Built
												);
	end;

	export build_base_Images := module
					
		shared lf := Bair.Filenames(version, pUseProd, pDelta).Images_Base.new;
		Images := if(EmptyBase
								,dataset([], bair.layouts.Images_Base)
								,Bair.Update_Base(version,pUseProd, pDelta).Images_base
								);		
		VersionControl.macBuildNewLogicalFile(lf, Images, BuildFile, pCompress := false);
		export Images_all := sequential(				
													 if(STD.File.FileExists(lf), output(lf + ' already exist;'), BuildFile)
													,promote_base_modname.promote_Images.buildfiles.New2Built
													);
	end;
	
	export build_base_Classification := module
					
		shared lf := Bair.Filenames(version, pUseProd, pDelta).Classification_base.new;
		Classification := if(EmptyBase
												,dataset([], bair.layouts.ClassificationLayout)
												,Bair.Update_Base(version,pUseProd, pDelta).Classification_base
												);
		VersionControl.macBuildNewLogicalFile(lf, Classification, BuildFile);
		export Classification_all := sequential(				
																	 if(STD.File.FileExists(lf), output(lf + ' already exist;'), BuildFile)
																	,promote_base_modname.promote_Classification.buildfiles.New2Built
																	);
	end;
	
	export build_base_AddressLookup := module
					
		shared lf := Bair.Filenames(version, pUseProd, pDelta).event_address_lookup_Base.new;
		AddressLookup := if(EmptyBase
											,dataset([], bair.layouts.AddressLookup_In)
											,Bair.Update_Base(version,pUseProd, pDelta).AddressLookup_base
											);
		VersionControl.macBuildNewLogicalFile(lf, AddressLookup, BuildFile);
		export AddressLookup_all := sequential(				
																 if(STD.File.FileExists(lf), output(lf + ' already exist;'), BuildFile)
																,promote_base_modname.promote_AddressLookup.buildfiles.New2Built
																);
	end;
	
	export build_base_AgencyDeletes := module
					
		shared lf := Bair.Filenames(version, pUseProd, pDelta).agency_deletes_Base.new;
		AgencyDeletes := if(EmptyBase
											,dataset([], bair.layouts.AgencyDeletes_Base)
											,Bair.Update_Base(version,pUseProd, pDelta).AgencyDeletes_base
											);
		VersionControl.macBuildNewLogicalFile(lf, AgencyDeletes, BuildFile);
		export AgencyDeletes_all := sequential(				
																 if(STD.File.FileExists(lf), output(lf + ' already exist;'), BuildFile)
																,promote_base_modname.promote_AgencyDeletes.buildfiles.New2Built
																);
	end;
		
end;
