﻿import DOPSGrowthCheck,dops;
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

OldRecords:=dataset('~thor_data400::DeltaStats::IndividualFileStats::full',DOPSGrowthCheck.layouts.Stats_Layout,thor,__compressed__,opt);

DopsGrowthCheck.layouts.Date_Compare_Layout tAlreadyDone(DopsGrowthCheck.layouts.Date_Compare_Layout L) := TRANSFORM
    SELF.Updated := if(exists(OldRecords(PackageName=L.PackageName and CurrVersion=L.CertVersion)),false,L.Updated);
    Self:=L;
END;

dAlreadyDone:=project(ChangedDataSets,tAlreadyDone(Left));

DOPSGrowthCheck.layouts.Build_Data_Layout tBuildData(DopsGrowthCheck.layouts.Date_Compare_Layout L, DopsGrowthCheck.layouts.Configuration_Layout R) := TRANSFORM
    Self.KeyFileNew:=R.KeyFilePre+L.CertVersion+R.KeyFilePost;
    Self.KeyFileOld:=R.KeyFilePre+L.ProdVersion+R.KeyFilePost;
    SELF := L;
    SELF := R;
END;

ChangedConfiguredDatasets:=join(dAlreadyDone(Updated=true),DOPSGrowthCheck.Configuration_File,
                            Left.PackageName=Right.PackageName,tBuildData(left,Right));

return ChangedConfiguredDatasets;
end;