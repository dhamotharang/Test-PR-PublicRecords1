import LocationId_Ingest;
import LocationId_iLink;
import LocationId_xLink;

export proc_build_all := function
	
	prepIngest     := LocationId_Ingest.proc_ingest.prepIngest();                           
	runIngest      := LocationId_Ingest.proc_ingest.runIngest();                           
	preLocationID  := LocationId_iLink.proc_locationid.runPreprocess();                     
	locationID     := LocationId_iLink.proc_locationid.runLocationId(StartIter); 
	postLocationID := LocationId_iLink.proc_locationid.runPostProcess();                    
	buildKeys      := LocationId_xLink.proc_xLink.buildKeys();                            
	
	run_all := 
			sequential(
				 evaluate(prepIngest)
    ,evaluate(runIngest)
    ,evaluate(preLocationID)
    ,evaluate(locationID)
    ,evaluate(postLocationID)
    ,evaluate(buildKeys)
			);
			
	return run_all;

end;