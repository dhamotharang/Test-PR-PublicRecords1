IMPORT BIPV2, Data_Services, doxie;

EXPORT Key_One_Click_Data_LinkIds  := MODULE

  // DEFINE THE INDEX
	EXPORT out_SuperKeyName		:= One_Click_Data.Keynames().LinkIds.qa; //SuperKeyName

	SHARED Base						  	:= One_Click_Data.Files().base.BUILT;
  
	Keybuild_Base             := PROJECT(Base,Layouts.Temporary.Keybuild_Linkids);
	
	BIPV2.IDmacros.mac_IndexWithXLinkIDs(Keybuild_Base, k, out_SuperKeyName)
	EXPORT Key := k;

	//DEFINE THE INDEX ACCESS
	EXPORT kFetch(
		DATASET(BIPV2.IDlayouts.l_xlink_ids) inputs, 
		STRING1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																								//Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																								//Should be enumerated or something?  at least need constants defined somewhere if you keep string1
		UNSIGNED2 ScoreThreshold = 0								//Applied at lowest leve of ID
		) :=
	FUNCTION

		BIPV2.IDmacros.mac_IndexFetch(inputs, Key, out, Level)
		RETURN out;																					

	END;

END;