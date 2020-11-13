import History_Analysis,ML_Core, PromoteSupers;

export MLCoreCalculateStatistics( String pVersion ):=function

loadfile:= History_Analysis.Files(pVersion).Counted_Deltas;

WithRecID:=RECORD
    unsigned recid:=0;
    History_Analysis.Layouts.BaseRec;
END;

AddRecID:=project(loadfile,transform(withRecID,self:=left;));

WithRecID tAssignRecID(WithRecID L,WithRecID R, INTEGER C):=TRANSFORM
    Self.recid:=C;
    SELF := R;
END;

AssignRecID:=iterate(AddRecID,tAssignRecID(left,right,counter));
ML_Core.ToField(AssignRecID,MLReady,recid,,,'delta_size,delta_size_perc,delta_count,delta_count_perc');
//SimpleStats:=ML_Core.FieldAggregates(MLReady).simple;
//MedianStats:=ML_Core.FieldAggregates(MLReady).medians;

//output(SimpleStats,named('SimpleStats'));
//output(MedianStats,named('MedianStats'));
CombinedRec:=RECORD
    String25   datasetname;
    String60   superkey;
    String1    updateflag;
    ML_Core.Types.NumericField;
END;

CombinedRec tCombine(WithRecID L, ML_Core.Types.NumericField R):=TRANSFORM
    Self.datasetname:=L.datasetname;
    Self.superkey:=L.superkey;
    Self.updateflag:=L.updateflag;
    Self.wi:=R.wi;
    Self.id:=R.id;
    Self.number:=R.number;
    Self.value:=R.value;
END;

CombineMLWithData:=join(AssignRecID,MLReady,left.recid=right.id,tcombine(left,right));

 SortFile:=sort(CombineMLWithData,datasetname,superkey,updateflag);

    GroupFile:=group(SortFile,datasetname,superkey,updateflag);

History_Analysis.Layouts.StatisticsRec tCalculate(CombinedRec L, dataset(CombinedRec) R):=TRANSFORM
        ReduceToML:=project(R,transform(ML_Core.Types.NumericField,Self:=left;));
        SimpleStats:=sort(ML_Core.FieldAggregates(ReduceToML).simple,number);
        MedianStats:=sort(ML_Core.FieldAggregates(ReduceToML).medians,number);
        self.numberofdeltas:=count(R);
        
        Self.FileSizeReal.Min:=SimpleStats[1].minval;
        Self.FileSizeReal.Mean:=SimpleStats[1].mean;
        Self.FileSizeReal.Max:=SimpleStats[1].maxval;
        Self.FileSizeReal.Median:=MedianStats[1].median;
        Self.FileSizeReal.Q1:=(self.FileSizeReal.Min+self.FileSizeReal.Median)/2;
        Self.FileSizeReal.Q3:=(self.FileSizeReal.Max+self.FileSizeReal.Median)/2;
        Self.FileSizeReal.Variance:=SimpleStats[1].var;
        Self.FileSizeReal.StDev:=SimpleStats[1].sd;
        Self.FileSizeReal.Plus2StDev:=Self.FileSizeReal.Mean+(2*Self.FileSizeReal.StDev);
        Self.FileSizeReal.Minus2StDev:=Self.FileSizeReal.Mean-(2*Self.FileSizeReal.StDev);
        self.FileSizeReal.NumLessThanQ1:=count(R(number=1 and value<Self.FileSizeReal.Q1));
        self.FileSizeReal.BtwnQ1AndQ3:=count(R(number=1 and value>=Self.FileSizeReal.Q1 and value<=Self.FileSizeReal.Q3));
        self.FileSizeReal.NumMoreThanQ3:=count(R(number=1 and value>Self.FileSizeReal.Q3));
        //Percent
        Self.FileSizePerc.Min:=SimpleStats[2].minval;
        Self.FileSizePerc.Mean:=SimpleStats[2].mean;
        Self.FileSizePerc.Max:=SimpleStats[2].maxval;
        self.FileSizePerc.Median:=MedianStats[2].Median;
        Self.FileSizePerc.Q1:=(self.FileSizePerc.Min+self.FileSizePerc.Median)/2;
        Self.FileSizePerc.Q3:=(self.FileSizePerc.Max+self.FileSizePerc.Median)/2;
        Self.FileSizePerc.Variance:=SimpleStats[2].var;
        Self.FileSizePerc.StDev:=SimpleStats[2].sd;
        Self.FileSizePerc.Plus2StDev:=Self.FileSizePerc.Mean+(2*Self.FileSizePerc.StDev);
        Self.FileSizePerc.Minus2StDev:=Self.FileSizePerc.Mean-(2*Self.FileSizePerc.StDev);
        self.FileSizePerc.NumLessThanQ1:=count(R(number=2 and value<Self.FileSizePerc.Q1));
        self.FileSizePerc.BtwnQ1AndQ3:=count(R(number=2 and value>=Self.FileSizePerc.Q1 and value<=Self.FileSizePerc.Q3));
        self.FileSizePerc.NumMoreThanQ3:=count(R(number=2 and value>Self.FileSizePerc.Q3));
        //Record Count Calculations
        //Real
        Self.NumberOfRecordsReal.Min:=SimpleStats[3].minval;
        Self.NumberOfRecordsReal.Mean:=SimpleStats[3].mean;
        Self.NumberOfRecordsReal.Max:=SimpleStats[3].maxval;
        Self.NumberOfRecordsReal.median:=MedianStats[3].Median;
        Self.NumberOfRecordsReal.Q1:=(self.NumberOfRecordsReal.Min+self.NumberOfRecordsReal.Median)/2;
        Self.NumberOfRecordsReal.Q3:=(self.NumberOfRecordsReal.Max+self.NumberOfRecordsReal.Median)/2;
        Self.NumberOfRecordsReal.Variance:=SimpleStats[3].var;
        Self.NumberOfRecordsReal.StDev:=SimpleStats[3].sd;
        Self.NumberOfRecordsReal.Plus2StDev:=Self.NumberOfRecordsReal.Mean+(2*Self.NumberOfRecordsReal.StDev);
        Self.NumberOfRecordsReal.Minus2StDev:=Self.NumberOfRecordsReal.Mean-(2*Self.NumberOfRecordsReal.StDev);
        self.NumberOfRecordsReal.NumLessThanQ1:=count(R(number=3 and value<Self.NumberOfRecordsReal.Q1));
        self.NumberOfRecordsReal.BtwnQ1AndQ3:=count(R(number=3 and value>=Self.NumberOfRecordsReal.Q1 and value<=Self.NumberOfRecordsReal.Q3));
        self.NumberOfRecordsReal.NumMoreThanQ3:=count(R(number=3 and value>Self.NumberOfRecordsReal.Q3));
        //Perc
        Self.NumberOfRecordsPerc.Min:=SimpleStats[4].minval;
        Self.NumberOfRecordsPerc.Mean:=SimpleStats[4].mean;
        Self.NumberOfRecordsPerc.Max:=SimpleStats[4].maxval;
        Self.NumberOfRecordsPerc.Median:=MedianStats[4].Median;
        Self.NumberOfRecordsPerc.Q1:=(self.NumberOfRecordsPerc.Min+self.NumberOfRecordsPerc.Median)/2;
        Self.NumberOfRecordsPerc.Q3:=(self.NumberOfRecordsPerc.Max+self.NumberOfRecordsPerc.Median)/2;
        Self.NumberOfRecordsPerc.Variance:=SimpleStats[4].var;
        Self.NumberOfRecordsPerc.StDev:=SimpleStats[4].sd;
        Self.NumberOfRecordsPerc.Plus2StDev:=Self.NumberOfRecordsPerc.Mean+(2*Self.NumberOfRecordsPerc.StDev);
        Self.NumberOfRecordsPerc.Minus2StDev:=Self.NumberOfRecordsPerc.Mean-(2*Self.NumberOfRecordsPerc.StDev);
        self.NumberOfRecordsPerc.NumLessThanQ1:=count(R(number=4 and value<Self.NumberOfRecordsPerc.Q1));
        self.NumberOfRecordsPerc.BtwnQ1AndQ3:=count(R(number=4 and value>=Self.NumberOfRecordsPerc.Q1 and value<=Self.NumberOfRecordsPerc.Q3));
        self.NumberOfRecordsPerc.NumMoreThanQ3:=count(R(number=4 and value>Self.NumberOfRecordsPerc.Q3));
        Self:=L;
    END;

 CalculateDelta:=rollup(GroupFile,GROUP,tCalculate(left,ROWS(left)));


PromoteSupers.Mac_SF_BuildProcess(CalculateDelta, History_Analysis.Filenames(pVersion).BaseStatistics, dsResult, 3,, True);

return dsResult;

end;