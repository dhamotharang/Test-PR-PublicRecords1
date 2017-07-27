IMPORT BIPV2, Data_Services, doxie, AutoStandardI, MDR, ut;

EXPORT Key_LinkIds := MODULE

  // DEFINE THE INDEX
	//shared superfile_name		:= Data_Services.Data_location.Prefix('LN_PropertyV2') + 'thor_data400::key::ln_propertyv2::'+doxie.Version_SuperKey+'::search.linkIds';
	shared superfile_name		:= '~' + 'thor_data400::key::ln_propertyv2::'+doxie.Version_SuperKey+'::search.linkIds';
		
	shared Base				:= LN_PropertyV2.file_search_building_Bip;
	//shared dkeybuild	:= project(Base, transform(frandx.layouts.keybuild, self := left));
	
	BIPV2.IDmacros.mac_IndexWithXLinkIDs(Base, k, superfile_name)

	export Key := k;

	//DEFINE THE INDEX ACCESS
	export kFetch2(
		dataset(BIPV2.IDlayouts.l_xlink_ids2) inputs, 
		string1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																								//Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																								//Should be enumerated or something?  at least need constants defined somewhere if you keep string1
		unsigned2 ScoreThreshold = 0,								//Applied at lowest leve of ID
		BIPV2.mod_sources.iParams in_mod=PROJECT(AutoStandardI.GlobalModule(),BIPV2.mod_sources.iParams,opt),
		joinLimit=25000,
		unsigned1 JoinType = BIPV2.IDconstants.JoinTypes.KeepJoin
		) :=
	FUNCTION

		BIPV2.IDmacros.mac_IndexFetch2(inputs, Key, ds_fetched, Level, joinLimit, JoinType);
		
		// We'd ordinarily pass SOURCE and VL_ID fields; this key doesn't have them but we can derive equivalents
		arg1:= MDR.sourceTools.fProperty(ds_fetched.ln_fares_id);
		arg2 := BIPV2.mod_sources.faux_vlid(ds_fetched.ln_fares_id[1]);
		ds_restricted := ds_fetched(BIPV2.mod_sources.isPermitted(in_mod).bySource(arg1,arg2));
		
		return ds_restricted;																					

	END;
	
	// Depricated version of the above kFetch2
	export kFetch(
		dataset(BIPV2.IDlayouts.l_xlink_ids) inputs, 
		string1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																								//Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																								//Should be enumerated or something?  at least need constants defined somewhere if you keep string1
		unsigned2 ScoreThreshold = 0,								//Applied at lowest leve of ID
		BIPV2.mod_sources.iParams in_mod=PROJECT(AutoStandardI.GlobalModule(),BIPV2.mod_sources.iParams,opt),
		joinLimit=25000
		) :=
	FUNCTION

		inputs_for2 := project(inputs, BIPV2.IDlayouts.l_xlink_ids2);
		f2 := kFetch2(inputs_for2, Level, ScoreThreshold, in_mod, joinLimit);
		return project(f2, recordof(Key));

	END;

END;
