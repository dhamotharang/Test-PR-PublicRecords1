IMPORT BIPV2, dx_FraudDefenseNetwork;

EXPORT Get_Key_Linkids := MODULE

  // DEFINE THE INDEX
	SHARED superfile_name	:= dx_FraudDefenseNetwork.Names.i_LINKIDS_SF;
  
 	EXPORT Base       := PROJECT(File_KeyBuild(),dx_FraudDefenseNetwork.Layouts.Main); 

	BIPV2.IDmacros.mac_IndexWithXLinkIDs(Base, k, superfile_name)
	
	EXPORT Key := k;

END;

