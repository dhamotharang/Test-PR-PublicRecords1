import BIPV2, Data_Services, doxie,ut, versioncontrol;

EXPORT key_LINKIDS := MODULE
    
	// DEFINE THE INDEX
	shared superfile_name		:= Data_services.data_location.prefix('DEFAULT') + 'thor_data400::key::NCPDP::' +doxie.Version_SuperKey+ '::linkids';
    // This project is used to remove the record_type which was added to the Keybuild record layout
	shared Base := project(NCPDP.Files().Keybuild_base.built, ncpdp.Layouts.Keybuild - [record_type]);


	BIPV2.IDmacros.mac_IndexWithXLinkIDs(Base, k, superfile_name)
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
