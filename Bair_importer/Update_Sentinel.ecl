import Bair_importer,ut;

EXPORT Update_Sentinel := MODULE
	EXPORT fn_SetBairSentinelFlag(boolean pStatus) := FUNCTION
		
		d := dataset([{pStatus}],Bair_importer.Layouts.Bair_Sentinel_Flag);
		exist_:=exists(Bair.Files().Orbit_Agencies(AgencyName = pAgencyName));
		dNew:=if(exist_,       Bair.Files().Orbit_Agencies,        Bair.Files().Orbit_Agencies + d);
		//Run Process
		ut.MAC_SF_BuildProcess(dNew,Bair_importer.Filenames().bair_sentinel_flag, doIt ,3,false,true,'','');											
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