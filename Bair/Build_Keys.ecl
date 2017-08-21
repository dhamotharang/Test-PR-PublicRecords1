import doxie, VersionControl, std;

export Build_Keys(string version, boolean pUseProd = false, boolean pDelta = false) := module
	
	shared promote_modname := Bair.promote(version,pUseProd,pDelta,false); //Promote keys
	
	export Build_Keys_Cfs_v2 := module
	
		shared lf := Bair.keynames(version,pUseProd,pDelta).cfs_v2_eid_key.new;
		VersionControl.macBuildNewLogicalKey(Bair.Keys(version,pUseProd,pDelta).cfs_v2_payload.New, BuildFile);																		
		export Cfs_v2_All := sequential(
													if(STD.File.FileExists(lf), output(lf + ' already exist;'), BuildFile),
													promote_modname.promote_Cfs_v2.buildfiles.New2Built
													);
	end;
	
	export Build_Keys_Cfs_officer_v2 := module
		
		shared lf := Bair.keynames(version,pUseProd,pDelta).cfs_officer_v2_eid_key.new;
		VersionControl.macBuildNewLogicalKey(Bair.Keys(version,pUseProd,pDelta).cfs_officer_v2_payload.New, BuildFile);																		
		export Cfs_officer_All := sequential(
															if(STD.File.FileExists(lf), output(lf + ' already exist;'), BuildFile),
															promote_modname.promote_Cfs_officer_v2.buildfiles.New2Built
															);
	end;
	
	export Build_Keys_mo := module
	
		shared lf := Bair.keynames(version,pUseProd,pDelta).mo_event_eid_key.new;
		VersionControl.macBuildNewLogicalKey(Bair.Keys(version,pUseProd,pDelta).mo_payload.New, BuildFile);																		
		export mo_All := sequential(
											if(STD.File.FileExists(lf), output(lf + ' already exist;'), BuildFile),
											promote_modname.promote_mo.buildfiles.New2Built
											);
	end;
	
	export Build_Keys_mo_udfv2 := module
	
		shared lf := Bair.keynames(version,pUseProd,pDelta).mo_udfv2_key.new;
		VersionControl.macBuildNewLogicalKey(Bair.Keys(version,pUseProd,pDelta).mo_udfv2_payload.New, BuildFile);																		
		export mo_udfv2_All := sequential(
													if(STD.File.FileExists(lf), output(lf + ' already exist;'), BuildFile),
													promote_modname.promote_mo_udfv2.buildfiles.New2Built
													);
	end;
	
	export Build_Keys_persons := module

		shared lf := Bair.keynames(version,pUseProd,pDelta).persons_event_eid_key.new;
		VersionControl.macBuildNewLogicalKey(Bair.Keys(version,pUseProd,pDelta).persons_payload.New, BuildFile);																		
		export persons_All := sequential(
													if(STD.File.FileExists(lf), output(lf + ' already exist;'), BuildFile),
													promote_modname.promote_persons.buildfiles.New2Built
													);
	end;
	
	export Build_Keys_persons_udfv2:= module
		
		shared lf := Bair.keynames(version,pUseProd,pDelta).persons_udfv2_key.new;
		VersionControl.macBuildNewLogicalKey(Bair.Keys(version,pUseProd,pDelta).persons_udfv2_payload.New, BuildFile);																		
		export persons_udfv2_All := sequential(
																if(STD.File.FileExists(lf), output(lf + ' already exist;'), BuildFile),
																promote_modname.promote_persons_udfv2.buildfiles.New2Built
																);
	end;
	
	export Build_Keys_vehicle := module
		
		shared lf := Bair.keynames(version,pUseProd,pDelta).vehicle_event_eid_key.new;
		VersionControl.macBuildNewLogicalKey(Bair.Keys(version,pUseProd,pDelta).vehicle_payload.New, BuildFile);																		
		export vehicle_All := sequential(
													if(STD.File.FileExists(lf), output(lf + ' already exist;'), BuildFile),
													promote_modname.promote_vehicle.buildfiles.New2Built
													);
	end;
	
	export Build_Keys_DataProvider := module
		
		shared lf := Bair.keynames(version,pUseProd,pDelta).DataProvider_id_key.new;
		VersionControl.macBuildNewLogicalKey(Bair.Keys(version,pUseProd,pDelta).DataProvider_payload.New, BuildFile);																		
		export DataProvider_All := sequential(
																if(STD.File.FileExists(lf), output(lf + ' already exist;'), BuildFile),
																promote_modname.promote_DataProvider.buildfiles.New2Built
																);
	end;
	
	export Build_Keys_group_access := module
		
		shared lf := Bair.keynames(version,pUseProd,pDelta).group_access_event_ori_key.new;
		VersionControl.macBuildNewLogicalKey(Bair.Keys(version,pUseProd,pDelta).group_access_payload.New, BuildFile);
																		
		export group_access_All := sequential(
																if(STD.File.FileExists(lf), output(lf + ' already exist;'), BuildFile),
																promote_modname.promote_group_access.buildfiles.New2Built
																);
	end;
	
	export Build_Keys_Offenders := module
		
		shared lf := Bair.keynames(version,pUseProd,pDelta).offenders_eid_key.new;
		VersionControl.macBuildNewLogicalKey(Bair.Keys(version,pUseProd,pDelta).offenders_payload.New, BuildFile);																		
		export Offenders_All := sequential(
														if(STD.File.FileExists(lf), output(lf + ' already exist;'), BuildFile),
														promote_modname.promote_Offenders.buildfiles.New2Built
														);
	end;
	
	export Build_Keys_Intel := module
		
		shared lf := Bair.keynames(version,pUseProd,pDelta).intel_eid_key.new;
		VersionControl.macBuildNewLogicalKey(Bair.Keys(version,pUseProd,pDelta).intel_payload.New, BuildFile);																		
		export Intel_All := sequential(
												if(STD.File.FileExists(lf), output(lf + ' already exist;'), BuildFile),
												promote_modname.promote_Intel.buildfiles.New2Built
												);
	end;
	
	export Build_Keys_Intel_v2 := module
		
		shared lf := Bair.keynames(version,pUseProd,pDelta).intel_v2_eid_key.new;
		VersionControl.macBuildNewLogicalKey(Bair.Keys(version,pUseProd,pDelta).intel_v2_payload.New, BuildFile);																		
		export Intel_v2_All := sequential(
														if(STD.File.FileExists(lf), output(lf + ' already exist;'), BuildFile),
														promote_modname.promote_Intel_v2.buildfiles.New2Built
														);
	end;
	
	export Build_Keys_Crash_v2 := module
		
		shared lf := Bair.keynames(version,pUseProd,pDelta).crash_v2_eid_key.new;
		VersionControl.macBuildNewLogicalKey(Bair.Keys(version,pUseProd,pDelta).crash_v2_payload.New, BuildFile);																		
		export Crash_v2_All := sequential(
														if(STD.File.FileExists(lf), output(lf + ' already exist;'), BuildFile),
														promote_modname.promote_crash_v2.buildfiles.New2Built
														);
	end;
	
	export Build_Keys_Crash_per_v2 := module
	
		shared lf := Bair.keynames(version,pUseProd,pDelta).crash_per_v2_eid_key.new;
		VersionControl.macBuildNewLogicalKey(Bair.Keys(version,pUseProd,pDelta).crash_per_v2_payload.New, BuildFile);																		
		export Crash_per_All := sequential(
														if(STD.File.FileExists(lf), output(lf + ' already exist;'), BuildFile),
														promote_modname.promote_Crash_per_v2.buildfiles.New2Built
														);
	end;
	
	export Build_Keys_Crash_veh_v2 := module
	
		shared lf := Bair.keynames(version,pUseProd,pDelta).crash_veh_v2_eid_key.new;
		VersionControl.macBuildNewLogicalKey(Bair.Keys(version,pUseProd,pDelta).crash_veh_v2_payload.New, BuildFile);																		
		export Crash_veh_All := sequential(
														if(STD.File.FileExists(lf), output(lf + ' already exist;'), BuildFile),
														promote_modname.promote_Crash_veh_v2.buildfiles.New2Built
														);
	end;
	
	export Build_Keys_LPR := module
	
		shared lf := Bair.keynames(version,pUseProd,pDelta).licenseplateevent_eid_key.new;
		VersionControl.macBuildNewLogicalKey(Bair.Keys(version,pUseProd,pDelta).LPR_payload.New, BuildFile);																		
		export LPR_All := sequential(
											if(STD.File.FileExists(lf), output(lf + ' already exist;'), BuildFile),
											promote_modname.promote_LPR.buildfiles.New2Built
											);
	end;
	
	export Build_Keys_Shotspotter := module
	
		shared lf := Bair.keynames(version,pUseProd,pDelta).Shotspotter_eid_key.new;
		VersionControl.macBuildNewLogicalKey(Bair.Keys(version,pUseProd,pDelta).Shotspotter_payload.New, BuildFile);																		
		export Shotspotter_All := sequential(
															if(STD.File.FileExists(lf), output(lf + ' already exist;'), BuildFile),
															promote_modname.promote_Shotspotter.buildfiles.New2Built
															);
	end;
	
	export Build_Keys_Notes := module
		
		shared lf := Bair.keynames(version,pUseProd,pDelta).Notes_eid_key.new;
		VersionControl.macBuildNewLogicalKey(Bair.Keys(version,pUseProd,pDelta).Notes_payload.New, BuildFile);																		
		export Notes_All := sequential(
												if(STD.File.FileExists(lf), output(lf + ' already exist;'), BuildFile),
												promote_modname.promote_Notes.buildfiles.New2Built
												);
	end;
	
	export Build_Keys_Images := module
		
		shared lf := Bair.keynames(version,pUseProd,pDelta).Images_eid_key.new;
		VersionControl.macBuildNewLogicalKey(Bair.Keys(version,pUseProd,pDelta).Images_payload.New, BuildFile);																		
		export Images_All := sequential(
													if(STD.File.FileExists(lf), output(lf + ' already exist;'), BuildFile),
													promote_modname.promote_Images.buildfiles.New2Built
													);
	end;
	
	export Build_Keys_Classification := module
		
		shared lf := Bair.keynames(version,pUseProd,pDelta).Classification_ori_key.new;
		VersionControl.macBuildNewLogicalKey(Bair.Keys(version,pUseProd,pDelta).Classification_payload.New, BuildFile);																		
		export Classification_All := sequential(
																	if(STD.File.FileExists(lf), output(lf + ' already exist;'), BuildFile),
																	promote_modname.promote_Classification.buildfiles.New2Built
																	);
	end;

end;