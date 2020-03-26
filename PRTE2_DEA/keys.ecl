IMPORT doxie,ut,Data_Services, BIPV2;

EXPORT keys := MODULE

	EXPORT Key_DEA_did 		:= INDEX(files.File_DEA((integer)did != 0),{unsigned6 my_did :=(integer)did},{files.File_DEA},constants.KeyName_DEA + doxie.Version_SuperKey + '::did');

	EXPORT Key_DEA_Bdid 	:= INDEX(files.File_DEA((integer)bdid != 0),{unsigned6 bd := (integer)bdid},{files.File_DEA},constants.KeyName_DEA + doxie.Version_SuperKey + '::bdid');

	EXPORT Key_dea_reg_num 	:= INDEX(files.Base_Full(Dea_Registration_Number != ''),{Dea_Registration_Number},{files.Base_Full}, constants.KeyName_DEA + doxie.Version_SuperKey +  '::reg_num');

	EXPORT Key_DEA_LNPID 	:= INDEX(files.DEAid_base((integer)lnpid != 0),{LNPID},{files.DEAid_base},constants.KeyName_DEA + doxie.Version_SuperKey +   '::lnpid');

	EXPORT Key_dea_linkids := MODULE
	    // DEFINE THE INDEX
		shared superfile_name	:= constants.KeyName_DEA + doxie.Version_SuperKey +  '::linkids';
		BIPV2.IDmacros.mac_IndexWithXLinkIDs(files.File_DEA_Modified, k, superfile_name)
		export Key := k;
		//DEFINE THE INDEX ACCESS
		export kFetch(
			dataset(BIPV2.IDlayouts.l_xlink_ids) inputs, 
			string1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																	//Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																	//Should be enumerated or something?  at least need constants defined somewhere if you keep string1
			unsigned2 ScoreThreshold = 0							//Applied at lowest leve of ID
			) :=
			FUNCTION
				BIPV2.IDmacros.mac_IndexFetch(inputs, Key, out, Level)
				return out;																					
			END;
	END;
END;














