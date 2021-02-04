import History_Analysis,ML_Core, PromoteSupers, ut;

export MLCoreCalculateStatistics(dataset(History_Analysis.Layouts.BaseRecprod) loadDeltas ):=function

WithRecID:=RECORD
    unsigned recid:=0;
    History_Analysis.Layouts.BaseRecProd;
END;

AddRecID:=project(loaddeltas,transform(withRecID,self:=left;));

WithRecID tAssignRecID(WithRecID L,WithRecID R, INTEGER C):=TRANSFORM
    Self.recid:=C;
    SELF := R;
END;

AssignRecID:=iterate(AddRecID,tAssignRecID(left,right,counter));
ML_Core.ToField(AssignRecID,MLReady,recid,,,'delta_size,delta_size_perc,delta_count,delta_count_perc');

CombinedRec:=RECORD
    String25   datasetname;
    String60   superkey;
    String1    updateflag;
    ML_Core.Types.NumericField;
END;

CombinedRec tCombine(WithRecID L, ML_Core.Types.NumericField R):=TRANSFORM
    Self.datasetname:=trim(L.datasetname, right, whitespace );
    Self.superkey:=trim(ut.fn_RemoveSpecialChars(L.superkey), right, whitespace );
    Self.updateflag:=trim(L.updateflag, right, whitespace );
    Self.wi:=R.wi;
    Self.id:=R.id;
    Self.number:=R.number;
    Self.value:=R.value;
END;

CombineMLWithData:=join(AssignRecID,MLReady,left.recid=right.id,tcombine(left,right));

 SortFile:=sort(CombineMLWithData,datasetname,superkey,updateflag);

    GroupFile:=group(SortFile,datasetname,superkey,updateflag);

History_Analysis.Layouts.statisticsRec tCalculate(CombinedRec L, dataset(CombinedRec) R):=TRANSFORM
        ReduceToML:=project(R,transform(ML_Core.Types.NumericField,Self:=left;));
        SimpleStats:=sort(ML_Core.FieldAggregates(ReduceToML).simple,number);
        MedianStats:=sort(ML_Core.FieldAggregates(ReduceToML).medians,number);
        SortForQsDS:=sort(ReduceToML(number=1),value);
        SortForQsDSP:=sort(ReduceToML(number=2),value);
        SortForQsDC:=sort(ReduceToML(number=3),value);
        SortForQsDCP:=sort(ReduceToML(number=4),value);
        NumRecs:=count(SortForQsDS);
        BelowMedian:=if(NumRecs%2<>0,truncate(NumRecs/2),(NumRecs/2)-1);
        AboveMedian:=if(NumRecs%2<>0,truncate(NumRecs/2)+2,(NumRecs/2)+1);

        Q1SetForDS:=choosen(SortForQsDS,BelowMedian);
        Q3SetForDS:=choosen(SortForQsDS,BelowMedian,AboveMedian);
        Q1SetForDSP:=choosen(SortForQsDSP,BelowMedian);
        Q3SetForDSP:=choosen(SortForQsDSP,BelowMedian,AboveMedian);
        Q1SetForDC:=choosen(SortForQsDC,BelowMedian);
        Q3SetForDC:=choosen(SortForQsDC,BelowMedian,AboveMedian);
        Q1SetForDCP:=choosen(SortForQsDCP,BelowMedian);
        Q3SetForDCP:=choosen(SortForQsDCP,BelowMedian,AboveMedian);

        CalcQ1DS:=ML_Core.FieldAggregates(Q1SetForDS).medians;
        CalcQ3DS:=ML_Core.FieldAggregates(Q3SetForDS).medians;
        CalcQ1DSP:=ML_Core.FieldAggregates(Q1SetForDSP).medians;
        CalcQ3DSP:=ML_Core.FieldAggregates(Q3SetForDSP).medians;
        CalcQ1DC:=ML_Core.FieldAggregates(Q1SetForDC).medians;
        CalcQ3DC:=ML_Core.FieldAggregates(Q3SetForDC).medians;
        CalcQ1DCP:=ML_Core.FieldAggregates(Q1SetForDCP).medians;
        CalcQ3DCP:=ML_Core.FieldAggregates(Q3SetForDCP).medians;
				self.numberofdeltas:=count(SortForQsDS);
        
        Self.Min_FilesizeReal:=SimpleStats[1].minval;
        Self.Mean_FilesizeReal:=SimpleStats[1].mean;
        Self.Max_FilesizeReal:=SimpleStats[1].maxval;
        Self.Median_FilesizeReal:=MedianStats[1].median;
        // Self.Q1_FilesizeReal:=(self.Min_FilesizeReal+self.Median_FilesizeReal)/2;
        // Self.Q3_FilesizeReal:=(self.Max_FilesizeReal+self.Median_FilesizeReal)/2;
        Self.Q1_FilesizeReal:=CalcQ1DS[1].median;
        Self.Q3_FilesizeReal:=CalcQ3DS[1].median;
        Self.Variance_FilesizeReal:=SimpleStats[1].var;
        Self.StDev_FilesizeReal:=SimpleStats[1].sd;
        Self.Plus2StDev_FilesizeReal:=Self.Mean_FilesizeReal+(2*Self.StDev_FilesizeReal);
        Self.Minus2StDev_FilesizeReal:=Self.Mean_FilesizeReal-(2*Self.StDev_FilesizeReal);
        self.NumLessThanQ1_FilesizeReal:=count(R(number=1 and value<Self.Q1_FilesizeReal));
        self.BtwnQ1AndQ3_FilesizeReal:=count(R(number=1 and value>=Self.Q1_FilesizeReal and value<=Self.Q3_FilesizeReal));
        self.NumMoreThanQ3_FilesizeReal:=count(R(number=1 and value>Self.Q3_FilesizeReal));
        //Percent
        Self.Min_FilesizePercent:=SimpleStats[2].minval;
        Self.Mean_FilesizePercent:=SimpleStats[2].mean;
        Self.Max_FilesizePercent:=SimpleStats[2].maxval;
        self.Median_FilesizePercent:=MedianStats[2].Median;
        // Self.Q1_FilesizePercent:=(self.Min_FilesizePercent+self.Median_FilesizePercent)/2;
        // Self.Q3_FilesizePercent:=(self.Max_FilesizePercent+self.Median_FilesizePercent)/2;
        Self.Q1_FilesizePercent:=CalcQ1DSP[1].median;
        Self.Q3_FilesizePercent:=CalcQ3DSP[1].median;
        Self.Variance_FilesizePercent:=SimpleStats[2].var;
        Self.StDev_FilesizePercent:=SimpleStats[2].sd;
        Self.Plus2StDev_FilesizePercent:=Self.Mean_FilesizePercent+(2*Self.StDev_FilesizePercent);
        Self.Minus2StDev_FilesizePercent:=Self.Mean_FilesizePercent-(2*Self.StDev_FilesizePercent);
        self.NumLessThanQ1_FilesizePercent:=count(R(number=2 and value<Self.Q1_FilesizePercent));
        self.BtwnQ1AndQ3_FilesizePercent:=count(R(number=2 and value>=Self.Q1_FilesizePercent and value<=Self.Q3_FilesizePercent));
        self.NumMoreThanQ3_FilesizePercent:=count(R(number=2 and value>Self.Q3_FilesizePercent));
        //Record Count Calculations
        //Real
        Self.Min_RecordCountReal:=SimpleStats[3].minval;
        Self.Mean_RecordCountReal:=SimpleStats[3].mean;
        Self.Max_RecordCountReal:=SimpleStats[3].maxval;
        Self.median_RecordCountReal:=MedianStats[3].Median;
        // Self.Q1_RecordCountReal:=(self.Min_RecordCountReal+self.Median_RecordCountReal)/2;
        // Self.Q3_RecordCountReal:=(self.Max_RecordCountReal+self.Median_RecordCountReal)/2;
        Self.Q1_RecordCountReal:=CalcQ1DC[1].median;
        Self.Q3_RecordCountReal:=CalcQ3DC[1].median;
        Self.Variance_RecordCountReal:=SimpleStats[3].var;
        Self.StDev_RecordCountReal:=SimpleStats[3].sd;
        Self.Plus2StDev_RecordCountReal:=Self.Mean_RecordCountReal+(2*Self.StDev_RecordCountReal);
        Self.Minus2StDev_RecordCountReal:=Self.Mean_RecordCountReal-(2*Self.StDev_RecordCountReal);
        self.NumLessThanQ1_RecordCountReal:=count(R(number=3 and value<Self.Q1_RecordCountReal));
        self.BtwnQ1AndQ3_RecordCountReal:=count(R(number=3 and value>=Self.Q1_RecordCountReal and value<=Self.Q3_RecordCountReal));
        self.NumMoreThanQ3_RecordCountReal:=count(R(number=3 and value>Self.Q3_RecordCountReal));
        //Perc
        Self.Min_RecordCountPercent:=SimpleStats[4].minval;
        Self.Mean_RecordCountPercent:=SimpleStats[4].mean;
        Self.Max_RecordCountPercent:=SimpleStats[4].maxval;
        Self.median_RecordCountPercent:=MedianStats[4].Median;
        // Self.Q1_RecordCountPercent:=(self.Min_RecordCountPercent+self.Median_RecordCountPercent)/2;
        // Self.Q3_RecordCountPercent:=(self.Max_RecordCountPercent+self.Median_RecordCountPercent)/2;
        Self.Q1_RecordCountPercent:=CalcQ1DCP[1].median;
        Self.Q3_RecordCountPercent:=CalcQ3DCP[1].median;
        Self.Variance_RecordCountPercent:=SimpleStats[4].var;
        Self.StDev_RecordCountPercent:=SimpleStats[4].sd;
        Self.Plus2StDev_RecordCountPercent:=Self.Mean_RecordCountPercent+(2*Self.StDev_RecordCountPercent);
        Self.Minus2StDev_RecordCountPercent:=Self.Mean_RecordCountPercent-(2*Self.StDev_RecordCountPercent);
				Self.MinThreshold:=if(truncate(Self.median_RecordCountPercent-(2*(Self.median_RecordCountPercent-Self.Q1_RecordCountPercent)))>=0,-1,truncate(Self.median_RecordCountPercent-(2*(Self.median_RecordCountPercent-Self.Q1_RecordCountPercent))));
        Self.MaxThreshold:=roundup(Self.median_RecordCountPercent+(2*(Self.Q3_RecordCountPercent-Self.median_RecordCountPercent)));
        self.NumLessThanMinThreshold:=count(R(number=4 and value<Self.MinThreshold));
        self.BtwnMinThresholdAndMaxThreshold:=count(R(number=4 and value>=Self.MinThreshold and value<=Self.MaxThreshold));
        self.NumMoreThanMaxThreshold:=count(R(number=4 and value>Self.MaxThreshold));
        Self:=L;
    END;

 CalculateDelta:=rollup(GroupFile,GROUP,tCalculate(left,ROWS(left)));
return CalculateDelta;

end;