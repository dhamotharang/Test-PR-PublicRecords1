IMPORT  doxie,mdr, PRTE2_GSA, BIPV2;

EXPORT keys := MODULE

	EXPORT key_gsa_bdid := INDEX(
		FILES.file_base_old(bdid != 0), 
		{bdid}, 
		{FILES.file_base_old}, 
		Constants.KeyName_gsa + doxie.Version_SuperKey + '::bdid');

	EXPORT key_gsa_did := INDEX(
		FILES.file_base_old(did!=0), 
		{did}, 
		{Files.file_base_old}, 
		Constants.KeyName_gsa + doxie.Version_SuperKey + '::did');
		
	EXPORT key_gsa_gsa_id := INDEX(
		FILES.file_base_old, 
		{gsa_id}, 
		{Files.file_base_old}, 
		Constants.KeyName_gsa + doxie.Version_SuperKey + '::gsa_id');
	
	EXPORT Key_GSA_LinkIDs := MODULE
		BIPV2.IDmacros.mac_IndexWithXLinkIDs(Files.File_Keybuild, k, Constants.KeyName_gsa + doxie.Version_SuperKey + '::linkids')
		export Key := k;
		
		//DEFINE THE INDEX ACCESS
		export kFetch(
			dataset(BIPV2.IDlayouts.l_xlink_ids) inputs, 
			string1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
														//Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
														//Should be enumerated or something?  at least need constants defined somewhere if you keep string1
			unsigned2 ScoreThreshold = 0						//Applied at lowest leve of ID
			) :=
		FUNCTION
			BIPV2.IDmacros.mac_IndexFetch(inputs, Key, out, Level)
			return out;																					
		END;
	END;

	EXPORT key_gsa_lnpid := INDEX(
		FILES.file_lnpid(lnpid != 0), 
		{lnpid}, 
		{FILES.file_lnpid}, 
		Constants.KeyName_gsa + doxie.Version_SuperKey + '::lnpid');

END;
