IMPORT InsuranceHeader_Incremental,InsuranceHeader_Ingest,STD,InsuranceHeader_xLink,InsuranceHeader_Incremental_Best; 

EXPORT proc_xlink_Master(STRING version) := MODULE
	
		// run iteration
	version_use := version + '_' + WORKUNIT;
	
	       ingestFilename   := NOTHOR(STD.File.GetSuperFileSubName(InsuranceHeader_Ingest.FileNames.AsHeaderAll_SF.current,1));
	SHARED ingestDate       := ingestFilename[STD.str.find(ingestFilename,'_w',1) + 2..STD.str.find(ingestFilename,'-',1)-1];

	EXPORT runXLink         := InsuranceHeader.proc_xIdl(ingestDate).runxLink;
	
	EXPORT runXlinkPromote  := InsuranceHeader.proc_xlink_promote_update_idops(ingestDate).runxLink;
	
	// Give delta version as latest incremental+1 because delta will have everything plus corrections compared to latest full 
	
  SHARED deltaDate   := (STRING)InsuranceHeader_Incremental.Build_Date.deltaversion;
	
	EXPORT runFulldeltabase := InsuranceHeader_Incremental.Proc_FullbuildDelta(deltaDate);
	EXPORT runFulldeltaHierarchy := InsuranceHeader_Incremental_Best.Proc_addrHier(deltaDate,TRUE).run ;     
	EXPORT runFulldeltaBest :=      InsuranceHeader_Incremental_Best.Proc_Base(deltaDate).run ;	
	EXPORT runFulldeltaKeys := InsuranceHeader_Incremental.Proc_FullbuildDelta_Keys(deltaDate);	
	
END;