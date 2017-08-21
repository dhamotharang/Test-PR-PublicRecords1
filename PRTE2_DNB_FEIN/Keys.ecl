IMPORT PRTE2_DNB_FEIN, DNB_FEINV2, Experian_FEIN, doxie, bipv2, ut, Data_Services, AutoKeyB2, autokey, AutoKeyI, AutoStandardI;

EXPORT Keys := MODULE

	SHARED	base_recs := PRTE2_DNB_FEIN.Files.DNB_base;
	
	//BDID
	slim_party := TABLE(base_recs((unsigned6)bdid != 0), {base_recs.bdid,
                               base_recs.tmsid});
	slim_dedup  := DEDUP(SORT(slim_party, tmsid, bdid),tmsid, bdid);
	
	EXPORT key_DNB_Fein_BDID := INDEX(slim_dedup,{unsigned6 p_bdid :=(unsigned6)bdid},{TMSID},
																		PRTE2_DNB_FEIN.Constants.KEY_PREFIX +  doxie.Version_SuperKey + '::bdid');
																		
	//TMSID
	slim_rec := RECORD
		DNB_FEINV2.layout_DNB_fein_base_main - case_duns_number;
  END;

	slim_main := PROJECT(base_recs, slim_rec);
	sort_id := SORT(slim_main, TMSID);

	EXPORT 	key_dnb_fein_tmsid := INDEX(sort_id,{TMSID},{sort_id},
																			PRTE2_DNB_FEIN.Constants.KEY_PREFIX +  doxie.Version_SuperKey + '::TMSID');
																			
	//LinkIDs - DNB
	EXPORT Key_LinkIds := MODULE
		SHARED  base_new 					:= PROJECT(PRTE2_DNB_FEIN.Files.Main_di_ref, TRANSFORM(DNB_FEINV2.layout_DNB_fein_base_main_new, SELF := LEFT));
		EXPORT out_logicalKeyName := Constants.KEY_PREFIX + doxie.Version_SuperKey + '::linkids'; //SuperKeyName
	
		BIPV2.IDmacros.mac_IndexWithXLinkIDs(base_new, out_key, out_logicalKeyName);
	
		EXPORT Key := out_key;

  //DEFINE THE INDEX ACCESS
		EXPORT KeyFetch(
			dataset(BIPV2.IDlayouts.l_xlink_ids) in_ds_withids, 
			string1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																												 //Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																												//Should be enumerated or something?  at least need constants defined somewhere if you keep string1
			unsigned2 ScoreThreshold = 0											 //Applied at lowest leve of ID
								) :=FUNCTION

			BIPV2.IDmacros.mac_IndexFetch(in_ds_withids, Key, out_fetch, Level)
		RETURN out_fetch;																					
		END;
	END;
	
	//LinkIDs - Experian
	EXPORT Key_LinkIds_exp := MODULE

  // DEFINE THE INDEX
	SHARED superfile_name	:= Constants.EXP_KEY_PREFIX + doxie.Version_SuperKey + '::linkids';;
	
	SHARED Base			   	  := PRTE2_DNB_FEIN.Files.Experian_base;
		
	BIPV2.IDmacros.mac_IndexWithXLinkIDs(Base, kExp, superfile_name)
	EXPORT Key_exp := kExp;

	//DEFINE THE INDEX ACCESS
		EXPORT kFetch_exp(
			dataset(BIPV2.IDlayouts.l_xlink_ids) inputs, 
			string1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																														//Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																														//Should be enumerated or something?  at least need constants defined somewhere if you keep string1
			unsigned2 ScoreThreshold = 0,													//Applied at lowest leve of ID
			BIPV2.mod_sources.iParams in_mod=PROJECT(AutoStandardI.GlobalModule(),BIPV2.mod_sources.iParams,opt)
			) := FUNCTION

			BIPV2.IDmacros.mac_IndexFetch(inputs, Key_exp, ds_fetched, Level);
    
    // Apply restrictions
			ds_restricted := ds_fetched(BIPV2.mod_sources.isPermitted(in_mod).bySource(source));
    
		RETURN ds_restricted;																					
		END;
	END;
	
END;