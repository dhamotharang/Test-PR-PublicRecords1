EXPORT Build_Updates(string version, boolean pUseProd = false) := MODULE

	//Delta files are build for every incremental update and these records are joined with full in the weekly update.
	export process_incremental_base(boolean pDelta = false, boolean EmptyBase = false)	:= function
	
		BuildBase_modname := bair.Build_Base(version,pUseProd,pDelta,EmptyBase);
		return parallel(
			BuildBase_modname.build_base_cfs.cfs_all,
			BuildBase_modname.build_base_mo.mo_all,
			BuildBase_modname.build_base_persons.persons_all,
			BuildBase_modname.build_base_vehicle.vehicle_all,
			BuildBase_modname.build_base_LPR.LPR_all,
			BuildBase_modname.build_base_mo_udf.mo_udf_all,
			BuildBase_modname.build_base_persons_udf.persons_udf_all,
			BuildBase_modname.build_base_intel.intel_all,
			BuildBase_modname.build_base_offenders.offenders_all,
			BuildBase_modname.build_base_offenders_picture.offenders_picture_all,
			BuildBase_modname.build_base_crash.crash_all,		
			BuildBase_modname.build_base_Shotspotter.Shotspotter_all,
			);
	end;
	
	process_full_refresh_base(boolean pDelta = false, boolean EmptyBase	= false)	:= function
	
		BuildBase_modname := bair.Build_Base(version,pUseProd,pDelta,EmptyBase);
		return sequential(
				parallel(			
					BuildBase_modname.build_base_DataProvider.DataProvider_all,
					BuildBase_modname.build_base_DataProviderLoc.DataProviderLoc_all,
					BuildBase_modname.build_base_DataProviderImp.DataProviderImp_all,
					BuildBase_modname.build_base_AddressLookup.AddressLookup_all,
					BuildBase_modname.build_base_AgencyDeletes.AgencyDeletes_all,
				),
				BuildBase_modname.build_base_AgencyCrimeTypeLookup.AgencyCrimeLookup_all,
				BuildBase_modname.build_base_AgencyCfsTypeLookup.AgencyCfsLookup_all,			
				BuildBase_modname.build_base_group_access.group_access_all,
				BuildBase_modname.build_base_Classification.Classification_all
			);
	end;
	
	shared process_base(boolean pDelta = false) := function
	
		BuildBase_modname := bair.Build_Base(version,pUseProd,pDelta);
		return sequential(
			if(pDelta, process_full_refresh_base(pDelta)),
			process_incremental_base(pDelta),
			parallel(
				BuildBase_modname.build_base_Images.images_all,
				BuildBase_modname.build_base_Notes.notes_all,
				bair.proc_GeoHash(version,pUseProd,pDelta).GeoHash_Keys(),
				// bair.proc_GeoHash(version,pUseProd,pDelta).GeoHash_LPR_Keys()
			),
			if(not pDelta, BuildBase_modname.build_base_AgencyDeletes.AgencyDeletes_all)
		);
	end;
	
	export delta_base := sequential(
												 Bair.Build_Composite(version, pUseProd, true).bld_curr_delta
												,Bair.Build_Composite(version, pUseProd, true).bld_all
												,process_base(true)
												);
	export full_base 	:= sequential(
												 Bair.Build_Composite(version, pUseProd, false).bld_all
												,process_base(false)
												);
				
	export process_incremental_key(boolean pDelta = false)	:= function
	
		BuildKeys_modname := bair.Build_Keys(version,pUseProd,pDelta);
		return parallel(
			BuildKeys_modname.Build_Keys_mo.mo_All,
			BuildKeys_modname.Build_Keys_persons.persons_All,
			BuildKeys_modname.Build_Keys_vehicle.vehicle_All,
			BuildKeys_modname.Build_Keys_LPR.LPR_All,
			BuildKeys_modname.Build_Keys_Mo_udfv2.Mo_udfv2_All,
			BuildKeys_modname.Build_Keys_Persons_udfv2.Persons_udfv2_All,
			BuildKeys_modname.Build_Keys_Intel.Intel_All,
			BuildKeys_modname.Build_Keys_Offenders.Offenders_All,							
			BuildKeys_modname.Build_Keys_Shotspotter.Shotspotter_All,
			BuildKeys_modname.Build_Keys_Cfs_v2.Cfs_v2_All,
			BuildKeys_modname.Build_Keys_Cfs_officer_v2.Cfs_officer_All,
			BuildKeys_modname.Build_Keys_Crash_v2.Crash_v2_All,
			BuildKeys_modname.Build_Keys_Crash_per_v2.Crash_per_All,
			BuildKeys_modname.Build_Keys_Crash_veh_v2.Crash_veh_All,
			BuildKeys_modname.Build_Keys_Intel_v2.Intel_v2_All,
			);
	end;
	
	export process_full_refresh_key(boolean pDelta = false)	:= function
	
		BuildKeys_modname := bair.Build_Keys(version,pUseProd,pDelta);
		return parallel(
			BuildKeys_modname.Build_Keys_group_access.group_access_All,
			BuildKeys_modname.Build_Keys_DataProvider.DataProvider_All,
			BuildKeys_modname.Build_Keys_Classification.Classification_All
			);
	end;
	
	shared process_key(boolean pDelta = false) := function 
	
		BuildKeys_modname := bair.Build_Keys(version,pUseProd,pDelta);
		return parallel(			
			if(pDelta, process_full_refresh_key(pDelta)),
			process_incremental_key(pDelta),
			BuildKeys_modname.Build_Keys_Images.Images_All,
			BuildKeys_modname.Build_Keys_Notes.Notes_All
		);
	end;
		
	export delta_key := process_key(true);
	export full_key  := process_key(false);
	
	export process_incremental_promote(boolean pDelta = false, boolean pBaseFileType = false)	:= function
	
		promote_modname				:= Bair.Promote(version, pUseProd, pDelta, pBaseFileType, '', false);
		promote_modname_w_del	:= Bair.Promote(version, pUseProd, pDelta, pBaseFileType, '', true);
		
		cfs_inter_has_owner_delete 			:= nothor(bair.util().dintermediate_super_owners(regexfind('::cfs::', name, nocase))[1].has_owner_delete);
		mo_inter_has_owner_delete 			:= nothor(bair.util().dintermediate_super_owners(regexfind('::mo::', name, nocase))[1].has_owner_delete);
		mo_udf_inter_has_owner_delete 	:= nothor(bair.util().dintermediate_super_owners(regexfind('::mo_udf::', name, nocase))[1].has_owner_delete);
		per_inter_has_owner_delete 			:= nothor(bair.util().dintermediate_super_owners(regexfind('::persons::', name, nocase))[1].has_owner_delete);
		per_udf_inter_has_owner_delete 	:= nothor(bair.util().dintermediate_super_owners(regexfind('::persons_udf::', name, nocase))[1].has_owner_delete);
		veh_inter_has_owner_delete 			:= nothor(bair.util().dintermediate_super_owners(regexfind('::vehicle::', name, nocase))[1].has_owner_delete);
		cra_inter_has_owner_delete 			:= nothor(bair.util().dintermediate_super_owners(regexfind('::crash::', name, nocase))[1].has_owner_delete);
		off_inter_has_owner_delete 			:= nothor(bair.util().dintermediate_super_owners(regexfind('::offenders::', name, nocase))[1].has_owner_delete);
		off_pic_inter_has_owner_delete 	:= nothor(bair.util().dintermediate_super_owners(regexfind('::offenders_picture::', name, nocase))[1].has_owner_delete);
		int_inter_has_owner_delete 			:= nothor(bair.util().dintermediate_super_owners(regexfind('::intel::', name, nocase))[1].has_owner_delete);
		lpr_inter_has_owner_delete 			:= nothor(bair.util().dintermediate_super_owners(regexfind('::licenseplateevent::', name, nocase))[1].has_owner_delete);
		shot_inter_has_owner_delete 		:= nothor(bair.util().dintermediate_super_owners(regexfind('::shotspotter::', name, nocase))[1].has_owner_delete);
	
		return 
				if(not pDelta or not pBaseFileType
					,parallel(
						promote_modname_w_del.Promote_cfs.buildfiles.Built2QA,
						promote_modname_w_del.Promote_mo.buildfiles.Built2QA,
						promote_modname_w_del.Promote_mo_udf.buildfiles.Built2QA,										
						promote_modname_w_del.Promote_mo_udfv2.buildfiles.Built2QA,										
						promote_modname_w_del.Promote_persons.buildfiles.Built2QA,
						promote_modname_w_del.Promote_persons_udf.buildfiles.Built2QA,										
						promote_modname_w_del.Promote_persons_udfv2.buildfiles.Built2QA,										
						promote_modname_w_del.Promote_vehicle.buildfiles.Built2QA,
						promote_modname_w_del.Promote_crash.buildfiles.Built2QA,
						promote_modname_w_del.Promote_offenders.buildfiles.Built2QA,
						promote_modname_w_del.Promote_offenders_picture.buildfiles.Built2QA,
						promote_modname_w_del.Promote_intel.buildfiles.Built2QA,
						promote_modname_w_del.Promote_LPR.buildfiles.Built2QA,														
						promote_modname_w_del.Promote_Shotspotter.buildfiles.Built2QA,
						promote_modname_w_del.promote_Cfs_v2.buildfiles.Built2QA,
						promote_modname_w_del.promote_Cfs_officer_v2.buildfiles.Built2QA,
						promote_modname_w_del.promote_crash_v2.buildfiles.Built2QA,
						promote_modname_w_del.promote_crash_per_v2.buildfiles.Built2QA,
						promote_modname_w_del.promote_crash_veh_v2.buildfiles.Built2QA,
						promote_modname_w_del.Promote_intel_v2.buildfiles.Built2QA,
						)
					,parallel(
						if(cfs_inter_has_owner_delete, promote_modname.promote_cfs.buildfiles.Built2QA, promote_modname_w_del.promote_cfs.buildfiles.Built2QA),
						if(mo_inter_has_owner_delete, promote_modname.Promote_mo.buildfiles.Built2QA, promote_modname_w_del.Promote_mo.buildfiles.Built2QA),
						if(mo_udf_inter_has_owner_delete, promote_modname.Promote_mo_udf.buildfiles.Built2QA, promote_modname_w_del.Promote_mo_udf.buildfiles.Built2QA),
						if(per_inter_has_owner_delete, promote_modname.Promote_persons.buildfiles.Built2QA, promote_modname_w_del.Promote_persons.buildfiles.Built2QA),
						if(per_udf_inter_has_owner_delete, promote_modname.Promote_persons_udf.buildfiles.Built2QA, promote_modname_w_del.Promote_persons_udf.buildfiles.Built2QA),
						if(veh_inter_has_owner_delete, promote_modname.Promote_vehicle.buildfiles.Built2QA, promote_modname_w_del.Promote_vehicle.buildfiles.Built2QA),
						if(cra_inter_has_owner_delete, promote_modname.Promote_crash.buildfiles.Built2QA, promote_modname_w_del.Promote_crash.buildfiles.Built2QA),
						if(off_inter_has_owner_delete, promote_modname.Promote_offenders.buildfiles.Built2QA, promote_modname_w_del.Promote_offenders.buildfiles.Built2QA),
						if(off_pic_inter_has_owner_delete, promote_modname.Promote_offenders_picture.buildfiles.Built2QA, promote_modname_w_del.Promote_offenders_picture.buildfiles.Built2QA),					
						if(int_inter_has_owner_delete, promote_modname.Promote_intel.buildfiles.Built2QA, promote_modname_w_del.Promote_intel.buildfiles.Built2QA),
						if(lpr_inter_has_owner_delete, promote_modname.Promote_LPR.buildfiles.Built2QA, promote_modname_w_del.Promote_LPR.buildfiles.Built2QA),
						if(shot_inter_has_owner_delete, promote_modname.Promote_Shotspotter.buildfiles.Built2QA, promote_modname_w_del.Promote_Shotspotter.buildfiles.Built2QA),
					)
				);
	end;
	
	export process_full_refresh_promote(boolean pDelta = false)	:= function
	
		del_inter_has_owner_delete 			:= nothor(bair.util().dintermediate_super_owners(regexfind('::agency_removed::', name, nocase))[1].has_owner_delete);
	
		promote_base_modname := bair.Promote(version,pUseProd,pDelta,true);
		promote_key_modname	 := bair.Promote(version,pUseProd,pDelta,false);
		
		return parallel(
				//promote base
				promote_base_modname.promote_DataProvider.buildfiles.Built2QA,
				promote_base_modname.Promote_group_access.buildfiles.Built2QA,
				promote_base_modname.promote_AgencyCrimeLookup.buildfiles.Built2QA,
				promote_base_modname.promote_AgencyCfsLookup.buildfiles.Built2QA,
				promote_base_modname.promote_Classification.buildfiles.Built2QA,
				promote_base_modname.promote_DataProviderLoc.buildfiles.Built2QA,
				promote_base_modname.promote_DataProviderImp.buildfiles.Built2QA,
				promote_base_modname.promote_AddressLookup.buildfiles.Built2QA,
				if(del_inter_has_owner_delete, bair.Promote(version,pUseProd,pDelta,true,'',false).promote_AgencyDeletes.buildfiles.Built2QA, bair.Promote(version,pUseProd,pDelta,true,'',true).promote_AgencyDeletes.buildfiles.Built2QA),
				
				//promote keys
				promote_key_modname.promote_DataProvider.buildfiles.Built2QA,
				promote_key_modname.Promote_group_access.buildfiles.Built2QA,
				promote_key_modname.promote_Classification.buildfiles.Built2QA,
				);
	end;			
	
	shared process_promote(boolean pDelta = false) := function
	
		promote_base_modname := bair.Promote(version,pUseProd,pDelta,true);
		promote_key_modname	 := bair.Promote(version,pUseProd,pDelta,false);

		return parallel(
			if(pDelta, process_full_refresh_promote(pDelta)),
			//Promote Base
			process_incremental_promote(pDelta, true),
			promote_base_modname.Promote_Images.buildfiles.Built2QA,
			promote_base_modname.Promote_Notes.buildfiles.Built2QA,
			if(pDelta, promote_base_modname.Promote_Geohash.buildfiles.Built2QA),
			// if(pDelta, promote_base_modname.Promote_Geohash_Lpr.buildfiles.Built2QA),
			if(not pDelta, promote_base_modname.promote_AgencyDeletes.buildfiles.Built2QA),
			
			//promote keys
			process_incremental_promote(pDelta, false),
			promote_key_modname.Promote_Images.buildfiles.Built2QA,
			promote_key_modname.Promote_Notes.buildfiles.Built2QA,
			if(pDelta, promote_key_modname.Promote_Geohash.buildfiles.Built2QA),
			// if(pDelta, promote_key_modname.Promote_Geohash_Lpr.buildfiles.Built2QA),
			if(not pDelta, promote_key_modname.promote_AgencyDeletes.buildfiles.Built2QA)
		);
	end;
	
	export promote_deltas := process_promote(true);
	export promote_full  	:= process_promote(false);
	
END;