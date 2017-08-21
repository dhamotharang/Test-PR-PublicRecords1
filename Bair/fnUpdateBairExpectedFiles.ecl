IMPORT Bair, ut;

EXPORT fnUpdateBairExpectedFiles := MODULE
	//Add New File Type
	EXPORT fn_addFileType(String pFileType, Boolean pRequired) := FUNCTION
		d := dataset([{pFileType,pRequired}],Bair.Layouts.FilesTypeLayout);
		//Check if File Type already exists to avoid duplication
		exist_:=exists(Bair.Files().Files_Type(fileType = pFileType));
		dNew:=if(exist_,Bair.Files().Files_Type,Bair.Files().Files_Type + d);
		//Run Process
		ut.MAC_SF_BuildProcess(dNew,Bair.Filenames().Files_Type_Template, doIt ,2,false,true,'','');											
		return doIt;
	END;
	//Remove File Type
	 EXPORT fn_removeFileType(String pFileType) := FUNCTION
		 //Find File Type
		 dNew:=Bair.Files().Files_Type(fileType != pFileType);
		 //Run Process
		 ut.MAC_SF_BuildProcess(dNew,Bair.Filenames().Files_Type_Template, doIt ,2,false,true,'','');											
		 return doit;
	 END;	

 	 EXPORT fn_changeFileType(String pFileType, Boolean pRequired) := FUNCTION
		 //Find File Type
		 d := dataset([{pFileType,pRequired}],Bair.Layouts.FilesTypeLayout);
		 dCurrent:=Bair.Files().Files_Type(fileType != pFileType);
		 dNew    := dCurrent + d;
		 //Run Process
		 ut.MAC_SF_BuildProcess(dNew,Bair.Filenames().Files_Type_Template, doIt ,2,false,true,'','');											
		 return doit;
	 END;	


END;