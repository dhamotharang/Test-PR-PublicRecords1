import History_Analysis,ML_Core, PromoteSupers;

export MLCoreCalculateStatistics(dataset(History_Analysis.Layouts.BaseRec) loadDeltas ):=function

WithRecID:=RECORD
    unsigned recid:=0;
    History_Analysis.Layouts.BaseRec;
END;

AddRecID:=project(loaddeltas,transform(withRecID,self:=left;));

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
        Self.FileSizePerc.Min_1:=SimpleStats[2].minval;
        Self.FileSizePerc.Mean_6:=SimpleStats[2].mean;
        Self.FileSizePerc.Max_5:=SimpleStats[2].maxval;
        self.FileSizePerc.Median_3:=MedianStats[2].Median;
        Self.FileSizePerc.Q1_2:=(self.FileSizePerc.Min_1+self.FileSizePerc.Median_3)/2;
        Self.FileSizePerc.Q3_4:=(self.FileSizePerc.Max_5+self.FileSizePerc.Median_3)/2;
        Self.FileSizePerc.Variance_7:=SimpleStats[2].var;
        Self.FileSizePerc.StDev_8:=SimpleStats[2].sd;
        Self.FileSizePerc.Plus2StDev_9:=Self.FileSizePerc.Mean_6+(2*Self.FileSizePerc.StDev_8);
        Self.FileSizePerc.Minus2StDev_10:=Self.FileSizePerc.Mean_6-(2*Self.FileSizePerc.StDev_8);
        self.FileSizePerc.NumLessThanQ1_11:=count(R(number=2 and value<Self.FileSizePerc.Q1_2));
        self.FileSizePerc.BtwnQ1AndQ3_12:=count(R(number=2 and value>=Self.FileSizePerc.Q1_2 and value<=Self.FileSizePerc.Q3_4));
        self.FileSizePerc.NumMoreThanQ3_12:=count(R(number=2 and value>Self.FileSizePerc.Q3_4));
        //Record Count Calculations
        //Real
        Self.NumberOfRecordsReal.Min_14:=SimpleStats[3].minval;
        Self.NumberOfRecordsReal.Mean_19:=SimpleStats[3].mean;
        Self.NumberOfRecordsReal.Max_18:=SimpleStats[3].maxval;
        Self.NumberOfRecordsReal.median_16:=MedianStats[3].Median;
        Self.NumberOfRecordsReal.Q1_15:=(self.NumberOfRecordsReal.Min_14+self.NumberOfRecordsReal.Median_16)/2;
        Self.NumberOfRecordsReal.Q3_17:=(self.NumberOfRecordsReal.Max_18+self.NumberOfRecordsReal.Median_16)/2;
        Self.NumberOfRecordsReal.Variance_20:=SimpleStats[3].var;
        Self.NumberOfRecordsReal.StDev_21:=SimpleStats[3].sd;
        Self.NumberOfRecordsReal.Plus2StDev_22:=Self.NumberOfRecordsReal.Mean_19+(2*Self.NumberOfRecordsReal.StDev_21);
        Self.NumberOfRecordsReal.Minus2StDev_23:=Self.NumberOfRecordsReal.Mean_19-(2*Self.NumberOfRecordsReal.StDev_21);
        self.NumberOfRecordsReal.NumLessThanQ1_24:=count(R(number=3 and value<Self.NumberOfRecordsReal.Q1_15));
        self.NumberOfRecordsReal.BtwnQ1AndQ3_25:=count(R(number=3 and value>=Self.NumberOfRecordsReal.Q1_15 and value<=Self.NumberOfRecordsReal.Q3_17));
        self.NumberOfRecordsReal.NumMoreThanQ3_26:=count(R(number=3 and value>Self.NumberOfRecordsReal.Q3_17));
        //Perc
        Self.NumberOfRecordsPerc.Min_27:=SimpleStats[4].minval;
        Self.NumberOfRecordsPerc.Mean_32:=SimpleStats[4].mean;
        Self.NumberOfRecordsPerc.Max_31:=SimpleStats[4].maxval;
        Self.NumberOfRecordsPerc.Median_29:=MedianStats[4].Median;
        Self.NumberOfRecordsPerc.Q1_28:=(self.NumberOfRecordsPerc.Min_27+self.NumberOfRecordsPerc.Median_29)/2;
        Self.NumberOfRecordsPerc.Q3_30:=(self.NumberOfRecordsPerc.Max_31+self.NumberOfRecordsPerc.Median_29)/2;
        Self.NumberOfRecordsPerc.Variance_33:=SimpleStats[4].var;
        Self.NumberOfRecordsPerc.StDev_34:=SimpleStats[4].sd;
        Self.NumberOfRecordsPerc.Plus2StDev_35:=Self.NumberOfRecordsPerc.Mean_32+(2*Self.NumberOfRecordsPerc.StDev_34);
        Self.NumberOfRecordsPerc.Minus2StDev_36:=Self.NumberOfRecordsPerc.Mean_32-(2*Self.NumberOfRecordsPerc.StDev_34);
        self.NumberOfRecordsPerc.NumLessThanQ1_37:=count(R(number=4 and value<Self.NumberOfRecordsPerc.Q1_28));
        self.NumberOfRecordsPerc.BtwnQ1AndQ3_38:=count(R(number=4 and value>=Self.NumberOfRecordsPerc.Q1_28 and value<=Self.NumberOfRecordsPerc.Q3_30));
        self.NumberOfRecordsPerc.NumMoreThanQ3_39:=count(R(number=4 and value>Self.NumberOfRecordsPerc.Q3_30));
        Self:=L;
    END;

 CalculateDelta:=rollup(GroupFile,GROUP,tCalculate(left,ROWS(left)));

return CalculateDelta;

end;