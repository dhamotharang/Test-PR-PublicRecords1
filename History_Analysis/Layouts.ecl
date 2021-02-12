Import dops, History_Analysis;

Export Layouts := Module
    Export layout_master_build := Record
        String25 build_name;
        String25 frequency;
        String25 status;
        String25 package;
        String15 platform;
        String8  Scorecard;
    End;

//datasetname,buildversion,whenqalive,whenprodlive,clusterflag,updateflag,superkey,templatelogicalkey,size,recordcoun
    Export layout_keysizedhistory := Record 
        String   datasetname;
        String10 buildversion;
        String25 whenQAlive;
        String25 whenProdLive;
        String1  clusterflag;
        String1  updateflag;
        String   superkey;
        String   templatelogicalkey;
        String   size;
        String   recordcount;
    End;

    Export layout_dopsservice := Record
        String   datasetname;
        String1  clusterflag;
        String25 whenqalive;
        string25 whenprodlive;
        String10 buildversion;
        String   superkey;
        String   logicalkey;
        Integer8 size;
        Integer8 recordcount;
        String1  updateflag;
        String   statuscode;
        String   statusdescription;
    END;

    Export layout_orbit_buildinstance := Record
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
    Export baseRecQA:= Record
        String     datasetname;
        String10   prevbuild_version:= '';
        String10   buildversion;
        String25   whenqalive;
        String1    updateflag;
        String     superkey;
        Integer8   previous_size:=0;
        Integer8   size;    
        Integer8   delta_size:=0;
        decimal5_2 delta_size_perc:=0;
        Integer8   prevrecord_count:=0;
        Integer8   recordcount;
        Integer8   delta_count:=0;
        Decimal5_2 delta_count_perc:=0;
    End;

    Export baseRecProd:= Record
        String     datasetname;
        String10   prevbuild_version:= '';
        String10   buildversion;
        String25   whenprodlive;
        String1    updateflag;
        String     superkey;
        Integer8   previous_size:=0;
        Integer8   size;    
        Integer8   delta_size:=0;
        decimal5_2 delta_size_perc:=0;
        Integer8   prevrecord_count:=0;
        Integer8   recordcount;
        Integer8   delta_count:=0;
        Decimal5_2 delta_count_perc:=0;
    End;

    Export statisticsRec := Record  
        String     datasetname;
        String     superkey;
        String1    updateflag;
        Unsigned   numberofdeltas;
        Real       Min_FilesizeReal;//Min
        Real       Q1_FilesizeReal;//Q1
        Real       Median_FilesizeReal;//Median
        Real       Q3_FilesizeReal;//Q3
        Real       Max_FilesizeReal;//Max
        Real       Mean_FilesizeReal;//Mean
        Real       Variance_FilesizeReal;//Variance
        Real       StDev_FilesizeReal;//StDev
        Real       Plus2StDev_FilesizeReal;//Plus2StDev
        Real       Minus2StDev_FilesizeReal;//Minus2StDev
        Unsigned   NumLessThanQ1_FilesizeReal;//NumLessThanQ1
        Unsigned   BtwnQ1AndQ3_FilesizeReal;//BtwnQ1AndQ3
        Unsigned   NumMoreThanQ3_FilesizeReal;//NumMoreThanQ3
        // percent 
        Real       Min_FilesizePercent;//Min_1
        Real       Q1_FilesizePercent;//Q1_2
        Real       Median_FilesizePercent;//Median_3
        Real       Q3_FilesizePercent;//Q3_4
        Real       Max_FilesizePercent;//Max_5
        Real       Mean_FilesizePercent;//Mean_6
        Real       Variance_FilesizePercent;//Variance_7
        Real       StDev_FilesizePercent;//StDev_8
        Real       Plus2StDev_FilesizePercent;//Plus2StDev_9
        Real       Minus2StDev_FilesizePercent;//Minus2StDev_10
        Real       MinThresholdSize;//New
        Real       MaxThresholdSize;//New
        Unsigned   NumLessThanMinThresholdSize;//NumLessThanQ1_11
        Unsigned   BtwnThresholdSize;//BtwnQ1AndQ3_12
        Unsigned   NumMoreThanMaxThresholdSize;//NumMoreThanQ3_13
        // Record Count Calculations
        // Real
        Real       Min_RecordCountReal;//Min_14
        Real       Q1_RecordCountReal;//Q1_15
        Real       Median_RecordCountReal;//Median_16
        Real       Q3_RecordCountReal;//Q3_17
        Real       Max_RecordCountReal;//Max_18
        Real       Mean_RecordCountReal;//Mean_19
        Real       Variance_RecordCountReal;//Variance_20
        Real       StDev_RecordCountReal;//StDev_21
        Real       Plus2StDev_RecordCountReal;//Plus2StDev_22
        Real       Minus2StDev_RecordCountReal;//Minus2StDev_23
        Unsigned   NumLessThanQ1_RecordCountReal;//NumLessThanQ1_24
        Unsigned   BtwnQ1AndQ3_RecordCountReal;//BtwnQ1AndQ3_25
        Unsigned   NumMoreThanQ3_RecordCountReal;//NumMoreThanQ3_26
        // Percent
        Real       Min_RecordCountPercent;//Min_27
        Real       Q1_RecordCountPercent;//Q1_28
        Real       Median_RecordCountPercent;//Median_29
        Real       Q3_RecordCountPercent;//Q3_30
        Real       Max_RecordCountPercent;//Max_31
        Real       Mean_RecordCountPercent;//Mean_32
        Real       Variance_RecordCountPercent;//Variance_33
        Real       StDev_RecordCountPercent;//StDev_34
        Real       Plus2StDev_RecordCountPercent;//Plus2StDev_35
        Real       Minus2StDev_RecordCountPercent;//Minus2StDev_36
        Real       MinThresholdCount;//New
        Real       MaxThresholdCount;//New
        Unsigned   NumLessThanMinThresholdCount;//NumLessThanQ1_37
        Unsigned   BtwnThresholdCount;//BtwnQ1AndQ3_38
        Unsigned   NumMoreThanMaxThresholdCount;//NumMoreThanQ3_39
    End;

End;