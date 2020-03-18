import History_Analysis,ML_Core;

export fn_CalculateStatistics:=function

    loadfile:=History_Analysis.Files.History_Analysis_SF;

    addposrec:=record
    History_Analysis.Layouts.BaseRec;
    unsigned POS:=0;
    string wi:=1;
    end;

    AddingPOSField:=project(loadfile,transform(addposrec,self:=left;));
    SortFile:=sort(AddingPOSField,datasetname,superkey,updateflag,build_version);

    GroupFile:=group(SortFile,datasetname,superkey,updateflag);

    History_Analysis.Layouts.StatisticsRec tCalculate(addposrec L, dataset(addposrec) R):=TRANSFORM
        SortedListFileSizeReal:=sort(R,delta_size);
        RankedListFileSizeReal:=ML_Core.Utils.SequenceInField(SortedListFileSizeReal,delta_size,POS);
        FileSizeRealMedianPOS1:=MAX(RankedListFileSizeReal,pos)/2;
        FileSizeRealMedianPOS2:=MAX(RankedListFileSizeReal,pos)/2+1;

        Self.FileSizeReal.Median

        SortedListFileSizePerc:=sort(R,delta_size_perc);
        RankedListFileSizePerc:=ML_Core.Utils.SequenceInField(SortedListFileSizePerc,delta_size_perc,POS);

        SortedListNumberOfRecordsReal:=sort(R,delta_count);
        RankedListNumberOfRecordsReal:=ML_Core.Utils.SequenceInField(SortedListNumberOfRecordsReal,delta_count,POS);

        SortedListNumberOfRecordsPerc:=sort(R,delta_count_perc);
        RankedListNumberOfRecordsPerc:=ML_Core.Utils.SequenceInField(SortedListNumberOfRecordsPerc,delta_count_perc,POS);

        Self.FileSizeReal.Min:=min(R,delta_size);
        Self.FileSizeReal.Mean:=ave(R,delta_size);
        Self.FileSizeReal.Max:=max(R,delta_size);
        Self.FileSizeReal.Q1:=(self.FileSizeReal.Min+self.FileSizeReal.Mean)/2;
        Self.FileSizeReal.Q3:=(self.FileSizeReal.Max+self.FileSizeReal.Mean)/2;
        Self.FileSizeReal.Variance:=variance(R,delta_size);
        Self.FileSizeReal.StDev:=sqrt(Self.FileSizeReal.Variance);
        Self.FileSizeReal.Plus2StDev:=Self.FileSizeReal.Mean+(2*Self.FileSizeReal.StDev);
        Self.FileSizeReal.Minus2StDev:=Self.FileSizeReal.Mean-(2*Self.FileSizeReal.StDev);
        //Percent
        Self.FileSizePerc.Min:=min(R,delta_size_perc);
        Self.FileSizePerc.Mean:=ave(R,delta_size_perc);
        Self.FileSizePerc.Max:=max(R,delta_size_perc);
        Self.FileSizePerc.Q1:=(self.FileSizePerc.Min+self.FileSizePerc.Mean)/2;
        Self.FileSizePerc.Q3:=(self.FileSizePerc.Max+self.FileSizePerc.Mean)/2;
        Self.FileSizePerc.Variance:=variance(R,delta_size_perc);
        Self.FileSizePerc.StDev:=sqrt(Self.FileSizePerc.Variance);
        Self.FileSizePerc.Plus2StDev:=Self.FileSizePerc.Mean+(2*Self.FileSizePerc.StDev);
        Self.FileSizePerc.Minus2StDev:=Self.FileSizePerc.Mean-(2*Self.FileSizePerc.StDev);
        //Record Count Calculations
        //Real
        Self.NumberOfRecordsReal.Min:=min(R,delta_count);
        Self.NumberOfRecordsReal.Mean:=ave(R,delta_count);
        Self.NumberOfRecordsReal.Max:=max(R,delta_count);
        Self.NumberOfRecordsReal.Q1:=(self.NumberOfRecordsReal.Min+self.NumberOfRecordsReal.Mean)/2;
        Self.NumberOfRecordsReal.Q3:=(self.NumberOfRecordsReal.Max+self.NumberOfRecordsReal.Mean)/2;
        Self.NumberOfRecordsReal.Variance:=variance(R,delta_count);
        Self.NumberOfRecordsReal.StDev:=sqrt(Self.NumberOfRecordsReal.Variance);
        Self.NumberOfRecordsReal.Plus2StDev:=Self.NumberOfRecordsReal.Mean+(2*Self.NumberOfRecordsReal.StDev);
        Self.NumberOfRecordsReal.Minus2StDev:=Self.NumberOfRecordsReal.Mean-(2*Self.NumberOfRecordsReal.StDev);
        //Perc
        Self.NumberOfRecordsPerc.Min:=min(R,delta_count_perc);
        Self.NumberOfRecordsPerc.Mean:=ave(R,delta_count_perc);
        Self.NumberOfRecordsPerc.Max:=max(R,delta_count_perc);
        Self.NumberOfRecordsPerc.Q1:=(self.NumberOfRecordsPerc.Min+self.NumberOfRecordsPerc.Mean)/2;
        Self.NumberOfRecordsPerc.Q3:=(self.NumberOfRecordsPerc.Max+self.NumberOfRecordsPerc.Mean)/2;
        Self.NumberOfRecordsPerc.Variance:=variance(R,delta_count_perc);
        Self.NumberOfRecordsPerc.StDev:=sqrt(Self.NumberOfRecordsPerc.Variance);
        Self.NumberOfRecordsPerc.Plus2StDev:=Self.NumberOfRecordsPerc.Mean+(2*Self.NumberOfRecordsPerc.StDev);
        Self.NumberOfRecordsPerc.Minus2StDev:=Self.NumberOfRecordsPerc.Mean-(2*Self.NumberOfRecordsPerc.StDev);
        Self:=L;
    END;
//rollup(SecondGroup,GROUP,tCreateRecord(left,ROWS(left)));

    CalculateDelta:=rollup(GroupFile,GROUP,tCalculate(left,ROWS(left)));
return CalculateDelta;
end;