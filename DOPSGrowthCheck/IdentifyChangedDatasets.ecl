import DOPSGrowthCheck,dops;
export IdentifyChangedDatasets := function 
    CertList:=dops.GetDeployedDatasets('Q','B','F');
    ProdList:=dops.GetDeployedDatasets('P','B','F');

DopsRec:=Recordof(CertList);

DopsGrowthCheck.layouts.Date_Compare_Layout tCompare(DopsRec L, DopsRec R) := transform
	Self.PackageName:=L.datasetname;
	Self.CertVersion:=L.buildversion;
	Self.ProdVersion:=R.buildversion;
	Self.Updated:=if(Self.CertVersion>Self.ProdVersion,true,false);
end;

ChangedDataSets:=join(CertList,ProdList,Left.datasetname=Right.datasetname,tCompare(Left,Right));

	oldrecsPlus:=dataset('~thor_data400::DeltaStats::CalculateStatsAlerts::full',DOPSGrowthCheck.layouts.CalculateStatAlerts,thor,__compressed__,opt);

	newrecsPlus:=dataset('~thor_data400::DeltaStats::CalculateStatsAlerts::using',DOPSGrowthCheck.layouts.CalculateStatAlerts,thor,__compressed__,opt);
	
	OldRecords := oldrecsPlus + newrecsPlus;

DopsGrowthCheck.layouts.Date_Compare_Layout tAlreadyDone(DopsGrowthCheck.layouts.Date_Compare_Layout L) := TRANSFORM
    SELF.Updated := if(exists(OldRecords(PackageName=L.PackageName and CurrVersion=L.CertVersion)),false,L.Updated);
    Self:=L;
END;

dAlreadyDone:=project(ChangedDataSets,tAlreadyDone(Left));

return dAlreadyDone(Updated=true);
end;