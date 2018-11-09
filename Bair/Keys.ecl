import doxie, tools, std, lib_stringlib;

export Keys(
	 string	 version		= ''
	,boolean pUseProd 	= false
	,boolean pDelta 		= false
) :=
module

	shared cfs_v2_Base
		:= dedup(project(bair.Files(version,pUseProd,pDelta).cfs_Base.Built(eid <> '' and quarantined = '0'), bair.layouts.cfs_v2_key), record, all);
	shared cfs_officer_v2_Base
		:= sort(
					dedup(
						project(bair.Files(version,pUseProd,pDelta).cfs_Base.Built(eid <> '' and quarantined = '0' and primary_officer <> '')
							,transform(bair.layouts.cfs_officer_v2_key
								,self.primary_officer_indicator := if(trim(left.primary_officer, left,right) in ['t','T','1','Y','y'], true, false)
								,self := left;))
					,record, all)
				,eid, -primary_officer_indicator, local);
	
	shared mo_event_Base
		:= project(bair.Files(version,pUseProd,pDelta).mo_Base.Built(LENGTH(eid)	> 3 and quarantined = '0'), bair.layouts.dbo_event_mo_final_Key);
	
	shared persons_event_Base
		:= project(bair.Files(version,pUseProd,pDelta).persons_Base.Built(LENGTH(eid)	> 3 and quarantined = '0'), bair.layouts.dbo_event_persons_final_Key);
	
	shared vehicle_event_Base
		:= project(bair.Files(version,pUseProd,pDelta).vehicle_Base.Built(LENGTH(eid)	> 3 and quarantined = '0'), bair.layouts.dbo_event_vehicle_final_Key);
	
	shared group_access_event_Base
		:= project(bair.Files(version,pUseProd,pDelta).group_access_Base.Built(ori	<> ''), bair.layouts.event_group_access_Key);
	
	shared DataProvider_Base
		:= project(bair.Files(version,pUseProd,pDelta).DataProvider_Base.Built(data_provider_id	<> 0), bair.layouts.event_dbo_data_provider_Key);
		
	shared Off_images
		:= dedup(
				project(bair.Files(version,pUseProd,pDelta).offenders_picture_Base.Built
					,transform({string23 eid, boolean has_image}
						,self.eid := left.eid;
						,self.has_image := if(left.picture_image <> '', true, false);))
			,record, all);
	
	shared offenders_Base
		:= join(
				distribute(bair.Files(version,pUseProd,pDelta).offenders_Base.Built(LENGTH(eid)	> 3 and quarantined = '0'), hash(eid))
				,distribute(Off_images, hash(eid))
				,left.eid = right.eid
				,transform(bair.layouts.dbo_offenders_Key,
						self.has_image := right.has_image;
						self := left;)
				,LEFT OUTER
				,local);
																					
	shared intel_Base
		:= project(bair.Files(version,pUseProd,pDelta).intel_Base.Built(LENGTH(eid)	> 3), bair.layouts.dbo_intel_Key);
	
	shared intel_v2_Base
		:= project(bair.Files(version,pUseProd,pDelta).intel_Base.Built(LENGTH(eid)	> 3), bair.layouts.intel_v2_Key);
		
	shared crash_v2_Base
		:= dedup(project(bair.Files(version,pUseProd,pDelta).crash_Base.Built(quarantined = '0'), bair.layouts.crash_v2_key), record, all);
	
	shared crash_per
		:= project(bair.Files(version,pUseProd,pDelta).crash_Base.Built(quarantined = '0'), transform(bair.layouts.crash_per_v2_key, self.personid := left.per_id; self.city := left.per_city; self.state := left.per_state; self.personvehicleid := left.vehicleid; self := left;));
	shared nonempty_crash_per
		:= crash_per(driver <> '' or first_name <> '' or last_name <> '' or  licensenumber <> '' or	licensestate <> '' or	race <> ''
																								or sex <> '' or city <> '' or state <> '' or age <> 0 or airbag <> '' or seatbelt <> '' or driveractions <> '');
	shared crash_per_v2_Base
		:= sort(distribute(dedup(nonempty_crash_per, record, all), hash(eid, PersonID)), eid, PersonID, local);
	
	shared crash_veh
		:= project(bair.Files(version,pUseProd,pDelta).crash_Base.Built(quarantined = '0'), bair.layouts.crash_veh_v2_key);
	shared nonempty_crash_veh
		:= crash_veh(vin <> '' or plate <> '' or platestate <> '' or year <> '' or make <> '' or model <> '' or towed <> ''
							or vehicle_type <> '' or damage <> '' or action <> '' or sequence <> '' or driverimpairment <> ''); 
	shared crash_veh_v2_Base
		:= sort(distribute(dedup(nonempty_crash_veh, record, all), hash(eid, VehicleID)), eid, VehicleID, local);
	
	shared licenseplateevent_Base
		:= project(bair.Files(version,pUseProd,pDelta).LPR_Base.Built(LENGTH(eid)	> 3)
					,transform(bair.layouts.lpr_dbo_LicensePlateEvent_Key,
							self.has_image := if(left.PlateImage <> '' or left.OverviewImage <> '', true, false);
							self := left;));
																							
	shared Shotspotter_Base
		:= project(bair.Files(version,pUseProd,pDelta).Shotspotter_Base.Built(LENGTH(eid)	> 3), bair.layouts.gunop_dbo_shot_incident_Key);

	shared Notes_Base
		:= bair.Files(version,pUseProd,pDelta).Notes_Keybuild.Keybuild;
	shared Images_Base
		:= bair.Files(version,pUseProd,pDelta).Images_Keybuild.Keybuild;
	
	shared Classification_Base
		:= bair.Files(version,pUseProd,pDelta).Classification_Base.Built(ori <> '');
	
	shared mudfv2
		:= Bair.proc_udfs(version, pUseProd, pDelta).mov2;
	shared pudfv2
		:= Bair.proc_udfs(version, pUseProd, pDelta).perv2;
	
	tools.mac_FilesIndex('mo_event_Base					,	{eid}	  						,	{mo_event_Base}'					,keynames(version,pUseProd,pDelta).mo_event_eid_key				,mo_payload);
	tools.mac_FilesIndex('mo_event_Base					,	{eid}	  						,	{mo_event_Base}'					,keynames(version,pUseProd,true).mo_event_eid_key						,mo_delta_payload);
	tools.mac_FilesIndex('persons_event_Base		,	{eid}	  						,	{persons_event_Base}'			,keynames(version,pUseProd,pDelta).persons_event_eid_key	,persons_payload);
	tools.mac_FilesIndex('persons_event_Base		,	{eid}	  						,	{persons_event_Base}'			,keynames(version,pUseProd,true).persons_event_eid_key				,persons_delta_Payload);
	
	tools.mac_FilesIndex('mudfv2 						  ,	{eid,data_provider_id,stamp},	{mudfv2}'						,keynames(version,pUseProd,pDelta).mo_udfv2_key					  ,mo_udfv2_payload);
	tools.mac_FilesIndex('mudfv2 						  ,	{eid,data_provider_id,stamp},	{mudfv2}'						,keynames(version,pUseProd,true).mo_udfv2_key					  		,mo_udfv2_delta_payload);
	tools.mac_FilesIndex('pudfv2 							,	{eid,data_provider_id,stamp},	{pudfv2}'						,keynames(version,pUseProd,pDelta).persons_udfv2_key			,persons_udfv2_payload);
	tools.mac_FilesIndex('pudfv2 							,	{eid,data_provider_id,stamp},	{pudfv2}'						,keynames(version,pUseProd,true).persons_udfv2_key						,persons_udfv2_delta_payload);
	
	tools.mac_FilesIndex('vehicle_event_Base			,{eid}	  					,{vehicle_event_Base}'							,keynames(version,pUseProd,pDelta).vehicle_event_eid_key			,vehicle_payload);
	tools.mac_FilesIndex('vehicle_event_Base			,{eid}	  					,{vehicle_event_Base}'							,keynames(version,pUseProd,true).vehicle_event_eid_key						,vehicle_delta_payload);
	tools.mac_FilesIndex('DataProvider_Base				,{data_provider_id}	,{DataProvider_Base}'								,keynames(version,pUseProd,pDelta).DataProvider_id_key				,DataProvider_payload);
	tools.mac_FilesIndex('group_access_event_Base	,{ori}	  					,{group_access_event_Base}'					,keynames(version,pUseProd,pDelta).group_access_event_ori_key	,group_access_payload);
	tools.mac_FilesIndex('offenders_Base					,{eid}	  					,{offenders_Base}'									,keynames(version,pUseProd,pDelta).offenders_eid_key					,offenders_payload);
	tools.mac_FilesIndex('intel_Base							,{eid}	  					,{intel_Base}'											,keynames(version,pUseProd,pDelta).intel_eid_key							,intel_payload);
	tools.mac_FilesIndex('licenseplateevent_Base	,{eid}	  					,{licenseplateevent_Base}'					,keynames(version,pUseProd,pDelta).licenseplateevent_eid_key	,LPR_payload);
	tools.mac_FilesIndex('licenseplateevent_Base	,{eid}	  					,{licenseplateevent_Base}'					,keynames(version,pUseProd,true).licenseplateevent_eid_key				,LPR_delta_payload);
	tools.mac_FilesIndex('Shotspotter_Base				,{eid}	  					,{Shotspotter_Base}'								,keynames(version,pUseProd,pDelta).Shotspotter_eid_key				,Shotspotter_payload);
	tools.mac_FilesIndex('Notes_Base							,{eid,ReferId} 			,{Note_Type,Seq,NoteLen,__filepos}' ,keynames(version,pUseProd,pDelta).Notes_eid_key							,Notes_payload);
	tools.mac_FilesIndex('Images_Base							,{eid}	  		 			,{Image_Type,ImageLen,__filepos}'		,keynames(version,pUseProd,pDelta).Images_eid_key							,Images_payload);
	tools.mac_FilesIndex('Classification_Base			,{ori,mode}					,{Classification_Base}'			  			,keynames(version,pUseProd,pDelta).Classification_ori_key			,Classification_payload);
	
	tools.mac_FilesIndex('cfs_v2_Base							,{eid}	  							,{cfs_v2_Base}'									,keynames(version,pUseProd,pDelta).cfs_v2_eid_key							,cfs_v2_payload);
	tools.mac_FilesIndex('cfs_v2_Base							,{eid}	  							,{cfs_v2_Base}'									,keynames(version,pUseProd,true).cfs_v2_eid_key									,cfs_delta_v2_payload);
	
	tools.mac_FilesIndex('cfs_officer_v2_Base			,{eid,primary_officer_indicator}	,{cfs_officer_v2_Base}'		,keynames(version,pUseProd,pDelta).cfs_officer_v2_eid_key			,cfs_officer_v2_payload);
	tools.mac_FilesIndex('cfs_officer_v2_Base			,{eid,primary_officer_indicator}	,{cfs_officer_v2_Base}'		,keynames(version,pUseProd,true).cfs_officer_v2_eid_key					,cfs_officer_delta_v2_payload);
	
	tools.mac_FilesIndex('crash_v2_Base						,{eid}	  							,{crash_v2_Base}'								,keynames(version,pUseProd,pDelta).crash_v2_eid_key						,crash_v2_payload);
	tools.mac_FilesIndex('crash_v2_Base						,{eid}	  							,{crash_v2_Base}'								,keynames(version,pUseProd,true).crash_v2_eid_key								,crash_delta_v2_payload);
	
	tools.mac_FilesIndex('crash_per_v2_Base				,{eid}	  							,{crash_per_v2_Base}'						,keynames(version,pUseProd,pDelta).crash_per_v2_eid_key				,crash_per_v2_payload);
	tools.mac_FilesIndex('crash_per_v2_Base				,{eid}	  							,{crash_per_v2_Base}'						,keynames(version,pUseProd,true).crash_per_v2_eid_key						,crash_per_delta_v2_payload);
	
	tools.mac_FilesIndex('crash_veh_v2_Base				,{eid}									,{crash_veh_v2_Base}'						,keynames(version,pUseProd,pDelta).crash_veh_v2_eid_key				,crash_veh_v2_payload);
	tools.mac_FilesIndex('crash_veh_v2_Base				,{eid}									,{crash_veh_v2_Base}'						,keynames(version,pUseProd,true).crash_veh_v2_eid_key						,crash_veh_delta_v2_payload);
	
	tools.mac_FilesIndex('intel_v2_Base						,{eid}	  							,{intel_v2_Base}'								,keynames(version,pUseProd,pDelta).intel_v2_eid_key						,intel_v2_payload);
end;
