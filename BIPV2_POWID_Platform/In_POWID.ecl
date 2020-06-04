IMPORT BIPV2_Files;
EXPORT In_POWID := BIPV2_Files.files_powid('BIPV2_POWID_Platform').DS_BUILDING;
//EXPORT In_POWID := DATASET('~dhw::temp::powid_base_file',BIPV2_POWID_Platform.Layout_POWID,THOR);
// EXPORT In_POWID := DATASET('~temp::powid::BIPV2_POWID_Platform::it1',BIPV2_POWID_Platform.Layout_POWID,THOR);
// EXPORT In_POWID := DATASET('~temp::powid::BIPV2_POWID_Platform::it2',BIPV2_POWID_Platform.Layout_POWID,THOR);
