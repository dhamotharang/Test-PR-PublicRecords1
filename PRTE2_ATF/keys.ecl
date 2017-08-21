IMPORT doxie,bipv2,ut,Data_Services,autokeyb2,PRTE2_ATF, ATF;

EXPORT keys := MODULE
	SHARED df := PRTE2_ATF.files.SearchFile;

	EXPORT key_atf_bdid := index(df(bdid != ''),{bdid},{bdid,atf_id},Constants.KEY_PREFIX + doxie.Version_SuperKey + '::BDID');
	
	EXPORT key_atf_did (boolean isFCRA = FALSE) := FUNCTION
					file_prefix := if(IsFCRA, 
														Constants.KEY_PREFIX + 'fcra::',
														Constants.KEY_PREFIX);
	RETURN index(df(did != 0),{did},{atf_id},file_prefix + doxie.Version_SuperKey + '::did');
	END;
	
	EXPORT key_atf_id (boolean isFCRA = FALSE) := FUNCTION
				file_prefix := if(IsFCRA, 
													Constants.KEY_PREFIX + 'fcra::',
													Constants.KEY_PREFIX);
	RETURN index(df,{ATF_id},{df},file_prefix + doxie.Version_SuperKey + '::atfid');
	END;
	
	EXPORT key_atf_lnum := index(df,{license_number},{license_number,atf_id},Constants.KEY_PREFIX + doxie.Version_SuperKey + '::lnum');
	
	EXPORT Key_LinkIds := MODULE

  // DEFINE THE INDEX
	EXPORT out_SuperKeyName		:= Constants.KEY_PREFIX + doxie.Version_SuperKey + '::linkids'; //SuperKeyName

	SHARED Base						  	:= Project(PRTE2_ATF.files.Base_out, PRTE2_ATF.layouts.Base);

	BIPV2.IDmacros.mac_IndexWithXLinkIDs(Base, k, out_SuperKeyName)
	EXPORT Key := k;

	//DEFINE THE INDEX ACCESS
	EXPORT kFetch(
		DATASET(BIPV2.IDlayouts.l_xlink_ids) inputs, 
		STRING1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																								//Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																								//Should be enumerated or something?  at least need constants defined somewhere if you keep string1
		UNSIGNED2 ScoreThreshold = 0								//Applied at lowest leve of ID
		) :=	FUNCTION
		
		BIPV2.IDmacros.mac_IndexFetch(inputs, Key, out, Level)
		
	RETURN out;																					
	END;
		
	END;
	
END;
