

Export History_Analysis := Module

    Export Layout_Master_Build := Record
    String25 build_name;
    String25 frequency;
    String25 status;
    String25 package;
    String15 platform;
    String8  Scorecard;
    End;
    
    Export Layout_keysizehistory := Record
    STRING field1;
    STRING field2;
    STRING field3;
    STRING field4;
    STRING field5;
    STRING field6;
    STRING field7;
    STRING field8;
    STRING field9;
    End;

    Export Layout_Orbit_Buildinstance := Record
    String10  select;
    Integer8  build_id;
    String25  build_name;
    Qstring10 build_version;
    String15  build_status;
    String10  build_sub_status;
    Qstring10 platform_build_status;
    String15  family;
    Qstring15 issue_tracking;
    STRING    field9;
    STRING    field10;
    STRING    field11;
    STRING    field12;
    STRING    field13;
    End;



    Export Master_Build_Frequence_Report := Dataset('~thor_data400::in::orbit_buildinstance::20200220::dops_extract03', Layout_Master_Build, CSV);

    Export Keysizedhistory_report := Dataset('~thor_data400::in::dops_keysizedhistory::20200220::dops_extract02', Layout_keysizehistory, Thor);

    Export Orbit_buildinstance  := Dataset('~thor_data400::in::orbit_buildinstance::20200220::dops_extract03', Layout_Orbit_Buildinstance, CSV);

End;