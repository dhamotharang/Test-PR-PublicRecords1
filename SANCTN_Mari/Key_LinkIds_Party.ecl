import BIPV2, Data_Services, doxie,ut, versioncontrol;

EXPORT Key_LinkIds_Party := MODULE

	// DEFINE THE INDEX
	shared superfile_name		:= SANCTN_Mari.cluster_name + 'key::sanctn::np::qa::party_linkids';
  shared Base 						:= SANCTN_Mari.files_SANCTN_common.party_bip;
	base1										:= PROJECT(Base,{Base}-enh_did_src);			//Do not include enh_did_src flag in the keys
	
	BIPV2.IDmacros.mac_IndexWithXLinkIDs(base1, k, superfile_name);

	export Key := k;
	
	//DEFINE THE INDEX ACCESS
	export kFetch(
		dataset(BIPV2.IDlayouts.l_xlink_ids) inputs, 
		string1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																								//Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																								//Should be enumerated or something?  at least need constants defined somewhere if you keep string1
		unsigned2 ScoreThreshold = 0								//Applied at lowest leve of ID
		) :=
	FUNCTION

		BIPV2.IDmacros.mac_IndexFetch(inputs, Key, out, Level)
		return out;																					

	END;

END;