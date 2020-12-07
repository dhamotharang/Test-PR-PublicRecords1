Import dops, History_Analysis;

Export Layouts := Module
    Export layout_master_build := Record
        string25 build_name;
        string25 frequency;
        string25 status;
        string25 package;
        string15 platform;
        string8  Scorecard;
    End;

    Export layout_keysizedhistory := Record 
        string datasetname;
        string buildversion;
        string whenlive;
        string clusterflag;
        string updateflag;
        string superkey;
        string templatelogicalkey;
        string size;
        string recordcount;
    End;

    Export layout_dopsservice := Record
        string  datasetname;
        string  clusterflag;
        string  whenlive;
        string  buildversion;
        string  superkey;
        string  logicalkey;
        integer size;
        integer recordcount;
        string  updateflag;
        string  statuscode;
        string  statusdescription;
    END;

    Export layout_orbit_buildinstance := Record
        string10  select;
        Integer8  build_id;
        string25  build_name;
        string10  build_version;
        String15  build_status;
        string10  build_sub_status;
        string10  platform_build_status;
        string15  family;
        string15  issue_tracking;
        string20  date_created;
        string15  created_by;
        string20  date_updated;
        string15  master_build;
    End;

    Export baseRec:= Record
        string25   datasetname;
        string10   prevbuild_version:= '';
        string10   buildversion;
        string25   whenlive;
        string1    updateflag;
        string60   superkey;
        integer8   previous_size:=0;
        integer8   size;    
        integer8   delta_size:=0;
        decimal5_2 delta_size_perc:=0;
        integer8   prevrecord_count:=0;
        integer8   recordcount;
        integer8   delta_count:=0;
        decimal5_2 delta_count_perc:=0;
    End;
    Export statisticsPoints := Record
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

    Export statisticsPoints1 := RECORD
           // percent 
        real       Min_1;   
        real       Q1_2;
        real       Median_3;
        real       Q3_4;
        real       Max_5;
        real       Mean_6;
        real       Variance_7;
        real       StDev_8;
        real       Plus2StDev_9;
        real       Minus2StDev_10;
        unsigned   NumLessThanQ1_11;
        Unsigned   BtwnQ1AndQ3_12;
        Unsigned   NumMoreThanQ3_12;
    END;

      Export statisticsPoints2 := RECORD
           // Record Count Calculatins
           // Real
        real       Min_14;   
        real       Q1_15;
        real       Median_16;
        real       Q3_17;
        real       Max_18;
        real       Mean_19;
        real       Variance_20;
        real       StDev_21;
        real       Plus2StDev_22;
        real       Minus2StDev_23;
        unsigned   NumLessThanQ1_24;
        Unsigned   BtwnQ1AndQ3_25;
        Unsigned   NumMoreThanQ3_26;
    END;

     Export statisticsPoints3 := RECORD
           // Percent
        real       Min_27;   
        real       Q1_28;
        real       Median_29;
        real       Q3_30;
        real       Max_31;
        real       Mean_32;
        real       Variance_33;
        real       StDev_34;
        real       Plus2StDev_35;
        real       Minus2StDev_36;
        unsigned   NumLessThanQ1_37;
        Unsigned   BtwnQ1AndQ3_38;
        Unsigned   NumMoreThanQ3_39;
    END;

    Export statisticsRec:=RECORD
        string25   datasetname;
        string60   superkey;
        string1    updateflag;
        unsigned   numberofdeltas;
        statisticsPoints  fileSizeReal;
        statisticsPoints1 fileSizePerc;
        statisticsPoints2 numberOfRecordsReal;
        statisticsPoints3 numberOfRecordsPerc;
    END;

End;