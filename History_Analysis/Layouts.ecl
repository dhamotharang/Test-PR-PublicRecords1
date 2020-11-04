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
    Export statisticsRec:=RECORD
        string25   datasetname;
        string60   superkey;
        string1    updateflag;
        unsigned   numberofdeltas;
        statisticsPoints fileSizeReal;
        statisticsPoints fileSizePerc;
        statisticsPoints numberOfRecordsReal;
        statisticsPoints numberOfRecordsPerc;
    END;

End;