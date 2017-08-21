import Bair,ut;

EXPORT Orbit_Module_Datasets := MODULE
	//Add New Dataset
	EXPORT fn_addDataset(String pFileNameID, String pOrbitId) := FUNCTION
		d := dataset([{pFileNameID,pOrbitId}],Bair.Layouts.Orbit_Datasets_Layout);
		//Check if FileNameID already exists to avoid duplication
		exist_:=exists(Bair.Files().Orbit_Datasets(FileNameID = pFileNameID));
		dNew:=if(exist_,Bair.Files().Orbit_Datasets,Bair.Files().Orbit_Datasets + d);
		//Run Process
		ut.MAC_SF_BuildProcess(dNew,Bair.Filenames().Orbit_Datasets_Template, doIt ,3,false,true,'','')					
		return doIt;
	END;
	//Remove Dataset
	 EXPORT fn_removeDataset(String pFileNameID) := FUNCTION
		 //Find FileNameID
		 dNew:=Bair.Files().Orbit_Datasets(FileNameID != pFileNameID);
		 //Run Process
		 ut.MAC_SF_BuildProcess(dNew,Bair.Filenames().Orbit_Datasets_Template, doIt ,3,false,true,'','');											
		 return doit;
	 END;	
END;