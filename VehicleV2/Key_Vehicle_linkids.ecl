IMPORT BIPV2, Doxie,AutoStandardI,mdr;

EXPORT Key_Vehicle_linkids := MODULE

 bip_key_new := record
  recordof(vehicleV2.File_VehicleV2_Party_Building) -[SRC_FIRST_DATE, SRC_LAST_DATE];
end;

 BipParty := project(vehicleV2.File_VehicleV2_Party_Building, transform(bip_key_new, self := left));

  // DEFINE THE INDEX
	BIPV2.IDmacros.mac_IndexWithXLinkIDs(BipParty, k, VehicleV2.Constant.str_linkid_keyname + doxie.Version_SuperKey);
	export Key := k;

	//DEFINE THE INDEX ACCESS
	export kFetch(
		dataset(BIPV2.IDlayouts.l_xlink_ids) inputs, 
		doxie.IDataAccess mod_access = MODULE(doxie.IDataAccess) END,  //Added for CCPA
		string1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																								//Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																								//Should be enumerated or something?  at least need constants defined somewhere if you keep string1
		unsigned2 ScoreThreshold = 0								//Applied at lowest leve of ID
		,BIPV2.mod_sources.iParams in_mod=PROJECT(AutoStandardI.GlobalModule(),BIPV2.mod_sources.iParams,opt)
		,JoinLimit = 25000
		) :=
	FUNCTION

		BIPV2.IDmacros.mac_IndexFetch(inputs, Key, fetched, Level, JoinLimit)
		VehicleV2.mac_check_access(fetched,out,mod_access); //Added for CCPA
		//the vl_id parameter is not applicable to DPPA sources
		ds_restricted := out(BIPV2.mod_sources.isPermitted(in_mod).bySource(MDR.sourceTools.fVehicles(state_origin,source_code),''));
		return ds_restricted;																					
		
	END;

END;