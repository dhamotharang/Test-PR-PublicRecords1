IMPORT  doxie,mdr, prte2_busreg,BIPV2;

EXPORT keys := MODULE

EXPORT key_busreg_company_bdid := INDEX(FILES.DS_busreg_bdid (bdid != 0),  {bdid},  {files.DS_busreg_bdid}, '~prte::key::busreg_company_bdid_' + doxie.Version_SuperKey );

EXPORT key_busreg_company_linkids := MODULE
BIPV2.IDmacros.mac_IndexWithXLinkIDs(files.DS_busreg_linkid, out_key, 
	    constants.KeyName_busreg + '_linkids_' + doxie.Version_SuperKey );
	
  Export Key:=out_key;
																	
//DEFINE THE INDEX ACCESS
	export kFetch2(
		dataset(BIPV2.IDlayouts.l_xlink_ids2) inputs, 
		string1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																								//Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																								//Should be enumerated or something?  at least need constants defined somewhere if you keep string1
		unsigned2 ScoreThreshold = 0,								//Applied at lowest leve of ID
		joinLimit = 25000,
		unsigned1 JoinType = BIPV2.IDconstants.JoinTypes.KeepJoin
		) :=
	FUNCTION

		BIPV2.IDmacros.mac_IndexFetch2(inputs, Key, out, Level, joinLimit, JoinType);
		return out;																					

	END;
	
	END;

END;

