import Bair,ut;

EXPORT Orbit_Module_Agencies := MODULE
	//Add New Agency
	EXPORT fn_addAgency(String pAgencyName, String pBuildName, String  pMemberId, String  pBuildPrefix, UNSIGNED4 pFilesCount) := FUNCTION
		d := dataset([{pAgencyName,pBuildName,pMemberId,pBuildPrefix,pFilesCount}],Bair.Layouts.Orbit_Agencies_Layout);
		//Check if AgencyName already exists to avoid duplication
		exist_:=exists(Bair.Files().Orbit_Agencies(AgencyName = pAgencyName));
		dNew:=if(exist_,Bair.Files().Orbit_Agencies,Bair.Files().Orbit_Agencies + d);
		//Run Process
		ut.MAC_SF_BuildProcess(dNew,Bair.Filenames().Orbit_Agencies_Template, doIt ,3,false,true,'','');											
		return doIt;
	END;
	//Remove Agency
	 EXPORT fn_removeAgency(String pAgencyName) := FUNCTION
		 //Find AgencyName
		 dNew:=Bair.Files().Orbit_Agencies(AgencyName != pAgencyName);
		 //Run Process
		 ut.MAC_SF_BuildProcess(dNew,Bair.Filenames().Orbit_Agencies_Template, doIt ,3,false,true,'','');											
		 return doit;
	 END;	
END;