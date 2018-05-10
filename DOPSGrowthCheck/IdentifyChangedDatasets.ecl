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

DOPSGrowthCheck.layouts.Build_Data_Layout tBuildData(DopsGrowthCheck.layouts.Date_Compare_Layout L, DopsGrowthCheck.layouts.Configuration_Layout R) := TRANSFORM
    SELF := L;
    SELF := R;
END;

ChangedConfiguredDatasets:=join(ChangedDatasets(Updated=true),DOPSGrowthCheck.Configuration_File,
                            Left.PackageName=Right.PackageName,tBuildData(left,Right));

return ChangedConfiguredDatasets;
end;