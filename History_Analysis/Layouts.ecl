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
        String    datasetname;
        String10  buildversion;
        String25  whenQAlive;
        String25  whenProdLive;
        String1   clusterflag;
        String1   updateflag;
        String    superkey;
        String    templatelogicalkey;
        String    size;
        String    recordcount;
    End;

    Export layout_dopsservice := Record
        String    datasetname;
        String1   clusterflag;
        String25  whenqalive;
        string25  whenprodlive;
        String10  buildversion;
        String    superkey;
        String    logicalkey;
        Integer8  size;
        Integer8  recordcount;
        String1   updateflag;
        String    statuscode;
        String    statusdescription;
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
        // percent 
        Real       Min_1;   
        Real       Q1_2;
        Real       Median_3;
        Real       Q3_4;
        Real       Max_5;
        Real       Mean_6;
        Real       Variance_7;
        Real       StDev_8;
        Real       Plus2StDev_9;
        Real       Minus2StDev_10;
        Unsigned   NumLessThanQ1_11;
        Unsigned   BtwnQ1AndQ3_12;
        Unsigned   NumMoreThanQ3_12;
        // Record Count Calculatins
        // Real
        Real       Min_14;   
        Real       Q1_15;
        Real       Median_16;
        Real       Q3_17;
        Real       Max_18;
        Real       Mean_19;
        Real       Variance_20;
        Real       StDev_21;
        Real       Plus2StDev_22;
        Real       Minus2StDev_23;
        Unsigned   NumLessThanQ1_24;
        Unsigned   BtwnQ1AndQ3_25;
        Unsigned   NumMoreThanQ3_26;
        // Percent
        Real       Min_27;   
        Real       Q1_28;
        Real       Median_29;
        Real       Q3_30;
        Real       Max_31;
        Real       Mean_32;
        Real       Variance_33;
        Real       StDev_34;
        Real       Plus2StDev_35;
        Real       Minus2StDev_36;
        Unsigned   NumLessThanQ1_37;
        Unsigned   BtwnQ1AndQ3_38;
        Unsigned   NumMoreThanQ3_39;
    End;

End;