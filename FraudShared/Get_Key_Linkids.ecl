IMPORT BIPV2;

EXPORT Get_Key_Linkids := MODULE

  // DEFINE THE INDEX
	shared superfile_name	:= keynames().main.LinkIds.QA;
  
 	shared Base       := Project(Get_File_KeyBuild().File_KeyBuild,Layouts_Key.Main); 

	BIPV2.IDmacros.mac_IndexWithXLinkIDs(Base, k, superfile_name)
	
	export Key := k;

END;

