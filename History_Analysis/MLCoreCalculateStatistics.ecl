import History_Analysis,ML_Core, PromoteSupers, ut;

export MLCoreCalculateStatistics(dataset(History_Analysis.Layouts.BaseRecprod) loadDeltas ):=function

WithRecID:=RECORD
    unsigned recid:=0;
    History_Analysis.Layouts.BaseRecprod;
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
        self.numberofdeltas:=count(R);
        
        Self.Min:=SimpleStats[1].minval;
        Self.Mean:=SimpleStats[1].mean;
        Self.Max:=SimpleStats[1].maxval;
        Self.Median:=MedianStats[1].median;
        Self.Q1:=(self.Min+self.Median)/2;
        Self.Q3:=(self.Max+self.Median)/2;
        Self.Variance:=SimpleStats[1].var;
        Self.StDev:=SimpleStats[1].sd;
        Self.Plus2StDev:=Self.Mean+(2*Self.StDev);
        Self.Minus2StDev:=Self.Mean-(2*Self.StDev);
        self.NumLessThanQ1:=count(R(number=1 and value<Self.Q1));
        self.BtwnQ1AndQ3:=count(R(number=1 and value>=Self.Q1 and value<=Self.Q3));
        self.NumMoreThanQ3:=count(R(number=1 and value>Self.Q3));
        //Percent
        Self.Min_1:=SimpleStats[2].minval;
        Self.Mean_6:=SimpleStats[2].mean;
        Self.Max_5:=SimpleStats[2].maxval;
        self.Median_3:=MedianStats[2].Median;
        Self.Q1_2:=(self.Min_1+self.Median_3)/2;
        Self.Q3_4:=(self.Max_5+self.Median_3)/2;
        Self.Variance_7:=SimpleStats[2].var;
        Self.StDev_8:=SimpleStats[2].sd;
        Self.Plus2StDev_9:=Self.Mean_6+(2*Self.StDev_8);
        Self.Minus2StDev_10:=Self.Mean_6-(2*Self.StDev_8);
        self.NumLessThanQ1_11:=count(R(number=2 and value<Self.Q1_2));
        self.BtwnQ1AndQ3_12:=count(R(number=2 and value>=Self.Q1_2 and value<=Self.Q3_4));
        self.NumMoreThanQ3_12:=count(R(number=2 and value>Self.Q3_4));
        //Record Count Calculations
        //Real
        Self.Min_14:=SimpleStats[3].minval;
        Self.Mean_19:=SimpleStats[3].mean;
        Self.Max_18:=SimpleStats[3].maxval;
        Self.median_16:=MedianStats[3].Median;
        Self.Q1_15:=(self.Min_14+self.Median_16)/2;
        Self.Q3_17:=(self.Max_18+self.Median_16)/2;
        Self.Variance_20:=SimpleStats[3].var;
        Self.StDev_21:=SimpleStats[3].sd;
        Self.Plus2StDev_22:=Self.Mean_19+(2*Self.StDev_21);
        Self.Minus2StDev_23:=Self.Mean_19-(2*Self.StDev_21);
        self.NumLessThanQ1_24:=count(R(number=3 and value<Self.Q1_15));
        self.BtwnQ1AndQ3_25:=count(R(number=3 and value>=Self.Q1_15 and value<=Self.Q3_17));
        self.NumMoreThanQ3_26:=count(R(number=3 and value>Self.Q3_17));
        //Perc
        Self.Min_27:=SimpleStats[4].minval;
        Self.Mean_32:=SimpleStats[4].mean;
        Self.Max_31:=SimpleStats[4].maxval;
        Self.Median_29:=MedianStats[4].Median;
        Self.Q1_28:=(self.Min_27+self.Median_29)/2;
        Self.Q3_30:=(self.Max_31+self.Median_29)/2;
        Self.Variance_33:=SimpleStats[4].var;
        Self.StDev_34:=SimpleStats[4].sd;
        Self.Plus2StDev_35:=Self.Mean_32+(2*Self.StDev_34);
        Self.Minus2StDev_36:=Self.Mean_32-(2*Self.StDev_34);
        self.NumLessThanQ1_37:=count(R(number=4 and value<Self.Q1_28));
        self.BtwnQ1AndQ3_38:=count(R(number=4 and value>=Self.Q1_28 and value<=Self.Q3_30));
        self.NumMoreThanQ3_39:=count(R(number=4 and value>Self.Q3_30));
        Self:=L;
    END;

 CalculateDelta:=rollup(GroupFile,GROUP,tCalculate(left,ROWS(left)));

return CalculateDelta;

end;