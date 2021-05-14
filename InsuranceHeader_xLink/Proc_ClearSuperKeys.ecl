EXPORT Proc_ClearSuperKeys := PARALLEL( // parallel should be ok - all using different superkey
     Process_xIDL_Layouts().ClearKeySuperFile // main datafile
    ,Process_xIDL_Layouts().ClearKeyIDHistorySuperFile // ID History
    ,Process_xIDL_Layouts().ClearKeyChangeIDSuperFile // Change ID
    ,Process_xIDL_Layouts().ClearKey0SuperFile // datafile for attributefile
    ,Process_xIDL_Layouts().ClearKey1SuperFile // datafile for attributefile
    ,Keys(File_InsuranceHeader).Clear_SpecificitiesDebugKeyNameSuperFile// specificities_debug
    ,Key_InsuranceHeader_NAME().ClearKeySuperFile // linkpath
    ,Key_InsuranceHeader_ADDRESS().ClearKeySuperFile // linkpath
    ,Key_InsuranceHeader_SSN().ClearKeySuperFile // linkpath
    ,Key_InsuranceHeader_SSN4().ClearKeySuperFile // linkpath
    ,Key_InsuranceHeader_DOB().ClearKeySuperFile // linkpath
    ,Key_InsuranceHeader_DOBF().ClearKeySuperFile // linkpath
    ,Key_InsuranceHeader_ZIP_PR().ClearKeySuperFile // linkpath
    ,Key_InsuranceHeader_SRC_RID().ClearKeySuperFile // linkpath
    ,Key_InsuranceHeader_DLN().ClearKeySuperFile // linkpath
    ,Key_InsuranceHeader_PH().ClearKeySuperFile // linkpath
    ,Key_InsuranceHeader_LFZ().ClearKeySuperFile // linkpath
    ,Key_InsuranceHeader_RELATIVE().ClearKeySuperFile // linkpath
    ,Key_InsuranceHeader_VIN().ClearKeySuperFile // linkpath
);
