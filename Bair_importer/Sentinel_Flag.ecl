import Bair_importer,PromoteSupers;

EXPORT Sentinel_Flag := MODULE
	EXPORT fn_GetBairSentinelFlag() := FUNCTION
		res := dataset(bair_importer._constants.sentinel_flag_built,bair_importer.layouts.Bair_Sentinel_Flag, THOR,OPT);
		return res[1].sentinel;		
	END;
	EXPORT fn_SetBairSentinelFlag(boolean pStatus,string pVersion,boolean pUseProd) := FUNCTION
		dNew := dataset([{pStatus}],bair_importer.layouts.Bair_Sentinel_Flag);
		PromoteSupers.MAC_SF_BuildProcess(dNew,Bair_importer.Filenames().lBaseSentinelTemplate, doIt ,2,,true,pVersion);	
		return doIt;
	END;
END;
