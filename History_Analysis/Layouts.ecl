export Layouts := Module

    Export Layout_Master_Build := Record
    String25 build_name;
    String25 frequency;
    String25 status;
    String25 package;
    String15 platform;
    String8  Scorecard;
    End;
    
    Export Layout_keysizehistory := Record
    String25  datasetname;  
    String10  build_version;
    String25  whenlive;
    String1   clusterflag;
    String1   updateflag;
    String60  superkey;
    String10  templatelogicalkey;
    Integer8  size;
    Integer8  recordcount;
    End;

    Export Layout_Orbit_Buildinstance := Record
    String10  select;
    Integer8  build_id;
    String25  build_name;
    String10  build_version;
    String15  build_status;
    String10  build_sub_status;
    String10  platform_build_status;
    String15  family;
    String15  issue_tracking;
    String20  date_created;
    String15  created_by;
    String20  date_updated;
    String15  master_build;
    End;

    Export BaseRec:= Record
    String25   datasetname;
    String10   prevbuild_version:= '';
    String10   build_version;
    String25   whenlive;
    String1    updateflag;
    String60   superkey;
    Integer8   previous_size:=0;
    Integer8   size;    
    Integer8   delta_size:=0;
    Decimal5_2 delta_size_perc:=0;
    Integer8   prevrecord_count:=0;
    Integer8   recordcount;
    Integer8   delta_count:=0;
    Decimal5_2 delta_count_perc:=0;
End;
    export StatisticsPoints:=RECORD
        Real       Min;
        Real       Q1;
        Real       Median;
        Real       Q3;
        Real       Max;
        Real       Mean;
        Real       Variance;
        Real       StDev;
        Real       Plus2StDev;
        Real       Minus2StDev;
        Unsigned   NumLessThanQ1;
        Unsigned   BtwnQ1AndQ3;
        Unsigned   NumMoreThanQ3;
    END;
    export StatisticsRec:=RECORD
        String25   datasetname;
        String60   superkey;
        String1    updateflag;
        unsigned   numberofdeltas;
        StatisticsPoints FileSizeReal;
        StatisticsPoints FileSizePerc;
        StatisticsPoints NumberOfRecordsReal;
        StatisticsPoints NumberOfRecordsPerc;
    END;

End;