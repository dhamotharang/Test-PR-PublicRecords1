import Bair_importer,PromoteSupers;

EXPORT Sentinel_Flag := MODULE
	EXPORT fn_GetBairSentinelFlag() := FUNCTION
		res := dataset(_constants.sentinel_flag_built,layouts.Bair_Sentinel_Flag, THOR,OPT);
		return res[1].sentinel;		
	END;
	EXPORT fn_SetBairSentinelFlag(boolean pStatus,string pVersion,boolean pUseProd) := FUNCTION
		dNew := dataset([{pStatus}],layouts.Bair_Sentinel_Flag);
		PromoteSupers.MAC_SF_BuildProcess(dNew,Filenames().lBaseSentinelTemplate, doIt ,2,,true,pVersion);	
		return doIt;
	END;
END;
