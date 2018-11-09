import tools, std;

lay_builds 	:= tools.Layout_FilenameVersions.builds;

export Promote(string     version      =  ''
							,boolean    pUseProd      = false
							,boolean		pDelta				= false
							,boolean		pBaseFileType	= false
							,string     pFilter       = ''
							,boolean    pDelete       = true
							,boolean    pisTesting    = false
							,unsigned1  pnGenerations = 3
				):= module
		
		export Promote_cfs := module				
			dataset(lay_builds)  pBuildFilenames := if(pBaseFileType
																									,bair.Filenames(version, pUseProd, pDelta).dbo_cfs_Base.dAll_filenames
																									,bair.keynames(version, pUseProd, pDelta).cfs_eid_key.dAll_filenames
																									);
			export buildfiles := tools.mod_PromoteBuild(version,pBuildFilenames,pFilter,pDelete,pisTesting := false, pnGenerations := 1);    
    end;
		
		export promote_Cfs_v2 := module		
			dataset(lay_builds)  pBuildFilenames := bair.keynames(version, pUseProd, pDelta).cfs_v2_eid_key.dAll_filenames;
			export buildfiles := tools.mod_PromoteBuild(version,pBuildFilenames,pFilter,pDelete,pisTesting := false, pnGenerations := 1);
		end;
		
		export promote_Cfs_officer_v2 := module		
			dataset(lay_builds)  pBuildFilenames := bair.keynames(version, pUseProd, pDelta).cfs_officer_v2_eid_key.dAll_filenames;
			export buildfiles := tools.mod_PromoteBuild(version,pBuildFilenames,pFilter,pDelete,pisTesting := false, pnGenerations := 1);
		end;
			
		export Promote_mo := module				
			dataset(lay_builds)  pBuildFilenames := if(pBaseFileType
																									,bair.Filenames(version, pUseProd, pDelta).dbo_event_mo_Base.dAll_filenames
																									,bair.keynames(version, pUseProd, pDelta).mo_event_eid_key.dAll_filenames
																									);
			export buildfiles := tools.mod_PromoteBuild(version,pBuildFilenames,pFilter,pDelete,pisTesting := false, pnGenerations := 1);    
    end;
		
		export promote_mo_udf := module				
			dataset(lay_builds)  pBuildFilenames := bair.Filenames(version, pUseProd, pDelta).event_dbo_mo_udf_Base.dAll_filenames;
			export buildfiles := tools.mod_PromoteBuild(version,pBuildFilenames,pFilter,pDelete,pisTesting := false, pnGenerations := 1);    
    end;
		
		export promote_mo_udfv2 := module				
			dataset(lay_builds)  pBuildFilenames := bair.keynames(version, pUseProd, pDelta).mo_udfv2_key.dAll_filenames;						
			export buildfiles := tools.mod_PromoteBuild(version,pBuildFilenames,pFilter,pDelete,pisTesting := false, pnGenerations := 1);    
    end;
		
		export Promote_persons := module				
			dataset(lay_builds)  pBuildFilenames := if(pBaseFileType
																									,bair.Filenames(version, pUseProd, pDelta).dbo_event_persons_Base.dAll_filenames
																									,bair.keynames(version, pUseProd, pDelta).persons_event_eid_key.dAll_filenames
																									);
			export buildfiles := tools.mod_PromoteBuild(version,pBuildFilenames,pFilter,pDelete,pisTesting := false, pnGenerations := 1);    
    end;
		
		export promote_persons_udf := module				
			dataset(lay_builds)  pBuildFilenames := bair.Filenames(version, pUseProd, pDelta).event_dbo_persons_udf_Base.dAll_filenames;
			export buildfiles := tools.mod_PromoteBuild(version,pBuildFilenames,pFilter,pDelete,pisTesting := false, pnGenerations := 1);    
    end;
		
		export promote_persons_udfv2 := module				
			dataset(lay_builds)  pBuildFilenames := bair.keynames(version, pUseProd, pDelta).persons_udfv2_key.dAll_filenames;			
			export buildfiles := tools.mod_PromoteBuild(version,pBuildFilenames,pFilter,pDelete,pisTesting := false, pnGenerations := 1);    
    end;
		
		export Promote_vehicle := module				
			dataset(lay_builds)  pBuildFilenames := if(pBaseFileType
																									,bair.Filenames(version, pUseProd, pDelta).dbo_event_vehicle_Base.dAll_filenames
																									,bair.keynames(version, pUseProd, pDelta).vehicle_event_eid_key.dAll_filenames
																									);
			export buildfiles := tools.mod_PromoteBuild(version,pBuildFilenames,pFilter,pDelete,pisTesting := false, pnGenerations := 1);    
    end;
		
		export promote_DataProvider := module						
			dataset(lay_builds)  pBuildFilenames := if(pBaseFileType
																									,bair.Filenames(version, pUseProd, pDelta).event_dbo_data_provider_Base.dAll_filenames
																									,bair.keynames(version, pUseProd, pDelta).DataProvider_id_key.dAll_filenames
																									);						
			export buildfiles := tools.mod_PromoteBuild(version,pBuildFilenames,pFilter,pDelete,pisTesting := false, pnGenerations := 1);    
    end;
		
		export promote_DataProviderLoc := module						
			dataset(lay_builds)  pBaseFilenames := bair.Filenames(version, pUseProd, pDelta).event_dbo_data_provider_location_Base.dAll_filenames;							
			export buildfiles := tools.mod_PromoteBuild(version,pBaseFilenames,pFilter,pDelete,pisTesting := false, pnGenerations := 1);						
    end;
		
		export promote_DataProviderImp := module						
			dataset(lay_builds)  pBaseFilenames := bair.Filenames(version, pUseProd, pDelta).event_dbo_data_provider_import_Base.dAll_filenames;							
			export buildfiles := tools.mod_PromoteBuild(version,pBaseFilenames,pFilter,pDelete,pisTesting := false, pnGenerations := 1);						
    end;
		
		export Promote_group_access := module						
			dataset(lay_builds)  pBuildFilenames := if(pBaseFileType
																									,bair.Filenames(version, pUseProd, pDelta).event_group_access_Base.dAll_filenames
																									,bair.keynames(version, pUseProd, pDelta).group_access_event_ori_key.dAll_filenames
																									);			
			export buildfiles := tools.mod_PromoteBuild(version,pBuildFilenames,pFilter,pDelete,pisTesting := false, pnGenerations := 1);			
    end;
		
		export Promote_intel := module				
			dataset(lay_builds)  pBuildFilenames := if(pBaseFileType
																									,bair.Filenames(version, pUseProd, pDelta).dbo_intel_Base.dAll_filenames
																									,bair.keynames(version, pUseProd, pDelta).intel_eid_key.dAll_filenames
																									);
			export buildfiles := tools.mod_PromoteBuild(version,pBuildFilenames,pFilter,pDelete,pisTesting := false, pnGenerations := 1);			
    end;
		
		export Promote_intel_v2 := module				
			dataset(lay_builds)  pBuildFilenames := bair.keynames(version, pUseProd, pDelta).intel_v2_eid_key.dAll_filenames;						
			export buildfiles := tools.mod_PromoteBuild(version,pBuildFilenames,pFilter,pDelete,pisTesting := false, pnGenerations := 1);    
    end;
		
		export Promote_offenders := module				
			dataset(lay_builds)  pBuildFilenames := if(pBaseFileType
																									,bair.Filenames(version, pUseProd, pDelta).dbo_offenders_Base.dAll_filenames
																									,bair.keynames(version, pUseProd, pDelta).offenders_eid_key.dAll_filenames
																									);
			export buildfiles := tools.mod_PromoteBuild(version,pBuildFilenames,pFilter,pDelete,pisTesting := false, pnGenerations := 1);    
    end;
		
		export Promote_offenders_picture := module						
			dataset(lay_builds)  pBaseFilenames := bair.Filenames(version, pUseProd, pDelta).dbo_offenders_picture_Base.dAll_filenames;
			export buildfiles := tools.mod_PromoteBuild(version,pBaseFilenames,pFilter,pDelete,pisTesting := false, pnGenerations := 1);    
    end;
		
		export Promote_offenders_class := module				
			dataset(lay_builds)  pBuildFilenames := bair.Filenames(version, pUseProd, pDelta).dbo_offenders_class_Base.dAll_filenames;
			export buildfiles := tools.mod_PromoteBuild(version,pBuildFilenames,pFilter,pDelete,pisTesting := false, pnGenerations := 1);    
    end;
		
		export Promote_crash := module				
			dataset(lay_builds)  pBuildFilenames := if(pBaseFileType
																									,bair.Filenames(version, pUseProd, pDelta).dbo_crash_Base.dAll_filenames
																									,bair.keynames(version, pUseProd, pDelta).crash_eid_key.dAll_filenames
																									);
			export buildfiles := tools.mod_PromoteBuild(version,pBuildFilenames,pFilter,pDelete,pisTesting := false, pnGenerations := 1);
    end;
		
		export promote_crash_v2 := module		
			dataset(lay_builds)  pBuildFilenames := bair.keynames(version, pUseProd, pDelta).crash_v2_eid_key.dAll_filenames;
			export buildfiles := tools.mod_PromoteBuild(version,pBuildFilenames,pFilter,pDelete,pisTesting := false, pnGenerations := 1);
		end;
		
		export promote_crash_per_v2 := module		
			dataset(lay_builds)  pBuildFilenames := bair.keynames(version, pUseProd, pDelta).crash_per_v2_eid_key.dAll_filenames;
			export buildfiles := tools.mod_PromoteBuild(version,pBuildFilenames,pFilter,pDelete,pisTesting := false, pnGenerations := 1);
		end;
		
		export promote_crash_veh_v2 := module		
			dataset(lay_builds)  pBuildFilenames := bair.keynames(version, pUseProd, pDelta).crash_veh_v2_eid_key.dAll_filenames;
			export buildfiles := tools.mod_PromoteBuild(version,pBuildFilenames,pFilter,pDelete,pisTesting := false, pnGenerations := 1);
		end;
		
		export Promote_LPR := module				
			dataset(lay_builds)  pBuildFilenames := if(pBaseFileType
																									,bair.Filenames(version, pUseProd, pDelta).lpr_dbo_LicensePlateEvent_Base.dAll_filenames
																									,bair.keynames(version, pUseProd, pDelta).licenseplateevent_eid_key.dAll_filenames
																									);
			export buildfiles := tools.mod_PromoteBuild(version,pBuildFilenames,pFilter,pDelete,pisTesting := false, pnGenerations := 1);    
    end;
			
		export Promote_Shotspotter := module				
			dataset(lay_builds)  pBuildFilenames := if(pBaseFileType
																									,bair.Filenames(version, pUseProd, pDelta).gunop_dbo_shot_incident_Base.dAll_filenames
																									,bair.keynames(version, pUseProd, pDelta).Shotspotter_eid_key.dAll_filenames
																									);
			export buildfiles := tools.mod_PromoteBuild(version,pBuildFilenames,pFilter,pDelete,pisTesting := false, pnGenerations := 1);
    end;
		
		export promote_Notes := module						
			dataset(lay_builds)  pBuildFilenames := if(pBaseFileType
																									,bair.Filenames(version, pUseProd, pDelta).Notes_Base.dAll_filenames
																									,bair.keynames(version, pUseProd, pDelta).notes_eid_dAll_filenames
																									);			
			export buildfiles := tools.mod_PromoteBuild(version,pBuildFilenames,pFilter,pDelete,pisTesting := false, pnGenerations := 1);
    end;
		
		export promote_Images := module						
			dataset(lay_builds)  pBuildFilenames := if(pBaseFileType
																									,bair.Filenames(version, pUseProd, pDelta).Images_Base.dAll_filenames
																									,bair.keynames(version, pUseProd, pDelta).images_eid_dAll_filenames
																									);						
			export buildfiles := tools.mod_PromoteBuild(version,pBuildFilenames,pFilter,pDelete,pisTesting := false, pnGenerations := 1);						
    end;
		
		export Promote_geohash := module						
			dataset(lay_builds)  pBuildFilenames := if(pBaseFileType
																									,bair.Filenames(version, pUseProd, pDelta).geohash_Base.dAll_filenames
																									,bair.keynames(version, pUseProd, pDelta).geohash_dAll_filenames
																									);						
			export buildfiles := tools.mod_PromoteBuild(version,pBuildFilenames,pFilter,pDelete,pisTesting := false, pnGenerations := 1);						
    end;		
		
		export Promote_geohash_lpr := module						
			dataset(lay_builds)  pBuildFilenames := if(pBaseFileType
																									,bair.Filenames(version, pUseProd, pDelta).geohash_lpr_Base.dAll_filenames
																									,bair.keynames(version, pUseProd, pDelta).geohash_lpr_dAll_filenames
																									);			
			export buildfiles := tools.mod_PromoteBuild(version,pBuildFilenames,pFilter,pDelete,pisTesting := false, pnGenerations := 1);						
    end;
		
		export promote_AgencyCrimeLookup := module						
			dataset(lay_builds)  pBuildFilenames := bair.Filenames(version, pUseProd, pDelta).event_dbo_AgencyCrimeTypeLookup_Base.dAll_filenames;			
			export buildfiles := tools.mod_PromoteBuild(version,pBuildFilenames,pFilter,pDelete,pisTesting := false, pnGenerations := 1);						
    end;
		
		export promote_AgencyCfsLookup := module						
			dataset(lay_builds)  pBuildFilenames := bair.Filenames(version, pUseProd, pDelta).cfs_dbo_AgencyCfsTypeLookup_Base.dAll_filenames;						
			export buildfiles := tools.mod_PromoteBuild(version,pBuildFilenames,pFilter,pDelete,pisTesting := false, pnGenerations := 1);						
    end;
		
		export promote_Classification := module						
			dataset(lay_builds)  pBuildFilenames := if(pBaseFileType
																									,bair.Filenames(version, pUseProd, pDelta).Classification_base.dAll_filenames
																									,bair.keynames(version,pUseProd, pDelta).Classification_ori_dAll_filenames
																									);			
			export buildfiles := tools.mod_PromoteBuild(version,pBuildFilenames,pFilter,pDelete,pisTesting := false, pnGenerations := 1);						
    end;
		
		export promote_AddressLookup := module						
			dataset(lay_builds)  pBuildFilenames := bair.Filenames(version, pUseProd, pDelta).event_address_lookup_Base.dAll_filenames;						
			export buildfiles := tools.mod_PromoteBuild(version,pBuildFilenames,pFilter,pDelete,pisTesting := false, pnGenerations := 1);						
    end;		
		
		export promote_AgencyDeletes := module						
			dataset(lay_builds)  pBuildFilenames := bair.Filenames(version, pUseProd, pDelta).agency_deletes_Base.dAll_filenames;						
			export buildfiles := tools.mod_PromoteBuild(version,pBuildFilenames,pFilter,pDelete,pisTesting := false, pnGenerations := 1);						
    end;
		
end;
