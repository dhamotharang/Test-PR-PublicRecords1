

Export History_Analysis := Module

    Shared Layout_Master_Build := Record
    String25 build_name;
    String25 frequency;
    String25 status;
    String25 package;
    String15 platform;
    String8  Scorecard;
    End;
    
    Shared Layout_keysizehistory := Record
    String25  datasetname;  
    String10  build_version;
    String25  whenlive;
    String1   clusterflag;
    String1   updateflag;
    String60  superkey;
    String10  templatelogicalkey;
    Unsigned8 size;
    Integer8  recordcount;
    End;

    Shared Layout_Orbit_Buildinstance := Record
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


    Export Master_Build_Frequence_Report := Dataset('~thor_data400::in::master_build_frequency::20200221::dops_extract01', Layout_Master_Build, CSV(Heading(1)));

    Export Keysizedhistory_report := Dataset('~thor_data400::in::dops_keysizedhistory::20200220::dops_extract02', Layout_keysizehistory, CSV(Heading(1)));

    Export Orbit_buildinstance  := Dataset('~thor_data400::in::orbit_buildinstance::20200220::dops_extract03', Layout_Orbit_Buildinstance, CSV(Heading(1)));

End;