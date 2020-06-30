IMPORT BIPV2, doxie, AutoStandardI, MDR,LN_PropertyV2;

EXPORT Key_LinkIds := MODULE

	export Key(boolean isFast =false) := FUNCTION 
	
		// DEFINE THE INDEX
		keyPrefix := if(isFast,'property_fast','ln_propertyv2');
		superfile_name		:= '~thor_data400::key::'+keyPrefix+'::'+doxie.Version_SuperKey+'::search.linkIds';
		
		base0	:=	LN_PropertyV2_Fast.file_search_building_Bip(LN_PropertyV2.File_Search_DID,false);
		base1	:=	LN_PropertyV2_Fast.file_search_building_Bip(LN_PropertyV2_Fast.Files.basedelta.search_prp,true);
			
		Base	:= if(isFast,base1,base0);
		//shared dkeybuild	:= project(Base, transform(frandx.layouts.keybuild, self := left));
		
		BIPV2.IDmacros.mac_IndexWithXLinkIDs(Base, k, superfile_name);
		
		return k;
	END;

	//DEFINE THE INDEX ACCESS
	export kFetch(
		dataset(BIPV2.IDlayouts.l_xlink_ids) inputs, 
		string1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																								//Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																								//Should be enumerated or something?  at least need constants defined somewhere if you keep string1
		unsigned2 ScoreThreshold = 0,								//Applied at lowest leve of ID
		BIPV2.mod_sources.iParams in_mod=PROJECT(AutoStandardI.GlobalModule(),BIPV2.mod_sources.iParams,opt),
		boolean isFast = false
		) :=
	FUNCTION

		BIPV2.IDmacros.mac_IndexFetch(inputs, Key(isFast), ds_fetched, Level)
		
		// We'd ordinarily pass SOURCE and VL_ID fields; this key doesn't have them but we can derive equivalents
		arg1:= MDR.sourceTools.fProperty(ds_fetched.ln_fares_id);
		arg2 := BIPV2.mod_sources.faux_vlid(ds_fetched.ln_fares_id[1]);
		ds_restricted := ds_fetched(BIPV2.mod_sources.isPermitted(in_mod).bySource(arg1,arg2));
		
		return ds_restricted;																					

	END;

END;