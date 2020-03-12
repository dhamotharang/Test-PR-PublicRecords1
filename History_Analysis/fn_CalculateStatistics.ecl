import History_Analysis;

export fn_CalculateStatistics:=function

    loadfile:=History_Analysis.Files.History_Analysis_SF;

    SortFile:=sort(loadfile,datasetname,superkey,updateflag,build_version);

    GroupFile:=group(SortFile,datasetname,superkey,updateflag);

    History_Analysis.Layouts.StatisticsRec tCalculate(History_Analysis.Layouts.BaseRec L, dataset(History_Analysis.Layouts.BaseRec) R):=TRANSFORM
        //File Size Calculations
        Self.FileSize.Min:=min(R,delta_size);
        Self.FileSize.Mean:=ave(R,delta_size);
        Self.FileSize.Max:=max(R,delta_size);
        Self.FileSize.Q1:=(self.FileSize.Min+self.FileSize.Mean)/2;
        Self.FileSize.Q3:=(self.FileSize.Max+self.FileSize.Mean)/2;
        Self.FileSize.Variance:=variance(R,delta_size);
        Self.FileSize.StDev:=sqrt(Self.FileSize.Variance);
        Self.FileSize.Plus2StDev:=Self.FileSize.Mean+(2*Self.FileSize.StDev);
        Self.FileSize.Minus2StDev:=Self.FileSize.Mean-(2*Self.FileSize.StDev);
        //Record Count Calculations
        Self.NumberOfRecords.Min:=min(R,delta_count);
        Self.NumberOfRecords.Mean:=ave(R,delta_count);
        Self.NumberOfRecords.Max:=max(R,delta_count);
        Self.NumberOfRecords.Q1:=(self.NumberOfRecords.Min+self.NumberOfRecords.Mean)/2;
        Self.NumberOfRecords.Q3:=(self.NumberOfRecords.Max+self.NumberOfRecords.Mean)/2;
        Self.NumberOfRecords.Variance:=variance(R,delta_count);
        Self.NumberOfRecords.StDev:=sqrt(Self.NumberOfRecords.Variance);
        Self.NumberOfRecords.Plus2StDev:=Self.NumberOfRecords.Mean+(2*Self.NumberOfRecords.StDev);
        Self.NumberOfRecords.Minus2StDev:=Self.NumberOfRecords.Mean-(2*Self.NumberOfRecords.StDev);
        Self:=L;
    END;

return '';
end;